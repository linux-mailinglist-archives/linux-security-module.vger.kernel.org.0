Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF26EFCF
	for <lists+linux-security-module@lfdr.de>; Tue, 30 Apr 2019 07:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfD3FDo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 30 Apr 2019 01:03:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37442 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfD3FDn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Apr 2019 01:03:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id y5so2269263wma.2;
        Mon, 29 Apr 2019 22:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uJMhjgb5zxPxkYouwBqnhllNEC+efi0qURt/Ty+nHUo=;
        b=FyOMuExG82iTN6oz4qYVha+B3bpp5KXoEGFM4poaUXkHBlgm4D3jxK7KjJ1WCC7u07
         GfhX3l0TgtL+N2ryxbvIoWI3p1mxnodj/Gelgl4MB/iStPTMl3C216nBQ1OLYcr9LWv7
         f9fJWLRRPGlb9ehm9AItbG1ZRg/359MY24IeY0nSQ6+65n4LVYcFXp8uB5wYJ+6F0VWy
         clD3PWaTfJpPV2gF9rfpz1DradCzkf4vFbiN+Pob75PEbuLEvulxANn/CoifX47ttGIG
         UF5u7Wmog/KSABmwpt5wW/dQSGtG1HMX7sUsv5I2Zkq4bmwyhySw83vE7B6toFKDVF67
         szkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uJMhjgb5zxPxkYouwBqnhllNEC+efi0qURt/Ty+nHUo=;
        b=YVatzHLDedn0k+xiCesuiYo6FasJmVpXFcPa71mO4qJTEJe6tTduirWrjIfAkmHCfd
         zkMpd3fK0SLjKZQQNTSaknjh4YGx8OAYdAeTv1jtpIqj7zePbx/ir+X5ApZGPhcx97mF
         0t9dX13V6dGs+3o1IHrkca1pvIOMPqVCJWASupRln2rioc1fBi+vBXyiEWuBIfmgCOsd
         orlmC4RS0fVxFxrLKemIHAj0jeyWgk5IRIE0j4YcdSwEU/A7ULAhEnuUUSEVnFq+i7XB
         dz2xLEeW94b32E4vPxzsRLwVka2y0LtzrVkIA81b2mIhrVa19NgVS//BQlW4BnXRgcZR
         vQFg==
X-Gm-Message-State: APjAAAUgyZi3VTn9dqFqv3Vu9Z2brftl2YPTPJtuL+RM0J3kNL038n6K
        cCQO0yYcZDv2jpHsdS9Accg=
X-Google-Smtp-Source: APXvYqwIr1Hdnaga2YnCv7mTHEVJtWQOAcNEnI7VSaNz5v1406HQx408Ikkg4gOEKA7FxbiBmbab6A==
X-Received: by 2002:a1c:a851:: with SMTP id r78mr1628659wme.36.1556600620617;
        Mon, 29 Apr 2019 22:03:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a4sm1224745wmf.45.2019.04.29.22.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 22:03:39 -0700 (PDT)
Date:   Tue, 30 Apr 2019 07:03:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call
 isolation
Message-ID: <20190430050336.GA92357@gmail.com>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com>
 <20190426083144.GA126896@gmail.com>
 <20190426095802.GA35515@gmail.com>
 <CALCETrV3xZdaMn_MQ5V5nORJbcAeMmpc=gq1=M9cmC_=tKVL3A@mail.gmail.com>
 <20190427084752.GA99668@gmail.com>
 <20190427104615.GA55518@gmail.com>
 <CALCETrUn_86VAd8FGacJ169xcWE6XQngAMMhvgd1Aa6ZxhGhtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUn_86VAd8FGacJ169xcWE6XQngAMMhvgd1Aa6ZxhGhtA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


* Andy Lutomirski <luto@kernel.org> wrote:

> On Sat, Apr 27, 2019 at 3:46 AM Ingo Molnar <mingo@kernel.org> wrote:

> > So I'm wondering whether there's a 4th choice as well, which avoids
> > control flow corruption *before* it happens:
> >
> >  - A C language runtime that is a subset of current C syntax and
> >    semantics used in the kernel, and which doesn't allow access outside
> >    of existing objects and thus creates a strictly enforced separation
> >    between memory used for data, and memory used for code and control
> >    flow.
> >
> >  - This would involve, at minimum:
> >
> >     - tracking every type and object and its inherent length and valid
> >       access patterns, and never losing track of its type.
> >
> >     - being a lot more organized about initialization, i.e. no
> >       uninitialized variables/fields.
> >
> >     - being a lot more strict about type conversions and pointers in
> >       general.
> 
> You're not the only one to suggest this.  There are at least a few
> things that make this extremely difficult if not impossible.  For
> example, consider this code:
> 
> void maybe_buggy(void)
> {
>   int a, b;
>   int *p = &a;
>   int *q = (int *)some_function((unsigned long)p);
>   *q = 1;
> }
> 
> If some_function(&a) returns &a, then all is well.  But if
> some_function(&a) returns &b or even a valid address of some unrelated
> kernel object, then the code might be entirely valid and correct C,
> but I don't see how the runtime checks are supposed to tell whether
> the resulting address is valid or is a bug.  This type of code is, I
> think, quite common in the kernel -- it happens in every data
> structure where we have unions of pointers and integers or where we
> steal some known-zero bits of a pointer to store something else.

So the thing is, for the infinitely large state space of "valid C code" 
we already disallow an infinitely many versions in the Linux kernel.

We have complicated rules that disallow certain C syntactical and 
semantical constructs, both on the tooling (build failure/warning) and on 
the review (style/taste) level.

So the question IMHO isn't whether it's "valid C", because we already 
have the Linux kernel's own C syntax variant and are enforcing it with 
varying degrees of success.

The question is whether the example you gave can be written in a strongly 
typed fashion, whether it makes sense to do so, and what the costs are.

I think it's evident that it can be written with strongly typed 
constructs, by separating pointers from embedded error codes - with 
negative side effects to code generation: for example it increases 
structure sizes and error return paths.

I think there's four main costs of converting such a pattern to strongly 
typed constructs:

 - memory/cache footprint:  there's a nonzero cost there.
 - performance:             this will hurt too.
 - code readability:        this will probably improve.
 - code robustness:         this will improve too.

So I think the proper question to ask is not whether there's common C 
syntax within the kernel that would have to be rewritten, but whether the 
total sum of memory and runtime overhead of strongly typed C programming 
(if it's possible/desirable) is larger than the total sum of a typical 
Linux distro enabling the various current and proposed kernel hardening 
features that have a runtime overhead:

 - the SMAP/SMEP overhead of STAC/CLAC for every single user copy

 - other usercopy hardening features

 - stackprotector

 - KASLR

 - compiler plugins against information leaks

 - proposed KASLR extension to implement module randomization and -PIE overhead

 - proposed function call integrity checks

 - proposed per system call kernel stack offset randomization

 - ( and I'm sure I forgot about a few more, and it's all still only 
     reactive security, not proactive security. )

That's death by a thousand cuts and CR3 switching during system calls is 
also throwing a hand grenade into the fight ;-)

So if people are also proposing to do CR3 switches in every system call, 
I'm pretty sure the answer is "yes, even a managed C runtime is probably 
faster than *THAT* sum of a performanc mess" - at least with the current 
CR3 switching x86-uarch cost structure...

Thanks,

	Ingo
