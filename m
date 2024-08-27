Return-Path: <linux-security-module+bounces-5127-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC69E960163
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Aug 2024 08:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CC87B21AE7
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Aug 2024 06:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E90EAFA;
	Tue, 27 Aug 2024 06:15:56 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2A6EB7C;
	Tue, 27 Aug 2024 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739356; cv=none; b=PGDtp2tVhANL/uniSNpaJ3UDweF3ir5sw87IXOjsrpQkgydcZTNYLTdKDjIyiN2Ac/1QC0K1hkav2DlNBjc/F9w5yNNLXOs7BEsKlEcBHgK/nQ/JRr1p7ZWMbntRELVW9pSD4iN0whvUw/mP6yW+ZTt0aa+MWy7MzzJt2DHIsJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739356; c=relaxed/simple;
	bh=D9zUaxCBuzZr6ZxruF4QX5YWqlsKIWT7R0X+I5mbeqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaHm/llzzpRGvRvBFkzZg4KHnNrqmVRxdQBuPR6O/SXfJtc2U3QBholBrmalGk7HoMGtuS4qmi+c96kweIoiO/RaefjiXbj7C7MDKM3BhKY7i3DvTmR/+Au+hXSiTnJNOSrQ6gXAJ0Yj6/FYX4MZrirAE6bTkotnv38yQO9X7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86cc0d10aaso237035466b.2;
        Mon, 26 Aug 2024 23:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724739352; x=1725344152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvNljt96kZpU7jSZrl60PVpp8KZA3Kt6uHD/i6ntmJg=;
        b=WLzu8RPa9Sky1L63PIAWpY/YZJxJ8B2aJYkKpi1PpJi4R0NS8FM6rghjJobiKfqZBr
         2S79z8+ZTvhJ/4TOEL0lRj3zgEyH9yktT77sDnTKsbgr2QLMW7Ws7b8v838Q3l3IXLxc
         eXhxOInYWqCjBwdR4wZ/wbCBx5+xIehQ5SmJuAaS8HueB2Flk4Tf2RDIFYW7NNknWpqJ
         xPSCTH8PTWhEGoxoDTOk0pXP6mFTUSBIQFrqfcVnkYPaaLzZvJFzK0DLm96FXPfaW4DI
         EUMyDQJ5dfGQZT156uTodmD2idst2gTO1gZF1w2i+C3zY4GZ64s931Um4wOCVZYiO0SM
         fsjw==
X-Forwarded-Encrypted: i=1; AJvYcCUWuUHZhQ4+VW85865c0oxDmcYBpo4nVHwFvJv5HMDQ6RiSa2+rOFvOnVYMYFKQ+C0HFh19TWfr55t9ZGJSZIRUdLJ0KcZP@vger.kernel.org, AJvYcCUzN4nZeObSOQOP/P2s1slAokwVdXjAEne1ZTa5EjKQl5O+b7oI8RPDkTpEdY4cxeWpMVOxEMy3hH9tXP5A@vger.kernel.org, AJvYcCVeQSpxjc9wG1oWDjAUTAZdMZ4cNFHKgCvIfylmNSBD6YwiGYKs4N4FqFheS/ZEl7Io7Vq7XQUhabBOh1rTkA==@vger.kernel.org, AJvYcCXMKj/bPvY4VqNt9HMfBotLw3qbdeF7W/4ei7OXl6uPbq3uPhOTfqvxAuXV1ZO6EHHYnm5Dobn0Cfphw/AcEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmLErEiSqekyMec6fq9LL3xTZxmyorvmcVfSy6sEgQYmdQXyji
	NAUUegk0muKx31UnvIDNn2tKN5PS5JoZRWS7XDzUdvpdZKhdH+lA
X-Google-Smtp-Source: AGHT+IG0Rtb9/QsxoHCkBplulCWks1HbTKU1zgRP3AjIMFphREd2tQE088Sm/ynw7mJupNashM/zQQ==
X-Received: by 2002:a17:907:6e91:b0:a86:3c01:cf08 with SMTP id a640c23a62f3a-a86a548822fmr1013189966b.47.1724739351769;
        Mon, 26 Aug 2024 23:15:51 -0700 (PDT)
Received: from localhost.localdomain (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582d8a3sm66834366b.136.2024.08.26.23.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 23:15:51 -0700 (PDT)
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Date: Tue, 27 Aug 2024 08:15:43 +0200
Message-ID: <20240827061543.1235703-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826085347.1152675-2-mhocko@kernel.org>
References: <20240826085347.1152675-2-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Hocko <mhocko@suse.com>

bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
inode to achieve GFP_NOWAIT semantic while holding locks. If this
allocation fails it will drop locks and use GFP_NOFS allocation context.

We would like to drop PF_MEMALLOC_NORECLAIM because it is really
dangerous to use if the caller doesn't control the full call chain with
this flag set. E.g. if any of the function down the chain needed
GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
cause unexpected failure.

While this is not the case in this particular case using the scoped gfp
semantic is not really needed bacause we can easily pus the allocation
context down the chain without too much clutter.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 fs/bcachefs/fs.c          | 14 ++++++--------
 fs/inode.c                |  6 +++---
 include/linux/fs.h        |  7 ++++++-
 include/linux/lsm_hooks.h |  2 +-
 include/linux/security.h  |  4 ++--
 security/security.c       |  8 ++++----
 6 files changed, 22 insertions(+), 19 deletions(-)

Chancges since v1
- compile errors fixed 
- dropped GFP_NOWARN as it is part of GFP_NOWAIT now

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 15fc41e63b6c..d151a2f28d12 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -231,9 +231,9 @@ static struct inode *bch2_alloc_inode(struct super_block *sb)
 	BUG();
 }
 
-static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
+static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c, gfp_t gfp)
 {
-	struct bch_inode_info *inode = kmem_cache_alloc(bch2_inode_cache, GFP_NOFS);
+	struct bch_inode_info *inode = kmem_cache_alloc(bch2_inode_cache, gfp);
 	if (!inode)
 		return NULL;
 
@@ -245,7 +245,7 @@ static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
 	mutex_init(&inode->ei_quota_lock);
 	memset(&inode->ei_devs_need_flush, 0, sizeof(inode->ei_devs_need_flush));
 
-	if (unlikely(inode_init_always(c->vfs_sb, &inode->v))) {
+	if (unlikely(inode_init_always_gfp(c->vfs_sb, &inode->v, gfp))) {
 		kmem_cache_free(bch2_inode_cache, inode);
 		return NULL;
 	}
@@ -258,12 +258,10 @@ static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
  */
 static struct bch_inode_info *bch2_new_inode(struct btree_trans *trans)
 {
-	struct bch_inode_info *inode =
-		memalloc_flags_do(PF_MEMALLOC_NORECLAIM|PF_MEMALLOC_NOWARN,
-				  __bch2_new_inode(trans->c));
+	struct bch_inode_info *inode = __bch2_new_inode(trans->c, GFP_NOWAIT);
 
 	if (unlikely(!inode)) {
-		int ret = drop_locks_do(trans, (inode = __bch2_new_inode(trans->c)) ? 0 : -ENOMEM);
+		int ret = drop_locks_do(trans, (inode = __bch2_new_inode(trans->c, GFP_NOFS)) ? 0 : -ENOMEM);
 		if (ret && inode) {
 			__destroy_inode(&inode->v);
 			kmem_cache_free(bch2_inode_cache, inode);
@@ -328,7 +326,7 @@ __bch2_create(struct mnt_idmap *idmap,
 	if (ret)
 		return ERR_PTR(ret);
 #endif
-	inode = __bch2_new_inode(c);
+	inode = __bch2_new_inode(c, GFP_NOFS);
 	if (unlikely(!inode)) {
 		inode = ERR_PTR(-ENOMEM);
 		goto err;
diff --git a/fs/inode.c b/fs/inode.c
index 86670941884b..a2aabbcffbe4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -153,7 +153,7 @@ static int no_open(struct inode *inode, struct file *file)
  * These are initializations that need to be done on every inode
  * allocation as the fields are not initialised by slab allocation.
  */
-int inode_init_always(struct super_block *sb, struct inode *inode)
+int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp)
 {
 	static const struct inode_operations empty_iops;
 	static const struct file_operations no_open_fops = {.open = no_open};
@@ -230,14 +230,14 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 #endif
 	inode->i_flctx = NULL;
 
-	if (unlikely(security_inode_alloc(inode)))
+	if (unlikely(security_inode_alloc(inode, gfp)))
 		return -ENOMEM;
 
 	this_cpu_inc(nr_inodes);
 
 	return 0;
 }
-EXPORT_SYMBOL(inode_init_always);
+EXPORT_SYMBOL(inode_init_always_gfp);
 
 void free_inode_nonrcu(struct inode *inode)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..d46ca71a7855 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3027,7 +3027,12 @@ extern loff_t default_llseek(struct file *file, loff_t offset, int whence);
 
 extern loff_t vfs_llseek(struct file *file, loff_t offset, int whence);
 
-extern int inode_init_always(struct super_block *, struct inode *);
+extern int inode_init_always_gfp(struct super_block *, struct inode *, gfp_t);
+static inline int inode_init_always(struct super_block *sb, struct inode *inode)
+{
+	return inode_init_always_gfp(sb, inode, GFP_NOFS);
+}
+
 extern void inode_init_once(struct inode *);
 extern void address_space_init_once(struct address_space *mapping);
 extern struct inode * igrab(struct inode *);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a2ade0ffe9e7..b08472d64765 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -150,6 +150,6 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 		__used __section(".early_lsm_info.init")		\
 		__aligned(sizeof(unsigned long))
 
-extern int lsm_inode_alloc(struct inode *inode);
+extern int lsm_inode_alloc(struct inode *inode, gfp_t gfp);
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 1390f1efb4f0..7c6b9b038a0d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -336,7 +336,7 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct cred *new);
 int security_path_notify(const struct path *path, u64 mask,
 					unsigned int obj_type);
-int security_inode_alloc(struct inode *inode);
+int security_inode_alloc(struct inode *inode, gfp_t gfp);
 void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
@@ -769,7 +769,7 @@ static inline int security_path_notify(const struct path *path, u64 mask,
 	return 0;
 }
 
-static inline int security_inode_alloc(struct inode *inode)
+static inline int security_inode_alloc(struct inode *inode, gfp_t gfp)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 8cee5b6c6e6d..3581262da5ee 100644
--- a/security/security.c
+++ b/security/security.c
@@ -660,14 +660,14 @@ static int lsm_file_alloc(struct file *file)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-int lsm_inode_alloc(struct inode *inode)
+int lsm_inode_alloc(struct inode *inode, gfp_t gfp)
 {
 	if (!lsm_inode_cache) {
 		inode->i_security = NULL;
 		return 0;
 	}
 
-	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, GFP_NOFS);
+	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, gfp);
 	if (inode->i_security == NULL)
 		return -ENOMEM;
 	return 0;
@@ -1582,9 +1582,9 @@ int security_path_notify(const struct path *path, u64 mask,
  *
  * Return: Return 0 if operation was successful.
  */
-int security_inode_alloc(struct inode *inode)
+int security_inode_alloc(struct inode *inode, gfp_t gfp)
 {
-	int rc = lsm_inode_alloc(inode);
+	int rc = lsm_inode_alloc(inode, gfp);
 
 	if (unlikely(rc))
 		return rc;
-- 
2.46.0


