Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC693380CFC
	for <lists+linux-security-module@lfdr.de>; Fri, 14 May 2021 17:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhENPaf (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 14 May 2021 11:30:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3073 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhENPaf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 May 2021 11:30:35 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FhXNS1pz8z6cw6b;
        Fri, 14 May 2021 23:23:20 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 17:29:22 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v7 05/12] evm: Introduce evm_hmac_disabled() to safely ignore verification errors
Date:   Fri, 14 May 2021 17:27:46 +0200
Message-ID: <20210514152753.982958-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514152753.982958-1-roberto.sassu@huawei.com>
References: <20210514152753.982958-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When a file is being created, LSMs can set the initial label with the
inode_init_security hook. If no HMAC key is loaded, the new file will have
LSM xattrs but not the HMAC. It is also possible that the file remains
without protected xattrs after creation if no active LSM provided it.

Unfortunately, EVM will deny any further metadata operation on new files,
as evm_protect_xattr() will always return the INTEGRITY_NOLABEL error, or
INTEGRITY_NOXATTRS if no protected xattrs exist. This would limit the
usability of EVM when only a public key is loaded, as commands such as cp
or tar with the option to preserve xattrs won't work.

This patch introduces the evm_hmac_disabled() function to determine whether
or not it is safe to ignore verification errors, based on the ability of
EVM to calculate HMACs. If the HMAC key is not loaded, and it cannot be
loaded in the future due to the EVM_SETUP_COMPLETE initialization flag,
allowing an operation despite the attrs/xattrs being found invalid will not
make them valid.

Since the post hooks can be executed even when the HMAC key is not loaded,
this patch also ensures that the EVM_INIT_HMAC initialization flag is set
before the post hooks call evm_update_evmxattr().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/evm/evm_main.c | 37 ++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 782915117175..b263c5b8eca3 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -90,6 +90,24 @@ static bool evm_key_loaded(void)
 	return (bool)(evm_initialized & EVM_KEY_MASK);
 }
 
+/*
+ * This function determines whether or not it is safe to ignore verification
+ * errors, based on the ability of EVM to calculate HMACs. If the HMAC key
+ * is not loaded, and it cannot be loaded in the future due to the
+ * EVM_SETUP_COMPLETE initialization flag, allowing an operation despite the
+ * attrs/xattrs being found invalid will not make them valid.
+ */
+static bool evm_hmac_disabled(void)
+{
+	if (evm_initialized & EVM_INIT_HMAC)
+		return false;
+
+	if (!(evm_initialized & EVM_SETUP_COMPLETE))
+		return false;
+
+	return true;
+}
+
 static int evm_find_protected_xattrs(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
@@ -338,6 +356,10 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 	if (evm_status == INTEGRITY_NOXATTRS) {
 		struct integrity_iint_cache *iint;
 
+		/* Exception if the HMAC is not going to be calculated. */
+		if (evm_hmac_disabled())
+			return 0;
+
 		iint = integrity_iint_find(d_backing_inode(dentry));
 		if (iint && (iint->flags & IMA_NEW_FILE))
 			return 0;
@@ -354,6 +376,9 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 				    -EPERM, 0);
 	}
 out:
+	/* Exception if the HMAC is not going to be calculated. */
+	if (evm_hmac_disabled() && evm_status == INTEGRITY_NOLABEL)
+		return 0;
 	if (evm_status != INTEGRITY_PASS)
 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
@@ -474,6 +499,9 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
 	if (!strcmp(xattr_name, XATTR_NAME_EVM))
 		return;
 
+	if (!(evm_initialized & EVM_INIT_HMAC))
+		return;
+
 	evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
 }
 
@@ -497,6 +525,9 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 	if (!strcmp(xattr_name, XATTR_NAME_EVM))
 		return;
 
+	if (!(evm_initialized & EVM_INIT_HMAC))
+		return;
+
 	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
 }
 
@@ -522,7 +553,8 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 		return 0;
 	evm_status = evm_verify_current_integrity(dentry);
 	if ((evm_status == INTEGRITY_PASS) ||
-	    (evm_status == INTEGRITY_NOXATTRS))
+	    (evm_status == INTEGRITY_NOXATTRS) ||
+	    (evm_hmac_disabled() && evm_status == INTEGRITY_NOLABEL))
 		return 0;
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 			    dentry->d_name.name, "appraise_metadata",
@@ -548,6 +580,9 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 
 	evm_reset_status(dentry->d_inode);
 
+	if (!(evm_initialized & EVM_INIT_HMAC))
+		return;
+
 	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
 		evm_update_evmxattr(dentry, NULL, NULL, 0);
 }
-- 
2.25.1

