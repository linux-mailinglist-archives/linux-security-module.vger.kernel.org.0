Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EE17E405F
	for <lists+linux-security-module@lfdr.de>; Tue,  7 Nov 2023 14:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjKGNm5 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 7 Nov 2023 08:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjKGNmx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Nov 2023 08:42:53 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FA4C1;
        Tue,  7 Nov 2023 05:42:50 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SPpwT5SnVz9y1BL;
        Tue,  7 Nov 2023 21:29:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDHdmBmPkplW202AA--.56782S8;
        Tue, 07 Nov 2023 14:42:22 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 06/23] evm: Align evm_inode_post_setattr() definition with LSM infrastructure
Date:   Tue,  7 Nov 2023 14:39:55 +0100
Message-Id: <20231107134012.682009-7-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDHdmBmPkplW202AA--.56782S8
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4fuFy5GFWkXry7uFWrGrg_yoW5Ar1fpF
        Z5K3WkCw1ruryUWr95GF48Za1FgFyrWryUX3yFgw1YyFnrtrnFqFn7G3yUAry5GrW8Wrn0
        qFnFvrn5Ar15A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5IbbQABsc
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Roberto Sassu <roberto.sassu@huawei.com>

Change evm_inode_post_setattr() definition, so that it can be registered as
implementation of the inode_post_setattr hook (to be introduced).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/attr.c                         | 2 +-
 include/linux/evm.h               | 6 ++++--
 security/integrity/evm/evm_main.c | 4 +++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 9bddc0a6352c..498e673bdf06 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -503,7 +503,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
 		ima_inode_post_setattr(idmap, dentry, ia_valid);
-		evm_inode_post_setattr(dentry, ia_valid);
+		evm_inode_post_setattr(idmap, dentry, ia_valid);
 	}
 
 	return error;
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 01fc495a83e2..cf976d8dbd7a 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -23,7 +23,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     struct integrity_iint_cache *iint);
 extern int evm_inode_setattr(struct mnt_idmap *idmap,
 			     struct dentry *dentry, struct iattr *attr);
-extern void evm_inode_post_setattr(struct dentry *dentry, int ia_valid);
+extern void evm_inode_post_setattr(struct mnt_idmap *idmap,
+				   struct dentry *dentry, int ia_valid);
 extern int evm_inode_setxattr(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *name,
 			      const void *value, size_t size);
@@ -97,7 +98,8 @@ static inline int evm_inode_setattr(struct mnt_idmap *idmap,
 	return 0;
 }
 
-static inline void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
+static inline void evm_inode_post_setattr(struct mnt_idmap *idmap,
+					  struct dentry *dentry, int ia_valid)
 {
 	return;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 894570fe39bc..d452d469c503 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -840,6 +840,7 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 /**
  * evm_inode_post_setattr - update 'security.evm' after modifying metadata
+ * @idmap: idmap of the idmapped mount
  * @dentry: pointer to the affected dentry
  * @ia_valid: for the UID and GID status
  *
@@ -849,7 +850,8 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
  * This function is called from notify_change(), which expects the caller
  * to lock the inode's i_mutex.
  */
-void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
+void evm_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			    int ia_valid)
 {
 	if (!evm_revalidate_status(NULL))
 		return;
-- 
2.34.1

