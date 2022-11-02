Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7D8616A38
	for <lists+linux-security-module@lfdr.de>; Wed,  2 Nov 2022 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiKBRMT (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 2 Nov 2022 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiKBRLi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Nov 2022 13:11:38 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F891B9D6
        for <linux-security-module@vger.kernel.org>; Wed,  2 Nov 2022 10:11:34 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A2HAuiD021888;
        Thu, 3 Nov 2022 02:10:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Thu, 03 Nov 2022 02:10:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A2HAnkI021849
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Nov 2022 02:10:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 07/10] CaitSith: Add permission checking functions.
Date:   Thu,  3 Nov 2022 02:10:22 +0900
Message-Id: <20221102171025.126961-7-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This file implements similar functions provided by many of
security/tomoyo/*.c files.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/caitsith/permission.c | 2746 ++++++++++++++++++++++++++++++++
 1 file changed, 2746 insertions(+)
 create mode 100644 security/caitsith/permission.c

diff --git a/security/caitsith/permission.c b/security/caitsith/permission.c
new file mode 100644
index 000000000000..0fd29e7f5d0a
--- /dev/null
+++ b/security/caitsith/permission.c
@@ -0,0 +1,2746 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * permission.c
+ *
+ * Copyright (C) 2005-2012  NTT DATA CORPORATION
+ *
+ * Version: 0.2.10   2021/06/06
+ */
+
+#include "caitsith.h"
+
+/***** SECTION1: Constants definition *****/
+
+/* String table for special mount operations. */
+static const char * const cs_mounts[CS_MAX_SPECIAL_MOUNT] = {
+	[CS_MOUNT_BIND]            = "--bind",
+	[CS_MOUNT_MOVE]            = "--move",
+	[CS_MOUNT_REMOUNT]         = "--remount",
+	[CS_MOUNT_MAKE_UNBINDABLE] = "--make-unbindable",
+	[CS_MOUNT_MAKE_PRIVATE]    = "--make-private",
+	[CS_MOUNT_MAKE_SLAVE]      = "--make-slave",
+	[CS_MOUNT_MAKE_SHARED]     = "--make-shared",
+};
+
+#ifdef CONFIG_SECURITY_CAITSITH_CAPABILITY
+
+/*
+ * Mapping table from "enum cs_capability_acl_index" to "enum cs_mac_index".
+ */
+static const u8 cs_c2mac[CS_MAX_CAPABILITY_INDEX] = {
+	[CS_USE_ROUTE_SOCKET]  = CS_MAC_USE_NETLINK_SOCKET,
+	[CS_USE_PACKET_SOCKET] = CS_MAC_USE_PACKET_SOCKET,
+};
+
+#endif
+
+/* Type of condition argument. */
+enum cs_arg_type {
+	CS_ARG_TYPE_NONE,
+	CS_ARG_TYPE_NUMBER,
+	CS_ARG_TYPE_NAME,
+	CS_ARG_TYPE_GROUP,
+	CS_ARG_TYPE_BITOP,
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+	CS_ARG_TYPE_IPV4ADDR,
+	CS_ARG_TYPE_IPV6ADDR,
+#endif
+} __packed;
+
+/***** SECTION2: Structure definition *****/
+
+/* Structure for holding inet domain socket's address. */
+struct cs_inet_addr_info {
+	u16 port;          /* In network byte order. */
+	const u8 *address; /* In network byte order. */
+	bool is_ipv6;
+};
+
+/* Structure for holding unix domain socket's address. */
+struct cs_unix_addr_info {
+	u8 *addr; /* This may not be '\0' terminated string. */
+	unsigned int addr_len;
+};
+
+/* Structure for holding socket address. */
+struct cs_addr_info {
+	u8 operation;
+	struct cs_inet_addr_info inet;
+	struct cs_unix_addr_info unix0;
+};
+
+/* Structure for holding single condition component. */
+struct cs_cond_arg {
+	enum cs_arg_type type;
+	unsigned long value[2];
+	const struct cs_path_info *name;
+	const struct cs_group *group;
+	struct in6_addr ip[2];
+};
+
+/***** SECTION3: Prototype definition section *****/
+
+static bool cs_alphabet_char(const char c);
+static bool cs_byte_range(const char *str);
+static bool cs_check_entry(struct cs_request_info *r,
+			   const struct cs_acl_info *ptr);
+static bool cs_condition(struct cs_request_info *r,
+			 const struct cs_condition *cond);
+static bool cs_file_matches_pattern(const char *filename,
+				    const char *filename_end,
+				    const char *pattern,
+				    const char *pattern_end);
+static bool cs_file_matches_pattern2(const char *filename,
+				     const char *filename_end,
+				     const char *pattern,
+				     const char *pattern_end);
+static bool cs_number_matches_group(const unsigned long min,
+				    const unsigned long max,
+				    const struct cs_group *group);
+static bool cs_path_matches_pattern(const struct cs_path_info *filename,
+				    const struct cs_path_info *pattern);
+static bool cs_path_matches_pattern2(const char *f, const char *p);
+static bool cs_path_matches_group(const struct cs_path_info *pathname,
+				  const struct cs_group *group);
+static int cs_execute_path(struct linux_binprm *bprm, struct path *path);
+static int cs_execute(struct cs_request_info *r);
+static int cs_kern_path(const char *pathname, int flags, struct path *path);
+static int cs_mkdev_perm(const u8 operation, const struct path *path,
+			 const unsigned int mode, unsigned int dev);
+static int cs_mount_acl(const char *dev_name, const struct path *dir,
+			const char *type, unsigned long flags,
+			const char *data);
+static int cs_path2_perm(const enum cs_mac_index operation,
+			 const struct path *path1, const struct path *path2);
+static int cs_path_number_perm(const enum cs_mac_index type,
+			       const struct path *path, unsigned long number);
+static int cs_path_perm(const enum cs_mac_index operation,
+			const struct path *path);
+static void cs_check_auto_domain_transition(void);
+static void cs_clear_request_info(struct cs_request_info *r);
+
+#ifdef CONFIG_SECURITY_CAITSITH_ENVIRON
+static int cs_env_perm(struct cs_request_info *r, const char *name,
+		       const char *value);
+static int cs_environ(struct cs_request_info *r);
+#endif
+
+#ifdef CONFIG_SECURITY_CAITSITH_CAPABILITY
+static bool cs_kernel_service(void);
+#endif
+
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+static bool cs_ip_matches_group(const bool is_ipv6, const u8 *address,
+				const struct cs_group *group);
+static bool cs_kernel_service(void);
+static int cs_check_inet_address(const struct sockaddr *addr,
+				 const unsigned int addr_len, const u16 port,
+				 struct cs_addr_info *address);
+static int cs_check_unix_address(struct sockaddr *addr,
+				 const unsigned int addr_len,
+				 struct cs_addr_info *address);
+static int cs_inet_entry(const struct cs_addr_info *address);
+static int cs_unix_entry(const struct cs_addr_info *address);
+static u8 cs_sock_family(struct sock *sk);
+#endif
+
+/***** SECTION4: Standalone functions section *****/
+
+/**
+ * cs_put_filesystem - Wrapper for put_filesystem().
+ *
+ * @fstype: Pointer to "struct file_system_type".
+ *
+ * Returns nothing.
+ *
+ * Since put_filesystem() is not exported, I embed put_filesystem() here.
+ */
+static inline void cs_put_filesystem(struct file_system_type *fstype)
+{
+	module_put(fstype->owner);
+}
+
+/***** SECTION5: Variables definition section *****/
+
+/* The initial domain. */
+struct cs_domain_info cs_kernel_domain;
+
+/* The list for "struct cs_domain_info". */
+LIST_HEAD(cs_domain_list);
+
+/* The list for ACL policy. */
+struct list_head cs_acl_list[CS_MAX_MAC_INDEX];
+
+/* NULL value. */
+struct cs_path_info cs_null_name;
+
+/***** SECTION6: Dependent functions section *****/
+
+/**
+ * cs_path_matches_group - Check whether the given pathname matches members of the given pathname group.
+ *
+ * @pathname: The name of pathname.
+ * @group:    Pointer to "struct cs_string_group".
+ *
+ * Returns true if @pathname matches pathnames in @group, false otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static bool cs_path_matches_group(const struct cs_path_info *pathname,
+				  const struct cs_group *group)
+{
+	struct cs_string_group *member;
+
+	list_for_each_entry_srcu(member, &group->member_list, head.list,
+				 &cs_ss) {
+		if (member->head.is_deleted)
+			continue;
+		if (!cs_path_matches_pattern(pathname, member->member_name))
+			continue;
+		return true;
+	}
+	return false;
+}
+
+/**
+ * cs_number_matches_group - Check whether the given number matches members of the given number group.
+ *
+ * @min:   Min number.
+ * @max:   Max number.
+ * @group: Pointer to "struct cs_number_group".
+ *
+ * Returns true if @min and @max partially overlaps @group, false otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static bool cs_number_matches_group(const unsigned long min,
+				    const unsigned long max,
+				    const struct cs_group *group)
+{
+	struct cs_number_group *member;
+	bool matched = false;
+
+	list_for_each_entry_srcu(member, &group->member_list, head.list,
+				 &cs_ss) {
+		if (member->head.is_deleted)
+			continue;
+		if (min > member->value[1] || max < member->value[0])
+			continue;
+		matched = true;
+		break;
+	}
+	return matched;
+}
+
+/**
+ * cs_check_entry - Do permission check.
+ *
+ * @r:   Pointer to "struct cs_request_info".
+ * @ptr: Pointer to "struct cs_acl_info".
+ *
+ * Returns true on match, false otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static bool cs_check_entry(struct cs_request_info *r,
+			   const struct cs_acl_info *ptr)
+{
+	return !ptr->is_deleted && cs_condition(r, ptr->cond);
+}
+
+/**
+ * cs_check_acl_list - Do permission check.
+ *
+ * @r: Pointer to "struct cs_request_info".
+ *
+ * Returns 0 on success, negative value otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static int cs_check_acl_list(struct cs_request_info *r)
+{
+	struct cs_acl_info *ptr;
+	int error = 0;
+	struct list_head * const list = &cs_acl_list[r->type];
+
+	r->matched_acl = NULL;
+	list_for_each_entry_srcu(ptr, list, list, &cs_ss) {
+		struct cs_acl_info *ptr2;
+retry:
+		if (!cs_check_entry(r, ptr)) {
+			if (unlikely(r->failed_by_oom))
+				goto oom;
+			continue;
+		}
+		r->matched_acl = ptr;
+		r->audit = ptr->audit;
+		r->result = CS_MATCHING_UNMATCHED;
+		list_for_each_entry_srcu(ptr2, &ptr->acl_info_list, list,
+					 &cs_ss) {
+			r->transition_candidate = NULL;
+			if (!cs_check_entry(r, ptr2)) {
+				if (unlikely(r->failed_by_oom))
+					goto oom;
+				continue;
+			}
+			if (ptr2->is_deny) {
+				r->result = CS_MATCHING_DENIED;
+				break;
+			}
+			r->result = CS_MATCHING_ALLOWED;
+			/* Set the first matching domain transition entry. */
+			if (r->transition_candidate && !r->transition)
+				r->transition = r->transition_candidate;
+			break;
+		}
+		error = cs_audit_log(r);
+		/* Ignore out of memory during audit. */
+		r->failed_by_oom = false;
+		if (!error)
+			continue;
+		if (error == CS_RETRY_REQUEST)
+			goto retry;
+		break;
+	}
+	return error;
+oom:
+	/*
+	 * If conditions could not be checked due to out of memory,
+	 * reject the request with -ENOMEM, for we don't know whether
+	 * there was a possibility of matching "deny" lines or not.
+	 */
+	{
+		static unsigned long cs_last_oom;
+		unsigned long oom = ktime_get_real_seconds();
+
+		if (oom != cs_last_oom) {
+			cs_last_oom = oom;
+			pr_info("CaitSith: Rejecting access request due to out of memory.\n");
+		}
+	}
+	return -ENOMEM;
+}
+
+/**
+ * cs_check_acl - Do permission check.
+ *
+ * @r:     Pointer to "struct cs_request_info".
+ * @clear: True to cleanup @r before return, false otherwise.
+ *
+ * Returns 0 on success, negative value otherwise.
+ *
+ * If "transition=" part was specified to "allow" entries of non "execute" acl
+ * but transition to that domain failed due to e.g. memory quota, the current
+ * thread will be killed by SIGKILL.
+ */
+int cs_check_acl(struct cs_request_info *r, const bool clear)
+{
+	int error;
+	const int idx = cs_read_lock();
+
+	error = cs_check_acl_list(r);
+	if (r->transition && r->transition != &cs_null_name &&
+	    r->result == CS_MATCHING_ALLOWED && r->type != CS_MAC_EXECUTE &&
+	    !cs_transit_domain(r->transition->name)) {
+		pr_warn("ERROR: Unable to transit to '%s' domain.\n",
+			r->transition->name);
+		force_sig(SIGKILL);
+	}
+	cs_read_unlock(idx);
+	if (clear)
+		cs_clear_request_info(r);
+	return error;
+}
+
+/**
+ * cs_execute - Check permission for "execute".
+ *
+ * @r: Pointer to "struct cs_request_info".
+ *
+ * Returns 0 on success, negative value otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static int cs_execute(struct cs_request_info *r)
+{
+	int retval;
+
+	/* Get symlink's dentry/vfsmount. */
+	retval = cs_execute_path(r->bprm, &r->obj.path[1]);
+	if (retval < 0)
+		return retval;
+	cs_populate_patharg(r, false);
+	if (!r->param.s[1])
+		return -ENOMEM;
+
+	/* Check execute permission. */
+	r->type = CS_MAC_EXECUTE;
+	retval = cs_check_acl(r, false);
+	if (retval < 0)
+		return retval;
+	/*
+	 * Tell GC that I started execve().
+	 * Also, tell open_exec() to check read permission.
+	 */
+	cs_current_security()->cs_flags |= CS_TASK_IS_IN_EXECVE;
+	if (!r->transition || r->transition == &cs_null_name)
+		/* Keep current domain. */
+		return 0;
+	/*
+	 * Make cs_current_security()->cs_flags visible to GC before changing
+	 * cs_current_security()->cs_domain_info.
+	 */
+	smp_wmb();
+	/*
+	 * Transit to the specified domain.
+	 * It will be reverted if execve() failed.
+	 */
+	if (cs_transit_domain(r->transition->name))
+		return 0;
+	pr_warn("ERROR: Domain '%s' not ready.\n",
+		r->transition->name);
+	return -ENOMEM;
+}
+
+/**
+ * cs_dump_page - Dump a page to buffer.
+ *
+ * @bprm: Pointer to "struct linux_binprm".
+ * @pos:  Location to dump.
+ * @dump: Pointer to "struct cs_page_dump".
+ *
+ * Returns true on success, false otherwise.
+ */
+bool cs_dump_page(struct linux_binprm *bprm, unsigned long pos,
+		  struct cs_page_dump *dump)
+{
+	struct page *page;
+	int ret;
+
+	/* dump->data is released by cs_start_execve(). */
+	if (!dump->data) {
+		dump->data = kzalloc(PAGE_SIZE, GFP_NOFS);
+		if (!dump->data)
+			return false;
+	}
+	/* Same with get_arg_page(bprm, pos, 0) in fs/exec.c */
+#ifdef CONFIG_MMU
+	mmap_read_lock(bprm->mm);
+	ret = get_user_pages_remote(bprm->mm, pos, 1, FOLL_FORCE, &page, NULL, NULL);
+	mmap_read_unlock(bprm->mm);
+	if (ret <= 0)
+		return false;
+#else
+	page = bprm->page[pos / PAGE_SIZE];
+#endif
+	if (page != dump->page) {
+		const unsigned int offset = pos % PAGE_SIZE;
+		/*
+		 * Maybe kmap()/kunmap() should be used here.
+		 * But remove_arg_zero() uses kmap_atomic()/kunmap_atomic().
+		 * So do I.
+		 */
+		char *kaddr = kmap_atomic(page);
+
+		dump->page = page;
+		memcpy(dump->data + offset, kaddr + offset,
+		       PAGE_SIZE - offset);
+		kunmap_atomic(kaddr);
+	}
+	/* Same with put_arg_page(page) in fs/exec.c */
+#ifdef CONFIG_MMU
+	put_page(page);
+#endif
+	return true;
+}
+
+/**
+ * cs_start_execve - Prepare for execve() operation.
+ *
+ * @bprm: Pointer to "struct linux_binprm".
+ * @rp:   Pointer to "struct cs_request_info *".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_start_execve(struct linux_binprm *bprm, struct cs_request_info **rp)
+{
+	int retval;
+	struct cs_security *task = cs_current_security();
+	struct cs_request_info *r;
+	int idx;
+	*rp = NULL;
+	r = kzalloc(sizeof(*r), GFP_NOFS);
+	if (!r)
+		return -ENOMEM;
+	r->tmp = kzalloc(CS_EXEC_TMPSIZE, GFP_NOFS);
+	if (!r->tmp) {
+		kfree(r);
+		return -ENOMEM;
+	}
+	idx = cs_read_lock();
+	/* r->dump->data is allocated by cs_dump_page(). */
+	r->previous_domain = task->cs_domain_info;
+	/* Clear manager flag. */
+	task->cs_flags &= ~CS_TASK_IS_MANAGER;
+	*rp = r;
+	r->bprm = bprm;
+	r->obj.path[0] = bprm->file->f_path;
+	retval = cs_execute(r);
+#ifdef CONFIG_SECURITY_CAITSITH_ENVIRON
+	if (!retval && bprm->envc)
+		retval = cs_environ(r);
+#endif
+	cs_clear_request_info(r);
+	/* Drop refcount obtained by cs_execute_path(). */
+	if (r->obj.path[1].dentry) {
+		path_put(&r->obj.path[1]);
+		r->obj.path[1].dentry = NULL;
+	}
+	cs_read_unlock(idx);
+	kfree(r->tmp);
+	r->tmp = NULL;
+	kfree(r->dump.data);
+	r->dump.data = NULL;
+	return retval;
+}
+
+/**
+ * cs_finish_execve - Clean up execve() operation.
+ *
+ * @retval: Return code of an execve() operation.
+ * @r:      Pointer to "struct cs_request_info".
+ *
+ * Returns nothing.
+ */
+void cs_finish_execve(int retval, struct cs_request_info *r)
+{
+	struct cs_security *task;
+
+	if (!r)
+		return;
+	task = cs_current_security();
+	if (retval < 0) {
+		task->cs_domain_info = r->previous_domain;
+		/*
+		 * Make task->cs_domain_info visible to GC before changing
+		 * task->cs_flags.
+		 */
+		smp_wmb();
+	}
+	/* Tell GC that I finished execve(). */
+	task->cs_flags &= ~CS_TASK_IS_IN_EXECVE;
+	cs_clear_request_info(r);
+	kfree(r);
+}
+
+/**
+ * cs_kern_path - Wrapper for kern_path().
+ *
+ * @pathname: Pathname to resolve. Maybe NULL.
+ * @flags:    Lookup flags.
+ * @path:     Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_kern_path(const char *pathname, int flags, struct path *path)
+{
+	if (!pathname || kern_path(pathname, flags, path))
+		return -ENOENT;
+	return 0;
+}
+
+/**
+ * cs_execute_path - Get dentry/vfsmount of a program.
+ *
+ * @bprm: Pointer to "struct linux_binprm".
+ * @path: Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_execute_path(struct linux_binprm *bprm, struct path *path)
+{
+	/*
+	 * Follow symlinks if the requested pathname is on procfs, for
+	 * /proc/\$/exe is meaningless.
+	 */
+	const unsigned int follow =
+		(bprm->file->f_path.dentry->d_sb->s_magic == PROC_SUPER_MAGIC)
+		? LOOKUP_FOLLOW : 0;
+	if (cs_kern_path(bprm->filename, follow, path))
+		return -ENOENT;
+	return 0;
+}
+
+/**
+ * cs_mount_acl - Check permission for mount() operation.
+ *
+ * @dev_name: Name of device file or mount source. Maybe NULL.
+ * @dir:      Pointer to "struct path".
+ * @type:     Name of filesystem type. Maybe NULL.
+ * @flags:    Mount options.
+ * @data:     Mount options not in @flags. Maybe NULL.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_mount_acl(const char *dev_name, const struct path *dir,
+			const char *type, unsigned long flags,
+			const char *data)
+{
+	struct cs_request_info r = { };
+	struct cs_path_info rtype = { };
+	struct cs_path_info rdata = { };
+	bool check_dev = false;
+	bool check_data = false;
+	int error;
+
+	/* Compare fstype in order to determine type of dev_name argument. */
+	if (type == cs_mounts[CS_MOUNT_REMOUNT]) {
+		/* do_remount() case. */
+		if (data && !(dir->mnt->mnt_sb->s_type->fs_flags &
+			      FS_BINARY_MOUNTDATA))
+			check_data = true;
+	} else if (type == cs_mounts[CS_MOUNT_BIND]) {
+		/* do_loopback() case. */
+		check_dev = true;
+	} else if (type == cs_mounts[CS_MOUNT_MAKE_UNBINDABLE] ||
+		   type == cs_mounts[CS_MOUNT_MAKE_PRIVATE] ||
+		   type == cs_mounts[CS_MOUNT_MAKE_SLAVE] ||
+		   type == cs_mounts[CS_MOUNT_MAKE_SHARED]) {
+		/* do_change_type() case. */
+	} else if (type == cs_mounts[CS_MOUNT_MOVE]) {
+		/* do_move_mount() case. */
+		check_dev = true;
+	} else {
+		/* do_new_mount() case. */
+		struct file_system_type *fstype;
+
+		if (!type)
+			return -EINVAL;
+		fstype = get_fs_type(type);
+		if (!fstype)
+			return -ENODEV;
+		if (fstype->fs_flags & FS_REQUIRES_DEV)
+			check_dev = true;
+		if (data && !(fstype->fs_flags & FS_BINARY_MOUNTDATA))
+			check_data = true;
+		cs_put_filesystem(fstype);
+	}
+	/* Start filling arguments. */
+	r.type = CS_MAC_MOUNT;
+	/* Remember mount options. */
+	r.param.i[0] = flags;
+	/*
+	 * Remember mount point.
+	 * r.param.s[1] is calculated from r.obj.path[1] as needed.
+	 */
+	r.obj.path[1] = *dir;
+	/* Remember fstype. */
+	rtype.name = cs_encode(type);
+	if (!rtype.name)
+		return -ENOMEM;
+	cs_fill_path_info(&rtype);
+	r.param.s[2] = &rtype;
+	if (check_data) {
+		/* Remember data argument. */
+		rdata.name = cs_encode(data);
+		if (!rdata.name) {
+			error = -ENOMEM;
+			goto out;
+		}
+		cs_fill_path_info(&rdata);
+		r.param.s[3] = &rdata;
+	}
+	if (check_dev) {
+		/*
+		 * Remember device file or mount source.
+		 * r.param.s[0] is calculated from r.obj.path[0] as needed.
+		 */
+		if (cs_kern_path(dev_name, LOOKUP_FOLLOW, &r.obj.path[0])) {
+			error = -ENOENT;
+			goto out;
+		}
+	}
+	error = cs_check_acl(&r, false);
+	/* Drop refcount obtained by cs_kern_path(). */
+	if (check_dev)
+		path_put(&r.obj.path[0]);
+out:
+	kfree(rtype.name);
+	kfree(rdata.name);
+	cs_clear_request_info(&r);
+	return error;
+}
+
+/**
+ * cs_mount_permission - Check permission for mount() operation.
+ *
+ * @dev_name:  Name of device file. Maybe NULL.
+ * @path:      Pointer to "struct path".
+ * @type:      Name of filesystem type. Maybe NULL.
+ * @flags:     Mount options.
+ * @data_page: Mount options not in @flags. Maybe NULL.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_mount_permission(const char *dev_name, const struct path *path,
+			const char *type, unsigned long flags,
+			void *data_page)
+{
+	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
+		flags &= ~MS_MGC_MSK;
+	if (flags & MS_REMOUNT) {
+		type = cs_mounts[CS_MOUNT_REMOUNT];
+		flags &= ~MS_REMOUNT;
+	} else if (flags & MS_BIND) {
+		type = cs_mounts[CS_MOUNT_BIND];
+		flags &= ~MS_BIND;
+	} else if (flags & MS_SHARED) {
+		if (flags & (MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
+			return -EINVAL;
+		type = cs_mounts[CS_MOUNT_MAKE_SHARED];
+		flags &= ~MS_SHARED;
+	} else if (flags & MS_PRIVATE) {
+		if (flags & (MS_SHARED | MS_SLAVE | MS_UNBINDABLE))
+			return -EINVAL;
+		type = cs_mounts[CS_MOUNT_MAKE_PRIVATE];
+		flags &= ~MS_PRIVATE;
+	} else if (flags & MS_SLAVE) {
+		if (flags & (MS_SHARED | MS_PRIVATE | MS_UNBINDABLE))
+			return -EINVAL;
+		type = cs_mounts[CS_MOUNT_MAKE_SLAVE];
+		flags &= ~MS_SLAVE;
+	} else if (flags & MS_UNBINDABLE) {
+		if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE))
+			return -EINVAL;
+		type = cs_mounts[CS_MOUNT_MAKE_UNBINDABLE];
+		flags &= ~MS_UNBINDABLE;
+	} else if (flags & MS_MOVE) {
+		type = cs_mounts[CS_MOUNT_MOVE];
+		flags &= ~MS_MOVE;
+	}
+	/*
+	 * do_mount() terminates data_page with '\0' if data_page != NULL.
+	 * Therefore, it is safe to pass data_page argument to cs_mount_acl()
+	 * as "const char *" rather than "void *".
+	 */
+	cs_check_auto_domain_transition();
+	return cs_mount_acl(dev_name, path, type, flags, data_page);
+}
+
+/**
+ * cs_move_mount_permission - Check permission for move_mount() operation.
+ *
+ * @from_path: Pointer to "struct path".
+ * @to_path:   Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_move_mount_permission(const struct path *from_path,
+			     const struct path *to_path)
+{
+	return 0; /* For now. */
+}
+
+/**
+ * cs_open_permission - Check permission for "read" and "write".
+ *
+ * @path: Pointer to "struct path".
+ * @flag: Flags for open().
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_open_permission(const struct path *path, const int flag)
+{
+	struct cs_request_info r = { };
+	const u32 cs_flags = cs_current_flags();
+	const u8 acc_mode = (flag & 3) == 3 ? 0 : ACC_MODE(flag);
+	int error = 0;
+
+	if (current->in_execve && !(cs_flags & CS_TASK_IS_IN_EXECVE))
+		return 0;
+#ifndef CONFIG_SECURITY_CAITSITH_READDIR
+	if (d_is_dir(path->dentry))
+		return 0;
+#endif
+	r.obj.path[0] = *path;
+	if (!(cs_flags & CS_TASK_IS_IN_EXECVE))
+		cs_check_auto_domain_transition();
+	if (acc_mode & MAY_READ) {
+		r.type = CS_MAC_READ;
+		error = cs_check_acl(&r, false);
+	}
+	if (!error && (acc_mode & MAY_WRITE)) {
+		r.type = (flag & O_APPEND) ? CS_MAC_APPEND : CS_MAC_WRITE;
+		error = cs_check_acl(&r, false);
+	}
+	cs_clear_request_info(&r);
+	return error;
+}
+
+/**
+ * cs_path_perm - Check permission for "unlink", "rmdir", "truncate", "append", "getattr" and "chroot".
+ *
+ * @operation: One of values in "enum cs_mac_index".
+ * @path:      Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path_perm(const enum cs_mac_index operation,
+			const struct path *path)
+{
+	struct cs_request_info r = { };
+
+	cs_check_auto_domain_transition();
+	r.type = operation;
+	r.obj.path[0] = *path;
+	return cs_check_acl(&r, true);
+}
+
+/**
+ * cs_mkdev_perm - Check permission for "mkblock" and "mkchar".
+ *
+ * @operation: Type of operation. (CS_MAC_MKCHAR or CS_MAC_MKBLOCK)
+ * @path:      Pointer to "struct path".
+ * @mode:      Create mode.
+ * @dev:       Device number.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_mkdev_perm(const u8 operation, const struct path *path,
+			 const unsigned int mode, unsigned int dev)
+{
+	struct cs_request_info r = { };
+
+	cs_check_auto_domain_transition();
+	r.obj.path[0] = *path;
+#ifdef CONFIG_SECURITY_PATH
+	dev = new_decode_dev(dev);
+#endif
+	r.type = operation;
+	r.param.i[0] = mode;
+	r.param.i[1] = MAJOR(dev);
+	r.param.i[2] = MINOR(dev);
+	return cs_check_acl(&r, true);
+}
+
+/**
+ * cs_path2_perm - Check permission for "rename", "link" and "pivot_root".
+ *
+ * @operation: One of values in "enum cs_mac_index".
+ * @path1:     Pointer to "struct path".
+ * @path2:     Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path2_perm(const enum cs_mac_index operation,
+			 const struct path *path1, const struct path *path2)
+{
+	struct cs_request_info r = { };
+
+	cs_check_auto_domain_transition();
+	r.type = operation;
+	r.obj.path[0] = *path1;
+	r.obj.path[1] = *path2;
+	return cs_check_acl(&r, true);
+}
+
+/**
+ * cs_symlink_permission - Check permission for "symlink".
+ *
+ * @path:   Pointer to "struct path".
+ * @target: Content of symlink.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_symlink_permission(const struct path *path, const char *target)
+{
+	struct cs_request_info r = { };
+
+	cs_check_auto_domain_transition();
+	r.type = CS_MAC_SYMLINK;
+	r.obj.path[0] = *path;
+	r.obj.pathname[1].name = cs_encode(target);
+	if (!r.obj.pathname[1].name)
+		return -ENOMEM;
+	cs_fill_path_info(&r.obj.pathname[1]);
+	r.param.s[1] = &r.obj.pathname[1];
+	return cs_check_acl(&r, true);
+}
+
+/**
+ * cs_path_number_perm - Check permission for "create", "mkdir", "mkfifo", "mksock", "ioctl", "chmod", "chown", "chgrp" and "unmount".
+ *
+ * @type:   One of values in "enum cs_mac_index".
+ * @path:   Pointer to "struct path".
+ * @number: Number.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path_number_perm(const enum cs_mac_index type,
+			       const struct path *path, unsigned long number)
+{
+	struct cs_request_info r = { };
+
+	cs_check_auto_domain_transition();
+	r.type = type;
+	r.obj.path[0] = *path;
+	r.param.i[0] = number;
+	return cs_check_acl(&r, true);
+}
+
+/**
+ * cs_ioctl_permission - Check permission for "ioctl".
+ *
+ * @filp: Pointer to "struct file".
+ * @cmd:  Ioctl command number.
+ * @arg:  Param for @cmd.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_ioctl_permission(struct file *filp, unsigned int cmd,
+			unsigned long arg)
+{
+	return cs_path_number_perm(CS_MAC_IOCTL, &filp->f_path, cmd);
+}
+
+/**
+ * cs_chmod_permission - Check permission for "chmod".
+ *
+ * @path: Pointer to "struct path".
+ * @mode: Mode.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_chmod_permission(const struct path *path, mode_t mode)
+{
+	return cs_path_number_perm(CS_MAC_CHMOD, path, mode & S_IALLUGO);
+}
+
+/**
+ * cs_chown_permission - Check permission for "chown/chgrp".
+ *
+ * @path:  Pointer to "struct path".
+ * @user:  User ID.
+ * @group: Group ID.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_chown_permission(const struct path *path, kuid_t user, kgid_t group)
+{
+	int error = 0;
+
+	if (uid_valid(user))
+		error = cs_path_number_perm(CS_MAC_CHOWN, path,
+					    from_kuid(&init_user_ns, user));
+	if (!error && gid_valid(group))
+		error = cs_path_number_perm(CS_MAC_CHGRP, path,
+					    from_kgid(&init_user_ns, group));
+	return error;
+}
+
+/**
+ * cs_fcntl_permission - Check permission for changing O_APPEND flag.
+ *
+ * @file: Pointer to "struct file".
+ * @cmd:  Command number.
+ * @arg:  Value for @cmd.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_fcntl_permission(struct file *file, unsigned int cmd,
+			unsigned long arg)
+{
+	if (!(cmd == F_SETFL && ((arg ^ file->f_flags) & O_APPEND)))
+		return 0;
+	return cs_open_permission(&file->f_path, O_WRONLY | (arg & O_APPEND));
+}
+
+/**
+ * cs_pivot_root_permission - Check permission for pivot_root().
+ *
+ * @old_path: Pointer to "struct path".
+ * @new_path: Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_pivot_root_permission(const struct path *old_path,
+			     const struct path *new_path)
+{
+	return cs_path2_perm(CS_MAC_PIVOT_ROOT, new_path, old_path);
+}
+
+/**
+ * cs_chroot_permission - Check permission for chroot().
+ *
+ * @path: Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_chroot_permission(const struct path *path)
+{
+	return cs_path_perm(CS_MAC_CHROOT, path);
+}
+
+/**
+ * cs_umount_permission - Check permission for unmount.
+ *
+ * @path:  Pointer to "struct path".
+ * @flags: Unmount flags.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_umount_permission(const struct path *path, int flags)
+{
+	return cs_path_number_perm(CS_MAC_UMOUNT, path, flags);
+}
+
+/**
+ * cs_mknod_permission - Check permission for vfs_mknod().
+ *
+ * @path: Pointer to "struct path".
+ * @mode: Device type and permission.
+ * @dev:  Device number for block or character device.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_mknod_permission(const struct path *path, const unsigned int mode,
+			unsigned int dev)
+{
+	int error = 0;
+	const unsigned int perm = mode & S_IALLUGO;
+
+	switch (mode & S_IFMT) {
+	case S_IFCHR:
+		error = cs_mkdev_perm(CS_MAC_MKCHAR, path, perm, dev);
+		break;
+	case S_IFBLK:
+		error = cs_mkdev_perm(CS_MAC_MKBLOCK, path, perm, dev);
+		break;
+	case S_IFIFO:
+		error = cs_path_number_perm(CS_MAC_MKFIFO, path, perm);
+		break;
+	case S_IFSOCK:
+		error = cs_path_number_perm(CS_MAC_MKSOCK, path, perm);
+		break;
+	case 0:
+	case S_IFREG:
+		error = cs_path_number_perm(CS_MAC_CREATE, path, perm);
+		break;
+	}
+	return error;
+}
+
+/**
+ * cs_mkdir_permission - Check permission for vfs_mkdir().
+ *
+ * @path: Pointer to "struct path".
+ * @mode: Create mode.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_mkdir_permission(const struct path *path, unsigned int mode)
+{
+	return cs_path_number_perm(CS_MAC_MKDIR, path, mode);
+}
+
+/**
+ * cs_rmdir_permission - Check permission for vfs_rmdir().
+ *
+ * @path: Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_rmdir_permission(const struct path *path)
+{
+	return cs_path_perm(CS_MAC_RMDIR, path);
+}
+
+/**
+ * cs_unlink_permission - Check permission for vfs_unlink().
+ *
+ * @path: Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_unlink_permission(const struct path *path)
+{
+	return cs_path_perm(CS_MAC_UNLINK, path);
+}
+
+#ifdef CONFIG_SECURITY_CAITSITH_GETATTR
+
+/**
+ * cs_getattr_permission - Check permission for vfs_getattr().
+ *
+ * @path: Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_getattr_permission(const struct path *path)
+{
+	return cs_path_perm(CS_MAC_GETATTR, path);
+}
+
+#endif
+
+/**
+ * cs_truncate_permission - Check permission for notify_change().
+ *
+ * @path: Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_truncate_permission(const struct path *path)
+{
+	return cs_path_perm(CS_MAC_TRUNCATE, path);
+}
+
+/**
+ * cs_rename_permission - Check permission for vfs_rename().
+ *
+ * @old: Pointer to "struct path".
+ * @new: Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_rename_permission(const struct path *old, const struct path *new)
+{
+	return cs_path2_perm(CS_MAC_RENAME, old, new);
+}
+
+/**
+ * cs_link_permission - Check permission for vfs_link().
+ *
+ * @old: Pointer to "struct path".
+ * @new: Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_link_permission(const struct path *old, const struct path *new)
+{
+	return cs_path2_perm(CS_MAC_LINK, old, new);
+}
+
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+
+/**
+ * cs_ip_matches_group - Check whether the given IP address matches members of the given IP group.
+ *
+ * @is_ipv6: True if @address is an IPv6 address.
+ * @address: An IPv4 or IPv6 address.
+ * @group:   Pointer to "struct cs_ip_group".
+ *
+ * Returns true if @address matches addresses in @group group, false otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static bool cs_ip_matches_group(const bool is_ipv6, const u8 *address,
+				const struct cs_group *group)
+{
+	struct cs_ip_group *member;
+	bool matched = false;
+	const u8 size = is_ipv6 ? 16 : 4;
+
+	list_for_each_entry_srcu(member, &group->member_list, head.list,
+				 &cs_ss) {
+		if (member->head.is_deleted)
+			continue;
+		if (member->is_ipv6 != is_ipv6)
+			continue;
+		if (memcmp(&member->ip[0], address, size) > 0 ||
+		    memcmp(address, &member->ip[1], size) > 0)
+			continue;
+		matched = true;
+		break;
+	}
+	return matched;
+}
+
+/**
+ * cs_inet_entry - Check permission for INET network operation.
+ *
+ * @address: Pointer to "struct cs_addr_info".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_inet_entry(const struct cs_addr_info *address)
+{
+	struct cs_request_info r = { };
+
+	cs_check_auto_domain_transition();
+	r.type = address->operation;
+	r.param.is_ipv6 = address->inet.is_ipv6;
+	r.param.ip = address->inet.address;
+	r.param.i[0] = ntohs(address->inet.port);
+	return cs_check_acl(&r, true);
+}
+
+/**
+ * cs_check_inet_address - Check permission for inet domain socket's operation.
+ *
+ * @addr:     Pointer to "struct sockaddr".
+ * @addr_len: Size of @addr.
+ * @port:     Port number.
+ * @address:  Pointer to "struct cs_addr_info".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_check_inet_address(const struct sockaddr *addr,
+				 const unsigned int addr_len, const u16 port,
+				 struct cs_addr_info *address)
+{
+	struct cs_inet_addr_info *i = &address->inet;
+
+	if (addr_len < sizeof(addr->sa_family))
+		goto skip;
+	switch (addr->sa_family) {
+	case AF_INET6:
+		if (addr_len < SIN6_LEN_RFC2133)
+			goto skip;
+		i->is_ipv6 = true;
+		i->address =
+			((struct sockaddr_in6 *) addr)->sin6_addr.s6_addr;
+		i->port = ((struct sockaddr_in6 *) addr)->sin6_port;
+		break;
+	case AF_INET:
+		if (addr_len < sizeof(struct sockaddr_in))
+			goto skip;
+		i->is_ipv6 = false;
+		i->address = (u8 *) &((struct sockaddr_in *) addr)->sin_addr;
+		i->port = ((struct sockaddr_in *) addr)->sin_port;
+		break;
+	default:
+		goto skip;
+	}
+	if (address->operation == CS_MAC_INET_RAW_BIND ||
+	    address->operation == CS_MAC_INET_RAW_SEND)
+		i->port = htons(port);
+	return cs_inet_entry(address);
+skip:
+	return 0;
+}
+
+/**
+ * cs_unix_entry - Check permission for UNIX network operation.
+ *
+ * @address: Pointer to "struct cs_addr_info".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_unix_entry(const struct cs_addr_info *address)
+{
+	int error;
+	char *buf = address->unix0.addr;
+	int len = address->unix0.addr_len - sizeof(sa_family_t);
+
+	if (len <= 0) {
+		buf = "anonymous";
+		len = 9;
+	} else if (buf[0]) {
+		len = strnlen(buf, len);
+	}
+	buf = cs_encode2(buf, len);
+	if (buf) {
+		struct cs_path_info addr;
+		struct cs_request_info r = { };
+
+		addr.name = buf;
+		cs_fill_path_info(&addr);
+		r.type = address->operation;
+		r.param.s[0] = &addr;
+		error = cs_check_acl(&r, true);
+		kfree(buf);
+	} else
+		error = -ENOMEM;
+	return error;
+}
+
+/**
+ * cs_check_unix_address - Check permission for unix domain socket's operation.
+ *
+ * @addr:     Pointer to "struct sockaddr".
+ * @addr_len: Size of @addr.
+ * @address:  Pointer to "struct cs_addr_info".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_check_unix_address(struct sockaddr *addr,
+				 const unsigned int addr_len,
+				 struct cs_addr_info *address)
+{
+	struct cs_unix_addr_info *u = &address->unix0;
+
+	if (addr_len < sizeof(addr->sa_family))
+		return 0;
+	if (addr->sa_family != AF_UNIX)
+		return 0;
+	u->addr = ((struct sockaddr_un *) addr)->sun_path;
+	u->addr_len = addr_len;
+	return cs_unix_entry(address);
+}
+
+/**
+ * cs_sock_family - Get socket's family.
+ *
+ * @sk: Pointer to "struct sock".
+ *
+ * Returns one of PF_INET, PF_INET6, PF_UNIX or 0.
+ */
+static u8 cs_sock_family(struct sock *sk)
+{
+	u8 family;
+
+	if (cs_kernel_service())
+		return 0;
+	family = sk->sk_family;
+	switch (family) {
+	case PF_INET:
+	case PF_INET6:
+	case PF_UNIX:
+		return family;
+	default:
+		return 0;
+	}
+}
+
+/**
+ * cs_socket_listen_permission - Check permission for listening a socket.
+ *
+ * @sock: Pointer to "struct socket".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_socket_listen_permission(struct socket *sock)
+{
+	struct cs_addr_info address;
+	const u8 family = cs_sock_family(sock->sk);
+	const unsigned int type = sock->type;
+	struct sockaddr_storage addr;
+	int addr_len;
+
+	if (!family || (type != SOCK_STREAM && type != SOCK_SEQPACKET))
+		return 0;
+	addr_len = sock->ops->getname(sock, (struct sockaddr *) &addr, 0);
+	if (addr_len < 0)
+		return addr_len;
+	if (family == PF_INET || family == PF_INET6)
+		address.operation = CS_MAC_INET_STREAM_LISTEN;
+	else if (type == SOCK_STREAM)
+		address.operation = CS_MAC_UNIX_STREAM_LISTEN;
+	else
+		address.operation = CS_MAC_UNIX_SEQPACKET_LISTEN;
+	if (family == PF_UNIX)
+		return cs_check_unix_address((struct sockaddr *) &addr,
+					     addr_len, &address);
+	return cs_check_inet_address((struct sockaddr *) &addr, addr_len, 0,
+				     &address);
+}
+
+/**
+ * cs_socket_connect_permission - Check permission for setting the remote address of a socket.
+ *
+ * @sock:     Pointer to "struct socket".
+ * @addr:     Pointer to "struct sockaddr".
+ * @addr_len: Size of @addr.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_socket_connect_permission(struct socket *sock, struct sockaddr *addr,
+				 int addr_len)
+{
+	struct cs_addr_info address;
+	const u8 family = cs_sock_family(sock->sk);
+
+	if (!family)
+		return 0;
+	switch (sock->type) {
+	case SOCK_DGRAM:
+		address.operation = family == PF_UNIX ?
+			CS_MAC_UNIX_DGRAM_SEND :
+		CS_MAC_INET_DGRAM_SEND;
+		break;
+	case SOCK_RAW:
+		address.operation = CS_MAC_INET_RAW_SEND;
+		break;
+	case SOCK_STREAM:
+		address.operation = family == PF_UNIX ?
+			CS_MAC_UNIX_STREAM_CONNECT :
+		CS_MAC_INET_STREAM_CONNECT;
+		break;
+	case SOCK_SEQPACKET:
+		address.operation = CS_MAC_UNIX_SEQPACKET_CONNECT;
+		break;
+	default:
+		return 0;
+	}
+	if (family == PF_UNIX)
+		return cs_check_unix_address(addr, addr_len, &address);
+	return cs_check_inet_address(addr, addr_len, sock->sk->sk_protocol,
+				     &address);
+}
+
+/**
+ * cs_socket_bind_permission - Check permission for setting the local address of a socket.
+ *
+ * @sock:     Pointer to "struct socket".
+ * @addr:     Pointer to "struct sockaddr".
+ * @addr_len: Size of @addr.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_socket_bind_permission(struct socket *sock, struct sockaddr *addr,
+			      int addr_len)
+{
+	struct cs_addr_info address;
+	const u8 family = cs_sock_family(sock->sk);
+	const unsigned int type = sock->type;
+
+	if (!family)
+		return 0;
+	switch (type) {
+	case SOCK_STREAM:
+		address.operation = family == PF_UNIX ?
+			CS_MAC_UNIX_STREAM_BIND :
+		CS_MAC_INET_STREAM_BIND;
+		break;
+	case SOCK_DGRAM:
+		address.operation = family == PF_UNIX ?
+			CS_MAC_UNIX_DGRAM_BIND :
+		CS_MAC_INET_DGRAM_BIND;
+		break;
+	case SOCK_RAW:
+		address.operation = CS_MAC_INET_RAW_BIND;
+		break;
+	case SOCK_SEQPACKET:
+		address.operation = CS_MAC_UNIX_SEQPACKET_BIND;
+		break;
+	default:
+		return 0;
+	}
+	if (family == PF_UNIX)
+		return cs_check_unix_address(addr, addr_len, &address);
+	return cs_check_inet_address(addr, addr_len, sock->sk->sk_protocol,
+				     &address);
+}
+
+/**
+ * cs_socket_sendmsg_permission - Check permission for sending a datagram.
+ *
+ * @sock: Pointer to "struct socket".
+ * @msg:  Pointer to "struct msghdr".
+ * @size: Unused.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_socket_sendmsg_permission(struct socket *sock, struct msghdr *msg,
+				 int size)
+{
+	struct cs_addr_info address;
+	const u8 family = cs_sock_family(sock->sk);
+	const unsigned int type = sock->type;
+
+	if (!msg->msg_name || !family ||
+	    (type != SOCK_DGRAM && type != SOCK_RAW))
+		return 0;
+	if (family == PF_UNIX)
+		address.operation = CS_MAC_UNIX_DGRAM_SEND;
+	else if (type == SOCK_DGRAM)
+		address.operation = CS_MAC_INET_DGRAM_SEND;
+	else
+		address.operation = CS_MAC_INET_RAW_SEND;
+	if (family == PF_UNIX)
+		return cs_check_unix_address((struct sockaddr *)
+					     msg->msg_name, msg->msg_namelen,
+					     &address);
+	return cs_check_inet_address((struct sockaddr *) msg->msg_name,
+				     msg->msg_namelen, sock->sk->sk_protocol,
+				     &address);
+}
+
+/**
+ * cs_socket_post_accept_permission - Check permission for accepting a socket.
+ *
+ * @sock:    Pointer to "struct socket".
+ * @newsock: Pointer to "struct socket".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_socket_post_accept_permission(struct socket *sock,
+				     struct socket *newsock)
+{
+	struct cs_addr_info address;
+	const u8 family = cs_sock_family(sock->sk);
+	const unsigned int type = sock->type;
+	struct sockaddr_storage addr;
+	int addr_len;
+
+	if (!family || (type != SOCK_STREAM && type != SOCK_SEQPACKET))
+		return 0;
+	addr_len = newsock->ops->getname(newsock, (struct sockaddr *) &addr,
+					 2);
+	if (addr_len < 0)
+		return addr_len;
+	if (family == PF_INET || family == PF_INET6)
+		address.operation = CS_MAC_INET_STREAM_ACCEPT;
+	else if (type == SOCK_STREAM)
+		address.operation = CS_MAC_UNIX_STREAM_ACCEPT;
+	else
+		address.operation = CS_MAC_UNIX_SEQPACKET_ACCEPT;
+	if (family == PF_UNIX)
+		return cs_check_unix_address((struct sockaddr *) &addr,
+					     addr_len, &address);
+	return cs_check_inet_address((struct sockaddr *) &addr, addr_len, 0,
+				     &address);
+}
+
+#endif
+
+#if defined(CONFIG_SECURITY_CAITSITH_CAPABILITY) || defined(CONFIG_SECURITY_CAITSITH_NETWORK)
+
+/**
+ * cs_kernel_service - Check whether I'm kernel service or not.
+ *
+ * Returns true if I'm kernel service, false otherwise.
+ */
+static bool cs_kernel_service(void)
+{
+	/* Nothing to do if I am a kernel service. */
+	return current->flags & PF_KTHREAD;
+}
+
+#endif
+
+#ifdef CONFIG_SECURITY_CAITSITH_CAPABILITY
+
+/**
+ * cs_capable - Check permission for capability.
+ *
+ * @operation: Type of operation.
+ *
+ * Returns true on success, false otherwise.
+ */
+bool cs_capable(const u8 operation)
+{
+	struct cs_request_info r = { };
+
+	r.type = cs_c2mac[operation];
+	return !cs_check_acl(&r, true);
+}
+
+/**
+ * cs_socket_create_permission - Check permission for creating a socket.
+ *
+ * @family:   Protocol family.
+ * @type:     Unused.
+ * @protocol: Unused.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int cs_socket_create_permission(int family, int type, int protocol)
+{
+	if (cs_kernel_service())
+		return 0;
+	if (family == PF_PACKET && !cs_capable(CS_USE_PACKET_SOCKET))
+		return -EPERM;
+	if (family == PF_NETLINK && !cs_capable(CS_USE_ROUTE_SOCKET))
+		return -EPERM;
+	return 0;
+}
+
+#endif
+
+/**
+ * cs_manager - Check whether the current process is a policy manager.
+ *
+ * Returns true if the current process is permitted to modify policy
+ * via /sys/kernel/security/caitsith/ interface.
+ *
+ * Caller holds cs_read_lock().
+ */
+bool cs_manager(void)
+{
+	struct cs_security *task;
+
+	if (!cs_policy_loaded)
+		return true;
+	task = cs_current_security();
+	if (task->cs_flags & CS_TASK_IS_MANAGER)
+		return true;
+	{
+		struct cs_request_info r = { };
+
+		r.type = CS_MAC_MODIFY_POLICY;
+		if (cs_check_acl(&r, true) == 0) {
+			/* Set manager flag. */
+			task->cs_flags |= CS_TASK_IS_MANAGER;
+			return true;
+		}
+	}
+	{ /* Reduce error messages. */
+		static pid_t cs_last_pid;
+		const pid_t pid = current->pid;
+
+		if (cs_last_pid != pid) {
+			const char *exe = cs_get_exe();
+
+			pr_warn("'%s' (pid=%u domain='%s') is not permitted to update policies.\n",
+				exe, pid, task->cs_domain_info->domainname->name);
+			cs_last_pid = pid;
+			kfree(exe);
+		}
+	}
+	return false;
+}
+
+#ifdef CONFIG_SECURITY_CAITSITH_ENVIRON
+
+/**
+ * cs_env_perm - Check permission for environment variable's name.
+ *
+ * @r:     Pointer to "struct cs_request_info".
+ * @name:  Name of environment variable. Maybe "".
+ * @value: Value of environment variable. Maybe "".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_env_perm(struct cs_request_info *r, const char *name,
+		       const char *value)
+{
+	struct cs_path_info n;
+	struct cs_path_info v;
+
+	n.name = name;
+	cs_fill_path_info(&n);
+	v.name = value;
+	cs_fill_path_info(&v);
+	r->type = CS_MAC_ENVIRON;
+	r->param.s[2] = &n;
+	r->param.s[3] = &v;
+	return cs_check_acl(r, false);
+}
+
+/**
+ * cs_environ - Check permission for environment variable names.
+ *
+ * @r: Pointer to "struct cs_request_info".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_environ(struct cs_request_info *r)
+{
+	struct linux_binprm *bprm = r->bprm;
+	/* env_page.data is allocated by cs_dump_page(). */
+	struct cs_page_dump env_page = { };
+	char *arg_ptr; /* Size is CS_EXEC_TMPSIZE bytes */
+	int arg_len = 0;
+	unsigned long pos = bprm->p;
+	int offset = pos % PAGE_SIZE;
+	int argv_count = bprm->argc;
+	int envp_count = bprm->envc;
+	int error = -ENOMEM;
+
+	arg_ptr = kzalloc(CS_EXEC_TMPSIZE, GFP_NOFS);
+	if (!arg_ptr) {
+		r->failed_by_oom = true;
+		goto out;
+	}
+	while (error == -ENOMEM) {
+		if (!cs_dump_page(bprm, pos, &env_page)) {
+			r->failed_by_oom = true;
+			goto out;
+		}
+		pos += PAGE_SIZE - offset;
+		/* Read. */
+		while (argv_count && offset < PAGE_SIZE) {
+			if (!env_page.data[offset++])
+				argv_count--;
+		}
+		if (argv_count) {
+			offset = 0;
+			continue;
+		}
+		while (offset < PAGE_SIZE) {
+			char *value;
+			const unsigned char c = env_page.data[offset++];
+
+			if (c && arg_len < CS_EXEC_TMPSIZE - 10) {
+				if (c > ' ' && c < 127 && c != '\\') {
+					arg_ptr[arg_len++] = c;
+				} else {
+					arg_ptr[arg_len++] = '\\';
+					arg_ptr[arg_len++] = (c >> 6) + '0';
+					arg_ptr[arg_len++]
+						= ((c >> 3) & 7) + '0';
+					arg_ptr[arg_len++] = (c & 7) + '0';
+				}
+			} else {
+				arg_ptr[arg_len] = '\0';
+			}
+			if (c)
+				continue;
+			value = strchr(arg_ptr, '=');
+			if (value)
+				*value++ = '\0';
+			else
+				value = "";
+			if (cs_env_perm(r, arg_ptr, value)) {
+				error = -EPERM;
+				break;
+			}
+			if (!--envp_count) {
+				error = 0;
+				break;
+			}
+			arg_len = 0;
+		}
+		offset = 0;
+	}
+out:
+	kfree(env_page.data);
+	kfree(arg_ptr);
+	return error;
+}
+
+#endif
+
+/**
+ * cs_path_matches_group_or_pattern - Check whether the given pathname matches the given group or the given pattern.
+ *
+ * @path:    Pointer to "struct cs_path_info".
+ * @group:   Pointer to "struct cs_group". Maybe NULL.
+ * @pattern: Pointer to "struct cs_path_info". Maybe NULL.
+ * @match:   True if positive match, false otherwise.
+ *
+ * Returns true on success, false otherwise.
+ */
+static bool cs_path_matches_group_or_pattern
+(const struct cs_path_info *path, const struct cs_group *group,
+ const struct cs_path_info *pattern, const bool match)
+{
+	if (group)
+		return cs_path_matches_group(path, group) == match;
+	else if (pattern != &cs_null_name)
+		return cs_path_matches_pattern(path, pattern) == match;
+	else
+		return !match;
+}
+
+/**
+ * cs_check_argv - Check argv[] in "struct linux_binbrm".
+ *
+ * @r:     Pointer to "struct cs_request_info".
+ * @index: Index number to check.
+ * @group: Pointer to "struct cs_group". Maybe NULL.
+ * @value: Pointer to "struct cs_path_info". NULL if @group != NULL.
+ * @match: True if positive match, false otherwise.
+ *
+ * Returns true on success, false otherwise.
+ */
+static bool cs_check_argv(struct cs_request_info *r, unsigned long index,
+			  const struct cs_group *group,
+			  const struct cs_path_info *value,
+			  const bool match)
+{
+	struct linux_binprm *bprm = r->bprm;
+	struct cs_page_dump *dump = &r->dump;
+	char *arg_ptr = r->tmp;
+	int arg_len = 0;
+	unsigned long pos = bprm->p;
+	int offset = pos % PAGE_SIZE;
+	struct cs_path_info arg;
+
+	if (index > bprm->argc)
+		return false;
+	while (1) {
+		if (!cs_dump_page(bprm, pos, dump)) {
+			r->failed_by_oom = true;
+			return false;
+		}
+		pos += PAGE_SIZE - offset;
+		while (offset < PAGE_SIZE) {
+			const unsigned char c = dump->data[offset++];
+
+			if (index) {
+				if (!c)
+					index--;
+				continue;
+			}
+			if (c && arg_len < CS_EXEC_TMPSIZE - 10) {
+				if (c > ' ' && c < 127 && c != '\\') {
+					arg_ptr[arg_len++] = c;
+				} else {
+					arg_ptr[arg_len++] = '\\';
+					arg_ptr[arg_len++] = (c >> 6) + '0';
+					arg_ptr[arg_len++] =
+						((c >> 3) & 7) + '0';
+					arg_ptr[arg_len++] = (c & 7) + '0';
+				}
+				continue;
+			}
+			arg_ptr[arg_len] = '\0';
+			arg.name = arg_ptr;
+			cs_fill_path_info(&arg);
+			return cs_path_matches_group_or_pattern
+				(&arg, group, value, match);
+		}
+		offset = 0;
+	}
+}
+
+/**
+ * cs_check_envp - Check envp[] in "struct linux_binbrm".
+ *
+ * @r:     Pointer to "struct cs_request_info".
+ * @name:  Pointer to "struct cs_path_info".
+ * @group: Pointer to "struct cs_group". Maybe NULL.
+ * @value: Pointer to "struct cs_path_info". NULL if @group != NULL.
+ * @match: True if positive match, false otherwise.
+ *
+ * Returns true on success, false otherwise.
+ */
+static bool cs_check_envp(struct cs_request_info *r,
+			  const struct cs_path_info *name,
+			  const struct cs_group *group,
+			  const struct cs_path_info *value,
+			  const bool match)
+{
+	struct linux_binprm *bprm = r->bprm;
+	struct cs_page_dump *dump = &r->dump;
+	char *arg_ptr = r->tmp;
+	int arg_len = 0;
+	unsigned long pos = bprm->p;
+	int offset = pos % PAGE_SIZE;
+	int argv_count = bprm->argc;
+	int envp_count = bprm->envc;
+	bool result = false;
+	struct cs_path_info env;
+	char *cp;
+
+	while (envp_count) {
+		if (!cs_dump_page(bprm, pos, dump)) {
+			r->failed_by_oom = true;
+			return false;
+		}
+		pos += PAGE_SIZE - offset;
+		while (envp_count && offset < PAGE_SIZE) {
+			const unsigned char c = dump->data[offset++];
+
+			if (argv_count) {
+				if (!c)
+					argv_count--;
+				continue;
+			}
+			if (c && arg_len < CS_EXEC_TMPSIZE - 10) {
+				if (c > ' ' && c < 127 && c != '\\') {
+					arg_ptr[arg_len++] = c;
+				} else {
+					arg_ptr[arg_len++] = '\\';
+					arg_ptr[arg_len++] = (c >> 6) + '0';
+					arg_ptr[arg_len++] =
+						((c >> 3) & 7) + '0';
+					arg_ptr[arg_len++] = (c & 7) + '0';
+				}
+			} else {
+				arg_ptr[arg_len] = '\0';
+			}
+			if (c)
+				continue;
+			arg_len = 0;
+			envp_count--;
+			/* Check. */
+			cp = strchr(arg_ptr, '=');
+			if (!cp)
+				cp = "";
+			else
+				*cp++ = '\0';
+			env.name = arg_ptr;
+			cs_fill_path_info(&env);
+			if (!cs_path_matches_pattern(&env, name))
+				continue;
+			result = true;
+			env.name = cp;
+			cs_fill_path_info(&env);
+			if (cs_path_matches_group_or_pattern
+			    (&env, group, value, match))
+				continue;
+			return false;
+		}
+		offset = 0;
+	}
+	/*
+	 * Return value rule:
+	 *
+	 * Condition envp["ENV"]=NULL
+	 * +----------------------+-------------+------------+-------------+
+	 * | environment variable | bool result | bool match | return      |
+	 * +----------------------+-------------+------------+-------------+
+	 * | undefined            | false       | true       | true        |
+	 * | defined but unmatch  | true        | true       | unreachable |
+	 * | defined and match    | true        | true       | unreachable |
+	 * +----------------------+-------------+------------+-------------+
+	 *
+	 * Condition envp["ENV"]!=NULL
+	 * +----------------------+-------------+------------+-------------+
+	 * | environment variable | bool result | bool match | return      |
+	 * +----------------------+-------------+------------+-------------+
+	 * | undefined            | false       | false      | false       |
+	 * | defined but unmatch  | true        | false      | true        |
+	 * | defined and match    | true        | false      | true        |
+	 * +----------------------+-------------+------------+-------------+
+	 *
+	 * Condition envp["ENV"]="VALUE" or envp["ENV"]=@GROUP
+	 * +----------------------+-------------+------------+-------------+
+	 * | environment variable | bool result | bool match | return      |
+	 * +----------------------+-------------+------------+-------------+
+	 * | undefined            | false       | true       | false       |
+	 * | defined but unmatch  | true        | true       | unreachable |
+	 * | defined and match    | true        | true       | true        |
+	 * +----------------------+-------------+------------+-------------+
+	 *
+	 * Condition envp["ENV"]!="VALUE" or envp["ENV"]!=@GROUP
+	 * +----------------------+-------------+------------+-------------+
+	 * | environment variable | bool result | bool match | return      |
+	 * +----------------------+-------------+------------+-------------+
+	 * | undefined            | false       | false      | true        |
+	 * | defined but unmatch  | true        | false      | true        |
+	 * | defined and match    | true        | false      | unreachable |
+	 * +----------------------+-------------+------------+-------------+
+	 *
+	 * FIXME: What should I do if multiple values with the same environment
+	 * variable name (e.g. HOME=/ and HOME=/root ) are passed in a way
+	 * comparison results differ?
+	 */
+	return value == &cs_null_name ? result != match : result || !match;
+}
+
+/**
+ * cs_get_attributes - Revalidate "struct inode".
+ *
+ * @r: Pointer to "struct cs_request_info".
+ *
+ * Returns nothing.
+ */
+void cs_get_attributes(struct cs_request_info *r)
+{
+	u8 i;
+	struct dentry *dentry = NULL;
+
+	if (r->obj.validate_done)
+		return;
+	for (i = 0; i < CS_MAX_PATH_STAT; i++) {
+		struct inode *inode;
+
+		switch (i) {
+		case CS_PATH1:
+			dentry = r->obj.path[0].dentry;
+			if (!dentry)
+				continue;
+			break;
+		case CS_PATH2:
+			dentry = r->obj.path[1].dentry;
+			if (!dentry)
+				continue;
+			break;
+		default:
+			if (!dentry)
+				continue;
+			dentry = dget_parent(dentry);
+			break;
+		}
+		inode = d_backing_inode(dentry);
+		if (inode) {
+			struct cs_mini_stat *stat = &r->obj.stat[i];
+
+			stat->uid  = inode->i_uid;
+			stat->gid  = inode->i_gid;
+			stat->ino  = inode->i_ino;
+			stat->mode = inode->i_mode;
+			stat->dev  = inode->i_sb->s_dev;
+			stat->rdev = inode->i_rdev;
+			stat->fsmagic = dentry->d_sb->s_magic;
+			r->obj.stat_valid[i] = true;
+		}
+		if (i & 1) /* parent directory */
+			dput(dentry);
+	}
+	r->obj.validate_done = true;
+}
+
+/**
+ * cs_populate_patharg - Calculate pathname for permission check and audit logs.
+ *
+ * @r:     Pointer to "struct cs_request_info".
+ * @first: True for first pathname, false for second pathname.
+ *
+ * Returns nothing.
+ */
+void cs_populate_patharg(struct cs_request_info *r, const bool first)
+{
+	struct cs_path_info *buf = &r->obj.pathname[!first];
+	struct path *path = &r->obj.path[!first];
+
+	if (!buf->name && path->dentry) {
+		buf->name = cs_realpath(path);
+		/* Set OOM flag if failed. */
+		if (!buf->name) {
+			r->failed_by_oom = true;
+			return;
+		}
+		cs_fill_path_info(buf);
+	}
+	if (!r->param.s[!first] && buf->name)
+		r->param.s[!first] = buf;
+}
+
+/**
+ * cs_cond2arg - Assign values to condition variables.
+ *
+ * @arg:   Pointer to "struct cs_cond_arg".
+ * @cmd:   One of values in "enum cs_conditions_index".
+ * @condp: Pointer to "union cs_condition_element *".
+ * @r:     Pointer to "struct cs_request_info".
+ *
+ * Returns true on success, false otherwise.
+ *
+ * This function should not fail. But it can fail if (for example) out of
+ * memory has occurred while calculating cs_populate_patharg() or
+ * cs_get_exename().
+ */
+static bool cs_cond2arg(struct cs_cond_arg *arg,
+			const enum cs_conditions_index cmd,
+			const union cs_condition_element **condp,
+			struct cs_request_info *r)
+{
+	struct cs_mini_stat *stat;
+	unsigned long value;
+	const struct linux_binprm *bprm = r->bprm;
+	const struct cs_request_param *param = &r->param;
+
+	arg->type = CS_ARG_TYPE_NUMBER;
+	switch (cmd) {
+	case CS_SELF_UID:
+		value = from_kuid(&init_user_ns, current_uid());
+		break;
+	case CS_SELF_EUID:
+		value = from_kuid(&init_user_ns, current_euid());
+		break;
+	case CS_SELF_SUID:
+		value = from_kuid(&init_user_ns, current_suid());
+		break;
+	case CS_SELF_FSUID:
+		value = from_kuid(&init_user_ns, current_fsuid());
+		break;
+	case CS_SELF_GID:
+		value = from_kgid(&init_user_ns, current_gid());
+		break;
+	case CS_SELF_EGID:
+		value = from_kgid(&init_user_ns, current_egid());
+		break;
+	case CS_SELF_SGID:
+		value = from_kgid(&init_user_ns, current_sgid());
+		break;
+	case CS_SELF_FSGID:
+		value = from_kgid(&init_user_ns, current_fsgid());
+		break;
+	case CS_SELF_PID:
+		value = cs_sys_getpid();
+		break;
+	case CS_SELF_PPID:
+		value = cs_sys_getppid();
+		break;
+	case CS_OBJ_IS_SOCKET:
+		value = S_IFSOCK;
+		break;
+	case CS_OBJ_IS_SYMLINK:
+		value = S_IFLNK;
+		break;
+	case CS_OBJ_IS_FILE:
+		value = S_IFREG;
+		break;
+	case CS_OBJ_IS_BLOCK_DEV:
+		value = S_IFBLK;
+		break;
+	case CS_OBJ_IS_DIRECTORY:
+		value = S_IFDIR;
+		break;
+	case CS_OBJ_IS_CHAR_DEV:
+		value = S_IFCHR;
+		break;
+	case CS_OBJ_IS_FIFO:
+		value = S_IFIFO;
+		break;
+	case CS_EXEC_ARGC:
+		if (!bprm)
+			return false;
+		value = bprm->argc;
+		break;
+	case CS_EXEC_ENVC:
+		if (!bprm)
+			return false;
+		value = bprm->envc;
+		break;
+	case CS_ARGV_ENTRY:
+	case CS_IMM_NUMBER_ENTRY1:
+		value = (*condp)->value;
+		(*condp)++;
+		break;
+	case CS_COND_NARG0:
+		value = param->i[0];
+		break;
+	case CS_COND_NARG1:
+		value = param->i[1];
+		break;
+	case CS_COND_NARG2:
+		value = param->i[2];
+		break;
+	case CS_TRANSIT_DOMAIN:
+	case CS_COND_IPARG:
+		/* Values are loaded by caller. Just return a dummy. */
+		arg->type = CS_ARG_TYPE_NONE;
+		value = 0;
+		break;
+	default:
+		goto not_single_value;
+	}
+	arg->value[0] = value;
+	arg->value[1] = value;
+	return true;
+not_single_value:
+	if (cmd == CS_IMM_NUMBER_ENTRY2) {
+		arg->value[0] = (*condp)->value;
+		(*condp)++;
+		arg->value[1] = (*condp)->value;
+		(*condp)++;
+		return true;
+	}
+	switch (cmd) {
+	case CS_COND_SARG0:
+		if (!r->param.s[0])
+			cs_populate_patharg(r, true);
+		arg->name = r->param.s[0];
+		break;
+	case CS_COND_SARG1:
+		if (!r->param.s[1])
+			cs_populate_patharg(r, false);
+		arg->name = r->param.s[1];
+		break;
+	case CS_COND_SARG2:
+		arg->name = r->param.s[2];
+		break;
+	case CS_COND_SARG3:
+		arg->name = r->param.s[3];
+		break;
+	case CS_ENVP_ENTRY:
+	case CS_IMM_NAME_ENTRY:
+		arg->name = (*condp)->path;
+		(*condp)++;
+		break;
+	case CS_SELF_EXE:
+		if (!r->exename.name) {
+			cs_get_exename(&r->exename);
+			/* Set OOM flag if failed. */
+			if (!r->exename.name)
+				r->failed_by_oom = true;
+		}
+		arg->name = &r->exename;
+		break;
+	case CS_COND_DOMAIN:
+		arg->name = r->param.s[0];
+		break;
+	case CS_SELF_DOMAIN:
+		arg->name = cs_current_domain()->domainname;
+		break;
+	default:
+		goto not_single_name;
+	}
+	if (!arg->name)
+		return false;
+	arg->type = CS_ARG_TYPE_NAME;
+	return true;
+not_single_name:
+	if (cmd == CS_IMM_GROUP) {
+		arg->type = CS_ARG_TYPE_GROUP;
+		arg->group = (*condp)->group;
+		(*condp)++;
+		return true;
+	}
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+	if (cmd == CS_IMM_IPV4ADDR_ENTRY1) {
+		arg->type = CS_ARG_TYPE_IPV4ADDR;
+		memmove(&arg->ip[0], &(*condp)->ip, 4);
+		memmove(&arg->ip[1], &(*condp)->ip, 4);
+		(*condp)++;
+		return true;
+	}
+	if (cmd == CS_IMM_IPV4ADDR_ENTRY2) {
+		arg->type = CS_ARG_TYPE_IPV4ADDR;
+		memmove(&arg->ip[0], &(*condp)->ip, 4);
+		(*condp)++;
+		memmove(&arg->ip[1], &(*condp)->ip, 4);
+		(*condp)++;
+		return true;
+	}
+	if (cmd == CS_IMM_IPV6ADDR_ENTRY1) {
+		arg->type = CS_ARG_TYPE_IPV6ADDR;
+		memmove(&arg->ip[0], &(*condp)->ip, 16);
+		memmove(&arg->ip[1], &(*condp)->ip, 16);
+		*condp = (void *)
+			(((u8 *) *condp) + sizeof(struct in6_addr));
+		return true;
+	}
+	if (cmd == CS_IMM_IPV6ADDR_ENTRY2) {
+		arg->type = CS_ARG_TYPE_IPV6ADDR;
+		memmove(&arg->ip[0], &(*condp)->ip, 16);
+		*condp = (void *)
+			(((u8 *) *condp) + sizeof(struct in6_addr));
+		memmove(&arg->ip[1], &(*condp)->ip, 16);
+		*condp = (void *)
+			(((u8 *) *condp) + sizeof(struct in6_addr));
+		return true;
+	}
+#endif
+	switch (cmd) {
+	case CS_MODE_SETUID:
+		value = S_ISUID;
+		break;
+	case CS_MODE_SETGID:
+		value = S_ISGID;
+		break;
+	case CS_MODE_STICKY:
+		value = S_ISVTX;
+		break;
+	case CS_MODE_OWNER_READ:
+		value = 0400;
+		break;
+	case CS_MODE_OWNER_WRITE:
+		value = 0200;
+		break;
+	case CS_MODE_OWNER_EXECUTE:
+		value = 0100;
+		break;
+	case CS_MODE_GROUP_READ:
+		value = 0040;
+		break;
+	case CS_MODE_GROUP_WRITE:
+		value = 0020;
+		break;
+	case CS_MODE_GROUP_EXECUTE:
+		value = 0010;
+		break;
+	case CS_MODE_OTHERS_READ:
+		value = 0004;
+		break;
+	case CS_MODE_OTHERS_WRITE:
+		value = 0002;
+		break;
+	case CS_MODE_OTHERS_EXECUTE:
+		value = 0001;
+		break;
+	default:
+		goto not_bitop;
+	}
+	arg->type = CS_ARG_TYPE_BITOP;
+	arg->value[0] = value;
+	return true;
+not_bitop:
+	arg->type = CS_ARG_TYPE_NUMBER;
+	if (!r->obj.path[0].dentry && !r->obj.path[1].dentry)
+		return false;
+	cs_get_attributes(r);
+	value = (cmd - CS_PATH_ATTRIBUTE_START) >> 4;
+	if (value > 3)
+		return false;
+	stat = &r->obj.stat[value];
+	if (!stat)
+		return false;
+	switch ((cmd - CS_PATH_ATTRIBUTE_START) & 0xF) {
+	case CS_PATH_ATTRIBUTE_UID:
+		value = from_kuid(&init_user_ns, stat->uid);
+		break;
+	case CS_PATH_ATTRIBUTE_GID:
+		value = from_kgid(&init_user_ns, stat->gid);
+		break;
+	case CS_PATH_ATTRIBUTE_INO:
+		value = stat->ino;
+		break;
+	case CS_PATH_ATTRIBUTE_MAJOR:
+		value = MAJOR(stat->dev);
+		break;
+	case CS_PATH_ATTRIBUTE_MINOR:
+		value = MINOR(stat->dev);
+		break;
+	case CS_PATH_ATTRIBUTE_TYPE:
+		value = stat->mode & S_IFMT;
+		break;
+	case CS_PATH_ATTRIBUTE_DEV_MAJOR:
+		value = MAJOR(stat->rdev);
+		break;
+	case CS_PATH_ATTRIBUTE_DEV_MINOR:
+		value = MINOR(stat->rdev);
+		break;
+	case CS_PATH_ATTRIBUTE_PERM:
+		value = stat->mode & S_IALLUGO;
+		break;
+	case CS_PATH_ATTRIBUTE_FSMAGIC:
+		value = stat->fsmagic;
+		break;
+	default:
+		return false;
+	}
+	arg->value[0] = value;
+	arg->value[1] = value;
+	return true;
+}
+
+/**
+ * cs_condition - Check condition part.
+ *
+ * @r:    Pointer to "struct cs_request_info".
+ * @cond: Pointer to "struct cs_condition". Maybe NULL.
+ *
+ * Returns true on success, false otherwise.
+ *
+ * Caller holds cs_read_lock().
+ */
+static bool cs_condition(struct cs_request_info *r,
+			 const struct cs_condition *cond)
+{
+	const union cs_condition_element *condp;
+
+	if (!cond)
+		return true;
+	condp = (typeof(condp)) (cond + 1);
+	while ((void *) condp < (void *) ((u8 *) cond) + cond->size) {
+		struct cs_cond_arg left;
+		struct cs_cond_arg right;
+		const enum cs_conditions_index left_op = condp->left;
+		const enum cs_conditions_index right_op = condp->right;
+		const bool match = !condp->is_not;
+
+		condp++;
+		if (!cs_cond2arg(&left, left_op, &condp, r) ||
+		    !cs_cond2arg(&right, right_op, &condp, r))
+			/*
+			 * Something wrong (e.g. out of memory or invalid
+			 * argument) occurred. We can't check permission.
+			 */
+			return false;
+		if (left.type == CS_ARG_TYPE_NUMBER) {
+			if (left_op == CS_ARGV_ENTRY) {
+				if (!r->bprm)
+					return false;
+				else if (right.type == CS_ARG_TYPE_NAME)
+					right.group = NULL;
+				else if (right.type == CS_ARG_TYPE_GROUP)
+					right.name = NULL;
+				else
+					return false;
+				if (cs_check_argv(r, left.value[0],
+						  right.group, right.name,
+						  match))
+					continue;
+				return false;
+			}
+			if (right.type == CS_ARG_TYPE_NUMBER) {
+				if ((left.value[0] <= right.value[1] &&
+				     left.value[1] >= right.value[0]) == match)
+					continue;
+				return false;
+			}
+			if (right.type == CS_ARG_TYPE_GROUP) {
+				if (cs_number_matches_group
+				    (left.value[0], left.value[1], right.group)
+				    == match)
+					continue;
+				return false;
+			}
+			if (right.type == CS_ARG_TYPE_BITOP) {
+				if (!(left.value[0] & right.value[0]) ==
+				    !match)
+					continue;
+				return false;
+			}
+			return false;
+		}
+		if (left.type == CS_ARG_TYPE_NAME) {
+			if (right.type == CS_ARG_TYPE_NAME)
+				right.group = NULL;
+			else if (right.type == CS_ARG_TYPE_GROUP)
+				right.name = NULL;
+			else
+				return false;
+			if (left_op == CS_ENVP_ENTRY) {
+				if (r->bprm && cs_check_envp
+				    (r, left.name, right.group, right.name,
+				     match))
+					continue;
+			} else if (cs_path_matches_group_or_pattern
+				   (left.name, right.group, right.name, match))
+				continue;
+			return false;
+		}
+		if (left.type != CS_ARG_TYPE_NONE)
+			return false;
+		/* Check IPv4 or IPv6 address expressions. */
+		if (left_op == CS_COND_IPARG) {
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+			if (right.type == CS_ARG_TYPE_GROUP) {
+				if (cs_ip_matches_group
+				    (r->param.is_ipv6, r->param.ip,
+				     right.group) == match)
+					continue;
+			} else if (right.type == CS_ARG_TYPE_IPV6ADDR) {
+				if (r->param.is_ipv6 &&
+				    (memcmp(r->param.ip, &right.ip[0],
+					    16) >= 0 &&
+				     memcmp(r->param.ip, &right.ip[1],
+					    16) <= 0) == match)
+					continue;
+			} else if (right.type == CS_ARG_TYPE_IPV4ADDR) {
+				if (!r->param.is_ipv6 &&
+				    (memcmp(r->param.ip, &right.ip[0],
+					    4) >= 0 &&
+				     memcmp(r->param.ip, &right.ip[1],
+					    4) <= 0) == match)
+					continue;
+			}
+#endif
+			return false;
+		}
+		if (left_op == CS_TRANSIT_DOMAIN) {
+			r->transition_candidate = right.name;
+			continue;
+		}
+		return false;
+	}
+	return true;
+}
+
+/**
+ * cs_check_auto_domain_transition - Check "auto_domain_transition" entry.
+ *
+ * Returns nothing.
+ *
+ * If "auto_domain_transition" keyword was specified and transition to that
+ * domain failed, the current thread will be killed by SIGKILL.
+ */
+static void cs_check_auto_domain_transition(void)
+{
+#ifdef CONFIG_SECURITY_CAITSITH_AUTO_DOMAIN_TRANSITION
+	struct cs_request_info r = { };
+
+	r.type = CS_MAC_AUTO_DOMAIN_TRANSITION;
+	cs_check_acl(&r, true);
+#endif
+}
+
+/**
+ * cs_byte_range - Check whether the string is a \ooo style octal value.
+ *
+ * @str: Pointer to the string.
+ *
+ * Returns true if @str is a \ooo style octal value, false otherwise.
+ */
+static bool cs_byte_range(const char *str)
+{
+	return *str >= '0' && *str++ <= '3' &&
+		*str >= '0' && *str++ <= '7' &&
+		*str >= '0' && *str <= '7';
+}
+
+/**
+ * cs_alphabet_char - Check whether the character is an alphabet.
+ *
+ * @c: The character to check.
+ *
+ * Returns true if @c is an alphabet character, false otherwise.
+ */
+static bool cs_alphabet_char(const char c)
+{
+	return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z');
+}
+
+/**
+ * cs_file_matches_pattern2 - Pattern matching without '/' character and "\-" pattern.
+ *
+ * @filename:     The start of string to check.
+ * @filename_end: The end of string to check.
+ * @pattern:      The start of pattern to compare.
+ * @pattern_end:  The end of pattern to compare.
+ *
+ * Returns true if @filename matches @pattern, false otherwise.
+ */
+static bool cs_file_matches_pattern2(const char *filename,
+				     const char *filename_end,
+				     const char *pattern,
+				     const char *pattern_end)
+{
+	while (filename < filename_end && pattern < pattern_end) {
+		char c;
+
+		if (*pattern != '\\') {
+			if (*filename++ != *pattern++)
+				return false;
+			continue;
+		}
+		c = *filename;
+		pattern++;
+		switch (*pattern) {
+			int i;
+			int j;
+		case '?':
+			if (c == '/') {
+				return false;
+			} else if (c == '\\') {
+				if (cs_byte_range(filename + 1))
+					filename += 3;
+				else
+					return false;
+			}
+			break;
+		case '+':
+			if (!isdigit(c))
+				return false;
+			break;
+		case 'x':
+			if (!isxdigit(c))
+				return false;
+			break;
+		case 'a':
+			if (!cs_alphabet_char(c))
+				return false;
+			break;
+		case '0':
+		case '1':
+		case '2':
+		case '3':
+			if (c == '\\' && cs_byte_range(filename + 1)
+			    && !strncmp(filename + 1, pattern, 3)) {
+				filename += 3;
+				pattern += 2;
+				break;
+			}
+			return false; /* Not matched. */
+		case '*':
+		case '@':
+			for (i = 0; i <= filename_end - filename; i++) {
+				if (cs_file_matches_pattern2(filename + i,
+							     filename_end,
+							     pattern + 1,
+							     pattern_end))
+					return true;
+				c = filename[i];
+				if (c == '.' && *pattern == '@')
+					break;
+				if (c != '\\')
+					continue;
+				if (cs_byte_range(filename + i + 1))
+					i += 3;
+				else
+					break; /* Bad pattern. */
+			}
+			return false; /* Not matched. */
+		default:
+			j = 0;
+			c = *pattern;
+			if (c == '$') {
+				while (isdigit(filename[j]))
+					j++;
+			} else if (c == 'X') {
+				while (isxdigit(filename[j]))
+					j++;
+			} else if (c == 'A') {
+				while (cs_alphabet_char(filename[j]))
+					j++;
+			}
+			for (i = 1; i <= j; i++) {
+				if (cs_file_matches_pattern2(filename + i,
+							     filename_end,
+							     pattern + 1,
+							     pattern_end))
+					return true;
+			}
+			return false; /* Not matched or bad pattern. */
+		}
+		filename++;
+		pattern++;
+	}
+	/* Ignore trailing "\*" and "\@" in @pattern. */
+	while (*pattern == '\\' &&
+	       (*(pattern + 1) == '*' || *(pattern + 1) == '@'))
+		pattern += 2;
+	return filename == filename_end && pattern == pattern_end;
+}
+
+/**
+ * cs_file_matches_pattern - Pattern matching without '/' character.
+ *
+ * @filename:     The start of string to check.
+ * @filename_end: The end of string to check.
+ * @pattern:      The start of pattern to compare.
+ * @pattern_end:  The end of pattern to compare.
+ *
+ * Returns true if @filename matches @pattern, false otherwise.
+ */
+static bool cs_file_matches_pattern(const char *filename,
+				    const char *filename_end,
+				    const char *pattern,
+				    const char *pattern_end)
+{
+	const char *pattern_start = pattern;
+	bool first = true;
+	bool result;
+
+	while (pattern < pattern_end - 1) {
+		/* Split at "\-" pattern. */
+		if (*pattern++ != '\\' || *pattern++ != '-')
+			continue;
+		result = cs_file_matches_pattern2(filename, filename_end,
+						  pattern_start, pattern - 2);
+		if (first)
+			result = !result;
+		if (result)
+			return false;
+		first = false;
+		pattern_start = pattern;
+	}
+	result = cs_file_matches_pattern2(filename, filename_end,
+					  pattern_start, pattern_end);
+	return first ? result : !result;
+}
+
+/**
+ * cs_path_matches_pattern2 - Do pathname pattern matching.
+ *
+ * @f: The start of string to check.
+ * @p: The start of pattern to compare.
+ *
+ * Returns true if @f matches @p, false otherwise.
+ */
+static bool cs_path_matches_pattern2(const char *f, const char *p)
+{
+	const char *f_delimiter;
+	const char *p_delimiter;
+
+	while (*f && *p) {
+		f_delimiter = strchr(f + 1, '/');
+		if (!f_delimiter)
+			f_delimiter = f + strlen(f);
+		p_delimiter = strchr(p + 1, '/');
+		if (!p_delimiter)
+			p_delimiter = p + strlen(p);
+		if (*p == '/' && *(p + 1) == '\\') {
+			if (*(p + 2) == '(') {
+				/* Check zero repetition. */
+				if (cs_path_matches_pattern2(f, p_delimiter))
+					return true;
+				/* Check one or more repetition. */
+				goto repetition;
+			}
+			if (*(p + 2) == '{')
+				goto repetition;
+		}
+		if ((*f == '/' || *p == '/') && *f++ != *p++)
+			return false;
+		if (!cs_file_matches_pattern(f, f_delimiter, p, p_delimiter))
+			return false;
+		f = f_delimiter;
+		p = p_delimiter;
+	}
+	/* Ignore trailing "\*" and "\@" in @pattern. */
+	while (*p == '\\' && (*(p + 1) == '*' || *(p + 1) == '@'))
+		p += 2;
+	return !*f && !*p;
+repetition:
+	do {
+		/* Compare current component with pattern. */
+		if (!cs_file_matches_pattern(f + 1, f_delimiter, p + 3,
+					     p_delimiter - 2))
+			break;
+		/* Proceed to next component. */
+		f = f_delimiter;
+		if (!*f)
+			break;
+		/* Continue comparison. */
+		if (cs_path_matches_pattern2(f, p_delimiter))
+			return true;
+		f_delimiter = strchr(f + 1, '/');
+	} while (f_delimiter);
+	return false; /* Not matched. */
+}
+
+/**
+ * cs_path_matches_pattern - Check whether the given filename matches the given pattern.
+ *
+ * @filename: The filename to check.
+ * @pattern:  The pattern to compare.
+ *
+ * Returns true if matches, false otherwise.
+ *
+ * The following patterns are available.
+ *   \ooo   Octal representation of a byte.
+ *   \*     Zero or more repetitions of characters other than '/'.
+ *   \@     Zero or more repetitions of characters other than '/' or '.'.
+ *   \?     1 byte character other than '/'.
+ *   \$     One or more repetitions of decimal digits.
+ *   \+     1 decimal digit.
+ *   \X     One or more repetitions of hexadecimal digits.
+ *   \x     1 hexadecimal digit.
+ *   \A     One or more repetitions of alphabet characters.
+ *   \a     1 alphabet character.
+ *
+ *   \-     Subtraction operator.
+ *
+ *   /\{dir\}/   '/' + 'One or more repetitions of dir/' (e.g. /dir/ /dir/dir/
+ *               /dir/dir/dir/ ).
+ *
+ *   /\(dir\)/   '/' + 'Zero or more repetitions of dir/' (e.g. / /dir/
+ *               /dir/dir/ ).
+ */
+static bool cs_path_matches_pattern(const struct cs_path_info *filename,
+				    const struct cs_path_info *pattern)
+{
+	const char *f = filename->name;
+	const char *p = pattern->name;
+	const int len = pattern->const_len;
+	/* If @pattern doesn't contain pattern, I can use strcmp(). */
+	if (len == pattern->total_len)
+		return !cs_pathcmp(filename, pattern);
+	/* Compare the initial length without patterns. */
+	if (len) {
+		if (strncmp(f, p, len))
+			return false;
+		f += len - 1;
+		p += len - 1;
+	}
+	return cs_path_matches_pattern2(f, p);
+}
+
+/**
+ * cs_clear_request_info - Release memory allocated during permission check.
+ *
+ * @r: Pointer to "struct cs_request_info".
+ *
+ * Returns nothing.
+ */
+static void cs_clear_request_info(struct cs_request_info *r)
+{
+	u8 i;
+	/*
+	 * r->obj.pathname[0] (which is referenced by r->obj.s[0]) and
+	 * r->obj.pathname[1] (which is referenced by r->obj.s[1]) may contain
+	 * pathnames allocated using cs_populate_patharg() or cs_mount_acl().
+	 * Their callers do not allocate memory until pathnames becomes needed
+	 * for checking condition or auditing requests.
+	 *
+	 * r->obj.s[2] and r->obj.s[3] are used by
+	 * cs_mount_acl()/cs_env_perm() and are allocated/released by their
+	 * callers.
+	 */
+	for (i = 0; i < 2; i++) {
+		kfree(r->obj.pathname[i].name);
+		r->obj.pathname[i].name = NULL;
+	}
+	kfree(r->exename.name);
+	r->exename.name = NULL;
+}
-- 
2.18.4

