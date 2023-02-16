Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63396994A3
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Feb 2023 13:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjBPMox (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 16 Feb 2023 07:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjBPMor (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 07:44:47 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D28C210C;
        Thu, 16 Feb 2023 04:44:45 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PHZNb2stDzGpTt;
        Thu, 16 Feb 2023 20:42:55 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 16 Feb
 2023 20:44:43 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <zohar@linux.ibm.com>, <paul@paul-moore.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>, <jgg@ziepe.ca>
Subject: [PATCH 4.19 v2 2/5] LSM: switch to blocking policy update notifiers
Date:   Thu, 16 Feb 2023 20:42:24 +0800
Message-ID: <20230216124227.44058-3-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230216124227.44058-1-guozihua@huawei.com>
References: <20230216124227.44058-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Janne Karhunen <janne.karhunen@gmail.com>

[ Upstream commit 42df744c4166af6959eda2df1ee5cde744d4a1c3 ]

Atomic policy updaters are not very useful as they cannot
usually perform the policy updates on their own. Since it
seems that there is no strict need for the atomicity,
switch to the blocking variant. While doing so, rename
the functions accordingly.

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: James Morris <jamorris@linux.microsoft.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 drivers/infiniband/core/device.c |  4 ++--
 include/linux/security.h         | 12 ++++++------
 security/security.c              | 23 +++++++++++++----------
 security/selinux/hooks.c         |  2 +-
 security/selinux/selinuxfs.c     |  2 +-
 5 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 9740614a108d..77e9c0c3c96b 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1208,7 +1208,7 @@ static int __init ib_core_init(void)
 		goto err_mad;
 	}
 
-	ret = register_lsm_notifier(&ibdev_lsm_nb);
+	ret = register_blocking_lsm_notifier(&ibdev_lsm_nb);
 	if (ret) {
 		pr_warn("Couldn't register LSM notifier. ret %d\n", ret);
 		goto err_sa;
@@ -1244,7 +1244,7 @@ static void __exit ib_core_cleanup(void)
 	roce_gid_mgmt_cleanup();
 	nldev_exit();
 	rdma_nl_unregister(RDMA_NL_LS);
-	unregister_lsm_notifier(&ibdev_lsm_nb);
+	unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
 	ib_sa_cleanup();
 	ib_mad_cleanup();
 	addr_cleanup();
diff --git a/include/linux/security.h b/include/linux/security.h
index 273877cf47bf..81e795c9c09a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -191,9 +191,9 @@ struct security_mnt_opts {
 	int num_mnt_opts;
 };
 
-int call_lsm_notifier(enum lsm_event event, void *data);
-int register_lsm_notifier(struct notifier_block *nb);
-int unregister_lsm_notifier(struct notifier_block *nb);
+int call_blocking_lsm_notifier(enum lsm_event event, void *data);
+int register_blocking_lsm_notifier(struct notifier_block *nb);
+int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 
 static inline void security_init_mnt_opts(struct security_mnt_opts *opts)
 {
@@ -409,17 +409,17 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 struct security_mnt_opts {
 };
 
-static inline int call_lsm_notifier(enum lsm_event event, void *data)
+static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
 {
 	return 0;
 }
 
-static inline int register_lsm_notifier(struct notifier_block *nb)
+static inline int register_blocking_lsm_notifier(struct notifier_block *nb)
 {
 	return 0;
 }
 
-static inline  int unregister_lsm_notifier(struct notifier_block *nb)
+static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index fc1410550b79..4d20a15f18b4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -38,7 +38,7 @@
 #define SECURITY_NAME_MAX	10
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
-static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
+static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
 
 char *lsm_names;
 /* Boot-time LSM user choice */
@@ -180,23 +180,26 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		panic("%s - Cannot get early memory.\n", __func__);
 }
 
-int call_lsm_notifier(enum lsm_event event, void *data)
+int call_blocking_lsm_notifier(enum lsm_event event, void *data)
 {
-	return atomic_notifier_call_chain(&lsm_notifier_chain, event, data);
+	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
+					    event, data);
 }
-EXPORT_SYMBOL(call_lsm_notifier);
+EXPORT_SYMBOL(call_blocking_lsm_notifier);
 
-int register_lsm_notifier(struct notifier_block *nb)
+int register_blocking_lsm_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&lsm_notifier_chain, nb);
+	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
+						nb);
 }
-EXPORT_SYMBOL(register_lsm_notifier);
+EXPORT_SYMBOL(register_blocking_lsm_notifier);
 
-int unregister_lsm_notifier(struct notifier_block *nb)
+int unregister_blocking_lsm_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&lsm_notifier_chain, nb);
+	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
+						  nb);
 }
-EXPORT_SYMBOL(unregister_lsm_notifier);
+EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
 
 /*
  * Hook list operation macros.
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 41e24df986eb..77f2147709b1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -199,7 +199,7 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
 {
 	if (event == AVC_CALLBACK_RESET) {
 		sel_ib_pkey_flush();
-		call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
+		call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
 	}
 
 	return 0;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 60b3f16bb5c7..4f72d0998580 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -180,7 +180,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 		selnl_notify_setenforce(new_value);
 		selinux_status_update_setenforce(state, new_value);
 		if (!new_value)
-			call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
+			call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
 	}
 	length = count;
 out:
-- 
2.17.1

