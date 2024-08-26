Return-Path: <linux-security-module+bounces-5047-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE2D95EEEB
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Aug 2024 12:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CD01F23447
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Aug 2024 10:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5886817839C;
	Mon, 26 Aug 2024 10:50:35 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B5615DBBA;
	Mon, 26 Aug 2024 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669435; cv=none; b=m/JzPnEZx5ep1yKiGh2YOZy0sUdrODuTHjHdqdVdVWomOWdAI9vRA5D9cLt9t8TH/olH8KzZgVVulsa3f1ygG+DkvUEiAPT7zpKzFwS3JU9no0NHIbS4n5ClhiaXVj+1fJHRsSTC7/aEkW9wFHqLVc1ULSKKrbNhZ1o1nTpIEqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669435; c=relaxed/simple;
	bh=vnX/pFmg+ITdvFyGXRGzoQFPJehSyw0HieAGNhxqhgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMNOoRsyGtUXdn4tHXuZ+GtZbT7Z3cDMDoKQ1dU4e98TvexsL9DHxTGBlcg6BjaNVZ1W2rIJ/oEeOqVbL7uzxjrbJmo5L1bndeQ1IjU5hiJbDwrjSsC7B1jOd+EPOlB+RyanTRYAWDNTPXNAEnJtiQUIsH+vEJCO3Ly6RxJ1Bdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjellic.com
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
	by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 47QAbV2Y003441;
	Mon, 26 Aug 2024 05:37:31 -0500
Received: (from greg@localhost)
	by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 47QAbVDc003440;
	Mon, 26 Aug 2024 05:37:31 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From: Greg Wettstein <greg@enjellic.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: [PATCH v4 10/14] Implement security event mapping.
Date: Mon, 26 Aug 2024 05:37:24 -0500
Message-Id: <20240826103728.3378-11-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240826103728.3378-1-greg@enjellic.com>
References: <20240826103728.3378-1-greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The map.c file is responsible for implenting the description of a
security event into a security state coefficient.  The following
documentation file, provided with the TSEM implementation,
contains a description of the generative functions used to create
the coefficients.

Documentation/admin-guide/LSM/tsem.rst

The mapping process takes a security event description, that was
packaged by the event.c file, and uses that description to drive
the coefficient generation process.

How the parameters are mapped into the coefficients is
responsible for implementing the security model enforced by the
internal Trusted Modeling Agent implementation.
---
 security/tsem/map.c | 1536 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1536 insertions(+)
 create mode 100644 security/tsem/map.c

diff --git a/security/tsem/map.c b/security/tsem/map.c
new file mode 100644
index 000000000000..6a72b9567b99
--- /dev/null
+++ b/security/tsem/map.c
@@ -0,0 +1,1536 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2024 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * This file is responsible for mapping the characteristics of
+ * security events into a security state coefficient for the internal
+ * trusted modeling agent implementation.  The primary TSEM
+ * documentation describes the generative functions that are used to
+ * conduct this mapping.
+ *
+ * The tsem_map_event() function is called by the tsem_model_event()
+ * to generate the security state coefficients for the internal
+ * modeling implementation.
+ *
+ * The other major role of this file is to provide the tsem_map_task()
+ * function that is used to generate the TASK_ID for a process.  This
+ * function is called from the tsem_bprm_committed_creds() function.
+ */
+
+#include <linux/magic.h>
+#include <uapi/linux/prctl.h>
+
+#include "tsem.h"
+
+static int add_u16(struct shash_desc *shash, u16 value)
+{
+	return crypto_shash_update(shash, (char *) &value, sizeof(value));
+}
+
+static int add_u32(struct shash_desc *shash, u32 value)
+{
+	return crypto_shash_update(shash, (char *) &value, sizeof(value));
+}
+
+static int add_u64(struct shash_desc *shash, u64 value)
+{
+	return crypto_shash_update(shash, (char *) &value, sizeof(value));
+}
+
+static int add_str(struct shash_desc *shash, char *str)
+{
+	u32 value;
+	u8 *p;
+	int retn;
+	int size;
+
+	p = (u8 *) &value;
+	value = strlen(str);
+	size = sizeof(value);
+	retn = crypto_shash_update(shash, p, size);
+	if (retn)
+		goto done;
+
+	p = (u8 *) str;
+	size = strlen(str);
+	retn = crypto_shash_update(shash, p, size);
+
+ done:
+	return retn;
+}
+
+static int get_COE_mapping(struct tsem_event *ep, u8 *mapping)
+{
+	int retn = 0;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tsem_digest();
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, ep->COE.uid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, ep->COE.euid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, ep->COE.suid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, ep->COE.gid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, ep->COE.egid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, ep->COE.sgid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, ep->COE.fsuid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, ep->COE.fsgid);
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, ep->COE.capeff.value);
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_final(shash, mapping);
+
+ done:
+	return retn;
+}
+
+static int add_temp_path(struct shash_desc *shash, char *pathname,
+			 u64 instance, u8 *owner)
+{
+	char *p, ch = '\0';
+	int retn;
+
+	p = strrchr(pathname, '/');
+	if (!p)
+		return -EINVAL;
+
+	++p;
+	ch = *p;
+	if (ch)
+		*p = '\0';
+	retn = add_str(shash, pathname);
+	if (ch)
+		*p = ch;
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, instance);
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_update(shash, owner, tsem_digestsize());
+
+ done:
+	return retn;
+}
+
+static int add_path(struct shash_desc *shash, struct tsem_path *path)
+{
+	int retn;
+
+	if (path->dev) {
+		retn = add_u32(shash, MAJOR(path->dev));
+		if (retn)
+			goto done;
+		retn = add_u32(shash, MINOR(path->dev));
+		if (retn)
+			goto done;
+	}
+
+	if (path->created) {
+		retn = add_temp_path(shash, path->pathname, path->instance,
+				     path->owner);
+	} else
+		retn = add_str(shash, path->pathname);
+
+ done:
+	return retn;
+}
+
+static int add_inode(struct shash_desc *shash, struct tsem_inode_cell *inode)
+{
+	u32 value;
+	u8 *p = (u8 *) &value;
+	int retn;
+	int size = sizeof(value);
+
+	value = inode->uid;
+	retn = crypto_shash_update(shash, p, size);
+	if (retn)
+		goto done;
+
+	value = inode->gid;
+	retn = crypto_shash_update(shash, p, size);
+	if (retn)
+		goto done;
+
+	value = inode->mode;
+	retn = crypto_shash_update(shash, p, size);
+	if (retn)
+		goto done;
+
+	value = inode->s_magic;
+	retn = crypto_shash_update(shash, p, size);
+	if (retn)
+		goto done;
+
+	p = (u8 *) inode->s_id;
+	size = sizeof(inode->s_id);
+	retn = crypto_shash_update(shash, p, size);
+	if (retn)
+		goto done;
+
+	if (inode->s_magic == TMPFS_MAGIC)
+		p = (u8 *) uuid_null.b;
+	else
+		p = (u8 *) inode->s_uuid;
+	size = sizeof(inode->s_uuid);
+	retn = crypto_shash_update(shash, p, size);
+
+ done:
+	return retn;
+}
+
+static int add_dentry(struct shash_desc *shash, struct tsem_dentry *dentry)
+{
+	int retn;
+
+	if (dentry->have_inode)
+		retn = add_inode(shash, &dentry->inode);
+
+	if (dentry->path.dev) {
+		retn = add_u32(shash, MAJOR(dentry->path.dev));
+		if (retn)
+			goto done;
+		retn = add_u32(shash, MINOR(dentry->path.dev));
+		if (retn)
+			goto done;
+	}
+
+	if (dentry->path.created &&
+	    dentry->path.creator == tsem_context(current)->id) {
+		retn = add_temp_path(shash, dentry->path.pathname,
+				     dentry->path.instance,
+				     dentry->path.owner);
+	} else
+		retn = add_str(shash, dentry->path.pathname);
+
+ done:
+	return retn;
+}
+
+static int add_file(struct shash_desc *shash, struct tsem_file_args *args)
+{
+	int retn;
+
+	retn = add_u32(shash, args->out.flags);
+	if (retn)
+		goto done;
+
+	retn = add_inode(shash, &args->out.inode);
+	if (retn)
+		goto done;
+
+	retn = add_path(shash, &args->out.path);
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_update(shash, args->out.digest, tsem_digestsize());
+
+ done:
+	return retn;
+}
+
+static int add_creds(struct shash_desc *shash, struct tsem_COE *cp)
+{
+	int retn;
+
+	retn = add_u32(shash, cp->uid);
+	if (!retn)
+		goto done;
+
+	retn = add_u32(shash, cp->euid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, cp->suid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, cp->gid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, cp->egid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, cp->sgid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, cp->fsuid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, cp->fsgid);
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, cp->capeff.value);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, cp->securebits);
+
+ done:
+	return retn;
+}
+
+static int add_socket(struct shash_desc *shash, struct tsem_socket *args)
+{
+	int retn;
+
+	retn = add_u32(shash, args->family);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->type);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->protocol);
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_update(shash, args->owner, sizeof(args->owner));
+
+ done:
+	return retn;
+}
+
+static int add_task(struct shash_desc *shash, u8 *task_id)
+{
+	return crypto_shash_update(shash, task_id, tsem_digestsize());
+}
+
+static int add_ipc_cred(struct shash_desc *shash, struct tsem_ipc_args *args)
+{
+	int retn;
+
+	retn = add_u32(shash, args->out.perm.uid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->out.perm.gid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->out.perm.cuid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->out.perm.cgid);
+	if (retn)
+		goto done;
+
+	retn = add_u16(shash, args->out.perm.mode);
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_update(shash, args->out.owner, tsem_digestsize());
+
+ done:
+	return retn;
+}
+
+static int add_socket_connect_bind(struct shash_desc *shash,
+				   struct tsem_event *ep)
+{
+	int retn;
+	char *p;
+	size_t size;
+	struct tsem_socket_args *args = &ep->CELL.socket;
+
+	retn = add_socket(shash, &args->out.socka);
+	if (retn)
+		goto done;
+
+	switch (args->out.socka.family) {
+	case AF_INET:
+		retn = add_u16(shash, args->out.ipv4.sin_port);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, args->out.ipv4.sin_addr.s_addr);
+		break;
+
+	case AF_INET6:
+		retn = add_u16(shash, args->out.ipv6.sin6_port);
+		if (retn)
+			goto done;
+
+		p = (u8 *) args->out.ipv6.sin6_addr.in6_u.u6_addr8;
+		size = sizeof(args->out.ipv6.sin6_addr.in6_u.u6_addr8);
+		retn = crypto_shash_update(shash, p, size);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, args->out.ipv6.sin6_flowinfo);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, args->out.ipv6.sin6_scope_id);
+		break;
+
+	case AF_UNIX:
+		p = args->out.path;
+		size = strlen(args->out.path);
+		retn = crypto_shash_update(shash, p, size);
+		break;
+
+	default:
+		p = (u8 *) args->out.mapping;
+		size = tsem_digestsize();
+		retn = crypto_shash_update(shash, p, size);
+		break;
+	}
+
+ done:
+	return retn;
+}
+
+static int add_socket_accept(struct shash_desc *shash, struct tsem_event *ep)
+{
+	char *p;
+	int retn, size;
+	struct tsem_socket_args *args = &ep->CELL.socket;
+
+	retn = add_socket(shash, &args->out.socka);
+	if (retn)
+		goto done;
+
+	switch (args->out.socka.family) {
+	case AF_INET:
+		retn = add_u16(shash, args->out.ipv4.sin_port);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, args->out.ipv4.sin_addr.s_addr);
+		break;
+
+	case AF_INET6:
+		retn = add_u16(shash, args->out.ipv6.sin6_port);
+		if (retn)
+			goto done;
+
+		p = (u8 *) args->out.ipv6.sin6_addr.in6_u.u6_addr8;
+		size = sizeof(args->out.ipv6.sin6_addr.in6_u.u6_addr8);
+		retn = crypto_shash_update(shash, p, size);
+		break;
+
+	case AF_UNIX:
+		p = args->out.path;
+		size = strlen(args->out.path);
+		retn = crypto_shash_update(shash, p, size);
+		break;
+
+	default:
+		p = args->out.mapping;
+		size = tsem_digestsize();
+		retn = crypto_shash_update(shash, p, size);
+		break;
+	}
+
+ done:
+	return retn;
+}
+
+static int add_socket_msg(struct shash_desc *shash, struct tsem_event *ep)
+{
+	char *p;
+	int size, retn;
+	struct sockaddr_in *ipv4;
+	struct sockaddr_in6 *ipv6;
+	struct tsem_socket_args *args = &ep->CELL.socket;
+
+	retn = add_socket(shash, &args->out.socka);
+	if (retn)
+		goto done;
+
+	if (!args->out.have_addr)
+		goto done;
+
+	if (args->out.socka.family == AF_INET) {
+		ipv4 = &args->out.ipv4;
+		retn = add_u16(shash, ipv4->sin_port);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ipv4->sin_addr.s_addr);
+		if (retn)
+			goto done;
+	}
+	if (args->out.socka.family == AF_INET6) {
+		ipv6 = &args->out.ipv6;
+		retn = add_u16(shash, ipv6->sin6_port);
+		if (retn)
+			goto done;
+
+		p = (u8 *) &ipv6->sin6_addr.in6_u.u6_addr8;
+		size = sizeof(ipv6->sin6_addr.in6_u.u6_addr8);
+		retn = crypto_shash_update(shash, p, size);
+		if (retn)
+			goto done;
+	}
+
+ done:
+	return retn;
+}
+
+static int add_xattr(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_inode_xattr_args *args = &ep->CELL.inode_xattr;
+
+	retn = add_dentry(shash, &args->out.dentry);
+	if (retn)
+		return retn;
+
+	if (ep->event == TSEM_INODE_LISTXATTR)
+		return 0;
+
+	retn = add_str(shash, args->out.name);
+	if (retn)
+		return retn;
+
+	if (ep->event == TSEM_INODE_GETXATTR ||
+	    ep->event == TSEM_INODE_REMOVEXATTR)
+		return 0;
+
+	retn = crypto_shash_update(shash, args->out.value, args->out.size);
+	if (retn)
+		return retn;
+
+	return add_u32(shash, args->out.flags);
+}
+
+static int add_inode_rename(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_inode_args *args = &ep->CELL.inode;
+
+	retn = add_inode(shash, &args->out.dir);
+	if (retn)
+		goto done;
+
+	retn = add_dentry(shash, &args->out.dentry);
+	if (retn)
+		goto done;
+
+	retn = add_inode(shash, &args->out.new_dir);
+	if (retn)
+		goto done;
+
+	retn = add_dentry(shash, &args->out.new_dentry);
+
+ done:
+	return retn;
+
+}
+
+static int add_inode_create(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn = 0;
+	struct tsem_inode_args *args = &ep->CELL.inode;
+
+	retn = add_inode(shash, &args->out.dir);
+	if (retn)
+		goto done;
+
+	retn = add_dentry(shash, &ep->CELL.inode.out.dentry);
+	if (retn)
+		goto done;
+	retn = add_u16(shash, ep->CELL.inode.mode);
+
+ done:
+	return retn;
+}
+
+static int add_sb_umount(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_sb_args *args = &ep->CELL.sb;
+
+	retn = add_dentry(shash, &args->out.dentry);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->flags);
+
+ done:
+	return retn;
+}
+
+static int add_sb_remount(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_sb_args *args = &ep->CELL.sb;
+
+	retn = add_dentry(shash, &args->out.dentry);
+	if (retn)
+		goto done;
+
+	retn = add_str(shash, ep->CELL.sb.out.type);
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, ep->CELL.sb.flags);
+
+ done:
+	return retn;
+}
+
+static int add_inode_link(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_inode_args *args = &ep->CELL.inode;
+
+	retn = add_dentry(shash, &args->out.dentry);
+	if (retn)
+		goto done;
+
+	retn = add_inode(shash, &args->out.dir);
+	if (retn)
+		goto done;
+
+	retn = add_dentry(shash, &args->out.new_dentry);
+
+ done:
+	return retn;
+}
+
+static int add_quotactl(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_quota_args *args = &ep->CELL.quota;
+
+	retn = add_u32(shash, args->cmds);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->type);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->id);
+	if (retn)
+		goto done;
+
+	retn = add_dentry(shash, &args->out.dentry);
+	if (retn)
+		goto done;
+
+	retn = add_str(shash, args->out.fstype);
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, args->out.s_flags);
+
+ done:
+	return retn;
+}
+
+static int add_mmap_file(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_mmap_file_args *args = &ep->CELL.mmap_file;
+
+	if (!args->anonymous) {
+		retn = add_file(shash, &args->file);
+		if (retn)
+			goto done;
+	}
+
+	retn = add_u32(shash, args->prot);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->flags);
+
+ done:
+	return retn;
+}
+
+static int add_task_setrlimit(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_task_kill_args *args = &ep->CELL.task_kill;
+
+	retn = add_task(shash, args->target);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->u.resource);
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, args->cur);
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, args->max);
+
+ done:
+	return retn;
+}
+
+static int add_move_path(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_sb_args *args = &ep->CELL.sb;
+
+	retn = add_path(shash, &args->out.path);
+	if (retn)
+		goto done;
+
+	add_path(shash, &args->out.path2);
+
+ done:
+	return retn;
+}
+
+static int add_task_kill(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_task_kill_args *args = &ep->CELL.task_kill;
+
+	retn = add_task(shash, args->target);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->signal);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->cross_model);
+
+ done:
+	return retn;
+}
+
+static int add_ptrace_access_check(struct shash_desc *shash,
+				   struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_task_kill_args *args = &ep->CELL.task_kill;
+
+	retn = add_task(shash, args->target);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->u.resource);
+
+ done:
+	return retn;
+}
+
+static int add_capget(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_capability_args *args = &ep->CELL.capability;
+
+	retn = add_task(shash, args->target);
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, args->effective.val);
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, args->inheritable.val);
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, args->permitted.val);
+
+ done:
+	return retn;
+}
+
+static int add_capset(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_capability_args *args = &ep->CELL.capability;
+
+	retn = add_u64(shash, args->effective.val);
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, args->inheritable.val);
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, args->permitted.val);
+
+ done:
+	return retn;
+}
+
+static int add_capable(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_capability_args *args = &ep->CELL.capability;
+
+	retn = add_u32(shash, args->cap);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->opts);
+
+ done:
+	return retn;
+}
+
+static int add_key_permission(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_key_args *args = &ep->CELL.key;
+
+	retn = add_u32(shash, args->out.possessed);
+	if (retn)
+		goto done;
+
+	retn = add_u16(shash, args->out.uid);
+	if (retn)
+		goto done;
+
+	retn = add_u16(shash, args->out.gid);
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, args->out.flags);
+	if (retn)
+		goto done;
+
+	retn = add_creds(shash, &args->out.cred);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->out.perm);
+
+ done:
+	return retn;
+}
+
+static int add_inode_setattr(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_inode_attr_args *args = &ep->CELL.inode_attr;
+
+	retn = add_dentry(shash, &args->out.dentry);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->out.valid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->out.mode);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->out.uid);
+	if (retn)
+		goto done;
+
+	retn = add_u32(shash, args->out.gid);
+	if (retn)
+		goto done;
+
+	retn = add_u64(shash, args->out.size);
+
+ done:
+	return retn;
+}
+
+static int add_bpf(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_bpf_args *args = &ep->CELL.bpf;
+
+	retn = add_u32(shash, args->bpf.cmd);
+	if (!retn)
+		goto done;
+
+	retn = add_u32(shash, args->bpf.size);
+
+ done:
+	return retn;
+}
+
+static int add_bpf_map(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_bpf_args *args = &ep->CELL.bpf;
+
+	retn = add_u32(shash, args->map.map_type);
+	if (!retn)
+		goto done;
+
+	retn = add_u32(shash, args->map.fmode);
+
+ done:
+	return retn;
+}
+
+static int add_bpf_prog(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_bpf_args *args = &ep->CELL.bpf;
+
+	retn = add_u32(shash, args->prog.type);
+	if (!retn)
+		goto done;
+
+	retn = add_u32(shash, args->prog.attach_type);
+
+ done:
+	return retn;
+}
+
+static int add_settime(struct shash_desc *shash, struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_time_args *args = &ep->CELL.time;
+
+	if (args->have_ts) {
+		retn = add_u64(shash, ep->CELL.time.seconds);
+		if (retn)
+			goto done;
+
+		retn = add_u64(shash, ep->CELL.time.nsecs);
+		if (retn)
+			goto done;
+	}
+
+	if (args->have_tz) {
+		retn = add_u32(shash, ep->CELL.time.minuteswest);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.time.dsttime);
+		if (retn)
+			goto done;
+	}
+
+ done:
+	return retn;
+}
+
+static int get_cell_mapping(struct tsem_event *ep, u8 *mapping)
+{
+	int retn = 0, size;
+	u8 *p;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tsem_digest();
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	switch (ep->event) {
+	case TSEM_NETLINK_SEND:
+		retn = add_socket(shash, &ep->CELL.socket.out.socka);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.netlink.out.uid);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.netlink.out.gid);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.netlink.out.portid);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.netlink.out.dst_group);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.netlink.out.flags);
+		if (retn)
+			goto done;
+
+		if (ep->CELL.netlink.out.nsid_set)
+			retn = add_u32(shash, ep->CELL.netlink.out.flags);
+		break;
+
+	case TSEM_IPC_PERMISSION:
+		retn = add_ipc_cred(shash, &ep->CELL.ipc);
+		if (retn)
+			goto done;
+
+		retn = add_u16(shash, ep->CELL.ipc.perm_flag);
+		break;
+
+	case TSEM_SHM_ASSOCIATE:
+	case TSEM_SHM_SHMCTL:
+	case TSEM_SHM_SHMAT:
+	case TSEM_SEM_ASSOCIATE:
+	case TSEM_SEM_SEMCTL:
+	case TSEM_MSG_QUEUE_ASSOCIATE:
+	case TSEM_MSG_QUEUE_MSGCTL:
+		retn = add_ipc_cred(shash, &ep->CELL.ipc);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.ipc.value);
+		break;
+
+	case TSEM_MSG_QUEUE_MSGRCV:
+		retn = add_ipc_cred(shash, &ep->CELL.ipc);
+		if (retn)
+			goto done;
+
+		p = ep->CELL.ipc.out.target;
+		size = tsem_digestsize();
+		retn = crypto_shash_update(shash, p, size);
+		if (retn)
+			goto done;
+
+		retn = add_u64(shash, ep->CELL.ipc.type);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.ipc.value);
+		break;
+
+	case TSEM_SEM_SEMOP:
+		retn = add_ipc_cred(shash, &ep->CELL.ipc);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.ipc.nsops);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.ipc.value);
+		break;
+
+	case TSEM_INODE_CREATE:
+		retn = add_inode_create(shash, ep);
+		break;
+
+	case TSEM_INODE_MKDIR:
+		retn = add_inode(shash, &ep->CELL.inode.out.dir);
+		if (retn)
+			goto done;
+
+		retn = add_dentry(shash, &ep->CELL.inode.out.dentry);
+		if (retn)
+			goto done;
+
+		retn = add_u16(shash, ep->CELL.inode.mode);
+		break;
+
+	case TSEM_INODE_RMDIR:
+	case TSEM_INODE_UNLINK:
+		retn = add_inode(shash, &ep->CELL.inode.out.dir);
+		if (retn)
+			goto done;
+
+		retn = add_dentry(shash, &ep->CELL.inode.out.dentry);
+		break;
+
+	case TSEM_SYSLOG:
+		retn = add_u32(shash, ep->CELL.value);
+		break;
+
+	case TSEM_SETTIME:
+		retn = add_settime(shash, ep);
+		break;
+
+	case TSEM_INODE_LINK:
+		retn = add_inode_link(shash, ep);
+		break;
+
+	case TSEM_INODE_SYMLINK:
+		retn = add_inode(shash, &ep->CELL.inode.out.dir);
+		if (retn)
+			goto done;
+
+		retn = add_dentry(shash, &ep->CELL.inode.out.dentry);
+		if (retn)
+			goto done;
+
+		retn = add_str(shash, ep->CELL.inode.out.old_name);
+		break;
+
+	case TSEM_INODE_MKNOD:
+		retn = add_inode(shash, &ep->CELL.inode.out.dir);
+		if (retn)
+			goto done;
+
+		retn = add_dentry(shash, &ep->CELL.inode.out.dentry);
+		if (retn)
+			goto done;
+
+		retn = add_u16(shash, ep->CELL.inode.mode);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.inode.dev);
+		break;
+
+	case TSEM_INODE_RENAME:
+		retn = add_inode_rename(shash, ep);
+		break;
+
+	case TSEM_INODE_KILLPRIV:
+		retn = add_dentry(shash, &ep->CELL.inode.out.dentry);
+		break;
+
+	case TSEM_FILE_OPEN:
+	case TSEM_BPRM_COMMITTED_CREDS:
+		retn = add_file(shash, &ep->CELL.file);
+		break;
+
+	case TSEM_FILE_IOCTL:
+	case TSEM_FILE_LOCK:
+	case TSEM_FILE_FCNTL:
+		retn = add_file(shash, &ep->CELL.file);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.file.cmd);
+		break;
+
+	case TSEM_FILE_RECEIVE:
+		retn = add_file(shash, &ep->CELL.file);
+		break;
+
+	case TSEM_MMAP_FILE:
+		retn = add_mmap_file(shash, ep);
+		break;
+
+	case TSEM_UNIX_STREAM_CONNECT:
+	case TSEM_UNIX_MAY_SEND:
+	case TSEM_SOCKET_SOCKETPAIR:
+		retn = add_socket(shash, &ep->CELL.socket.out.socka);
+		if (retn)
+			goto done;
+
+		retn = add_socket(shash, &ep->CELL.socket.out.sockb);
+		break;
+
+	case TSEM_SOCKET_SENDMSG:
+	case TSEM_SOCKET_RECVMSG:
+		retn = add_socket_msg(shash, ep);
+		break;
+
+	case TSEM_SOCKET_GETSOCKNAME:
+	case TSEM_SOCKET_GETPEERNAME:
+	case TSEM_TUN_DEV_ATTACH_QUEUE:
+		retn = add_socket(shash, &ep->CELL.socket.out.socka);
+		break;
+
+	case TSEM_SOCKET_CREATE:
+		retn = add_u32(shash, ep->CELL.socket.out.socka.family);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.socket.out.socka.type);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.socket.out.socka.protocol);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.socket.out.socka.kern);
+		break;
+
+	case TSEM_SOCKET_CONNECT:
+	case TSEM_SOCKET_BIND:
+		retn = add_socket_connect_bind(shash, ep);
+		break;
+
+	case TSEM_SOCKET_ACCEPT:
+		retn = add_socket_accept(shash, ep);
+		break;
+
+	case TSEM_SOCKET_LISTEN:
+	case TSEM_SOCKET_SHUTDOWN:
+		retn = add_socket(shash, &ep->CELL.socket.out.socka);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.socket.value);
+		break;
+
+	case TSEM_SOCKET_SETSOCKOPT:
+		retn = add_socket(shash, &ep->CELL.socket.out.socka);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.socket.value);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.socket.optname);
+		break;
+
+	case TSEM_KERNEL_MODULE_REQUEST:
+		retn = add_str(shash, ep->CELL.kernel.out.kmod_name);
+		break;
+
+	case TSEM_KERNEL_LOAD_DATA:
+		retn = add_u32(shash, ep->CELL.kernel.id);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.kernel.contents);
+		break;
+
+	case TSEM_KERNEL_READ_FILE:
+		retn = add_file(shash, &ep->CELL.kernel.out.file);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.kernel.id);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.kernel.contents);
+		break;
+
+	case TSEM_TASK_KILL:
+		retn = add_task_kill(shash, ep);
+		break;
+
+	case TSEM_PTRACE_ACCESS_CHECK:
+		retn = add_ptrace_access_check(shash, ep);
+		break;
+
+	case TSEM_PTRACE_TRACEME:
+		retn = add_task(shash, ep->CELL.task_kill.source);
+		break;
+
+	case TSEM_CAPGET:
+		retn = add_capget(shash, ep);
+		break;
+
+	case TSEM_CAPSET:
+		retn = add_capset(shash, ep);
+		break;
+
+	case TSEM_CAPABLE:
+		retn = add_capable(shash, ep);
+		break;
+
+	case TSEM_TASK_SETPGID:
+		p = ep->CELL.task_kill.target;
+		size = sizeof(ep->CELL.task_kill.target);
+		retn = crypto_shash_update(shash, p, size);
+		if (retn)
+			goto done;
+
+		p = ep->CELL.task_kill.source;
+		size = sizeof(ep->CELL.task_kill.source);
+		retn = crypto_shash_update(shash, p, size);
+		break;
+
+	case TSEM_TASK_GETPGID:
+	case TSEM_TASK_GETSID:
+	case TSEM_TASK_GETIOPRIO:
+	case TSEM_TASK_SETSCHEDULER:
+	case TSEM_TASK_GETSCHEDULER:
+		retn = add_task(shash, ep->CELL.task_kill.target);
+		break;
+
+	case TSEM_TASK_SETNICE:
+	case TSEM_TASK_SETIOPRIO:
+		p = ep->CELL.task_kill.target;
+		size = sizeof(ep->CELL.task_kill.target);
+		retn = crypto_shash_update(shash, p, size);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.task_kill.u.value);
+		break;
+
+	case TSEM_TASK_PRLIMIT:
+		retn = add_creds(shash, &ep->CELL.task_prlimit.out.cred);
+		if (retn)
+			goto done;
+
+		retn = add_creds(shash, &ep->CELL.task_prlimit.out.tcred);
+		if (retn)
+			goto done;
+
+		retn = add_u32(shash, ep->CELL.task_prlimit.flags);
+		break;
+
+	case TSEM_TASK_SETRLIMIT:
+		retn = add_task_setrlimit(shash, ep);
+		break;
+
+	case TSEM_TASK_PRCTL:
+		retn = add_u32(shash, ep->CELL.task_prctl.option);
+		if (retn)
+			goto done;
+
+		if (ep->CELL.task_prctl.option != PR_GET_PDEATHSIG)
+			retn = add_u64(shash, ep->CELL.task_prctl.arg2);
+		else
+			retn = add_u64(shash, 0);
+		if (retn)
+			goto done;
+
+		retn = add_u64(shash, ep->CELL.task_prctl.arg4);
+		if (retn)
+			goto done;
+
+		retn = add_u64(shash, ep->CELL.task_prctl.arg5);
+		break;
+
+	case TSEM_INODE_GETATTR:
+		retn = add_dentry(shash, &ep->CELL.inode_attr.out.dentry);
+		break;
+
+	case TSEM_INODE_SETATTR:
+		retn = add_inode_setattr(shash, ep);
+		break;
+
+	case TSEM_INODE_SETXATTR:
+	case TSEM_INODE_GETXATTR:
+	case TSEM_INODE_REMOVEXATTR:
+	case TSEM_INODE_LISTXATTR:
+		retn = add_xattr(shash, ep);
+		break;
+
+	case TSEM_KEY_ALLOC:
+		retn = add_creds(shash, &ep->CELL.key.out.cred);
+		if (retn)
+			goto done;
+
+		retn = add_u64(shash, ep->CELL.key.flags);
+		break;
+
+	case TSEM_KEY_PERMISSION:
+		retn = add_key_permission(shash, ep);
+		break;
+
+	case TSEM_SB_MOUNT:
+		if (ep->CELL.sb.out.dev_name) {
+			retn = add_str(shash, ep->CELL.sb.out.dev_name);
+			if (retn)
+				goto done;
+		}
+
+		retn = add_path(shash, &ep->CELL.sb.out.path);
+		if (retn)
+			goto done;
+
+		if (ep->CELL.sb.out.type) {
+			retn = add_str(shash, ep->CELL.sb.out.type);
+			if (retn)
+				goto done;
+		}
+
+		retn = add_u64(shash, ep->CELL.sb.flags);
+		break;
+
+	case TSEM_SB_UMOUNT:
+		retn = add_sb_umount(shash, ep);
+		break;
+
+	case TSEM_SB_REMOUNT:
+		retn = add_sb_remount(shash, ep);
+		break;
+
+	case TSEM_SB_STATFS:
+		retn = add_dentry(shash, &ep->CELL.sb.out.dentry);
+		break;
+
+	case TSEM_SB_PIVOTROOT:
+	case TSEM_MOVE_MOUNT:
+		retn = add_move_path(shash, ep);
+		break;
+
+	case TSEM_QUOTACTL:
+		retn = add_quotactl(shash, ep);
+		break;
+
+	case TSEM_QUOTA_ON:
+		retn = add_dentry(shash, &ep->CELL.quota.out.dentry);
+		break;
+
+	case TSEM_BPF:
+		retn = add_bpf(shash, ep);
+		break;
+
+	case TSEM_BPF_MAP:
+		retn = add_bpf_map(shash, ep);
+		break;
+
+	case TSEM_BPF_PROG:
+		retn = add_bpf_prog(shash, ep);
+		break;
+
+	default:
+		p = (u8 *) tsem_names[ep->event];
+		size = strlen(tsem_names[ep->event]);
+		retn = crypto_shash_update(shash, p, size);
+		if (retn)
+			goto done;
+
+		p = tsem_context(current)->zero_digest;
+		size = tsem_digestsize();
+		retn = crypto_shash_update(shash, p, size);
+		break;
+	}
+
+ done:
+	if (!retn)
+		retn = crypto_shash_final(shash, mapping);
+
+	if (ep->event == TSEM_INODE_SETXATTR) {
+		kfree(ep->CELL.inode_xattr.out.value);
+		ep->CELL.inode_xattr.out.value = NULL;
+	}
+
+	return retn;
+}
+
+static int get_event_mapping(int event, u8 *p_task_id, u8 *task_id,
+			     u8 *COE_id, u8 *cell_id, u8 *mapping)
+{
+	int retn = 0;
+	u32 event_id = (u32) event;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tsem_digest();
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_update(shash, tsem_names[event_id],
+				   strlen(tsem_names[event_id]));
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_update(shash, p_task_id, tsem_digestsize());
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_update(shash, task_id, tsem_digestsize());
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_update(shash, COE_id, tsem_digestsize());
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_finup(shash, cell_id, tsem_digestsize(), mapping);
+
+ done:
+	return retn;
+}
+
+static int map_event(struct tsem_event *ep, u8 *p_task_id, u8 *task_id,
+		     u8 *event_mapping)
+{
+	int retn;
+	u8 COE_mapping[HASH_MAX_DIGESTSIZE];
+	u8 cell_mapping[HASH_MAX_DIGESTSIZE];
+
+	retn = get_COE_mapping(ep, COE_mapping);
+	if (retn)
+		goto done;
+
+	retn = get_cell_mapping(ep, cell_mapping);
+	if (retn)
+		goto done;
+
+	retn = get_event_mapping(ep->event, p_task_id, task_id, COE_mapping,
+				 cell_mapping, event_mapping);
+ done:
+	return retn;
+}
+
+/**
+ * tsem_map_task() - Create the task identity description structure.
+ * @file: A pointer to the file structure defining the executable.
+ * @task_id: Pointer to the buffer that the task id will be copied to.
+ *
+ * This function creates the security event state point that will be used
+ * as the task identifier for the generation of security state points
+ * that are created by the process that task identifier is assigned to.
+ *
+ * Return: This function returns 0 if the mapping was successfully
+ *	   created and an error value otherwise.
+ */
+int tsem_map_task(struct file *file, u8 *task_id)
+{
+	int retn;
+	u8 null_taskid[HASH_MAX_DIGESTSIZE];
+	struct tsem_event *ep;
+
+	ep = tsem_event_allocate(TSEM_BPRM_COMMITTED_CREDS, false);
+	if (!ep)
+		return -ENOMEM;
+
+	ep->CELL.file.in.file = file;
+	retn = tsem_event_init(ep);
+	if (retn > 0) {
+		memset(null_taskid, '\0', tsem_digestsize());
+		retn = map_event(ep, tsem_task(current)->p_task_id,
+				 null_taskid, task_id);
+	}
+
+	tsem_event_put(ep);
+	return retn;
+}
+
+/**
+ * tsem_map_event() - Create a security event mapping.
+ * @event: The number of the event to be mapped.
+ * @params: A pointer to the structure containing the event description
+ *	    parameters.
+ *
+ * This function creates a structure to describe a security event
+ * and maps the event into a security state coefficient.
+ *
+ * Return: This function returns a value of zero on success and a negative
+ *	   error code on failure.
+ */
+int tsem_map_event(struct tsem_event *ep)
+{
+	struct tsem_task *task = tsem_task(current);
+
+	return map_event(ep, task->p_task_id, task->task_id, ep->mapping);
+}
-- 
2.39.1


