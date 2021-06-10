Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519D13A25AF
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Jun 2021 09:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFJHpA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 10 Jun 2021 03:45:00 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5318 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhFJHpA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Jun 2021 03:45:00 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G0wnG0sT4z1BKZm;
        Thu, 10 Jun 2021 15:38:10 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 15:42:59 +0800
Received: from huawei.com (10.175.101.6) by dggemi758-chm.china.huawei.com
 (10.1.198.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 15:42:59 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <keescook@chromium.org>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiaosong2@huawei.com>
Subject: [PATCH -next] Yama: fix doc warnings
Date:   Thu, 10 Jun 2021 15:49:18 +0800
Message-ID: <20210610074918.59095-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggemi758-chm.china.huawei.com (10.1.198.144)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix gcc W=1 warnings:

security/yama/yama_lsm.c:116: warning: Function parameter or member 'work' not described in 'yama_relation_cleanup'

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 security/yama/yama_lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..acfa1b82311d 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -110,6 +110,7 @@ static void report_access(const char *access, struct task_struct *target,
 
 /**
  * yama_relation_cleanup - remove invalid entries from the relation list
+ * @work: Pointer to "struct work_struct".
  *
  */
 static void yama_relation_cleanup(struct work_struct *work)
-- 
2.25.4

