#include "stdafx.h"
#include "file_loader.h"

CMemoryTextFileLoader::CMemoryTextFileLoader()
{
}

CMemoryTextFileLoader::~CMemoryTextFileLoader()
{
}

bool CMemoryTextFileLoader::SplitLine(DWORD dwLine, std::vector<std::string>* pstTokenVector, const char * c_szDelimeter)
{
	pstTokenVector->clear();

	std::string stToken;
	const std::string & c_rstLine = GetLineString(dwLine);

	DWORD basePos = 0;

	do
	{
		int beginPos = c_rstLine.find_first_not_of(c_szDelimeter, basePos);
		if (beginPos < 0)
			return false;

		int endPos;

		if (c_rstLine[beginPos] == '#' && c_rstLine.compare(beginPos, 4, "#--#") != 0)
		{
			return false;
		}
		else if (c_rstLine[beginPos] == '"')
		{
			++beginPos;
			endPos = c_rstLine.find_first_of("\"", beginPos);

			if (endPos < 0)
				return false;

			basePos = endPos + 1;
		}
		else
		{
			endPos = c_rstLine.find_first_of(c_szDelimeter, beginPos);
			basePos = endPos;
		}

		pstTokenVector->emplace_back(c_rstLine.substr(beginPos, endPos - beginPos));

		if (int(c_rstLine.find_first_not_of(c_szDelimeter, basePos)) < 0)
			break;
	} while (basePos < c_rstLine.length());

	return true;
}

DWORD CMemoryTextFileLoader::GetLineCount()
{
	return m_stLineVector.size();
}

bool CMemoryTextFileLoader::CheckLineIndex(DWORD dwLine)
{
	if (dwLine >= m_stLineVector.size())
		return false;

	return true;
}

const std::string & CMemoryTextFileLoader::GetLineString(DWORD dwLine)
{
	assert(CheckLineIndex(dwLine));
	return m_stLineVector[dwLine];
}

void CMemoryTextFileLoader::Bind(int bufSize, const void* c_pvBuf)
{
	m_stLineVector.clear();

	const char * c_pcBuf = (const char *)c_pvBuf;
	std::string stLine;
	int pos = 0;

	// UTF-8 BOM atla (EF BB BF)
	if (bufSize >= 3 &&
		(unsigned char)c_pcBuf[0] == 0xEF &&
		(unsigned char)c_pcBuf[1] == 0xBB &&
		(unsigned char)c_pcBuf[2] == 0xBF)
	{
		pos = 3;
	}

	while (pos < bufSize)
	{
		const unsigned char c = (unsigned char)c_pcBuf[pos++];

		if ('\n' == c || '\r' == c)
		{
			if (pos < bufSize)
				if ('\n' == c_pcBuf[pos] || '\r' == c_pcBuf[pos])
					++pos;

			m_stLineVector.emplace_back(stLine);
			stLine = "";
		}
		else if (c >= 0x80)
		{
			// UTF-8 multi-byte karakter
			int byteCount = 1;
			if ((c & 0xE0) == 0xC0)
				byteCount = 2;      // 110xxxxx - 2 byte
			else if ((c & 0xF0) == 0xE0)
				byteCount = 3;      // 1110xxxx - 3 byte
			else if ((c & 0xF8) == 0xF0)
				byteCount = 4;      // 11110xxx - 4 byte

			if (pos - 1 + byteCount <= bufSize)
			{
				stLine.append(c_pcBuf + (pos - 1), byteCount);
				pos += byteCount - 1;
			}
			else
			{
				stLine += (char)c;
			}
		}
		else
		{
			stLine += (char)c;
		}
	}

	m_stLineVector.emplace_back(stLine);
}

