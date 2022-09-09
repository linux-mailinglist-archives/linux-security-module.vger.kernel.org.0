Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3455B2B6C
	for <lists+linux-security-module@lfdr.de>; Fri,  9 Sep 2022 03:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiIIBTE (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 8 Sep 2022 21:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIIBTD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Sep 2022 21:19:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5911098FD;
        Thu,  8 Sep 2022 18:19:01 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MNyj66Nf8zmVJm;
        Fri,  9 Sep 2022 09:15:22 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 09:19:00 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH v4 1/2] ima: Simplify ima_lsm_copy_rule
Date:   Fri, 9 Sep 2022 09:15:15 +0800
Message-ID: <20220909011516.55957-2-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909011516.55957-1-guozihua@huawei.com>
References: <20220909011516.55957-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Currently ima_lsm_copy_rule() set the arg_p field of the source rule to
NULL, so that the source rule could be freed afterward. It does not make
sense for this behavior to be inside a "copy" function. So move it
outside and let the caller handle this field.

As of now, the only user of ima_lsm_copy_rule() is
ima_lsm_update_rule(). In ima_lsm_update_rule(), we would like to free
only the lsm.rule in the old rule entry, and leave arg_p untouch. In
this case, it's better to use ima_filter_rule_free() directly and not
introduce another for loop to set arg_p to NULL.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 security/integrity/ima/ima_policy.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a8802b8da946..8040215c0252 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -398,12 +398,6 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		nentry->lsm[i].type = entry->lsm[i].type;
 		nentry->lsm[i].args_p = entry->lsm[i].args_p;
-		/*
-		 * Remove the reference from entry so that the associated
-		 * memory will not be freed during a later call to
-		 * ima_lsm_free_rule(entry).
-		 */
-		entry->lsm[i].args_p = NULL;
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
@@ -417,6 +411,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 static int ima_lsm_update_rule(struct ima_rule_entry *entry)
 {
+	int i;
 	struct ima_rule_entry *nentry;
 
 	nentry = ima_lsm_copy_rule(entry);
@@ -431,7 +426,8 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
 	 * references and the entry itself. All other memory references will now
 	 * be owned by nentry.
 	 */
-	ima_lsm_free_rule(entry);
+	for (i = 0; i < MAX_LSM_RULES; i++)
+		ima_filter_rule_free(entry->lsm[i].rule);
 	kfree(entry);
 
 	return 0;
-- 
2.17.1

