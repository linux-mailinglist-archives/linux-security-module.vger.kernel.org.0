Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533185833D6
	for <lists+linux-security-module@lfdr.de>; Wed, 27 Jul 2022 21:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiG0TzA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 27 Jul 2022 15:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiG0Ty7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Jul 2022 15:54:59 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CB356BBF
        for <linux-security-module@vger.kernel.org>; Wed, 27 Jul 2022 12:54:57 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LtPdB18x9zMqMfb;
        Wed, 27 Jul 2022 21:54:54 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4LtPd94vGmzln8VM;
        Wed, 27 Jul 2022 21:54:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1658951694;
        bh=4vCIXI/5V3E0JoYph3HCIwV+ywjIiRGEiTJoYTbvjqU=;
        h=Date:From:To:Cc:References:Subject:In-Reply-To:From;
        b=JLd6rI6QFfGKUYvO4L//xHwQ8B+HcmzFAMiLSZeXtx8kqBbP4EIV8HqrjIe4IDYRH
         q8hUmmzO2vfdwXSJBaky84TvrgNPe8ppj0BrilJuQ6quZNrKV/j9n1EoBuVH8H1wxE
         MEFHY+JouSLlPOBQAEJVRxpI3DV3HDTKnubrcZRo=
Message-ID: <6691d91f-c03b-30fa-2fa0-d062b3b234b9@digikod.net>
Date:   Wed, 27 Jul 2022 21:54:52 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     willemdebruijn.kernel@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yusongping@huawei.com,
        anton.sirazetdinov@huawei.com
References: <20220621082313.3330667-1-konstantin.meskhidze@huawei.com>
 <4c57a0c2-e207-10d6-c73d-bcda66bf3963@digikod.net>
Subject: Re: [PATCH v6 00/17] Network support for Landlock
In-Reply-To: <4c57a0c2-e207-10d6-c73d-bcda66bf3963@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 26/07/2022 19:43, Mickaël Salaün wrote:
> 
> On 21/06/2022 10:22, Konstantin Meskhidze wrote:
>> Hi,
>> This is a new V6 patch related to Landlock LSM network confinement.
>> It is based on the latest landlock-wip branch on top of v5.19-rc2:
>> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=landlock-wip
>>
>> It brings refactoring of previous patch version V5:
>>      - Fixes some logic errors and typos.
>>      - Adds additional FIXTURE_VARIANT and FIXTURE_VARIANT_ADD helpers
>>      to support both ip4 and ip6 families and shorten seltests' code.
>>      - Makes TCP sockets confinement support optional in sandboxer demo.
>>      - Formats the code with clang-format-14
>>
>> All test were run in QEMU evironment and compiled with
>>   -static flag.
>>   1. network_test: 18/18 tests passed.
>>   2. base_test: 7/7 tests passed.
>>   3. fs_test: 59/59 tests passed.
>>   4. ptrace_test: 8/8 tests passed.
>>
>> Still have issue with base_test were compiled without -static flag
>> (landlock-wip branch without network support)
>> 1. base_test: 6/7 tests passed.
>>   Error:
>>   #  RUN           global.inconsistent_attr ...
>>   # base_test.c:54:inconsistent_attr:Expected ENOMSG (42) == errno (22)
>>   # inconsistent_attr: Test terminated by assertion
>>   #          FAIL  global.inconsistent_attr
>> not ok 1 global.inconsistent_attr
>>
>> LCOV - code coverage report:
>>              Hit  Total  Coverage
>> Lines:      952  1010    94.3 %
>> Functions:  79   82      96.3 %
>>
>> Previous versions:
>> v5: 
>> https://lore.kernel.org/linux-security-module/20220516152038.39594-1-konstantin.meskhidze@huawei.com
>> v4: 
>> https://lore.kernel.org/linux-security-module/20220309134459.6448-1-konstantin.meskhidze@huawei.com/
>> v3: 
>> https://lore.kernel.org/linux-security-module/20220124080215.265538-1-konstantin.meskhidze@huawei.com/
>> v2: 
>> https://lore.kernel.org/linux-security-module/20211228115212.703084-1-konstantin.meskhidze@huawei.com/
>> v1: 
>> https://lore.kernel.org/linux-security-module/20211210072123.386713-1-konstantin.meskhidze@huawei.com/
>>
>> Konstantin Meskhidze (17):
>>    landlock: renames access mask
>>    landlock: refactors landlock_find/insert_rule
>>    landlock: refactors merge and inherit functions
>>    landlock: moves helper functions
>>    landlock: refactors helper functions
>>    landlock: refactors landlock_add_rule syscall
>>    landlock: user space API network support
>>    landlock: adds support network rules
>>    landlock: implements TCP network hooks
>>    seltests/landlock: moves helper function
>>    seltests/landlock: adds tests for bind() hooks
>>    seltests/landlock: adds tests for connect() hooks
>>    seltests/landlock: adds AF_UNSPEC family test
>>    seltests/landlock: adds rules overlapping test
>>    seltests/landlock: adds ruleset expanding test
>>    seltests/landlock: adds invalid input data test
>>    samples/landlock: adds network demo
>>
>>   include/uapi/linux/landlock.h               |  49 ++
>>   samples/landlock/sandboxer.c                | 118 ++-
>>   security/landlock/Kconfig                   |   1 +
>>   security/landlock/Makefile                  |   2 +
>>   security/landlock/fs.c                      | 162 +---
>>   security/landlock/limits.h                  |   8 +-
>>   security/landlock/net.c                     | 155 ++++
>>   security/landlock/net.h                     |  26 +
>>   security/landlock/ruleset.c                 | 448 +++++++++--
>>   security/landlock/ruleset.h                 |  91 ++-
>>   security/landlock/setup.c                   |   2 +
>>   security/landlock/syscalls.c                | 168 +++--
>>   tools/testing/selftests/landlock/common.h   |  10 +
>>   tools/testing/selftests/landlock/config     |   4 +
>>   tools/testing/selftests/landlock/fs_test.c  |  10 -
>>   tools/testing/selftests/landlock/net_test.c | 774 ++++++++++++++++++++
>>   16 files changed, 1737 insertions(+), 291 deletions(-)
>>   create mode 100644 security/landlock/net.c
>>   create mode 100644 security/landlock/net.h
>>   create mode 100644 tools/testing/selftests/landlock/net_test.c
>>
>> -- 
>> 2.25.1
>>
> 
> I did a thorough review of all the code. I found that the main issue 
> with this version is that we stick to the layers limit whereas it is 
> only relevant for filesystem hierarchies. You'll find in the following 
> patch miscellaneous fixes and improvement, with some TODOs to get rid of 
> this layer limit. We'll need a test to check that too. You'll need to 
> integrate this diff into your patches though.

You can find the related patch here: 
https://git.kernel.org/mic/c/8f4104b3dc59e7f110c9b83cdf034d010a2d006f
