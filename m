Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D2556DE9
	for <lists+linux-security-module@lfdr.de>; Wed, 26 Jun 2019 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfFZPmk (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 26 Jun 2019 11:42:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:42370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbfFZPmk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jun 2019 11:42:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB564ABD9;
        Wed, 26 Jun 2019 15:42:38 +0000 (UTC)
Date:   Wed, 26 Jun 2019 17:42:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Potapenko <glider@google.com>
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
Subject: Re: [PATCH v8 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <20190626154237.GZ17798@dhcp22.suse.cz>
References: <20190626121943.131390-1-glider@google.com>
 <20190626121943.131390-2-glider@google.com>
 <20190626144943.GY17798@dhcp22.suse.cz>
 <CAG_fn=Xf5yEuz7JyOt-gmNx1uSM6mmM57_jFxCi+9VPZ4PSwJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=Xf5yEuz7JyOt-gmNx1uSM6mmM57_jFxCi+9VPZ4PSwJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed 26-06-19 17:00:43, Alexander Potapenko wrote:
> On Wed, Jun 26, 2019 at 4:49 PM Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > > @@ -1142,6 +1200,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
> > >       }
> > >       arch_free_page(page, order);
> > >       kernel_poison_pages(page, 1 << order, 0);
> > > +     if (want_init_on_free())
> > > +             kernel_init_free_pages(page, 1 << order);
> >
> > same here. If you don't want to make this exclusive then you have to
> > zero before poisoning otherwise you are going to blow up on the poison
> > check, right?
> Note that we disable initialization if page poisoning is on.

Ohh, right. Missed that in the init code.

> As I mentioned on another thread we can eventually merge this code
> with page poisoning, but right now it's better to make the user decide
> which of the features they want instead of letting them guess how the
> combination of the two is going to work.

Strictly speaking zeroying is a subset of poisoning. If somebody asks
for both the poisoning surely satisfies any data leak guarantees
zeroying would give. So I am not sure we have to really make them
exclusive wrt. to the configuraion. I will leave that to you but it
would be better if the code didn't break subtly once the early init
restriction is removed for one way or another. So either always make
sure that zeroying is done _before_ poisoning or that you do not zero
when poisoning. The later sounds the best wrt. the code quality from my
POV.

-- 
Michal Hocko
SUSE Labs
