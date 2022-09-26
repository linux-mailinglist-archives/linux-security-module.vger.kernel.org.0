Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DC65EAAF0
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Sep 2022 17:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiIZP0L (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 26 Sep 2022 11:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiIZPYL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Sep 2022 11:24:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F6521E19;
        Mon, 26 Sep 2022 07:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D7741CE114D;
        Mon, 26 Sep 2022 14:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FBDC4347C;
        Mon, 26 Sep 2022 14:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201386;
        bh=aar05o0GKlj5qSpKpK91BAhaPuQi2P7Jz1CKbiFrK24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sU2RrOnhjqjIiqa1dUKHTO7+jM6NbQJJyrLOmW3SFgIjBS4eUyplbHJ3pazkRZEXh
         7MfK35DuOolpGIpJDV2G0Ele5bPv0sWOamjJO3DWeWUIX9JD8Iqp2u1DgUijloya5i
         08h8TcD7rzh2KGkrUJNVdkgw3ncV7chHfedtAwH3zh/u3tbMd0RnJucFRTohgL51xW
         1NLxM8+spzlp3eZp8reK8sg7CHFkXQE6EAzCT8PQEijFlhSx3xK7lLjUDUR1Uvf0Yq
         FxaaiOhpTHSv0oHByJpnRI4rxL1/ykcda0Z+UH+wd+ZTd6a8ElD6Of6VtY1ugK0WFl
         89ImsAR320X1Q==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 25/30] xattr: use posix acl api
Date:   Mon, 26 Sep 2022 16:08:22 +0200
Message-Id: <20220926140827.142806-26-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7587; i=brauner@kernel.org; h=from:subject; bh=aar05o0GKlj5qSpKpK91BAhaPuQi2P7Jz1CKbiFrK24=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQbbnLauXujI5NRPlcxf81xU87oN18MC3YbL578mkep+Hf5 P26vjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlsrmP4HyL6NeNsy7k5Ry3P6u68d3 tj5PFo/1aXgvKuCiNWPk+V14wMM/7EZb8xLei9tXD7172nl4uzirVM/NO5RiB1seadBZlr+QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In previous patches we built a new posix api solely around get and set
inode operations. Now that we have all the pieces in place we can switch
the system calls and the vfs over to only rely on this api when
interacting with posix acls. This finally removes all type unsafety and
type conversion issues explained in detail in [1] that we aim to get rid
of.

With the new posix acl api we immediately translate into an appropriate
kernel internal struct posix_acl format both when getting and setting
posix acls. This is a stark contrast to before were we hacked unsafe raw
values into the uapi struct that was stored in a void pointer relying
and having filesystems and security modules hack around in the uapi
struct as well.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged

 fs/internal.h                   |  1 +
 fs/xattr.c                      | 62 ++++++++++++++++++++++++++++-----
 include/linux/posix_acl_xattr.h | 10 ++++--
 io_uring/xattr.c                |  2 ++
 4 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 87e96b9024ce..743a4029cd2e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -206,6 +206,7 @@ struct xattr_ctx {
 		const void __user *cvalue;
 		void __user *value;
 	};
+	struct posix_acl *acl;
 	void *kvalue;
 	size_t size;
 	/* Attribute name */
diff --git a/fs/xattr.c b/fs/xattr.c
index 0b9a84921c4d..b716f7b5858b 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -171,6 +171,9 @@ __vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 {
 	const struct xattr_handler *handler;
 
+	if (is_posix_acl_xattr(name))
+		return -EOPNOTSUPP;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
@@ -392,6 +395,9 @@ __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 {
 	const struct xattr_handler *handler;
 
+	if (is_posix_acl_xattr(name))
+		return -EOPNOTSUPP;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
@@ -464,6 +470,9 @@ __vfs_removexattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	const struct xattr_handler *handler;
 
+	if (is_posix_acl_xattr(name))
+		return -EOPNOTSUPP;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
@@ -573,19 +582,41 @@ int setxattr_copy(const char __user *name, struct xattr_ctx *ctx)
 	return error;
 }
 
-static void setxattr_convert(struct user_namespace *mnt_userns,
-			     struct dentry *d, struct xattr_ctx *ctx)
+static int setxattr_convert(struct user_namespace *mnt_userns, struct dentry *d,
+			    struct xattr_ctx *ctx)
 {
-	if (ctx->size && is_posix_acl_xattr(ctx->kname->name))
-		posix_acl_fix_xattr_from_user(ctx->kvalue, ctx->size);
+	struct posix_acl *acl;
+
+	if (!ctx->size || !is_posix_acl_xattr(ctx->kname->name))
+		return 0;
+
+	/*
+	 * Note that posix_acl_from_xattr() uses GFP_NOFS when it probably
+	 * doesn't need to here.
+	 */
+	acl = posix_acl_from_xattr(current_user_ns(), ctx->kvalue, ctx->size);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+
+	ctx->acl = acl;
+	return 0;
 }
 
 int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct xattr_ctx *ctx)
 {
-	setxattr_convert(mnt_userns, dentry, ctx);
+	int error;
+
+	error = setxattr_convert(mnt_userns, dentry, ctx);
+	if (error)
+		return error;
+
+	if (is_posix_acl_xattr(ctx->kname->name))
+		return vfs_set_acl(mnt_userns, dentry,
+				   ctx->kname->name, ctx->acl);
+
 	return vfs_setxattr(mnt_userns, dentry, ctx->kname->name,
-			ctx->kvalue, ctx->size, ctx->flags);
+			    ctx->kvalue, ctx->size, ctx->flags);
 }
 
 static long
@@ -597,6 +628,7 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
 	struct xattr_ctx ctx = {
 		.cvalue   = value,
 		.kvalue   = NULL,
+		.acl	  = NULL,
 		.size     = size,
 		.kname    = &kname,
 		.flags    = flags,
@@ -610,6 +642,7 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
 	error = do_setxattr(mnt_userns, d, &ctx);
 
 	kvfree(ctx.kvalue);
+	posix_acl_release(ctx.acl);
 	return error;
 }
 
@@ -690,10 +723,18 @@ do_getxattr(struct user_namespace *mnt_userns, struct dentry *d,
 			return -ENOMEM;
 	}
 
-	error = vfs_getxattr(mnt_userns, d, kname, ctx->kvalue, ctx->size);
+	if (is_posix_acl_xattr(ctx->kname->name)) {
+		ctx->acl = vfs_get_acl(mnt_userns, d, ctx->kname->name);
+		if (IS_ERR(ctx->acl))
+			return PTR_ERR(ctx->acl);
+
+		error = vfs_posix_acl_to_xattr(mnt_userns, d_inode(d), ctx->acl,
+					       ctx->kvalue, ctx->size);
+		posix_acl_release(ctx->acl);
+	} else {
+		error = vfs_getxattr(mnt_userns, d, kname, ctx->kvalue, ctx->size);
+	}
 	if (error > 0) {
-		if (is_posix_acl_xattr(kname))
-			posix_acl_fix_xattr_to_user(ctx->kvalue, error);
 		if (ctx->size && copy_to_user(ctx->value, ctx->kvalue, error))
 			error = -EFAULT;
 	} else if (error == -ERANGE && ctx->size >= XATTR_SIZE_MAX) {
@@ -868,6 +909,9 @@ removexattr(struct user_namespace *mnt_userns, struct dentry *d,
 	if (error < 0)
 		return error;
 
+	if (is_posix_acl_xattr(kname))
+		return vfs_remove_acl(mnt_userns, d, kname);
+
 	return vfs_removexattr(mnt_userns, d, kname);
 }
 
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index 3bd8fac436bc..0294b3489a81 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -33,6 +33,8 @@ posix_acl_xattr_count(size_t size)
 }
 
 #ifdef CONFIG_FS_POSIX_ACL
+struct posix_acl *posix_acl_from_xattr(struct user_namespace *user_ns,
+				       const void *value, size_t size);
 void posix_acl_fix_xattr_from_user(void *value, size_t size);
 void posix_acl_fix_xattr_to_user(void *value, size_t size);
 void posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
@@ -42,6 +44,12 @@ ssize_t vfs_posix_acl_to_xattr(struct user_namespace *mnt_userns,
 			       struct inode *inode, const struct posix_acl *acl,
 			       void *buffer, size_t size);
 #else
+static inline struct posix_acl *
+posix_acl_from_xattr(struct user_namespace *user_ns, const void *value,
+		     size_t size)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline void posix_acl_fix_xattr_from_user(void *value, size_t size)
 {
 }
@@ -63,8 +71,6 @@ static inline ssize_t vfs_posix_acl_to_xattr(struct user_namespace *mnt_userns,
 }
 #endif
 
-struct posix_acl *posix_acl_from_xattr(struct user_namespace *user_ns, 
-				       const void *value, size_t size);
 int posix_acl_to_xattr(struct user_namespace *user_ns,
 		       const struct posix_acl *acl, void *buffer, size_t size);
 struct posix_acl *vfs_set_acl_prepare(struct user_namespace *mnt_userns,
diff --git a/io_uring/xattr.c b/io_uring/xattr.c
index 84180afd090b..5b2548649272 100644
--- a/io_uring/xattr.c
+++ b/io_uring/xattr.c
@@ -8,6 +8,7 @@
 #include <linux/namei.h>
 #include <linux/io_uring.h>
 #include <linux/xattr.h>
+#include <linux/posix_acl_xattr.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -31,6 +32,7 @@ void io_xattr_cleanup(struct io_kiocb *req)
 
 	kfree(ix->ctx.kname);
 	kvfree(ix->ctx.kvalue);
+	posix_acl_release(ix->ctx.acl);
 }
 
 static void io_xattr_finish(struct io_kiocb *req, int ret)
-- 
2.34.1

