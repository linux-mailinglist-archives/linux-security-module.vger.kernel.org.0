Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A6E406943
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Sep 2021 11:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhIJJrE (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 10 Sep 2021 05:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhIJJrE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Sep 2021 05:47:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544EC061574
        for <linux-security-module@vger.kernel.org>; Fri, 10 Sep 2021 02:45:53 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631267150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GSMPZEtXXftkUR1bNVazYlrnN54mxcZ7Ro8PEBPLCt8=;
        b=42+q8/8i7jcb9ljp6C0qrKHZy8rJ51qwrElY09oZqJkpfr79x8DXkmpBQ0/sZ7LERM6MzE
        1YFnxy20H15JZpEz9FWIn0SJFfF/ruoHeErgRGNtakYMaYSGvkzH9Hn9vchEKograT4zvK
        8kNFXrqiJqK5b1/PI6QQZFJL1iwSEpzU09gtnWC60EI1/96wMCDdHSlpY2tM/SzcEbcqUj
        xMTl9rAM9uNCIgdUZVzNQg59DDaDoGlcTi8XEnMJCR0/NcfJichl1+AqUXwvcEH2jdXGyZ
        XqVmXZ5dwxjcCLTpKIvWLkuDs3dNasXoUrbgohNLdFXafalYLeLfOEtytMZocw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631267150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GSMPZEtXXftkUR1bNVazYlrnN54mxcZ7Ro8PEBPLCt8=;
        b=B/1ZqLDxuoMVeZIvWM27i8yzk8yQ2+OvY+lHOrW/lVruTsOvJTT+oYKXa1M+p5juwP0FAx
        MOttZZdu8C6y0gAQ==
To:     linux-security-module@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] smack: Guard smack_ipv6_lock definition within a SMACK_IPV6_PORT_LABELING block
Date:   Fri, 10 Sep 2021 11:45:44 +0200
Message-Id: <20210910094544.3430125-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The mutex smack_ipv6_lock is only used with the SMACK_IPV6_PORT_LABELING
block but its definition is outside of the block. This leads to a
defined-but-not-used warning on PREEMPT_RT.

Moving smack_ipv6_lock down to the block where it is used where it used
raises the question why is smk_ipv6_port_list read if nothing is added
to it.
Turns out, only smk_ipv6_port_check() is using it outside of an ifdef
SMACK_IPV6_PORT_LABELING block. However two of three caller invoke
smk_ipv6_port_check() from a ifdef block and only one is using
__is_defined() macro which requires the function and smk_ipv6_port_list
to be around.

Put the lock and list inside an ifdef SMACK_IPV6_PORT_LABELING block to
avoid the warning regarding unused mutex. Extend the ifdef-block to also
cover smk_ipv6_port_check(). Make smack_socket_connect() use ifdef
instead of __is_defined() to avoid complains about missing function.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 security/smack/smack_lsm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index cacbe75185194..fd9e6b54907ee 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -51,8 +51,10 @@
 #define SMK_RECEIVING	1
 #define SMK_SENDING	2
=20
+#ifdef SMACK_IPV6_PORT_LABELING
 static DEFINE_MUTEX(smack_ipv6_lock);
 static LIST_HEAD(smk_ipv6_port_list);
+#endif
 struct kmem_cache *smack_rule_cache;
 int smack_enabled __initdata;
=20
@@ -2603,7 +2605,6 @@ static void smk_ipv6_port_label(struct socket *sock, =
struct sockaddr *address)
 	mutex_unlock(&smack_ipv6_lock);
 	return;
 }
-#endif
=20
 /**
  * smk_ipv6_port_check - check Smack port access
@@ -2666,6 +2667,7 @@ static int smk_ipv6_port_check(struct sock *sk, struc=
t sockaddr_in6 *address,
=20
 	return smk_ipv6_check(skp, object, address, act);
 }
+#endif
=20
 /**
  * smack_inode_setsecurity - set smack xattrs
@@ -2852,8 +2854,9 @@ static int smack_socket_connect(struct socket *sock, =
struct sockaddr *sap,
 			rc =3D smk_ipv6_check(ssp->smk_out, rsp, sip,
 					    SMK_CONNECTING);
 		}
-		if (__is_defined(SMACK_IPV6_PORT_LABELING))
+#ifdef SMACK_IPV6_PORT_LABELING
 			rc =3D smk_ipv6_port_check(sock->sk, sip, SMK_CONNECTING);
+#endif
=20
 		return rc;
 	}
--=20
2.33.0

