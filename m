Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAA744A334
	for <lists+linux-security-module@lfdr.de>; Tue,  9 Nov 2021 02:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242715AbhKIB0X (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 8 Nov 2021 20:26:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243377AbhKIBVS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Nov 2021 20:21:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2804161B25;
        Tue,  9 Nov 2021 01:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636420101;
        bh=e2Jilp331rr99Ef88AIlDbGBjY/CT9vxaixomPDloSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TepFlju8Ve0Y1qG+8TxNIE9w9FE0e3urNKdv7dq0oSARQ3XKfQ3i65Nm5Zqh65Xdx
         cxJuNuSO8hdQC8oo58CcfvucDeIloD/hRtnbnr1puGSog01GhGGsE0yR59L51I8VTY
         jJzDOK0HQZI+oRXnO2+8563pLaq+F1ZummlQcgW4BW3LOQapsHKxVVcGFS7qC/fQdv
         MXODWYhJeK4TgXcqbP/nGOTTuY++fGkxlzIQquhjYB3EXF3XnrFNaOQUduOcazhX8G
         VY1ZGRTZ1w/SksDBiyis9+WSSFD7vI0ThKuOYeJ3Tl7aEKlW+2oCNgBsZx/I16Weq5
         5Fyuqybbc/jpg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        syzbot+3f91de0b813cc3d19a80@syzkaller.appspotmail.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>, jmorris@namei.org,
        serge@hallyn.com, linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/33] smackfs: Fix use-after-free in netlbl_catmap_walk()
Date:   Mon,  8 Nov 2021 20:07:41 -0500
Message-Id: <20211109010807.1191567-7-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109010807.1191567-1-sashal@kernel.org>
References: <20211109010807.1191567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

[ Upstream commit 0817534ff9ea809fac1322c5c8c574be8483ea57 ]

Syzkaller reported use-after-free bug as described in [1]. The bug is
triggered when smk_set_cipso() tries to free stale category bitmaps
while there are concurrent reader(s) using the same bitmaps.

Wait for RCU grace period to finish before freeing the category bitmaps
in smk_set_cipso(). This makes sure that there are no more readers using
the stale bitmaps and freeing them should be safe.

[1] https://lore.kernel.org/netdev/000000000000a814c505ca657a4e@google.com/

Reported-by: syzbot+3f91de0b813cc3d19a80@syzkaller.appspotmail.com
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smackfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 966d30bf2e388..e26e7fbb89657 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -854,6 +854,7 @@ static int smk_open_cipso(struct inode *inode, struct file *file)
 static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos, int format)
 {
+	struct netlbl_lsm_catmap *old_cat;
 	struct smack_known *skp;
 	struct netlbl_lsm_secattr ncats;
 	char mapcatset[SMK_CIPSOLEN];
@@ -943,9 +944,11 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 
 	rc = smk_netlbl_mls(maplevel, mapcatset, &ncats, SMK_CIPSOLEN);
 	if (rc >= 0) {
-		netlbl_catmap_free(skp->smk_netlabel.attr.mls.cat);
+		old_cat = skp->smk_netlabel.attr.mls.cat;
 		skp->smk_netlabel.attr.mls.cat = ncats.attr.mls.cat;
 		skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;
+		synchronize_rcu();
+		netlbl_catmap_free(old_cat);
 		rc = count;
 	}
 
-- 
2.33.0

