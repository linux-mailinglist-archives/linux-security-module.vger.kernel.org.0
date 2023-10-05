Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFC07BA16A
	for <lists+linux-security-module@lfdr.de>; Thu,  5 Oct 2023 16:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbjJEOnm (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 5 Oct 2023 10:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbjJEOkk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Oct 2023 10:40:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A663877659
        for <linux-security-module@vger.kernel.org>; Thu,  5 Oct 2023 07:13:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24423C4167D
        for <linux-security-module@vger.kernel.org>; Thu,  5 Oct 2023 14:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696515189;
        bh=Bo5mvk6vkrQxD2IluJgA/5OHu6xLKoIvtWmLKT7zBGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YFXdRFQRqfZb9ryswA8hjH1yUFvBiQo0da78Lxg1Chw2WKPaBUa3Bi1npIh+1neqO
         +L9x4TldM0VTimJ4LhlgEEAIVk/cBtiCmEME8hmUe9mHyNxM80GSBW4a58ucWu4hc6
         x3emtGX18las8qAETtkQgTopX1Bx/HVKSsaBXiS0U1tkj0p1A8Y3izJvMBA57Q6Ec0
         V1gy+Uxmuc2bDN47SszebtD/AwW1OLDV2Ksf6J0gM6mjPBYNt7ZExSSlMwko4ebELU
         WpdB959b/jXxVorczfUdl2+kG9ZRZnHUOfsyGKLkahGxwPQ6J+6v5TOrRPZcfpokNc
         xYAekP59hvWFw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-533d9925094so1793928a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 05 Oct 2023 07:13:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YyOoRNgZxOabkdgD1wk6IKWoOYClZ0TmQEt07XLOxhQTa5jbsRw
        sFIhmXT2Lmlqievx/15u/MsB568NknwPm8WUI/DdoQ==
X-Google-Smtp-Source: AGHT+IGM7SGGf75Todds88tZ8hzjPtZ+Z8ItHdiSECABQJ5cIJlbNJT2qigtQfzO57mkPNcA5RMCRhzJBrjw4ATwjjg=
X-Received: by 2002:a05:6402:14d2:b0:530:e9bf:1ea3 with SMTP id
 f18-20020a05640214d200b00530e9bf1ea3mr5287832edx.7.1696515187421; Thu, 05 Oct
 2023 07:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com> <20231005114754.56c40a2f@d-jobol>
In-Reply-To: <20231005114754.56c40a2f@d-jobol>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 5 Oct 2023 16:12:56 +0200
X-Gmail-Original-Message-ID: <CACYkzJ458OJT9fii--uhZ-3JCbWJqvvZy736FDaCheL0V-U3AA@mail.gmail.com>
Message-ID: <CACYkzJ458OJT9fii--uhZ-3JCbWJqvvZy736FDaCheL0V-U3AA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
To:     =?UTF-8?Q?Jos=C3=A9_Bollo?= <jobol@nonadev.net>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 5, 2023 at 11:48=E2=80=AFAM Jos=C3=A9 Bollo <jobol@nonadev.net>=
 wrote:
>
> Le Wed, 27 Sep 2023 18:02:32 +0200,
> KP Singh <kpsingh@kernel.org> a =C3=A9crit :
>
> > On Wed, Sep 27, 2023 at 5:09=E2=80=AFPM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >
> > > Recently, the LSM community is trying to make drastic changes.
> > >
> > > Crispin Cowan has explained
> > >
> > >   It is Linus' comments that spurred me to want to start this
> > > undertaking.  He observes that there are many different security
> > > approaches, each with their own advocates.  He doesn't want to
> > > arbitrate which of them should be "the" Linux security approach,
> > > and would rather that Linux can support any of them.
> > >
> > >   That is the purpose of this project:  to allow Linux to support a
> > > variety of security models, so that security developers don't have
> > > to have the "my dog's bigger than your dog" argument, and users can
> > > choose the security model that suits their needs.
> > >
> > > when the LSM project started [1].
> > >
> > > However, Casey Schaufler is trying to make users difficult to
> > > choose the security model that suits their needs, by requiring LSM
> > > ID value which is assigned to only LSM modules that succeeded to
> > > become in-tree [2]. Therefore, I'm asking Casey and Paul Moore to
> > > change their mind to allow assigning LSM ID value to any LSM
> > > modules (so that users can choose the security model that suits
> > > their needs) [3].
> > >
> > > I expect that LSM ID value will be assigned to any publicly
> > > available LSM modules. Otherwise, it is mostly pointless to propose
> > > this patch; there will be little LSM modules to built into vmlinux;
> > > let alone dynamically loading as LKM-based LSMs.
> > >
> > > Also, KP Singh is trying to replace the linked list with static
> > > calls in order to reduce overhead of indirect calls [4]. However,
> > > this change assumed that any LSM modules are built-in. I don't like
> > > such assumption because I still consider that LSM modules which are
> > > not built into vmlinux will be wanted by users [5].
> > >
> > > Then, Casey told me to supply my implementation of loadable security
> > > modules [6]. Therefore, I post this patch as basic changes needed
> > > for allowing dynamically appendable LSM modules (and an example of
> > > appendable LSM modules). This patch was tested on only x86_64.
> > >
> > > Question for KP Singh would be how can we allow dynamically
> > > appendable LSM modules if current linked list is replaced with
> > > static calls with minimal-sized array...
> >
> > As I suggested in the other thread:
> >
> > https://lore.kernel.org/bpf/20230918212459.1937798-1-kpsingh@kernel.org=
/T/#md21b9d9cc769f39e451d20364857b693d3fcb587
> >
> > You can add extra static call slots and fallback to a linked list
> > based implementation if you have more than say N modules [1] and
> > fallback to a linked list implementation [2].
> >
> > for [1] you can just do MAX_LSM_COUNT you can just do:
> >
> > #ifdef CONFIG_MODULAR_LSM
> > #define MODULAR_LSM_ENABLED "1,1,1,1"
> > #endif
> >
> > and use it in the LSM_COUNT.
> >
> > for [2] you can choose to export a better module API than directly
> > exposing security_hook_heads.
> >
> > Now, comes the question of whether we need dynamically loaded LSMs, I
> > am not in favor of this.Please share your limitations of BPF as you
> > mentioned and what's missing to implement dynamic LSMs. My question
> > still remains unanswered.
> >
> > Until I hear the real limitations of using BPF, it's a NAK from me.
>
> Hi all,
>
> I don't understand the reason why you want to enforce implementers to
> use your BPF?
>
> Even if it can do any possible thing that security implementer wants,
> why enforcing to use it? For experimenting? But then after successful
> experimentation the implementer must translate to real LSM and rewrite
> almost every thing.
>
> And also why to use faty BPF for a tricky simple stuff?
>

faty BPF? I am not even sure what that means? BPF is compiled to
native code and is used in production systems and not just
experimental stuff. I think you have some catching up to do here!
