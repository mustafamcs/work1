#ifndef __INC_PROFILE_H__
#define __INC_PROFILE_H__

#include "length.h"

#include <cstdio>
#include <cstring>
#include <cstdlib>

#pragma push_macro("snprintf")
#undef snprintf

// active_profile (tek satır: 99, 105, 120) ve
// server/profiles/<id>/profile.conf okunur.
// Dosya yoksa kapı kapalıdır: id 99, level_cap 99, attr_slots 5, features core.

struct SProfileRuntime
{
	bool loaded;
	int id;
	int level_cap;
	int attr_slots;
	char features[32][32];
	int feature_count;
};

inline SProfileRuntime& ProfileRuntime()
{
	static SProfileRuntime rt;
	static bool ready = false;
	if (!ready)
	{
		std::memset(&rt, 0, sizeof(rt));
		rt.id = 99;
		rt.level_cap = 99;
		rt.attr_slots = 5;
		ready = true;
	}
	return rt;
}

inline void ProfileAddFeature(const char* name)
{
	if (!name || !name[0])
		return;

	SProfileRuntime& rt = ProfileRuntime();
	if (rt.feature_count >= 32)
		return;

	char tmp[32];
	std::snprintf(tmp, sizeof(tmp), "%s", name);
	char* begin = tmp;
	while (*begin == ' ' || *begin == '\t')
		++begin;
	size_t len = std::strlen(begin);
	while (len > 0 && (begin[len - 1] == ' ' || begin[len - 1] == '\t' || begin[len - 1] == '\r' || begin[len - 1] == '\n'))
	{
		begin[--len] = '\0';
	}
	if (!begin[0])
		return;

	for (int i = 0; i < rt.feature_count; ++i)
	{
		if (std::strcmp(rt.features[i], begin) == 0)
			return;
	}

	std::snprintf(rt.features[rt.feature_count], 32, "%s", begin);
	++rt.feature_count;
}

inline void ProfileApplyIdDefaults(int id)
{
	if (id != 99 && id != 105 && id != 120)
		id = 99;

	SProfileRuntime& rt = ProfileRuntime();
	rt.id = id;
	rt.level_cap = id;
	rt.attr_slots = (id == 120) ? 7 : 5;
	rt.feature_count = 0;
	ProfileAddFeature("core");
	rt.loaded = true;
}

inline void ProfileSplitFeatures(const char* value)
{
	if (!value)
		return;

	char buf[512];
	std::snprintf(buf, sizeof(buf), "%s", value);
	char* p = buf;
	while (*p)
	{
		char* start = p;
		while (*p && *p != ',' && *p != ' ' && *p != '\t' && *p != ';')
			++p;
		char saved = *p;
		*p = '\0';
		ProfileAddFeature(start);
		if (!saved)
			break;
		++p;
	}
}

inline bool ProfileReadFirstInt(const char* path, int* out)
{
	FILE* fp = std::fopen(path, "rb");
	if (!fp)
		return false;

	char buf[64];
	size_t n = std::fread(buf, 1, sizeof(buf) - 1, fp);
	std::fclose(fp);
	buf[n] = '\0';

	char* p = buf;
	if (n >= 3 && (unsigned char)p[0] == 0xEF && (unsigned char)p[1] == 0xBB && (unsigned char)p[2] == 0xBF)
		p += 3;
	while (*p == ' ' || *p == '\t' || *p == '\r' || *p == '\n')
		++p;
	if (*p < '0' || *p > '9')
		return false;

	*out = std::atoi(p);
	return true;
}

inline bool ProfileLoadConf(const char* path)
{
	FILE* fp = std::fopen(path, "rb");
	if (!fp)
		return false;

	char line[512];
	while (std::fgets(line, sizeof(line), fp))
	{
		char* p = line;
		while (*p == ' ' || *p == '\t')
			++p;
		if (*p == '\0' || *p == '\n' || *p == '\r' || *p == '#')
			continue;

		char* eq = std::strchr(p, '=');
		if (!eq)
			continue;
		*eq = '\0';
		char* key = p;
		char* val = eq + 1;

		char* kend = key + std::strlen(key);
		while (kend > key && (kend[-1] == ' ' || kend[-1] == '\t'))
			*--kend = '\0';
		while (*val == ' ' || *val == '\t')
			++val;
		char* vend = val + std::strlen(val);
		while (vend > val && (vend[-1] == '\n' || vend[-1] == '\r' || vend[-1] == ' ' || vend[-1] == '\t'))
			*--vend = '\0';

		if (std::strcmp(key, "level_cap") == 0)
		{
			int v = std::atoi(val);
			if (v >= 1 && v <= 250)
				ProfileRuntime().level_cap = v;
		}
		else if (std::strcmp(key, "attr_slots") == 0)
		{
			int v = std::atoi(val);
			if (v >= 1 && v <= ITEM_ATTRIBUTE_MAX_NUM)
				ProfileRuntime().attr_slots = v;
		}
		else if (std::strcmp(key, "features") == 0)
			ProfileSplitFeatures(val);
	}

	std::fclose(fp);
	return true;
}

inline bool ProfileLoad()
{
	SProfileRuntime& rt = ProfileRuntime();
	if (rt.loaded)
		return true;

	const char* prefixes[] = {
		"",
		"../",
		"../../",
		"../../../",
		"../../../../",
		"../../../../../",
	};

	char activePath[512];
	const char* root = NULL;
	for (size_t i = 0; i < sizeof(prefixes) / sizeof(prefixes[0]); ++i)
	{
		std::snprintf(activePath, sizeof(activePath), "%sactive_profile", prefixes[i]);
		FILE* fp = std::fopen(activePath, "rb");
		if (!fp)
			continue;
		std::fclose(fp);
		root = prefixes[i];
		break;
	}

	if (!root)
	{
		std::fprintf(stderr, "active_profile not found; closed profile 99\n");
		ProfileApplyIdDefaults(99);
		return false;
	}

	int id = 0;
	if (!ProfileReadFirstInt(activePath, &id) || (id != 99 && id != 105 && id != 120))
	{
		std::fprintf(stderr, "active_profile invalid; closed profile 99\n");
		ProfileApplyIdDefaults(99);
		return false;
	}

	ProfileApplyIdDefaults(id);

	char confPath[512];
	std::snprintf(confPath, sizeof(confPath), "%sserver/profiles/%d/profile.conf", root, id);
	if (!ProfileLoadConf(confPath))
	{
		std::fprintf(stderr, "profile.conf missing (%s); features stay core\n", confPath);
		return false;
	}

	std::fprintf(stderr, "profile id=%d level_cap=%d attr_slots=%d features=%d\n",
		rt.id, rt.level_cap, rt.attr_slots, rt.feature_count);
	return true;
}

inline int ProfileId()
{
	ProfileLoad();
	return ProfileRuntime().id;
}

inline int ProfileLevelCap()
{
	ProfileLoad();
	return ProfileRuntime().level_cap;
}

inline int ProfileAttrSlots()
{
	ProfileLoad();
	return ProfileRuntime().attr_slots;
}

inline bool ProfileHasFeature(const char* name)
{
	ProfileLoad();
	if (!name || !name[0])
		return false;
	if (std::strcmp(name, "core") == 0)
		return true;

	const SProfileRuntime& rt = ProfileRuntime();
	for (int i = 0; i < rt.feature_count; ++i)
	{
		if (std::strcmp(rt.features[i], name) == 0)
			return true;
	}
	return false;
}

inline bool ProfileRareAttrOpen()
{
	return ProfileAttrSlots() > ITEM_ATTRIBUTE_NORM_NUM;
}

// Kemer, kostüm, kuşak, tılsım, simya. Eldiven üç profilde de yok.
inline bool ProfileWearAllowed(int itemType, int itemSubType)
{
	if (itemType == ITEM_ARMOR && itemSubType == ARMOR_GLOVE)
		return false;

	if (itemType == ITEM_BELT)
		return ProfileHasFeature("belt");

	if (itemType == ITEM_COSTUME)
	{
#ifdef ENABLE_ACCE_COSTUME_SYSTEM
		if (itemSubType == COSTUME_ACCE)
			return ProfileHasFeature("sash");
#endif
		return ProfileHasFeature("costume");
	}

	if (itemType == ITEM_DS || itemType == ITEM_SPECIAL_DS)
		return ProfileHasFeature("dragon_soul");

	if (itemType == ITEM_ARMOR && itemSubType == ARMOR_PENDANT)
		return ProfileHasFeature("talisman");

	return true;
}

// profile_lock değerleri:
// 0: açık, 1: min_profile aktif profilden büyük,
// 2: sistem bu profilde kapalı, 3: nadir efsunlar bu profilde kapalı.
// Kontrol sırası: 2 -> 1 -> 3 -> 0.
inline int ProfileComputeLock(BYTE itemType, BYTE itemSubType, WORD minProfile, const long* attrTypes)
{
	const char* feature = NULL;

	if (itemType == ITEM_DS || itemType == ITEM_SPECIAL_DS)
		feature = "dragon_soul"; // simya taşları dahil
	else if (itemType == ITEM_COSTUME)
	{
#ifdef ENABLE_ACCE_COSTUME_SYSTEM
		if (itemSubType == COSTUME_ACCE)
			feature = "sash";
		else
#endif
			feature = "costume";
	}
	else if (itemType == ITEM_ARMOR && itemSubType == ARMOR_PENDANT)
		feature = "talisman";
	else if (itemType == ITEM_BELT)
		feature = "belt";
	else if (itemType == ITEM_PET)
		feature = (itemSubType == PET_UPBRINGING) ? "level_pet" : "seal_pet";
	// energy, aura, transmutation (yansıtma), autohunt, gaya, buffi:
	// bu kaynaklarda ayrı bir item tipi/subtype yok, no-op.

	if (feature && !ProfileHasFeature(feature))
		return 2;

	if (minProfile > ProfileId())
		return 1;

	if (attrTypes && ProfileAttrSlots() <= ITEM_ATTRIBUTE_NORM_NUM)
	{
		for (int i = ITEM_ATTRIBUTE_RARE_START; i < ITEM_ATTRIBUTE_RARE_END; ++i)
		{
			if (attrTypes[i] != 0)
				return 3;
		}
	}

	return 0;
}

inline bool ProfileIsItemUsable(int lockCode)
{
	return lockCode != 1 && lockCode != 2;
}

#pragma pop_macro("snprintf")

#endif
