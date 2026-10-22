#include "stdafx.h"
#include "sql_data.h"
#include "db.h"

namespace sqldata
{

std::string SrcFromPath(const char* path)
{
	std::string p = path ? path : "";
	const size_t s = p.find_last_of("/\\");
	if (s != std::string::npos)
		p = p.substr(s + 1);
	const size_t d = p.rfind(".txt");
	if (d != std::string::npos)
		p.resize(d);
	return p;
}

bool LoadRows(const char* src, std::vector<std::vector<std::string> >& rows)
{
	rows.clear();
	if (!src || !*src)
		return false;
	if (!AccountDB::instance().IsConnected())
		return false;

	char szQuery[512];

	// src SQL yonetiminde mi? (kayit yoksa dosya fallback)
	snprintf(szQuery, sizeof(szQuery),
		"SELECT 1 FROM game_data_src WHERE src='%s' LIMIT 1", src);
	auto pReg(AccountDB::instance().DirectQuery(szQuery));
	if (!pReg || !pReg->Get() || !pReg->Get()->pSQLResult || pReg->Get()->uiNumRows == 0)
		return false;

	snprintf(szQuery, sizeof(szQuery),
		"SELECT k,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,"
		"c17,c18,c19,c20,c21,c22,c23,c24 "
		"FROM game_data_row WHERE src='%s' ORDER BY seq", src);

	auto pMsg(AccountDB::instance().DirectQuery(szQuery));
	if (!pMsg || !pMsg->Get() || !pMsg->Get()->pSQLResult)
		return false;

	MYSQL_ROW row;
	while (NULL != (row = mysql_fetch_row(pMsg->Get()->pSQLResult)))
	{
		std::vector<std::string> tokens;
		for (int i = 0; i < 25; ++i)
		{
			if (!row[i])
				break;
			tokens.emplace_back(row[i]);
		}
		if (!tokens.empty())
			rows.emplace_back(tokens);
	}
	return true;	// src kayitli: 0 satir da gecerli (yetkili bos tablo)
}

bool OpenReader(jsontable::CLineReader& reader, const char* file)
{
	std::vector<std::vector<std::string> > rows;
	if (LoadRows(SrcFromPath(file).c_str(), rows))
	{
		reader.SetRows(rows);
		return true;
	}
	return reader.Open(file);
}

}
