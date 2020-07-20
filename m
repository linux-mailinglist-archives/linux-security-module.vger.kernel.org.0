Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431C2225DEE
	for <lists+linux-security-module@lfdr.de>; Mon, 20 Jul 2020 13:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgGTLzX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 20 Jul 2020 07:55:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35936 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgGTLzX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 07:55:23 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jxUNi-0004wH-99; Mon, 20 Jul 2020 11:54:54 +0000
Date:   Mon, 20 Jul 2020 13:54:52 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200720115452.ne2vqtdneuungb3j@wittgenstein>
References: <20200719100418.2112740-1-areber@redhat.com>
 <20200719181729.6f37lilhvov5a74f@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200719181729.6f37lilhvov5a74f@wittgenstein>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Jul 19, 2020 at 08:17:30PM +0200, Christian Brauner wrote:
> On Sun, Jul 19, 2020 at 12:04:10PM +0200, Adrian Reber wrote:
> > This is v6 of the 'Introduce CAP_CHECKPOINT_RESTORE' patchset. The
> > changes to v5 are:
> > 
> >  * split patch dealing with /proc/self/exe into two patches:
> >    * first patch to enable changing it with CAP_CHECKPOINT_RESTORE
> >      and detailed history in the commit message
> >    * second patch changes -EINVAL to -EPERM
> >  * use kselftest_harness.h infrastructure for test
> >  * replace if (!capable(CAP_SYS_ADMIN) || !capable(CAP_CHECKPOINT_RESTORE))
> >    with if (!checkpoint_restore_ns_capable(&init_user_ns))
> > 
> > Adrian Reber (5):
> >   capabilities: Introduce CAP_CHECKPOINT_RESTORE
> >   pid: use checkpoint_restore_ns_capable() for set_tid
> >   pid_namespace: use checkpoint_restore_ns_capable() for ns_last_pid
> >   proc: allow access in init userns for map_files with
> >     CAP_CHECKPOINT_RESTORE
> >   selftests: add clone3() CAP_CHECKPOINT_RESTORE test
> > 
> > Nicolas Viennot (2):
> >   prctl: Allow local CAP_CHECKPOINT_RESTORE to change /proc/self/exe
> >   prctl: exe link permission error changed from -EINVAL to -EPERM
> > 
> >  fs/proc/base.c                                |   8 +-
> >  include/linux/capability.h                    |   6 +
> >  include/uapi/linux/capability.h               |   9 +-
> >  kernel/pid.c                                  |   2 +-
> >  kernel/pid_namespace.c                        |   2 +-
> >  kernel/sys.c                                  |  13 +-
> >  security/selinux/include/classmap.h           |   5 +-
> >  tools/testing/selftests/clone3/.gitignore     |   1 +
> >  tools/testing/selftests/clone3/Makefile       |   4 +-
> >  .../clone3/clone3_cap_checkpoint_restore.c    | 177 ++++++++++++++++++
> >  10 files changed, 212 insertions(+), 15 deletions(-)
> >  create mode 100644 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> > 
> > base-commit: d31958b30ea3b7b6e522d6bf449427748ad45822
> 
> Adrian, Nicolas thank you!
> I grabbed the series to run the various core test-suites we've added
> over the last year and pushed it to
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=cap_checkpoint_restore
> for now to let kbuild/ltp chew on it for a bit.

Ok, I ran the test-suite this morning and there's nothing to worry about
it all passes _but_ the selftests had a bug using SKIP() instead of
XFAIL() and they mixed ksft_print_msg() and TH_LOG(). I know that I
think I mentioned to you that you can't use TH_LOG() outside of TEST*().
Turns out I was wrong. You can do it if you pass in a specific global
variable. Here's the diff I applied on top of the selftests you sent.
After these changes the output looks like this:

[==========] Running 1 tests from 1 test cases.
[ RUN      ] global.clone3_cap_checkpoint_restore
# clone3() syscall supported
clone3_cap_checkpoint_restore.c:155:clone3_cap_checkpoint_restore:Child has PID 12303
clone3_cap_checkpoint_restore.c:88:clone3_cap_checkpoint_restore:[12302] Trying clone3() with CLONE_SET_TID to 12303
clone3_cap_checkpoint_restore.c:55:clone3_cap_checkpoint_restore:Operation not permitted - Failed to create new process
clone3_cap_checkpoint_restore.c:90:clone3_cap_checkpoint_restore:[12302] clone3() with CLONE_SET_TID 12303 says:-1
clone3_cap_checkpoint_restore.c:88:clone3_cap_checkpoint_restore:[12302] Trying clone3() with CLONE_SET_TID to 12303
clone3_cap_checkpoint_restore.c:70:clone3_cap_checkpoint_restore:I am the parent (12302). My child's pid is 12303
clone3_cap_checkpoint_restore.c:63:clone3_cap_checkpoint_restore:I am the child, my PID is 12303 (expected 12303)
clone3_cap_checkpoint_restore.c:90:clone3_cap_checkpoint_restore:[12302] clone3() with CLONE_SET_TID 12303 says:0
[       OK ] global.clone3_cap_checkpoint_restore
[==========] 1 / 1 tests passed.
[  PASSED  ]

Ok with this below being applied on top of it?

diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index c0d83511cd28..9562425aa0a9 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -38,7 +38,8 @@ static void child_exit(int ret)
 	_exit(ret);
 }
 
-static int call_clone3_set_tid(pid_t *set_tid, size_t set_tid_size)
+static int call_clone3_set_tid(struct __test_metadata *_metadata,
+			       pid_t *set_tid, size_t set_tid_size)
 {
 	int status;
 	pid_t pid = -1;
@@ -51,7 +52,7 @@ static int call_clone3_set_tid(pid_t *set_tid, size_t set_tid_size)
 
 	pid = sys_clone3(&args, sizeof(struct clone_args));
 	if (pid < 0) {
-		ksft_print_msg("%s - Failed to create new process\n", strerror(errno));
+		TH_LOG("%s - Failed to create new process", strerror(errno));
 		return -errno;
 	}
 
@@ -59,18 +60,17 @@ static int call_clone3_set_tid(pid_t *set_tid, size_t set_tid_size)
 		int ret;
 		char tmp = 0;
 
-		ksft_print_msg
-		    ("I am the child, my PID is %d (expected %d)\n", getpid(), set_tid[0]);
+		TH_LOG("I am the child, my PID is %d (expected %d)", getpid(), set_tid[0]);
 
 		if (set_tid[0] != getpid())
 			child_exit(EXIT_FAILURE);
 		child_exit(EXIT_SUCCESS);
 	}
 
-	ksft_print_msg("I am the parent (%d). My child's pid is %d\n", getpid(), pid);
+	TH_LOG("I am the parent (%d). My child's pid is %d", getpid(), pid);
 
 	if (waitpid(pid, &status, 0) < 0) {
-		ksft_print_msg("Child returned %s\n", strerror(errno));
+		TH_LOG("Child returned %s", strerror(errno));
 		return -errno;
 	}
 
@@ -80,13 +80,14 @@ static int call_clone3_set_tid(pid_t *set_tid, size_t set_tid_size)
 	return WEXITSTATUS(status);
 }
 
-static int test_clone3_set_tid(pid_t *set_tid, size_t set_tid_size)
+static int test_clone3_set_tid(struct __test_metadata *_metadata,
+			       pid_t *set_tid, size_t set_tid_size)
 {
 	int ret;
 
-	ksft_print_msg("[%d] Trying clone3() with CLONE_SET_TID to %d\n", getpid(), set_tid[0]);
-	ret = call_clone3_set_tid(set_tid, set_tid_size);
-	ksft_print_msg("[%d] clone3() with CLONE_SET_TID %d says:%d\n", getpid(), set_tid[0], ret);
+	TH_LOG("[%d] Trying clone3() with CLONE_SET_TID to %d", getpid(), set_tid[0]);
+	ret = call_clone3_set_tid(_metadata, set_tid, set_tid_size);
+	TH_LOG("[%d] clone3() with CLONE_SET_TID %d says:%d", getpid(), set_tid[0], ret);
 	return ret;
 }
 
@@ -144,7 +145,7 @@ TEST(clone3_cap_checkpoint_restore)
 	test_clone3_supported();
 
 	EXPECT_EQ(getuid(), 0)
-		SKIP(return, "Skipping all tests as non-root\n");
+		XFAIL(return, "Skipping all tests as non-root\n");
 
 	memset(&set_tid, 0, sizeof(set_tid));
 
@@ -162,16 +163,20 @@ TEST(clone3_cap_checkpoint_restore)
 
 	ASSERT_EQ(set_capability(), 0)
 		TH_LOG("Could not set CAP_CHECKPOINT_RESTORE");
-	prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
-	setgid(1000);
-	setuid(1000);
+
+	ASSERT_EQ(prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0), 0);
+
+	EXPECT_EQ(setgid(65534), 0)
+		TH_LOG("Failed to setgid(65534)");
+	ASSERT_EQ(setuid(65534), 0);
+
 	set_tid[0] = pid;
 	/* This would fail without CAP_CHECKPOINT_RESTORE */
-	ASSERT_EQ(test_clone3_set_tid(set_tid, 1), -EPERM);
+	ASSERT_EQ(test_clone3_set_tid(_metadata, set_tid, 1), -EPERM);
 	ASSERT_EQ(set_capability(), 0)
 		TH_LOG("Could not set CAP_CHECKPOINT_RESTORE");
 	/* This should work as we have CAP_CHECKPOINT_RESTORE as non-root */
-	ASSERT_EQ(test_clone3_set_tid(set_tid, 1), 0);
+	ASSERT_EQ(test_clone3_set_tid(_metadata, set_tid, 1), 0);
 }
 
 TEST_HARNESS_MAIN
