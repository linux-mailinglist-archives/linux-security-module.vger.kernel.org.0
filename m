Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78FB591A21
	for <lists+linux-security-module@lfdr.de>; Sat, 13 Aug 2022 14:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiHMMb5 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 13 Aug 2022 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237284AbiHMMb5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 13 Aug 2022 08:31:57 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB8CE02D
        for <linux-security-module@vger.kernel.org>; Sat, 13 Aug 2022 05:31:54 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M4g082g2wzMqF99;
        Sat, 13 Aug 2022 14:31:52 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4M4g072SWpzlqwsR;
        Sat, 13 Aug 2022 14:31:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1660393912;
        bh=HDillD1+rhlKp/3AjyimGk/Si0hVmCa1QRiHvT5iNAU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=zgKxGcqawXTaNr8DsBoAP5aFyZANyTJ0n9DZ9plOnhewHMrP6RFyQeoFV6zVQwOLW
         fQv3796lCSAq1uFcB9cwT/ij9tbay1DWVqUiywCtXleONX70laXFvQJkHbYyZ5taOZ
         1nKtCH1ZdnVy5hgK4TnYicZGBJl8QAg6982I5+yc=
Message-ID: <e4843a98-0bde-829c-f77a-56d45ba324d7@digikod.net>
Date:   Sat, 13 Aug 2022 14:31:50 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Anders Roxell <anders.roxell@linaro.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Guillaume <guillaume.tucker@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
 <CADYN=9JM1nnjC9LypHqrz7JJjbZLpm8rArDUy4zgYYrajErBnA@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH] selftests/landlock: fix broken include of
 linux/landlock.h
In-Reply-To: <CADYN=9JM1nnjC9LypHqrz7JJjbZLpm8rArDUy4zgYYrajErBnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 13/08/2022 12:01, Anders Roxell wrote:
> On Wed, 3 Aug 2022 at 22:14, Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
>>
>> Revert part of the earlier changes to fix the kselftest build when
>> using a sub-directory from the top of the tree as this broke the
>> landlock test build as a side-effect when building with "make -C
>> tools/testing/selftests/landlock".
>>
>> Reported-by: Mickaël Salaün <mic@digikod.net>
>> Fixes: a917dd94b832 ("selftests/landlock: drop deprecated headers dependency")
>> Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> 
> Building with this patch doesn't work, it gives this output:
> make[3]: Entering directory
> '/home/anders/src/kernel/next/tools/testing/selftests/landlock'
> make[3]: Leaving directory
> '/home/anders/src/kernel/next/tools/testing/selftests/landlock'
> make[3]: *** No rule to make target
> '/home/anders/.cache/tuxmake/builds/78/build/kselftest/landlock/base_test',
> needed by 'all'.  Stop.
> 
> I'm building like this:
> tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-12
> --kconfig defconfig kselftest
> 
> which translates into this make command:
> make --silent --keep-going --jobs=32
> O=/home/anders/.cache/tuxmake/builds/78/build
> INSTALL_PATH=/home/anders/.cache/tuxmake/builds/78/build/kselftest_install
> ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- kselftest-install

This works well for me. Which commit is checkout?


> 
> building without this patch works, see below:
> 
> make[3]: Entering directory
> '/home/anders/src/kernel/next/tools/testing/selftests/landlock'
> x86_64-linux-gnu-gcc -Wall -O2 -isystem
> /home/anders/.cache/tuxmake/builds/77/build/usr/include    base_test.c
>   -o /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/base_test
> -lcap
> x86_64-linux-gnu-gcc -Wall -O2 -isystem
> /home/anders/.cache/tuxmake/builds/77/build/usr/include    fs_test.c
> -o /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/fs_test
> -lcap
> x86_64-linux-gnu-gcc -Wall -O2 -isystem
> /home/anders/.cache/tuxmake/builds/77/build/usr/include
> ptrace_test.c  -o
> /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/ptrace_test
> -lcap
> x86_64-linux-gnu-gcc -Wall -O2 -isystem
> /home/anders/.cache/tuxmake/builds/77/build/usr/include    true.c  -o
> /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/true
> -static
> make[3]: Leaving directory
> '/home/anders/src/kernel/next/tools/testing/selftests/landlock'
Does this work if you revert this patch, commit a917dd94b832 
("selftests/landlock: drop deprecated headers dependency") and commit 
f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")?

This patch mainly revert commit a917dd94b832, so I don't see the issue.


> 
> Cheers,
> Anders
> 
>> ---
>>   tools/testing/selftests/landlock/Makefile | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
>> index a6959df28eb0..02868ac3bc71 100644
>> --- a/tools/testing/selftests/landlock/Makefile
>> +++ b/tools/testing/selftests/landlock/Makefile
>> @@ -9,10 +9,13 @@ TEST_GEN_PROGS := $(src_test:.c=)
>>   TEST_GEN_PROGS_EXTENDED := true
>>
>>   OVERRIDE_TARGETS := 1
>> +top_srcdir := ../../../..
>>   include ../lib.mk
>>
>> +khdr_dir = $(top_srcdir)/usr/include
>> +
>>   $(OUTPUT)/true: true.c
>>          $(LINK.c) $< $(LDLIBS) -o $@ -static
>>
>> -$(OUTPUT)/%_test: %_test.c ../kselftest_harness.h common.h
>> -       $(LINK.c) $< $(LDLIBS) -o $@ -lcap
>> +$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
>> +       $(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)
>> --
>> 2.30.2
>>
