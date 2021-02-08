Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E0E313C18
	for <lists+linux-security-module@lfdr.de>; Mon,  8 Feb 2021 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhBHSBv (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 8 Feb 2021 13:01:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235131AbhBHR7r (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Feb 2021 12:59:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6808464E92;
        Mon,  8 Feb 2021 17:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612807103;
        bh=Ffhyf60erkGDMmC/z5vAbbYWcKe61yWtQ4zdQlyeutA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KxSCwN3u1OpWv+MdIYMb3fDSklkUvJcFuXglYy0SUQY7XHYEAhaeg2aITCg/joQHb
         WLJL+jNRbfXXb0KgayF8Sik0B35YiIZQJ9LvY6z4UwWMgBNk6AZUFRgvIJD2XPPlAq
         jBz+5ie/ssrFo48/lPslcNwdVyPiUS7AZDxQN0x9wRb12n7970OpKptj01FG1NrUWL
         ICLgeGQimV+OLcUsmeWfc+xmrvwaBC76rF6mE3v/bfqV2BGvP4ybNVMbSz/ppy2rjf
         oBAgKfqbmPB6teO6oHHR2bqKQPqJzqFtg9is87gbHrrp5Z8XA8UTYv9B7x8nWo6VSF
         L2rf3mtkeNJlg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 12/36] cap: fix conversions on getxattr
Date:   Mon,  8 Feb 2021 12:57:42 -0500
Message-Id: <20210208175806.2091668-12-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210208175806.2091668-1-sashal@kernel.org>
References: <20210208175806.2091668-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit f2b00be488730522d0fb7a8a5de663febdcefe0a ]

If a capability is stored on disk in v2 format cap_inode_getsecurity() will
currently return in v2 format unconditionally.

This is wrong: v2 cap should be equivalent to a v3 cap with zero rootid,
and so the same conversions performed on it.

If the rootid cannot be mapped, v3 is returned unconverted.  Fix this so
that both v2 and v3 return -EOVERFLOW if the rootid (or the owner of the fs
user namespace in case of v2) cannot be mapped into the current user
namespace.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/commoncap.c | 67 ++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 59bf3c1674c8b..a6c9bb4441d54 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -371,10 +371,11 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 {
 	int size, ret;
 	kuid_t kroot;
+	u32 nsmagic, magic;
 	uid_t root, mappedroot;
 	char *tmpbuf = NULL;
 	struct vfs_cap_data *cap;
-	struct vfs_ns_cap_data *nscap;
+	struct vfs_ns_cap_data *nscap = NULL;
 	struct dentry *dentry;
 	struct user_namespace *fs_ns;
 
@@ -396,46 +397,61 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 	fs_ns = inode->i_sb->s_user_ns;
 	cap = (struct vfs_cap_data *) tmpbuf;
 	if (is_v2header((size_t) ret, cap)) {
-		/* If this is sizeof(vfs_cap_data) then we're ok with the
-		 * on-disk value, so return that.  */
-		if (alloc)
-			*buffer = tmpbuf;
-		else
-			kfree(tmpbuf);
-		return ret;
-	} else if (!is_v3header((size_t) ret, cap)) {
-		kfree(tmpbuf);
-		return -EINVAL;
+		root = 0;
+	} else if (is_v3header((size_t) ret, cap)) {
+		nscap = (struct vfs_ns_cap_data *) tmpbuf;
+		root = le32_to_cpu(nscap->rootid);
+	} else {
+		size = -EINVAL;
+		goto out_free;
 	}
 
-	nscap = (struct vfs_ns_cap_data *) tmpbuf;
-	root = le32_to_cpu(nscap->rootid);
 	kroot = make_kuid(fs_ns, root);
 
 	/* If the root kuid maps to a valid uid in current ns, then return
 	 * this as a nscap. */
 	mappedroot = from_kuid(current_user_ns(), kroot);
 	if (mappedroot != (uid_t)-1 && mappedroot != (uid_t)0) {
+		size = sizeof(struct vfs_ns_cap_data);
 		if (alloc) {
-			*buffer = tmpbuf;
+			if (!nscap) {
+				/* v2 -> v3 conversion */
+				nscap = kzalloc(size, GFP_ATOMIC);
+				if (!nscap) {
+					size = -ENOMEM;
+					goto out_free;
+				}
+				nsmagic = VFS_CAP_REVISION_3;
+				magic = le32_to_cpu(cap->magic_etc);
+				if (magic & VFS_CAP_FLAGS_EFFECTIVE)
+					nsmagic |= VFS_CAP_FLAGS_EFFECTIVE;
+				memcpy(&nscap->data, &cap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
+				nscap->magic_etc = cpu_to_le32(nsmagic);
+			} else {
+				/* use allocated v3 buffer */
+				tmpbuf = NULL;
+			}
 			nscap->rootid = cpu_to_le32(mappedroot);
-		} else
-			kfree(tmpbuf);
-		return size;
+			*buffer = nscap;
+		}
+		goto out_free;
 	}
 
 	if (!rootid_owns_currentns(kroot)) {
-		kfree(tmpbuf);
-		return -EOPNOTSUPP;
+		size = -EOVERFLOW;
+		goto out_free;
 	}
 
 	/* This comes from a parent namespace.  Return as a v2 capability */
 	size = sizeof(struct vfs_cap_data);
 	if (alloc) {
-		*buffer = kmalloc(size, GFP_ATOMIC);
-		if (*buffer) {
-			struct vfs_cap_data *cap = *buffer;
-			__le32 nsmagic, magic;
+		if (nscap) {
+			/* v3 -> v2 conversion */
+			cap = kzalloc(size, GFP_ATOMIC);
+			if (!cap) {
+				size = -ENOMEM;
+				goto out_free;
+			}
 			magic = VFS_CAP_REVISION_2;
 			nsmagic = le32_to_cpu(nscap->magic_etc);
 			if (nsmagic & VFS_CAP_FLAGS_EFFECTIVE)
@@ -443,9 +459,12 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
 			cap->magic_etc = cpu_to_le32(magic);
 		} else {
-			size = -ENOMEM;
+			/* use unconverted v2 */
+			tmpbuf = NULL;
 		}
+		*buffer = cap;
 	}
+out_free:
 	kfree(tmpbuf);
 	return size;
 }
-- 
2.27.0

