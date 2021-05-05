Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C658373974
	for <lists+linux-security-module@lfdr.de>; Wed,  5 May 2021 13:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhEELez (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 5 May 2021 07:34:55 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3010 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhEELev (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 May 2021 07:34:51 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FZvb93cPHz6yhs4;
        Wed,  5 May 2021 19:28:05 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 13:33:53 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v6 07/11] evm: Pass user namespace to set/remove xattr hooks
Date:   Wed, 5 May 2021 13:33:25 +0200
Message-ID: <20210505113329.1410943-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505112935.1410679-1-roberto.sassu@huawei.com>
References: <20210505112935.1410679-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In preparation for 'evm: Allow setxattr() and setattr() for unmodified
metadata', this patch passes mnt_userns to the inode set/remove xattr hooks
so that the GID of the inode on an idmapped mount is correctly determined
by posix_acl_update_mode().

Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/evm.h               | 12 ++++++++----
 security/integrity/evm/evm_main.c | 17 +++++++++++------
 security/security.c               |  4 ++--
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index e5b7bcb152b9..8cad46bcec9d 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -23,13 +23,15 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     struct integrity_iint_cache *iint);
 extern int evm_inode_setattr(struct dentry *dentry, struct iattr *attr);
 extern void evm_inode_post_setattr(struct dentry *dentry, int ia_valid);
-extern int evm_inode_setxattr(struct dentry *dentry, const char *name,
+extern int evm_inode_setxattr(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, const char *name,
 			      const void *value, size_t size);
 extern void evm_inode_post_setxattr(struct dentry *dentry,
 				    const char *xattr_name,
 				    const void *xattr_value,
 				    size_t xattr_value_len);
-extern int evm_inode_removexattr(struct dentry *dentry, const char *xattr_name);
+extern int evm_inode_removexattr(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
 				       const char *xattr_name);
 extern int evm_inode_init_security(struct inode *inode,
@@ -72,7 +74,8 @@ static inline void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 	return;
 }
 
-static inline int evm_inode_setxattr(struct dentry *dentry, const char *name,
+static inline int evm_inode_setxattr(struct user_namespace *mnt_userns,
+				     struct dentry *dentry, const char *name,
 				     const void *value, size_t size)
 {
 	return 0;
@@ -86,7 +89,8 @@ static inline void evm_inode_post_setxattr(struct dentry *dentry,
 	return;
 }
 
-static inline int evm_inode_removexattr(struct dentry *dentry,
+static inline int evm_inode_removexattr(struct user_namespace *mnt_userns,
+					struct dentry *dentry,
 					const char *xattr_name)
 {
 	return 0;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 9faebff029e6..3745c08c09e6 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -342,7 +342,8 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
  * For posix xattr acls only, permit security.evm, even if it currently
  * doesn't exist, to be updated unless the EVM signature is immutable.
  */
-static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
+static int evm_protect_xattr(struct user_namespace *mnt_userns,
+			     struct dentry *dentry, const char *xattr_name,
 			     const void *xattr_value, size_t xattr_value_len)
 {
 	enum integrity_status evm_status;
@@ -405,6 +406,7 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 
 /**
  * evm_inode_setxattr - protect the EVM extended attribute
+ * @mnt_userns: user namespace of the idmapped mount
  * @dentry: pointer to the affected dentry
  * @xattr_name: pointer to the affected extended attribute name
  * @xattr_value: pointer to the new extended attribute value
@@ -416,8 +418,9 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
  * userspace from writing HMAC value.  Writing 'security.evm' requires
  * requires CAP_SYS_ADMIN privileges.
  */
-int evm_inode_setxattr(struct dentry *dentry, const char *xattr_name,
-		       const void *xattr_value, size_t xattr_value_len)
+int evm_inode_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		       const char *xattr_name, const void *xattr_value,
+		       size_t xattr_value_len)
 {
 	const struct evm_ima_xattr_data *xattr_data = xattr_value;
 
@@ -434,19 +437,21 @@ int evm_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		    xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG)
 			return -EPERM;
 	}
-	return evm_protect_xattr(dentry, xattr_name, xattr_value,
+	return evm_protect_xattr(mnt_userns, dentry, xattr_name, xattr_value,
 				 xattr_value_len);
 }
 
 /**
  * evm_inode_removexattr - protect the EVM extended attribute
+ * @mnt_userns: user namespace of the idmapped mount
  * @dentry: pointer to the affected dentry
  * @xattr_name: pointer to the affected extended attribute name
  *
  * Removing 'security.evm' requires CAP_SYS_ADMIN privileges and that
  * the current value is valid.
  */
-int evm_inode_removexattr(struct dentry *dentry, const char *xattr_name)
+int evm_inode_removexattr(struct user_namespace *mnt_userns,
+			  struct dentry *dentry, const char *xattr_name)
 {
 	/* Policy permits modification of the protected xattrs even though
 	 * there's no HMAC key loaded
@@ -454,7 +459,7 @@ int evm_inode_removexattr(struct dentry *dentry, const char *xattr_name)
 	if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
 		return 0;
 
-	return evm_protect_xattr(dentry, xattr_name, NULL, 0);
+	return evm_protect_xattr(mnt_userns, dentry, xattr_name, NULL, 0);
 }
 
 static void evm_reset_status(struct inode *inode)
diff --git a/security/security.c b/security/security.c
index b38155b2de83..e9f8010a2341 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1354,7 +1354,7 @@ int security_inode_setxattr(struct user_namespace *mnt_userns,
 	ret = ima_inode_setxattr(dentry, name, value, size);
 	if (ret)
 		return ret;
-	return evm_inode_setxattr(dentry, name, value, size);
+	return evm_inode_setxattr(mnt_userns, dentry, name, value, size);
 }
 
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
@@ -1399,7 +1399,7 @@ int security_inode_removexattr(struct user_namespace *mnt_userns,
 	ret = ima_inode_removexattr(dentry, name);
 	if (ret)
 		return ret;
-	return evm_inode_removexattr(dentry, name);
+	return evm_inode_removexattr(mnt_userns, dentry, name);
 }
 
 int security_inode_need_killpriv(struct dentry *dentry)
-- 
2.25.1

