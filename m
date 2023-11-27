Return-Path: <linux-security-module+bounces-74-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC13B7FA91F
	for <lists+linux-security-module@lfdr.de>; Mon, 27 Nov 2023 19:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA24F1C20918
	for <lists+linux-security-module@lfdr.de>; Mon, 27 Nov 2023 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451753DB93
	for <lists+linux-security-module@lfdr.de>; Mon, 27 Nov 2023 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="SnZkSNne"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BEADD;
	Mon, 27 Nov 2023 09:59:42 -0800 (PST)
Received: from fpc.intra.ispras.ru (unknown [10.10.165.13])
	by mail.ispras.ru (Postfix) with ESMTPSA id AF28940F1DC4;
	Mon, 27 Nov 2023 17:59:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AF28940F1DC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1701107979;
	bh=VEjuqMt0uxDZ/rlzw+yfIoeYXkpeJuWf+25lURwZBP0=;
	h=From:To:Cc:Subject:Date:From;
	b=SnZkSNnealGn+5XHUqVUlJmqKHhGsMTE58h+5pub1imhyr8jFY+B/zjT9fSErnUZm
	 bLYSIkojyst3QAX8cbRO1PvdaPeXBv/ce0kWWKTxL1O+Jd/X0IkAfsMHlEEUTeN1vw
	 XY31yctrPR/4/MhujsIjChH20JmC7kVbwDn0GGzk=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: John Johansen <john.johansen@canonical.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH] apparmor: free the allocated pdb objects
Date: Mon, 27 Nov 2023 20:59:04 +0300
Message-Id: <20231127175904.156583-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

policy_db objects are allocated with kzalloc() inside aa_alloc_pdb() and
are not cleared in the corresponding aa_free_pdb() function causing leak:

unreferenced object 0xffff88801f0a1400 (size 192):
  comm "apparmor_parser", pid 1247, jiffies 4295122827 (age 2306.399s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81ddc612>] __kmem_cache_alloc_node+0x1e2/0x2d0
    [<ffffffff81c47c55>] kmalloc_trace+0x25/0xc0
    [<ffffffff83eb9a12>] aa_alloc_pdb+0x82/0x140
    [<ffffffff83ec4077>] unpack_pdb+0xc7/0x2700
    [<ffffffff83ec6b10>] unpack_profile+0x450/0x4960
    [<ffffffff83ecc129>] aa_unpack+0x309/0x15e0
    [<ffffffff83ebdb23>] aa_replace_profiles+0x213/0x33c0
    [<ffffffff83e8d341>] policy_update+0x261/0x370
    [<ffffffff83e8d66e>] profile_replace+0x20e/0x2a0
    [<ffffffff81eadfaf>] vfs_write+0x2af/0xe00
    [<ffffffff81eaf4c6>] ksys_write+0x126/0x250
    [<ffffffff890fa0b6>] do_syscall_64+0x46/0xf0
    [<ffffffff892000ea>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

Free the pdbs inside aa_free_pdb(). While at it, rename the variable
representing an aa_policydb object to make the function more unified with
aa_pdb_free_kref() and aa_alloc_pdb().

Found by Linux Verification Center (linuxtesting.org).

Fixes: 98b824ff8984 ("apparmor: refcount the pdb")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 security/apparmor/policy.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index ed4c9803c8fa..957654d253dd 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -99,13 +99,14 @@ const char *const aa_profile_mode_names[] = {
 };
 
 
-static void aa_free_pdb(struct aa_policydb *policy)
+static void aa_free_pdb(struct aa_policydb *pdb)
 {
-	if (policy) {
-		aa_put_dfa(policy->dfa);
-		if (policy->perms)
-			kvfree(policy->perms);
-		aa_free_str_table(&policy->trans);
+	if (pdb) {
+		aa_put_dfa(pdb->dfa);
+		if (pdb->perms)
+			kvfree(pdb->perms);
+		aa_free_str_table(&pdb->trans);
+		kfree(pdb);
 	}
 }
 
-- 
2.34.1


