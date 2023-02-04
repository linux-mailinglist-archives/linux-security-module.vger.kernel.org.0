Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D168A864
	for <lists+linux-security-module@lfdr.de>; Sat,  4 Feb 2023 06:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBDFdJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 4 Feb 2023 00:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjBDFdF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Feb 2023 00:33:05 -0500
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A8DD30EC
        for <linux-security-module@vger.kernel.org>; Fri,  3 Feb 2023 21:33:00 -0800 (PST)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 3145A3vv011671;
        Fri, 3 Feb 2023 23:10:03 -0600
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 3145A3Hl011669;
        Fri, 3 Feb 2023 23:10:03 -0600
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 11/14] Add event description implementation.
Date:   Fri,  3 Feb 2023 23:09:51 -0600
Message-Id: <20230204050954.11583-12-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230204050954.11583-1-greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The event.c file implements support for packaging the description
of an event into its Context Of Execution (COE) and CELL
components for subsequent modeling by an internal Trusted
Modeling Agent or export to a trust orchestrator.

The tsem_event_allocate() function is called by every security
event handler that determines that an event is to be modeled,
either generically or explicitly.  For externally modeled domains
the event description is released after the export of the event
is completed.

For internally modeled domains the event description is retained
in order to support retention and surfacing of the security event
descriptions until the domain is terminated.

The event description structures are allocated from a TSEM
event description cache named 'tsem_event_cache'.  This cache is
created by an initialization function exported from this file
that is called as part of the TSEM LSM initialization process.o

In the case of a security event that acts on a file, ie. is
called with a 'struct file' pointer, one of the components of the
CELL value is a digest of the contents of the file.  This file
uses the integrity_kernel_read() function supplied by the
integrity infrastructure to compute the file digest value using
the SHA256 cryptographic hashing function.

In a manner similar to the Integrity Measurement Architecture the
file digest processing functionality needs to temporarily alter
the file mode characteristics if the file is not readable.  The
characteristics are returned to their normal file after reading
of the digest is complete.

The TSEM LSM allocates uses the LSM 'blob' infrastructure to
allocate a TSEM specific inode structure when an inode is
allocated.  The digest value for the value is stored in this
structure in order to eliminate subsequent re-computation of the
digest value if the file has not changed.

The inode 'iversion' value is used to detect changes to an inode
in order to trigger the re-computation of the digest value if the
file has changed.

One of the subtle issues that needs to be addressed is to handle
re-entrancy of the file_open security event hook that is caused
by the integrity_kernel_read() function opening the file.  The
TSEM specific inode structure contains a member that is used to
indicate whether or not a digest is being computed for a file.
The tsem_file_open() event handler checks for the presence of
this flag and allows permission for the open if this flag is
detected.

For IPV6 and IPV6 sockets relevant socket information is
collected to be used in the CELL computation.

For a UNIX domain socket (AF_UNIX) the digest of the pathname for
the socket is used for the CELL value.

Other socket types are generically modeled by computing the
digest of the address field supplied when the socket was created
or bound.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 security/tsem/event.c | 474 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 474 insertions(+)
 create mode 100644 security/tsem/event.c

diff --git a/security/tsem/event.c b/security/tsem/event.c
new file mode 100644
index 000000000000..a6162caf2d81
--- /dev/null
+++ b/security/tsem/event.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2022 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * This file manages the data structures used to define a security event.
+ */
+
+#define ZERO_FILE "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
+
+#include <linux/iversion.h>
+#include <crypto/hash.h>
+
+#include "tsem.h"
+#include "../integrity/integrity.h"
+
+static struct kmem_cache *event_cachep;
+
+static void get_COE(struct tsem_COE *COE)
+
+{
+	kernel_cap_t eff, per, inh;
+
+	COE->uid = from_kuid(&init_user_ns, current_uid());
+	COE->euid = from_kuid(&init_user_ns, current_euid());
+	COE->suid = from_kuid(&init_user_ns, current_suid());
+
+	COE->gid = from_kgid(&init_user_ns, current_gid());
+	COE->egid = from_kgid(&init_user_ns, current_egid());
+	COE->sgid = from_kgid(&init_user_ns, current_sgid());
+
+	COE->fsuid = from_kuid(&init_user_ns, current_fsuid());
+	COE->fsgid = from_kgid(&init_user_ns, current_fsgid());
+
+	if (security_capget(current, &eff, &inh, &per) != 0)
+		eff = CAP_FULL_SET;
+	COE->capability.mask = eff;
+}
+
+static char *get_path(struct file *file)
+{
+	int retn = 0;
+	const char *pathname = NULL;
+	char *path, *pathbuffer = NULL;
+
+	pathbuffer = __getname();
+	if (pathbuffer) {
+		pathname = d_absolute_path(&file->f_path, pathbuffer,
+					   PATH_MAX);
+		if (IS_ERR(pathname)) {
+			__putname(pathbuffer);
+			pathbuffer = NULL;
+			pathname = NULL;
+		}
+	}
+
+	if (pathname)
+		path = kstrdup(pathname, GFP_KERNEL);
+	else
+		path = kstrdup(file->f_path.dentry->d_name.name, GFP_KERNEL);
+	if (!path)
+		retn = -ENOMEM;
+
+	if (pathbuffer)
+		__putname(pathbuffer);
+	if (retn)
+		path = ERR_PTR(retn);
+	return path;
+}
+
+static int add_file_name(struct crypto_shash *tfm, struct tsem_event *ep)
+{
+	int retn;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tfm;
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	ep->file.name_length = strlen(ep->pathname);
+	retn = crypto_shash_finup(shash, ep->pathname, ep->file.name_length,
+				  ep->file.name);
+
+ done:
+	return retn;
+}
+
+static struct file *open_event_file(struct file *file, unsigned int *status)
+{
+	int flags;
+	struct file *alt_file;
+
+	if (!(file->f_mode & FMODE_CAN_READ)) {
+		file->f_mode |= FMODE_CAN_READ;
+		*status |= 4;
+	}
+	if (file->f_mode & FMODE_READ)
+		return file;
+
+	flags = file->f_flags & ~(O_WRONLY | O_APPEND | O_TRUNC | O_CREAT |
+				  O_NOCTTY | O_EXCL);
+	flags |= O_RDONLY;
+
+	alt_file = dentry_open(&file->f_path, flags, file->f_cred);
+	if (!IS_ERR(alt_file)) {
+		*status |= 1;
+		return alt_file;
+	}
+
+	file->f_flags |= FMODE_READ;
+	*status |= 2;
+	return file;
+}
+
+static int get_file_digest(struct crypto_shash *tfm, struct file *file,
+			   struct inode *inode, loff_t size, u8 *digest)
+{
+	u8 *bufr;
+	int retn = 0, rsize;
+	unsigned int open_status = 0;
+	loff_t posn = 0;
+	struct file *read_file;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tfm;
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	bufr = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!bufr) {
+		retn = -ENOMEM;
+		goto done;
+	}
+
+	if (!likely(file->f_op->read || file->f_op->read_iter)) {
+		retn = -EINVAL;
+		goto done;
+	}
+	read_file = open_event_file(file, &open_status);
+
+	while (posn < size) {
+		rsize = integrity_kernel_read(read_file, posn, bufr, 4096);
+		if (rsize < 0) {
+			retn = rsize;
+			break;
+		}
+		if (rsize == 0)
+			break;
+
+		posn += rsize;
+		retn = crypto_shash_update(shash, bufr, rsize);
+		if (retn)
+			break;
+	}
+
+	kfree(bufr);
+	if (!retn)
+		retn = crypto_shash_final(shash, digest);
+
+ done:
+	if (open_status & 1)
+		fput(read_file);
+	if (open_status & 2)
+		file->f_flags &= ~FMODE_READ;
+	if (open_status & 4)
+		file->f_flags &= ~FMODE_CAN_READ;
+	return retn;
+}
+
+int add_file_digest(struct file *file, struct tsem_file *tfp)
+{
+	int retn = 0;
+	loff_t size;
+	struct inode *inode = NULL;
+	struct tsem_inode *tsip;
+	u8 measurement[WP256_DIGEST_SIZE];
+	struct tsem_TMA_context *ctx = tsem_context(current);
+	struct crypto_shash *tfm;
+
+	memset(measurement, '\0', sizeof(measurement));
+	inode = file_inode(file);
+	tsip = tsem_inode(inode);
+
+	mutex_lock(&tsip->mutex);
+	if (!ctx->external) {
+		retn = tsem_model_has_pseudonym(tsip, tfp, measurement);
+		if (retn < 0)
+			goto done;
+		if (retn) {
+			memcpy(tfp->digest, measurement, sizeof(tfp->digest));
+			retn = 0;
+			goto done;
+		}
+	}
+
+	size = i_size_read(inode);
+	if (!size) {
+		if (!hex2bin(measurement, ZERO_FILE, sizeof(measurement)))
+			memcpy(tfp->digest, measurement, sizeof(tfp->digest));
+		else
+			memset(tfp->digest, '\0', sizeof(tfp->digest));
+		goto done;
+	}
+
+	if (inode_eq_iversion(inode, tsip->version) &&
+	    tsip->status == TSEM_INODE_COLLECTED) {
+		memcpy(tfp->digest, tsip->digest, sizeof(tfp->digest));
+		goto done;
+	}
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm)) {
+		retn = PTR_ERR(tfm);
+		goto done;
+	}
+
+	tsip->status = TSEM_INODE_COLLECTING;
+	retn = get_file_digest(tfm, file, inode, size, measurement);
+	if (retn)
+		tsip->status = 0;
+	else {
+		memcpy(tfp->digest, measurement, sizeof(tfp->digest));
+		memcpy(tsip->digest, measurement, sizeof(tsip->digest));
+		tsip->status = TSEM_INODE_COLLECTED;
+		tsip->version = inode_query_iversion(inode);
+	}
+
+ done:
+	mutex_unlock(&tsip->mutex);
+	return retn;
+}
+
+static int get_file_cell(struct file *file, struct tsem_event *ep)
+{
+	int retn = 1;
+	struct crypto_shash *tfm;
+	struct inode *inode;
+
+	inode = file_inode(file);
+	inode_lock(inode);
+
+	ep->pathname = get_path(file);
+	if (IS_ERR(ep->pathname)) {
+		retn = PTR_ERR(ep->pathname);
+		goto done;
+	}
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm)) {
+		retn = PTR_ERR(tfm);
+		goto done;
+	}
+
+	retn = add_file_name(tfm, ep);
+	if (retn)
+		goto done;
+
+	retn = add_file_digest(file, &ep->file);
+	if (retn)
+		goto done;
+
+	ep->file.flags = file->f_flags;
+
+	ep->file.uid = from_kuid(&init_user_ns, inode->i_uid);
+	ep->file.gid = from_kgid(&init_user_ns, inode->i_gid);
+	ep->file.mode = inode->i_mode;
+	ep->file.s_magic = inode->i_sb->s_magic;
+	memcpy(ep->file.s_id, inode->i_sb->s_id, sizeof(ep->file.s_id));
+	memcpy(ep->file.s_uuid, inode->i_sb->s_uuid.b,
+	       sizeof(ep->file.s_uuid));
+
+ done:
+	inode_unlock(inode);
+	crypto_free_shash(tfm);
+	return retn;
+}
+
+static int get_socket_mapping(struct crypto_shash *tfm,
+			      struct tsem_socket_connect_args *scp)
+{
+	int retn, size;
+	u8 *p;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tfm;
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	switch (scp->family) {
+	case AF_UNIX:
+		p = (u8 *) scp->addr->sa_data;
+		size = strlen(p);
+		retn = crypto_shash_finup(shash, p, size, scp->u.mapping);
+		break;
+	default:
+		p = (u8 *) scp->addr->sa_data;
+		size = sizeof(scp->addr) - offsetof(struct sockaddr, sa_data);
+		retn = crypto_shash_finup(shash, p, size, scp->u.mapping);
+		break;
+	}
+	memcpy(scp->tsip->digest, scp->u.mapping, sizeof(scp->tsip->digest));
+
+ done:
+	return retn;
+}
+
+static int get_socket_cell(struct tsem_event *ep)
+
+{
+	int retn = 0;
+	struct crypto_shash *tfm = NULL;
+	struct tsem_socket_connect_args *scp = &ep->CELL.socket_connect;
+
+	scp->family = scp->addr->sa_family;
+
+	switch (scp->family) {
+	case AF_INET:
+		memcpy(&scp->u.ipv4, scp->addr, sizeof(scp->u.ipv4));
+		break;
+	case AF_INET6:
+		memcpy(&scp->u.ipv6, scp->addr, sizeof(scp->u.ipv6));
+		break;
+	default:
+		tfm = crypto_alloc_shash("sha256", 0, 0);
+		if (IS_ERR(tfm)) {
+			retn = PTR_ERR(tfm);
+			tfm = NULL;
+			goto done;
+		}
+		retn = get_socket_mapping(tfm, scp);
+		break;
+	}
+
+ done:
+	crypto_free_shash(tfm);
+	return retn;
+}
+
+/**
+ * tsem_event_allocate() - Allocate a security event description structure.
+ * @event: The security event number for which the structure is being
+ *	   allocated.
+ * @params: A pointer to the aggregation structure used to hold the
+ *	    parameters that describe the function.
+ *
+ * This function is responsible for allocating the primary tsem_event
+ * structure and populating it based on the event type.
+ *
+ * Return: This function returns a pointer to the allocated structure which
+ *	   on failure will have an error return code embedded in it.
+ */
+struct tsem_event *tsem_event_allocate(enum tsem_event_type event,
+				       struct tsem_event_parameters *params)
+{
+	int retn = 0;
+	struct tsem_event *ep;
+	struct tsem_task *task = tsem_task(current);
+
+	ep = kmem_cache_zalloc(event_cachep, GFP_KERNEL);
+	if (!ep) {
+		retn = -ENOMEM;
+		goto done;
+	}
+
+	ep->event = event;
+	ep->pid = task_pid_nr(current);
+	memcpy(ep->comm, current->comm, sizeof(ep->comm));
+	memcpy(ep->task_id, task->task_id, sizeof(ep->task_id));
+
+	get_COE(&ep->COE);
+	switch (event) {
+	case TSEM_FILE_OPEN:
+	case TSEM_BPRM_SET_CREDS:
+		retn = get_file_cell(params->u.file, ep);
+		break;
+	case TSEM_MMAP_FILE:
+		ep->CELL.mmap_file = *params->u.mmap_file;
+		if (!ep->CELL.mmap_file.anonymous)
+			retn = get_file_cell(ep->CELL.mmap_file.file, ep);
+		break;
+	case TSEM_SOCKET_CREATE:
+		ep->CELL.socket_create = *params->u.socket_create;
+		break;
+	case TSEM_SOCKET_CONNECT:
+	case TSEM_SOCKET_BIND:
+		ep->CELL.socket_connect = *params->u.socket_connect;
+		retn = get_socket_cell(ep);
+		break;
+	case TSEM_SOCKET_ACCEPT:
+		ep->CELL.socket_accept = *params->u.socket_accept;
+		break;
+	case TSEM_TASK_KILL:
+		ep->CELL.task_kill = *params->u.task_kill;
+		break;
+	case TSEM_GENERIC_EVENT:
+		ep->CELL.event_type = params->u.event_type;
+		break;
+	default:
+		WARN_ONCE(true, "Unhandled event type: %d\n", event);
+		break;
+	}
+
+ done:
+	if (retn) {
+		kfree(ep);
+		ep = ERR_PTR(retn);
+	} else
+		kref_init(&ep->kref);
+
+	return ep;
+}
+
+/**
+ * tsem_free_event() - Free a security event description.
+ * @ep: A pointer to the security event description that is to be freed.
+ *
+ * This function is responsible for freeing the resources that were
+ * allocated by the tsem_event_allocate_COE_cell() function.
+ */
+static void tsem_event_free(struct kref *kref)
+{
+	struct tsem_event *ep;
+
+	ep = container_of(kref, struct tsem_event, kref);
+	if (ep)
+		kfree(ep->pathname);
+	kmem_cache_free(event_cachep, ep);
+}
+
+/**
+ * tsem_event_put() - Release a referenceto a TSEM event description.
+ *
+ * This function is called each time the use of a TSEM event description
+ * is dropped.
+ */
+void tsem_event_put(struct tsem_event *ep)
+{
+	kref_put(&ep->kref, tsem_event_free);
+}
+
+/**
+ * tsem_event_get() - Obtain a reference to a TSEM event description.
+ *
+ * This function is called on each invocation of the tsem_task_free
+ * function to release one of the references on the TMA modeling
+ * structure.
+ */
+void tsem_event_get(struct tsem_event *ep)
+{
+	kref_get(&ep->kref);
+}
+
+/**
+ * tsem event_cache_init() - Initialize the TSEM event cache.
+ *
+ * This function is called by the TSEM initialization function and sets
+ * up the cache that will hold tsem_event structures.
+ *
+ * Return: This function returns a value of zero on success and a negative
+ *	   error code on failure.
+ */
+int __init tsem_event_cache_init(void)
+{
+	event_cachep = kmem_cache_create("tsem_event_cache",
+					 sizeof(struct tsem_event), 0,
+					 SLAB_PANIC, 0);
+	if (!event_cachep)
+		return -ENOMEM;
+	return 0;
+}
-- 
2.39.1

