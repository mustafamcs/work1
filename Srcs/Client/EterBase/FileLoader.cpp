#include "StdAfx.h"
#include "FileLoader.h"
#include <assert.h>

CMemoryTextFileLoader::CMemoryTextFileLoader()
{
}

CMemoryTextFileLoader::~CMemoryTextFileLoader()
{
}

bool CMemoryTextFileLoader::SplitLineByTab(DWORD dwLine, CTokenVector* pstTokenVector)
{
	pstTokenVector->reserve(10);
	pstTokenVector->clear();

	const std::string & c_rstLine = GetLineString(dwLine);
	const int c_iLineLength = c_rstLine.length();

	if (0 == c_iLineLength)
		return false;

	int basePos = 0;

	do
	{
		int beginPos = c_rstLine.find_first_of("\t", basePos);

		pstTokenVector->push_back(c_rstLine.substr(basePos, beginPos-basePos));

		basePos = beginPos+1;
	} while (basePos < c_iLineLength && basePos > 0);

	return true;
}

int CMemoryTextFileLoader::SplitLine2(DWORD dwLine, CTokenVector* pstTokenVector, const char * c_szDelimeter)
{
	pstTokenVector->reserve(10);
	pstTokenVector->clear();

	std::string stToken;
	const std::string & c_rstLine = GetLineString(dwLine);

	DWORD basePos = 0;

	do
	{
		int beginPos = c_rstLine.find_first_not_of(c_szDelimeter, basePos);

		if (beginPos < 0)
			return -1;

		int endPos;

		if (c_rstLine[beginPos] == '"')
		{
			++beginPos;
			endPos = c_rstLine.find_first_of("\"", beginPos);

			if (endPos < 0)
				return -2;

			basePos = endPos + 1;
		}
		else
		{
			endPos = c_rstLine.find_first_of(c_szDelimeter, beginPos);
			basePos = endPos;
		}

		pstTokenVector->push_back(c_rstLine.substr(beginPos, endPos - beginPos));

		if (int(c_rstLine.find_first_not_of(c_szDelimeter, basePos)) < 0)
			break;
	} while (basePos < c_rstLine.length());

	return 0;
}

bool CMemoryTextFileLoader::SplitLine(DWORD dwLine, CTokenVector* pstTokenVector, const char * c_szDelimeter)
{
	pstTokenVector->reserve(10);
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

		if (c_rstLine[beginPos] == '"')
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

		pstTokenVector->push_back(c_rstLine.substr(beginPos, endPos - beginPos));

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

static bool s_keepUtf8 = false;

void Locale_SetKeepUTF8(bool keep)
{
	s_keepUtf8 = keep;
}

// UTF-8 codepoint'i Windows-1254'e cevir (Turkce karakterler icin)
static char ConvertUTF8ToWindows1254(unsigned int codepoint)
{
	// Turkce karakterler - UTF-8 codepoint -> Windows-1254
	switch (codepoint)
	{
		case 0x011E: return (char)0xD0; // Ğ
		case 0x011F: return (char)0xF0; // ğ
		case 0x0130: return (char)0xDD; // İ
		case 0x0131: return (char)0xFD; // ı
		case 0x015E: return (char)0xDE; // Ş
		case 0x015F: return (char)0xFE; // ş
		case 0x00C7: return (char)0xC7; // Ç
		case 0x00E7: return (char)0xE7; // ç
		case 0x00D6: return (char)0xD6; // Ö
		case 0x00F6: return (char)0xF6; // ö
		case 0x00DC: return (char)0xDC; // Ü
		case 0x00FC: return (char)0xFC; // ü
		// Diger yaygin karakterler
		case 0x20AC: return (char)0x80; // €
		default:
			// Latin-1 araligi (0x00-0xFF) dogrudan gecerli
			if (codepoint <= 0xFF)
				return (char)codepoint;
			return '?'; // Bilinmeyen karakter
	}
}

void CMemoryTextFileLoader::Bind(int bufSize, const void* c_pvBuf)
{
	m_stLineVector.reserve(128);
	m_stLineVector.clear();

	const char * c_pcBuf = (const char *)c_pvBuf;
	std::string stLine;
	int pos = 0;

	// UTF-8 BOM kontrolu (EF BB BF)
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

			m_stLineVector.push_back(stLine);
			stLine = "";
		}
		else if (c >= 0x80)
		{
			if (s_keepUtf8)
			{
				stLine += (char)c;
				continue;
			}
			// UTF-8 multi-byte karakter kontrolu (BOM olsun olmasin)
			// 2-byte UTF-8: 110xxxxx 10xxxxxx
			if ((c & 0xE0) == 0xC0 && pos < bufSize)
			{
				unsigned char c2 = (unsigned char)c_pcBuf[pos];
				if ((c2 & 0xC0) == 0x80) // Valid UTF-8 continuation byte
				{
					unsigned int codepoint = ((c & 0x1F) << 6) | (c2 & 0x3F);
					stLine += ConvertUTF8ToWindows1254(codepoint);
					pos++;
					continue;
				}
			}
			// 3-byte UTF-8: 1110xxxx 10xxxxxx 10xxxxxx
			else if ((c & 0xF0) == 0xE0 && pos + 1 < bufSize)
			{
				unsigned char c2 = (unsigned char)c_pcBuf[pos];
				unsigned char c3 = (unsigned char)c_pcBuf[pos + 1];
				if ((c2 & 0xC0) == 0x80 && (c3 & 0xC0) == 0x80) // Valid UTF-8 continuation bytes
				{
					unsigned int codepoint = ((c & 0x0F) << 12) | ((c2 & 0x3F) << 6) | (c3 & 0x3F);
					stLine += ConvertUTF8ToWindows1254(codepoint);
					pos += 2;
					continue;
				}
			}
			// 4-byte UTF-8: 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
			else if ((c & 0xF8) == 0xF0 && pos + 2 < bufSize)
			{
				unsigned char c2 = (unsigned char)c_pcBuf[pos];
				unsigned char c3 = (unsigned char)c_pcBuf[pos + 1];
				unsigned char c4 = (unsigned char)c_pcBuf[pos + 2];
				if ((c2 & 0xC0) == 0x80 && (c3 & 0xC0) == 0x80 && (c4 & 0xC0) == 0x80)
				{
					stLine += '?'; // 4-byte karakterler Windows-1254'te yok
					pos += 3;
					continue;
				}
			}
			// UTF-8 degilse, zaten Windows-1254 olarak kabul et
			stLine += (char)c;
		}
		else
		{
			stLine += (char)c;
		}
	}

	m_stLineVector.push_back(stLine);
}

//////////////////////////////////////////////////////////////////////////////////////////////////
int CMemoryFileLoader::GetSize()
{
	return m_size;
}

int CMemoryFileLoader::GetPosition()
{
	return m_pos;
}

bool CMemoryFileLoader::IsReadableSize(int size)
{
	if (m_pos + size > m_size)
		return false;

	return true;
}

bool CMemoryFileLoader::Read(int size, void* pvDst)
{
	if (!IsReadableSize(size))
		return false;

	memcpy(pvDst, GetCurrentPositionPointer(), size);
	m_pos += size;
	return true;
}

const char* CMemoryFileLoader::GetCurrentPositionPointer()
{
	assert(m_pcBase != NULL);
	return (m_pcBase + m_pos);
}

CMemoryFileLoader::CMemoryFileLoader(int size, const void* c_pvMemoryFile)
{
	assert(c_pvMemoryFile != NULL);

	m_pos = 0;
	m_size = size;
	m_pcBase = (const char *) c_pvMemoryFile;
}

CMemoryFileLoader::~CMemoryFileLoader()
{
}

//////////////////////////////////////////////////////////////////////////////////////////////////
int CDiskFileLoader::GetSize()
{
	return m_size;
}

bool CDiskFileLoader::Read(int size, void* pvDst)
{
	assert(m_fp != NULL);

	int ret = fread(pvDst, size, 1, m_fp);

	if (ret <= 0)
		return false;

	return true;
}

bool CDiskFileLoader::Open(const char* c_szFileName)
{
	Close();

	if (!c_szFileName[0])
		return false;

	m_fp = fopen(c_szFileName, "rb");

	if (!m_fp)
		return false;

	fseek(m_fp, 0, SEEK_END);
	m_size = ftell(m_fp);
	fseek(m_fp, 0, SEEK_SET);
	return true;
}

void CDiskFileLoader::Close()
{
	if (m_fp)
		fclose(m_fp);

	Initialize();
}

void CDiskFileLoader::Initialize()
{
	m_fp = NULL;
	m_size = 0;
}

CDiskFileLoader::CDiskFileLoader()
{
	Initialize();
}

CDiskFileLoader::~CDiskFileLoader()
{
	Close();
}

