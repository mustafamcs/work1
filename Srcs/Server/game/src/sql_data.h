#ifndef __INC_GAME_SQLDATA_H__
#define __INC_GAME_SQLDATA_H__

#include <string>
#include <vector>
#include "../../common/JsonTable.h"

// common.game_data_row uzerinden token-satiri tablo okuma.
// Donen satirlar [k, c1..cN] token dizileridir; NULL hucreler atlanir.
namespace sqldata
{
	// "locale/turkey/group.txt" -> "group"
	std::string SrcFromPath(const char* path);

	// common.game_data_row'dan src satirlarini okur.
	// false: baglanti yok / satir yok (dosya fallback kullanilmali)
	bool LoadRows(const char* src, std::vector<std::vector<std::string> >& rows);

	// SQL-oncelikli satir okuyucu: game_data_row'da src satiri varsa onu
	// besler, yoksa reader.Open(file) ile json/txt fallback'e duser.
	bool OpenReader(jsontable::CLineReader& reader, const char* file);
}

#endif // __INC_GAME_SQLDATA_H__
