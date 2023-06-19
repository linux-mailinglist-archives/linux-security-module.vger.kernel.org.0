Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB0C735D72
	for <lists+linux-security-module@lfdr.de>; Mon, 19 Jun 2023 20:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjFSSX3 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 19 Jun 2023 14:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjFSSX2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Jun 2023 14:23:28 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEBC119
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 11:23:26 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QlJ6j2pGHzMq40r;
        Mon, 19 Jun 2023 18:23:25 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QlJ6h3dZLzMqD0G;
        Mon, 19 Jun 2023 20:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1687199005;
        bh=Qr8PhNeLD6qr1V7vT5Z8S3Ee6R5YJna11xamraRUXKc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=scvwM9ClHOVog9yZpkpmYj5PIxVH4ic2sAxGP12t61wnXeqRpPqKLubqZoc6g9Dgw
         y7OinZtDzZtS4KsCs9EEukis91TtuusCArBOoiHmO1znbFyshkbdGEQU0DxhwEhGns
         YyyLZx/NLMlOB8AVAJ501KuajYapC+KhMimG/pXQ=
Message-ID: <de9fd04b-8da9-b03b-b278-5437c67b15eb@digikod.net>
Date:   Mon, 19 Jun 2023 20:23:23 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v11 00/12] Network support for Landlock
Content-Language: en-US
To:     "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
Cc:     willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yusongping@huawei.com,
        artem.kuzin@huawei.com
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <8f3d242a-c0ee-217e-8094-84093ce4e134@digikod.net>
 <ea810d57-93fe-1724-4aab-5cbc1a35062f@huawei.com>
 <96c88b9f-7625-7aae-83a5-a91586a9bc15@digikod.net>
 <a1995119-48d1-6e5b-c6c7-d5f7a973ca1f@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <a1995119-48d1-6e5b-c6c7-d5f7a973ca1f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 19/06/2023 16:28, Konstantin Meskhidze (A) wrote:
> 
> 
> 6/6/2023 12:40 PM, Mickaël Salaün пишет:
>>
>> On 06/06/2023 11:10, Konstantin Meskhidze (A) wrote:
>>>
>>>
>>> 6/5/2023 6:02 PM, Mickaël Salaün пишет:
>>>> Hi Konstantin,
>>>>
>>>> The kernel code looks good. I found some issues in tests and
>>>> documentation, and I'm still reviewing the whole patches. In the
>>>> meantime, I've pushed it in -next, we'll see how it goes.
>>>>
>>>> We need to have this new code covered by syzkaller. I'll work on that
>>>> unless you want to.
>>>>
>>>> Regards,
>>>>      Mickaël
>>>>
>>>      Hi, Mickaël!
>>>      I have never set up syzkaller. Do you have a syzkaller scenario for
>>> Landlock code? I need some hints. I will give it a shot.
>>
>> You can get a look at https://github.com/google/syzkaller/pull/3423 or
>> other Landlock-related PR.
>>
>> The setup might be a bit challenging though, but it will be a good
>> investment for future kernel changes.
> 
>     Thanks. I will handle it. Can you give me a hand with some tips if I
> have issues with syzkaller setup?

Yes, you can Cc me and send emails to syzkaller@googlegroups.com: 
https://groups.google.com/g/syzkaller




>>
>>
>>>
>>>     Regards,
>>>        Konstantin.
>>>>
>>>> On 15/05/2023 18:13, Konstantin Meskhidze wrote:
>>>>> Hi,
>>>>> This is a new V11 patch related to Landlock LSM network confinement.
>>>>> It is based on the landlock's -next branch on top of v6.2-rc3+ kernel version:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
>>>>>
>>>>> It brings refactoring of previous patch version V10.
>>>>> Mostly there are fixes of logic and typos, refactoring some selftests.
>>>>>
>>>>> All test were run in QEMU evironment and compiled with
>>>>>     -static flag.
>>>>>     1. network_test: 36/36 tests passed.
>>>>>     2. base_test: 7/7 tests passed.
>>>>>     3. fs_test: 78/78 tests passed.
>>>>>     4. ptrace_test: 8/8 tests passed.
>>>>>
>>>>> Previous versions:
>>>>> v10: https://lore.kernel.org/linux-security-module/20230323085226.1432550-1-konstantin.meskhidze@huawei.com/
>>>>> v9: https://lore.kernel.org/linux-security-module/20230116085818.165539-1-konstantin.meskhidze@huawei.com/
>>>>> v8: https://lore.kernel.org/linux-security-module/20221021152644.155136-1-konstantin.meskhidze@huawei.com/
>>>>> v7: https://lore.kernel.org/linux-security-module/20220829170401.834298-1-konstantin.meskhidze@huawei.com/
>>>>> v6: https://lore.kernel.org/linux-security-module/20220621082313.3330667-1-konstantin.meskhidze@huawei.com/
>>>>> v5: https://lore.kernel.org/linux-security-module/20220516152038.39594-1-konstantin.meskhidze@huawei.com
>>>>> v4: https://lore.kernel.org/linux-security-module/20220309134459.6448-1-konstantin.meskhidze@huawei.com/
>>>>> v3: https://lore.kernel.org/linux-security-module/20220124080215.265538-1-konstantin.meskhidze@huawei.com/
>>>>> v2: https://lore.kernel.org/linux-security-module/20211228115212.703084-1-konstantin.meskhidze@huawei.com/
>>>>> v1: https://lore.kernel.org/linux-security-module/20211210072123.386713-1-konstantin.meskhidze@huawei.com/
>>>>>
>>>>> Konstantin Meskhidze (11):
>>>>>      landlock: Make ruleset's access masks more generic
>>>>>      landlock: Refactor landlock_find_rule/insert_rule
>>>>>      landlock: Refactor merge/inherit_ruleset functions
>>>>>      landlock: Move and rename layer helpers
>>>>>      landlock: Refactor layer helpers
>>>>>      landlock: Refactor landlock_add_rule() syscall
>>>>>      landlock: Add network rules and TCP hooks support
>>>>>      selftests/landlock: Share enforce_ruleset()
>>>>>      selftests/landlock: Add 11 new test suites dedicated to network
>>>>>      samples/landlock: Add network demo
>>>>>      landlock: Document Landlock's network support
>>>>>
>>>>> Mickaël Salaün (1):
>>>>>      landlock: Allow filesystem layout changes for domains without such
>>>>>        rule type
>>>>>
>>>>>     Documentation/userspace-api/landlock.rst     |   89 +-
>>>>>     include/uapi/linux/landlock.h                |   48 +
>>>>>     samples/landlock/sandboxer.c                 |  128 +-
>>>>>     security/landlock/Kconfig                    |    1 +
>>>>>     security/landlock/Makefile                   |    2 +
>>>>>     security/landlock/fs.c                       |  232 +--
>>>>>     security/landlock/limits.h                   |    7 +-
>>>>>     security/landlock/net.c                      |  174 +++
>>>>>     security/landlock/net.h                      |   26 +
>>>>>     security/landlock/ruleset.c                  |  405 +++++-
>>>>>     security/landlock/ruleset.h                  |  185 ++-
>>>>>     security/landlock/setup.c                    |    2 +
>>>>>     security/landlock/syscalls.c                 |  163 ++-
>>>>>     tools/testing/selftests/landlock/base_test.c |    2 +-
>>>>>     tools/testing/selftests/landlock/common.h    |   10 +
>>>>>     tools/testing/selftests/landlock/config      |    4 +
>>>>>     tools/testing/selftests/landlock/fs_test.c   |   74 +-
>>>>>     tools/testing/selftests/landlock/net_test.c  | 1317 ++++++++++++++++++
>>>>>     18 files changed, 2520 insertions(+), 349 deletions(-)
>>>>>     create mode 100644 security/landlock/net.c
>>>>>     create mode 100644 security/landlock/net.h
>>>>>     create mode 100644 tools/testing/selftests/landlock/net_test.c
>>>>>
>>>>> --
>>>>> 2.25.1
>>>>>
>>>> .
>> .
