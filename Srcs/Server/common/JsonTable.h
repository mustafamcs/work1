#ifndef __INC_COMMON_JSONTABLE_H__
#define __INC_COMMON_JSONTABLE_H__

#include <cstdio>
#include <string>
#include <vector>
#include <rapidjson/document.h>

namespace jsontable
{
	inline bool FileExists(const char* path)
	{
		FILE* fp = std::fopen(path, "rb");
		if (!fp)
			return false;
		std::fclose(fp);
		return true;
	}

	// "x.txt" -> "x.json" ; "x.json" -> "x.json" ; diger uzantilar -> ""
	inline std::string JsonPathFor(const char* fileName)
	{
		std::string p(fileName ? fileName : "");
		const size_t n = p.size();
		if (n > 5 && p.compare(n - 5, 5, ".json") == 0)
			return p;
		if (n > 4 && p.compare(n - 4, 4, ".txt") == 0)
			return p.substr(0, n - 4) + ".json";
		return std::string();
	}

	inline bool ReadFile(const char* fileName, std::string& out)
	{
		FILE* fp = std::fopen(fileName, "rb");
		if (!fp)
			return false;
		std::fseek(fp, 0, SEEK_END);
		const long size = std::ftell(fp);
		std::fseek(fp, 0, SEEK_SET);
		out.resize(size > 0 ? size : 0);
		if (size > 0)
			std::fread(&out[0], 1, size, fp);
		std::fclose(fp);
		return true;
	}

	inline void CellToString(const rapidjson::Value& v, std::string& out)
	{
		if (v.IsString())
			out.assign(v.GetString(), v.GetStringLength());
		else if (v.IsInt64())
			out = std::to_string(v.GetInt64());
		else if (v.IsUint64())
			out = std::to_string(v.GetUint64());
		else if (v.IsDouble())
		{
			char b[64];
			snprintf(b, sizeof(b), "%g", v.GetDouble());
			out = b;
		}
		else if (v.IsBool())
			out = v.GetBool() ? "1" : "0";
		else
			out.clear();
	}

	// [ [ "hucre", "hucre" ], ... ] -> rows
	inline bool LoadRows(const char* fileName, std::vector<std::vector<std::string>>& rows)
	{
		std::string buffer;
		if (!ReadFile(fileName, buffer))
			return false;

		rapidjson::Document doc;
		doc.Parse(buffer.c_str(), buffer.size());
		if (doc.HasParseError() || !doc.IsArray())
			return false;

		rows.clear();
		for (rapidjson::Value::ConstValueIterator it = doc.Begin(); it != doc.End(); ++it)
		{
			if (!it->IsArray())
				continue;
			std::vector<std::string> row;
			for (rapidjson::Value::ConstValueIterator c = it->Begin(); c != it->End(); ++c)
			{
				std::string cell;
				CellToString(*c, cell);
				row.emplace_back(cell);
			}
			rows.emplace_back(row);
		}
		return true;
	}

	inline void EscapeJson(const std::string& in, std::string& out)
	{
		for (size_t i = 0; i < in.size(); ++i)
		{
			const char c = in[i];
			switch (c)
			{
				case '"': out += "\\\""; break;
				case '\\': out += "\\\\"; break;
				case '\n': out += "\\n"; break;
				case '\r': out += "\\r"; break;
				case '\t': out += "\\t"; break;
				default:
					if ((unsigned char)c < 0x20)
					{
						char b[8];
						snprintf(b, sizeof(b), "\\u%04x", c);
						out += b;
					}
					else
						out += c;
			}
		}
	}

	// rows -> "x.json" (UTF-8 duz karakter)
	inline bool WriteRows(const char* fileName, const std::vector<std::vector<std::string> >& rows)
	{
		FILE* fp = std::fopen(fileName, "wb");
		if (!fp)
			return false;
		std::fputs("[\n", fp);
		for (size_t i = 0; i < rows.size(); ++i)
		{
			std::string line = "\t[";
			for (size_t j = 0; j < rows[i].size(); ++j)
			{
				if (j)
					line += ", ";
				std::string esc;
				EscapeJson(rows[i][j], esc);
				line += '"';
				line += esc;
				line += '"';
			}
			line += ']';
			if (i + 1 < rows.size())
				line += ',';
			line += '\n';
			std::fwrite(line.c_str(), 1, line.size(), fp);
		}
		std::fputs("]\n", fp);
		std::fclose(fp);
		return true;
	}

	// JSON-onecelikli satir okuyucu: x.json varsa satirlari TAB ile birlestirip
	// fgets() semantigiyle verir, yoksa x.txt'den okur.
	class CLineReader
	{
	public:
		CLineReader() : m_fp(NULL), m_bJson(false), m_pos(0) {}
		~CLineReader() { Close(); }

		bool Open(const char* fileName)
		{
			m_strFileName = fileName ? fileName : "";
			const std::string jsonPath = JsonPathFor(fileName);
			if (!jsonPath.empty() && FileExists(jsonPath.c_str()))
			{
				if (!LoadRows(jsonPath.c_str(), m_rows))
					return false;
				m_bJson = true;
				m_pos = 0;
				return true;
			}
			m_bJson = false;
			m_fp = std::fopen(fileName, "rt");
			return (m_fp != NULL);
		}

		bool Gets(char* buf, int bufSize)
		{
			if (!m_bJson)
				return (m_fp && std::fgets(buf, bufSize, m_fp) != NULL);

			if (m_pos >= m_rows.size())
				return false;

			const std::vector<std::string>& row = m_rows[m_pos++];
			std::string line;
			for (size_t i = 0; i < row.size(); ++i)
			{
				if (i)
					line += '\t';
				line += row[i];
			}
			line += '\n';
			strncpy(buf, line.c_str(), bufSize - 1);
			buf[bufSize - 1] = '\0';
			return true;
		}

		// JSON modda dogrudan hucre erisimi (TAB'siz ayristirma gerektirenler icin)
		const std::vector<std::vector<std::string> >& Rows() const { return m_rows; }
		bool IsJson() const { return m_bJson; }

		// Dis kaynaktan gelen satirlari (orn. SQL) JSON modunda besler
		void SetRows(std::vector<std::vector<std::string> >& rows)
		{
			m_rows.swap(rows);
			m_bJson = true;
			m_pos = 0;
		}

		void Close()
		{
			if (m_fp)
			{
				std::fclose(m_fp);
				m_fp = NULL;
			}
		}
	private:
		FILE* m_fp;
		bool m_bJson;
		size_t m_pos;
		std::string m_strFileName;
		std::vector<std::vector<std::string> > m_rows;
	};
}

#endif // __INC_COMMON_JSONTABLE_H__
