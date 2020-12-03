Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F2A2CE428
	for <lists+linux-security-module@lfdr.de>; Fri,  4 Dec 2020 01:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502020AbgLDALU (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 3 Dec 2020 19:11:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43147 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgLDALU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Dec 2020 19:11:20 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kkyY9-0007ka-Bg; Fri, 04 Dec 2020 00:02:13 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 32/40] apparmor: handle idmapped mounts
Date:   Fri,  4 Dec 2020 00:57:28 +0100
Message-Id: <20201203235736.3528991-33-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
References: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The i_uid and i_gid are only ever used when logging for AppArmor. This
is already broken in a bunch of places where the global root id is
reported instead of the i_uid or i_gid of the file. Nonetheless, be kind
and log the mapped inode if we're coming from an idmapped mount. If the
initial user namespace is passed nothing changes so non-idmapped mounts
will see identical behavior as before.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged

/* v4 */
- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.
---
 security/apparmor/domain.c |  9 ++++++---
 security/apparmor/file.c   |  5 ++++-
 security/apparmor/lsm.c    | 12 ++++++++----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 16f184bc48de..890aa0b43bab 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -10,12 +10,14 @@
 
 #include <linux/errno.h>
 #include <linux/fdtable.h>
+#include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/mount.h>
 #include <linux/syscalls.h>
 #include <linux/tracehook.h>
 #include <linux/personality.h>
 #include <linux/xattr.h>
+#include <linux/user_namespace.h>
 
 #include "include/audit.h"
 #include "include/apparmorfs.h"
@@ -858,8 +860,10 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
 	const char *info = NULL;
 	int error = 0;
 	bool unsafe = false;
+	struct user_namespace *mnt_userns = mnt_user_ns(bprm->file->f_path.mnt);
+	kuid_t i_uid = i_uid_into_mnt(mnt_userns, file_inode(bprm->file));
 	struct path_cond cond = {
-		file_inode(bprm->file)->i_uid,
+		i_uid,
 		file_inode(bprm->file)->i_mode
 	};
 
@@ -967,8 +971,7 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
 	error = fn_for_each(label, profile,
 			aa_audit_file(profile, &nullperms, OP_EXEC, MAY_EXEC,
 				      bprm->filename, NULL, new,
-				      file_inode(bprm->file)->i_uid, info,
-				      error));
+				      i_uid, info, error));
 	aa_put_label(new);
 	goto done;
 }
diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 92acf9a49405..d70d09a5ce7d 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -11,6 +11,8 @@
 #include <linux/tty.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
 
 #include "include/apparmor.h"
 #include "include/audit.h"
@@ -508,8 +510,9 @@ static int __file_path_perm(const char *op, struct aa_label *label,
 {
 	struct aa_profile *profile;
 	struct aa_perms perms = {};
+	struct user_namespace *mnt_userns = mnt_user_ns(file->f_path.mnt);
 	struct path_cond cond = {
-		.uid = file_inode(file)->i_uid,
+		.uid = i_uid_into_mnt(mnt_userns, file_inode(file)),
 		.mode = file_inode(file)->i_mode
 	};
 	char *buffer;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index ffeaee5ed968..03260983b471 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -224,7 +224,8 @@ static int common_perm(const char *op, const struct path *path, u32 mask,
  */
 static int common_perm_cond(const char *op, const struct path *path, u32 mask)
 {
-	struct path_cond cond = { d_backing_inode(path->dentry)->i_uid,
+	struct user_namespace *mnt_userns = mnt_user_ns(path->mnt);
+	struct path_cond cond = { i_uid_into_mnt(mnt_userns, d_backing_inode(path->dentry)),
 				  d_backing_inode(path->dentry)->i_mode
 	};
 
@@ -266,12 +267,13 @@ static int common_perm_rm(const char *op, const struct path *dir,
 			  struct dentry *dentry, u32 mask)
 {
 	struct inode *inode = d_backing_inode(dentry);
+	struct user_namespace *mnt_userns = mnt_user_ns(dir->mnt);
 	struct path_cond cond = { };
 
 	if (!inode || !path_mediated_fs(dentry))
 		return 0;
 
-	cond.uid = inode->i_uid;
+	cond.uid = i_uid_into_mnt(mnt_userns, inode);
 	cond.mode = inode->i_mode;
 
 	return common_perm_dir_dentry(op, dir, dentry, mask, &cond);
@@ -361,11 +363,12 @@ static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_d
 
 	label = begin_current_label_crit_section();
 	if (!unconfined(label)) {
+		struct user_namespace *mnt_userns = mnt_user_ns(old_dir->mnt);
 		struct path old_path = { .mnt = old_dir->mnt,
 					 .dentry = old_dentry };
 		struct path new_path = { .mnt = new_dir->mnt,
 					 .dentry = new_dentry };
-		struct path_cond cond = { d_backing_inode(old_dentry)->i_uid,
+		struct path_cond cond = { i_uid_into_mnt(mnt_userns, d_backing_inode(old_dentry)),
 					  d_backing_inode(old_dentry)->i_mode
 		};
 
@@ -420,8 +423,9 @@ static int apparmor_file_open(struct file *file)
 
 	label = aa_get_newest_cred_label(file->f_cred);
 	if (!unconfined(label)) {
+		struct user_namespace *mnt_userns = mnt_user_ns(file->f_path.mnt);
 		struct inode *inode = file_inode(file);
-		struct path_cond cond = { inode->i_uid, inode->i_mode };
+		struct path_cond cond = { i_uid_into_mnt(mnt_userns, inode), inode->i_mode };
 
 		error = aa_path_perm(OP_OPEN, label, &file->f_path, 0,
 				     aa_map_file_to_perms(file), &cond);
-- 
2.29.2

