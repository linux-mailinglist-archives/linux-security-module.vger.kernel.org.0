Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477DF7DF085
	for <lists+linux-security-module@lfdr.de>; Thu,  2 Nov 2023 11:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345944AbjKBKsR (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 2 Nov 2023 06:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345942AbjKBKsQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Nov 2023 06:48:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB8E7
        for <linux-security-module@vger.kernel.org>; Thu,  2 Nov 2023 03:48:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EE6C433C8
        for <linux-security-module@vger.kernel.org>; Thu,  2 Nov 2023 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698922093;
        bh=uVCmri5yX+MDhXil1qI8WZohlpSUqiIyU4eJ6NPgmI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cWZQYbO8OmFGWahMTDABt+z7o7qfeg2DWXg9aAgavwA2rSX3e9gIjmtjrENg6BLxN
         /qwHMyttnsVaz+Cb3xIia/XIV9VWbB8vSk+fggPY5JM/zSKUDzWrCSR84VMdf0k5NP
         ZsVaQOEWkwRC3RstufpniMGUs7ulr5huAtm5Qo7mEMIgyRyAd4xYeWbEWqLNUBOL4a
         ISMB05EmQSq4ehHSwVP/pw+ozpQIWTXGcPlViswzOpazM5FICr59R4m3XrB7RdaI/X
         45OmxpxrOyGRP5H2t25W9fXZXlkrp0dqpYW1/iPuGJSCiA06ZqEw+/ZgPPGUNF+UOm
         uBok82M7k+Gyw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso1611404a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 02 Nov 2023 03:48:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YzW/PTGTBb8lkRsZNlJA5QMqU0HNubGNqOQpbxnoLVsASJXX55R
        58rP4pWkb4FakyeQTRytLzeZwX6fU6bkZZe0ZAukUA==
X-Google-Smtp-Source: AGHT+IGMHTRxE4OeDt/BYnPSn+4jdzO4zzkSmsqJKVR4kUdUDdRmYY0s70ndCiybTReZVPlE7Lt5VVNPPq7uBm3pUfg=
X-Received: by 2002:a50:cc48:0:b0:540:2a8f:806f with SMTP id
 n8-20020a50cc48000000b005402a8f806fmr4456038edi.3.1698922091993; Thu, 02 Nov
 2023 03:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231102005521.346983-1-kpsingh@kernel.org> <b0186178-0338-4db1-9065-b6bbda10d58f@I-love.SAKURA.ne.jp>
 <CACYkzJ48EOFEgeWyX=mTwPhZk2Wb=LzngPGCo8Hn=KoBcgCJHg@mail.gmail.com> <cdd87907-e75a-46fd-884f-29fc07f62c32@I-love.SAKURA.ne.jp>
In-Reply-To: <cdd87907-e75a-46fd-884f-29fc07f62c32@I-love.SAKURA.ne.jp>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 2 Nov 2023 11:48:01 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7ght66802wQFKzokfJKMKDOobYgeaCpu5Gx=iX0EuJVg@mail.gmail.com>
Message-ID: <CACYkzJ7ght66802wQFKzokfJKMKDOobYgeaCpu5Gx=iX0EuJVg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Reduce overhead of LSMs with static calls
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        renauld@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 2, 2023 at 11:30=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/11/02 19:01, KP Singh wrote:
> > On Thu, Nov 2, 2023 at 10:42=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> I didn't get your response on https://lkml.kernel.org/r/c588ca5d-c343-=
4ea2-a1f1-4efe67ebb8e3@I-love.SAKURA.ne.jp .
> >>
> >> Do you agree that we cannot replace LKM-based LSMs with eBPF-based acc=
ess control mechanisms,
> >> and do you admit that this series makes LKM-based LSMs more difficult =
to use?
> >
> > If you want to do a proper in-tree version of dynamic LSMs. There can
> > be an exported symbol that allocates a dynamic slot and registers LSM
> > hooks to it. This is very doable, but it's not my use case so, I am
> > not going to do it.
> >
> > No it does not make LKM based LSMs difficult to use. I am not ready to
> > have that debate again.  I suggested multiple extensions in my replies
> > which you chose to ignore.
>
> You said
>
>   I think this needs to be discussed if and when we allow LKM based LSMs.=
"
>
> as a response to
>
>   It is Casey's commitment that the LSM infrastructure will not forbid LK=
M-based LSMs.
>   We will start allowing LKM-based LSMs. But it is not clear how we can m=
ake it possible to
>   allow LKM-based LSMs.
>
> , and you suggested combination of static calls (for built-in LSMs) and
> linked list (for LKM-based LSMs).

Tetsuo, this is exactly a technical solution and it works, a very easy
API can be made to enable the LKM based use-case (if the maintainers
agree that they want to enable LKM based LSMs)

I think what you can do is send patches for an API for LKM based LSMs
and have it merged before my series, I will work with the code I have
and make LKM based LSMs work. If this work gets merged, and your
use-case is accepted (I think I can speak for at least Kees [if not
others] too here) we will help you if you get stuck with MAX_LSM_COUNT
or a dual static call and linked list based approach.

>
> So, what is your answer to
>
>   Until I hear the real limitations of using BPF, it's a NAK from me.

The burden of proof is on you. All I can say is that if you wanted to
implement the policy logic you want, you could. If you cannot, please
share specifics and the BPF / LSM community will help.

>
> ? Do you agree to allow dynamically appendable LSM modules?

Nice try, I am for dynamically loadable hook logic, that's why I
implemented the BPF LSM. What you want to ask me is am I for LKM LSMs.
Regarding the LKM based LSMs, it's my opinion that it should be done
with BPF LSM because it's actually safer and does not have the
maintenance overhead that a kernel module has.

My 0.02c, please share code, specifics and if you like your use case,
get it merged with a patch series. From here onwards, I won't be
responding to hypotheticals.

>
