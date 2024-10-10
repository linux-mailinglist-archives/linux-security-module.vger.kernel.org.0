Return-Path: <linux-security-module+bounces-6037-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7DF998D39
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Oct 2024 18:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E5DB35952
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Oct 2024 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB821CCB38;
	Thu, 10 Oct 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kxzGWNz8"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF491CCB22
	for <linux-security-module@vger.kernel.org>; Thu, 10 Oct 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574029; cv=none; b=gg5YFP765yrruK0QnAjTSKuDh3gNtiNlp0+daGPe3zzKZd52dt9Z/hjKLuXXkLLLITuoXwqbKzhKbwb/fucX9c5h1AnZKvYl1k/NQyh0rWPgQzlyRU6lVHcbRoH617VWlhQTE1p2iOe4RATT7kve5cWON1GmK2SopU9zn9RNUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574029; c=relaxed/simple;
	bh=b9m/+J0NHIYt2XBf4REoel7im/5tGdJ8vx2caisRitU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjywbER8AylyCT/ZcA+uk7vKCSymZfU1loA4aVTwH2Fien0KWTchD73qwYl/MwkUY8fLXGSb0jRIyRq63VpnvX+/Wqgd1z5/CDFCruDun/TarC3Zj+0NtPUF6zsQjiOidOqPhddf+YmNqVp+McTvFmiV4EB2een0BGW+wdOUTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kxzGWNz8; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XPYX23TrVz6C1;
	Thu, 10 Oct 2024 17:26:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728574018;
	bh=AvPae8614W2IhRWzUsWrgc6FU1WWWePg3y3V213ZELM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxzGWNz8JdR99s0m1e7yN3Ny21/+iH2p9EBA4vF4rLkWIt1vU6NxgFwpsBOQaYgml
	 cWhnNyw/uaMeE1SxnntnZ3bF1Xjo+IHSiHdHf1Qm5SCSmgA6MBkgOGpNkjYgQ9Hz2Q
	 13aB+ZJzPIuua1hXfXD5ZzhcgDehAH4SKr1acYAU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XPYX172zpzBF7;
	Thu, 10 Oct 2024 17:26:57 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH v1 3/7] selinux: Fix inode numbers in error messages
Date: Thu, 10 Oct 2024 17:26:43 +0200
Message-ID: <20241010152649.849254-3-mic@digikod.net>
In-Reply-To: <20241010152649.849254-1-mic@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Use the new inode_get_ino() helper to log the user space's view of
inode's numbers instead of the private kernel values.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/selinux/hooks.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fc926d3cac6e..60b31b35f475 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1384,8 +1384,8 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 	if (rc < 0) {
 		kfree(context);
 		if (rc != -ENODATA) {
-			pr_warn("SELinux: %s:  getxattr returned %d for dev=%s ino=%ld\n",
-				__func__, -rc, inode->i_sb->s_id, inode->i_ino);
+			pr_warn("SELinux: %s:  getxattr returned %d for dev=%s ino=%llu\n",
+				__func__, -rc, inode->i_sb->s_id, inode_get_ino(inode));
 			return rc;
 		}
 		*sid = def_sid;
@@ -1396,13 +1396,13 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 					     def_sid, GFP_NOFS);
 	if (rc) {
 		char *dev = inode->i_sb->s_id;
-		unsigned long ino = inode->i_ino;
+		u64 ino = inode_get_ino(inode);
 
 		if (rc == -EINVAL) {
-			pr_notice_ratelimited("SELinux: inode=%lu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
+			pr_notice_ratelimited("SELinux: inode=%llu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
 					      ino, dev, context);
 		} else {
-			pr_warn("SELinux: %s:  context_to_sid(%s) returned %d for dev=%s ino=%ld\n",
+			pr_warn("SELinux: %s:  context_to_sid(%s) returned %d for dev=%s ino=%llu\n",
 				__func__, context, -rc, dev, ino);
 		}
 	}
@@ -3324,8 +3324,8 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 					   &newsid);
 	if (rc) {
 		pr_err("SELinux:  unable to map context to SID"
-		       "for (%s, %lu), rc=%d\n",
-		       inode->i_sb->s_id, inode->i_ino, -rc);
+		       "for (%s, %llu), rc=%d\n",
+		       inode->i_sb->s_id, inode_get_ino(inode), -rc);
 		return;
 	}
 
-- 
2.46.1


