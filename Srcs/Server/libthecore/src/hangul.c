#define __LIBTHECORE__
#include "stdafx.h"

int is_hangul(const BYTE * str)
{
    if (str[0] >= 0xb0 && str[0] <= 0xc8 && str[1] >= 0xa1 && str[1] <= 0xfe)
	return 1;

    return 0;
}

int check_han(const char *str)
{
    int i, code;

    if (!str || !*str)
	return 0;

    for (i = 0; str[i]; i += 2)
    {
	if (isnhspace(str[i]))
	    return 0;

	if (isalpha(str[i]) || isdigit(str[i]))
	    continue;

	code = str[i];
	code += 256;

	if (code < 176 || code > 200)
	    return 0;
    }

    return 1;
}

const char *first_han(const BYTE *str)
{
    unsigned char high, low;
    int len, i;
    const char *p = "\xb1\xd7\xbf\xdc";

    static const char* wansung[] =
    {
	"\xb0\xa1", "\xb1\xee", "\xb3\xaa", "\xb4\xd9", "\xb5\xfb",
	"\xb6\xf3", "\xb8\xb6", "\xb9\xd9", "\xba\xfc", "\xbb\xe7",
	"\xbd\xce", "\xbe\xc6", "\xc0\xda", "\xc2\xa5", "\xc2\xf7",
	"\xc4\xab", "\xc5\xb8", "\xc6\xc4", "\xc7\xcf", ""
    };

    static const char* johab[] =
    {
	"\x88\x61", "\x8c\x61", "\x90\x61", "\x94\x61", "\x98\x61",
	"\x9c\x61", "\xa0\x61", "\xa4\x61", "\xa8\x61", "\xac\x61",
	"\xb0\x61", "\xb4\x61", "\xb8\x61", "\xbc\x61", "\xc0\x61",
	"\xc4\x61", "\xc8\x61", "\xcc\x61", "\xd0\x61", ""
    };

    len = strlen((const char*) str);

    if (len < 2)
	return p;

    high = str[0];
    low  = str[1];

    if (!is_hangul(str))
    {
	return p;
    }

    high = (KStbl[(high - 0xb0) * 94 + low - 0xa1] >> 8) & 0x7c;

    for (i = 0; johab[i][0]; i++)
    {
	low = (johab[i][0] & 0x7f);

	if (low == high)
	    return (wansung[i]);
    }

    return (p);
}

int under_han(const void * orig)
{
    const BYTE * str = (const BYTE *) orig;
    BYTE high, low;
    int len;

    len = strlen((const char*) str);

    if (len < 2)
	return 0;

    if (str[len - 1] == ')')
    {
	while (str[len] != '(')
	    len--;
    }

    high = str[len - 2];
    low  = str[len - 1];

    if (!is_hangul(&str[len - 2]))
	return 0;

    high = KStbl[(high - 0xb0) * 94 + low - 0xa1] & 0x1f;

    if (high < 2)
	return 0;

    if (high > 28)
	return 0;

    return 1;
}

