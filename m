Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4460769474
	for <lists+linux-security-module@lfdr.de>; Mon, 31 Jul 2023 13:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGaLQu (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 31 Jul 2023 07:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGaLQt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 31 Jul 2023 07:16:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F65BE76
        for <linux-security-module@vger.kernel.org>; Mon, 31 Jul 2023 04:16:47 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RDwds5NZczrS32;
        Mon, 31 Jul 2023 19:15:45 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 19:16:45 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>,
        <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next] apparmor: remove kernel-doc warnings
Date:   Mon, 31 Jul 2023 19:16:14 +0800
Message-ID: <20230731111614.212113-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Remove kernel-doc warnings:

security/apparmor/lib.c:33: warning: Function parameter or member 't' not
described in 'aa_free_str_table'
security/apparmor/lib.c:33: warning: Excess function parameter 'str'
description in 'aa_free_str_table'
security/apparmor/lib.c:94: warning: Function parameter or member 'n' not
described in 'skipn_spaces'
security/apparmor/lib.c:390: warning: Excess function parameter 'deny'
description in 'aa_check_perms'

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 security/apparmor/lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index a630c951bb3b..01943ec184da 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -27,7 +27,7 @@ struct aa_perms allperms = { .allow = ALL_PERMS_MASK,
 
 /**
  * aa_free_str_table - free entries str table
- * @str: the string table to free  (MAYBE NULL)
+ * @t: the string table to free  (MAYBE NULL)
  */
 void aa_free_str_table(struct aa_str_table *t)
 {
@@ -85,6 +85,7 @@ char *aa_split_fqname(char *fqname, char **ns_name)
 /**
  * skipn_spaces - Removes leading whitespace from @str.
  * @str: The string to be stripped.
+ * @n: Number of spaces to be removed.
  *
  * Returns a pointer to the first non-whitespace character in @str.
  * if all whitespace will return NULL
@@ -371,7 +372,6 @@ int aa_profile_label_perm(struct aa_profile *profile, struct aa_profile *target,
  * @profile: profile being checked
  * @perms: perms computed for the request
  * @request: requested perms
- * @deny: Returns: explicit deny set
  * @sa: initialized audit structure (MAY BE NULL if not auditing)
  * @cb: callback fn for type specific fields (MAY BE NULL)
  *
-- 
2.17.1

