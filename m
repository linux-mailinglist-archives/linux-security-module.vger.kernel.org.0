Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD8591A2B
	for <lists+linux-security-module@lfdr.de>; Sat, 13 Aug 2022 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiHMMpV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 13 Aug 2022 08:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiHMMpU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 13 Aug 2022 08:45:20 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00ACEC
        for <linux-security-module@vger.kernel.org>; Sat, 13 Aug 2022 05:45:16 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M4gHZ33NtzMpyq3;
        Sat, 13 Aug 2022 14:45:14 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4M4gHY225JzlnSCY;
        Sat, 13 Aug 2022 14:45:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1660394714;
        bh=IQrIbF2VtrmodfDdxmTdVekCba+4wRAWVddcJUVPo5Y=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=XfLX8Z+Nko+Gy1i8w8BcIMgb1WQYBvE4k+gewmW74iK65dQzjSUkj5T9J8wAC+/uf
         ohqd5diqPDhfX3PdU0tulr/AF5pnSIXftdOz/wwAMhWiIENETIXb4e7eGJ2FHPv6BF
         BJsR8H+tRZisyVWODHVvkgtYrTP98ROdKn7wWyhU=
Message-ID: <0e9d3b82-e08c-4f5d-012f-c3649da357bf@digikod.net>
Date:   Sat, 13 Aug 2022 14:45:12 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
References: <20220804193746.9161-1-gnoack3000@gmail.com>
 <20220804193746.9161-3-gnoack3000@gmail.com>
 <40ad7781-a94d-7be2-e5b9-64b6893a669e@digikod.net> <Yvd3+fy+mDBop+YA@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v3 2/4] selftests/landlock: Selftests for file truncation
 support
In-Reply-To: <Yvd3+fy+mDBop+YA@nuc>
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


On 13/08/2022 12:07, Günther Noack wrote:
> On Thu, Aug 11, 2022 at 06:59:38PM +0200, Mickaël Salaün wrote:
>>
>> On 04/08/2022 21:37, Günther Noack wrote:
>>> These tests exercise the following truncation operations:
>>>
>>> * truncate() (truncate by path)
>>> * ftruncate() (truncate by file descriptor)
>>> * open with the O_TRUNC flag
>>> * special case: creat(), which is open with O_CREAT|O_WRONLY|O_TRUNC.
>>>
>>> in the following scenarios:
>>>
>>> * Files with read, write and truncate rights.
>>> * Files with read and truncate rights.
>>> * Files with the truncate right.
>>> * Files without the truncate right.
>>>
>>> In particular, the following scenarios are enforced with the test:
>>>
>>> * The truncate right is required to use ftruncate,
>>>     even when the thread already has the right to write to the file.
>>> * open() with O_TRUNC requires the truncate right, if it truncates a file.
>>>     open() already checks security_path_truncate() in this case,
>>>     and it required no additional check in the Landlock LSM's file_open hook.
>>> * creat() requires the truncate right
>>>     when called with an existing filename.
>>> * creat() does *not* require the truncate right
>>>     when it's creating a new file.
>>>
>>> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
>>> ---
>>>    tools/testing/selftests/landlock/fs_test.c | 204 +++++++++++++++++++++
>>>    1 file changed, 204 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
>>> index cb77eaa01c91..3e84bae7e83a 100644
>>> --- a/tools/testing/selftests/landlock/fs_test.c
>>> +++ b/tools/testing/selftests/landlock/fs_test.c
>>> @@ -58,6 +58,7 @@ static const char file1_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f1";
>>>    static const char file2_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f2";
>>>    static const char dir_s3d1[] = TMP_DIR "/s3d1";
>>> +static const char file1_s3d1[] = TMP_DIR "/s3d1/f1";
>>>    /* dir_s3d2 is a mount point. */
>>>    static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
>>>    static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
>>> @@ -83,6 +84,7 @@ static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
>>>     * │           ├── f1
>>>     * │           └── f2
>>>     * └── s3d1
>>> + *     ├── f1
>>>     *     └── s3d2
>>>     *         └── s3d3
>>>     */
>>> @@ -208,6 +210,7 @@ static void create_layout1(struct __test_metadata *const _metadata)
>>>    	create_file(_metadata, file1_s2d3);
>>>    	create_file(_metadata, file2_s2d3);
>>> +	create_file(_metadata, file1_s3d1);
>>>    	create_directory(_metadata, dir_s3d2);
>>>    	set_cap(_metadata, CAP_SYS_ADMIN);
>>>    	ASSERT_EQ(0, mount("tmp", dir_s3d2, "tmpfs", 0, "size=4m,mode=700"));
>>> @@ -230,6 +233,7 @@ static void remove_layout1(struct __test_metadata *const _metadata)
>>>    	EXPECT_EQ(0, remove_path(file1_s2d2));
>>>    	EXPECT_EQ(0, remove_path(file1_s2d1));
>>> +	EXPECT_EQ(0, remove_path(file1_s3d1));
>>>    	EXPECT_EQ(0, remove_path(dir_s3d3));
>>>    	set_cap(_metadata, CAP_SYS_ADMIN);
>>>    	umount(dir_s3d2);
>>> @@ -3023,6 +3027,206 @@ TEST_F_FORK(layout1, proc_pipe)
>>>    	ASSERT_EQ(0, close(pipe_fds[1]));
>>>    }
>>> +/* Opens the file, invokes ftruncate(2) and returns the errno or 0. */
>>> +static int test_ftruncate(struct __test_metadata *const _metadata,
>>> +			  const char *const path, int flags)
>>> +{
>>> +	int res, err, fd;
>>> +
>>> +	fd = open(path, flags | O_CLOEXEC);
>>> +	ASSERT_LE(0, fd);
>>> +
>>> +	res = ftruncate(fd, 10);
>>> +	err = errno;
>>> +	ASSERT_EQ(0, close(fd));
>>> +
>>> +	if (res < 0)
>>> +		return err;
>>> +	return 0;
>>> +}
>>> +
>>> +/* Invokes truncate(2) and returns the errno or 0. */
>>> +static int test_truncate(const char *const path)
>>> +{
>>> +	if (truncate(path, 10) < 0)
>>> +		return errno;
>>> +	return 0;
>>> +}
>>> +
>>> +/* Invokes creat(2) and returns the errno or 0. */
>>> +static int test_creat(struct __test_metadata *const _metadata,
>>> +		      const char *const path, mode_t mode)
>>> +{
>>> +	int fd = creat(path, mode);
>>> +
>>> +	if (fd < 0)
>>> +		return errno;
>>> +	ASSERT_EQ(0, close(fd));
>>
>> test_creat() contains an ASSERT, which would only print this line, which
>> would not help much if it is called multiple times, which is the case. I
>> prefer not passing _metadata but only returning errno or 0 and handling the
>> ASSERT in layout1.truncate* . It is not the case everywhere but we should
>> try to follow this rule as much as possible.
> 
> Thanks, that's a good point that the line number attribution becomes confusing.
> 
> I changed these ASSERT_EQ() calls to just return the errno directly.
> 
> 
>>> +	return 0;
>>> +}
>>> +
>>> +TEST_F_FORK(layout1, truncate)
>>> +{
>>> +	const char *const file_rwt = file1_s1d1;
>>> +	const char *const file_rw = file2_s1d1;
>>> +	const char *const file_rt = file1_s1d2;
>>> +	const char *const file_t = file2_s1d2;
>>> +	const char *const file_none = file1_s1d3;
>>> +	const char *const dir_t = dir_s2d1;
>>> +	const char *const file_in_dir_t = file1_s2d1;
>>> +	const char *const dir_w = dir_s3d1;
>>> +	const char *const file_in_dir_w = file1_s3d1;
>>> +	const struct rule rules[] = {
>>> +		{
>>> +			.path = file_rwt,
>>> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
>>> +				  LANDLOCK_ACCESS_FS_WRITE_FILE |
>>> +				  LANDLOCK_ACCESS_FS_TRUNCATE,
>>> +		},
>>> +		{
>>> +			.path = file_rw,
>>> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
>>> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
>>> +		},
>>> +		{
>>> +			.path = file_rt,
>>> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
>>> +				  LANDLOCK_ACCESS_FS_TRUNCATE,
>>> +		},
>>> +		{
>>> +			.path = file_t,
>>> +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
>>> +		},
>>> +		// Implicitly: No access rights for file_none.
>>> +		{
>>> +			.path = dir_t,
>>> +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
>>> +		},
>>> +		{
>>> +			.path = dir_w,
>>> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
>>> +		},
>>> +		{},
>>> +	};
>>> +	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
>>> +			      LANDLOCK_ACCESS_FS_WRITE_FILE |
>>> +			      LANDLOCK_ACCESS_FS_TRUNCATE;
>>> +	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
>>> +
>>> +	ASSERT_LE(0, ruleset_fd);
>>> +	enforce_ruleset(_metadata, ruleset_fd);
>>> +	ASSERT_EQ(0, close(ruleset_fd));
>>> +
>>> +	/*
>>> +	 * Checks read, write and truncate rights: truncation works.
>>> +	 *
>>> +	 * Note: Independent of Landlock, ftruncate(2) on read-only
>>> +	 * file descriptors never works.
>>> +	 */
>>> +	EXPECT_EQ(0, test_ftruncate(_metadata, file_rwt, O_WRONLY));
>>
>> Other than following the original Google Test documentation, what is the
>> advantage to use EXPECT? Don't you think it would be harder to debug a bunch
>> of failed expect?
> 
> <This is maybe slightly philosophical, which means that I have no hard
> proof for any of this, but I'm happy to discuss it :)>
> 
> I think at the root, most test frameworks agree that the test output
> should ideally be a list of mostly-independent test scenarios together
> with their failure statuses.
> 
> I think it is actually *easier* to debug a bunch of failed
> expectations if they fail at the same time: When multiple of these
> scenarios fail at the same time, that would give you a hint that
> something more fundamental is broken, whereas when only one of them
> fails, you'd know that it is a problem specific to the test scenario
> at hand.
> 
>> What is the reason for other test frameworks to not
>> implement EXPECT?
> 
> The way that the different test frameworks try to achieve this "table
> of scenarios" output is different:
> 
> The JUnit/xUnit-style frameworks only have an ASSERT-equivalent, and I
> think in these testing cultures there is a greater emphasis on having
> a separate test function for each exercised scenario. That way, you
> still end up with a long table of test scenarios with their failure
> statuses. -- But that is not the test structure that we have here in
> the Landlock selftests.
> 
> In Googletest, or in the Go test framework, there is a distinction
> between ASSERT and EXPECT, and people are more encouraged to test
> multiple similar scenarios in the same function (in Go, they call it a
> "table driven test"). It works as well, as long as people take care
> that the scenarios that are tested together don't accidentally depend
> on each others left-over state.
> 
> I'm not sure why some test frameworks do this with assert-only and
> others distinguish between assert and expect.
> 
> I *suspect* that in C and C++, it is more difficult to factor out
> shared test setup code than in Java or Python, and so people tend to
> write bigger test functions that exercise more scenarios at once, and
> then the distinction between assert and expect became more useful.
> 
> <end of philosophical derail>
> 
> 
>> How Chromium or other Google code really use it? Genuine questions.
> 
> This is how Chromium uses it:
> 
> https://source.chromium.org/search?q=ASSERT_EQ (~6000 hits)
> https://source.chromium.org/search?q=EXPECT_EQ (~5800 hits)
> 
> This is how Absl uses it (from the website: "Abseil is an open source
> collection of C++ libraries drawn from the most fundamental pieces of
> Google’s internal codebase."):
> 
> https://github.com/abseil/abseil-cpp/search?q=EXPECT_EQ (163 results)
> https://github.com/abseil/abseil-cpp/search?q=ASSERT_EQ (24 results)
> 
> In Chromium, there are clearly some corners where they use ASSERT
> exclusively. In Abseil, I think it gets used more in the spirit of the
> framework, but it's also a smaller codebase.

Thanks for these explanations!

> 
> 
> **To make a constructive proposal**:
> 
> I think that using EXPECT improves debuggability in case of a test
> failure, but both with EXPECT and with ASSERT, the tests will give the
> same guarantee that the code works, so I feel that this should not be
> blocking the truncate patch... so I'd just go and convert it all to
> ASSERTs, it'll be consistent with the surrounding tests, and we can
> have that EXPECT/ASSERT discussion separately if you like. Does that
> sound good?

You did the work to differentiate EXPECT from ASSERT, and as long as 
failing an EXPECT doesn't change the semantic of the next tests (i.e. 
not changing a common state, e.g. by creating or removing a file), I 
think we should keep your current code. This may be tricky to do 
correctly, hence my reluctance. I'll think a bit more about that but it 
will be much more easier to replace EXPECT with ASSERT than to re-add 
EXPECT, and it wouldn't require another patch series, so let's not 
change your patch. :)
