Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3D59F5E9
	for <lists+linux-security-module@lfdr.de>; Wed, 24 Aug 2022 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiHXJJF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 24 Aug 2022 05:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiHXJJF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Aug 2022 05:09:05 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEE77FE7E
        for <linux-security-module@vger.kernel.org>; Wed, 24 Aug 2022 02:09:00 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MCKyy3bQjzMpv4C;
        Wed, 24 Aug 2022 11:08:58 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MCKyy0Jd3zlh8TN;
        Wed, 24 Aug 2022 11:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661332138;
        bh=xK0dNHiC+fa+DP9my7HNgGtjSsIeaFdRMmWZrKWWL/w=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=e73aRn3cw6OXeHBP7o5Uwkvg0+44o+DeaFlrQk0rmAQocttQUs+Egpe8KKZoHY5dP
         4yfg5assHgAQ8DA2NxdgvLO6CymboUq6pZX5RToTd18szsPCtwc6buvjH7A0s6ZedH
         3O6AI70s6LMcc2AFGdSa57nO5aSGSXTE60Zzm1cE=
Message-ID: <d11fb442-da45-5c4f-ce89-678b5f9bee17@digikod.net>
Date:   Wed, 24 Aug 2022 11:08:57 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>
Cc:     jorgelo@chromium.org, linux-security-module@vger.kernel.org,
        groeck@chromium.org, Jeff Xu <jeffxu@chromium.org>,
        Kees Cook <keescook@chromium.org>
References: <20220823010216.2653012-1-jeffxu@google.com>
 <32d37192-8290-4e8d-32c6-f6992ec2f3ec@digikod.net>
 <CALmYWFsf-Nh6azOV5rVrv+U2sKFME9ubbF6iuGO7mFes=asEQQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v4] selftests/landlock: skip overlayfs test when kernel
 not support it
In-Reply-To: <CALmYWFsf-Nh6azOV5rVrv+U2sKFME9ubbF6iuGO7mFes=asEQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 24/08/2022 01:47, Jeff Xu wrote:
>> I guess this is because of the TEST_F_FORK() helper which doesn't handle
>> well the skipped with error tests, hence the parent test process trying
>> to execute the teardown and unmounting something which is not mounted it
>> its namespace, and the duplicated messages.
> 
>> This may be related to commit 63e6b2a42342 ("selftests/harness: Run
>> TEARDOWN for ASSERT failures").
> 
>> Can you fix TEST_F_FORK() for skipped tests please?
> 
>> We should merge TEST_F_FORK() within kselftest_harness.h with a follow
>> up patch though.
> 
> OK. That can be after I worked on pt_test.

Right, but that is independent from the TEST_F_FORK() fix which should 
be easier to do and make backport possible.


> 
> Would you like me to move supports_overlayfs() to the beginning of
> layout2_overlay in this Patch ?
> then there is nothing to cleanup.

I'm not sure this would be enough, and the current approach is good. 
TEST_F_FORK() needs some investigation.


> 
>> On 23/08/2022 03:02, jeffxu@google.com wrote:
>>> From: Jeff Xu <jeffxu@google.com>
>>
>> This is not consistent with your Signed-off-by email.
> 
> Sure, will try to switch to send patch via jeffxu@chromium.org
> 
> 
> On Tue, Aug 23, 2022 at 8:28 AM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> This looks good overall. You'll find some nitpicking review below.
>>
>> I found that there is an issue with the skipped test, and especially the
>> teardown parts:
>>
>>> #  RUN           layout2_overlay.no_restriction ...
>>> #      SKIP      overlayfs is not supported
>>> # fs_test.c:3537:no_restriction:Expected 0 (0) == test_open(merge_fl1, O_RDONLY) (2)
>>> # fs_test.c:3512:no_restriction:Expected 0 (0) == umount(MERGE_DATA) (-1)
>>
>> These messages seem OK…
>>
>>> # fs_test.c:3496:no_restriction:Expected 0 (0) == umount(LOWER_BASE) (-1)
>>> # fs_test.c:3507:no_restriction:Expected 0 (0) == umount(UPPER_BASE) (-1)
>>
>> …but these two should not happen because the tmpfs should still be mounted.
>>
>>
>>> #            OK  layout2_overlay.no_restriction
>>> ok 58 # SKIP overlayfs is not supported
>>> #  RUN           layout2_overlay.same_content_different_file ...
>>> # fs_test.c:3512:no_restriction:Expected 0 (0) == umount(MERGE_DATA) (-1)
>>
>> These is some inconsistencies here too.
>>
>>> # fs_test.c:230:no_restriction:Expected 0 (0) == umount(TMP_DIR) (-1)
>>> #      SKIP      overlayfs is not supported
>>> # fs_test.c:3723:same_content_different_file:Expected 0 (0) == test_open(path_entry, O_RDWR) (2)
>>> # fs_test.c:3496:same_content_different_file:Expected 0 (0) == umount(LOWER_BASE) (-1)
>>> # fs_test.c:3498:same_content_different_file:Expected 0 (0) == remove_path(LOWER_BASE) (16)
>>> # fs_test.c:3507:same_content_different_file:Expected 0 (0) == umount(UPPER_BASE) (-1)
>>> # fs_test.c:3509:same_content_different_file:Expected 0 (0) == remove_path(UPPER_BASE) (16)
>>> # fs_test.c:3512:same_content_different_file:Expected 0 (0) == umount(MERGE_DATA) (-1)
>>> # fs_test.c:230:same_content_different_file:Expected 0 (0) == umount(TMP_DIR) (-1)
>>> # fs_test.c:232:same_content_different_file:Expected 0 (0) == remove_path(TMP_DIR) (16)
>>> # fs_test.c:3512:same_content_different_file:Expected 0 (0) == umount(MERGE_DATA) (-1)
>>
>> I guess this is because of the TEST_F_FORK() helper which doesn't handle
>> well the skipped with error tests, hence the parent test process trying
>> to execute the teardown and unmounting something which is not mounted it
>> its namespace, and the duplicated messages.
>>
>> This may be related to commit 63e6b2a42342 ("selftests/harness: Run
>> TEARDOWN for ASSERT failures").
>>
>> Can you fix TEST_F_FORK() for skipped tests please?
>>
>> We should merge TEST_F_FORK() within kselftest_harness.h with a follow
>> up patch though.
>>
>>
>> On 23/08/2022 03:02, jeffxu@google.com wrote:
>>> From: Jeff Xu <jeffxu@google.com>
>>
>> This is not consistent with your Signed-off-by email.
>>
>>>
>>> Overlayfs can be disabled in kernel config, causing related tests to fail.
>>> Add check for overlayfs’s supportability at runtime, so we can call SKIP()
>>> when needed.
>>
>> selftests/landlock: Skip overlayfs tests when not supported
>>
>> overlayfs can be disabled in the kernel configuration (which is the case
>> for chromeOS), causing related tests to fail.  Skip such tests when an
>> overlayfs mount operation failed because the running kernel doesn't
>> support this file system.
>>
>>
>>>
>>> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>>> Reviewed-by: Guenter Roeck <groeck@chromium.org>
>>> ---
>>>    tools/testing/selftests/landlock/fs_test.c | 53 ++++++++++++++++++++--
>>>    1 file changed, 50 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
>>> index 21a2ce8fa739..aaece185579d 100644
>>> --- a/tools/testing/selftests/landlock/fs_test.c
>>> +++ b/tools/testing/selftests/landlock/fs_test.c
>>> @@ -11,6 +11,7 @@
>>>    #include <fcntl.h>
>>>    #include <linux/landlock.h>
>>>    #include <sched.h>
>>> +#include <stdio.h>
>>>    #include <string.h>
>>>    #include <sys/capability.h>
>>>    #include <sys/mount.h>
>>> @@ -62,6 +63,7 @@ static const char dir_s3d1[] = TMP_DIR "/s3d1";
>>>    static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
>>>    static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
>>>
>>> +static const char proc_filesystems[] = "/proc/filesystems";
>>
>> No need for this global variable, just use the string in the fopen() call.
>>
>>
>>>    /*
>>>     * layout1 hierarchy:
>>>     *
>>> @@ -169,6 +171,42 @@ static int remove_path(const char *const path)
>>>        return err;
>>>    }
>>>
>>> +static bool fgrep(FILE *inf, const char *str)
>>
>> const char *const str
>>
>> s/inf/file/
>>
>>
>>> +{
>>> +     char line[32];
>>> +     int slen = strlen(str);
>>
>> s/slen/str_len/
>>
>>> +
>>> +     while (!feof(inf)) {
>>> +             if (!fgets(line, sizeof(line), inf))
>>> +                     break;
>>> +             if (strncmp(line, str, slen))
>>> +                     continue;
>>> +
>>> +             return true;
>>> +     }
>>> +
>>> +     return false;
>>> +}
>>> +
>>> +static bool supports_overlayfs(void)
>>> +{
>>> +     bool ret = false;
>>
>> No need to set it to "false" (which should be "true" BTW).
>>
>>
>>> +     FILE *inf = fopen(proc_filesystems, "r");
>>
>> s/inf/filename/
>>
>>> +
>>> +     /*
>>> +      * If fopen fails, return supported.
>>> +      * This helps to detect missing file (shall not
>>> +      * happen).
>>
>> "A failed attempt to open /proc/filesystems implies that the file
>> system is supported (default behavior). This can help detect such
>> unattended issue (which should not happen)."
>>
>>
>>> +      */
>>> +     if (!inf)
>>> +             return true;
>>> +
>>> +     ret = fgrep(inf, "nodev\toverlay\n");
>>> +     fclose(inf);
>>> +
>>
>> You can remove this newline.
>>
>>> +     return ret;
>>> +}
>>> +
>>>    static void prepare_layout(struct __test_metadata *const _metadata)
>>>    {
>>>        disable_caps(_metadata);
>>> @@ -3404,6 +3442,8 @@ FIXTURE(layout2_overlay) {};
>>>
>>>    FIXTURE_SETUP(layout2_overlay)
>>>    {
>>> +     int rc;
>>
>> s/rc/ret/
>>
>> int ret, err;
>>
>>> +
>>>        prepare_layout(_metadata);
>>>
>>>        create_directory(_metadata, LOWER_BASE);
>>> @@ -3431,11 +3471,18 @@ FIXTURE_SETUP(layout2_overlay)
>>>        create_directory(_metadata, MERGE_DATA);
>>>        set_cap(_metadata, CAP_SYS_ADMIN);
>>>        set_cap(_metadata, CAP_DAC_OVERRIDE);
>>> -     ASSERT_EQ(0, mount("overlay", MERGE_DATA, "overlay", 0,
>>> -                        "lowerdir=" LOWER_DATA ",upperdir=" UPPER_DATA
>>> -                        ",workdir=" UPPER_WORK));
>>> +
>>> +     rc = mount("overlay", MERGE_DATA, "overlay", 0,
>>> +                "lowerdir=" LOWER_DATA ",upperdir=" UPPER_DATA
>>> +                ",workdir=" UPPER_WORK);
>>
>> err = errno;
>>
>>>        clear_cap(_metadata, CAP_DAC_OVERRIDE);
>>>        clear_cap(_metadata, CAP_SYS_ADMIN);
>>> +
>>> +     if (rc < 0) {
>>
>> if (ret == -1) {
>>
>>> +             ASSERT_EQ(ENODEV, errno);
>>
>> ASSERT_EQ(ENODEV, err);
>>
>>> +             ASSERT_FALSE(supports_overlayfs());
>>> +             SKIP(return, "overlayfs is not supported");
>>> +     }
>>
>> ASSERT_EQ(0, ret);
>>
>>>    }
>>>
>>>    FIXTURE_TEARDOWN(layout2_overlay)
>>>
>>> base-commit: 50cd95ac46548429e5bba7ca75cc97d11a697947
