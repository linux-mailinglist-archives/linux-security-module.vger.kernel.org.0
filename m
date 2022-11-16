Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBB362C8F1
	for <lists+linux-security-module@lfdr.de>; Wed, 16 Nov 2022 20:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiKPT2H (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 16 Nov 2022 14:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiKPT2A (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Nov 2022 14:28:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC560E8B
        for <linux-security-module@vger.kernel.org>; Wed, 16 Nov 2022 11:27:59 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so3397348pjk.1
        for <linux-security-module@vger.kernel.org>; Wed, 16 Nov 2022 11:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kB+EGp4efz1Gli9X+UrH3zS99DGscETUAzFGWwtq1Xg=;
        b=fbEd/BFryc3b2Z/VNsNlHKcMsDEwZ6c+zGxvCyRUnkUoKHAzbvY4rTAYx/LVUwvG4F
         x3DLpWz6iSvj5BIm1MWHR6xxsZ0aAo0TEVyC4+vuoEB4/d/fra6qLpkilcMZapx3bVk1
         +RDI4nBFjdgRJIZih4d8WK9S3UaiIsyw6YSMkLpFnwupxg1juYksMhTSwHp0nQo8QHrt
         v7G7ynPW7WVSXQPwfm0N+09KVY4ROsRn5xioCl+k4m9eYbR+utWhQG6TKSDqvlcMTtC8
         Vbt7zLlb16dwS70elh1cJBvfsPSHaGtzNR49ajGyNG6zOzEhsTEtwra+tL7a842Grh15
         nw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kB+EGp4efz1Gli9X+UrH3zS99DGscETUAzFGWwtq1Xg=;
        b=DHyABed3NYkjnueylTG7fdg0ld6tZfCkLzar61sqLZiYI+YS5m8rjqX2fXc/Y8wDdR
         +Osr6dPKBIH9zQfZuUXuNijjXpkFrQ7PLW5z4MDyd6IGldUj8RggqCFA9OYrvkI6ajfS
         ZT8ZosLeBaxLlXgZD/uhzpoZHp4b59vpUF6kKLHoWvxXvDDpUWM6P5bdztQjw5Lni1bG
         wAzXWp3bo0zFvvjFFPFqWZWg4h6/4em3w5qqON+naEKGhCBMdmTSflz86FdPCPe+ViAq
         q/Z87ZNyqWKxam3ObCV1dFim6e4ZHPUEPc+b1b8gUoNdncW2ZrrQD055Eu8AbP2rw8di
         b38g==
X-Gm-Message-State: ANoB5pmXZeVLdGEUqicmpKR8Zdd5K1+f4FN4KcVDe4FNx7BfwMUTz2mz
        PRix0JddnKElRye9LQiUb5U/FqSx7av2634XcVAS
X-Google-Smtp-Source: AA0mqf55uKXEYyGizECPsOHdKj5/mM+Y8oxUfBS+vv/OItr8pFepf98/PVEBpbdjowSWOBiVXMwE30uUHBlf2wvsqnE=
X-Received: by 2002:a17:90a:4596:b0:1fd:5b5d:f09d with SMTP id
 v22-20020a17090a459600b001fd5b5df09dmr5302996pjg.69.1668626879321; Wed, 16
 Nov 2022 11:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
 <20221115175652.3836811-2-roberto.sassu@huaweicloud.com> <CAHC9VhQjnwbFgAoFgTaLQP7YnNDNyP1i0i8H++HZWj930pW=-A@mail.gmail.com>
 <18e375adfe53f8ce5fb38a6a146ad06eaec71a5e.camel@huaweicloud.com> <CACYkzJ43UZARCkWp6wOQuuEDpOnf33JwAJ=CeZVuW0hffQrmeQ@mail.gmail.com>
In-Reply-To: <CACYkzJ43UZARCkWp6wOQuuEDpOnf33JwAJ=CeZVuW0hffQrmeQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Nov 2022 14:27:47 -0500
Message-ID: <CAHC9VhTR1_Yr=jsCVMAMG3qcOP_GT0KbyzHVKD+Ok0NJQmBkdg@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/4] lsm: Clarify documentation of vm_enough_memory hook
To:     KP Singh <kpsingh@kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, jmorris@namei.org,
        serge@hallyn.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 16, 2022 at 2:18 PM KP Singh <kpsingh@kernel.org> wrote:
> On Wed, Nov 16, 2022 at 9:06 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >
> > On Tue, 2022-11-15 at 21:11 -0500, Paul Moore wrote:
> > > On Tue, Nov 15, 2022 at 12:57 PM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >
> > > > include/linux/lsm_hooks.h reports the result of the LSM infrastructure to
> > > > the callers, not what LSMs should return to the LSM infrastructure.
> > > >
> > > > Clarify that and add that returning 1 from the LSMs means calling
> > > > __vm_enough_memory() with cap_sys_admin set, 0 without.
> > > >
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > > > ---
> > > >  include/linux/lsm_hooks.h | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > > index 4ec80b96c22e..f40b82ca91e7 100644
> > > > --- a/include/linux/lsm_hooks.h
> > > > +++ b/include/linux/lsm_hooks.h
> > > > @@ -1411,7 +1411,9 @@
> > > >   *     Check permissions for allocating a new virtual mapping.
> > > >   *     @mm contains the mm struct it is being added to.
> > > >   *     @pages contains the number of pages.
> > > > - *     Return 0 if permission is granted.
> > > > + *     Return 0 if permission is granted by LSMs to the caller. LSMs should
> > > > + *     return 1 if __vm_enough_memory() should be called with
> > > > + *     cap_sys_admin set, 0 if not.
> > >
> > > I think this is a nice addition, but according to the code, any value
> > > greater than zero will trigger the caller-should-have-CAP_SYS_ADMIN
> > > behavior, not just 1.  I suggest updating the comment.
> >
> > Ok, yes. Thanks.
>
> Also, this is an unrelated patch and you can probably send it
> independently, especially
> since the other changes will now land mostly via BPF.

Yes, the doc/comment changes really have nothing to do with the other
stuff we are discussing in this patchset.

-- 
paul-moore.com
