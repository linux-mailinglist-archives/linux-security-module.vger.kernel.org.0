Return-Path: <linux-security-module+bounces-14451-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKQwOEzDg2mouAMAu9opvQ
	(envelope-from <linux-security-module+bounces-14451-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Wed, 04 Feb 2026 23:08:12 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C83ECEE0
	for <lists+linux-security-module@lfdr.de>; Wed, 04 Feb 2026 23:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32EBE3012BE9
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Feb 2026 22:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489DA339B5B;
	Wed,  4 Feb 2026 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C0pl4jKc"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09729BD91
	for <linux-security-module@vger.kernel.org>; Wed,  4 Feb 2026 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770242890; cv=none; b=HZUeJgHSfgWEh/NJwMwWMhZo75lioPUhKnWsaJcNqv7vBYA0dCbSm+lUsC5FoNlMAT0MVDDoopsPcGH9X8+RK43yrpHUvc9APZv4wxH6FqXB1Bc9wTZPI+6Iew1VWxAIY8B8O+Mdh577Mc2q8GEF+NhyZPMKwCKLRzJbLN0Uuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770242890; c=relaxed/simple;
	bh=647rGwjOXpJwhyN1vJ2yZKJed42sXu2X52KTrViuaug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kpp/rOEp3i8ZZ3R1Z02WkkHUsZsYcgnOhxrPGKZWeqd94TP7J4vzZItCxQtcTCHla42GkkoI8jkyfE6Xr+sxqoIbRB0F5b6e3gaVY8FUynvXh11+yJRa9fgj/PV83n6ri1jpNsLmXkbszCrwrY67xuGxqMfa5h8tMh99/lUhZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C0pl4jKc; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770242877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CMdWLbGopHdmAWXfApiWvJeoEIG/Kf/gE4BeKnetrTY=;
	b=C0pl4jKc5TrcFulz/iNhVam2ArH1y1QJMpDibw8I8opH4NSDNXPOkLjczA3FwzecMchazS
	Bg6ZJchZqFkZaP2ESc6UAlQmuuuEdjNlctAe9gzQwx4ozVp5yVqlm97Y/PyYW6ey4mnqdJ
	lppFt7hbqSIt7JYrYTFEyAjoFpuTvPo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Remove redundant if check in sk_peer_get_label
Date: Wed,  4 Feb 2026 23:07:35 +0100
Message-ID: <20260204220734.1008069-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14451-lists,linux-security-module=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-security-module@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-security-module];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61C83ECEE0
X-Rspamd-Action: no action

Remove the redundant if check in sk_peer_get_label() and return
ERR_PTR(-ENOPROTOOPT) directly.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/lsm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index a87cd60ed206..54343f7c96a4 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1536,15 +1536,11 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 static struct aa_label *sk_peer_get_label(struct sock *sk)
 {
 	struct aa_sk_ctx *ctx = aa_sock(sk);
-	struct aa_label *label = ERR_PTR(-ENOPROTOOPT);
 
 	if (rcu_access_pointer(ctx->peer))
 		return aa_get_label_rcu(&ctx->peer);
 
-	if (sk->sk_family != PF_UNIX)
-		return ERR_PTR(-ENOPROTOOPT);
-
-	return label;
+	return ERR_PTR(-ENOPROTOOPT);
 }
 
 /**
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


