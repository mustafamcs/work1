// vim:ts=4 sw=4
#include "stdafx.h"
#include "ClientManager.h"
#include "Config.h"
#include "DBManager.h"
#include "QID.h"

void CClientManager::QUERY_PARTY_CREATE(CPeer* peer, TPacketPartyCreate* p)
{
	TPartyMap & pm = m_map_pkChannelParty[peer->GetChannel()];

	if (pm.find(p->dwLeaderPID) == pm.end())
	{
		pm.emplace(p->dwLeaderPID, TPartyMember());
		ForwardPacket(HEADER_DG_PARTY_CREATE, p, sizeof(TPacketPartyCreate), peer->GetChannel(), peer);
		sys_log(0, "PARTİ Oluştur [%lu]", p->dwLeaderPID);
	}
	else
	{
		sys_err("PARTİ Oluştur - [%lu] zaten var", p->dwLeaderPID);
	}
}

void CClientManager::QUERY_PARTY_DELETE(CPeer* peer, TPacketPartyDelete* p)
{
	TPartyMap& pm = m_map_pkChannelParty[peer->GetChannel()];
	itertype(pm) it = pm.find(p->dwLeaderPID);

	if (it == pm.end())
	{
		sys_err("PARTİ Sil - [%lu] yok", p->dwLeaderPID);
		return;
	}

	pm.erase(it);
	ForwardPacket(HEADER_DG_PARTY_DELETE, p, sizeof(TPacketPartyDelete), peer->GetChannel(), peer);
	sys_log(0, "PARTİ Sil [%lu]", p->dwLeaderPID);
}

void CClientManager::QUERY_PARTY_ADD(CPeer* peer, TPacketPartyAdd* p)
{
	TPartyMap & pm = m_map_pkChannelParty[peer->GetChannel()];
	itertype(pm) it = pm.find(p->dwLeaderPID);

	if (it == pm.end())
	{
		sys_err("PARTİ Ekle - [%lu] yok", p->dwLeaderPID);
		return;
	}

	if (it->second.find(p->dwPID) == it->second.end())
	{
		it->second.emplace(p->dwPID, TPartyInfo());
		ForwardPacket(HEADER_DG_PARTY_ADD, p, sizeof(TPacketPartyAdd), peer->GetChannel(), peer);
		sys_log(0, "PARTİ Ekle [%lu] -> [%lu]", p->dwPID, p->dwLeaderPID);
	}
	else
		sys_err("PARTİ Ekle - [%lu] zaten [%lu] partisinde", p->dwPID, p->dwLeaderPID);
}

void CClientManager::QUERY_PARTY_REMOVE(CPeer* peer, TPacketPartyRemove* p)
{
	TPartyMap & pm = m_map_pkChannelParty[peer->GetChannel()];
	itertype(pm) it = pm.find(p->dwLeaderPID);

	if (it == pm.end())
	{
		sys_err("PARTİ Kaldır - [%lu] yok, [%lu] kaldırılamıyor",p->dwLeaderPID, p->dwPID);
		return;
	}

	itertype(it->second) pit = it->second.find(p->dwPID);

	if (pit != it->second.end())
	{
		it->second.erase(pit);
		ForwardPacket(HEADER_DG_PARTY_REMOVE, p, sizeof(TPacketPartyRemove), peer->GetChannel(), peer);
		sys_log(0, "PARTİ Kaldır [%lu] -> [%lu]", p->dwPID, p->dwLeaderPID);
	}
	else
		sys_err("PARTİ Kaldır - [%lu] [%lu] partisinde bulunamıyor", p->dwPID, p->dwLeaderPID);
}

void CClientManager::QUERY_PARTY_STATE_CHANGE(CPeer* peer, TPacketPartyStateChange* p)
{
	TPartyMap & pm = m_map_pkChannelParty[peer->GetChannel()];
	itertype(pm) it = pm.find(p->dwLeaderPID);

	if (it == pm.end())
	{
		sys_err("PARTİ StateChange - [%lu] yok, durum değiştirilemez [%lu]",p->dwLeaderPID, p->dwPID);
		return;
	}

	itertype(it->second) pit = it->second.find(p->dwPID);

	if (pit == it->second.end())
	{
		sys_err("PARTİ StateChange - [%lu] [%lu] partisinde bulunamıyor", p->dwPID, p->dwLeaderPID);
		return;
	}

	if (p->bFlag)
		pit->second.bRole = p->bRole;
	else
		pit->second.bRole = 0;

	ForwardPacket(HEADER_DG_PARTY_STATE_CHANGE, p, sizeof(TPacketPartyStateChange), peer->GetChannel(), peer);
	sys_log(0, "PARTİ StateChange [%lu] -> [%lu] kaynak %d %d",p->dwPID, p->dwLeaderPID, p->bRole, p->bFlag);
}

void CClientManager::QUERY_PARTY_SET_MEMBER_LEVEL(CPeer* peer, TPacketPartySetMemberLevel* p)
{
	TPartyMap & pm = m_map_pkChannelParty[peer->GetChannel()];
	itertype(pm) it = pm.find(p->dwLeaderPID);

	if (it == pm.end())
	{
		sys_err("PARTİ SetMemberLevel - [%lu] yok, seviye değiştirilemez [%lu]",p->dwLeaderPID, p->dwPID);
		return;
	}

	itertype(it->second) pit = it->second.find(p->dwPID);

	if (pit == it->second.end())
	{
		sys_err("PARTİ SetMemberLevel - [%lu] [%lu] partisinde bulunamıyor", p->dwPID, p->dwLeaderPID);
		return;
	}

	pit->second.bLevel = p->bLevel;

	ForwardPacket(HEADER_DG_PARTY_SET_MEMBER_LEVEL, p, sizeof(TPacketPartySetMemberLevel), peer->GetChannel());
	sys_log(0, "PARTİ SetMemberLevel pid [%lu] seviye %d",p->dwPID, p->bLevel);
}

