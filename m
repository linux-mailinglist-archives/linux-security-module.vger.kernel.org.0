Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECED373976
	for <lists+linux-security-module@lfdr.de>; Wed,  5 May 2021 13:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhEELez (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 5 May 2021 07:34:55 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3011 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbhEELew (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 May 2021 07:34:52 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FZvTF3H9hz6wkM4;
        Wed,  5 May 2021 19:22:57 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 13:33:54 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6 08/11] evm: Allow setxattr() and setattr() for unmodified metadata
Date:   Wed, 5 May 2021 13:33:26 +0200
Message-ID: <20210505113329.1410943-4-roberto.sassu@huawei.com>
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

With the patch to allow xattr/attr operations if a portable signature
verification fails, cp and tar can copy all xattrs/attrs so that at the
end of the process verification succeeds.

However, it might happen that the xattrs/attrs are already set to the
correct value (taken at signing time) and signature verification succeeds
before the copy has completed. For example, an archive might contains files
owned by root and the archive is extracted by root.

Then, since portable signatures are immutable, all subsequent operations
fail (e.g. fchown()), even if the operation is legitimate (does not alter
the current value).

This patch avoids this problem by reporting successful operation to user
space when that operation does not alter the current value of xattrs/attrs.

Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 security/integrity/evm/evm_main.c | 111 +++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 3745c08c09e6..793e6556b004 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -18,6 +18,7 @@
 #include <linux/integrity.h>
 #include <linux/evm.h>
 #include <linux/magic.h>
+#include <linux/posix_acl_xattr.h>
 
 #include <crypto/hash.h>
 #include <crypto/hash_info.h>
@@ -330,6 +331,90 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
 	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
 }
 
+/*
+ * evm_xattr_acl_change - check if passed ACL changes the inode mode
+ * @mnt_userns: user namespace of the idmapped mount
+ * @dentry: pointer to the affected dentry
+ * @xattr_name: requested xattr
+ * @xattr_value: requested xattr value
+ * @xattr_value_len: requested xattr value length
+ *
+ * Check if passed ACL changes the inode mode, which is protected by EVM.
+ *
+ * Returns 1 if passed ACL causes inode mode change, 0 otherwise.
+ */
+static int evm_xattr_acl_change(struct user_namespace *mnt_userns,
+				struct dentry *dentry, const char *xattr_name,
+				const void *xattr_value, size_t xattr_value_len)
+{
+#ifdef CONFIG_FS_POSIX_ACL
+	umode_t mode;
+	struct posix_acl *acl = NULL, *acl_res;
+	struct inode *inode = d_backing_inode(dentry);
+	int rc;
+
+	/* user_ns is not relevant here, ACL_USER/ACL_GROUP don't have impact
+	 * on the inode mode (see posix_acl_equiv_mode()).
+	 */
+	acl = posix_acl_from_xattr(&init_user_ns, xattr_value, xattr_value_len);
+	if (IS_ERR_OR_NULL(acl))
+		return 1;
+
+	acl_res = acl;
+	/* Passing mnt_userns is necessary to correctly determine the GID in
+	 * an idmapped mount, as the GID is used to clear the setgid bit in
+	 * the inode mode.
+	 */
+	rc = posix_acl_update_mode(mnt_userns, inode, &mode, &acl_res);
+
+	posix_acl_release(acl);
+
+	if (rc)
+		return 1;
+
+	if (inode->i_mode != mode)
+		return 1;
+#endif
+	return 0;
+}
+
+/*
+ * evm_xattr_change - check if passed xattr value differs from current value
+ * @mnt_userns: user namespace of the idmapped mount
+ * @dentry: pointer to the affected dentry
+ * @xattr_name: requested xattr
+ * @xattr_value: requested xattr value
+ * @xattr_value_len: requested xattr value length
+ *
+ * Check if passed xattr value differs from current value.
+ *
+ * Returns 1 if passed xattr value differs from current value, 0 otherwise.
+ */
+static int evm_xattr_change(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, const char *xattr_name,
+			    const void *xattr_value, size_t xattr_value_len)
+{
+	char *xattr_data = NULL;
+	int rc = 0;
+
+	if (posix_xattr_acl(xattr_name))
+		return evm_xattr_acl_change(mnt_userns, dentry, xattr_name,
+					    xattr_value, xattr_value_len);
+
+	rc = vfs_getxattr_alloc(&init_user_ns, dentry, xattr_name, &xattr_data,
+				0, GFP_NOFS);
+	if (rc < 0)
+		return 1;
+
+	if (rc == xattr_value_len)
+		rc = !!memcmp(xattr_value, xattr_data, rc);
+	else
+		rc = 1;
+
+	kfree(xattr_data);
+	return rc;
+}
+
 /*
  * evm_protect_xattr - protect the EVM extended attribute
  *
@@ -396,7 +481,13 @@ static int evm_protect_xattr(struct user_namespace *mnt_userns,
 	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
 		return 0;
 
-	if (evm_status != INTEGRITY_PASS)
+	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
+	    !evm_xattr_change(mnt_userns, dentry, xattr_name, xattr_value,
+			      xattr_value_len))
+		return 0;
+
+	if (evm_status != INTEGRITY_PASS &&
+	    evm_status != INTEGRITY_PASS_IMMUTABLE)
 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
 				    integrity_status_msg[evm_status],
@@ -539,6 +630,19 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
 }
 
+static int evm_attr_change(struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = d_backing_inode(dentry);
+	unsigned int ia_valid = attr->ia_valid;
+
+	if ((!(ia_valid & ATTR_UID) || uid_eq(attr->ia_uid, inode->i_uid)) &&
+	    (!(ia_valid & ATTR_GID) || gid_eq(attr->ia_gid, inode->i_gid)) &&
+	    (!(ia_valid & ATTR_MODE) || attr->ia_mode == inode->i_mode))
+		return 0;
+
+	return 1;
+}
+
 /**
  * evm_inode_setattr - prevent updating an invalid EVM extended attribute
  * @dentry: pointer to the affected dentry
@@ -569,6 +673,11 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 	    (evm_status == INTEGRITY_FAIL_IMMUTABLE) ||
 	    (evm_hmac_disabled() && evm_status == INTEGRITY_NOLABEL))
 		return 0;
+
+	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
+	    !evm_attr_change(dentry, attr))
+		return 0;
+
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 			    dentry->d_name.name, "appraise_metadata",
 			    integrity_status_msg[evm_status], -EPERM, 0);
-- 
2.25.1

