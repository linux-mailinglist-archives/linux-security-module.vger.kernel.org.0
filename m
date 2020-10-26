Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E3E299920
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Oct 2020 22:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391000AbgJZVwo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 26 Oct 2020 17:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390998AbgJZVwo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Oct 2020 17:52:44 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA6B20708;
        Mon, 26 Oct 2020 21:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603749163;
        bh=+A7DvgqVh3Qf7w5qcuvrismxVJ2EIHUYl5GuVTb5ydQ=;
        h=From:To:Cc:Subject:Date:From;
        b=wyVVhrq93KdEDAvh1iHH2almfUrbFHJf9tQ0VURpt6O1AVUWpGAUzkMMzNf6JUkzQ
         j0HGfydVjDgeUVhEXRS/sfBjXBiDj+gzYAAEwex+U0V6X0j/lL7/7E332J3D2gg7Hp
         t8mXYMpIsPWH/7gi3k2BKF9jocoCy6Pxn9mX1mNo=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Toshiharu Harada <haradats@nttdata.co.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] tomoyo: fix clang pointer arithmetic warning
Date:   Mon, 26 Oct 2020 22:52:31 +0100
Message-Id: <20201026215236.3894200-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

clang warns about additions on NULL pointers being undefined in C:

security/tomoyo/securityfs_if.c:226:59: warning: arithmetic on a null pointer treated as a cast from integer to pointer is a GNU extension [-Wnull-pointer-arithmetic]
        securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,

Change the code to instead use a cast through uintptr_t to avoid
the warning.

Fixes: 9590837b89aa ("Common functions for TOMOYO Linux.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/tomoyo/securityfs_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 546281c5b233..0a5f00073ef1 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -223,7 +223,7 @@ static const struct file_operations tomoyo_operations = {
 static void __init tomoyo_create_entry(const char *name, const umode_t mode,
 				       struct dentry *parent, const u8 key)
 {
-	securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,
+	securityfs_create_file(name, mode, parent, (u8 *)(uintptr_t)key,
 			       &tomoyo_operations);
 }
 
-- 
2.27.0

