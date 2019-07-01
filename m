Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A03B4F275
	for <lists+linux-security-module@lfdr.de>; Sat, 22 Jun 2019 02:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfFVAFI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Jun 2019 20:05:08 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38405 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfFVAFI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 20:05:08 -0400
Received: by mail-qk1-f202.google.com with SMTP id n190so9429474qkd.5
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 17:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wIFdm0Q0zLXc4coa7Z/96rdyx2imGKaMIfermTsJW8k=;
        b=JN4RXNvC+8GDr0Gaq4Zi34NQrWj8vWpwZgAP/YoFzEW9MZXyQWtKCMlq8iTiuX6/lV
         1+VUeYafIAXQdrdB0tlv0bk6MpHEgr4ukH4/FxX4j7mxwIpwloEP1R8iXREfuTjjemdy
         T9D4z4d/YpU2PeORir6WqmkCckgi0RrXaGHkBip2AcFXlskACVOIYWF712FCYf7/PKLn
         rm6MmlktQhwNcay49ymJnXXB1O0STSV4FQeb/wsvYGRG0zyC4/FE/bMqGhP4rHGfjy+V
         Fu/1gtkKs8OjeMJcq4TpS5ZQ4jmvqujMmVYIMgasrALy1ExKsBDys+FgQgzDsOURrNOl
         s8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wIFdm0Q0zLXc4coa7Z/96rdyx2imGKaMIfermTsJW8k=;
        b=XZGRhvgXSWu7thvpaxzHAlX0ETfdNsjPXWo0se2MrZXhAxsSyUHzemwZYZe59WGDJM
         Di/IgrCEL5EpLdpKe+MwXzSzCbs8f5FQpZdF9yN9ajPOoIMLGIKiuOfT2KJCmDNVMep5
         3y42/ZzPCrypOKAY9ZOInJHCgCvWusDXLIGVJT42NH+fofQsuUz2HUjiXFTalEIyl6e1
         Sls33pGSXbbrU3rsseEev2dHZVCU1YXo9i1cz6PIozEm3mvgYHhl6zQ7tElky3y+13n5
         zGDx4XcFliUXvakDcF7szlMAXP11RqEbR6d/XPpVLWiOh0eaevTL/7y9H+AIob2tf8Za
         DBGw==
X-Gm-Message-State: APjAAAXsuYtF6lamXgVx0PP69WPEULaYQq46o6Xnt3T6PrRappzYJpWU
        BF6luHD82bNxlOv/S4yZwvCDrQdROoT5BHWR1l62TQ==
X-Google-Smtp-Source: APXvYqwEb21I6QNDoyZGm6qhPKu1RYvZTnK22plQRnGOOx0tarObnEpgr/qYRKt5PCpyxEezLD7sbLzRW4VH5K5ByYQ+eQ==
X-Received: by 2002:a0c:afbd:: with SMTP id s58mr5323597qvc.217.1561161907281;
 Fri, 21 Jun 2019 17:05:07 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:55 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-27-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 26/29] debugfs: Restrict debugfs when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Disallow opening of debugfs files that might be used to muck around when
the kernel is locked down as various drivers give raw access to hardware
through debugfs.  Given the effort of auditing all 2000 or so files and
manually fixing each one as necessary, I've chosen to apply a heuristic
instead.  The following changes are made:

 (1) chmod and chown are disallowed on debugfs objects (though the root dir
     can be modified by mount and remount, but I'm not worried about that).

 (2) When the kernel is locked down, only files with the following criteria
     are permitted to be opened:

	- The file must have mode 00444
	- The file must not have ioctl methods
	- The file must not have mmap

 (3) When the kernel is locked down, files may only be opened for reading.

Normal device interaction should be done through configfs, sysfs or a
miscdev, not debugfs.

Note that this makes it unnecessary to specifically lock down show_dsts(),
show_devs() and show_call() in the asus-wmi driver.

I would actually prefer to lock down all files by default and have the
the files unlocked by the creator.  This is tricky to manage correctly,
though, as there are 19 creation functions and ~1600 call sites (some of
them in loops scanning tables).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: acpi4asus-user@lists.sourceforge.net
cc: platform-driver-x86@vger.kernel.org
cc: Matthew Garrett <mjg59@srcf.ucam.org>
cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 fs/debugfs/file.c            | 30 ++++++++++++++++++++++++++++++
 fs/debugfs/inode.c           | 32 ++++++++++++++++++++++++++++++--
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 4fce1da7db23..f60518f0e3aa 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -19,6 +19,7 @@
 #include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/poll.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -136,6 +137,25 @@ void debugfs_file_put(struct dentry *dentry)
 }
 EXPORT_SYMBOL_GPL(debugfs_file_put);
 
+/*
+ * Only permit access to world-readable files when the kernel is locked down.
+ * We also need to exclude any file that has ways to write or alter it as root
+ * can bypass the permissions check.
+ */
+static bool debugfs_is_locked_down(struct inode *inode,
+				   struct file *filp,
+				   const struct file_operations *real_fops)
+{
+	if ((inode->i_mode & 07777) == 0444 &&
+	    !(filp->f_mode & FMODE_WRITE) &&
+	    !real_fops->unlocked_ioctl &&
+	    !real_fops->compat_ioctl &&
+	    !real_fops->mmap)
+		return false;
+
+	return security_locked_down(LOCKDOWN_DEBUGFS);
+}
+
 static int open_proxy_open(struct inode *inode, struct file *filp)
 {
 	struct dentry *dentry = F_DENTRY(filp);
@@ -147,6 +167,11 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
 		return r == -EIO ? -ENOENT : r;
 
 	real_fops = debugfs_real_fops(filp);
+
+	r = debugfs_is_locked_down(inode, filp, real_fops);
+	if (r)
+		goto out;
+
 	real_fops = fops_get(real_fops);
 	if (!real_fops) {
 		/* Huh? Module did not clean up after itself at exit? */
@@ -272,6 +297,11 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 		return r == -EIO ? -ENOENT : r;
 
 	real_fops = debugfs_real_fops(filp);
+
+	r = debugfs_is_locked_down(inode, filp, real_fops);
+	if (r)
+		goto out;
+
 	real_fops = fops_get(real_fops);
 	if (!real_fops) {
 		/* Huh? Module did not cleanup after itself at exit? */
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 95b5e78c22b1..a53a4748ebc1 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -23,6 +23,7 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -32,6 +33,32 @@ static struct vfsmount *debugfs_mount;
 static int debugfs_mount_count;
 static bool debugfs_registered;
 
+/*
+ * Don't allow access attributes to be changed whilst the kernel is locked down
+ * so that we can use the file mode as part of a heuristic to determine whether
+ * to lock down individual files.
+ */
+static int debugfs_setattr(struct dentry *dentry, struct iattr *ia)
+{
+	int ret = security_locked_down(LOCKDOWN_DEBUGFS);
+
+	if (ret && (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
+		return ret;
+	return simple_setattr(dentry, ia);
+}
+
+static const struct inode_operations debugfs_file_inode_operations = {
+	.setattr	= debugfs_setattr,
+};
+static const struct inode_operations debugfs_dir_inode_operations = {
+	.lookup		= simple_lookup,
+	.setattr	= debugfs_setattr,
+};
+static const struct inode_operations debugfs_symlink_inode_operations = {
+	.get_link	= simple_get_link,
+	.setattr	= debugfs_setattr,
+};
+
 static struct inode *debugfs_get_inode(struct super_block *sb)
 {
 	struct inode *inode = new_inode(sb);
@@ -356,6 +383,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	inode->i_mode = mode;
 	inode->i_private = data;
 
+	inode->i_op = &debugfs_file_inode_operations;
 	inode->i_fop = proxy_fops;
 	dentry->d_fsdata = (void *)((unsigned long)real_fops |
 				DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
@@ -516,7 +544,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 		return failed_creating(dentry);
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
-	inode->i_op = &simple_dir_inode_operations;
+	inode->i_op = &debugfs_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -611,7 +639,7 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 		return failed_creating(dentry);
 	}
 	inode->i_mode = S_IFLNK | S_IRWXUGO;
-	inode->i_op = &simple_symlink_inode_operations;
+	inode->i_op = &debugfs_symlink_inode_operations;
 	inode->i_link = link;
 	d_instantiate(dentry, inode);
 	return end_creating(dentry);
diff --git a/include/linux/security.h b/include/linux/security.h
index 53ea85889a48..097e4b0ce73f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -94,6 +94,7 @@ enum lockdown_reason {
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
+	LOCKDOWN_DEBUGFS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index a7e75c614416..bbcb82985765 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -30,6 +30,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
+	[LOCKDOWN_DEBUGFS] = "debugfs access",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
-- 
2.22.0.410.gd8fdbe21b5-goog

