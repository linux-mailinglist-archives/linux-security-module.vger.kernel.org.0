Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A9361012
	for <lists+linux-security-module@lfdr.de>; Sat,  6 Jul 2019 12:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfGFKz1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 6 Jul 2019 06:55:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45262 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfGFKz0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Jul 2019 06:55:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so12220783wre.12;
        Sat, 06 Jul 2019 03:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yTf2cEJ/R1sIWwnnsJBizfOJ+ZTQkKILtxUL3GoVlWE=;
        b=ZLNuz0c29GG+6CNJGcOAjeOlpRMP9h7O99Pi/gakDKFGU3lhhHikq8a99CInc2k/XO
         x6Aq3KQ16oEDc3jolc38IPHfVlXaurELUSiUDHn05p6lfOFDkkvsNRWEIR/u9OIqM0Iv
         HtbBQ2B/Kq1vvvG4gn4LbVxWfdc/sXmvb7bh25PrgcUiOFGqI5qzgRkWR5JJ3qB8it29
         nt6KXK7N3DC9FtosDIw8Yw2FSs9KbQjD6zMPBftq1aXOG2YvtlhuzxNjQd3NYN3DSsHP
         AO1doaXc1DmHasyn5SSmlIyHvB5/T78+l9uWIWn6bgSiY0WNtJcA4pqYF4yEJgMx128n
         jwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yTf2cEJ/R1sIWwnnsJBizfOJ+ZTQkKILtxUL3GoVlWE=;
        b=RS48iXTel6QPwNCVYq4c/MlQvT+YbHFm3lkZAhdo3HUL9WjA7dZSRkE6fV43C0ChBX
         GtL+1HRUl580todqT/USeC7WY6l12XOndu0oSLLCP+qN8N3ET+U227APbeYAGb1BjI9W
         fyAmxUHbHyfeP01U4sVJfIENSKF63pPTC7R+wItfm+X9l7r5DLA2E3w/bYKruBobxnEW
         35iCpvoZS1F0ubwSEs73h4uHVMiXO0UPQAfGXf3BHPg+kgDcj10T4Hz8WXvTsZ5lGWYY
         Pp+xo7OHtC56/kSNFgGy4DqtHs+S/0wFuEeyslOwqxW1IxBiknOAf//UGjOC5gOpVQW7
         TcfA==
X-Gm-Message-State: APjAAAUUH5ZDrsVCsYZiMCEhfO2jTRtLQt53ha4g4bk+8QIz6O4JaYkP
        F74LCiN7WdUFsJAUuvangP4f8xY3vV157A==
X-Google-Smtp-Source: APXvYqy4CMl5RxszjxSvrEAMWtejw7CVXkEcAJC69QuAF9VdqwZsgSkOM4PQR4vCXHHgIdQEtRBcQw==
X-Received: by 2002:adf:e483:: with SMTP id i3mr7749477wrm.210.1562410523298;
        Sat, 06 Jul 2019 03:55:23 -0700 (PDT)
Received: from localhost (net-93-71-3-102.cust.vodafonedsl.it. [93.71.3.102])
        by smtp.gmail.com with ESMTPSA id h11sm12578794wrx.93.2019.07.06.03.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jul 2019 03:55:22 -0700 (PDT)
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 10/12] S.A.R.A.: XATTRs support
Date:   Sat,  6 Jul 2019 12:54:51 +0200
Message-Id: <1562410493-8661-11-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Adds support for extended filesystem attributes in security and user
namespaces. They can be used to override flags set via the centralized
configuration, even when S.A.R.A. configuration is locked or saractl
is not used at all.

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 Documentation/admin-guide/LSM/SARA.rst          | 20 +++++
 Documentation/admin-guide/kernel-parameters.txt | 16 ++++
 include/uapi/linux/xattr.h                      |  4 +
 security/sara/Kconfig                           | 22 ++++++
 security/sara/wxprot.c                          | 99 +++++++++++++++++++++++++
 5 files changed, 161 insertions(+)

diff --git a/Documentation/admin-guide/LSM/SARA.rst b/Documentation/admin-guide/LSM/SARA.rst
index fdde04c..47d9364 100644
--- a/Documentation/admin-guide/LSM/SARA.rst
+++ b/Documentation/admin-guide/LSM/SARA.rst
@@ -55,6 +55,8 @@ WX Protection. In particular:
 To extend the scope of the above features, despite the issues that they may
 cause, they are complemented by **/proc/PID/attr/sara/wxprot** interface
 and **trampoline emulation**.
+It's also possible to override the centralized configuration via `Extended
+filesystem attributes`_.
 
 At the moment, WX Protection (unless specified otherwise) should work on
 any architecture supporting the NX bit, including, but not limited to:
@@ -123,6 +125,24 @@ in your project or copy/paste parts of it.
 To make things simpler `libsara` is the only part of S.A.R.A. released under
 *CC0 - No Rights Reserved* license.
 
+Extended filesystem attributes
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+When this functionality is enabled, it's possible to override
+WX Protection flags set in the main configuration via extended attributes,
+even when S.A.R.A.'s configuration is in "locked" mode.
+If the user namespace is also enabled, its attributes will override settings
+configured via the security namespace.
+The xattrs currently in use are:
+
+- security.sara.wxprot
+- user.sara.wxprot
+
+They can be manually set to the desired value as a decimal, hexadecimal or
+octal number. When this functionality is enabled, S.A.R.A. can be easily used
+without the help of its userspace tools. Though the preferred way to change
+these attributes is `sara-xattr` which is part of `saractl` [2]_.
+
+
 Trampoline emulation
 ^^^^^^^^^^^^^^^^^^^^
 Some programs need to generate part of their code at runtime. Luckily enough,
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3d6e86d..af40f1b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4254,6 +4254,22 @@
 			See S.A.R.A. documentation.
 			Default value is set via kernel config option.
 
+	sara.wxprot_xattrs_enabled= [SARA]
+			Enable support for security xattrs.
+			Format: { "0" | "1" }
+			See security/sara/Kconfig help text
+			0 -- disable.
+			1 -- enable.
+			Default value is set via kernel config option.
+
+	sara.wxprot_xattrs_user= [SARA]
+			Enable support for user xattrs.
+			Format: { "0" | "1" }
+			See security/sara/Kconfig help text
+			0 -- disable.
+			1 -- enable.
+			Default value is set via kernel config option.
+
 	serialnumber	[BUGS=X86-32]
 
 	shapers=	[NET]
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index c1395b5..45c0333 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -77,5 +77,9 @@
 #define XATTR_POSIX_ACL_DEFAULT  "posix_acl_default"
 #define XATTR_NAME_POSIX_ACL_DEFAULT XATTR_SYSTEM_PREFIX XATTR_POSIX_ACL_DEFAULT
 
+#define XATTR_SARA_SUFFIX "sara."
+#define XATTR_SARA_WXP_SUFFIX XATTR_SARA_SUFFIX "wxp"
+#define XATTR_NAME_SEC_SARA_WXP XATTR_SECURITY_PREFIX XATTR_SARA_WXP_SUFFIX
+#define XATTR_NAME_USR_SARA_WXP XATTR_USER_PREFIX XATTR_SARA_WXP_SUFFIX
 
 #endif /* _UAPI_LINUX_XATTR_H */
diff --git a/security/sara/Kconfig b/security/sara/Kconfig
index 458e0e8..773256b 100644
--- a/security/sara/Kconfig
+++ b/security/sara/Kconfig
@@ -135,6 +135,28 @@ config SECURITY_SARA_WXPROT_EMUTRAMP
 
 	  If unsure, answer y.
 
+config SECURITY_SARA_WXPROT_XATTRS_ENABLED
+	bool "xattrs support enabled by default."
+	depends on SECURITY_SARA_WXPROT
+	default n
+	help
+	  If you say Y here it will be possible to override WX protection
+	  configuration via extended attributes in the security namespace.
+	  Even when S.A.R.A.'s configuration has been locked.
+
+	  If unsure, answer N.
+
+config CONFIG_SECURITY_SARA_WXPROT_XATTRS_USER
+	bool "'user' namespace xattrs support enabled by default."
+	depends on SECURITY_SARA_WXPROT_XATTRS_ENABLED
+	default n
+	help
+	  If you say Y here it will be possible to override WX protection
+	  configuration via extended attributes in the user namespace.
+	  Even when S.A.R.A.'s configuration has been locked.
+
+	  If unsure, answer N.
+
 config SECURITY_SARA_WXPROT_DISABLED
 	bool "WX protection will be disabled at boot."
 	depends on SECURITY_SARA_WXPROT
diff --git a/security/sara/wxprot.c b/security/sara/wxprot.c
index 84f7b1e..773d1fd 100644
--- a/security/sara/wxprot.c
+++ b/security/sara/wxprot.c
@@ -25,6 +25,7 @@
 #include <linux/printk.h>
 #include <linux/ratelimit.h>
 #include <linux/spinlock.h>
+#include <linux/xattr.h>
 
 #include "include/dfa.h"
 #include "include/sara.h"
@@ -82,6 +83,18 @@ struct wxprot_config_container {
 static const bool wxprot_emutramp;
 #endif
 
+#ifdef CONFIG_SECURITY_SARA_WXPROT_XATTRS_ENABLED
+static int wxprot_xattrs_enabled __read_mostly = true;
+#else
+static int wxprot_xattrs_enabled __read_mostly;
+#endif
+
+#ifdef CONFIG_SECURITY_SARA_WXPROT_XATTRS_USER
+static int wxprot_xattrs_user __read_mostly = true;
+#else
+static int wxprot_xattrs_user __read_mostly;
+#endif
+
 static void pr_wxp(char *msg)
 {
 	char *buf, *path;
@@ -133,6 +146,14 @@ static bool are_flags_valid(u16 flags)
 MODULE_PARM_DESC(wxprot_enabled,
 		 "Disable or enable S.A.R.A. WX Protection at boot time.");
 
+module_param(wxprot_xattrs_enabled, int, 0);
+MODULE_PARM_DESC(wxprot_xattrs_enabled,
+		 "Disable or enable S.A.R.A. WXP extended attributes interfaces.");
+
+module_param(wxprot_xattrs_user, int, 0);
+MODULE_PARM_DESC(wxprot_xattrs_user,
+		 "Allow normal users to override S.A.R.A. WXP settings via extended attributes.");
+
 static int param_set_wxpflags(const char *val, const struct kernel_param *kp)
 {
 	u16 flags;
@@ -236,6 +257,65 @@ static inline int is_relro_page(const struct vm_area_struct *vma)
 }
 
 /*
+ * Extended attributes handling
+ */
+static int sara_wxprot_xattrs_name(struct dentry *d,
+				   const char *name,
+				   u16 *flags)
+{
+	int rc;
+	char buffer[10];
+	u16 tmp;
+
+	if (!(d->d_inode->i_opflags & IOP_XATTR))
+		return -EOPNOTSUPP;
+
+	rc = __vfs_getxattr(d, d->d_inode, name, buffer, sizeof(buffer) - 1);
+	if (rc > 0) {
+		buffer[rc] = '\0';
+		rc = kstrtou16(buffer, 0, &tmp);
+		if (rc)
+			return rc;
+		if (!are_flags_valid(tmp))
+			return -EINVAL;
+		*flags = tmp;
+		return 0;
+	} else if (rc < 0)
+		return rc;
+
+	return -ENODATA;
+}
+
+#define sara_xattrs_may_return(RC, XATTRNAME, FNAME) do {	\
+	if (RC == -EINVAL || RC == -ERANGE)			\
+		pr_info_ratelimited(				\
+			"WXP: malformed xattr '%s' on '%s'\n",	\
+			XATTRNAME,				\
+			FNAME);					\
+	else if (RC == 0)					\
+		return 0;					\
+} while (0)
+
+static inline int sara_wxprot_xattrs(struct dentry *d,
+				     u16 *flags)
+{
+	int rc;
+
+	if (!wxprot_xattrs_enabled)
+		return 1;
+	if (wxprot_xattrs_user) {
+		rc = sara_wxprot_xattrs_name(d, XATTR_NAME_USR_SARA_WXP,
+					     flags);
+		sara_xattrs_may_return(rc, XATTR_NAME_USR_SARA_WXP,
+				       d->d_name.name);
+	}
+	rc = sara_wxprot_xattrs_name(d, XATTR_NAME_SEC_SARA_WXP, flags);
+	sara_xattrs_may_return(rc, XATTR_NAME_SEC_SARA_WXP, d->d_name.name);
+	return 1;
+}
+
+
+/*
  * LSM hooks
  */
 static int sara_bprm_set_creds(struct linux_binprm *bprm)
@@ -259,6 +339,10 @@ static int sara_bprm_set_creds(struct linux_binprm *bprm)
 	if (!sara_enabled || !wxprot_enabled)
 		return 0;
 
+	if (sara_wxprot_xattrs(bprm->file->f_path.dentry,
+			       &sara_wxp_flags) == 0)
+		goto flags_set;
+
 	/*
 	 * SARA_WXP_TRANSFER means that the parent
 	 * wants this child to inherit its flags.
@@ -283,6 +367,7 @@ static int sara_bprm_set_creds(struct linux_binprm *bprm)
 	} else
 		path = (char *) bprm->interp;
 
+flags_set:
 	if (sara_wxp_flags != default_flags &&
 	    sara_wxp_flags & SARA_WXP_VERBOSE)
 		pr_debug_ratelimited("WXP: '%s' run with flags '0x%x'.\n",
@@ -777,6 +862,10 @@ static int config_hash(char **buf)
 
 static DEFINE_SARA_SECFS_BOOL_FLAG(wxprot_enabled_data,
 				   wxprot_enabled);
+static DEFINE_SARA_SECFS_BOOL_FLAG(wxprot_xattrs_enabled_data,
+				   wxprot_xattrs_enabled);
+static DEFINE_SARA_SECFS_BOOL_FLAG(wxprot_xattrs_user_data,
+				   wxprot_xattrs_user);
 
 static struct sara_secfs_fptrs fptrs __lsm_ro_after_init = {
 	.load = config_load,
@@ -820,6 +909,16 @@ static DEFINE_SARA_SECFS_BOOL_FLAG(wxprot_enabled_data,
 		.type = SARA_SECFS_CONFIG_HASH,
 		.data = &fptrs,
 	},
+	{
+		.name = "xattr_enabled",
+		.type = SARA_SECFS_BOOL,
+		.data = (void *) &wxprot_xattrs_enabled_data,
+	},
+	{
+		.name = "xattr_user_allowed",
+		.type = SARA_SECFS_BOOL,
+		.data = (void *) &wxprot_xattrs_user_data,
+	},
 };
 
 
-- 
1.9.1

