Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70FFB4E9E7
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Jun 2019 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfFUNuP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Jun 2019 09:50:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44646 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFUNuO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 09:50:14 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so3103504iob.11
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cw2DVVVaW1JthaIStHyVWKFyGjZO7Go63aSJmpzaddY=;
        b=KXjBo31VfnltBbJdA5yKC1ZR851xWsYsQgB+hBrxuGNZF3t1WXwfr646wzU1J12QeP
         YU9wetmkhiV57BQHqaQCIK8Y1dUt7Qv+MtezwXD1DK6KqYN0QHLLhXdji7ajcIAZBN7r
         VpBJ+Z29U5Fj4elewwoSwcbQF8RR1L8BtDFPd4rdBhOHjHJzNTF/0hEvtO2WJpVm42Bc
         y8EL4SkeNVD0sHOcuRaVkyz09ZUUwefEOQ/98C1fZaV18ENeM0LGC2Pe8jpjBgQ7iVk9
         4jJVMv5EURSo2Ln0lcUjyy0RNEfNrU71m7G+57EraqJ+xYAVjhgOtnIHGtz2UUqz51p/
         umog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cw2DVVVaW1JthaIStHyVWKFyGjZO7Go63aSJmpzaddY=;
        b=O6sxLCFwkDo35KUVGgDMOJaTCoRc9NMJSsm+uItCiwVvuJnVZBHRE/e9WF0Cw06udX
         kdFyaXZwHiUVQBdx9ZNN6OIB3TV3j2CepQOMs/ILYvnavR8E/TnujSuy5FWzlOEU6wXz
         Vf+bDQSzfBly05JHFKHYxP4Z/yGclTVnLLFJrhLiugpbu0tYm6aBCwKKix/wZDC5ZAb0
         2qgadKK4aFbjIXRJ12bz6JvBr7UpI9gLY4gLOG/F3CLspTIOz8Ycm1yu310R9u0364iq
         uvGVYBgqShg1x2r34ZxI4ddGYjq/Wh2vvSi9TfjEcViSkgjC0TT8VgPFM1PkD/jvfayX
         k4sA==
X-Gm-Message-State: APjAAAXPiCSR58wWCLtc4zbFRQ8nuG4clE7Fumuw714DXgrb790VG1eO
        0JCEyUSVJvNgw/i5Qs4eCVAEH4fGywa4d8vdf2bviA==
X-Google-Smtp-Source: APXvYqyGp3A4I8cB/c8HVPYxMthN9MCOBsCawaPJbxoVjiIyOYTqSWoU2129z/WePboVbfhUhWGmvkGBEqsMhABn2+c=
X-Received: by 2002:a5e:820a:: with SMTP id l10mr23290864iom.283.1561125013996;
 Fri, 21 Jun 2019 06:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190618094731.3677294-1-arnd@arndb.de> <201906201034.9E44D8A2A8@keescook>
 <CAK8P3a2uFcaGMSHRdg4NECHJwgAyhtMuYDv3U=z2UdBSL5U0Lw@mail.gmail.com>
 <CAKv+Gu-A_OWUQ_neUAprmQOotPA=LoUGQHvFkZ2tqQAg=us1jA@mail.gmail.com> <CAK8P3a2d3H-pdiLX_8aA4LNLOVTSyPW_jvwZQkv0Ey3SJS87Bg@mail.gmail.com>
In-Reply-To: <CAK8P3a2d3H-pdiLX_8aA4LNLOVTSyPW_jvwZQkv0Ey3SJS87Bg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 21 Jun 2019 15:50:02 +0200
Message-ID: <CAKv+Gu9p017iPva85dPMdnKW_MSOUcthqcy7KDhGEYCN7=C_SA@mail.gmail.com>
Subject: Re: [PATCH] structleak: disable BYREF_ALL in combination with KASAN_STACK
To:     Arnd Bergmann <arnd@arndb.de>
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

On Fri, 21 Jun 2019 at 15:44, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jun 21, 2019 at 3:32 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > On Fri, 21 Jun 2019 at 11:44, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thu, Jun 20, 2019 at 7:36 PM Kees Cook <keescook@chromium.org> wrote:
> > > > On Tue, Jun 18, 2019 at 11:47:13AM +0200, Arnd Bergmann wrote:
> > > > > The combination of KASAN_STACK and GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
> > > > > leads to much larger kernel stack usage, as seen from the warnings
> > > > > about functions that now exceed the 2048 byte limit:
> > > >
> > > > Is the preference that this go into v5.2 (there's not much time left),
> > > > or should this be v5.3? (You didn't mark it as Cc: stable?)
> > >
> > > Having it in 5.2 would be great. I had not done much build testing in the last
> > > months, so I didn't actually realize that your patch was merged a while ago
> > > rather than only in linux-next.
> > >
> > > BTW, I have now run into a small number of files that are still affected
> > > by a stack overflow warning from STRUCTLEAK_BYREF_ALL. I'm trying
> > > to come up with patches for those as well, we can probably do it in a way
> > > that also improves the affected drivers. I'll put you on Cc when I
> > > find another one.
> > >
> >
> > There is something fundamentally wrong here, though. BYREF_ALL only
> > initializes variables that have their address taken, which does not
> > explain why the size of the stack frame should increase (since in
> > order to have an address in the first place, the variable must already
> > have a stack slot assigned)
> >
> > So I suspect that BYREF_ALL is defeating some optimizations where.
> > e.g., the call involving the address of the variable is optimized
> > away, but the the initialization remains, thus forcing the variable to
> > be allocated in the stack frame even though the initializer is the
> > only thing that references it.
>
> One pattern I have seen here is temporary variables from macros or
> inline functions whose lifetime now extends over the entire function
> rather than just the basic block in which they are defined, see e.g.
> lpfc_debug_dump_qe() being inlined multiple times into
> lpfc_debug_dump_all_queues(). Each instance of the local
> "char line_buf[LPFC_LBUF_SZ];" seems to add on to the previous
> one now, where the behavior without the structleak plugin is that
> they don't.
>

Right, that seems to be due to the fact that this code

/* split the first bb where we can put the forced initializers */
gcc_assert(single_succ_p(ENTRY_BLOCK_PTR_FOR_FN(cfun)));
bb = single_succ(ENTRY_BLOCK_PTR_FOR_FN(cfun));
if (!single_pred_p(bb)) {
    split_edge(single_succ_edge(ENTRY_BLOCK_PTR_FOR_FN(cfun)));
    gcc_assert(single_succ_p(ENTRY_BLOCK_PTR_FOR_FN(cfun)));
}

puts all the initializers at the beginning of the function rather than
inside the scope of the definition.
