Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D65E7AB403
	for <lists+linux-security-module@lfdr.de>; Fri, 22 Sep 2023 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjIVOp4 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 22 Sep 2023 10:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjIVOpz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Sep 2023 10:45:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C511D180
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 07:45:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7137CC433C9
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695393949;
        bh=x8jhwHX1MvKQRIiqP5FKS1y+4zwiLLNB0WcOkVo6kzg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DebYlyZnPCwNqDJg/z4MY+5QqYyRai7UI/s8h0r0YhXgi4YeTEZr2efKE8x2IJ9XM
         vMBTe4W5p0FJxmBv2ibcjDB4y9e6Bm+pG/VLtpN/o5BBLnXvR4sc1/mfsW4YAy1zOv
         uUDDm8I8dPSJruENE/rIfONmohKSxCx1wb7bPw1EVpBjbvB3UqW7gKG+50IWOOqq+N
         0N9mXNF+8Igr/2PfZoOMYToqexQivy48U3CLb7gtECuSF9rYgaFudTLQcC0bEMXazK
         tLWdftBjn4oLwXXakVA6F/N4pE7Wo8Ree/E7XPTh2gYjVP0ZdqVIcG/lGvJ6ONES2r
         KKDA+VhKahkew==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so5610028a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 07:45:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YxL5FLHovkK7+TJzvWGvk1F5bUqAdpCmxvu2SnckHGLvURCCqYe
        WflRZOzNJXS0KezM4r648J8Z8zZubQ9Na/Zm9Scmtg==
X-Google-Smtp-Source: AGHT+IHrBNWm0Cefy5SEbxPrR0DdcKeSIQe/ruLw87hb8iYwlGCKq+UrbzslqiAvXG6t6ZLsg03KQXZ864PuqaNLi7o=
X-Received: by 2002:aa7:d819:0:b0:521:d2ab:e4df with SMTP id
 v25-20020aa7d819000000b00521d2abe4dfmr3920764edq.19.1695393947668; Fri, 22
 Sep 2023 07:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
 <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com> <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
In-Reply-To: <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 22 Sep 2023 16:45:36 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5M0Bw9S_mkFkjR_-bRsKryXh2LKiurjMX9WW-d0Mr6bg@mail.gmail.com>
Message-ID: <CACYkzJ5M0Bw9S_mkFkjR_-bRsKryXh2LKiurjMX9WW-d0Mr6bg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 22, 2023 at 1:25=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/09/21 22:58, KP Singh wrote:
> > On Thu, Sep 21, 2023 at 3:21=E2=80=AFPM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> On 2023/09/19 6:24, KP Singh wrote:
> >>> These macros are a clever trick to determine a count of the number of
> >>> LSMs that are enabled in the config to ascertain the maximum number o=
f
> >>> static calls that need to be configured per LSM hook.
> >>
> >> As a LKM-based LSM user, indirect function calls using a linked list h=
ave
> >> an advantage which this series kills. There always is a situation wher=
e a
> >
> >
> >> LSM cannot be built into vmlinux (and hence has to be loaded as a LKM-=
based
> >> LSM) due to distributor's support policy. Therefore, honestly speaking=
,
> >> I don't want LSM infrastructure to define the maximum number of "slots=
" or
> >> "static calls"...
> >>
> >
> > Yeah, LSMs are not meant to be used from a kernel module. The data
> > structure is actually __ro_after_init. So, I am not even sure how you
> > are using it in kernel modules (unless you are patching this out).
> > And, if you are really patching stuff to get your out of tree LSMs to
> > work, then you might as well add your "custom" LSM config here or just
> > override this count.
>
> I'm using LKM-based LSM with any version between 2.6.0 and 6.6-rc2, witho=
ut patching
> __ro_after_init out. We can load LKM-based LSMs, without patching the ori=
ginal kernel.

Then __ro_after_init is broken in your tree and you are missing some patche=
s.

> And it seems to me that several proprietary security products for Linux a=
re using
> this trick, for LSMs for such products cannot be built into distributor's=
 kernels...
>
> ----------
> [    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-6.6.0-rc2+ root=
=3D/dev/sda1 ro vconsole.keymap=3Djp106 vconsole.font=3Dlatarcyrheb-sun16 s=
ecurity=3Dnone sysrq_always_enabled console=3DttyS0,115200n8 console=3Dtty0=
 LANG=3Den_US.UTF-8 init=3D/sbin/akari-init
> (...snipped...)
> [  147.238458] AKARI: 1.0.48   2023/05/27
> [  147.244867] Access Keeping And Regulating Instrument registered.
> [  147.261232] Calling /sbin/ccs-init to load policy. Please wait.
> 239 domains. 11807 ACL entries.
> 1938 KB used by policy.
> [  147.768694] CCSecurity: 1.8.9   2021/04/01
> [  147.768740] Mandatory Access Control activated.
> ----------
>
> >
> > The performance benefits here outweigh the need for a completely
> > unsupported use case.
>
> LKM-based LSMs are not officially supported since 2.6.24. But people need=
 LKM-based LSMs.
> It is very sad that the LSM community is trying to lock out out of tree L=
SMs
> ( https://lkml.kernel.org/r/ec37cd2f-24ee-3273-c253-58d480569117@I-love.S=
AKURA.ne.jp ).
> The LSM interface is a common property for *all* Linux users.

Again, I don't understand how this locks out out-of-tree LSMs. One can
go and patch static calls the same way one hacked around by directly
adding stuff to the security_hook_heads. I am not going to suggest any
hacks here but there are pretty obvious solutions out there.;

My recommendation would be to use BPF LSM for any custom MAC policy
logic. That's the whole goal of the BPF LSM is to safely enable these
use cases without relying on LSM internals and hacks.

- KP

>
> I'm not objecting the performance benefits by replacing with static calls=
.
> I'm not happy that the LSM community ignores the Torvald's comment at htt=
ps://lkml.org/lkml/2007/10/1/192
> and does not listen to minority's voices.
>
