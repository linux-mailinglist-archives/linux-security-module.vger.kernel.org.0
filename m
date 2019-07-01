Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43C857E14
	for <lists+linux-security-module@lfdr.de>; Thu, 27 Jun 2019 10:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfF0ISi (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 27 Jun 2019 04:18:38 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43186 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfF0ISh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 04:18:37 -0400
Received: by mail-vs1-f68.google.com with SMTP id j26so1039378vsn.10
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 01:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V2MLU2hoUroTx93WcuuGvq0jI4DMgmgoOD2dvEuNFM0=;
        b=vDqsgOZUO4t/77JyofO51bRsfleRu3emD864BLmbTNlTzBjp08buIVwfoWQIj8UF8w
         a/GDAwughka9b0RP4CdHo7oDKQ5e396QIt97MSLy/xPJ8oz9tikIeScaFYjVQc7LfdB+
         PklPaIMJFf5H4ZIQE+A8cOYF+JmvCgyiPbugCL0ySdeWOdBuipAq5yWwvhBpyaJCH9HF
         osTv9+U7Jq0piUIFo6uyqEv3ZyHeNysQJuecHX6cS+i+zqjvN2EJn5Gww5k7XNwocWYo
         JAGREF1X/pylp5aCcC7fvbNZzLiOngOTa28AoVxLJQ3IqQNQGZ8puaMIvYwRPltRnctC
         dTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V2MLU2hoUroTx93WcuuGvq0jI4DMgmgoOD2dvEuNFM0=;
        b=G5IP6sIpUwvxCNEtPdGXFsnMwb2trftE7Kn5eYVcrrh1f1T8k2ooFvRRI7BjXbuvkj
         ZNUUOWsTszwCMRyy90ItTyV/WG2wWd27cJbeUeQZJXvvKMBEav9ZMneHczdLYxg/vFjQ
         o/hdy1QeGt3RG3ED/28E0lgwjyvS32HoaXKmrueNkvZ5urYWhs6AQnhHGY/MBVk/KDg5
         64iCIqLVPsmiu17DlOqihXLdN6lMHlMKr8Lo4qJ9BOglvWVn9UkZON4vi4RnLVq50UF9
         BZulmKC7OPvDutxSkt0jVVCHfVNVftKOJuFjA15h8kylwjFkM3eZgTF56JfB3BgCPqif
         9OPQ==
X-Gm-Message-State: APjAAAUp5CpxCq972iw5LvmOkG6PxqhOtrqnPM0x17GTEVaiZj10F5i9
        izZJT2q1WmhGaR8toej7AktZ6ax2rzTM28ICKTGahQ==
X-Google-Smtp-Source: APXvYqxy0Otv31rVuzhr/H25iAskFoUefHFO0n/k2UglqXTkgr07oBKYdS9OxnXbMOqUyFn21OsN3moWk+ayWLygSwk=
X-Received: by 2002:a67:e98f:: with SMTP id b15mr1819530vso.209.1561623515952;
 Thu, 27 Jun 2019 01:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190626121943.131390-1-glider@google.com> <20190626121943.131390-2-glider@google.com>
 <1561572949.5154.81.camel@lca.pw>
In-Reply-To: <1561572949.5154.81.camel@lca.pw>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 27 Jun 2019 10:18:24 +0200
Message-ID: <CAG_fn=XdjZ8otqJgtg01SxN9KTT3PVfvt1SmQZhk=rcguQ2ryQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Hocko <mhocko@kernel.org>,
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
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 26, 2019 at 8:15 PM Qian Cai <cai@lca.pw> wrote:
>
> On Wed, 2019-06-26 at 14:19 +0200, Alexander Potapenko wrote:
> > The new options are needed to prevent possible information leaks and
> > make control-flow bugs that depend on uninitialized values more
> > deterministic.
> >
> > This is expected to be on-by-default on Android and Chrome OS. And it
> > gives the opportunity for anyone else to use it under distros too via
> > the boot args. (The init_on_free feature is regularly requested by
> > folks where memory forensics is included in their threat models.)
> >
> > init_on_alloc=3D1 makes the kernel initialize newly allocated pages and=
 heap
> > objects with zeroes. Initialization is done at allocation time at the
> > places where checks for __GFP_ZERO are performed.
> >
> > init_on_free=3D1 makes the kernel initialize freed pages and heap objec=
ts
> > with zeroes upon their deletion. This helps to ensure sensitive data
> > doesn't leak via use-after-free accesses.
> >
> > Both init_on_alloc=3D1 and init_on_free=3D1 guarantee that the allocato=
r
> > returns zeroed memory. The two exceptions are slab caches with
> > constructors and SLAB_TYPESAFE_BY_RCU flag. Those are never
> > zero-initialized to preserve their semantics.
> >
> > Both init_on_alloc and init_on_free default to zero, but those defaults
> > can be overridden with CONFIG_INIT_ON_ALLOC_DEFAULT_ON and
> > CONFIG_INIT_ON_FREE_DEFAULT_ON.
> >
> > If either SLUB poisoning or page poisoning is enabled, we disable
> > init_on_alloc and init_on_free so that initialization doesn't interfere
> > with debugging.
> >
> > Slowdown for the new features compared to init_on_free=3D0,
> > init_on_alloc=3D0:
> >
> > hackbench, init_on_free=3D1:  +7.62% sys time (st.err 0.74%)
> > hackbench, init_on_alloc=3D1: +7.75% sys time (st.err 2.14%)
> >
> > Linux build with -j12, init_on_free=3D1:  +8.38% wall time (st.err 0.39=
%)
> > Linux build with -j12, init_on_free=3D1:  +24.42% sys time (st.err 0.52=
%)
> > Linux build with -j12, init_on_alloc=3D1: -0.13% wall time (st.err 0.42=
%)
> > Linux build with -j12, init_on_alloc=3D1: +0.57% sys time (st.err 0.40%=
)
> >
> > The slowdown for init_on_free=3D0, init_on_alloc=3D0 compared to the
> > baseline is within the standard error.
> >
> > The new features are also going to pave the way for hardware memory
> > tagging (e.g. arm64's MTE), which will require both on_alloc and on_fre=
e
> > hooks to set the tags for heap objects. With MTE, tagging will have the
> > same cost as memory initialization.
> >
> > Although init_on_free is rather costly, there are paranoid use-cases wh=
ere
> > in-memory data lifetime is desired to be minimized. There are various
> > arguments for/against the realism of the associated threat models, but
> > given that we'll need the infrastructure for MTE anyway, and there are
> > people who want wipe-on-free behavior no matter what the performance co=
st,
> > it seems reasonable to include it in this series.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Acked-by: Kees Cook <keescook@chromium.org>
> > To: Andrew Morton <akpm@linux-foundation.org>
> > To: Christoph Lameter <cl@linux.com>
> > To: Kees Cook <keescook@chromium.org>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Kostya Serebryany <kcc@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Sandeep Patil <sspatil@android.com>
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Qian Cai <cai@lca.pw>
> > Cc: linux-mm@kvack.org
> > Cc: linux-security-module@vger.kernel.org
> > Cc: kernel-hardening@lists.openwall.com
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  v2:
> >   - unconditionally initialize pages in kernel_init_free_pages()
> >   - comment from Randy Dunlap: drop 'default false' lines from
> > Kconfig.hardening
> >  v3:
> >   - don't call kernel_init_free_pages() from memblock_free_pages()
> >   - adopted some Kees' comments for the patch description
> >  v4:
> >   - use NULL instead of 0 in slab_alloc_node() (found by kbuild test ro=
bot)
> >   - don't write to NULL object in slab_alloc_node() (found by Android
> >     testing)
> >  v5:
> >   - adjusted documentation wording as suggested by Kees
> >   - disable SLAB_POISON if auto-initialization is on
> >   - don't wipe RCU cache allocations made without __GFP_ZERO
> >   - dropped SLOB support
> >  v7:
> >   - rebase the patch, added the Acked-by: tag
> >  v8:
> >   - addressed comments by Michal Hocko: revert kernel/kexec_core.c and
> >     apply initialization in dma_pool_free()
> >   - disable init_on_alloc/init_on_free if slab poisoning or page
> >     poisoning are enabled, as requested by Qian Cai
> >   - skip the redzone when initializing a freed heap object, as requeste=
d
> >     by Qian Cai and Kees Cook
> >   - use s->offset to address the freeptr (suggested by Kees Cook)
> >   - updated the patch description, added Signed-off-by: tag
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  9 +++
> >  drivers/infiniband/core/uverbs_ioctl.c        |  2 +-
> >  include/linux/mm.h                            | 22 ++++++
> >  mm/dmapool.c                                  |  4 +-
> >  mm/page_alloc.c                               | 71 +++++++++++++++++--
> >  mm/slab.c                                     | 16 ++++-
> >  mm/slab.h                                     | 19 +++++
> >  mm/slub.c                                     | 43 +++++++++--
> >  net/core/sock.c                               |  2 +-
> >  security/Kconfig.hardening                    | 29 ++++++++
> >  10 files changed, 199 insertions(+), 18 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > b/Documentation/admin-guide/kernel-parameters.txt
> > index 138f6664b2e2..84ee1121a2b9 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1673,6 +1673,15 @@
> >
> >       initrd=3D         [BOOT] Specify the location of the initial
> > ramdisk
> >
> > +     init_on_alloc=3D  [MM] Fill newly allocated pages and heap
> > objects with
> > +                     zeroes.
> > +                     Format: 0 | 1
> > +                     Default set by CONFIG_INIT_ON_ALLOC_DEFAULT_ON.
> > +
> > +     init_on_free=3D   [MM] Fill freed pages and heap objects with
> > zeroes.
> > +                     Format: 0 | 1
> > +                     Default set by CONFIG_INIT_ON_FREE_DEFAULT_ON.
> > +
> >       init_pkru=3D      [x86] Specify the default memory protection key=
s
> > rights
> >                       register contents for all processes.  0x55555554 =
by
> >                       default (disallow access to all but pkey 0).  Can
> > diff --git a/drivers/infiniband/core/uverbs_ioctl.c
> > b/drivers/infiniband/core/uverbs_ioctl.c
> > index 829b0c6944d8..61758201d9b2 100644
> > --- a/drivers/infiniband/core/uverbs_ioctl.c
> > +++ b/drivers/infiniband/core/uverbs_ioctl.c
> > @@ -127,7 +127,7 @@ __malloc void *_uverbs_alloc(struct uverbs_attr_bun=
dle
> > *bundle, size_t size,
> >       res =3D (void *)pbundle->internal_buffer + pbundle->internal_used=
;
> >       pbundle->internal_used =3D
> >               ALIGN(new_used, sizeof(*pbundle->internal_buffer));
> > -     if (flags & __GFP_ZERO)
> > +     if (want_init_on_alloc(flags))
> >               memset(res, 0, size);
> >       return res;
> >  }
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index dd0b5f4e1e45..96be2604f313 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2696,6 +2696,28 @@ static inline void kernel_poison_pages(struct pa=
ge
> > *page, int numpages,
> >                                       int enable) { }
> >  #endif
> >
> > +#ifdef CONFIG_INIT_ON_ALLOC_DEFAULT_ON
> > +DECLARE_STATIC_KEY_TRUE(init_on_alloc);
> > +#else
> > +DECLARE_STATIC_KEY_FALSE(init_on_alloc);
> > +#endif
> > +static inline bool want_init_on_alloc(gfp_t flags)
> > +{
> > +     if (static_branch_unlikely(&init_on_alloc))
> > +             return true;
> > +     return flags & __GFP_ZERO;
> > +}
> > +
> > +#ifdef CONFIG_INIT_ON_FREE_DEFAULT_ON
> > +DECLARE_STATIC_KEY_TRUE(init_on_free);
> > +#else
> > +DECLARE_STATIC_KEY_FALSE(init_on_free);
> > +#endif
> > +static inline bool want_init_on_free(void)
> > +{
> > +     return static_branch_unlikely(&init_on_free);
> > +}
> > +
> >  extern bool _debug_pagealloc_enabled;
> >
> >  static inline bool debug_pagealloc_enabled(void)
>
> Do those really necessary need to be static keys?
Yes. Initially they weren't, but using static branches saved us a few %%.

> Adding either init_on_free=3D0 or init_on_alloc=3D0 to the kernel cmdline=
 will
> generate a warning with kernels built with clang.
Looks like Kees has taken care of this issue in his "arm64: Move
jump_label_init() before parse_early_param()"
Thanks Kees!
> [    0.000000] static_key_disable(): static key 'init_on_free+0x0/0x4' us=
ed
> before call to jump_label_init()
> [    0.000000] WARNING: CPU: 0 PID: 0 at ./include/linux/jump_label.h:317
> early_init_on_free+0x1c0/0x200
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.2.0-rc6-next-201=
90626+
> #9
> [    0.000000] pstate: 60000089 (nZCv daIf -PAN -UAO)
> [    0.000000] pc : early_init_on_free+0x1c0/0x200
> [    0.000000] lr : early_init_on_free+0x1c0/0x200
> [    0.000000] sp : ffff100012c07df0
> [    0.000000] x29: ffff100012c07e20 x28: ffff1000110a01ec
> [    0.000000] x27: 000000000000005f x26: ffff100011716cd0
> [    0.000000] x25: ffff100010d36166 x24: ffff100010d3615d
> [    0.000000] x23: ffff100010d364b5 x22: ffff1000117164a0
> [    0.000000] x21: 0000000000000000 x20: 0000000000000000
> [    0.000000] x19: 0000000000000000 x18: 000000000000002e
> [    0.000000] x17: 000000000000000f x16: 0000000000000040
> [    0.000000] x15: 0000000000000000 x14: 6c61632065726f66
> [    0.000000] x13: 6562206465737520 x12: 273478302f307830
> [    0.000000] x11: 0000000000000000 x10: 0000000000000000
> [    0.000000] x9 : 0000000000000000 x8 : 0000000000000000
> [    0.000000] x7 : 6d756a206f74206c x6 : ffff100014426625
> [    0.000000] x5 : ffff100012c07b28 x4 : 0000000000000007
> [    0.000000] x3 : ffff1000101aadf4 x2 : 0000000000000001
> [    0.000000] x1 : 0000000000000001 x0 : 000000000000005d
> [    0.000000] Call trace:
> [    0.000000]  early_init_on_free+0x1c0/0x200
> [    0.000000]  do_early_param+0xd0/0x104
> [    0.000000]  parse_args+0x1f0/0x524
> [    0.000000]  parse_early_param+0x70/0x8c
> [    0.000000]  setup_arch+0xa8/0x268
> [    0.000000]  start_kernel+0x80/0x560
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
