Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FCE7AC377
	for <lists+linux-security-module@lfdr.de>; Sat, 23 Sep 2023 18:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjIWQIZ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 23 Sep 2023 12:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjIWQIY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 23 Sep 2023 12:08:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2878192
        for <linux-security-module@vger.kernel.org>; Sat, 23 Sep 2023 09:08:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6ABBC433CB
        for <linux-security-module@vger.kernel.org>; Sat, 23 Sep 2023 16:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695485297;
        bh=dOu4Kext4m/bcqGy1+iexYAC2GYJBXd/qBE3H2AITZc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LmqQSwc7WVCYAlbiKKnE9DKi1HRQVkRdaQV/mMD6tbWijTlP6sOTU8OrYPcWUswkJ
         jluHJoaceDZWgBAROTiOy+64g9kjm8qR+JHOXhnG17AfwH6Bv9scbKEy+futq7uRWk
         ooD/Xao+/XfyFGDLQveGfjTyUAhdRNV632HOYgFvFCulcYvJodx0dm563SmQqT/4dP
         7CJ2mFSJr1GfZeHw3lxtnswpd1Fru7i4Xcnphtb+t0Xc8gDkHiEzxzLxq6fXd02KxX
         wkLqK49QvFhlU9CW+IzqDvvX1sQBmWEp4/sMd6F3klnBcqqbZgVHMn6hLzQ45v59fg
         g2bS7cs/bNYMA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso4551016a12.1
        for <linux-security-module@vger.kernel.org>; Sat, 23 Sep 2023 09:08:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy2/bODYtXzhqtreP6LFbVBU9yzEgRGLpBCBv/PmHcdn7lPiumP
        z2KCEvlec6BvmqS6f8+YP6eiJGTvrSU4T2FOHkMcjQ==
X-Google-Smtp-Source: AGHT+IEvzihRDJwnbYMH4zfrUDYdHyUuTfiu0p5tQ7cNX768Dv2TUtsCc1HwjuWG14mGLJ6tGeOgoWWc9V7FXGOrkR4=
X-Received: by 2002:a50:ec89:0:b0:532:e1a2:b0b8 with SMTP id
 e9-20020a50ec89000000b00532e1a2b0b8mr2394260edr.8.1695485296089; Sat, 23 Sep
 2023 09:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
 <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
 <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp> <CAHC9VhTv3f3+ZOviV7YcjbA=cdKOmSC0hj80y2sJgACo+nyK9Q@mail.gmail.com>
In-Reply-To: <CAHC9VhTv3f3+ZOviV7YcjbA=cdKOmSC0hj80y2sJgACo+nyK9Q@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sat, 23 Sep 2023 18:08:05 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5=-4aNnh_PkW3-Haz3Q65TyVSW=Zf9x818ToQX4yC8WQ@mail.gmail.com>
Message-ID: <CACYkzJ5=-4aNnh_PkW3-Haz3Q65TyVSW=Zf9x818ToQX4yC8WQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 22, 2023 at 4:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Sep 22, 2023 at 7:25=E2=80=AFAM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > On 2023/09/21 22:58, KP Singh wrote:
> > > Yeah, LSMs are not meant to be used from a kernel module. The data
> > > structure is actually __ro_after_init. So, I am not even sure how you
> > > are using it in kernel modules (unless you are patching this out).
> > > And, if you are really patching stuff to get your out of tree LSMs to
> > > work, then you might as well add your "custom" LSM config here or jus=
t
> > > override this count.
> >
> > I'm using LKM-based LSM with any version between 2.6.0 and 6.6-rc2, wit=
hout patching
> > __ro_after_init out. We can load LKM-based LSMs, without patching the o=
riginal kernel.
> > And it seems to me that several proprietary security products for Linux=
 are using
> > this trick, for LSMs for such products cannot be built into distributor=
's kernels...
>
> ...
>
> > > The performance benefits here outweigh the need for a completely
> > > unsupported use case.
> >
> > LKM-based LSMs are not officially supported since 2.6.24. But people ne=
ed LKM-based LSMs.
> > It is very sad that the LSM community is trying to lock out out of tree=
 LSMs
> > ( https://lkml.kernel.org/r/ec37cd2f-24ee-3273-c253-58d480569117@I-love=
.SAKURA.ne.jp ).
> > The LSM interface is a common property for *all* Linux users.
> >
> > I'm not objecting the performance benefits by replacing with static cal=
ls.
> > I'm not happy that the LSM community ignores the Torvald's comment at h=
ttps://lkml.org/lkml/2007/10/1/192
> > and does not listen to minority's voices.
>
> Despite a previous comment that I was done engaging with Tetsuo on
> this topic, I feel it is worth commenting here as there are a number
> of people on the To/CC line that have likely not been following the
> related discussion threads on the LSM list.
>
> First and foremost I want to reiterate that the LSM community's first
> priority are those LSMs which have been accepted and merged into the
> upstream Linux kernel.  While I have no intention, or desire, to harm
> out-of-tree LSMs, I stand firm that we should not compromise designs
> for in-tree LSMs/functionality solely to benefit out-of-tree LSMs.  I
> believe this is consistent, or at least compatible, with the general
> Linux kernel community's stance on in-tree vs out-of-tree code.
>
> The (relatively) newly proposed LSM syscalls have proven to be a
> contentious topic between Tetsuo and the LSM community as a whole; I
> won't rehash the arguments here, as they are all available on
> lore.kernel.org (simply look for any threads that Tetsuo has been
> involved in over the past several months) but we have discussed this
> issue at great length and Tetsuo remains the only opposing opinion.
> It was my hope that Tetsuo would respect the opinion of the upstream
> LSM community, even if he didn't agree with the details.  After all,
> this is how we move forward in cases where differing opinions cannot
> all be accommodated in the code.
>
> Unfortunately Tetsuo's continued and stubborn refusal to accept the
> majority opinion has started to spill into other discussion threads,
> disrupting the discussion there and twisting some of the core issues
> to better fit his arguments.  Not only is this frustrating, it is
> becoming rather disruptive.  My suggestion is to simply follow some
> classic Internet advice and "don't feed the trolls".
>
> As we discussed off-list (and in-person!) this week, I am generally
> supportive of work that improves performance, but correctness will
> always be my priority with maintainability a close second.  We have a
> few more pressing issues at the LSM layer which are demanding my time
> at the moment, but I do promise to come back to this issue/patchset as
> these other high priority issues are resolved.
>
> Thanks for your patience and understanding KP :)

Thank you for the context Paul, this explains a lot!


>
> --
> paul-moore.com
