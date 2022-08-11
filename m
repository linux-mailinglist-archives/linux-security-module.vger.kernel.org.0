Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6070059058C
	for <lists+linux-security-module@lfdr.de>; Thu, 11 Aug 2022 19:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiHKRPZ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 11 Aug 2022 13:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbiHKROw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Aug 2022 13:14:52 -0400
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AABF13
        for <linux-security-module@vger.kernel.org>; Thu, 11 Aug 2022 09:59:41 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M3Y232rFZzMqPRk;
        Thu, 11 Aug 2022 18:59:39 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4M3Y226kH4zlrKcg;
        Thu, 11 Aug 2022 18:59:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1660237179;
        bh=ZcmzDu8m3HZOuhVsJJCKrT8/W4uG5CpXWVzF7YLAh40=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=apFeXDsAYZ6GCeIQAQQ54QqYceNfy2Vj3m7ZDuTHjncJuSVfohxZk3kdCXm4FkCHb
         ocm4Opir5ydxyhLJZYvJs1OVFrldsR6XJ0vEmDFnvbsMenpHRrMSYKSIKO2ovk0jiR
         KNEFXftSWiUFm7kDfOF/k1j5BWkSEX50ShNJ6t1c=
Message-ID: <40ad7781-a94d-7be2-e5b9-64b6893a669e@digikod.net>
Date:   Thu, 11 Aug 2022 18:59:38 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
References: <20220804193746.9161-1-gnoack3000@gmail.com>
 <20220804193746.9161-3-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v3 2/4] selftests/landlock: Selftests for file truncation
 support
In-Reply-To: <20220804193746.9161-3-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 04/08/2022 21:37, Günther Noack wrote:
> These tests exercise the following truncation operations:
> 
> * truncate() (truncate by path)
> * ftruncate() (truncate by file descriptor)
> * open with the O_TRUNC flag
> * special case: creat(), which is open with O_CREAT|O_WRONLY|O_TRUNC.
> 
> in the following scenarios:
> 
> * Files with read, write and truncate rights.
> * Files with read and truncate rights.
> * Files with the truncate right.
> * Files without the truncate right.
> 
> In particular, the following scenarios are enforced with the test:
> 
> * The truncate right is required to use ftruncate,
>    even when the thread already has the right to write to the file.
> * open() with O_TRUNC requires the truncate right, if it truncates a file.
>    open() already checks security_path_truncate() in this case,
>    and it required no additional check in the Landlock LSM's file_open hook.
> * creat() requires the truncate right
>    when called with an existing filename.
> * creat() does *not* require the truncate right
>    when it's creating a new file.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   tools/testing/selftests/landlock/fs_test.c | 204 +++++++++++++++++++++
>   1 file changed, 204 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index cb77eaa01c91..3e84bae7e83a 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -58,6 +58,7 @@ static const char file1_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f1";
>   static const char file2_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f2";
>   
>   static const char dir_s3d1[] = TMP_DIR "/s3d1";
> +static const char file1_s3d1[] = TMP_DIR "/s3d1/f1";
>   /* dir_s3d2 is a mount point. */
>   static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
>   static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
> @@ -83,6 +84,7 @@ static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
>    * │           ├── f1
>    * │           └── f2
>    * └── s3d1
> + *     ├── f1
>    *     └── s3d2
>    *         └── s3d3
>    */
> @@ -208,6 +210,7 @@ static void create_layout1(struct __test_metadata *const _metadata)
>   	create_file(_metadata, file1_s2d3);
>   	create_file(_metadata, file2_s2d3);
>   
> +	create_file(_metadata, file1_s3d1);
>   	create_directory(_metadata, dir_s3d2);
>   	set_cap(_metadata, CAP_SYS_ADMIN);
>   	ASSERT_EQ(0, mount("tmp", dir_s3d2, "tmpfs", 0, "size=4m,mode=700"));
> @@ -230,6 +233,7 @@ static void remove_layout1(struct __test_metadata *const _metadata)
>   	EXPECT_EQ(0, remove_path(file1_s2d2));
>   	EXPECT_EQ(0, remove_path(file1_s2d1));
>   
> +	EXPECT_EQ(0, remove_path(file1_s3d1));
>   	EXPECT_EQ(0, remove_path(dir_s3d3));
>   	set_cap(_metadata, CAP_SYS_ADMIN);
>   	umount(dir_s3d2);
> @@ -3023,6 +3027,206 @@ TEST_F_FORK(layout1, proc_pipe)
>   	ASSERT_EQ(0, close(pipe_fds[1]));
>   }
>   
> +/* Opens the file, invokes ftruncate(2) and returns the errno or 0. */
> +static int test_ftruncate(struct __test_metadata *const _metadata,
> +			  const char *const path, int flags)
> +{
> +	int res, err, fd;
> +
> +	fd = open(path, flags | O_CLOEXEC);
> +	ASSERT_LE(0, fd);
> +
> +	res = ftruncate(fd, 10);
> +	err = errno;
> +	ASSERT_EQ(0, close(fd));
> +
> +	if (res < 0)
> +		return err;
> +	return 0;
> +}
> +
> +/* Invokes truncate(2) and returns the errno or 0. */
> +static int test_truncate(const char *const path)
> +{
> +	if (truncate(path, 10) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +/* Invokes creat(2) and returns the errno or 0. */
> +static int test_creat(struct __test_metadata *const _metadata,
> +		      const char *const path, mode_t mode)
> +{
> +	int fd = creat(path, mode);
> +
> +	if (fd < 0)
> +		return errno;
> +	ASSERT_EQ(0, close(fd));

test_creat() contains an ASSERT, which would only print this line, which 
would not help much if it is called multiple times, which is the case. I 
prefer not passing _metadata but only returning errno or 0 and handling 
the ASSERT in layout1.truncate* . It is not the case everywhere but we 
should try to follow this rule as much as possible.


> +	return 0;
> +}
> +
> +TEST_F_FORK(layout1, truncate)
> +{
> +	const char *const file_rwt = file1_s1d1;
> +	const char *const file_rw = file2_s1d1;
> +	const char *const file_rt = file1_s1d2;
> +	const char *const file_t = file2_s1d2;
> +	const char *const file_none = file1_s1d3;
> +	const char *const dir_t = dir_s2d1;
> +	const char *const file_in_dir_t = file1_s2d1;
> +	const char *const dir_w = dir_s3d1;
> +	const char *const file_in_dir_w = file1_s3d1;
> +	const struct rule rules[] = {
> +		{
> +			.path = file_rwt,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE |
> +				  LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		{
> +			.path = file_rw,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{
> +			.path = file_rt,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		{
> +			.path = file_t,
> +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		// Implicitly: No access rights for file_none.
> +		{
> +			.path = dir_t,
> +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		{
> +			.path = dir_w,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{},
> +	};
> +	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +			      LANDLOCK_ACCESS_FS_WRITE_FILE |
> +			      LANDLOCK_ACCESS_FS_TRUNCATE;
> +	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/*
> +	 * Checks read, write and truncate rights: truncation works.
> +	 *
> +	 * Note: Independent of Landlock, ftruncate(2) on read-only
> +	 * file descriptors never works.
> +	 */
> +	EXPECT_EQ(0, test_ftruncate(_metadata, file_rwt, O_WRONLY));

Other than following the original Google Test documentation, what is the 
advantage to use EXPECT? Don't you think it would be harder to debug a 
bunch of failed expect? What is the reason for other test frameworks to 
not implement EXPECT? How Chromium or other Google code really use it? 
Genuine questions.


> +	EXPECT_EQ(EINVAL, test_ftruncate(_metadata, file_rwt, O_RDONLY));
> +	EXPECT_EQ(0, test_truncate(file_rwt));
> +	EXPECT_EQ(0, test_open(file_rwt, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(0, test_open(file_rwt, O_RDONLY | O_TRUNC));
> +
> +	/* Checks read and write rights: no truncate variant works. */
> +	EXPECT_EQ(EACCES, test_ftruncate(_metadata, file_rw, O_WRONLY));
> +	EXPECT_EQ(EINVAL, test_ftruncate(_metadata, file_rw, O_RDONLY));
> +	EXPECT_EQ(EACCES, test_truncate(file_rw));
> +	EXPECT_EQ(EACCES, test_open(file_rw, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_rw, O_RDONLY | O_TRUNC));
> +
> +	/*
> +	 * Checks read and truncate rights: truncation works.
> +	 *
> +	 * Note: Files opened in O_RDONLY can get truncated as part of
> +	 * the same operation.
> +	 */
> +	EXPECT_EQ(0, test_open(file_rt, O_RDONLY));
> +	EXPECT_EQ(0, test_open(file_rt, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_rt, O_WRONLY));
> +	EXPECT_EQ(EACCES, test_open(file_rt, O_WRONLY));
> +	EXPECT_EQ(0, test_truncate(file_rt));
> +
> +	/* Checks truncate right: truncate works, but can't open file. */
> +	EXPECT_EQ(EACCES, test_open(file_t, O_WRONLY));
> +	EXPECT_EQ(EACCES, test_open(file_t, O_RDONLY));
> +	EXPECT_EQ(EACCES, test_open(file_t, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_t, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(0, test_truncate(file_t));
> +
> +	/* Checks "no rights" case: No form of truncation works. */
> +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_truncate(file_none));
> +
> +	/* Checks truncate right on directory: truncate works on contained files */
> +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_WRONLY));
> +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_RDONLY));
> +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(0, test_truncate(file_in_dir_t));
> +
> +	/*
> +	 * Checks creat in dir_w: This requires the truncate right
> +	 * when overwriting an existing file, but does not require it
> +	 * when the file is new.
> +	 */
> +	EXPECT_EQ(EACCES, test_creat(_metadata, file_in_dir_w, 0600));
> +
> +	ASSERT_EQ(0, unlink(file_in_dir_w));
> +	EXPECT_EQ(0, test_creat(_metadata, file_in_dir_w, 0600));
> +}
> +
> +/*
> + * Exercises file truncation when it's not restricted,
> + * as it was the case before LANDLOCK_ACCESS_FS_TRUNCATE existed.
> + */
> +TEST_F_FORK(layout1, truncate_unhandled)
> +{
> +	const char *const file_r = file1_s1d1;
> +	const char *const file_w = file2_s1d1;
> +	const char *const file_none = file1_s1d2;
> +	const struct rule rules[] = {
> +		{
> +			.path = file_r,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE,
> +		},
> +		{
> +			.path = file_w,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		// Implicitly: No rights for file_none.
> +		{},
> +	};
> +	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +			      LANDLOCK_ACCESS_FS_WRITE_FILE;
> +	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Checks read right: truncation should work through truncate and open. */
> +	EXPECT_EQ(0, test_truncate(file_r));
> +	EXPECT_EQ(0, test_open(file_r, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_r, O_WRONLY | O_TRUNC));
> +
> +	/* Checks write right: truncation should work through truncate, ftruncate and open. */
> +	EXPECT_EQ(0, test_truncate(file_w));
> +	EXPECT_EQ(0, test_ftruncate(_metadata, file_w, O_WRONLY));
> +	EXPECT_EQ(EACCES, test_open(file_w, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(0, test_open(file_w, O_WRONLY | O_TRUNC));
> +
> +	/* Checks "no rights" case: truncate works but all open attempts fail. */
> +	EXPECT_EQ(0, test_truncate(file_none));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY));
> +}

These tests looks good!

> +
>   /* clang-format off */
>   FIXTURE(layout1_bind) {};
>   /* clang-format on */
