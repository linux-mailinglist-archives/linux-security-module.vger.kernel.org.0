Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A54302BA
	for <lists+linux-security-module@lfdr.de>; Thu, 30 May 2019 21:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfE3TWQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 30 May 2019 15:22:16 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:44520 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3TWP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 May 2019 15:22:15 -0400
Received: by mail-qt1-f201.google.com with SMTP id p15so5857348qti.11
        for <linux-security-module@vger.kernel.org>; Thu, 30 May 2019 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KfHgTGg/JNwEVGFgmhHSyJz3/wBu2D+Qm1I3WpfuIqQ=;
        b=R0dkl/E3g/fEkV02Bx8k1+qVBP+rGhJ2PPH8UHVuKZnR2qC526HpFcoS5lEQDvsFwW
         F0kYkiOvskR4qdw8V9lDdfKO0yX5+AkcJeoORYcQ1T+zcSRL4d6DCrrU4gWj4O41HOOk
         N8jqjmD0KTjAHExyTgXSHtD5hL92FBUevn+NVCB56pLVtvKoCUDQjZDclnttOFjkRfV+
         si6eLoc4SF7zXS0NtTu+7TzhxHCo/E51b7FG+MG/zm2y0RxOfIj46btBHlXonDja4Tbc
         5uDHcmwgPD5WbuRmoeNAgnhB29jdFc3KzKSqUdrfS5kwDxGPPtGMoxhYxBbpqCtLrPQe
         yj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KfHgTGg/JNwEVGFgmhHSyJz3/wBu2D+Qm1I3WpfuIqQ=;
        b=K2ihM8zV9CohpsFSZXVQmfEJakDRsyIT4vLOcZ6NlLbASmD4Po5DDoyXMAcC8joaj1
         YnAzbseSZefYEt1Ey1I2OWTEnu7uXmUS0Mxei6bWdxLzm7XqMwPOYbre6jpBRVMnELgE
         40/JSBtxFWRUIC8ADJuGSPvhSNWbDUv5ypsyLZXnQOQjSVoiajpPe+yjkgYeuWdk9ZCB
         cJ/RL0J3dbe70/MDxqXSZ1XQ/XQth8NHlSVJ2px2tGtgUQ4oN2Q+NE26J0WWKDQBrj3N
         qM7j+OsORiSs0j91dWYv/snggsFE+1nWJQHcRhZ/br5y/qgpLmAYjc9mOjKg70gU3Ncq
         2tLw==
X-Gm-Message-State: APjAAAVi/21CyoQ52PgD+giX1ksky/GzZoAqu1SUHV+BzUPgZSg+EpnJ
        XExQnk5CuGeye1N8JNd3fzvQYusjd4s=
X-Google-Smtp-Source: APXvYqzspoWYLggt9WHuBZTaWcFuKbKtq8viGUrnhm7jJyPchxxoQjLKY1+rI4zWi8i2KKqwXjPTD1qDuXk=
X-Received: by 2002:ac8:704:: with SMTP id g4mr5009978qth.207.1559244134330;
 Thu, 30 May 2019 12:22:14 -0700 (PDT)
Date:   Thu, 30 May 2019 12:22:08 -0700
In-Reply-To: <20190529224350.6460-1-mikewu@google.com>
Message-Id: <20190530192208.99773-1-mikewu@google.com>
Mime-Version: 1.0
References: <20190529224350.6460-1-mikewu@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v2] Allow to exclude specific file types in LoadPin
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
Changelog since v1:
- Mark ignore_read_file_id with __ro_after_init.
- Mark parse_exclude() with __init.
- Use ARRAY_SIZE(ignore_read_file_id) instead of READING_MAX_ID.


 Documentation/admin-guide/LSM/LoadPin.rst | 10 ++++++
 security/loadpin/loadpin.c                | 38 +++++++++++++++++++++++
 2 files changed, 48 insertions(+)

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
index 055fb0a64169..d5f064644c54 100644
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
@@ -187,10 +196,37 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
+static void __init parse_exclude(void)
+{
+	int i, j;
+	char *cur;
+
+	for (i = 0; i < ARRAY_SIZE(exclude_read_files); i++) {
+		cur = exclude_read_files[i];
+		if (!cur)
+			break;
+		if (*cur == '\0')
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(kernel_read_file_str); j++) {
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
@@ -203,3 +239,5 @@ DEFINE_LSM(loadpin) = {
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
+module_param_array_named(exclude, exclude_read_files, charp, NULL, 0);
+MODULE_PARM_DESC(exclude, "Exclude pinning specific read file types");
-- 
2.22.0.rc1.257.g3120a18244-goog

