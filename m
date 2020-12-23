Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CB82E1667
	for <lists+linux-security-module@lfdr.de>; Wed, 23 Dec 2020 04:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgLWCTH (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 22 Dec 2020 21:19:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgLWCTG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Dec 2020 21:19:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04301229CA;
        Wed, 23 Dec 2020 02:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608689897;
        bh=x5PIUwxH5WbhePd4i2PbNKAofydYlihwur288ZNn9Ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pc2gFmd18ziJuepaThbh9nWTJVK7eX1iGNC/jdGD2D0jqgH1aVlNY1/gWCyBbFTIa
         TZ7gQ3TI1Fiun5AI5StCyvGZnFT5YL3p+gGDAjfwfuFTCam5TsP+nOyuBE+diKGHJQ
         QLbdjbm/4Qp6YmTpHPtsDn5zwz/pVDddtTiitOcRivThkSSgYiniV0UlBBw64ATmOW
         XVPHndXGy99/3U3SVmAhqWKjSfcMXRWJEaAK9GjZPuUX7rCcIe3oFYrMtz8nZUBvp/
         LZ7Jvj4pAXZKIKg8H+wFCVVTVu/5qEd5o+Zj/+sexSV1SPQ2rh5EJvyhCU2ysNGjgA
         tUk0Cmr6ZElJA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.4 003/130] tomoyo: fix clang pointer arithmetic warning
Date:   Tue, 22 Dec 2020 21:16:06 -0500
Message-Id: <20201223021813.2791612-3-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223021813.2791612-1-sashal@kernel.org>
References: <20201223021813.2791612-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit d9594e0409651a237903a13c9718df889f43d43b ]

clang warns about additions on NULL pointers being undefined in C:

security/tomoyo/securityfs_if.c:226:59: warning: arithmetic on a null pointer treated as a cast from integer to pointer is a GNU extension [-Wnull-pointer-arithmetic]
        securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,

Change the code to instead use a cast through uintptr_t to avoid
the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/tomoyo/securityfs_if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 546281c5b233a..065f4941c4d8c 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -131,8 +131,8 @@ static const struct file_operations tomoyo_self_operations = {
  */
 static int tomoyo_open(struct inode *inode, struct file *file)
 {
-	const int key = ((u8 *) file_inode(file)->i_private)
-		- ((u8 *) NULL);
+	const u8 key = (uintptr_t) file_inode(file)->i_private;
+
 	return tomoyo_open_control(key, file);
 }
 
@@ -223,7 +223,7 @@ static const struct file_operations tomoyo_operations = {
 static void __init tomoyo_create_entry(const char *name, const umode_t mode,
 				       struct dentry *parent, const u8 key)
 {
-	securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,
+	securityfs_create_file(name, mode, parent, (void *) (uintptr_t) key,
 			       &tomoyo_operations);
 }
 
-- 
2.27.0

