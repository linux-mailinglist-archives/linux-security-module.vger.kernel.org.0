Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50C04E9B8
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Jun 2019 15:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfFUNo2 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Jun 2019 09:44:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34402 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUNo1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 09:44:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id m29so6965209qtu.1;
        Fri, 21 Jun 2019 06:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1VRloZAnkBM20C0VMUxA/xb315UbiGomahozxwvH1Z8=;
        b=lJMEoVrtp3544DX1I4a5sA0Sh6wlsis37MrKFTDnfx3UaW/XOb0MwRzhlK0qsYp2lG
         az/Vostqoi9m7pFrtRvsqg8w5Tp0qmu1Hvk0Sq0TI0r426w42ZB+RTJHSDHNBFsD1APm
         LBMywE5iZUtI8YkNHGYvHCky4uWCEcZwXX6tOOdW6zar/Za4jVbJ8rRGhIO9FEcEU19M
         HviF3qySrkR0iGHSwQZGqPAYf0cieok6OAlB5gCLuWLjA04IR3MB+yeRAJtRxEw19sfH
         VCiRj0mpsZf2KVNYooN+nZeP6uzumU0DRgxTRB+iOlhSSoQhn8l0mgmfMKcVwAHrvICt
         ynug==
X-Gm-Message-State: APjAAAWqrknmsROP0u0bjQdKuOt2RBO3bBLLS3pVSFMtZ7UtGxhrmZcg
        yzubvvckNqvZL90zk+el++ZI/opXhhKyRTY8U1U=
X-Google-Smtp-Source: APXvYqx9NB1qq4sDlov2UHcJxN+0a0rXwnpPmDPhIrvdFCKv81905QoRFNrlrNFvlCAE1/C6IOoX27NwUsfLu0J+GcU=
X-Received: by 2002:aed:2bc1:: with SMTP id e59mr96965363qtd.7.1561124666614;
 Fri, 21 Jun 2019 06:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190618094731.3677294-1-arnd@arndb.de> <201906201034.9E44D8A2A8@keescook>
 <CAK8P3a2uFcaGMSHRdg4NECHJwgAyhtMuYDv3U=z2UdBSL5U0Lw@mail.gmail.com> <CAKv+Gu-A_OWUQ_neUAprmQOotPA=LoUGQHvFkZ2tqQAg=us1jA@mail.gmail.com>
In-Reply-To: <CAKv+Gu-A_OWUQ_neUAprmQOotPA=LoUGQHvFkZ2tqQAg=us1jA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 15:44:08 +0200
Message-ID: <CAK8P3a2d3H-pdiLX_8aA4LNLOVTSyPW_jvwZQkv0Ey3SJS87Bg@mail.gmail.com>
Subject: Re: [PATCH] structleak: disable BYREF_ALL in combination with KASAN_STACK
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 3:32 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On Fri, 21 Jun 2019 at 11:44, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Jun 20, 2019 at 7:36 PM Kees Cook <keescook@chromium.org> wrote:
> > > On Tue, Jun 18, 2019 at 11:47:13AM +0200, Arnd Bergmann wrote:
> > > > The combination of KASAN_STACK and GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
> > > > leads to much larger kernel stack usage, as seen from the warnings
> > > > about functions that now exceed the 2048 byte limit:
> > >
> > > Is the preference that this go into v5.2 (there's not much time left),
> > > or should this be v5.3? (You didn't mark it as Cc: stable?)
> >
> > Having it in 5.2 would be great. I had not done much build testing in the last
> > months, so I didn't actually realize that your patch was merged a while ago
> > rather than only in linux-next.
> >
> > BTW, I have now run into a small number of files that are still affected
> > by a stack overflow warning from STRUCTLEAK_BYREF_ALL. I'm trying
> > to come up with patches for those as well, we can probably do it in a way
> > that also improves the affected drivers. I'll put you on Cc when I
> > find another one.
> >
>
> There is something fundamentally wrong here, though. BYREF_ALL only
> initializes variables that have their address taken, which does not
> explain why the size of the stack frame should increase (since in
> order to have an address in the first place, the variable must already
> have a stack slot assigned)
>
> So I suspect that BYREF_ALL is defeating some optimizations where.
> e.g., the call involving the address of the variable is optimized
> away, but the the initialization remains, thus forcing the variable to
> be allocated in the stack frame even though the initializer is the
> only thing that references it.

One pattern I have seen here is temporary variables from macros or
inline functions whose lifetime now extends over the entire function
rather than just the basic block in which they are defined, see e.g.
lpfc_debug_dump_qe() being inlined multiple times into
lpfc_debug_dump_all_queues(). Each instance of the local
"char line_buf[LPFC_LBUF_SZ];" seems to add on to the previous
one now, where the behavior without the structleak plugin is that
they don't.

      Arnd
