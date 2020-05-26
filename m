Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3417E19A5EC
	for <lists+linux-security-module@lfdr.de>; Wed,  1 Apr 2020 09:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbgDAHIf (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 1 Apr 2020 03:08:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731792AbgDAHIf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Apr 2020 03:08:35 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7813F750118036EA1333;
        Wed,  1 Apr 2020 15:08:28 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Apr 2020 15:08:18 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <casey@schaufler-ca.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH -next] smack: fix a missing-check bug in smack_sb_eat_lsm_opts()
Date:   Wed, 1 Apr 2020 15:10:55 +0800
Message-ID: <20200401071055.8265-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In smack_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul().
It returns NULL when fails, add check for it.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 security/smack/smack_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2862fc3..9ec30f3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -731,6 +731,8 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
 		token = match_opt_prefix(from, len, &arg);
 		if (token != Opt_error) {
 			arg = kmemdup_nul(arg, from + len - arg, GFP_KERNEL);
+			if (!arg)
+				return -ENOMEM;
 			rc = smack_add_opt(token, arg, mnt_opts);
 			if (unlikely(rc)) {
 				kfree(arg);
-- 
2.7.4

