#include "stdafx.h"
#include "../../common/stl.h"
#include "../../common/JsonTable.h"
#include "sql_data.h"
#include "group_text_parse_tree.h"

CGroupTextParseTreeLoader::CGroupTextParseTreeLoader()
	: m_pRootGroupNode(NULL), m_dwcurLineIndex(0), m_bJson(false)
{
}

CGroupTextParseTreeLoader::~CGroupTextParseTreeLoader()
{
	if (NULL != m_pRootGroupNode)
		delete m_pRootGroupNode;
}

const char * CGroupTextParseTreeLoader::GetFileName()
{
	return m_strFileName.c_str();
}

bool CGroupTextParseTreeLoader::Load(const char * c_szFileName)
{
	m_strFileName = c_szFileName;

	m_dwcurLineIndex = 0;

	const std::string jsonPath = jsontable::JsonPathFor(c_szFileName);
	m_bJson = false;

	const std::string srcName = sqldata::SrcFromPath(c_szFileName);
	if (sqldata::LoadRows(srcName.c_str(), m_jsonRows))
	{
		m_bJson = true;
	}
	else if (!jsonPath.empty() && jsontable::FileExists(jsonPath.c_str()))
	{
		if (!jsontable::LoadRows(jsonPath.c_str(), m_jsonRows))
			return false;
		m_bJson = true;
	}
	else
	{
		FILE* fp = fopen(c_szFileName, "rb");

		if (NULL == fp)
			return false;

		fseek(fp, 0L, SEEK_END);
		const size_t fileSize = ftell(fp);
		fseek(fp, 0, SEEK_SET);

		char * pData = M2_NEW char[fileSize];
		fread(pData, fileSize, 1, fp);
		fclose(fp);

		m_fileLoader.Bind(fileSize, pData);
		M2_DELETE_ARRAY(pData);
	}

	if (NULL != m_pRootGroupNode)
	{
		delete m_pRootGroupNode;
	}

	m_pRootGroupNode = new CGroupNode();
	if (!LoadGroup(m_pRootGroupNode))
	{
		delete m_pRootGroupNode;
		return false;
	}
	return true;
}

bool CGroupTextParseTreeLoader::LoadGroup(CGroupNode * pGroupNode)
{
	TTokenVector stTokenVector;
	const DWORD dwLineCount = m_bJson ? (DWORD)m_jsonRows.size() : m_fileLoader.GetLineCount();
	for (; m_dwcurLineIndex < dwLineCount; ++m_dwcurLineIndex)
	{
		if (m_bJson)
		{
			stTokenVector.assign(m_jsonRows[m_dwcurLineIndex].begin(), m_jsonRows[m_dwcurLineIndex].end());
			if (stTokenVector.empty())
				continue;
		}
		else if (!m_fileLoader.SplitLine(m_dwcurLineIndex, &stTokenVector))
			continue;

		stl_lowers(stTokenVector[0]);

		if ('{' == stTokenVector[0][0])
			continue;

		if ('}' == stTokenVector[0][0])
			break;

		// Group
		if (0 == stTokenVector[0].compare("group"))
		{
			if (2 != stTokenVector.size())
			{
				sys_err("Geçersiz grup sözdizimi token sayısı: %u != 2 (İSİMDE BOŞLUK OLMAZ)", stTokenVector.size());
				for (unsigned int i = 0; i < stTokenVector.size(); ++i)
					sys_err("  %u %s", i, stTokenVector[i].c_str());
				exit(1);
				continue;
			}

			CGroupNode * pNewNode = new CGroupNode();

			pNewNode->strGroupName = stTokenVector[1];
			stl_lowers(pNewNode->strGroupName);

			pGroupNode->SetChildNode(pNewNode->strGroupName.c_str(), pNewNode);

			++m_dwcurLineIndex;

			LoadGroup(pNewNode);
		}
		// Column Names
		else if (0 == stTokenVector[0].compare("#--#"))
		{
			for (TTokenVector::size_type i = 1; i < stTokenVector.size(); i++)
			{
				stl_lowers(stTokenVector[i]);
				pGroupNode->m_map_columnNameToIndex.emplace(stTokenVector[i], i - 1);
			}
		}
		else
		{
			std::string key = stTokenVector[0];

			if (1 == stTokenVector.size())
			{
				sys_err("CGroupTextParseTreeLoader::LoadGroup : bir değer olmalı (dosya: %s satır: %d anahtar: %s)",
						m_strFileName.c_str(),
						m_dwcurLineIndex,
						key.c_str());
				break;
			}

			stTokenVector.erase(stTokenVector.begin());
			pGroupNode->m_map_rows.emplace(key, CGroupNode::CGroupNodeRow(pGroupNode, stTokenVector));
		}
	}

	return true;
}

CGroupNode* CGroupTextParseTreeLoader::GetGroup(const char * c_szGroupName)
{
	if (NULL == m_pRootGroupNode)
		return NULL;
	return m_pRootGroupNode->GetChildNode(c_szGroupName);
}

CGroupNode::CGroupNode()
{
}

CGroupNode::~CGroupNode()
{
	for (TMapGroup::iterator it = m_mapChildNodes.begin(); it != m_mapChildNodes.end(); it++)
	{
		delete it->second;
	}
}

DWORD CGroupNode::GetChildNodeCount()
{
	return m_mapChildNodes.size();
}

bool CGroupNode::SetChildNode(const char * c_szKey, CGroupNode* pChildGroup)
{
	if (NULL == pChildGroup)
	{
		m_mapChildNodes.erase(c_szKey);
		return true;
	}
	TMapGroup::iterator it = m_mapChildNodes.find(c_szKey);
	if (it != m_mapChildNodes.end())
		return false;

	m_mapChildNodes.emplace(c_szKey, pChildGroup);

	return true;
}

CGroupNode* CGroupNode::GetChildNode(const std::string & c_rstrKey) const
{
	TMapGroup::const_iterator it = m_mapChildNodes.find(c_rstrKey);
	if (it != m_mapChildNodes.end())
		return it->second;
	else
		return NULL;
}

std::string CGroupNode::GetNodeName() const
{
	return strGroupName;
}

bool CGroupNode::IsToken(const std::string & c_rstrKey) const
{
	return m_map_rows.end() != m_map_rows.find(c_rstrKey);
}

int CGroupNode::GetRowCount()
{
	return m_map_rows.size();
}

bool CGroupNode::GetRow(const std::string & c_rstrRowKey, OUT const CGroupNode::CGroupNodeRow ** ppRow) const
{
	TMapRow::const_iterator row_it = m_map_rows.find(c_rstrRowKey);
	if (m_map_rows.end() == row_it)
	{
		return false;
	}

	*ppRow = &row_it->second;

	return true;
}

bool CGroupNode::GetRow(int idx, OUT const CGroupNode::CGroupNodeRow ** ppRow) const
{
	if ((TMapRow::size_type)idx >= m_map_rows.size())
		return false;

	TMapRow::const_iterator row_it = m_map_rows.begin();

	std::advance(row_it, idx);

	*ppRow = &row_it->second;

	return true;
}

bool CGroupNode::GetGroupRow(const std::string& stGroupName, const std::string& stRow, OUT const CGroupNode::CGroupNodeRow ** ppRow) const
{
	CGroupNode* pChildGroup = GetChildNode(stGroupName);
	if (NULL != pChildGroup)
	{
		if (pChildGroup->GetRow(stRow, ppRow))
			return true;
	}
	pChildGroup = GetChildNode("default");
	if (NULL != pChildGroup)
	{
		if (pChildGroup->GetRow(stRow, ppRow))
			return true;
	}
	return false;
}

int	CGroupNode::GetColumnIndexFromName(const std::string& stName) const
{
	TMapNameToIndex::const_iterator it = m_map_columnNameToIndex.find(stName);
	if (m_map_columnNameToIndex.end() == it)
		return -1;
	else
		return it->second;
}

CGroupNode::CGroupNodeRow::CGroupNodeRow(CGroupNode* pGroupNode, TTokenVector& vec_values)
{
	m_pOwnerGroupNode = pGroupNode;
	m_vec_values.clear();
	std::copy(vec_values.begin(), vec_values.end(), std::back_inserter(m_vec_values));
}

CGroupNode::CGroupNodeRow::~CGroupNodeRow()
{
}

int CGroupNode::CGroupNodeRow::GetSize() const
{
	return m_vec_values.size();
}

