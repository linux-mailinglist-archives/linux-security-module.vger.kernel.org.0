Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826B854A103
	for <lists+linux-security-module@lfdr.de>; Mon, 13 Jun 2022 23:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352978AbiFMVOP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 13 Jun 2022 17:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351743AbiFMVNI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Jun 2022 17:13:08 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72CB393D9
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jun 2022 13:52:41 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s124so9250578oia.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jun 2022 13:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ie2xrfdugqSnUY/lUmZJBYqEw/Jj5HQgDROYZDI7Ljg=;
        b=q8Sos2zHH2cqeJpqAWGopwq4BFpy5d162ZHvWsGBGzD8dXmnX4TsH4oGd9xtjxFj3k
         kkiT7ORHTaWO7TVdzrFrUtvSJwyodFHKf3kDLk5zfyB6+Q4t7bACoSZoThK4QulFXt66
         4eu47sTHknmVkiiSbjTEY+HxauLbTxzPeZ3t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ie2xrfdugqSnUY/lUmZJBYqEw/Jj5HQgDROYZDI7Ljg=;
        b=L+ONNAMbhXgbbz0dB2k5sgqNf/Xb+bXbx9PMOUQPaTPGM2wy6RLkAoKJLSctxjFOvC
         ptH64hCZeRZcGcIGOL6p0tyzPtL1DinEQh89HoHynhfafQHhw2CuknFMKYsEnqXZAb/J
         XcDleG6RxNxy564tN24gBqOzOnn3gIg1sVRtSwxS5DXpyYcstZ+vbejAlvOA62Hc0PEZ
         mE1AiEGwU0XQvc1I3BqCvHaQvntHV07SJyMLIDdiBMoHK0r+1pHjE/BdeMoVsLHzaqw/
         ufTG399J9fZXw8fB77PYGYZVXWurxJWTos7sWoyPhu/JRSRIpKrYjdiQZOMkskkqmbkS
         WPMQ==
X-Gm-Message-State: AOAM5306wYdvBOzqUKRDAq9NOzMNO0f/NxfvnQWa49qKMyRZ876TePUE
        zBa6rLX2V5ePn6j2C0CLH/z8DQ==
X-Google-Smtp-Source: ABdhPJxwqO943xteTGAgFieA/vZp5/Zn/6Qxyj5rF6Le0Sf8rKMQHGa/+OpWxWOapQGjDXa0MQVMLw==
X-Received: by 2002:a05:6808:2394:b0:326:d5d6:a4ba with SMTP id bp20-20020a056808239400b00326d5d6a4bamr321996oib.67.1655153561069;
        Mon, 13 Jun 2022 13:52:41 -0700 (PDT)
Received: from [192.168.0.41] ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id dv8-20020a056870d88800b000f5eb6b409bsm4444747oab.45.2022.06.13.13.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 13:52:40 -0700 (PDT)
Message-ID: <e1b62234-9b8a-e7c2-2946-5ef9f6f23a08@cloudflare.com>
Date:   Mon, 13 Jun 2022 15:52:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] cred: Propagate security_prepare_creds() error code
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        keyrings@vger.kernel.org, selinux@vger.kernel.org,
        serge@hallyn.com, amir73il@gmail.com, kernel-team@cloudflare.com,
        Jeff Moyer <jmoyer@redhat.com>,
        Paul Moore <paul@paul-moore.com>
References: <20220608150942.776446-1-fred@cloudflare.com>
 <87tu8oze94.fsf@email.froward.int.ebiederm.org>
From:   Frederick Lawler <fred@cloudflare.com>
In-Reply-To: <87tu8oze94.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Eric,

On 6/13/22 12:04 PM, Eric W. Biederman wrote:
> Frederick Lawler <fred@cloudflare.com> writes:
> 
>> While experimenting with the security_prepare_creds() LSM hook, we
>> noticed that our EPERM error code was not propagated up the callstack.
>> Instead ENOMEM is always returned.  As a result, some tools may send a
>> confusing error message to the user:
>>
>> $ unshare -rU
>> unshare: unshare failed: Cannot allocate memory
>>
>> A user would think that the system didn't have enough memory, when
>> instead the action was denied.
>>
>> This problem occurs because prepare_creds() and prepare_kernel_cred()
>> return NULL when security_prepare_creds() returns an error code. Later,
>> functions calling prepare_creds() and prepare_kernel_cred() return
>> ENOMEM because they assume that a NULL meant there was no memory
>> allocated.
>>
>> Fix this by propagating an error code from security_prepare_creds() up
>> the callstack.
> 
> Why would it make sense for security_prepare_creds to return an error
> code other than ENOMEM?
>  > That seems a bit of a violation of what that function is supposed to do
>

The API allows LSM authors to decide what error code is returned from 
the cred_prepare hook. security_task_alloc() is a similar hook, and has 
its return code propagated.

I'm proposing we follow security_task_allocs() pattern, and add 
visibility for failure cases in prepare_creds().

> I have probably missed a very interesting discussion where that was
> mentioned but I don't see link to the discussion or anything explaining
> why we want to do that in this change.
> 

AFAIK, this is the start of the discussion.

> Eric
> 


