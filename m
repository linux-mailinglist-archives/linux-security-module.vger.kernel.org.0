Return-Path: <linux-security-module+bounces-15306-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNzyBKiIqGn2vQAAu9opvQ
	(envelope-from <linux-security-module+bounces-15306-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Wed, 04 Mar 2026 20:31:52 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FF7207194
	for <lists+linux-security-module@lfdr.de>; Wed, 04 Mar 2026 20:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B59453027DA6
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Mar 2026 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB63DEAD0;
	Wed,  4 Mar 2026 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cCeqlCEx"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9703D75BC
	for <linux-security-module@vger.kernel.org>; Wed,  4 Mar 2026 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652648; cv=none; b=VGO+3njg3KH3Z3kWXQAtQz40XKGa8AAu6x6WZX3TC2t87poU+cTnpCdzRS6J9aIM2fnIzMhRYJIxqdreESUNoEpONSSpQ+MQQKpnfr0wN+aw0GYe/h05+NY7pDtWqCpyaH8CkztDC3yBDSt3HEdReI18DvySfT9YOWcirhHVASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652648; c=relaxed/simple;
	bh=0mBpGfUkeMd8K93JQlf37dR4eRZ5J4VIdoM3ZmPtk3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RJeA/JF5ZxCiau0swQ2a15BMQEyGSXJcHrIPKNxil4cqXrI4BXqNDfwnMYRJPUMpZDN2QUcl7Tu9G2htkmJn+6KbHZ2fYUzMNOxmckOIviRyhL+hJzuDUNmJYp5wEKpCW6HnIbsBBwcO1s35WhA9b8e6yZ3ucxclsw4VpZJ18R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cCeqlCEx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae65d5cc57so84558225ad.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2026 11:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652647; x=1773257447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOxh1jjHnNBlU/r3wfUuHYPwmcibM6OILDY5c9b7tZs=;
        b=cCeqlCExlPvBsuxWHiTShI0REY5zjgU9npQChVX4/XEpPiAYjMeeHe+f+L6svb8h7d
         IPtWHAiiu3nCrZvrl0BLFqfGS0ln2/gBi3WjCmxSckof4xlGJmpvUMc/34j0afhfwLdX
         85y3iOItTwedvvEOgL3EeYuL5WakONB4ZAjzPgT9tg4kIy5rjdms9a/5cgFPO0SxlPHZ
         8EdBrzWL+cPVycH6LskQmbbAf62WVT8w/WH54GoWpuYoikDdjzDJUsAeBRVkX7MDyXNW
         jNv8NJstFxJ1VvRDvGDgNycXTWvUEK27issGSe/Td/C/79pyhAeJ7dbNcOgA8/jSs3I6
         eb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652647; x=1773257447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOxh1jjHnNBlU/r3wfUuHYPwmcibM6OILDY5c9b7tZs=;
        b=byo5aAEdtOBlyIcA6wI08VPvSy5rfr1G6s6TA79OYRvZsat1zjHQEAh79bLlqMGGVF
         HNoLiFh+czAotI4UAn4ZfSN/2RA0NO1AIoV85Iw0qT3eIWWxU+xF3iXNz/unbvwk6cyz
         koPtyljnd7pjUS8g8X3El6jeUnpZea5gY6rb/VxxXv9+W8VoqFvKxcUVlWSK8PFWG2Jd
         yI52Cs2eOEKHjoGQUa9bTtl81YvC9cPnifXuVzacgu93WTADdZ6owAOcxNVoxvu//PHY
         P+1xn7vZmYSN/X5H4OKGR8tLUbG4q5AK9B87TbJ5RT0qaLOdrDh93/CFZ3hEm91qjLKc
         U9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzBox5sB9HSjAzyulePMVUa7VmnOqHa2VtDmlhwfXdDyreeq6aiU8BSli1qkR4snv+PtKHORk0uezod+868bnGtgITdts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xeLDsn9ULVcBgWngnMmlww3k1R/FC7O3JlSB8SoESrflcPpI
	rIW55DUlYdMAQsQjgoJgLKRSyU39nKR7LkOJRqQCuZq7qcot8c0w6QuRobvnn1C9Uq9KGsf8DXL
	43DnM7g==
X-Received: from pltt17.prod.google.com ([2002:a17:902:d151:b0:2ae:5031:c200])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a43:b0:2ae:5daf:85dd
 with SMTP id d9443c01a7336-2ae6a9def98mr32837055ad.11.1772652647104; Wed, 04
 Mar 2026 11:30:47 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:37 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 06/15] smack: Remove IPPROTO_UDPLITE support in security_sock_rcv_skb().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 80FF7207194
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15306-lists,linux-security-module=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-security-module@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,schaufler-ca.com,paul-moore.com,namei.org,hallyn.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-security-module];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,schaufler-ca.com:email,hallyn.com:email,namei.org:email]
X-Rspamd-Action: no action

smack_socket_sock_rcv_skb() is registered as socket_sock_rcv_skb,
which is called as security_sock_rcv_skb() in sk_filter_trim_cap().

Now that UDP-Lite is gone, let's remove the IPPROTO_UDPLITE support
in smack_socket_sock_rcv_skb().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
 security/smack/smack_lsm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 98af9d7b9434..e581d6465946 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4176,7 +4176,6 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 			sip->sin6_port = th->source;
 		break;
 	case IPPROTO_UDP:
-	case IPPROTO_UDPLITE:
 		uh = skb_header_pointer(skb, offset, sizeof(_udph), &_udph);
 		if (uh != NULL)
 			sip->sin6_port = uh->source;
@@ -4301,8 +4300,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 #if IS_ENABLED(CONFIG_IPV6)
 	case PF_INET6:
 		proto = smk_skb_to_addr_ipv6(skb, &sadd);
-		if (proto != IPPROTO_UDP && proto != IPPROTO_UDPLITE &&
-		    proto != IPPROTO_TCP)
+		if (proto != IPPROTO_UDP && proto != IPPROTO_TCP)
 			break;
 #ifdef SMACK_IPV6_SECMARK_LABELING
 		skp = smack_from_skb(skb);
-- 
2.53.0.473.g4a7958ca14-goog


