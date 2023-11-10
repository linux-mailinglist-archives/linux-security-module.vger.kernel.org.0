Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED297E7847
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Nov 2023 04:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345870AbjKJDtP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 9 Nov 2023 22:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345874AbjKJDtG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Nov 2023 22:49:06 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8084695
        for <linux-security-module@vger.kernel.org>; Thu,  9 Nov 2023 19:49:04 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A9MYAbH003612
        for <linux-security-module@vger.kernel.org>; Thu, 9 Nov 2023 19:49:03 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3u8mdg2jre-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 09 Nov 2023 19:49:02 -0800
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 19:48:53 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6EC543B41DBC7; Thu,  9 Nov 2023 19:48:44 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <paul@paul-moore.com>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v10 bpf-next 03/17] bpf: introduce BPF token object
Date:   Thu, 9 Nov 2023 19:48:24 -0800
Message-ID: <20231110034838.1295764-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110034838.1295764-1-andrii@kernel.org>
References: <20231110034838.1295764-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vONEzg1Muf1D2yja1HN5v0dG9MugJnmc
X-Proofpoint-GUID: vONEzg1Muf1D2yja1HN5v0dG9MugJnmc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add new kind of BPF kernel object, BPF token. BPF token is meant to
allow delegating privileged BPF functionality, like loading a BPF
program or creating a BPF map, from privileged process to a *trusted*
unprivileged process, all while having a good amount of control over which
privileged operations could be performed using provided BPF token.

This is achieved through mounting BPF FS instance with extra delegation
mount options, which determine what operations are delegatable, and also
constraining it to the owning user namespace (as mentioned in the
previous patch).

BPF token itself is just a derivative from BPF FS and can be created
through a new bpf() syscall command, BPF_TOKEN_CREATE, which accepts BPF
FS FD, which can be attained through open() API by opening BPF FS mount
point. Currently, BPF token "inherits" delegated command, map types,
prog type, and attach type bit sets from BPF FS as is. In the future,
having an BPF token as a separate object with its own FD, we can allow
to further restrict BPF token's allowable set of things either at the
creation time or after the fact, allowing the process to guard itself
further from unintentionally trying to load undesired kind of BPF
programs. But for now we keep things simple and just copy bit sets as is.

When BPF token is created from BPF FS mount, we take reference to the
BPF super block's owning user namespace, and then use that namespace for
checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
capabilities that are normally only checked against init userns (using
capable()), but now we check them using ns_capable() instead (if BPF
token is provided). See bpf_token_capable() for details.

Such setup means that BPF token in itself is not sufficient to grant BPF
functionality. User namespaced process has to *also* have necessary
combination of capabilities inside that user namespace. So while
previously CAP_BPF was useless when granted within user namespace, now
it gains a meaning and allows container managers and sys admins to have
a flexible control over which processes can and need to use BPF
functionality within the user namespace (i.e., container in practice).
And BPF FS delegation mount options and derived BPF tokens serve as
a per-container "flag" to grant overall ability to use bpf() (plus further
restrict on which parts of bpf() syscalls are treated as namespaced).

Note also, BPF_TOKEN_CREATE command itself requires ns_capable(CAP_BPF)
within the BPF FS owning user namespace, rounding up the ns_capable()
story of BPF token.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  41 +++++++
 include/uapi/linux/bpf.h       |  37 ++++++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/inode.c             |  17 ++-
 kernel/bpf/syscall.c           |  17 +++
 kernel/bpf/token.c             | 200 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  37 ++++++
 7 files changed, 341 insertions(+), 10 deletions(-)
 create mode 100644 kernel/bpf/token.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index aeffd71cda3c..fc4b5856bbde 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -51,6 +51,10 @@ struct module;
 struct bpf_func_state;
 struct ftrace_ops;
 struct cgroup;
+struct bpf_token;
+struct user_namespace;
+struct super_block;
+struct inode;
 
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -1574,6 +1578,13 @@ struct bpf_mount_opts {
 	u64 delegate_attachs;
 };
 
+struct bpf_token {
+	struct work_struct work;
+	atomic64_t refcnt;
+	struct user_namespace *userns;
+	u64 allowed_cmds;
+};
+
 struct bpf_struct_ops_value;
 struct btf_member;
 
@@ -2031,6 +2042,7 @@ static inline void bpf_enable_instrumentation(void)
 	migrate_enable();
 }
 
+extern const struct super_operations bpf_super_ops;
 extern const struct file_operations bpf_map_fops;
 extern const struct file_operations bpf_prog_fops;
 extern const struct file_operations bpf_iter_fops;
@@ -2165,6 +2177,8 @@ static inline void bpf_map_dec_elem_count(struct bpf_map *map)
 
 extern int sysctl_unprivileged_bpf_disabled;
 
+bool bpf_token_capable(const struct bpf_token *token, int cap);
+
 static inline bool bpf_allow_ptr_leaks(void)
 {
 	return perfmon_capable();
@@ -2199,8 +2213,17 @@ int bpf_link_new_fd(struct bpf_link *link);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
 
+void bpf_token_inc(struct bpf_token *token);
+void bpf_token_put(struct bpf_token *token);
+int bpf_token_create(union bpf_attr *attr);
+struct bpf_token *bpf_token_get_from_fd(u32 ufd);
+
+bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
+
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
+struct inode *bpf_get_inode(struct super_block *sb, const struct inode *dir,
+			    umode_t mode);
 
 #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
 #define DEFINE_BPF_ITER_FUNC(target, args...)			\
@@ -2563,6 +2586,24 @@ static inline int bpf_obj_get_user(const char __user *pathname, int flags)
 	return -EOPNOTSUPP;
 }
 
+static inline bool bpf_token_capable(const struct bpf_token *token, int cap)
+{
+	return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
+}
+
+static inline void bpf_token_inc(struct bpf_token *token)
+{
+}
+
+static inline void bpf_token_put(struct bpf_token *token)
+{
+}
+
+static inline struct bpf_token *bpf_token_get_from_fd(u32 ufd)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline void __dev_flush(void)
 {
 }
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0f6cdf52b1da..9e62ef957c4f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -847,6 +847,36 @@ union bpf_iter_link_info {
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
  *
+ * BPF_TOKEN_CREATE
+ *	Description
+ *		Create BPF token with embedded information about what
+ *		BPF-related functionality it allows:
+ *		- a set of allowed bpf() syscall commands;
+ *		- a set of allowed BPF map types to be created with
+ *		BPF_MAP_CREATE command, if BPF_MAP_CREATE itself is allowed;
+ *		- a set of allowed BPF program types and BPF program attach
+ *		types to be loaded with BPF_PROG_LOAD command, if
+ *		BPF_PROG_LOAD itself is allowed.
+ *
+ *		BPF token is created (derived) from an instance of BPF FS,
+ *		assuming it has necessary delegation mount options specified.
+ *		This BPF token can be passed as an extra parameter to various
+ *		bpf() syscall commands to grant BPF subsystem functionality to
+ *		unprivileged processes.
+ *
+ *		When created, BPF token is "associated" with the owning
+ *		user namespace of BPF FS instance (super block) that it was
+ *		derived from, and subsequent BPF operations performed with
+ *		BPF token would be performing capabilities checks (i.e.,
+ *		CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN) within
+ *		that user namespace. Without BPF token, such capabilities
+ *		have to be granted in init user namespace, making bpf()
+ *		syscall incompatible with user namespace, for the most part.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -901,6 +931,8 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_TOKEN_CREATE,
+	__MAX_BPF_CMD,
 };
 
 enum bpf_map_type {
@@ -1709,6 +1741,11 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
 
+	struct { /* struct used by BPF_TOKEN_CREATE command */
+		__u32		flags;
+		__u32		bpffs_fd;
+	} token_create;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f526b7573e97..4ce95acfcaa7 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 53313a95fdc6..6ce3f9696e72 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -99,9 +99,9 @@ static const struct inode_operations bpf_prog_iops = { };
 static const struct inode_operations bpf_map_iops  = { };
 static const struct inode_operations bpf_link_iops  = { };
 
-static struct inode *bpf_get_inode(struct super_block *sb,
-				   const struct inode *dir,
-				   umode_t mode)
+struct inode *bpf_get_inode(struct super_block *sb,
+			    const struct inode *dir,
+			    umode_t mode)
 {
 	struct inode *inode;
 
@@ -602,11 +602,13 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct bpf_mount_opts *opts = root->d_sb->s_fs_info;
 	umode_t mode = d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
+	u64 mask;
 
 	if (mode != S_IRWXUGO)
 		seq_printf(m, ",mode=%o", mode);
 
-	if (opts->delegate_cmds == ~0ULL)
+	mask = (1ULL << __MAX_BPF_CMD) - 1;
+	if ((opts->delegate_cmds & mask) == mask)
 		seq_printf(m, ",delegate_cmds=any");
 	else if (opts->delegate_cmds)
 		seq_printf(m, ",delegate_cmds=0x%llx", opts->delegate_cmds);
@@ -639,7 +641,7 @@ static void bpf_free_inode(struct inode *inode)
 	free_inode_nonrcu(inode);
 }
 
-static const struct super_operations bpf_super_ops = {
+const struct super_operations bpf_super_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
 	.show_options	= bpf_show_options,
@@ -817,10 +819,7 @@ static int bpf_get_tree(struct fs_context *fc)
 
 static void bpf_free_fc(struct fs_context *fc)
 {
-	struct bpf_mount_opts *opts = fc->s_fs_info;
-
-	if (opts)
-		kfree(opts);
+	kfree(fc->s_fs_info);
 }
 
 static const struct fs_context_operations bpf_context_ops = {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ad4d8e433ccc..a7bf4322f51c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5346,6 +5346,20 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 	return ret;
 }
 
+#define BPF_TOKEN_CREATE_LAST_FIELD token_create.bpffs_fd
+
+static int token_create(union bpf_attr *attr)
+{
+	if (CHECK_ATTR(BPF_TOKEN_CREATE))
+		return -EINVAL;
+
+	/* no flags are supported yet */
+	if (attr->token_create.flags)
+		return -EINVAL;
+
+	return bpf_token_create(attr);
+}
+
 static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
@@ -5479,6 +5493,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_PROG_BIND_MAP:
 		err = bpf_prog_bind_map(&attr);
 		break;
+	case BPF_TOKEN_CREATE:
+		err = token_create(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
new file mode 100644
index 000000000000..0d5cb87fecf6
--- /dev/null
+++ b/kernel/bpf/token.c
@@ -0,0 +1,200 @@
+#include <linux/bpf.h>
+#include <linux/vmalloc.h>
+#include <linux/fdtable.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/idr.h>
+#include <linux/namei.h>
+#include <linux/user_namespace.h>
+
+bool bpf_token_capable(const struct bpf_token *token, int cap)
+{
+	/* BPF token allows ns_capable() level of capabilities */
+	if (token) {
+		if (ns_capable(token->userns, cap))
+			return true;
+		if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))
+			return true;
+	}
+	/* otherwise fallback to capable() checks */
+	return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
+}
+
+void bpf_token_inc(struct bpf_token *token)
+{
+	atomic64_inc(&token->refcnt);
+}
+
+static void bpf_token_free(struct bpf_token *token)
+{
+	put_user_ns(token->userns);
+	kvfree(token);
+}
+
+static void bpf_token_put_deferred(struct work_struct *work)
+{
+	struct bpf_token *token = container_of(work, struct bpf_token, work);
+
+	bpf_token_free(token);
+}
+
+void bpf_token_put(struct bpf_token *token)
+{
+	if (!token)
+		return;
+
+	if (!atomic64_dec_and_test(&token->refcnt))
+		return;
+
+	INIT_WORK(&token->work, bpf_token_put_deferred);
+	schedule_work(&token->work);
+}
+
+static int bpf_token_release(struct inode *inode, struct file *filp)
+{
+	struct bpf_token *token = filp->private_data;
+
+	bpf_token_put(token);
+	return 0;
+}
+
+static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
+{
+	struct bpf_token *token = filp->private_data;
+	u64 mask;
+
+	BUILD_BUG_ON(__MAX_BPF_CMD >= 64);
+	mask = (1ULL << __MAX_BPF_CMD) - 1;
+	if ((token->allowed_cmds & mask) == mask)
+		seq_printf(m, "allowed_cmds:\tany\n");
+	else
+		seq_printf(m, "allowed_cmds:\t0x%llx\n", token->allowed_cmds);
+}
+
+#define BPF_TOKEN_INODE_NAME "bpf-token"
+
+static const struct inode_operations bpf_token_iops = { };
+
+static const struct file_operations bpf_token_fops = {
+	.release	= bpf_token_release,
+	.show_fdinfo	= bpf_token_show_fdinfo,
+};
+
+int bpf_token_create(union bpf_attr *attr)
+{
+	struct bpf_mount_opts *mnt_opts;
+	struct bpf_token *token = NULL;
+	struct user_namespace *userns;
+	struct inode *inode;
+	struct file *file;
+	struct path path;
+	struct fd f;
+	umode_t mode;
+	int err, fd;
+
+	f = fdget(attr->token_create.bpffs_fd);
+	if (!f.file)
+		return -EBADF;
+
+	path = f.file->f_path;
+	path_get(&path);
+	fdput(f);
+
+	if (path.mnt->mnt_root != path.dentry) {
+		err = -EINVAL;
+		goto out_path;
+	}
+	if (path.mnt->mnt_sb->s_op != &bpf_super_ops) {
+		err = -EINVAL;
+		goto out_path;
+	}
+	err = path_permission(&path, MAY_ACCESS);
+	if (err)
+		goto out_path;
+
+	userns = path.dentry->d_sb->s_user_ns;
+	if (!ns_capable(userns, CAP_BPF)) {
+		err = -EPERM;
+		goto out_path;
+	}
+
+	mode = S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
+	inode = bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		goto out_path;
+	}
+
+	inode->i_op = &bpf_token_iops;
+	inode->i_fop = &bpf_token_fops;
+	clear_nlink(inode); /* make sure it is unlinked */
+
+	file = alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME, O_RDWR, &bpf_token_fops);
+	if (IS_ERR(file)) {
+		iput(inode);
+		err = PTR_ERR(file);
+		goto out_path;
+	}
+
+	token = kvzalloc(sizeof(*token), GFP_USER);
+	if (!token) {
+		err = -ENOMEM;
+		goto out_file;
+	}
+
+	atomic64_set(&token->refcnt, 1);
+
+	/* remember bpffs owning userns for future ns_capable() checks */
+	token->userns = get_user_ns(userns);
+
+	mnt_opts = path.dentry->d_sb->s_fs_info;
+	token->allowed_cmds = mnt_opts->delegate_cmds;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		err = fd;
+		goto out_token;
+	}
+
+	file->private_data = token;
+	fd_install(fd, file);
+
+	path_put(&path);
+	return fd;
+
+out_token:
+	bpf_token_free(token);
+out_file:
+	fput(file);
+out_path:
+	path_put(&path);
+	return err;
+}
+
+struct bpf_token *bpf_token_get_from_fd(u32 ufd)
+{
+	struct fd f = fdget(ufd);
+	struct bpf_token *token;
+
+	if (!f.file)
+		return ERR_PTR(-EBADF);
+	if (f.file->f_op != &bpf_token_fops) {
+		fdput(f);
+		return ERR_PTR(-EINVAL);
+	}
+
+	token = f.file->private_data;
+	bpf_token_inc(token);
+	fdput(f);
+
+	return token;
+}
+
+bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
+{
+	if (!token)
+		return false;
+
+	return token->allowed_cmds & (1ULL << cmd);
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0f6cdf52b1da..9e62ef957c4f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -847,6 +847,36 @@ union bpf_iter_link_info {
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
  *
+ * BPF_TOKEN_CREATE
+ *	Description
+ *		Create BPF token with embedded information about what
+ *		BPF-related functionality it allows:
+ *		- a set of allowed bpf() syscall commands;
+ *		- a set of allowed BPF map types to be created with
+ *		BPF_MAP_CREATE command, if BPF_MAP_CREATE itself is allowed;
+ *		- a set of allowed BPF program types and BPF program attach
+ *		types to be loaded with BPF_PROG_LOAD command, if
+ *		BPF_PROG_LOAD itself is allowed.
+ *
+ *		BPF token is created (derived) from an instance of BPF FS,
+ *		assuming it has necessary delegation mount options specified.
+ *		This BPF token can be passed as an extra parameter to various
+ *		bpf() syscall commands to grant BPF subsystem functionality to
+ *		unprivileged processes.
+ *
+ *		When created, BPF token is "associated" with the owning
+ *		user namespace of BPF FS instance (super block) that it was
+ *		derived from, and subsequent BPF operations performed with
+ *		BPF token would be performing capabilities checks (i.e.,
+ *		CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN) within
+ *		that user namespace. Without BPF token, such capabilities
+ *		have to be granted in init user namespace, making bpf()
+ *		syscall incompatible with user namespace, for the most part.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -901,6 +931,8 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_TOKEN_CREATE,
+	__MAX_BPF_CMD,
 };
 
 enum bpf_map_type {
@@ -1709,6 +1741,11 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
 
+	struct { /* struct used by BPF_TOKEN_CREATE command */
+		__u32		flags;
+		__u32		bpffs_fd;
+	} token_create;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.34.1

