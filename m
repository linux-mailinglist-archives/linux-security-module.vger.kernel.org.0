Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8643D2C3F8B
	for <lists+linux-security-module@lfdr.de>; Wed, 25 Nov 2020 13:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgKYMGb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 25 Nov 2020 07:06:31 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7681 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbgKYMGb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Nov 2020 07:06:31 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ch03M36z5z15LFw;
        Wed, 25 Nov 2020 20:06:07 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Nov 2020
 20:06:20 +0800
From:   Zheng Zengkai <zhengzengkai@huawei.com>
To:     <takedakn@nttdata.co.jp>, <penguin-kernel@I-love.SAKURA.ne.jp>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhengzengkai@huawei.com>
Subject: [PATCH] tomoyo: Avoid potential null pointer access
Date:   Wed, 25 Nov 2020 20:10:43 +0800
Message-ID: <20201125121043.107662-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Calls to kzalloc() should be null-checked in order to avoid
any potential failures or unnecessary code execution.
Fix this by adding null checks for _entry_ right after allocation.

Fixes: 57c2590fb7fd ("TOMOYO: Update profile structure")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 security/tomoyo/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 4bee32bfe16d..99b4fafcb100 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -499,6 +499,8 @@ static struct tomoyo_profile *tomoyo_assign_profile
 	if (ptr)
 		return ptr;
 	entry = kzalloc(sizeof(*entry), GFP_NOFS);
+	if (!entry)
+		return NULL;
 	if (mutex_lock_interruptible(&tomoyo_policy_lock))
 		goto out;
 	ptr = ns->profile_ptr[profile];
-- 
2.20.1

