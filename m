Return-Path: <linux-security-module+bounces-7590-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C153A08F29
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Jan 2025 12:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05603A4BF5
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Jan 2025 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF1C20CCE9;
	Fri, 10 Jan 2025 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DIV5pbU3"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A720C464
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508314; cv=none; b=KdNv+TCvIIF+UUpk48suq/Me53rr7E2zAJsKiQmDWWbeUxPF2ZF2EOByItR4UvOXc4Sa9zysHmFhxrZlBVq5o5G0rDzNOZ+1XXhh6dr+xuecjOWeD6aGMXNjLMM8gelLOeRiOb1p+LDG8Q0PUn7/okEkoEoWe8zs9OFIGe5BabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508314; c=relaxed/simple;
	bh=uWMG2F279m99+BFcojb/AFuslMz+/oJtvTdz+OwZ1oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re1Ib7egU5Pqemgy+D6zComwkwKg0lLsCm0Rj16ZZRvHdtJLD8CMvJT9bHzwIXkiYPf6i+C4p2yGQ1ThJApPbIEikRhpWhZBgQkKBSN1jcds0tIYzL7IxbJaq3PAyYa/JuAgLr0ajn6gwK0WAU722GKDzkghEJuhxj1PQc1w6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DIV5pbU3; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YTzpY4Hy2z4X9;
	Fri, 10 Jan 2025 12:25:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736508309;
	bh=IbsOgWHIpOBlieRdOx5fQl6DmEA7c4s3aN6oGa1LhAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIV5pbU3KSqWN7mvVSCcGPl+o7gXWZRYCcogvVBMEttL4eFDSNgJJ4UvB5GwOghwf
	 ZojqDmPhc88gfSCpPGOKyKHlq2ttvvLnqkpxRZxIkp7Ku/OWZd1hkYtfukzF3e57fX
	 uqSPrB22aVUUa4ws4IUMWT6KU4j6qTM/2JA/eQQ4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YTzpX5B9bzm1y;
	Fri, 10 Jan 2025 12:25:08 +0100 (CET)
Date: Fri, 10 Jan 2025 12:25:08 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 22/30] selftests/landlock: Add
 layout1.umount_sandboxer tests
Message-ID: <20250110.chi1Uwa9ahB4@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-23-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108154338.1129069-23-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Jan 08, 2025 at 04:43:30PM +0100, Mickaël Salaün wrote:
> Check that a domain is not tied to the executable file that created it.
> For instance, that could happen if a Landlock domain took a reference to
> a struct path.
> 
> Move global path names to common.h and replace copy_binary() with a more
> generic copy_file() helper.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250108154338.1129069-23-mic@digikod.net

Pushed in my next tree to simplify next patch series.

> ---
> 
> Changes since v3:
> - New patch to check issue from v2.
> ---
>  tools/testing/selftests/landlock/Makefile     |  2 +-
>  tools/testing/selftests/landlock/common.h     |  3 +
>  tools/testing/selftests/landlock/fs_test.c    | 94 +++++++++++++++++--
>  .../selftests/landlock/sandbox-and-launch.c   | 82 ++++++++++++++++
>  tools/testing/selftests/landlock/wait-pipe.c  | 42 +++++++++
>  5 files changed, 213 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/sandbox-and-launch.c
>  create mode 100644 tools/testing/selftests/landlock/wait-pipe.c
> 
> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
> index 348e2dbdb4e0..b1445c8bee50 100644
> --- a/tools/testing/selftests/landlock/Makefile
> +++ b/tools/testing/selftests/landlock/Makefile
> @@ -10,7 +10,7 @@ src_test := $(wildcard *_test.c)
>  
>  TEST_GEN_PROGS := $(src_test:.c=)
>  
> -TEST_GEN_PROGS_EXTENDED := true
> +TEST_GEN_PROGS_EXTENDED := true sandbox-and-launch wait-pipe
>  
>  # Short targets:
>  $(TEST_GEN_PROGS): LDLIBS += -lcap
> diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
> index 8391ab574f64..a604ea5d8297 100644
> --- a/tools/testing/selftests/landlock/common.h
> +++ b/tools/testing/selftests/landlock/common.h
> @@ -28,6 +28,9 @@
>  /* TEST_F_FORK() should not be used for new tests. */
>  #define TEST_F_FORK(fixture_name, test_name) TEST_F(fixture_name, test_name)
>  
> +static const char bin_sandbox_and_launch[] = "./sandbox-and-launch";
> +static const char bin_wait_pipe[] = "./wait-pipe";
> +
>  static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
>  {
>  	cap_t cap_p;
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index a359c0d3107f..8ac9aaf38eaa 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -59,7 +59,7 @@ int open_tree(int dfd, const char *filename, unsigned int flags)
>  #define RENAME_EXCHANGE (1 << 1)
>  #endif
>  
> -#define BINARY_PATH "./true"
> +static const char bin_true[] = "./true";
>  
>  /* Paths (sibling number and depth) */
>  static const char dir_s1d1[] = TMP_DIR "/s1d1";
> @@ -1965,8 +1965,8 @@ TEST_F_FORK(layout1, relative_chroot_chdir)
>  	test_relative_path(_metadata, REL_CHROOT_CHDIR);
>  }
>  
> -static void copy_binary(struct __test_metadata *const _metadata,
> -			const char *const dst_path)
> +static void copy_file(struct __test_metadata *const _metadata,
> +		      const char *const src_path, const char *const dst_path)
>  {
>  	int dst_fd, src_fd;
>  	struct stat statbuf;
> @@ -1976,11 +1976,10 @@ static void copy_binary(struct __test_metadata *const _metadata,
>  	{
>  		TH_LOG("Failed to open \"%s\": %s", dst_path, strerror(errno));
>  	}
> -	src_fd = open(BINARY_PATH, O_RDONLY | O_CLOEXEC);
> +	src_fd = open(src_path, O_RDONLY | O_CLOEXEC);
>  	ASSERT_LE(0, src_fd)
>  	{
> -		TH_LOG("Failed to open \"" BINARY_PATH "\": %s",
> -		       strerror(errno));
> +		TH_LOG("Failed to open \"%s\": %s", src_path, strerror(errno));
>  	}
>  	ASSERT_EQ(0, fstat(src_fd, &statbuf));
>  	ASSERT_EQ(statbuf.st_size,
> @@ -2028,9 +2027,9 @@ TEST_F_FORK(layout1, execute)
>  		create_ruleset(_metadata, rules[0].access, rules);
>  
>  	ASSERT_LE(0, ruleset_fd);
> -	copy_binary(_metadata, file1_s1d1);
> -	copy_binary(_metadata, file1_s1d2);
> -	copy_binary(_metadata, file1_s1d3);
> +	copy_file(_metadata, bin_true, file1_s1d1);
> +	copy_file(_metadata, bin_true, file1_s1d2);
> +	copy_file(_metadata, bin_true, file1_s1d3);
>  
>  	enforce_ruleset(_metadata, ruleset_fd);
>  	ASSERT_EQ(0, close(ruleset_fd));
> @@ -2048,6 +2047,83 @@ TEST_F_FORK(layout1, execute)
>  	test_execute(_metadata, 0, file1_s1d3);
>  }
>  
> +TEST_F_FORK(layout1, umount_sandboxer)
> +{
> +	int pipe_child[2], pipe_parent[2];
> +	char buf_parent;
> +	pid_t child;
> +	int status;
> +
> +	copy_file(_metadata, bin_sandbox_and_launch, file1_s3d3);
> +	ASSERT_EQ(0, pipe2(pipe_child, 0));
> +	ASSERT_EQ(0, pipe2(pipe_parent, 0));
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		char pipe_child_str[12], pipe_parent_str[12];
> +		char *const argv[] = { (char *)file1_s3d3,
> +				       (char *)bin_wait_pipe, pipe_child_str,
> +				       pipe_parent_str, NULL };
> +
> +		/* Passes the pipe FDs to the executed binary and its child. */
> +		EXPECT_EQ(0, close(pipe_child[0]));
> +		EXPECT_EQ(0, close(pipe_parent[1]));
> +		snprintf(pipe_child_str, sizeof(pipe_child_str), "%d",
> +			 pipe_child[1]);
> +		snprintf(pipe_parent_str, sizeof(pipe_parent_str), "%d",
> +			 pipe_parent[0]);
> +
> +		/*
> +		 * We need bin_sandbox_and_launch (copied inside the mount as
> +		 * file1_s3d3) to execute bin_wait_pipe (outside the mount) to
> +		 * make sure the mount point will not be EBUSY because of
> +		 * file1_s3d3 being in use.  This avoids a potential race
> +		 * condition between the following read() and umount() calls.
> +		 */
> +		ASSERT_EQ(0, execve(argv[0], argv, NULL))
> +		{
> +			TH_LOG("Failed to execute \"%s\": %s", argv[0],
> +			       strerror(errno));
> +		};
> +		_exit(1);
> +		return;
> +	}
> +
> +	EXPECT_EQ(0, close(pipe_child[1]));
> +	EXPECT_EQ(0, close(pipe_parent[0]));
> +
> +	/* Waits for the child to sandbox itself. */
> +	EXPECT_EQ(1, read(pipe_child[0], &buf_parent, 1));
> +
> +	/* Tests that the sandboxer is tied to its mount point. */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	EXPECT_EQ(-1, umount(dir_s3d2));
> +	EXPECT_EQ(EBUSY, errno);
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	/* Signals the child to launch a grandchild. */
> +	EXPECT_EQ(1, write(pipe_parent[1], ".", 1));
> +
> +	/* Waits for the grandchild. */
> +	EXPECT_EQ(1, read(pipe_child[0], &buf_parent, 1));
> +
> +	/* Tests that the domain's sandboxer is not tied to its mount point. */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	EXPECT_EQ(0, umount(dir_s3d2))
> +	{
> +		TH_LOG("Failed to umount \"%s\": %s", dir_s3d2,
> +		       strerror(errno));
> +	};
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	/* Signals the grandchild to terminate. */
> +	EXPECT_EQ(1, write(pipe_parent[1], ".", 1));
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	ASSERT_EQ(1, WIFEXITED(status));
> +	ASSERT_EQ(0, WEXITSTATUS(status));
> +}
> +
>  TEST_F_FORK(layout1, link)
>  {
>  	const struct rule layer1[] = {
> diff --git a/tools/testing/selftests/landlock/sandbox-and-launch.c b/tools/testing/selftests/landlock/sandbox-and-launch.c
> new file mode 100644
> index 000000000000..1ef49f349429
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/sandbox-and-launch.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sandbox itself and execute another program (in a different mount point).
> + *
> + * Used by layout1.umount_sandboxer from fs_test.c
> + *
> + * Copyright © 2024 Microsoft Corporation
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/prctl.h>
> +#include <unistd.h>
> +
> +#include "wrappers.h"
> +
> +int main(int argc, char *argv[])
> +{
> +	struct landlock_ruleset_attr ruleset_attr = {
> +		.scoped = LANDLOCK_SCOPE_SIGNAL,
> +	};
> +	int pipe_child, pipe_parent, ruleset_fd;
> +	char buf;
> +
> +	/*
> +	 * The first argument must be the file descriptor number of a pipe.
> +	 * The second argument must be the program to execute.
> +	 */
> +	if (argc != 4) {
> +		fprintf(stderr, "Wrong number of arguments (not three)\n");
> +		return 1;
> +	}
> +
> +	pipe_child = atoi(argv[2]);
> +	pipe_parent = atoi(argv[3]);
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	if (ruleset_fd < 0) {
> +		perror("Failed to create ruleset");
> +		return 1;
> +	}
> +
> +	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
> +		perror("Failed to call prctl()");
> +		return 1;
> +	}
> +
> +	if (landlock_restrict_self(ruleset_fd, 0)) {
> +		perror("Failed to restrict self");
> +		return 1;
> +	}
> +
> +	if (close(ruleset_fd)) {
> +		perror("Failed to close ruleset");
> +		return 1;
> +	}
> +
> +	/* Signals that we are sandboxed. */
> +	errno = 0;
> +	if (write(pipe_child, ".", 1) != 1) {
> +		perror("Failed to write to the second argument");
> +		return 1;
> +	}
> +
> +	/* Waits for the parent to try to umount. */
> +	if (read(pipe_parent, &buf, 1) != 1) {
> +		perror("Failed to write to the third argument");
> +		return 1;
> +	}
> +
> +	/* Shifts arguments. */
> +	argv[0] = argv[1];
> +	argv[1] = argv[2];
> +	argv[2] = argv[3];
> +	argv[3] = NULL;
> +	execve(argv[0], argv, NULL);
> +	perror("Failed to execute the provided binary");
> +	return 1;
> +}
> diff --git a/tools/testing/selftests/landlock/wait-pipe.c b/tools/testing/selftests/landlock/wait-pipe.c
> new file mode 100644
> index 000000000000..0dbcd260a0fa
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/wait-pipe.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Write in a pipe and wait.
> + *
> + * Used by layout1.umount_sandboxer from fs_test.c
> + *
> + * Copyright © 2024-2025 Microsoft Corporation
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +int main(int argc, char *argv[])
> +{
> +	int pipe_child, pipe_parent;
> +	char buf;
> +
> +	/* The first argument must be the file descriptor number of a pipe. */
> +	if (argc != 3) {
> +		fprintf(stderr, "Wrong number of arguments (not two)\n");
> +		return 1;
> +	}
> +
> +	pipe_child = atoi(argv[1]);
> +	pipe_parent = atoi(argv[2]);
> +
> +	/* Signals that we are waiting. */
> +	if (write(pipe_child, ".", 1) != 1) {
> +		perror("Failed to write to first argument");
> +		return 1;
> +	}
> +
> +	/* Waits for the parent do its test. */
> +	if (read(pipe_parent, &buf, 1) != 1) {
> +		perror("Failed to write to the second argument");
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> -- 
> 2.47.1
> 
> 

