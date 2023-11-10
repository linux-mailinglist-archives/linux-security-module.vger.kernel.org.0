Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96717E7882
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Nov 2023 04:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbjKJDvd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 9 Nov 2023 22:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345860AbjKJDvc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Nov 2023 22:51:32 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57053468C
        for <linux-security-module@vger.kernel.org>; Thu,  9 Nov 2023 19:51:30 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MYr3J003725
        for <linux-security-module@vger.kernel.org>; Thu, 9 Nov 2023 19:51:29 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u91s75fxk-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 09 Nov 2023 19:51:29 -0800
Received: from twshared4634.37.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 19:51:25 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 648C63B41DCA6; Thu,  9 Nov 2023 19:49:11 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <paul@paul-moore.com>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v10 bpf-next 16/17] selftests/bpf: add BPF token-enabled tests
Date:   Thu, 9 Nov 2023 19:48:37 -0800
Message-ID: <20231110034838.1295764-17-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110034838.1295764-1-andrii@kernel.org>
References: <20231110034838.1295764-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6HX1-P4u2LsD35hq918vTbHUORmHE-zi
X-Proofpoint-ORIG-GUID: 6HX1-P4u2LsD35hq918vTbHUORmHE-zi
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a selftest that attempts to conceptually replicate intended BPF
token use cases inside user namespaced container.

Child process is forked. It is then put into its own userns and mountns.
Child creates BPF FS context object. This ensures child userns is
captured as the owning userns for this instance of BPF FS. Given setting
delegation mount options is privileged operation, we ensure that child
cannot set them.

This context is passed back to privileged parent process through Unix
socket, where parent sets up delegation options, creates, and mounts it
as a detached mount. This mount FD is passed back to the child to be
used for BPF token creation, which allows otherwise privileged BPF
operations to succeed inside userns.

We validate that all of token-enabled privileged commands (BPF_BTF_LOAD,
BPF_MAP_CREATE, and BPF_PROG_LOAD) work as intended. They should only
succeed inside the userns if a) BPF token is provided with proper
allowed sets of commands and types; and b) namespaces CAP_BPF and other
privileges are set. Lacking a) or b) should lead to -EPERM failures.

Based on suggested workflow by Christian Brauner ([0]).

  [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785e@brauner/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 672 ++++++++++++++++++
 1 file changed, 672 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
new file mode 100644
index 000000000000..dc03790c6272
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -0,0 +1,672 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "cap_helpers.h"
+#include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
+#include <unistd.h>
+#include <linux/filter.h>
+#include <linux/unistd.h>
+#include <linux/mount.h>
+#include <sys/socket.h>
+#include <sys/syscall.h>
+#include <sys/un.h>
+
+static inline int sys_mount(const char *dev_name, const char *dir_name,
+			    const char *type, unsigned long flags,
+			    const void *data)
+{
+	return syscall(__NR_mount, dev_name, dir_name, type, flags, data);
+}
+
+static inline int sys_fsopen(const char *fsname, unsigned flags)
+{
+	return syscall(__NR_fsopen, fsname, flags);
+}
+
+static inline int sys_fspick(int dfd, const char *path, unsigned flags)
+{
+	return syscall(__NR_fspick, dfd, path, flags);
+}
+
+static inline int sys_fsconfig(int fs_fd, unsigned cmd, const char *key, const void *val, int aux)
+{
+	return syscall(__NR_fsconfig, fs_fd, cmd, key, val, aux);
+}
+
+static inline int sys_fsmount(int fs_fd, unsigned flags, unsigned ms_flags)
+{
+	return syscall(__NR_fsmount, fs_fd, flags, ms_flags);
+}
+
+static int drop_priv_caps(__u64 *old_caps)
+{
+	return cap_disable_effective((1ULL << CAP_BPF) |
+				     (1ULL << CAP_PERFMON) |
+				     (1ULL << CAP_NET_ADMIN) |
+				     (1ULL << CAP_SYS_ADMIN), old_caps);
+}
+
+static int restore_priv_caps(__u64 old_caps)
+{
+	return cap_enable_effective(old_caps, NULL);
+}
+
+static int set_delegate_mask(int fs_fd, const char *key, __u64 mask)
+{
+	char buf[32];
+	int err;
+
+	snprintf(buf, sizeof(buf), "0x%llx", (unsigned long long)mask);
+	err = sys_fsconfig(fs_fd, FSCONFIG_SET_STRING, key,
+			   mask == ~0ULL ? "any" : buf, 0);
+	if (err < 0)
+		err = -errno;
+	return err;
+}
+
+#define zclose(fd) do { if (fd >= 0) close(fd); fd = -1; } while (0)
+
+struct bpffs_opts {
+	__u64 cmds;
+	__u64 maps;
+	__u64 progs;
+	__u64 attachs;
+};
+
+static int create_bpffs_fd(void)
+{
+	int fs_fd;
+
+	/* create VFS context */
+	fs_fd = sys_fsopen("bpf", 0);
+	ASSERT_GE(fs_fd, 0, "fs_fd");
+
+	return fs_fd;
+}
+
+static int materialize_bpffs_fd(int fs_fd, struct bpffs_opts *opts)
+{
+	int mnt_fd, err;
+
+	/* set up token delegation mount options */
+	err = set_delegate_mask(fs_fd, "delegate_cmds", opts->cmds);
+	if (!ASSERT_OK(err, "fs_cfg_cmds"))
+		return err;
+	err = set_delegate_mask(fs_fd, "delegate_maps", opts->maps);
+	if (!ASSERT_OK(err, "fs_cfg_maps"))
+		return err;
+	err = set_delegate_mask(fs_fd, "delegate_progs", opts->progs);
+	if (!ASSERT_OK(err, "fs_cfg_progs"))
+		return err;
+	err = set_delegate_mask(fs_fd, "delegate_attachs", opts->attachs);
+	if (!ASSERT_OK(err, "fs_cfg_attachs"))
+		return err;
+
+	/* instantiate FS object */
+	err = sys_fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+	if (err < 0)
+		return -errno;
+
+	/* create O_PATH fd for detached mount */
+	mnt_fd = sys_fsmount(fs_fd, 0, 0);
+	if (err < 0)
+		return -errno;
+
+	return mnt_fd;
+}
+
+/* send FD over Unix domain (AF_UNIX) socket */
+static int sendfd(int sockfd, int fd)
+{
+	struct msghdr msg = {};
+	struct cmsghdr *cmsg;
+	int fds[1] = { fd }, err;
+	char iobuf[1];
+	struct iovec io = {
+		.iov_base = iobuf,
+		.iov_len = sizeof(iobuf),
+	};
+	union {
+		char buf[CMSG_SPACE(sizeof(fds))];
+		struct cmsghdr align;
+	} u;
+
+	msg.msg_iov = &io;
+	msg.msg_iovlen = 1;
+	msg.msg_control = u.buf;
+	msg.msg_controllen = sizeof(u.buf);
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(fds));
+	memcpy(CMSG_DATA(cmsg), fds, sizeof(fds));
+
+	err = sendmsg(sockfd, &msg, 0);
+	if (err < 0)
+		err = -errno;
+	if (!ASSERT_EQ(err, 1, "sendmsg"))
+		return -EINVAL;
+
+	return 0;
+}
+
+/* receive FD over Unix domain (AF_UNIX) socket */
+static int recvfd(int sockfd, int *fd)
+{
+	struct msghdr msg = {};
+	struct cmsghdr *cmsg;
+	int fds[1], err;
+	char iobuf[1];
+	struct iovec io = {
+		.iov_base = iobuf,
+		.iov_len = sizeof(iobuf),
+	};
+	union {
+		char buf[CMSG_SPACE(sizeof(fds))];
+		struct cmsghdr align;
+	} u;
+
+	msg.msg_iov = &io;
+	msg.msg_iovlen = 1;
+	msg.msg_control = u.buf;
+	msg.msg_controllen = sizeof(u.buf);
+
+	err = recvmsg(sockfd, &msg, 0);
+	if (err < 0)
+		err = -errno;
+	if (!ASSERT_EQ(err, 1, "recvmsg"))
+		return -EINVAL;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (!ASSERT_OK_PTR(cmsg, "cmsg_null") ||
+	    !ASSERT_EQ(cmsg->cmsg_len, CMSG_LEN(sizeof(fds)), "cmsg_len") ||
+	    !ASSERT_EQ(cmsg->cmsg_level, SOL_SOCKET, "cmsg_level") ||
+	    !ASSERT_EQ(cmsg->cmsg_type, SCM_RIGHTS, "cmsg_type"))
+		return -EINVAL;
+
+	memcpy(fds, CMSG_DATA(cmsg), sizeof(fds));
+	*fd = fds[0];
+
+	return 0;
+}
+
+static ssize_t write_nointr(int fd, const void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret = write(fd, buf, count);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
+
+static int write_file(const char *path, const void *buf, size_t count)
+{
+	int fd;
+	ssize_t ret;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
+	if (fd < 0)
+		return -1;
+
+	ret = write_nointr(fd, buf, count);
+	close(fd);
+	if (ret < 0 || (size_t)ret != count)
+		return -1;
+
+	return 0;
+}
+
+static int create_and_enter_userns(void)
+{
+	uid_t uid;
+	gid_t gid;
+	char map[100];
+
+	uid = getuid();
+	gid = getgid();
+
+	if (unshare(CLONE_NEWUSER))
+		return -1;
+
+	if (write_file("/proc/self/setgroups", "deny", sizeof("deny") - 1) &&
+	    errno != ENOENT)
+		return -1;
+
+	snprintf(map, sizeof(map), "0 %d 1", uid);
+	if (write_file("/proc/self/uid_map", map, strlen(map)))
+		return -1;
+
+
+	snprintf(map, sizeof(map), "0 %d 1", gid);
+	if (write_file("/proc/self/gid_map", map, strlen(map)))
+		return -1;
+
+	if (setgid(0))
+		return -1;
+
+	if (setuid(0))
+		return -1;
+
+	return 0;
+}
+
+typedef int (*child_callback_fn)(int);
+
+static void child(int sock_fd, struct bpffs_opts *opts, child_callback_fn callback)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	int mnt_fd = -1, fs_fd = -1, err = 0, bpffs_fd = -1;
+
+	/* setup userns with root mappings */
+	err = create_and_enter_userns();
+	if (!ASSERT_OK(err, "create_and_enter_userns"))
+		goto cleanup;
+
+	/* setup mountns to allow creating BPF FS (fsopen("bpf")) from unpriv process */
+	err = unshare(CLONE_NEWNS);
+	if (!ASSERT_OK(err, "create_mountns"))
+		goto cleanup;
+
+	err = sys_mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
+	if (!ASSERT_OK(err, "remount_root"))
+		goto cleanup;
+
+	fs_fd = create_bpffs_fd();
+	if (!ASSERT_GE(fs_fd, 0, "create_bpffs_fd")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	/* ensure unprivileged child cannot set delegation options */
+	err = set_delegate_mask(fs_fd, "delegate_cmds", 0x1);
+	ASSERT_EQ(err, -EPERM, "delegate_cmd_eperm");
+	err = set_delegate_mask(fs_fd, "delegate_maps", 0x1);
+	ASSERT_EQ(err, -EPERM, "delegate_maps_eperm");
+	err = set_delegate_mask(fs_fd, "delegate_progs", 0x1);
+	ASSERT_EQ(err, -EPERM, "delegate_progs_eperm");
+	err = set_delegate_mask(fs_fd, "delegate_attachs", 0x1);
+	ASSERT_EQ(err, -EPERM, "delegate_attachs_eperm");
+
+	/* pass BPF FS context object to parent */
+	err = sendfd(sock_fd, fs_fd);
+	if (!ASSERT_OK(err, "send_fs_fd"))
+		goto cleanup;
+	zclose(fs_fd);
+
+	/* avoid mucking around with mount namespaces and mounting at
+	 * well-known path, just get detach-mounted BPF FS fd back from parent
+	 */
+	err = recvfd(sock_fd, &mnt_fd);
+	if (!ASSERT_OK(err, "recv_mnt_fd"))
+		goto cleanup;
+
+	/* try to fspick() BPF FS and try to add some delegation options */
+	fs_fd = sys_fspick(mnt_fd, "", FSPICK_EMPTY_PATH);
+	if (!ASSERT_GE(fs_fd, 0, "bpffs_fspick")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	/* ensure unprivileged child cannot reconfigure to set delegation options */
+	err = set_delegate_mask(fs_fd, "delegate_cmds", ~0ULL);
+	if (!ASSERT_EQ(err, -EPERM, "delegate_cmd_eperm_reconfig")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+	err = set_delegate_mask(fs_fd, "delegate_maps", ~0ULL);
+	if (!ASSERT_EQ(err, -EPERM, "delegate_maps_eperm_reconfig")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+	err = set_delegate_mask(fs_fd, "delegate_progs", ~0ULL);
+	if (!ASSERT_EQ(err, -EPERM, "delegate_progs_eperm_reconfig")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+	err = set_delegate_mask(fs_fd, "delegate_attachs", ~0ULL);
+	if (!ASSERT_EQ(err, -EPERM, "delegate_attachs_eperm_reconfig")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+	zclose(fs_fd);
+
+	bpffs_fd = openat(mnt_fd, ".", 0, O_RDWR);
+	if (!ASSERT_GE(bpffs_fd, 0, "bpffs_open")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	/* do custom test logic with customly set up BPF FS instance */
+	err = callback(bpffs_fd);
+	if (!ASSERT_OK(err, "test_callback"))
+		goto cleanup;
+
+	err = 0;
+cleanup:
+	zclose(sock_fd);
+	zclose(mnt_fd);
+	zclose(fs_fd);
+	zclose(bpffs_fd);
+
+	exit(-err);
+}
+
+static int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
+}
+
+static void parent(int child_pid, struct bpffs_opts *bpffs_opts, int sock_fd)
+{
+	int fs_fd = -1, mnt_fd = -1, err;
+
+	err = recvfd(sock_fd, &fs_fd);
+	if (!ASSERT_OK(err, "recv_bpffs_fd"))
+		goto cleanup;
+
+	mnt_fd = materialize_bpffs_fd(fs_fd, bpffs_opts);
+	if (!ASSERT_GE(mnt_fd, 0, "materialize_bpffs_fd")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+	zclose(fs_fd);
+
+	/* pass BPF FS context object to parent */
+	err = sendfd(sock_fd, mnt_fd);
+	if (!ASSERT_OK(err, "send_mnt_fd"))
+		goto cleanup;
+	zclose(mnt_fd);
+
+	err = wait_for_pid(child_pid);
+	ASSERT_OK(err, "waitpid_child");
+
+cleanup:
+	zclose(sock_fd);
+	zclose(fs_fd);
+	zclose(mnt_fd);
+
+	if (child_pid > 0)
+		(void)kill(child_pid, SIGKILL);
+}
+
+static void subtest_userns(struct bpffs_opts *bpffs_opts, child_callback_fn cb)
+{
+	int sock_fds[2] = { -1, -1 };
+	int child_pid = 0, err;
+
+	err = socketpair(AF_UNIX, SOCK_STREAM, 0, sock_fds);
+	if (!ASSERT_OK(err, "socketpair"))
+		goto cleanup;
+
+	child_pid = fork();
+	if (!ASSERT_GE(child_pid, 0, "fork"))
+		goto cleanup;
+
+	if (child_pid == 0) {
+		zclose(sock_fds[0]);
+		return child(sock_fds[1], bpffs_opts, cb);
+
+	} else {
+		zclose(sock_fds[1]);
+		return parent(child_pid, bpffs_opts, sock_fds[0]);
+	}
+
+cleanup:
+	zclose(sock_fds[0]);
+	zclose(sock_fds[1]);
+	if (child_pid > 0)
+		(void)kill(child_pid, SIGKILL);
+}
+
+static int userns_map_create(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	int err, token_fd = -1, map_fd = -1;
+	__u64 old_caps = 0;
+
+	/* create BPF token from BPF FS mount */
+	token_fd = bpf_token_create(mnt_fd, NULL);
+	if (!ASSERT_GT(token_fd, 0, "token_create")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	/* while inside non-init userns, we need both a BPF token *and*
+	 * CAP_BPF inside current userns to create privileged map; let's test
+	 * that neither BPF token alone nor namespaced CAP_BPF is sufficient
+	 */
+	err = drop_priv_caps(&old_caps);
+	if (!ASSERT_OK(err, "drop_caps"))
+		goto cleanup;
+
+	/* no token, no CAP_BPF -> fail */
+	map_opts.token_fd = 0;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_STACK, "wo_token_wo_bpf", 0, 8, 1, &map_opts);
+	if (!ASSERT_LT(map_fd, 0, "stack_map_wo_token_wo_cap_bpf_should_fail")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	/* token without CAP_BPF -> fail */
+	map_opts.token_fd = token_fd;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_STACK, "w_token_wo_bpf", 0, 8, 1, &map_opts);
+	if (!ASSERT_LT(map_fd, 0, "stack_map_w_token_wo_cap_bpf_should_fail")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	/* get back effective local CAP_BPF (and CAP_SYS_ADMIN) */
+	err = restore_priv_caps(old_caps);
+	if (!ASSERT_OK(err, "restore_caps"))
+		goto cleanup;
+
+	/* CAP_BPF without token -> fail */
+	map_opts.token_fd = 0;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_STACK, "wo_token_w_bpf", 0, 8, 1, &map_opts);
+	if (!ASSERT_LT(map_fd, 0, "stack_map_wo_token_w_cap_bpf_should_fail")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	/* finally, namespaced CAP_BPF + token -> success */
+	map_opts.token_fd = token_fd;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_STACK, "w_token_w_bpf", 0, 8, 1, &map_opts);
+	if (!ASSERT_GT(map_fd, 0, "stack_map_w_token_w_cap_bpf")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+cleanup:
+	zclose(token_fd);
+	zclose(map_fd);
+	return err;
+}
+
+static int userns_btf_load(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_btf_load_opts, btf_opts);
+	int err, token_fd = -1, btf_fd = -1;
+	const void *raw_btf_data;
+	struct btf *btf = NULL;
+	__u32 raw_btf_size;
+	__u64 old_caps = 0;
+
+	/* create BPF token from BPF FS mount */
+	token_fd = bpf_token_create(mnt_fd, NULL);
+	if (!ASSERT_GT(token_fd, 0, "token_create")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	/* while inside non-init userns, we need both a BPF token *and*
+	 * CAP_BPF inside current userns to create privileged map; let's test
+	 * that neither BPF token alone nor namespaced CAP_BPF is sufficient
+	 */
+	err = drop_priv_caps(&old_caps);
+	if (!ASSERT_OK(err, "drop_caps"))
+		goto cleanup;
+
+	/* setup a trivial BTF data to load to the kernel */
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "empty_btf"))
+		goto cleanup;
+
+	ASSERT_GT(btf__add_int(btf, "int", 4, 0), 0, "int_type");
+
+	raw_btf_data = btf__raw_data(btf, &raw_btf_size);
+	if (!ASSERT_OK_PTR(raw_btf_data, "raw_btf_data"))
+		goto cleanup;
+
+	/* no token + no CAP_BPF -> failure */
+	btf_opts.token_fd = 0;
+	btf_fd = bpf_btf_load(raw_btf_data, raw_btf_size, &btf_opts);
+	if (!ASSERT_LT(btf_fd, 0, "no_token_no_cap_should_fail"))
+		goto cleanup;
+
+	/* token + no CAP_BPF -> failure */
+	btf_opts.token_fd = token_fd;
+	btf_fd = bpf_btf_load(raw_btf_data, raw_btf_size, &btf_opts);
+	if (!ASSERT_LT(btf_fd, 0, "token_no_cap_should_fail"))
+		goto cleanup;
+
+	/* get back effective local CAP_BPF (and CAP_SYS_ADMIN) */
+	err = restore_priv_caps(old_caps);
+	if (!ASSERT_OK(err, "restore_caps"))
+		goto cleanup;
+
+	/* token + CAP_BPF -> success */
+	btf_opts.token_fd = token_fd;
+	btf_fd = bpf_btf_load(raw_btf_data, raw_btf_size, &btf_opts);
+	if (!ASSERT_GT(btf_fd, 0, "token_and_cap_success"))
+		goto cleanup;
+
+	err = 0;
+cleanup:
+	btf__free(btf);
+	zclose(btf_fd);
+	zclose(token_fd);
+	return err;
+}
+
+static int userns_prog_load(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
+	int err, token_fd = -1, prog_fd = -1;
+	struct bpf_insn insns[] = {
+		/* bpf_jiffies64() requires CAP_BPF */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		/* bpf_get_current_task() requires CAP_PERFMON */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_current_task),
+		/* r0 = 0; exit; */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	size_t insn_cnt = ARRAY_SIZE(insns);
+	__u64 old_caps = 0;
+
+	/* create BPF token from BPF FS mount */
+	token_fd = bpf_token_create(mnt_fd, NULL);
+	if (!ASSERT_GT(token_fd, 0, "token_create")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	/* validate we can successfully load BPF program with token; this
+	 * being XDP program (CAP_NET_ADMIN) using bpf_jiffies64() (CAP_BPF)
+	 * and bpf_get_current_task() (CAP_PERFMON) helpers validates we have
+	 * BPF token wired properly in a bunch of places in the kernel
+	 */
+	prog_opts.token_fd = token_fd;
+	prog_opts.expected_attach_type = BPF_XDP;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_GT(prog_fd, 0, "prog_fd")) {
+		err = -EPERM;
+		goto cleanup;
+	}
+
+	/* no token + caps -> failure */
+	prog_opts.token_fd = 0;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_EQ(prog_fd, -EPERM, "prog_fd_eperm")) {
+		err = -EPERM;
+		goto cleanup;
+	}
+
+	err = drop_priv_caps(&old_caps);
+	if (!ASSERT_OK(err, "drop_caps"))
+		goto cleanup;
+
+	/* no caps + token -> failure */
+	prog_opts.token_fd = token_fd;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_EQ(prog_fd, -EPERM, "prog_fd_eperm")) {
+		err = -EPERM;
+		goto cleanup;
+	}
+
+	/* no caps + no token -> definitely a failure */
+	prog_opts.token_fd = 0;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_EQ(prog_fd, -EPERM, "prog_fd_eperm")) {
+		err = -EPERM;
+		goto cleanup;
+	}
+
+	err = 0;
+cleanup:
+	zclose(prog_fd);
+	zclose(token_fd);
+	return err;
+}
+
+void test_token(void)
+{
+	if (test__start_subtest("map_token")) {
+		struct bpffs_opts opts = {
+			.cmds = 1ULL << BPF_MAP_CREATE,
+			.maps = 1ULL << BPF_MAP_TYPE_STACK,
+		};
+
+		subtest_userns(&opts, userns_map_create);
+	}
+	if (test__start_subtest("btf_token")) {
+		struct bpffs_opts opts = {
+			.cmds = 1ULL << BPF_BTF_LOAD,
+		};
+
+		subtest_userns(&opts, userns_btf_load);
+	}
+	if (test__start_subtest("prog_token")) {
+		struct bpffs_opts opts = {
+			.cmds = 1ULL << BPF_PROG_LOAD,
+			.progs = 1ULL << BPF_PROG_TYPE_XDP,
+			.attachs = 1ULL << BPF_XDP,
+		};
+
+		subtest_userns(&opts, userns_prog_load);
+	}
+}
-- 
2.34.1

