Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504342B990
	for <lists+linux-security-module@lfdr.de>; Mon, 27 May 2019 19:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfE0Rwg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 27 May 2019 13:52:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50979 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0Rwg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 May 2019 13:52:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hVJnS-0001iE-Qa; Mon, 27 May 2019 17:52:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] smack: remove redundant assignment to variable m
Date:   Mon, 27 May 2019 18:52:26 +0100
Message-Id: <20190527175226.17191-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Variable m is assigned a value that is never read and m is later
reassigned in for-loop.  This the assignment is redundant and can
be mored.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/smack/smackfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 47f73a0dabb1..b66adafeb5fa 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -1174,7 +1174,6 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 			rc = -EINVAL;
 			goto free_out;
 		}
-		m = BEBITS;
 		masks = 32;
 	}
 	if (masks > BEBITS) {
-- 
2.20.1

