Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ECD63A8B7
	for <lists+linux-security-module@lfdr.de>; Mon, 28 Nov 2022 13:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiK1MtS (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 28 Nov 2022 07:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiK1MtQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 Nov 2022 07:49:16 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBCAE41
        for <linux-security-module@vger.kernel.org>; Mon, 28 Nov 2022 04:49:12 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id c2so7066944qko.1
        for <linux-security-module@vger.kernel.org>; Mon, 28 Nov 2022 04:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGVmMJIaDzF+HZ9gyq+88LkwK1s7TvZ3LoSpvYVKuJs=;
        b=Yc4mY6AvvR8J0FvilEHOp4YJztk5dej6+6PHrqtJwOKPe36IVOw6KUbOFPvxqaIUVL
         EKFpogzvGm5EXh9TW/siBoniymJvMkxoq2s2dEzDKzySHox0B0xSAyWktDHmUzO51+5r
         xBS2R51caFTcaZHv7tE2Is3GOhS4XFGMGdcni1OmAj9u7AIsdo2OBC6Zs3HQUO6jBJLv
         WeR77C4rP7xgp7c/aFdK2MLoUKskkP98Mt6qMdHjTw7hhwDdYJ7y6jlJ5bHRt/CQ7ysK
         65OhWflnpl2owcwtMU/s6jA0FNYtvL78Qc9INGOyriQqV3yzcPyXQWZS92FrOCZ0e3aP
         rMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGVmMJIaDzF+HZ9gyq+88LkwK1s7TvZ3LoSpvYVKuJs=;
        b=FCgWqbauo3m3KlhuF09pbl1sSqOLHvZKjXvlBk1XuqvDnTA8cfUELnr9MDh0JJRz8X
         cXqU98IBhn8E6mxk5plvvzfFnnC/j8RLcUekx19D05KEC9pjx/sX0gW8P5pLGiapW5oN
         f9/S/GFVNHtbW8XnITE1EU6wbecIIyDBrPXO4Gu/OePv8iRY6MHv0OCdHwIXbd3M1Y9g
         rENazqxd09evtL/5UuWoJ/0N5pV3xVxc3vaEBdTHkhB8das8Cfv6IzYB2v5iKx9f9SST
         YAVN9EPsRwId6jUlkKbwj7D3ZxZ19mqvQ1WEFWp0q70S3ijhVRHlwCHtRbel6H6KUEXk
         rppA==
X-Gm-Message-State: ANoB5pkRs2I95G6C/GyXE3zddx6jwsZ00NsdWNQz5xb1+V/8sGOgCsln
        0Lt/MIay3NyIdR5mzzzBEgBh
X-Google-Smtp-Source: AA0mqf4Ds2RG2gMvCRQqsJgfksVgiZ7yR5a4UThP2iPQ0CQqTIvFBEEQxZnN45hFk2rmk57REIkPQg==
X-Received: by 2002:a37:9ad2:0:b0:6fc:3ccb:f0ea with SMTP id c201-20020a379ad2000000b006fc3ccbf0eamr19410302qke.669.1669639751623;
        Mon, 28 Nov 2022 04:49:11 -0800 (PST)
Received: from [192.168.68.74] (096-033-065-247.res.spectrum.com. [96.33.65.247])
        by smtp.gmail.com with ESMTPSA id v2-20020ac873c2000000b003a57f822157sm6805786qtp.90.2022.11.28.04.49.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Nov 2022 04:49:10 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        <casey.schaufler@intel.com>,
        <linux-security-module@vger.kernel.org>, <jmorris@namei.org>,
        <keescook@chromium.org>, <john.johansen@canonical.com>,
        <penguin-kernel@i-love.sakura.ne.jp>,
        <stephen.smalley.work@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>
Date:   Mon, 28 Nov 2022 07:49:11 -0500
Message-ID: <184be48c558.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <Y4Rok2iAOekw/tSJ@kroah.com>
References: <20221123201552.7865-1-casey@schaufler-ca.com>
 <20221123201552.7865-2-casey@schaufler-ca.com>
 <Y38D1s3uQ6zNORei@kroah.com>
 <463cb747-5bac-9e8e-b78e-1ff6a1b29142@digikod.net>
 <CAHC9VhR9h1GF6VGovp1+UB-vt+QNofjmecPwLqE3OviKQHRMcg@mail.gmail.com>
 <Y4Rok2iAOekw/tSJ@kroah.com>
User-Agent: AquaMail/1.40.1 (build: 104001224)
Subject: Re: [PATCH v3 1/9] LSM: Identify modules by more than name
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On November 28, 2022 2:51:55 AM Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Nov 27, 2022 at 10:48:53PM -0500, Paul Moore wrote:
>> On Fri, Nov 25, 2022 at 11:19 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
>>> On 24/11/2022 06:40, Greg KH wrote:
>>>> On Wed, Nov 23, 2022 at 12:15:44PM -0800, Casey Schaufler wrote:
>>>>> Create a struct lsm_id to contain identifying information
>>>>> about Linux Security Modules (LSMs). At inception this contains
>>>>> the name of the module and an identifier associated with the
>>>>> security module. Change the security_add_hooks() interface to
>>>>> use this structure. Change the individual modules to maintain
>>>>> their own struct lsm_id and pass it to security_add_hooks().
>>>>>
>>>>> The values are for LSM identifiers are defined in a new UAPI
>>>>> header file linux/lsm.h. Each existing LSM has been updated to
>>>>> include it's LSMID in the lsm_id.
>>>>>
>>>>> The LSM ID values are sequential, with the oldest module
>>>>> LSM_ID_CAPABILITY being the lowest value and the existing modules
>>>>> numbered in the order they were included in the main line kernel.
>>>>> This is an arbitrary convention for assigning the values, but
>>>>> none better presents itself. The value 0 is defined as being invalid.
>>>>> The values 1-99 are reserved for any special case uses which may
>>>>> arise in the future.
>>>>
>>>> What would be a "special case" that deserves a lower number?
>>>
>>> I don't see any meaningful use case for these reserved numbers either.
>>> If there are some, let's put them now, otherwise we should start with 1=
.
>>> Is it inspired by an existing UAPI?
>>> Reserving 0 as invalid is good though.
>>
>> I haven't finished reviewing this latest patchset, but I wanted to
>> comment on this quickly while I had a moment in front of a keyboard
>> ... I did explain my desire and reasoning for this in a previous
>> revision of this patchset and I still believe the
>> reserved-for-potential-future-use to be a valid reason so I'm going to
>> ask for this to remain.
>
> Then that reasoning and explaination needs to be here in the changelog
> so that we understand and have a chance to agree/disagree with that.
> Otherwise we, and everyone else, are left to just be confused.
>
> thanks,
>
> greg k-h

The patch author should have done that considering I made my comments on th=
e last revision.

--
paul-moore.com


