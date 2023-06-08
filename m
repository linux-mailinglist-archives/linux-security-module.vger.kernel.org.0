Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2073B727532
	for <lists+linux-security-module@lfdr.de>; Thu,  8 Jun 2023 04:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjFHCsU (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 7 Jun 2023 22:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjFHCsT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Jun 2023 22:48:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8B31702
        for <linux-security-module@vger.kernel.org>; Wed,  7 Jun 2023 19:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB16A60EAD
        for <linux-security-module@vger.kernel.org>; Thu,  8 Jun 2023 02:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D580C433AC
        for <linux-security-module@vger.kernel.org>; Thu,  8 Jun 2023 02:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686192497;
        bh=4A7H/mog/TgOmC7oqpsOM6DptnxRvSrVl/OhNt4q5wg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CyeLPY48K0wsctozYU6JfdKV/lmxivx3x0DeDxHnwTR7B7/nGzIITgEFUNqTLWleL
         UmiUmfpYefDX91N7a6FWqc/37JdV9VHkKCBnFk5kY+7W9mejzu7vzakKQsZeR2/Vkc
         DBgGEwn0bxWiJFGR/QXCc7GgRSGApJnDPdU4hw/zwlag/PLu62rGhBEG2JkwR+/+2t
         MpuJP8XqdIkZpthpgbive0Tit3ls7k+vDjxl1fvQ/VsF6AQ3AkFZjb0UOYuRBu2QI1
         R0h+fQ5fUMQLGISHyDbsLReTOzuuQRK1UZxT8OdcKOVdNzbs3PbB2092/SbbBjme/i
         OCnPic1mbIpJQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-970056276acso21778266b.2
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jun 2023 19:48:17 -0700 (PDT)
X-Gm-Message-State: AC+VfDyzPE/yBDAptaOtP8y9IZDAZhMNvBxFKQ0qQ3Jb0LaU8ryc5sE+
        yQInCM7MPh57kMbYjNLNOc/u6RqGSaoJoTBSEJhpLw==
X-Google-Smtp-Source: ACHHUZ4WZ+gC3BRC12otKRR49zezASVnNvtVkVtTK3GcQKki3hi6v2g0aX8zCgiwz/s0b2TLwNt0Ix6HZCA7LCQI7aI=
X-Received: by 2002:a17:907:a426:b0:96f:912e:5ec4 with SMTP id
 sg38-20020a170907a42600b0096f912e5ec4mr7983866ejc.16.1686192495571; Wed, 07
 Jun 2023 19:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230120000818.1324170-1-kpsingh@kernel.org> <20230120000818.1324170-4-kpsingh@kernel.org>
 <202301192004.777AEFFE@keescook> <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
 <db1fed31-0283-5401-cf55-d18a98ca33ae@schaufler-ca.com> <CAPhsuW4C8NU15mjetX8Ucp3R66xEgOGS6udiaauUtPg06Si93Q@mail.gmail.com>
 <8b5f62f3-a2c4-9ba3-d1e4-af557047f44b@schaufler-ca.com> <CACYkzJ7=xPB-mzAq-GBszm2Q3NapVNbcrqBdSS0FZsTeTbL9QA@mail.gmail.com>
 <63e14c10.170a0220.beb2a.bc4c@mx.google.com>
In-Reply-To: <63e14c10.170a0220.beb2a.bc4c@mx.google.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 8 Jun 2023 04:48:04 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4LX6Acxs0s-d2+hC0Zfx2CTL7_JpeWD9pGz4b9_0J29g@mail.gmail.com>
Message-ID: <CACYkzJ4LX6Acxs0s-d2+hC0Zfx2CTL7_JpeWD9pGz4b9_0J29g@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
To:     Kees Cook <keescook@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 6, 2023 at 7:51=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Mon, Feb 06, 2023 at 07:41:04PM +0100, KP Singh wrote:
> > On Mon, Feb 6, 2023 at 7:29 PM Casey Schaufler <casey@schaufler-ca.com>=
 wrote:
> > >
> > > On 2/6/2023 9:48 AM, Song Liu wrote:
> > > > On Mon, Feb 6, 2023 at 8:29 AM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> > > >> On 2/6/2023 5:04 AM, KP Singh wrote:
> > > >>> On Fri, Jan 20, 2023 at 5:36 AM Kees Cook <keescook@chromium.org>=
 wrote:
> > > >>>> On Fri, Jan 20, 2023 at 01:08:17AM +0100, KP Singh wrote:
> > > >>>>> The indirect calls are not really needed as one knows the addre=
sses of
> > > >>> [...]
> > > >>>
> > > >>>>> +/*
> > > >>>>> + * Define static calls and static keys for each LSM hook.
> > > >>>>> + */
> > > >>>>> +
> > > >>>>> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)           =
       \
> > > >>>>> +     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),      =
       \
> > > >>>>> +                             *((RET(*)(__VA_ARGS__))NULL));   =
       \
> > > >>>>> +     DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ENABLED_KEY(NAME, N=
UM));
> > > >>>> Hm, another place where we would benefit from having separated l=
ogic for
> > > >>>> "is it built?" and "is it enabled by default?" and we could use
> > > >>>> DEFINE_STATIC_KEY_MAYBE(). But, since we don't, I think we need =
to use
> > > >>>> DEFINE_STATIC_KEY_TRUE() here or else won't all the calls be
> > > >>>> out-of-line? (i.e. the default compiled state will be NOPs?) If =
we're
> > > >>>> trying to optimize for having LSMs, I think we should default to=
 inline
> > > >>>> calls. (The machine code in the commit log seems to indicate tha=
t they
> > > >>>> are out of line -- it uses jumps.)
> > > >>>>
> > > >>> I should have added it in the commit description, actually we are
> > > >>> optimizing for "hot paths are less likely to have LSM hooks enabl=
ed"
> > > >>> (eg. socket_sendmsg).
> > > >> How did you come to that conclusion? Where is there a correlation =
between
> > > >> "hot path" and "less likely to be enabled"?
> > > > I could echo KP's reasoning here. AFAICT, the correlation is that L=
SMs on
> > > > hot path will give more performance overhead. In our use cases (Met=
a),
> > > > we are very careful with "small" performance hits. 0.25% is signifi=
cant
> > > > overhead; 1% overhead will not fly without very good reasons (Do we
> > > > have to do this? Are there any other alternatives?). If it is possi=
ble to
> > > > achieve similar security on a different hook, we will not enable th=
e hook on
> > > > the hot path. For example, we may not enable socket_sendmsg, but tr=
y
> > > > to disallow opening such sockets instead.
> > >
> > > I'm not asking about BPF. I'm asking about the impact on other LSMs.
> > > If you're talking strictly about BPF you need to say that. I'm all fo=
r
> > > performance improvement. But as I've said before, it should be for al=
l
> > > the security modules, not just BPF.
> >
> > It's a trade off that will work differently for different LSMs and
> > distros (based on the LSM they chose) and this the config option. I
> > even suggested this be behind CONFIG_EXPERT (which is basically says
> > this:
> >
> >  "This option allows certain base kernel options and settings
> >  to be disabled or tweaked. This is for specialized
> >  environments which can tolerate a "non-standard" kernel.
> >  Only use this if you really know what you are doing."
>
> Using the DEFINE_STATIC_KEY_MAYBE() and static_branch_maybe() macros
> tied to a new CONFIG seems like it can give us a reasonable knob for
> in-line vs out-of-line calls.

Coming back to this after a while as I finally got time to work on
this. (work/personal downtime).

I am changing it to DEFINE_STATIC_KEY_TRUE in this patch and
DEFINE_STATIC_KEY_MAYBE in a subsequent one and guarded by a config
called CONFIG_SECURITY_HOOK_LIKELY. I am letting it default to yes,
but distros can change it depending on their choice of LSM and
performance characteristics.

>
> > > >>>  But I do see that there are LSMs that have these
> > > >>> enabled. Maybe we can put this behind a config option, possibly
> > > >>> depending on CONFIG_EXPERT?
> > > >> Help me, as the maintainer of one of those LSMs, understand why th=
at would
> > > >> be a good idea.
> > > > IIUC, this is also from performance concerns. We would like to mana=
ge
> > > > the complexity at compile time for performance benefits.
> > >
> > > What complexity? What config option? I know that I'm slow, but it loo=
ks
> > > as if you're suggesting making the LSM infrastructure incredibly frag=
ile
> > > and difficult to understand.
> >
> > I am sorry but the LSM is a core piece of the kernel that currently
> > has significant unnecessary overheads (look at the numbers that I
> > posted) and this not making it fragile, it's making it performant,
> > such optimisations are everywhere in the kernel and the LSM
> > infrastructure has somehow been neglected and is just catching up.
> > These are resources being wasted which could be saved.
>
> Let's just move forward to v2, which I think will look much cleaner. I
> think we can get to both maintainable code and run-time performance with
> this series.
>
> --
> Kees Cook
