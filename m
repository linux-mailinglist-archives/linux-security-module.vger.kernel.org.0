Return-Path: <linux-security-module+bounces-108-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFF57FBFBE
	for <lists+linux-security-module@lfdr.de>; Tue, 28 Nov 2023 17:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27241C2094F
	for <lists+linux-security-module@lfdr.de>; Tue, 28 Nov 2023 16:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8255D4B8
	for <lists+linux-security-module@lfdr.de>; Tue, 28 Nov 2023 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hm4t8eX0"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3642C1BE
	for <linux-security-module@vger.kernel.org>; Tue, 28 Nov 2023 08:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701187431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHWP4CgGMGQMa05oAicwuViSFvoHVKUifmpkz3RoaX8=;
	b=hm4t8eX0SYs9uilE31HsArpVenKn84AeoEtlfjU6inIgCCONA59ycfvweR8CuBmumyCobK
	pJWjzSHl7bovtBXFt3lC8viEo1hs7ZM0xG0K5Rw5f0PG2wb03IIEDfUPF9g91ndSvDigfG
	HL3FPFHVYqMVuK9ES43hk+ze84HWWJo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-7SCx4CGFP-eZbXGBfcnbDw-1; Tue, 28 Nov 2023 11:03:50 -0500
X-MC-Unique: 7SCx4CGFP-eZbXGBfcnbDw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b4c9c3cffso5312415e9.2
        for <linux-security-module@vger.kernel.org>; Tue, 28 Nov 2023 08:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187427; x=1701792227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHWP4CgGMGQMa05oAicwuViSFvoHVKUifmpkz3RoaX8=;
        b=KfVcAJngXt61BKJa+/VnTYBkXK+AX8Q6Fc4y8tL6xrzwwb9OBBf5/Dfk8ya4czsce8
         BdZ8mnwbZK1UIW/vgsPI2bkqikF6ETmziOqR/zzU55ojzy7vtGckQvldNwKXE5WMFKOd
         C9ePabVOwYe/hXt3Gj5PZDny5o4wAVSIbPiM57bU6sHOs50G1ymslVuzTeOOH13AfmBy
         E0GTKi6ZQWiIRRcSRBFHGYtgGADvcZNlwTZSo8b4flOPeu60DHw8sKshW8kxtezoaTRp
         fnOSeBWMCk/Q5Jz0iMyErtb7sHh62RwBkpQfE6OcNG6Ampg9HQNGjHUKTkjYwMX9mErD
         5Ufw==
X-Gm-Message-State: AOJu0YzxICWJ3uOwOZjY7tMzCJjCHcOf5MXrPVm2vMvjQ98jeDz+saml
	PxJjZ1t7IBe40aW5hi36am4vaReje8nERaB9/u2yuC4eqdbvIdcqFQI0fIZWuHXKurfEhKF4jxg
	cbqABi/bpPiq6n0XkeZGdnBPIm9QddcpxGN7M
X-Received: by 2002:a5d:6346:0:b0:332:f3c9:1c8b with SMTP id b6-20020a5d6346000000b00332f3c91c8bmr6888830wrw.35.1701187427192;
        Tue, 28 Nov 2023 08:03:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeAuJxAOs5c/9tnwUokFzgY0Drl2v1Y2ITVtVNS8ZYHkGucf8lZeJyedz1R9kZoZu7mu1PWg==
X-Received: by 2002:a5d:6346:0:b0:332:f3c9:1c8b with SMTP id b6-20020a5d6346000000b00332f3c91c8bmr6888808wrw.35.1701187426874;
        Tue, 28 Nov 2023 08:03:46 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (89-148-117-163.pool.digikabel.hu. [89.148.117.163])
        by smtp.gmail.com with ESMTPSA id w27-20020adf8bdb000000b00332e5624a31sm14745352wra.84.2023.11.28.08.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:03:45 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/4] listmount: list mounts in ID order
Date: Tue, 28 Nov 2023 17:03:33 +0100
Message-ID: <20231128160337.29094-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128160337.29094-1-mszeredi@redhat.com>
References: <20231128160337.29094-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This is needed to allow continuing from a midpoint.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9b4cb25c25ed..ad62cf7ee334 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1010,7 +1010,7 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
 
 static inline struct mount *node_to_mount(struct rb_node *node)
 {
-	return rb_entry(node, struct mount, mnt_node);
+	return node ? rb_entry(node, struct mount, mnt_node) : NULL;
 }
 
 static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
@@ -4999,24 +4999,21 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	return ret;
 }
 
-static struct mount *listmnt_first(struct mount *root)
+static struct mount *listmnt_next(struct mount *curr)
 {
-	return list_first_entry_or_null(&root->mnt_mounts, struct mount, mnt_child);
+	return node_to_mount(rb_next(&curr->mnt_node));
 }
 
-static struct mount *listmnt_next(struct mount *curr, struct mount *root)
-{
-	return next_mnt(curr, root);
-}
-
-static ssize_t do_listmount(struct vfsmount *mnt, u64 __user *buf,
-			    size_t bufsize, const struct path *root)
+static ssize_t do_listmount(struct mount *first, struct vfsmount *mnt,
+			    u64 __user *buf, size_t bufsize,
+			    const struct path *root)
 {
 	struct mount *r, *m = real_mount(mnt);
 	struct path rootmnt = {
 		.mnt = root->mnt,
 		.dentry = root->mnt->mnt_root
 	};
+	struct path orig;
 	ssize_t ctr;
 	int err;
 
@@ -5027,8 +5024,17 @@ static ssize_t do_listmount(struct vfsmount *mnt, u64 __user *buf,
 	if (err)
 		return err;
 
-	for (ctr = 0, r = listmnt_first(m); r; r = listmnt_next(r, m)) {
-		if (!is_path_reachable(r, r->mnt.mnt_root, root))
+	if (root->mnt == mnt) {
+		orig = *root;
+	} else {
+		orig.mnt = mnt;
+		orig.dentry = mnt->mnt_root;
+	}
+
+	for (ctr = 0, r = first; r; r = listmnt_next(r)) {
+		if (r == m)
+			continue;
+		if (!is_path_reachable(r, r->mnt.mnt_root, &orig))
 			continue;
 
 		if (ctr >= bufsize)
@@ -5045,8 +5051,10 @@ static ssize_t do_listmount(struct vfsmount *mnt, u64 __user *buf,
 SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 		u64 __user *, buf, size_t, bufsize, unsigned int, flags)
 {
+	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct mnt_id_req kreq;
 	struct vfsmount *mnt;
+	struct mount *first;
 	struct path root;
 	u64 mnt_id;
 	ssize_t ret;
@@ -5066,11 +5074,13 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 		mnt = root.mnt;
 	} else {
 		ret = -ENOENT;
-		mnt = lookup_mnt_in_ns(mnt_id, current->nsproxy->mnt_ns);
+		mnt  = lookup_mnt_in_ns(mnt_id, ns);
 		if (!mnt)
 			goto err;
 	}
-	ret = do_listmount(mnt, buf, bufsize, &root);
+	first = node_to_mount(rb_first(&ns->mounts));
+
+	ret = do_listmount(first, mnt, buf, bufsize, &root);
 err:
 	path_put(&root);
 	up_read(&namespace_sem);
-- 
2.41.0


