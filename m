Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883F139EB5B
	for <lists+linux-security-module@lfdr.de>; Tue,  8 Jun 2021 03:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFHBav (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 7 Jun 2021 21:30:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3089 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHBav (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Jun 2021 21:30:51 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzXZZ6xqpzWt1b;
        Tue,  8 Jun 2021 09:24:06 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 09:28:57 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 09:28:56 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next v2] capability: fix doc warnings in capability.c
Date:   Tue, 8 Jun 2021 09:37:58 +0800
Message-ID: <20210608013758.2496838-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fixes the following W=1 kernel build warning(s):

kernel/capability.c:490: warning: Function parameter or
 member 'mnt_userns' not described in 'privileged_wrt_inode_uidgid'
kernel/capability.c:506: warning: Function parameter or
 member 'mnt_userns' not described in 'capable_wrt_inode_uidgid'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 kernel/capability.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/capability.c b/kernel/capability.c
index 46a361dde042..8dba4982d599 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -480,6 +480,7 @@ EXPORT_SYMBOL(file_ns_capable);
 /**
  * privileged_wrt_inode_uidgid - Do capabilities in the namespace work over the inode?
  * @ns: The user namespace in question
+ * @mnt_userns: User namespace of the mount the inode was found from
  * @inode: The inode in question
  *
  * Return true if the inode uid and gid are within the namespace.
@@ -494,6 +495,7 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
 
 /**
  * capable_wrt_inode_uidgid - Check nsown_capable and uid and gid mapped
+ * @mnt_userns: User namespace of the mount the inode was found from
  * @inode: The inode in question
  * @cap: The capability in question
  *
-- 
2.31.1

