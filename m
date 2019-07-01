Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 987444F27E
	for <lists+linux-security-module@lfdr.de>; Sat, 22 Jun 2019 02:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfFVAF7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Jun 2019 20:05:59 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:56016 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfFVAFL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 20:05:11 -0400
Received: by mail-ua1-f73.google.com with SMTP id 64so835714uam.22
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 17:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vGiJX2dzGpRjKnSoPZuNXcbny7AXv1yeygEILRT0AgM=;
        b=M+yvWlVg838ieNk95p+zBJNfOoHWV7pAhQqEfOasMxIjU5AlCrrufTghlxQyJRvIHh
         /e/mbjb9MlfxgI85vtxi0tFAnxsQcMIELEqigGfx9grIoyftf0D6jJ8K0PeOcBWt12qK
         7gopx57BfzdPQvTrAAB/jFXuaJlTZHE1q8sMm9sESMCsBt3eHscb3q+T2qUpNkKr7oNl
         iOu2GoEo1PAIZHFWr2Qu4UbzshGwTE4ZQCPARy22UpDqfVKMmaBpzg2cE1mOLV5tyiQp
         3HpmLVX5YIhLZObEB8OKFCXpMNpBdmcXHX0ObAYluer0m9wf5mbeYqoDV+N/DxbkjWmE
         F8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vGiJX2dzGpRjKnSoPZuNXcbny7AXv1yeygEILRT0AgM=;
        b=JC33n4Kv0FywFD0iwtHWNpWj+Oc6SYh2EuNqrCiI36M7TOhSAloU/7L+IU/FcxEuZ2
         DOO1JVM+7l2z6K39BKRVpCBK6JZ5bHAnmTFYZQYVeXwm2seEnNYHI9HXYYUM7c2d5VI5
         tMAGMZZsdjRh0b2JGK2fsj+TRyuy+rLJSIIzghxMrf1kCD50feEzMl8PIMqZhb4XHlF0
         B5XYcHAj025/UQwQOiwhBNbiKUuAnxb+yIZDsrNUt17OVl3lOVPtFcCY6fgamW6fehE3
         +zIxZHIZrZtwO5CSW18iK4IyPx+mXELLonV6uhWZkntBanp0rM/FDSV74BamerNrR6kL
         B8HA==
X-Gm-Message-State: APjAAAXz6282C6NscwpCf6QBz9sxzyipxkfMGZPwHex7sFJCJ2Y0ms5z
        Thf5cJKq2fUNzSpfEd+D1ckHJQXJkklHUMX6vAmRRg==
X-Google-Smtp-Source: APXvYqw/pvxQaFdDMQtY04lRVC8VYuuM0nEYIOrpUDP5Rh91YLRRYn4he0ZQF4KpanOJ1Qljojzah+bdHObjfpcOKvc2Ew==
X-Received: by 2002:a1f:f282:: with SMTP id q124mr10671272vkh.4.1561161909677;
 Fri, 21 Jun 2019 17:05:09 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:56 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-28-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 27/29] tracefs: Restrict tracefs when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Tracefs may release more information about the kernel than desirable, so
restrict it when the kernel is locked down in confidentiality mode by
preventing open().

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 fs/tracefs/inode.c           | 43 +++++++++++++++++++++++++++++++++++-
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7098c49f3693..487d41f234f8 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -24,6 +24,7 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 
 #define TRACEFS_DEFAULT_MODE	0700
 
@@ -31,6 +32,23 @@ static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
+static int default_open_file(struct inode *inode, struct file *filp)
+{
+	struct dentry *dentry = filp->f_path.dentry;
+	struct file_operations *real_fops;
+	int ret;
+
+	if (!dentry)
+		return -EINVAL;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	real_fops = dentry->d_fsdata;
+	return real_fops->open(inode, filp);
+}
+
 static ssize_t default_read_file(struct file *file, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
@@ -50,6 +68,13 @@ static const struct file_operations tracefs_file_operations = {
 	.llseek =	noop_llseek,
 };
 
+static const struct file_operations tracefs_proxy_file_operations = {
+	.read =		default_read_file,
+	.write =	default_write_file,
+	.open =		default_open_file,
+	.llseek =	noop_llseek,
+};
+
 static struct tracefs_dir_ops {
 	int (*mkdir)(const char *name);
 	int (*rmdir)(const char *name);
@@ -225,6 +250,12 @@ static int tracefs_apply_options(struct super_block *sb)
 	return 0;
 }
 
+static void tracefs_destroy_inode(struct inode *inode)
+{
+	if (S_ISREG(inode->i_mode))
+		kfree(inode->i_fop);
+}
+
 static int tracefs_remount(struct super_block *sb, int *flags, char *data)
 {
 	int err;
@@ -260,6 +291,7 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 
 static const struct super_operations tracefs_super_operations = {
 	.statfs		= simple_statfs,
+	.destroy_inode  = tracefs_destroy_inode,
 	.remount_fs	= tracefs_remount,
 	.show_options	= tracefs_show_options,
 };
@@ -393,6 +425,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 {
 	struct dentry *dentry;
 	struct inode *inode;
+	struct file_operations *proxy_fops;
 
 	if (!(mode & S_IFMT))
 		mode |= S_IFREG;
@@ -406,8 +439,16 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
+	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
+	if (!proxy_fops)
+		return failed_creating(dentry);
+
+	dentry->d_fsdata = fops ? (void *)fops :
+		(void *)&tracefs_file_operations;
+	memcpy(proxy_fops, dentry->d_fsdata, sizeof(struct file_operations));
+	proxy_fops->open = default_open_file;
 	inode->i_mode = mode;
-	inode->i_fop = fops ? fops : &tracefs_file_operations;
+	inode->i_fop = proxy_fops;
 	inode->i_private = data;
 	d_instantiate(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
diff --git a/include/linux/security.h b/include/linux/security.h
index 097e4b0ce73f..438dc0892b96 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -100,6 +100,7 @@ enum lockdown_reason {
 	LOCKDOWN_KPROBES,
 	LOCKDOWN_BPF_READ,
 	LOCKDOWN_PERF,
+	LOCKDOWN_TRACEFS,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index bbcb82985765..98f9ee0026d5 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -36,6 +36,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
 	[LOCKDOWN_PERF] = "unsafe use of perf",
+	[LOCKDOWN_TRACEFS] = "use of tracefs",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.410.gd8fdbe21b5-goog

