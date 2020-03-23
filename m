Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F74818FEA8
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Mar 2020 21:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgCWUVP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 23 Mar 2020 16:21:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36399 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWUVO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Mar 2020 16:21:14 -0400
Received: by mail-qk1-f194.google.com with SMTP id d11so16879619qko.3;
        Mon, 23 Mar 2020 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dq2e7ENlb6avmGzEnYBHkNZ9DRnXGKNiPYpj0AW5dUg=;
        b=uu1xFpLO5YSYuS2vANvLsWqcoNgOTTn9WC1QypwzdjM3kTUkdmt6EUFZrZx3rRBRcX
         8bX2LVpHMgmGUolIQ6HFEA4X+66E+q5NQetZrr75cs+GYTfEtVMz7BGWALSzlEw1c0rw
         KRVZ9eDJL9OSoZTSbDxI+TzPufHpnWwQYxuOyObi01ERpflJ5/+ft4JnSmxKL8tZp0dk
         INhZVTXEJYcUq7arBtuwT6XTlbbNe3heEz8RDNzwyvUtp8RZHiJ7MqkuADnFq89R/YSp
         BNs5HVvaAv4eLQbdbEaPN33MTXQAPovB+SWUPMoslKlfeyiNFQdCF5UfQ9/+S6tuxg5k
         fjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dq2e7ENlb6avmGzEnYBHkNZ9DRnXGKNiPYpj0AW5dUg=;
        b=OAh6aswAtJ41/KmAuo4RgXPWPlIgiNgQv9s++aoGlwtNsJAKON7wzr/jWF38yUwhBg
         VZeoehXe10nSXgKWhIgU8gJAepshYjW55iJ32yF4UqHY2vMtAC8TXwJht0P79htXcfXi
         t/MmYJy3BjNU6NOH5Pv1T1DEaQCgcAhNj/WOuzSj3flL45uSdk92OS/+h6eT18VpLPgf
         Oqei+IIdQQy7i+pD0Uy4qoEeuXF3VRGINDpggy5QFeCifK7ITm9i+vH6najaU3NYLVAp
         ekMw/M9onyeu2Lpg9fFWzylvtVqHdAsi7d6nDv6hIT2uyY6tmXPeZQeuKn8VtoP2XH7R
         NMUw==
X-Gm-Message-State: ANhLgQ2pK+aN1iOYw6J/djTUmNaMXHbIT3NHv62hsDhTKnEmG7pCPGEn
        Oye7h3kJY+91hgLwZiE3cascuh37UIQCPt2XqAU=
X-Google-Smtp-Source: ADFU+vvVtBthwjRyrs5hStcwgajio70+DWdEHq4ZkATtjshFoMokv3FExtoOv5+t9MDaR6Ya6IWPHO1MqUxxgRmEMJY=
X-Received: by 2002:a37:e40d:: with SMTP id y13mr22608204qkf.39.1584994873559;
 Mon, 23 Mar 2020 13:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200323164415.12943-1-kpsingh@chromium.org> <20200323164415.12943-6-kpsingh@chromium.org>
 <202003231237.F654B379@keescook> <20200323194759.GB18787@chromium.org>
In-Reply-To: <20200323194759.GB18787@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Mar 2020 13:21:02 -0700
Message-ID: <CAEf4BzZTsssnKgRFEzZBOnBMjCxk2wzkq7j_bOHmPpt5RmhqKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
To:     KP Singh <kpsingh@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 23, 2020 at 12:48 PM KP Singh <kpsingh@chromium.org> wrote:
>
> On 23-M=C3=A4r 12:44, Kees Cook wrote:
> > On Mon, Mar 23, 2020 at 05:44:13PM +0100, KP Singh wrote:
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > The bpf_lsm_ nops are initialized into the LSM framework like any oth=
er
> > > LSM.  Some LSM hooks do not have 0 as their default return value. The
> > > __weak symbol for these hooks is overridden by a corresponding
> > > definition in security/bpf/hooks.c
> > >
> > > The LSM can be enabled / disabled with CONFIG_LSM.
> > >
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> >
> > Nice! This is super clean on the LSM side of things. :)
> >
> > One note below...
> >
> > > Reviewed-by: Brendan Jackman <jackmanb@google.com>
>
> [...]
>
> > > +
> > > +/*
> > > + * Copyright (C) 2020 Google LLC.
> > > + */
> > > +#include <linux/lsm_hooks.h>
> > > +#include <linux/bpf_lsm.h>
> > > +
> > > +/* Some LSM hooks do not have 0 as their default return values. Over=
ride the
> > > + * __weak definitons generated by default for these hooks
> >
> > If you wanted to avoid this, couldn't you make the default return value
> > part of lsm_hooks.h?
> >
> > e.g.:
> >
> > LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct inode *inode,
> >        const char *name, void **buffer, bool alloc)
> >
> > ...
> >
> > #define LSM_HOOK(RET, DEFAULT, NAME, ...)     \
> >       LSM_HOOK_##RET(NAME, DEFAULT, __VA_ARGS__)
> > ...
> > #define LSM_HOOK_int(NAME, DEFAULT, ...)      \
> > noinline int bpf_lsm_##NAME(__VA_ARGS__)      \
> > {                                             \
> >       return (DEFAULT);                       \
> > }
> >
> > Then all the __weak stuff is gone, and the following 4 functions don't
> > need to be written out, and the information is available to the macros
> > if anyone else might ever want it.
>
> Thanks, I like it!
>
> If no-one objects, I will update it in the next revision.
>

I was about to propose the same, explicit default value seems like a
much cleaner and more straightforward way to do this.

> - KP
>
> >
> > -Kees
> >
> > > + */
> > > +noinline int bpf_lsm_inode_getsecurity(struct inode *inode, const ch=
ar *name,
> > > +                                  void **buffer, bool alloc)
> > > +};
>
> [...]
>
> > > --
> > > 2.20.1
> > >
> >
> > --
> > Kees Cook
