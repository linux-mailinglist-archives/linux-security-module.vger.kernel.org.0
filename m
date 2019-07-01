Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC1D3381C
	for <lists+linux-security-module@lfdr.de>; Mon,  3 Jun 2019 20:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfFCSgX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 3 Jun 2019 14:36:23 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:36853 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfFCSgQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Jun 2019 14:36:16 -0400
Received: by mail-oi1-f201.google.com with SMTP id f30so5568104oij.3
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2019 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eZitS+dbekPKdSNKv5e4dRxz7q7psKdXco7JWUyUMYI=;
        b=uINysbsp98/V5G2kBWYHoIhT/rBsJepOwPJSjBVEQppBYNRWnvqVwAApBvYTW84bEJ
         tzMyyXoKwN4rqiWZvrGMNzC+qf5fkucrR0NzYetxglwxXgUTMns5m26CdQijOasEi1g+
         Hlqhd3qZhx1UTY5M0mOwhadaipDfE7owhYN9ym9VYoblRb2e/RPpaiGrNqNEGh/wDzVl
         PKKT8k7dnNbYCPMxODos/8GERZ6DBGH0nuhWTal6oC+WXtflYyNJ5zdsFLLJYelg/otc
         Y4Y5VddFnoFFBILsWu2w4SiGvxMorSWDUn032trwlFJD8hSaDWgMeZ3jyTnuH8nmK4MH
         rg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eZitS+dbekPKdSNKv5e4dRxz7q7psKdXco7JWUyUMYI=;
        b=acVPWL0huDIpxrTNK7fD+8emrC3g7y9Yfq7GtUFXRlfJlW+ca/yqmAnVRXmxrpr+sf
         bGoOT+8jDTVvIijIOKK4iAKU0qKuBku9S/ay/Tkb0a2/y72qOgFvdvgLCxsnK9nLIiV/
         U5xMWlmO9Q2cjgFdKn77OBupi5qwLWq3lxD4IrTgo6zMXtyR5no/BZAFs40O2T/V5S9C
         BBvFxSJ3Xp44n7VXtR31I/J1cYPLLtAXCzFMcx0WD0Dc4jL7l1J0pmrHocGDwOokU+uR
         upa4Xe9AmcId3SRR0JHme1PvH+OGi4fAkvkcuskgWtaNc77HllUYFDb8h1WKoqlqnLK2
         /acg==
X-Gm-Message-State: APjAAAWba8jLtSUtxw1f1VKgyOvjY7WzMZyRjaNdhTCxnfoHJMoarUb/
        1cVlmQ+t6E5MQdRnMz4W0IEXpFHwyE0=
X-Google-Smtp-Source: APXvYqxpXOFxdc3vJz3PZMQqPBZKT2Eii9UcnH3WZRUmIJ8WKqVB4eFIcjYFCMRAi97cbu9nJOcjDT4/rJc=
X-Received: by 2002:a9d:4d04:: with SMTP id n4mr937988otf.234.1559586975858;
 Mon, 03 Jun 2019 11:36:15 -0700 (PDT)
Date:   Mon,  3 Jun 2019 11:36:10 -0700
In-Reply-To: <20190529224350.6460-1-mikewu@google.com>
Message-Id: <20190603183610.241026-1-mikewu@google.com>
Mime-Version: 1.0
References: <20190529224350.6460-1-mikewu@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v4] Allow to exclude specific file types in LoadPin
From:   Ke Wu <mikewu@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, Ke Wu <mikewu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Linux kernel already provide MODULE_SIG and KEXEC_VERIFY_SIG to
make sure loaded kernel module and kernel image are trusted. This
patch adds a kernel command line option "loadpin.exclude" which
allows to exclude specific file types from LoadPin. This is useful
when people want to use different mechanisms to verify module and
kernel image while still use LoadPin to protect the integrity of
other files kernel loads.

Signed-off-by: Ke Wu <mikewu@google.com>
---
Changelog since v3:
- Undo patch v3 change.
- Use ignore_read_file_id rahther than kernel_read_file_str when
  iterating to prevent out-of-bounds write.

Changelog since v2:
- Make size of exclude_read_files and ignore_read_file_id to be
  equal to the size of kernel_read_file_str.

Changelog since v1:
- Mark ignore_read_file_id with __ro_after_init.
- Mark parse_exclude() with __init.
- Use ARRAY_SIZE(ignore_read_file_id) instead of READING_MAX_ID.


 Documentation/admin-guide/LSM/LoadPin.rst | 10 ++++++
 security/loadpin/loadpin.c                | 44 +++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/admin-guide/LSM/LoadPin.rst b/Documentation/admin-guide/LSM/LoadPin.rst
index 32070762d24c..716ad9b23c9a 100644
--- a/Documentation/admin-guide/LSM/LoadPin.rst
+++ b/Documentation/admin-guide/LSM/LoadPin.rst
@@ -19,3 +19,13 @@ block device backing the filesystem is not read-only, a sysctl is
 created to toggle pinning: ``/proc/sys/kernel/loadpin/enabled``. (Having
 a mutable filesystem means pinning is mutable too, but having the
 sysctl allows for easy testing on systems with a mutable filesystem.)
+
+It's also possible to exclude specific file types from LoadPin using kernel
+command line option "``loadpin.exclude``". By default, all files are
+included, but they can be excluded using kernel command line option such
+as "``loadpin.exclude=kernel-module,kexec-image``". This allows to use
+different mechanisms such as ``CONFIG_MODULE_SIG`` and
+``CONFIG_KEXEC_VERIFY_SIG`` to verify kernel module and kernel image while
+still use LoadPin to protect the integrity of other files kernel loads. The
+full list of valid file types can be found in ``kernel_read_file_str``
+defined in ``include/linux/fs.h``.
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 055fb0a64169..ae59b812f4c8 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -45,6 +45,8 @@ static void report_load(const char *origin, struct file *file, char *operation)
 }
 
 static int enforce = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCE);
+static char *exclude_read_files[READING_MAX_ID];
+static int ignore_read_file_id[READING_MAX_ID] __ro_after_init;
 static struct super_block *pinned_root;
 static DEFINE_SPINLOCK(pinned_root_spinlock);
 
@@ -129,6 +131,13 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 	struct super_block *load_root;
 	const char *origin = kernel_read_file_id_str(id);
 
+	/* If the file id is excluded, ignore the pinning. */
+	if ((unsigned int)id < ARRAY_SIZE(ignore_read_file_id) &&
+	    ignore_read_file_id[id]) {
+		report_load(origin, file, "pinning-excluded");
+		return 0;
+	}
+
 	/* This handles the older init_module API that has a NULL file. */
 	if (!file) {
 		if (!enforce) {
@@ -187,10 +196,43 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
+static void __init parse_exclude(void)
+{
+	int i, j;
+	char *cur;
+
+	/* Robustness check: size of kernel_read_file_str should be size of
+	 * ignore_read_file_id + 1.
+	 */
+	BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) <
+		     ARRAY_SIZE(ignore_read_file_id));
+
+	for (i = 0; i < ARRAY_SIZE(exclude_read_files); i++) {
+		cur = exclude_read_files[i];
+		if (!cur)
+			break;
+		if (*cur == '\0')
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(ignore_read_file_id); j++) {
+			if (strcmp(cur, kernel_read_file_str[j]) == 0) {
+				pr_info("excluding: %s\n",
+					kernel_read_file_str[j]);
+				ignore_read_file_id[j] = 1;
+				/*
+				 * Can not break, because one read_file_str
+				 * may map to more than on read_file_id.
+				 */
+			}
+		}
+	}
+}
+
 static int __init loadpin_init(void)
 {
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
+	parse_exclude();
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
 	return 0;
 }
@@ -203,3 +245,5 @@ DEFINE_LSM(loadpin) = {
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
+module_param_array_named(exclude, exclude_read_files, charp, NULL, 0);
+MODULE_PARM_DESC(exclude, "Exclude pinning specific read file types");
-- 
2.22.0.rc1.311.g5d7573a151-goog

