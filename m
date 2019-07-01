Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD374EA45
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Jun 2019 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfFUOKe (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Jun 2019 10:10:34 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45529 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUOKe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 10:10:34 -0400
Received: by mail-ua1-f67.google.com with SMTP id v18so2992875uad.12
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wrdEXo/dZqG2VBBEHjkm9umzSYOAuCCoFiPBOZwieBA=;
        b=dr9Z+fBW/EL/AboE8tYKHBbokfp7cBhVBj2BeXnlM1sNnJU1yZlEYPW1v7VnYnKD9g
         ZoirrFWGixiGN+pWwZxclknn52BNiexn12gfKsWELbai6du00S32lG11y9VkdYvjJre6
         hn/PQ0y4vh8xEAQ1969NI/lVFAr2MpC9p8hAxiUHZ5yCuKRR8s6NSS0qWzbKa/tZdcKY
         pFoj6FwVdsVghIlnlg1Y1yX0tRba/aWQxKlaLcDk9nClMescS+5hR0AA6vC4P4W5/8EF
         XWVv9SmWCE9OsKTIGo8j8/Mer2OwCmb7jpFGnELQrvt9PuGOfEALHhGoUGNk2mgspI9o
         i4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wrdEXo/dZqG2VBBEHjkm9umzSYOAuCCoFiPBOZwieBA=;
        b=D5k30sowB4AMrd7CiLqol8qewfY3ZdJE2UxOQepnP6jKcWODyhB4xqyrCNMbwc/svI
         ztOWp975FCDvHeyV1QtRl7MgdJauvCwnjrCDfb0V3pNx6Baov8/oABdDz07rmTVh8bDW
         zThX9sTOpjWZnkVeYBT+8l3zvcfjelijrYAQvHtlZsALFLSg1gCYAoTwXfbZqGSSl+o4
         jL9X5/HmrIcvKsrTCaLk4qMq05YFuxgu18iGVtoQTD++my0EBq+rQ0p7iZnAoGS5i1pD
         6tEv0DIdM4QYUmoOzZJ6m7mklG4jRJrUD4rU2djiuNFUf9DtBokBTalmzAajRflouJJ4
         vcag==
X-Gm-Message-State: APjAAAXA3Pul+Slb/lWwOxkGJGuxGXSjCf43ZG5jhmxX6Y9MBW6GbM4P
        UzqavXcl+qMfp8SWorJxFhCecrfszKf27p3kcmWEHQ==
X-Google-Smtp-Source: APXvYqz/CH5RLWc9rguyLew76C+m4hWG0I8vzrW686B60RxUfjgG1yOUxMREVPBIXgPDhj1lf7iqdrOvdYXQfkzWbqM=
X-Received: by 2002:ab0:308c:: with SMTP id h12mr6056804ual.72.1561126232440;
 Fri, 21 Jun 2019 07:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190617151050.92663-1-glider@google.com> <20190617151050.92663-2-glider@google.com>
 <20190621070905.GA3429@dhcp22.suse.cz> <CAG_fn=UFj0Lzy3FgMV_JBKtxCiwE03HVxnR8=f9a7=4nrUFXSw@mail.gmail.com>
In-Reply-To: <CAG_fn=UFj0Lzy3FgMV_JBKtxCiwE03HVxnR8=f9a7=4nrUFXSw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 21 Jun 2019 16:10:19 +0200
Message-ID: <CAG_fn=W90HNeZ0UcUctnbUBzJ=_b+gxMGdUoDyO3JPoyy4dGSg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 10:57 AM Alexander Potapenko <glider@google.com> wr=
ote:
>
> On Fri, Jun 21, 2019 at 9:09 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 17-06-19 17:10:49, Alexander Potapenko wrote:
> > > The new options are needed to prevent possible information leaks and
> > > make control-flow bugs that depend on uninitialized values more
> > > deterministic.
> > >
> > > init_on_alloc=3D1 makes the kernel initialize newly allocated pages a=
nd heap
> > > objects with zeroes. Initialization is done at allocation time at the
> > > places where checks for __GFP_ZERO are performed.
> > >
> > > init_on_free=3D1 makes the kernel initialize freed pages and heap obj=
ects
> > > with zeroes upon their deletion. This helps to ensure sensitive data
> > > doesn't leak via use-after-free accesses.
> > >
> > > Both init_on_alloc=3D1 and init_on_free=3D1 guarantee that the alloca=
tor
> > > returns zeroed memory. The two exceptions are slab caches with
> > > constructors and SLAB_TYPESAFE_BY_RCU flag. Those are never
> > > zero-initialized to preserve their semantics.
> > >
> > > Both init_on_alloc and init_on_free default to zero, but those defaul=
ts
> > > can be overridden with CONFIG_INIT_ON_ALLOC_DEFAULT_ON and
> > > CONFIG_INIT_ON_FREE_DEFAULT_ON.
> > >
> > > Slowdown for the new features compared to init_on_free=3D0,
> > > init_on_alloc=3D0:
> > >
> > > hackbench, init_on_free=3D1:  +7.62% sys time (st.err 0.74%)
> > > hackbench, init_on_alloc=3D1: +7.75% sys time (st.err 2.14%)
> > >
> > > Linux build with -j12, init_on_free=3D1:  +8.38% wall time (st.err 0.=
39%)
> > > Linux build with -j12, init_on_free=3D1:  +24.42% sys time (st.err 0.=
52%)
> > > Linux build with -j12, init_on_alloc=3D1: -0.13% wall time (st.err 0.=
42%)
> > > Linux build with -j12, init_on_alloc=3D1: +0.57% sys time (st.err 0.4=
0%)
> > >
> > > The slowdown for init_on_free=3D0, init_on_alloc=3D0 compared to the
> > > baseline is within the standard error.
> > >
> > > The new features are also going to pave the way for hardware memory
> > > tagging (e.g. arm64's MTE), which will require both on_alloc and on_f=
ree
> > > hooks to set the tags for heap objects. With MTE, tagging will have t=
he
> > > same cost as memory initialization.
> > >
> > > Although init_on_free is rather costly, there are paranoid use-cases =
where
> > > in-memory data lifetime is desired to be minimized. There are various
> > > arguments for/against the realism of the associated threat models, bu=
t
> > > given that we'll need the infrastructre for MTE anyway, and there are
> > > people who want wipe-on-free behavior no matter what the performance =
cost,
> > > it seems reasonable to include it in this series.
> >
> > Thanks for reworking the original implemenation. This looks much better=
!
> >
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> > > Acked-by: Kees Cook <keescook@chromium.org>
> > > To: Andrew Morton <akpm@linux-foundation.org>
> > > To: Christoph Lameter <cl@linux.com>
> > > To: Kees Cook <keescook@chromium.org>
> > > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Cc: Michal Hocko <mhocko@kernel.org>
> > > Cc: James Morris <jmorris@namei.org>
> > > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Cc: Kostya Serebryany <kcc@google.com>
> > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Sandeep Patil <sspatil@android.com>
> > > Cc: Laura Abbott <labbott@redhat.com>
> > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Jann Horn <jannh@google.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Marco Elver <elver@google.com>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-security-module@vger.kernel.org
> > > Cc: kernel-hardening@lists.openwall.com
> >
> > Acked-by: Michal Hocko <mhocko@suse.cz> # page allocator parts.
> >
> > kmalloc based parts look good to me as well but I am not sure I fill
> > qualified to give my ack there without much more digging and I do not
> > have much time for that now.
> >
> > [...]
> > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > index fd5c95ff9251..2f75dd0d0d81 100644
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -315,7 +315,7 @@ static struct page *kimage_alloc_pages(gfp_t gfp_=
mask, unsigned int order)
> > >               arch_kexec_post_alloc_pages(page_address(pages), count,
> > >                                           gfp_mask);
> > >
> > > -             if (gfp_mask & __GFP_ZERO)
> > > +             if (want_init_on_alloc(gfp_mask))
> > >                       for (i =3D 0; i < count; i++)
> > >                               clear_highpage(pages + i);
> > >       }
> >
> > I am not really sure I follow here. Why do we want to handle
> > want_init_on_alloc here? The allocated memory comes from the page
> > allocator and so it will get zeroed there. arch_kexec_post_alloc_pages
> > might touch the content there but is there any actual risk of any kind
> > of leak?
> You're right, we don't want to initialize this memory if init_on_alloc is=
 on.
> We need something along the lines of:
>   if (!static_branch_unlikely(&init_on_alloc))
>     if (gfp_mask & __GFP_ZERO)
>       // clear the pages
>
> Another option would be to disable initialization in alloc_pages() using =
a flag.
> >
> > > diff --git a/mm/dmapool.c b/mm/dmapool.c
> > > index 8c94c89a6f7e..e164012d3491 100644
> > > --- a/mm/dmapool.c
> > > +++ b/mm/dmapool.c
> > > @@ -378,7 +378,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t=
 mem_flags,
> > >  #endif
> > >       spin_unlock_irqrestore(&pool->lock, flags);
> > >
> > > -     if (mem_flags & __GFP_ZERO)
> > > +     if (want_init_on_alloc(mem_flags))
> > >               memset(retval, 0, pool->size);
> > >
> > >       return retval;
> >
> > Don't you miss dma_pool_free and want_init_on_free?
> Agreed.
> I'll fix this and add tests for DMA pools as well.
This doesn't seem to be easy though. One needs a real DMA-capable
device to allocate using DMA pools.
On the other hand, what happens to a DMA pool when it's destroyed,
isn't it wiped by pagealloc?

I'm inclined towards not touching mm/dmapool.c in this patch series,
as it is probably orthogonal to the idea of hardening the
heap/pagealloc.
> > --
> > Michal Hocko
> > SUSE Labs
>
>
>
> --
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe, 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
