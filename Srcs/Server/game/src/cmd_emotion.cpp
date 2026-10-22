#include "stdafx.h"
#include "utils.h"
#include "char.h"
#include "char_manager.h"
#include "motion.h"
#include "packet.h"
#include "buffer_manager.h"
#include "unique_item.h"
#include "wedding.h"

#define NEED_TARGET	(1 << 0)
#define NEED_PC		(1 << 1)
#define WOMAN_ONLY	(1 << 2)
#define OTHER_SEX_ONLY	(1 << 3)
#define SELF_DISARM	(1 << 4)
#define TARGET_DISARM	(1 << 5)
#define BOTH_DISARM	(SELF_DISARM | TARGET_DISARM)

struct emotion_type_s
{
	const char *	command;
	const char *	command_to_client;
	long	flag;
	float	extra_delay;
} emotion_types[] = {
	{ "öpücük",	"french_kiss",	NEED_PC | OTHER_SEX_ONLY | BOTH_DISARM,		2.0f },
	{ "öp",	"kiss",		NEED_PC | OTHER_SEX_ONLY | BOTH_DISARM,		1.5f },
	{ "tokat",	"slap",		NEED_PC | SELF_DISARM,				1.5f },
	{ "alkış",	"clap",		0,						1.0f },
	{ "yaşa",		"cheer1",	0,						1.0f },
	{ "yaşasın",	"cheer2",	0,						1.0f },

	// DANCE
	{ "dans1",	"dance1",	0,						1.0f },
	{ "dans2",	"dance2",	0,						1.0f },
	{ "dans3",	"dance3",	0,						1.0f },
	{ "dans4",	"dance4",	0,						1.0f },
	{ "dans5",	"dance5",	0,						1.0f },
	{ "dans6",	"dance6",	0,						1.0f },
	// END_OF_DANCE
	{ "tebrik",	"congratulation",	0,				1.0f	},
	{ "affet",	"forgive",			0,				1.0f	},
	{ "kızgın",	"angry",			0,				1.0f	},
	{ "baştan",	"attractive",		0,				1.0f	},
	{ "üzgün",	"sad",				0,				1.0f	},
	{ "utangaç",	"shy",				0,				1.0f	},
	{ "destek",	"cheerup",			0,				1.0f	},
	{ "kıskanç",	"banter",			0,				1.0f	},
	{ "neşe",	"joy",				0,				1.0f	},
	{ "\n",	"\n",		0,						0.0f },
};

std::set<std::pair<DWORD, DWORD> > s_emotion_set;

ACMD(do_emotion_allow)
{
	if ( ch->GetArena() )
	{
		ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("Bunu arenada kullanamazsın."));
		return;
	}

	char arg1[256];
	one_argument(argument, arg1, sizeof(arg1));

	if (!*arg1)
		return;

	DWORD	val = 0; str_to_number(val, arg1);
	s_emotion_set.emplace(ch->GetVID(), val);
}

#ifdef ENABLE_NEWSTUFF
#include "config.h"
#endif

bool CHARACTER_CanEmotion(CHARACTER& rch)
{
#ifdef ENABLE_NEWSTUFF
	if (g_bDisableEmotionMask)
		return true;
#endif

	if (marriage::WeddingManager::instance().IsWeddingMap(rch.GetMapIndex()))
		return true;

	if (rch.IsEquipUniqueItem(UNIQUE_ITEM_EMOTION_MASK))
		return true;

	if (rch.IsEquipUniqueItem(UNIQUE_ITEM_EMOTION_MASK2))
		return true;

	return false;
}

ACMD(do_emotion)
{
	int i;
	{
		if (ch->IsRiding())
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("At sürerken duygularınızı ifade edemezsiniz."));
			return;
		}
	}

	for (i = 0; *emotion_types[i].command != '\n'; ++i)
	{
		if (!strcmp(cmd_info[cmd].command, emotion_types[i].command))
			break;

		if (!strcmp(cmd_info[cmd].command, emotion_types[i].command_to_client))
			break;
	}

	if (*emotion_types[i].command == '\n')
	{
		sys_err("duygu bulunamıyor");
		return;
	}

	if (!CHARACTER_CanEmotion(*ch))
	{
		ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("Bunu Duygu Maskesi taktığında yapabilirsin."));
		return;
	}

	if (IS_SET(emotion_types[i].flag, WOMAN_ONLY) && SEX_MALE==GET_SEX(ch))
	{
		ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("Bunu sadece bayanlar yapabilir."));
		return;
	}

	char arg1[256];
	one_argument(argument, arg1, sizeof(arg1));

	LPCHARACTER victim = NULL;

	if (*arg1)
		victim = ch->FindCharacterInView(arg1, IS_SET(emotion_types[i].flag, NEED_PC));

	if (IS_SET(emotion_types[i].flag, NEED_TARGET | NEED_PC))
	{
		if (!victim)
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("Kişi bulunamadı."));
			return;
		}
	}

	if (victim)
	{
		if (!victim->IsPC() || victim == ch)
			return;

		if (victim->IsRiding())
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("At süren bir kişiye duygularınızı ifade edemezsiniz."));
			return;
		}

		long distance = DISTANCE_APPROX(ch->GetX() - victim->GetX(), ch->GetY() - victim->GetY());

		if (distance < 10)
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("Çok yakınsın."));
			return;
		}

		if (distance > 500)
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("Çok uzaksın."));
			return;
		}

		if (IS_SET(emotion_types[i].flag, OTHER_SEX_ONLY))
		{
			if (GET_SEX(ch)==GET_SEX(victim))
			{
				ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("Bu sadece diğer cinsiyetle birlikte yapılabilen bir aksiyon."));
				return;
			}
		}

		if (IS_SET(emotion_types[i].flag, NEED_PC))
		{
			if (s_emotion_set.find(std::make_pair(victim->GetVID(), ch->GetVID())) == s_emotion_set.end())
			{
				if (true == marriage::CManager::instance().IsMarried( ch->GetPlayerID() ))
				{
					const marriage::TMarriage* marriageInfo = marriage::CManager::instance().Get( ch->GetPlayerID() );

					const DWORD other = marriageInfo->GetOther( ch->GetPlayerID() );

					if (0 == other || other != victim->GetPlayerID())
					{
						ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("Bunun için eşinin onayı gerekli."));
						return;
					}
				}
				else
				{
					ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("Bunun için eşinin onayı gerekli."));
					return;
				}
			}

			s_emotion_set.emplace(ch->GetVID(), victim->GetVID());
		}
	}

	char chatbuf[256+1];
	int len = snprintf(chatbuf, sizeof(chatbuf), "%s %u %u",
			emotion_types[i].command_to_client,
			(DWORD) ch->GetVID(), victim ? (DWORD) victim->GetVID() : 0);

	if (len < 0 || len >= (int) sizeof(chatbuf))
		len = sizeof(chatbuf) - 1;

	++len;

	TPacketGCChat pack_chat;
	pack_chat.header = HEADER_GC_CHAT;
	pack_chat.size = sizeof(TPacketGCChat) + len;
	pack_chat.type = CHAT_TYPE_COMMAND;
	pack_chat.id = 0;
	TEMP_BUFFER buf;
	buf.write(&pack_chat, sizeof(TPacketGCChat));
	buf.write(chatbuf, len);

	ch->PacketAround(buf.read_peek(), buf.size());

	if (victim)
		sys_log(1, "ACTION: %s TO %s", emotion_types[i].command, victim->GetName());
	else
		sys_log(1, "ACTION: %s", emotion_types[i].command);
}

