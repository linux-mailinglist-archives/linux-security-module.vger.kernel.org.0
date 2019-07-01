Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C417433D6C
	for <lists+linux-security-module@lfdr.de>; Tue,  4 Jun 2019 05:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfFDDOJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 3 Jun 2019 23:14:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42615 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDDOJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Jun 2019 23:14:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so1554808pff.9
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2019 20:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c5HP5Me6K1D1zdUUO0f7kzVFOIQyYSbiNswjCmfwwdM=;
        b=O7cjrefYDb8qdY6xHlr7GQJ9p1Q5FyScv3e2w+vscGV9dmLj3ZLW9f5Pf+78Vl8cuW
         0jy0uX2DCPP14kq0gZIICMmiy5PCkk1FdQ8qsJt5mI6MDzj6VECvJfWif7Wo3c2QjgSS
         u7igduXfvXL5/BBTot/FruOSt3YvXQO0ax1VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c5HP5Me6K1D1zdUUO0f7kzVFOIQyYSbiNswjCmfwwdM=;
        b=UEvjToiMwQUZO81wJZUdvGUFh8E/1ldhuhEIqYkU1CrAvpvSXe/n9S0CtqT8lW/H2H
         pd+TbBNxPUfxPOEdaNCEQzY7buzv+YvD/EHF4YINNJKWdN6OVWQHANBFScnQpzEC/LEv
         EJ0X4F9sLCyCo61x/uiJxtfpDSVhWPIdhK7peM0g/RYYGcRflH58W6fyPcSazuKV2sEt
         gAbmeqAWQvPsBcYeQ5KsSOHT97mKyGzs6q96pehnHPYagLmRVdi8oyNTdJHYSEB6MlPv
         ID5FwNFn7RjOBgPlrkjnyfKplh/SULvXDub35R16A6yjsRMKP/fonoxjT3ZOJ4ul5DAr
         z4cQ==
X-Gm-Message-State: APjAAAVERPvT5Z5A3vEH/07dVVz3ExXJAY2pYaAz2Q/i6m7IdTvsEDIl
        MsZ96CsIngbxf5sQPIkuIq0KHw==
X-Google-Smtp-Source: APXvYqyr65yqSMgjUZyLKXrBeCQLIR7WRh1PgCOxNwDSym495N0oGFV/Y355onNEh2hWQW9f50Nt2g==
X-Received: by 2002:a17:90a:35c:: with SMTP id 28mr33030091pjf.110.1559618048938;
        Mon, 03 Jun 2019 20:14:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v4sm3118023pfb.14.2019.06.03.20.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 20:14:07 -0700 (PDT)
Date:   Mon, 3 Jun 2019 20:14:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sandeep Patil <sspatil@android.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Marco Elver <elver@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] mm: init: report memory auto-initialization
 features at boot time
Message-ID: <201906032010.8E630B7@keescook>
References: <20190529123812.43089-1-glider@google.com>
 <20190529123812.43089-3-glider@google.com>
 <20190531181832.e7c3888870ce9e50db9f69e6@linux-foundation.org>
 <CAG_fn=XBq-ipvZng3hEiGwyQH2rRNFbN_Cj0r+5VoJqou0vovA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XBq-ipvZng3hEiGwyQH2rRNFbN_Cj0r+5VoJqou0vovA@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 03, 2019 at 11:24:49AM +0200, Alexander Potapenko wrote:
> On Sat, Jun 1, 2019 at 3:18 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 29 May 2019 14:38:11 +0200 Alexander Potapenko <glider@google.com> wrote:
> >
> > > Print the currently enabled stack and heap initialization modes.
> > >
> > > The possible options for stack are:
> > >  - "all" for CONFIG_INIT_STACK_ALL;
> > >  - "byref_all" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL;
> > >  - "byref" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF;
> > >  - "__user" for CONFIG_GCC_PLUGIN_STRUCTLEAK_USER;
> > >  - "off" otherwise.
> > >
> > > Depending on the values of init_on_alloc and init_on_free boottime
> > > options we also report "heap alloc" and "heap free" as "on"/"off".
> >
> > Why?
> >
> > Please fully describe the benefit to users so that others can judge the
> > desirability of the patch.  And so they can review it effectively, etc.
> I'm going to update the description with the following passage:
> 
>     Print the currently enabled stack and heap initialization modes.
> 
>     Stack initialization is enabled by a config flag, while heap
>     initialization is configured at boot time with defaults being set
>     in the config. It's more convenient for the user to have all information
>     about these hardening measures in one place.
> 
> Does this make sense?
> > Always!
> >
> > > In the init_on_free mode initializing pages at boot time may take some
> > > time, so print a notice about that as well.
> >
> > How much time?
> I've seen pauses up to 1 second, not actually sure they're worth a
> separate line in the log.
> Kees, how long were the delays in your case?

I didn't measure it, but I think it was something like 0.5 second per GB.
I noticed because normally boot flashes by. With init_on_free it pauses
for no apparent reason, which is why I suggested the note. (I mean *I*
knew why it was pausing, but it might surprise someone who sets
init_on_free=1 without really thinking about what's about to happen at
boot.)

-- 
Kees Cook
