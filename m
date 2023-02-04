Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90B668A861
	for <lists+linux-security-module@lfdr.de>; Sat,  4 Feb 2023 06:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjBDFc4 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 4 Feb 2023 00:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjBDFcw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Feb 2023 00:32:52 -0500
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6C9693E22
        for <linux-security-module@vger.kernel.org>; Fri,  3 Feb 2023 21:32:50 -0800 (PST)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 31459w6C011632;
        Fri, 3 Feb 2023 23:09:58 -0600
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 31459w6r011630;
        Fri, 3 Feb 2023 23:09:58 -0600
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 05/14] Add TSEM master header file.
Date:   Fri,  3 Feb 2023 23:09:45 -0600
Message-Id: <20230204050954.11583-6-greg@enjellic.com>
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

TSEM is designed, from a functional perspective, to be contained
entirely in its own directory.

The tsem.h header file defines the enumeration types, structure
definitions and externally visiable functions that are referenced
by the TSEM LSM implementation.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 security/tsem/tsem.h | 388 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 388 insertions(+)
 create mode 100644 security/tsem/tsem.h

diff --git a/security/tsem/tsem.h b/security/tsem/tsem.h
new file mode 100644
index 000000000000..2d81a17e655a
--- /dev/null
+++ b/security/tsem/tsem.h
@@ -0,0 +1,388 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Copyright (C) 2022 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * TSEM specific includes.
+ */
+
+#include <uapi/linux/in.h>
+#include <uapi/linux/in6.h>
+#include <linux/wait.h>
+#include <linux/kref.h>
+#include <linux/lsm_hooks.h>
+#include <linux/capability.h>
+#include <crypto/hash_info.h>
+
+#define TSEM_CONTROL_CAPABILITY CAP_TRUST
+
+enum tsem_event_type {
+	TSEM_BPRM_SET_CREDS = 1,
+	TSEM_GENERIC_EVENT,
+	TSEM_TASK_KILL,
+	TSEM_TASK_SETPGID,
+	TSEM_TASK_GETPGID,
+	TSEM_TASK_GETSID,
+	TSEM_TASK_SETNICE,
+	TSEM_TASK_SETIOPRIO,
+	TSEM_TASK_GETIOPRIO,
+	TSEM_TASK_PRLIMIT,
+	TSEM_TASK_SETRLIMIT,
+	TSEM_TASK_SETSCHEDULER,
+	TSEM_TASK_GETSCHEDULER,
+	TSEM_TASK_PRCTL,
+	TSEM_FILE_OPEN,
+	TSEM_MMAP_FILE,
+	TSEM_FILE_IOCTL,
+	TSEM_FILE_LOCK,
+	TSEM_FILE_FCNTL,
+	TSEM_FILE_RECEIVE,
+	TSEM_UNIX_STREAM_CONNECT,
+	TSEM_UNIX_MAY_SEND,
+	TSEM_SOCKET_CREATE,
+	TSEM_SOCKET_CONNECT,
+	TSEM_SOCKET_BIND,
+	TSEM_SOCKET_ACCEPT,
+	TSEM_SOCKET_LISTEN,
+	TSEM_SOCKET_SOCKETPAIR,
+	TSEM_SOCKET_SENDMSG,
+	TSEM_SOCKET_RECVMSG,
+	TSEM_SOCKET_GETSOCKNAME,
+	TSEM_SOCKET_GETPEERNAME,
+	TSEM_SOCKET_SETSOCKOPT,
+	TSEM_SOCKET_SHUTDOWN,
+	TSEM_PTRACE_TRACEME,
+	TSEM_KERNEL_MODULE_REQUEST,
+	TSEM_KERNEL_LOAD_DATA,
+	TSEM_KERNEL_READ_FILE,
+	TSEM_SB_MOUNT,
+	TSEM_SB_UMOUNT,
+	TSEM_SB_REMOUNT,
+	TSEM_SB_PIVOTROOT,
+	TSEM_SB_STATFS,
+	TSEM_MOVE_MOUNT,
+	TSEM_SHM_ASSOCIATE,
+	TSEM_SHM_SHMCTL,
+	TSEM_SHM_SHMAT,
+	TSEM_SEM_ASSOCIATE,
+	TSEM_SEM_SEMCTL,
+	TSEM_SEM_SEMOP,
+	TSEM_SYSLOG,
+	TSEM_SETTIME,
+	TSEM_QUOTACTL,
+	TSEM_QUOTA_ON,
+	TSEM_MSG_QUEUE_ASSOCIATE,
+	TSEM_MSG_QUEUE_MSGCTL,
+	TSEM_MSG_QUEUE_MSGSND,
+	TSEM_MSG_QUEUE_MSGRCV,
+	TSEM_IPC_PERMISSION,
+	TSEM_KEY_ALLOC,
+	TSEM_KEY_PERMISSION,
+	TSEM_NETLINK_SEND,
+	TSEM_INODE_CREATE,
+	TSEM_INODE_LINK,
+	TSEM_INODE_UNLINK,
+	TSEM_INODE_SYMLINK,
+	TSEM_INODE_MKDIR,
+	TSEM_INODE_RMDIR,
+	TSEM_INODE_MKNOD,
+	TSEM_INODE_RENAME,
+	TSEM_INODE_SETATTR,
+	TSEM_INODE_GETATTR,
+	TSEM_INODE_SETXATTR,
+	TSEM_INODE_GETXATTR,
+	TSEM_INODE_LISTXATTR,
+	TSEM_INODE_REMOVEXATTR,
+	TSEM_INODE_KILLPRIV,
+	TSEM_TUN_DEV_CREATE,
+	TSEM_TUN_DEV_ATTACH_QUEUE,
+	TSEM_TUN_DEV_ATTACH,
+	TSEM_TUN_DEV_OPEN,
+	TSEM_BPF,
+	TSEM_BPF_MAP,
+	TSEM_BPF_PROG,
+	TSEM_EVENT_CNT
+};
+
+enum tsem_action_type {
+	TSEM_ACTION_LOG = 0,
+	TSEM_ACTION_EPERM,
+	TSEM_ACTION_CNT
+};
+
+enum tsem_control_type {
+	TSEM_CONTROL_INTERNAL = 1,
+	TSEM_CONTROL_EXTERNAL,
+	TSEM_CONTROL_ENFORCE,
+	TSEM_CONTROL_SEAL,
+	TSEM_CONTROL_TRUSTED,
+	TSEM_CONTROL_UNTRUSTED,
+	TSEM_CONTROL_MAP_STATE,
+	TSEM_CONTROL_MAP_PSEUDONYM,
+	TSEM_CONTROL_MAP_BASE
+};
+
+enum tsem_task_trust {
+	TSEM_TASK_TRUSTED = 1,
+	TSEM_TASK_UNTRUSTED = 2,
+	TSEM_TASK_TRUST_PENDING = 4
+};
+
+enum tsem_inode_state {
+	TSEM_INODE_COLLECTING = 1,
+	TSEM_INODE_COLLECTED
+};
+
+struct tsem_COE {
+	uid_t uid;
+	uid_t euid;
+	uid_t suid;
+
+	gid_t gid;
+	gid_t egid;
+	gid_t sgid;
+
+	uid_t fsuid;
+	gid_t fsgid;
+
+	union {
+		kernel_cap_t mask;
+		u64 value;
+	} capability;
+};
+
+struct tsem_file {
+	uid_t uid;
+	gid_t gid;
+	umode_t mode;
+	u32 flags;
+
+	u32 name_length;
+	u8 name[WP256_DIGEST_SIZE];
+
+	u32 s_magic;
+	u8 s_id[32];
+	u8 s_uuid[16];
+
+	u8 digest[WP256_DIGEST_SIZE];
+};
+
+struct tsem_event_point {
+	struct list_head list;
+	u8 point[WP256_DIGEST_SIZE];
+	bool valid;
+};
+
+struct tsem_mmap_file_args {
+	struct file *file;
+	u32 anonymous;
+	u32 reqprot;
+	u32 prot;
+	u32 flags;
+};
+
+struct tsem_socket_create_args {
+	int family;
+	int type;
+	int protocol;
+	int kern;
+};
+
+struct tsem_socket_connect_args {
+	struct tsem_inode *tsip;
+	struct sockaddr *addr;
+	int addr_len;
+	u16 family;
+	union {
+		struct sockaddr_in ipv4;
+		struct sockaddr_in6 ipv6;
+		u8 mapping[WP256_DIGEST_SIZE];
+	} u;
+};
+
+struct tsem_socket_accept_args {
+	struct tsem_inode *tsip;
+	u16 family;
+	u16 type;
+	__be16 port;
+	__be32 ipv4;
+	struct in6_addr ipv6;
+};
+
+struct tsem_task_kill_args {
+	u32 cross_model;
+	u32 signal;
+	u8 target[WP256_DIGEST_SIZE];
+};
+
+struct tsem_event {
+	struct kref kref;
+	enum tsem_event_type event;
+	pid_t pid;
+	char *pathname;
+	char comm[TASK_COMM_LEN];
+	u8 task_id[WP256_DIGEST_SIZE];
+	u8 mapping[WP256_DIGEST_SIZE];
+	struct tsem_COE COE;
+	struct tsem_file file;
+	union {
+		u32 event_type;
+		struct tsem_mmap_file_args mmap_file;
+		struct tsem_socket_create_args socket_create;
+		struct tsem_socket_connect_args socket_connect;
+		struct tsem_socket_accept_args socket_accept;
+		struct tsem_task_kill_args task_kill;
+	} CELL;
+};
+
+struct tsem_event_parameters {
+	union {
+		u32 event_type;
+		struct file *file;
+		struct tsem_mmap_file_args *mmap_file;
+		struct tsem_socket_create_args *socket_create;
+		struct tsem_socket_connect_args *socket_connect;
+		struct tsem_socket_accept_args *socket_accept;
+		struct tsem_task_kill_args *task_kill;
+	} u;
+};
+
+struct tsem_trajectory {
+	struct list_head list;
+	struct tsem_event *ep;
+};
+
+struct tsem_model {
+	bool have_aggregate;
+	u8 base[WP256_DIGEST_SIZE];
+	u8 measurement[WP256_DIGEST_SIZE];
+	u8 state[WP256_DIGEST_SIZE];
+
+	unsigned int point_count;
+	struct mutex point_mutex;
+	struct list_head point_list;
+	struct list_head state_list;
+
+	unsigned int trajectory_count;
+	struct mutex trajectory_mutex;
+	struct list_head trajectory_list;
+
+	unsigned int forensics_count;
+	unsigned int max_forensics_count;
+	struct mutex forensics_mutex;
+	struct list_head forensics_list;
+
+	struct mutex pseudonym_mutex;
+	struct list_head pseudonym_list;
+};
+
+struct tsem_external {
+	char *filename;
+	struct mutex measurement_mutex;
+	struct list_head measurement_list;
+	struct dentry *dentry;
+	bool have_event;
+	wait_queue_head_t wq;
+};
+
+struct tsem_TMA_work {
+	struct work_struct work;
+	struct tsem_TMA_context *ctx;
+};
+
+struct tsem_TMA_context {
+	struct kref kref;
+	struct tsem_TMA_work work;
+	u64 id;
+	bool sealed;
+	enum tsem_action_type actions[TSEM_EVENT_CNT];
+	struct tsem_model *model;
+	struct tsem_external *external;
+};
+
+struct tsem_task {
+	int trust_status;
+	u8 task_id[WP256_DIGEST_SIZE];
+	struct tsem_TMA_context *context;
+};
+
+struct tsem_inode {
+	enum tsem_inode_state status;
+	u64 version;
+	u8 digest[WP256_DIGEST_SIZE];
+	struct mutex mutex;
+};
+
+extern struct lsm_blob_sizes tsem_blob_sizes;
+extern enum tsem_action_type tsem_root_actions[TSEM_EVENT_CNT];
+extern struct tsem_TMA_context root_TMA_context;
+extern const char * const tsem_names[TSEM_EVENT_CNT];
+
+extern int tsem_fs_init(void);
+extern struct dentry *tsem_fs_create_external(const char *name);
+extern void tsem_fs_remove_external(struct dentry *dentry);
+
+extern struct tsem_model *tsem_model_allocate(void);
+extern void tsem_model_free(struct tsem_TMA_context *ctx);
+extern int tsem_model_event(struct tsem_event *ep);
+extern int tsem_model_load_point(u8 *point);
+extern int tsem_model_load_pseudonym(u8 *mapping);
+extern int tsem_model_has_pseudonym(struct tsem_inode *tsip,
+				    struct tsem_file *ep, u8 *mapping);
+extern void tsem_model_load_base(u8 *mapping);
+extern int tsem_model_add_aggregate(void);
+extern void tsem_model_compute_state(void);
+
+extern int tsem_ns_init(void);
+extern int tsem_ns_create(enum tsem_control_type type);
+extern void tsem_ns_put(struct tsem_TMA_context *ctx);
+extern void tsem_ns_get(struct tsem_TMA_context *ctx);
+
+extern int tsem_export_show(struct seq_file *m);
+extern int tsem_export_event(struct tsem_event *ep);
+extern int tsem_export_action(enum tsem_event_type event);
+extern int tsem_export_aggregate(void);
+
+extern int tsem_map_task(struct file *file, u8 *mapping);
+struct tsem_event *tsem_map_event(enum tsem_event_type event,
+				  struct tsem_event_parameters *param);
+
+extern struct tsem_event *tsem_event_allocate(enum tsem_event_type event,
+					struct tsem_event_parameters *params);
+extern void tsem_event_put(struct tsem_event *ep);
+extern void tsem_event_get(struct tsem_event *ep);
+extern int tsem_event_cache_init(void);
+
+extern u8 *tsem_trust_aggregate(void);
+extern int tsem_trust_add_event(u8 *coefficient);
+
+static inline struct tsem_task *tsem_task(struct task_struct *task)
+{
+	return task->security + tsem_blob_sizes.lbs_task;
+}
+
+static inline bool tsem_task_trusted(struct task_struct *task)
+{
+	return tsem_task(task)->trust_status & TSEM_TASK_TRUSTED;
+}
+
+static inline bool tsem_task_untrusted(struct task_struct *task)
+{
+	return tsem_task(task)->trust_status & ~TSEM_TASK_TRUSTED;
+}
+
+static inline struct tsem_TMA_context *tsem_context(struct task_struct *task)
+{
+	return tsem_task(task)->context;
+}
+
+static inline struct tsem_model *tsem_model(struct task_struct *task)
+{
+	return tsem_task(task)->context->model;
+}
+
+static inline struct tsem_inode *tsem_inode(struct inode *inode)
+{
+	return inode->i_security + tsem_blob_sizes.lbs_inode;
+}
-- 
2.39.1

