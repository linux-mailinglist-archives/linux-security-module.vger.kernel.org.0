Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BCC5EE181
	for <lists+linux-security-module@lfdr.de>; Wed, 28 Sep 2022 18:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiI1QPj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 28 Sep 2022 12:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiI1QNr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 28 Sep 2022 12:13:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBF79751C;
        Wed, 28 Sep 2022 09:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7678E61ED7;
        Wed, 28 Sep 2022 16:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3A4C433D6;
        Wed, 28 Sep 2022 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664381623;
        bh=CSwykYpnb7QGEnPpcpcyn7tcINBPr/2/Qt9Br4egGvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPL00wnfwRIWqc3i0yAILwQUWbFI9i5TAbLOptsN7Twsj7TqOB2IzQyv1FU3wn+Fc
         5a9GgHctxVrrCLrpT4crEDrEtkm4/kw2FAGxrSgo9EkDda1WWXmu1k3/ei6kwB+JgL
         Bb11mSwatpo5c2JlhjHeg836ZtIl0yB3Kda6ExuYfYv4qvpmC6ep0aXnUW2tl0RDWC
         OzgVi/IkZPCDJR2HaoZptPf+6v5xjo26sQjSFmBbxsZEr1+DUpoLpZN1SdDOxNwc/3
         DEhdNB+OEdXyyQBn19ccX9gvA+YAJcvwYldNU8HGcPrf2WfVowf3tufQUbApLP6NWG
         tJm9mtLBwtvWg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 21/29] ovl: implement set acl method
Date:   Wed, 28 Sep 2022 18:08:35 +0200
Message-Id: <20220928160843.382601-22-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928160843.382601-1-brauner@kernel.org>
References: <20220928160843.382601-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7731; i=brauner@kernel.org; h=from:subject; bh=CSwykYpnb7QGEnPpcpcyn7tcINBPr/2/Qt9Br4egGvQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSbFNbpT1n5yepG9gyD3ueLF139P2tRzLOs/ZzLry0+Ff2z e0JwXUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEjnMzMhw9wLihPNJG4WXRZr0DMl 7/6jxW/px3USPm3lO5PUeuXOdm+Kex/qeEoYbZs6dWPv9PfrfjqWAKvWqk3je9+ZT1xJuV93gA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The current way of setting and getting posix acls through the generic
xattr interface is error prone and type unsafe. The vfs needs to
interpret and fixup posix acls before storing or reporting it to
userspace. Various hacks exist to make this work. The code is hard to
understand and difficult to maintain in it's current form. Instead of
making this work by hacking posix acls through xattr handlers we are
building a dedicated posix acl api around the get and set inode
operations. This removes a lot of hackiness and makes the codepaths
easier to maintain. A lot of background can be found in [1].

In order to build a type safe posix api around get and set acl we need
all filesystem to implement get and set acl.

Now that we have added get and set acl inode operations that allow easy
access to the dentry we give overlayfs it's own get and set acl inode
operations.

The set acl inode operation is duplicates most of the ovl posix acl
xattr handler. The main difference being that the set acl inode
operation relies on the new posix acl api. Once the vfs has been
switched over the custom posix acl xattr handler will be removed
completely.

Note, until the vfs has been switched to the new posix acl api this
patch is a non-functional change.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    Miklos Szeredi <miklos@szeredi.hu>:
    - split ovl_set_acl() into two functions
    - add comment about checking whether copy up is even necessary
    
    /* v3 */
    unchanged

 fs/overlayfs/dir.c       |  1 +
 fs/overlayfs/inode.c     | 94 ++++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/overlayfs.h | 17 ++++++++
 3 files changed, 112 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index eb49d5d7b56f..0e817ebce92c 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1313,6 +1313,7 @@ const struct inode_operations ovl_dir_inode_operations = {
 	.listxattr	= ovl_listxattr,
 	.get_inode_acl	= ovl_get_inode_acl,
 	.get_acl	= ovl_get_acl,
+	.set_acl	= ovl_set_acl,
 	.update_time	= ovl_update_time,
 	.fileattr_get	= ovl_fileattr_get,
 	.fileattr_set	= ovl_fileattr_set,
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index fed72225ebe1..fc4c2d821343 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -594,6 +594,98 @@ struct posix_acl *ovl_get_acl(struct user_namespace *mnt_userns,
 	revert_creds(old_cred);
 	return acl;
 }
+
+static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
+				 struct posix_acl *acl, int type)
+{
+	int err;
+	struct path realpath;
+	const char *acl_name;
+	const struct cred *old_cred;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
+	struct dentry *upperdentry = ovl_dentry_upper(dentry);
+	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
+
+	err = ovl_want_write(dentry);
+	if (err)
+		return err;
+
+	/*
+	 * If ACL is to be removed from a lower file, check if it exists in
+	 * the first place before copying it up.
+	 */
+	acl_name = posix_acl_xattr_name(type);
+	if (!acl && !upperdentry) {
+		struct posix_acl *real_acl;
+
+		ovl_path_lower(dentry, &realpath);
+		old_cred = ovl_override_creds(dentry->d_sb);
+		real_acl = vfs_get_acl(mnt_user_ns(realpath.mnt), realdentry,
+				       acl_name);
+		revert_creds(old_cred);
+		posix_acl_release(real_acl);
+		if (IS_ERR(real_acl)) {
+			err = PTR_ERR(real_acl);
+			goto out_drop_write;
+		}
+	}
+
+	if (!upperdentry) {
+		err = ovl_copy_up(dentry);
+		if (err)
+			goto out_drop_write;
+
+		realdentry = ovl_dentry_upper(dentry);
+	}
+
+	old_cred = ovl_override_creds(dentry->d_sb);
+	if (acl)
+		err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
+	else
+		err = ovl_do_remove_acl(ofs, realdentry, acl_name);
+	revert_creds(old_cred);
+
+	/* copy c/mtime */
+	ovl_copyattr(inode);
+
+out_drop_write:
+	ovl_drop_write(dentry);
+	return err;
+}
+
+int ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		struct posix_acl *acl, int type)
+{
+	int err;
+	struct inode *inode = d_inode(dentry);
+	struct dentry *workdir = ovl_workdir(dentry);
+	struct inode *realinode = ovl_inode_real(inode);
+
+	if (!IS_POSIXACL(d_inode(workdir)))
+		return -EOPNOTSUPP;
+	if (!realinode->i_op->set_acl)
+		return -EOPNOTSUPP;
+	if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
+		return acl ? -EACCES : 0;
+	if (!inode_owner_or_capable(&init_user_ns, inode))
+		return -EPERM;
+
+	/*
+	 * Check if sgid bit needs to be cleared (actual setacl operation will
+	 * be done with mounter's capabilities and so that won't do it for us).
+	 */
+	if (unlikely(inode->i_mode & S_ISGID) && type == ACL_TYPE_ACCESS &&
+	    !in_group_p(inode->i_gid) &&
+	    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID)) {
+		struct iattr iattr = { .ia_valid = ATTR_KILL_SGID };
+
+		err = ovl_setattr(&init_user_ns, dentry, &iattr);
+		if (err)
+			return err;
+	}
+
+	return ovl_set_or_remove_acl(dentry, inode, acl, type);
+}
 #endif
 
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
@@ -770,6 +862,7 @@ static const struct inode_operations ovl_file_inode_operations = {
 	.listxattr	= ovl_listxattr,
 	.get_inode_acl	= ovl_get_inode_acl,
 	.get_acl	= ovl_get_acl,
+	.set_acl	= ovl_set_acl,
 	.update_time	= ovl_update_time,
 	.fiemap		= ovl_fiemap,
 	.fileattr_get	= ovl_fileattr_get,
@@ -791,6 +884,7 @@ static const struct inode_operations ovl_special_inode_operations = {
 	.listxattr	= ovl_listxattr,
 	.get_inode_acl	= ovl_get_inode_acl,
 	.get_acl	= ovl_get_acl,
+	.set_acl	= ovl_set_acl,
 	.update_time	= ovl_update_time,
 };
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 68a3030332e9..b2645baeba2f 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -8,6 +8,8 @@
 #include <linux/uuid.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
+#include <linux/posix_acl.h>
+#include <linux/posix_acl_xattr.h>
 #include "ovl_entry.h"
 
 #undef pr_fmt
@@ -278,6 +280,18 @@ static inline int ovl_removexattr(struct ovl_fs *ofs, struct dentry *dentry,
 	return ovl_do_removexattr(ofs, dentry, ovl_xattr(ofs, ox));
 }
 
+static inline int ovl_do_set_acl(struct ovl_fs *ofs, struct dentry *dentry,
+				 const char *acl_name, struct posix_acl *acl)
+{
+	return vfs_set_acl(ovl_upper_mnt_userns(ofs), dentry, acl_name, acl);
+}
+
+static inline int ovl_do_remove_acl(struct ovl_fs *ofs, struct dentry *dentry,
+				    const char *acl_name)
+{
+	return vfs_remove_acl(ovl_upper_mnt_userns(ofs), dentry, acl_name);
+}
+
 static inline int ovl_do_rename(struct ovl_fs *ofs, struct inode *olddir,
 				struct dentry *olddentry, struct inode *newdir,
 				struct dentry *newdentry, unsigned int flags)
@@ -595,12 +609,15 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
 struct posix_acl *ovl_get_inode_acl(struct inode *inode, int type, bool rcu);
 struct posix_acl *ovl_get_acl(struct user_namespace *mnt_userns,
 			      struct dentry *dentry, int type);
+int ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		struct posix_acl *acl, int type);
 void ovl_idmap_posix_acl(struct inode *realinode,
 			 struct user_namespace *mnt_userns,
 			 struct posix_acl *acl);
 #else
 #define ovl_get_inode_acl	NULL
 #define ovl_get_acl		NULL
+#define ovl_set_acl		NULL
 #endif
 
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
-- 
2.34.1

