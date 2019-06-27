Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD558322
	for <lists+linux-security-module@lfdr.de>; Thu, 27 Jun 2019 15:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfF0NJU (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 27 Jun 2019 09:09:20 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42290 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0NJU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 09:09:20 -0400
Received: by mail-ua1-f67.google.com with SMTP id a97so806622uaa.9
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+GEy0GowFU+uQq8TtB0z8xaih9ptN5Q3IEiqpuelFDs=;
        b=EMPAztyeJD8w4tcBaVeombkZujMeYNTsJ7eaSZC9f/YoNsl84xyhDO4M73FyMmjA/x
         t5N4V/SYNJGu8aRCWbdfkZuL0gmN6Wgsx5IiESN3D5cmEWh1+qccSYhaDxN/fjQrz5Jj
         Cmx2Loy9qjuSXQ4c1Xk6qnfHtYBKzCGdneCzQmv777wUvbWV+GjeS64FIN8TGVu5kjI3
         cB8Y4DCxGroHXSrRmB1f6VKjKprKpC5G6gqTdPHTtnquOGPC1Bg5sg8J02NNcNrwL5Ku
         Y7AExdNBks6Anahq3UGPKqAJm/MXezvkzfSwn+pSQixXTQgFZClv7wnEHCzFUPX1MZUn
         6o4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+GEy0GowFU+uQq8TtB0z8xaih9ptN5Q3IEiqpuelFDs=;
        b=Fu1ql19IvPnZQJt7XYXwV+mRN+QIRaz504/iiAPB+B8xmz3krRtO/14qlzRXz4OiG+
         VBCz6ZPr8DE6g9TyQSZh2trLbOGoN2SfWa8yUN4hhAIF7tmnrHhGFT/ihxULmi7OpsKt
         ZFtymo+bCNRcvs+lmXklBruxiapu6Z7Hchz97qZkzRO6HrBjPcije6pjAn2LOUf6QYsv
         5LME0nOhsm6v1E4GOsSOsYBNBbLILWOMA1qCYs3hbu8rsFMJ8LN1gY2TEB/v2puiHIjI
         JLis8Eee6h1Iqt7mmUGeUWrrw674tXJvnac3XLCsuFwNUQXYjywZZJigUch9RPaEmo+V
         uJgg==
X-Gm-Message-State: APjAAAWYUq+RagKoD4l0+PvLWa2zf7Dq/6VFesAOJ5VUyBV0JAjLHUXu
        l8ZR9TwSgn3AW7E91FnsGDsBjFKAb7ujEN2YOQhIZw==
X-Google-Smtp-Source: APXvYqyybVeF02FV7oyRIEy9deXhVNP2OXv1ccgGnq0QB34Ix3HStMP+1vnMzbMN3do7c59wTe80K7fkjXUNi2zvrCQ=
X-Received: by 2002:ab0:3d2:: with SMTP id 76mr2215849uau.12.1561640958978;
 Thu, 27 Jun 2019 06:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190626121943.131390-1-glider@google.com> <20190626121943.131390-2-glider@google.com>
 <20190626144943.GY17798@dhcp22.suse.cz> <CAG_fn=Xf5yEuz7JyOt-gmNx1uSM6mmM57_jFxCi+9VPZ4PSwJQ@mail.gmail.com>
 <20190626154237.GZ17798@dhcp22.suse.cz>
In-Reply-To: <20190626154237.GZ17798@dhcp22.suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 27 Jun 2019 15:09:06 +0200
Message-ID: <CAG_fn=V4SZwu50LCZq+2Fa-zAZmQ+X-80vxzN-MGJZdjpFpjhw@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] mm: security: introduce init_on_alloc=1 and
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
        Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 26, 2019 at 5:42 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 26-06-19 17:00:43, Alexander Potapenko wrote:
> > On Wed, Jun 26, 2019 at 4:49 PM Michal Hocko <mhocko@kernel.org> wrote:
> [...]
> > > > @@ -1142,6 +1200,8 @@ static __always_inline bool free_pages_prepar=
e(struct page *page,
> > > >       }
> > > >       arch_free_page(page, order);
> > > >       kernel_poison_pages(page, 1 << order, 0);
> > > > +     if (want_init_on_free())
> > > > +             kernel_init_free_pages(page, 1 << order);
> > >
> > > same here. If you don't want to make this exclusive then you have to
> > > zero before poisoning otherwise you are going to blow up on the poiso=
n
> > > check, right?
> > Note that we disable initialization if page poisoning is on.
>
> Ohh, right. Missed that in the init code.
>
> > As I mentioned on another thread we can eventually merge this code
> > with page poisoning, but right now it's better to make the user decide
> > which of the features they want instead of letting them guess how the
> > combination of the two is going to work.
>
> Strictly speaking zeroying is a subset of poisoning. If somebody asks
> for both the poisoning surely satisfies any data leak guarantees
> zeroying would give. So I am not sure we have to really make them
> exclusive wrt. to the configuraion. I will leave that to you but it
> would be better if the code didn't break subtly once the early init
> restriction is removed for one way or another. So either always make
> sure that zeroying is done _before_ poisoning or that you do not zero
> when poisoning. The later sounds the best wrt. the code quality from my
> POV.
I somewhat liked the idea of always having zero-initialized page/heap
memory if init_on_{alloc,free} is on.
But in production mode we won't have page or slab poisoning anyway,
and for debugging this doesn't really matter much.
I've sent v9 with poisoning support added.
> --
> Michal Hocko
> SUSE Labs



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
