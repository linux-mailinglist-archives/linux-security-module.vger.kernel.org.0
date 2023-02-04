Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F066568A866
	for <lists+linux-security-module@lfdr.de>; Sat,  4 Feb 2023 06:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjBDFdR (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 4 Feb 2023 00:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjBDFdP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Feb 2023 00:33:15 -0500
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6611E3C35
        for <linux-security-module@vger.kernel.org>; Fri,  3 Feb 2023 21:33:09 -0800 (PST)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 3145A0h8011647;
        Fri, 3 Feb 2023 23:10:00 -0600
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 3145A008011645;
        Fri, 3 Feb 2023 23:10:00 -0600
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 08/14] Implement TSEM control plane.
Date:   Fri,  3 Feb 2023 23:09:48 -0600
Message-Id: <20230204050954.11583-9-greg@enjellic.com>
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

The fs.c file contains the implementation of the TSEM control
plane that is in the form of a pseudo-filesystem mounted on the
following directory:

/sys/fs/tsem

The following file documents the interface provided by the
control plane:

Documentation/ABI/testing/tsemfs

The pseudo-files act on the modeling context of the process that
is acting on the file.  For example, reading the 'id'
pseudo-file, returns the modeling domain identifier that the
process is running in.

The ExternalTMA directory is used to segreate the pseudo-files
that are created in order to surface security event descriptions
to an external trust orchestrator.  The files in this directory
appear as the numeric value of the modeling domain they were
created for.

The 'control' pseudo-file is the only writable file in the plane
and is used to control the TSEM implementation.  The most
important and primary roles are to create namespaces and set the
trust status of a process modeled by an external TMA.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 security/tsem/fs.c | 894 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 894 insertions(+)
 create mode 100644 security/tsem/fs.c

diff --git a/security/tsem/fs.c b/security/tsem/fs.c
new file mode 100644
index 000000000000..2898a1cc8c97
--- /dev/null
+++ b/security/tsem/fs.c
@@ -0,0 +1,894 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2022 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * Implements the sysfs based control plane.
+ */
+
+#include <linux/seq_file.h>
+#include <linux/sysfs.h>
+#include <linux/fs_context.h>
+#include <linux/namei.h>
+#include <linux/poll.h>
+#include <uapi/linux/magic.h>
+
+#include "tsem.h"
+
+static int fs_init_context(struct fs_context *context);
+static int fs_get_tree(struct fs_context *context);
+
+static struct file_system_type fs_definition = {
+	.name = "tsemfs",
+	.init_fs_context = fs_init_context,
+	.kill_sb = kill_litter_super
+};
+
+static struct fs_context_operations fs_operations = {
+	.get_tree = fs_get_tree
+};
+
+static struct vfsmount *fs_mount;
+
+static int fs_mount_cnt;
+
+static struct dentry *external_dentry;
+
+struct control_commands {
+	char *cmd;
+	enum tsem_control_type type;
+};
+
+static struct control_commands commands[9] = {
+	{"internal", TSEM_CONTROL_INTERNAL},
+	{"external", TSEM_CONTROL_EXTERNAL},
+	{"enforce", TSEM_CONTROL_ENFORCE},
+	{"seal", TSEM_CONTROL_SEAL},
+	{"trusted ", TSEM_CONTROL_TRUSTED},
+	{"untrusted ", TSEM_CONTROL_UNTRUSTED},
+	{"state ", TSEM_CONTROL_MAP_STATE},
+	{"pseudonym ", TSEM_CONTROL_MAP_PSEUDONYM},
+	{"base ", TSEM_CONTROL_MAP_BASE}
+};
+
+static bool can_access_fs(void)
+{
+	struct tsem_TMA_context *ctx = tsem_context(current);
+
+	if (ctx->external)
+		return false;
+	if (capable(TSEM_CONTROL_CAPABILITY))
+		return true;
+	if (ctx->sealed)
+		return false;
+	return true;
+}
+
+static int control_COE(pid_t pid, unsigned long cmd)
+{
+	bool wakeup = false;
+	int retn = -ESRCH;
+	struct task_struct *COE;
+	struct tsem_task *task;
+
+	rcu_read_lock();
+	COE = find_task_by_vpid(pid);
+	if (COE != NULL) {
+		task = tsem_task(COE);
+		if (cmd == TSEM_CONTROL_UNTRUSTED)
+			task->trust_status = TSEM_TASK_UNTRUSTED;
+		if (cmd == TSEM_CONTROL_TRUSTED) {
+			task->trust_status &= ~TSEM_TASK_TRUST_PENDING;
+			if (tsem_task_trusted(COE))
+				task->trust_status = TSEM_TASK_TRUSTED;
+		}
+
+		retn = 0;
+		wakeup = true;
+	}
+	rcu_read_unlock();
+
+	if (wakeup)
+		wake_up_process(COE);
+
+	return retn;
+}
+
+static int config_context(unsigned long cmd, char *bufr)
+{
+	int retn = -EINVAL;
+	unsigned int lp;
+	struct tsem_TMA_context *ctx = tsem_context(current);
+
+	if (ctx->sealed)
+		return -EPERM;
+
+	if (cmd == TSEM_CONTROL_SEAL) {
+		ctx->sealed = true;
+		retn = 0;
+	}
+
+	if (cmd == TSEM_CONTROL_ENFORCE) {
+		for (lp = 0; lp < ARRAY_SIZE(tsem_root_actions); ++lp)
+			ctx->actions[lp] = TSEM_ACTION_EPERM;
+		retn = 0;
+	}
+
+	return retn;
+}
+
+static int config_point(enum tsem_control_type type, u8 *arg)
+{
+	int retn = -EINVAL;
+	u8 mapping[WP256_DIGEST_SIZE];
+
+	if (*++arg == '\0')
+		goto done;
+	if (strlen(arg) != sizeof(mapping) * 2)
+		goto done;
+	if (hex2bin(mapping, arg, sizeof(mapping)))
+		goto done;
+
+	if (type == TSEM_CONTROL_MAP_STATE)
+		retn = tsem_model_load_point(mapping);
+	else if (type == TSEM_CONTROL_MAP_PSEUDONYM)
+		retn = tsem_model_load_pseudonym(mapping);
+	else {
+		tsem_model_load_base(mapping);
+		retn = 0;
+	}
+
+ done:
+	return retn;
+}
+
+static void show_event(struct seq_file *c, struct tsem_event *ep, char *file)
+{
+	seq_printf(c, "event{process=%s, filename=%s, type=%s, task_id=%*phN}",
+		   ep->comm, file ? file : "none", tsem_names[ep->event],
+		   WP256_DIGEST_SIZE, ep->task_id);
+	seq_printf(c, " COE{uid=%d, euid=%d, suid=%d, gid=%d, egid=%d, sgid=%d, fsuid=%d, fsgid=%d, cap=0x%llx} ",
+		   ep->COE.uid, ep->COE.euid, ep->COE.suid, ep->COE.gid,
+		   ep->COE.egid, ep->COE.sgid, ep->COE.fsuid, ep->COE.fsgid,
+		   ep->COE.capability.value);
+}
+
+static void show_file(struct seq_file *c, struct tsem_event *ep)
+{
+	seq_printf(c, "file{flags=%u, uid=%d, gid=%d, mode=0%o, name_length=%u, name=%*phN, s_magic=0x%0x, s_id=%s, s_uuid=%*phN, digest=%*phN}\n",
+		   ep->file.flags, ep->file.uid, ep->file.gid, ep->file.mode,
+		   ep->file.name_length, WP256_DIGEST_SIZE, ep->file.name,
+		   ep->file.s_magic, ep->file.s_id,
+		   (int) sizeof(ep->file.s_uuid), ep->file.s_uuid,
+		   WP256_DIGEST_SIZE, ep->file.digest);
+}
+
+static void show_mmap(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_mmap_file_args *args = &ep->CELL.mmap_file;
+
+	show_event(c, ep, args->file ? ep->pathname : NULL);
+	seq_printf(c, "%s{type=%u, reqprot=%u, prot=%u, flags=%u} ",
+		   tsem_names[ep->event], args->file == NULL,
+		   args->reqprot, args->prot, args->flags);
+
+	if (!args->file)
+		seq_puts(c, "\n");
+	else
+		show_file(c, ep);
+}
+
+static void show_socket_create(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_socket_create_args *args = &ep->CELL.socket_create;
+
+	show_event(c, ep, NULL);
+	seq_printf(c, "%s{family=%u, type=%u, protocol=%u, kern=%u}\n",
+		   tsem_names[ep->event], args->family, args->type,
+		   args->protocol, args->kern);
+}
+
+static void show_socket(struct seq_file *c, struct tsem_event *ep)
+{
+	struct sockaddr_in *ipv4;
+	struct sockaddr_in6 *ipv6;
+	struct tsem_socket_connect_args *scp = &ep->CELL.socket_connect;
+
+	show_event(c, ep, NULL);
+	seq_printf(c, "%s{family=%u, ", tsem_names[ep->event], scp->family);
+
+	switch (scp->family) {
+	case AF_INET:
+		ipv4 = (struct sockaddr_in *) &scp->u.ipv4;
+		seq_printf(c, "port=%u, addr=%u}\n", ipv4->sin_port,
+			   ipv4->sin_addr.s_addr);
+		break;
+	case AF_INET6:
+		ipv6 = (struct sockaddr_in6 *) &scp->u.ipv6;
+		seq_printf(c, "port=%u, flow=%u, scope=%u, addr=%*phN}\n",
+			   ipv6->sin6_port, ipv6->sin6_flowinfo,
+			   ipv6->sin6_scope_id,
+			   (int) sizeof(ipv6->sin6_addr.in6_u.u6_addr8),
+			   ipv6->sin6_addr.in6_u.u6_addr8);
+		break;
+	default:
+		seq_printf(c, "addr=%*phN}\n", WP256_DIGEST_SIZE,
+			   scp->u.mapping);
+		break;
+	}
+}
+
+static void show_socket_accept(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_socket_accept_args *sap = &ep->CELL.socket_accept;
+
+	show_event(c, ep, NULL);
+	seq_printf(c, "%s{family=%u, type=%u, port=%u, addr=",
+		   tsem_names[ep->event], sap->family, sap->type, sap->port);
+
+	switch (sap->family) {
+	case AF_INET:
+		seq_printf(c, "%u}\n", sap->ipv4);
+		break;
+	case AF_INET6:
+		seq_printf(c, "%*phN}\n",
+			   (int) sizeof(sap->ipv6.in6_u.u6_addr8),
+			   sap->ipv6.in6_u.u6_addr8);
+		break;
+	default:
+		seq_printf(c, "%*phN}\n", (int) sizeof(sap->tsip->digest),
+			   sap->tsip->digest);
+		break;
+	}
+}
+
+static void show_task_kill(struct seq_file *c, struct tsem_event *ep)
+{
+	struct tsem_task_kill_args *args = &ep->CELL.task_kill;
+
+	show_event(c, ep, NULL);
+	seq_printf(c, "%s{cross=%u, signal=%u, target=%*phN}\n",
+		   tsem_names[ep->event], args->cross_model, args->signal,
+		   WP256_DIGEST_SIZE, args->target);
+}
+
+static void show_event_generic(struct seq_file *c, struct tsem_event *ep)
+{
+	show_event(c, ep, NULL);
+	seq_printf(c, "%s{type=%s}\n", tsem_names[ep->event],
+		   tsem_names[ep->CELL.event_type]);
+}
+
+static void show_trajectory_event(struct seq_file *c, struct tsem_event *ep)
+{
+	switch (ep->event) {
+	case TSEM_FILE_OPEN:
+		show_event(c, ep, ep->pathname);
+		show_file(c, ep);
+		break;
+	case TSEM_MMAP_FILE:
+		show_mmap(c, ep);
+		break;
+	case TSEM_SOCKET_CREATE:
+		show_socket_create(c, ep);
+		break;
+	case TSEM_SOCKET_CONNECT:
+	case TSEM_SOCKET_BIND:
+		show_socket(c, ep);
+		break;
+	case TSEM_SOCKET_ACCEPT:
+		show_socket_accept(c, ep);
+		break;
+	case TSEM_TASK_KILL:
+		show_task_kill(c, ep);
+		break;
+	case TSEM_GENERIC_EVENT:
+		show_event_generic(c, ep);
+		break;
+	default:
+		break;
+	}
+}
+
+static void *trajectory_start(struct seq_file *c, loff_t *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_lock(&model->trajectory_mutex);
+	return seq_list_start(&model->trajectory_list, *pos);
+}
+
+static void *trajectory_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	return seq_list_next(p, &model->trajectory_list, pos);
+}
+
+static void trajectory_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->trajectory_mutex);
+}
+
+static int trajectory_show(struct seq_file *c, void *trajectory)
+{
+	struct tsem_trajectory *pt;
+	struct tsem_event *ep;
+
+	pt = list_entry(trajectory, struct tsem_trajectory, list);
+	ep = pt->ep;
+
+	show_trajectory_event(c, ep);
+
+	return 0;
+}
+
+static const struct seq_operations trajectory_seqops = {
+	.start = trajectory_start,
+	.next = trajectory_next,
+	.stop = trajectory_stop,
+	.show = trajectory_show
+};
+
+static int trajectory_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &trajectory_seqops);
+}
+
+static const struct file_operations trajectory_ops = {
+	.open = trajectory_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static void *point_start(struct seq_file *c, loff_t *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_lock(&model->point_mutex);
+	return seq_list_start(&model->point_list, *pos);
+}
+
+static void *point_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	return seq_list_next(p, &model->point_list, pos);
+}
+
+static void point_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->point_mutex);
+}
+
+static int point_show(struct seq_file *c, void *point)
+{
+	struct tsem_event_point *id;
+
+	id = list_entry(point, struct tsem_event_point, list);
+	seq_printf(c, "%*phN\n", WP256_DIGEST_SIZE, id->point);
+	return 0;
+}
+
+static const struct seq_operations point_seqops = {
+	.start = point_start,
+	.next = point_next,
+	.stop = point_stop,
+	.show = point_show
+};
+
+static int point_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &point_seqops);
+}
+
+static const struct file_operations point_ops = {
+	.open = point_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int open_control(struct inode *inode, struct file *filp)
+{
+	if (!capable(TSEM_CONTROL_CAPABILITY))
+		return -EACCES;
+	if (!(filp->f_flags & O_WRONLY))
+		return -EACCES;
+	return 0;
+}
+
+static ssize_t write_control(struct file *file, const char __user *buf,
+			     size_t datalen, loff_t *ppos)
+{
+	char *p, *arg, cmdbufr[76];
+	unsigned int lp;
+	ssize_t retn = -EINVAL;
+	long pid;
+	enum tsem_control_type type;
+
+	if (*ppos != 0)
+		goto done;
+	if (datalen > sizeof(cmdbufr)-1)
+		goto done;
+
+	memset(cmdbufr, '\0', sizeof(cmdbufr));
+	if (copy_from_user(cmdbufr, buf, datalen)) {
+		retn = -EFAULT;
+		goto done;
+	}
+
+	p = strchr(cmdbufr, '\n');
+	if (!p)
+		goto done;
+	*p = '\0';
+
+	arg = strchr(cmdbufr, ' ');
+
+	for (lp = 0; lp < ARRAY_SIZE(commands); ++lp) {
+		if (!strncmp(cmdbufr, commands[lp].cmd,
+			     strlen(commands[lp].cmd))) {
+			type = commands[lp].type;
+			break;
+		}
+	}
+
+	switch (type) {
+	case TSEM_CONTROL_EXTERNAL:
+	case TSEM_CONTROL_INTERNAL:
+		retn = tsem_ns_create(type);
+		break;
+	case TSEM_CONTROL_ENFORCE:
+	case TSEM_CONTROL_SEAL:
+		retn = config_context(type, cmdbufr);
+		break;
+	case TSEM_CONTROL_TRUSTED:
+	case TSEM_CONTROL_UNTRUSTED:
+		p = strchr(cmdbufr, ' ');
+		if (!p)
+			goto done;
+		*p++ = '\0';
+		if (kstrtol(p, 0, &pid))
+			goto done;
+		retn = control_COE(pid, type);
+		break;
+	case TSEM_CONTROL_MAP_STATE:
+	case TSEM_CONTROL_MAP_PSEUDONYM:
+	case TSEM_CONTROL_MAP_BASE:
+		retn = config_point(type, arg);
+		break;
+	}
+
+done:
+	if (!retn)
+		retn = datalen;
+	return retn;
+}
+
+static int release_control(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static const struct file_operations control_ops = {
+	.open = open_control,
+	.write = write_control,
+	.release = release_control,
+	.llseek = generic_file_llseek,
+};
+
+static void *forensics_start(struct seq_file *c, loff_t *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_lock(&model->forensics_mutex);
+	return seq_list_start(&model->forensics_list, *pos);
+}
+
+static void *forensics_next(struct seq_file *c, void *p, loff_t *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	return seq_list_next(p, &model->forensics_list, pos);
+}
+
+static void forensics_stop(struct seq_file *c, void *pos)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	mutex_unlock(&model->forensics_mutex);
+}
+
+static int forensics_show(struct seq_file *c, void *event)
+{
+	struct tsem_trajectory *pt;
+	struct tsem_event *ep;
+
+	pt = list_entry(event, struct tsem_trajectory, list);
+	ep = pt->ep;
+
+	show_trajectory_event(c, ep);
+
+	return 0;
+}
+
+static const struct seq_operations forensics_seqops = {
+	.start = forensics_start,
+	.next = forensics_next,
+	.stop = forensics_stop,
+	.show = forensics_show
+};
+
+static int forensics_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return seq_open(file, &forensics_seqops);
+}
+
+static const struct file_operations forensics_ops = {
+	.open = forensics_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int measurement_show(struct seq_file *c, void *event)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	seq_printf(c, "%*phN\n", (int) sizeof(model->measurement),
+		   model->measurement);
+	return 0;
+}
+
+static int measurement_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return single_open(file, &measurement_show, NULL);
+}
+
+static const struct file_operations measurement_ops = {
+	.open = measurement_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int id_show(struct seq_file *c, void *event)
+{
+	seq_printf(c, "%llu\n", tsem_context(current)->id);
+	return 0;
+}
+
+static int id_open(struct inode *inode, struct file *file)
+{
+	struct tsem_TMA_context *ctx = tsem_context(current);
+
+	if (ctx->sealed)
+		return -EACCES;
+	return single_open(file, &id_show, NULL);
+}
+
+static const struct file_operations id_ops = {
+	.open = id_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int state_show(struct seq_file *m, void *v)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	tsem_model_compute_state();
+	seq_printf(m, "%*phN\n", WP256_DIGEST_SIZE, model->state);
+	return 0;
+}
+
+static int state_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return single_open(file, &state_show, NULL);
+}
+
+static const struct file_operations state_ops = {
+	.open = state_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int aggregate_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%*phN\n", WP256_DIGEST_SIZE, tsem_trust_aggregate());
+	return 0;
+}
+
+static int aggregate_open(struct inode *inode, struct file *file)
+{
+	if (!can_access_fs())
+		return -EACCES;
+	return single_open(file, &aggregate_show, NULL);
+}
+
+static const struct file_operations aggregate_ops = {
+	.open = aggregate_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int export_show(struct seq_file *m, void *v)
+{
+	return tsem_export_show(m);
+}
+
+static __poll_t export_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct tsem_TMA_context *ctx = tsem_context(current);
+
+	if (!ctx->external)
+		return -ENOENT;
+
+	poll_wait(file, &ctx->external->wq, wait);
+
+	if (ctx->external->have_event) {
+		ctx->external->have_event = false;
+		return EPOLLIN | EPOLLRDNORM;
+	}
+	return 0;
+}
+
+static int export_open(struct inode *inode, struct file *file)
+{
+	if (!capable(TSEM_CONTROL_CAPABILITY))
+		return -EACCES;
+	return single_open(file, &export_show, NULL);
+}
+
+static const struct file_operations export_ops = {
+	.open = export_open,
+	.poll = export_poll,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int fs_fill(struct super_block *sb, struct fs_context *fc)
+{
+	int retn;
+
+	static const struct tree_descr root_files[] = {
+		[2] = {"control", &control_ops, 0200},
+		[3] = {"id", &id_ops, 0400},
+		[4] = {"trajectory", &trajectory_ops, 0400},
+		[5] = {"forensics", &forensics_ops, 0400},
+		[6] = {"points", &point_ops, 0400},
+		[7] = {"measurement", &measurement_ops, 0400},
+		[8] = {"state", &state_ops, 0400},
+		[9] = {"aggregate", &aggregate_ops, 0400},
+		{""}
+	};
+
+	retn = simple_fill_super(sb, TSEMFS_MAGIC, root_files);
+	if (retn)
+		pr_warn("Unable to create TSEM root filesystem.\n");
+
+	return retn;
+}
+
+static int fs_init_context(struct fs_context *fc)
+{
+	fc->ops = &fs_operations;
+	return 0;
+}
+
+static int fs_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, fs_fill);
+}
+
+static int create_update_directory(void)
+{
+	int retn = 0;
+	struct dentry *root, *dentry;
+	struct inode *root_dir, *inode;
+	static const char *name = "ExternalTMA";
+
+	root = fs_mount->mnt_root;
+	root_dir = d_inode(root);
+
+	inode_lock(root_dir);
+	dentry = lookup_one_len(name, root, strlen(name));
+	if (IS_ERR(dentry)) {
+		retn = PTR_ERR(dentry);
+		goto done;
+	}
+
+	if (d_really_is_positive(dentry)) {
+		retn = -EEXIST;
+		goto done_dentry;
+	}
+
+	inode = new_inode(root_dir->i_sb);
+	if (!inode) {
+		retn = -ENOMEM;
+		goto done_dentry;
+	}
+
+	inode->i_ino = get_next_ino();
+	inode->i_mode = 0755 | S_IFDIR;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_private = NULL;
+	inode->i_fop = &export_ops;
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	inc_nlink(inode);
+	inc_nlink(root_dir);
+
+	d_instantiate(dentry, inode);
+	dget(dentry);
+	external_dentry = dentry;
+	inode_unlock(root_dir);
+	return 0;
+
+ done_dentry:
+	dput(dentry);
+
+ done:
+	inode_unlock(root_dir);
+	return retn;
+}
+
+/**
+ * tesm_fs_init() - Initialize the TSEM control filesystem.
+ *
+ * This function is called as part of the TSEM LSM initialization
+ * process.  It creates the /sys/fs/tsem mount point and populates
+ * the filesystem to be mounted there with the control plane file and
+ * internal TMA model information files.
+ *
+ * Return: If filesystem initialization is successful a return code of 0
+ *	   is returned.  A negative return value is returned if an error
+ *	   is encoutnered.
+ */
+int __init tsem_fs_init(void)
+{
+	int retn;
+
+	retn = sysfs_create_mount_point(fs_kobj, "tsem");
+	if (retn) {
+		pr_warn("Unable to create TSEM filesystem mount point.\n");
+		return retn;
+	}
+
+	retn = register_filesystem(&fs_definition);
+	if (retn) {
+		pr_warn("Unable to register TSEM filesystem.\n");
+		goto done;
+	}
+
+	fs_mount = kern_mount(&fs_definition);
+	if (IS_ERR(fs_mount)) {
+		pr_warn("Unable to mount TSEM filesystem.\n");
+		retn = PTR_ERR(fs_mount);
+		fs_mount = NULL;
+	}
+
+	retn = create_update_directory();
+
+ done:
+	if (retn)
+		sysfs_remove_mount_point(fs_kobj, "tsem");
+	return retn;
+}
+
+/**
+ * tesm_fs_create_external() - Create an external TMA update file.
+ * @id: A pointer to the ASCII representation of the modeling domain
+ *      that the export file is being created for.
+ *
+ * This function is used to create a pseudo-file that will output security
+ * event descriptions for a namespace.  This routine will create the
+ * following file:
+ *
+ * /sys/fs/tsem/ExternalTMA/N
+ *
+ * Where N is replaced with the security model context identifier.
+ *
+ * Return: If creation of the update file is successful a pointer to the
+ *	   dentry of the file is returned.  If an error was encountered
+ *	   an error code is encoded in the pointer.
+ */
+struct dentry *tsem_fs_create_external(const char *name)
+{
+	int retn = 0;
+	struct dentry *dentry;
+	struct inode *root_dir, *inode;
+
+	retn = simple_pin_fs(&fs_definition, &fs_mount, &fs_mount_cnt);
+	if (retn)
+		return ERR_PTR(retn);
+
+	root_dir = d_inode(external_dentry);
+	inode_lock(root_dir);
+
+	dentry = lookup_one_len(name, external_dentry, strlen(name));
+	if (IS_ERR(dentry)) {
+		retn = PTR_ERR(dentry);
+		goto done;
+	}
+	if (d_really_is_positive(dentry)) {
+		WARN_ON_ONCE(1);
+		retn = -EEXIST;
+		goto done_dentry;
+	}
+
+	inode = new_inode(root_dir->i_sb);
+	if (!inode) {
+		retn = -ENOMEM;
+		goto done_dentry;
+	}
+
+	inode->i_ino = get_next_ino();
+	inode->i_mode = 0400 | S_IFREG;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_private = NULL;
+	inode->i_fop = &export_ops;
+
+	d_instantiate(dentry, inode);
+	dget(dentry);
+	inode_unlock(root_dir);
+	return dentry;
+
+ done_dentry:
+	dput(dentry);
+
+ done:
+	inode_unlock(root_dir);
+	simple_release_fs(&fs_mount, &fs_mount_cnt);
+	if (retn)
+		dentry = ERR_PTR(retn);
+	return dentry;
+}
+
+/**
+ * tesm_fs_remove_external() - Remove an external modeling update file.
+ * @dentry: A pointer to the dentry of the file to be removed.
+ *
+ * This function is used to remove the update file for an externally
+ * modeled security domain.
+ */
+void tsem_fs_remove_external(struct dentry *dentry)
+{
+	struct inode *root_dir;
+
+	if (!dentry || IS_ERR(dentry)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	root_dir = d_inode(dentry->d_parent);
+
+	inode_lock(root_dir);
+	if (simple_positive(dentry)) {
+		simple_unlink(root_dir, dentry);
+		dput(dentry);
+	}
+	inode_unlock(root_dir);
+
+	simple_release_fs(&fs_mount, &fs_mount_cnt);
+}
-- 
2.39.1

