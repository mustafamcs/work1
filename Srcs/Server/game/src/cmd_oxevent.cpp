#include "stdafx.h"
#include "utils.h"
#include "char.h"
#include "OXEvent.h"
#include "questmanager.h"
#include "questlua.h"
#include "config.h"
#include "locale_service.h"
#include "cmd.h"

ACMD(do_oxevent_show_quiz)
{
	ch->ChatPacket(CHAT_TYPE_INFO, "===== OX YARIŞMA LİSTESİ =====");
	COXEventManager::instance().ShowQuizList(ch);
	ch->ChatPacket(CHAT_TYPE_INFO, "===== OX YARIŞMA LİSTESİ SONU =====");
}

ACMD(do_oxevent_log)
{
	if ( COXEventManager::instance().LogWinner() == false )
	{
		ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("OX Etkinlikteki diğer katılımcılar listelendi."));
	}
	else
	{
		ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("OX Etkinlikteki diğer katılımcılar listelenemedi."));
	}
}

ACMD(do_oxevent_get_attender)
{
	ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("Diğer Katılımcıların sayısı : %d"), COXEventManager::instance().GetAttenderCount());
}

