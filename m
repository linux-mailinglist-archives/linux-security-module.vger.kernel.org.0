Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986606D4FFE
	for <lists+linux-security-module@lfdr.de>; Mon,  3 Apr 2023 20:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjDCSG6 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 3 Apr 2023 14:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjDCSGv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Apr 2023 14:06:51 -0400
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5400540EC;
        Mon,  3 Apr 2023 11:06:48 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PqzP25S2nzMq4dC;
        Mon,  3 Apr 2023 20:06:46 +0200 (CEST)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4PqzP15ZPjzMpqQ9;
        Mon,  3 Apr 2023 20:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1680545206;
        bh=hmdrlLm0XKaDWe4FqgfqILqtbgqtZpel+rg4XPUuC00=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cvlwPFbUIRN3iXcAoZZk/TTiRRlVZlugfGtm9sCghhc/3PI+yO/O85Os2bkww6VwJ
         VQ9QOB/6f+UQ70rBvKL5qW55M/V2SLqNgcUAd7+ehKcr+V6nAsWHUQsNf4UsDtSK3C
         DbHAMkCJYXsPqfMhukjK0/AVaXBDBgJHhQAdDKlc=
Message-ID: <6af85c04-0388-026a-e4ee-08d9aad6b86a@digikod.net>
Date:   Mon, 3 Apr 2023 20:06:45 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v7 07/11] LSM: Helpers for attribute names and filling an
 lsm_ctx
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230315224704.2672-1-casey@schaufler-ca.com>
 <20230315224704.2672-8-casey@schaufler-ca.com>
 <544a4809-1a79-9dd7-61a5-5fce1f4a5f10@digikod.net>
 <bbd6abb7-7443-0f34-788b-0e441dc5afee@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <bbd6abb7-7443-0f34-788b-0e441dc5afee@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 03/04/2023 20:03, Casey Schaufler wrote:
> On 4/3/2023 2:47 AM, Mickaël Salaün wrote:
>>
>> On 15/03/2023 23:47, Casey Schaufler wrote:
>>> Add lsm_name_to_attr(), which translates a text string to a
>>> LSM_ATTR value if one is available.
>>>
>>> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
>>> the trailing attribute value.
>>>
>>> All are used in module specific components of LSM system calls.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>    include/linux/security.h | 13 ++++++++++
>>>    security/lsm_syscalls.c  | 51 ++++++++++++++++++++++++++++++++++++++++
>>>    security/security.c      | 31 ++++++++++++++++++++++++
>>>    3 files changed, 95 insertions(+)
>>
>> [...]
>>
>>> diff --git a/security/security.c b/security/security.c
>>> index 2c57fe28c4f7..f7b814a3940c 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -753,6 +753,37 @@ static int lsm_superblock_alloc(struct
>>> super_block *sb)
>>>        return 0;
>>>    }
>>>    +/**
>>> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
>>> + * @ctx: an LSM context to be filled
>>> + * @context: the new context value
>>> + * @context_size: the size of the new context value
>>> + * @id: LSM id
>>> + * @flags: LSM defined flags
>>> + *
>>> + * Fill all of the fields in a user space lsm_ctx structure.
>>> + * Caller is assumed to have verified that @ctx has enough space
>>> + * for @context.
>>> + * Returns 0 on success, -EFAULT on a copyout error.
>>> + */
>>> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
>>> +              size_t context_size, u64 id, u64 flags)
>>> +{
>>> +    struct lsm_ctx local;
>>> +    void __user *vc = ctx;
>>> +
>>> +    local.id = id;
>>> +    local.flags = flags;
>>> +    local.ctx_len = context_size;
>>> +    local.len = context_size + sizeof(local);
>>> +    vc += sizeof(local);
>>> +    if (copy_to_user(ctx, &local, sizeof(local)))
>>> +        return -EFAULT;
>>> +    if (context_size > 0 && copy_to_user(vc, context, context_size))
>>> +        return -EFAULT;
>>
>> Can we do a single copy_to_user() call?
> 
> It would be possible, but would require allocating memory and copying
> the context. I don't see that as an improvement.
> 
>> That would avoid inconsistent user space data, could speed up a bit
>> the operation, and make the code easier to understand. To use the
>> stack, we need to know the maximum size of context_size for all use
>> cases, which seems reasonable and can be checked at build time (on
>> each LSM side, and potentially with specific context type passed as
>> enum instead of context_size) and run time (for this generic helper).
> 
> Knowning the maximum size of attributes for all LSMs and hard coding
> that here would make maintaining this code really painful.

Hmm, I forgot about variable-length strings, but maybe a reasonable 
common maximum size (that could fit on the stack) could be found?

> 
>>
>>
>>> +    return 0;
>>> +}
>>> +
>>>    /*
>>>     * The default value of the LSM hook is defined in
>>> linux/lsm_hook_defs.h and
>>>     * can be accessed with:
