Return-Path: <linux-security-module+bounces-10063-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E243CABDDE6
	for <lists+linux-security-module@lfdr.de>; Tue, 20 May 2025 16:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F008D1BA0649
	for <lists+linux-security-module@lfdr.de>; Tue, 20 May 2025 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFDA24BD03;
	Tue, 20 May 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="GUW33kDg"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A424BD1F
	for <linux-security-module@vger.kernel.org>; Tue, 20 May 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752882; cv=none; b=ptIBoClJRPu1v65mufRq2V+vMOHYRpGLuBsLLXddYXDXZZMGJE8HIIzwtj9wJ6vMbWBm8Qt187nqKZg83ouTrueXIRlSDHJy0cogqfUGtjqDHkzHk+XyrLM2NDHNYEcgNGAoYOdEG1NBZIoByywRNZ6jZ5YSVbClft+KqBiygDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752882; c=relaxed/simple;
	bh=OWK0Zt23bPSbE4Ll64xGeV+57pDChH+4wfdXg+cVc3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjrGa52Amz2UdgrOMx7PiStLavfiOmDvl3zY7YvxHvsGkKzXU9vUQEvLxtLsRnzLXq0tIC6W43KT7c8Hx5GcbdQBkk/+ISK0Rzdxo3WPaGu8mg165z9/noOIhgSpqPv5ZIXtGTuI5DlPLMgm5t4AualtHJ/h3grei134iu211M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=GUW33kDg; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b1y5d1xbbz7RK;
	Tue, 20 May 2025 16:45:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1747752325;
	bh=iXHCzy2mvfq2Ah5c6EuTknCOAZP225QNWQ+0yp2MqCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GUW33kDg4zawPBatwVSy4eRcRjatDTSIqFlfaozDG5UBG2OcJ+ffulyqejP0x/R8+
	 hU8kc1HItRcQEMnssiBbQFOumHxomHzA+ylvimYlFgm5On2E6/YcVhan4LMgM8+Z5g
	 rXIz1DgFuSkvv0NTcWgdc2pk2/0BqeQBuLn+OgUM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4b1y5Z3wXyz443;
	Tue, 20 May 2025 16:45:22 +0200 (CEST)
Date: Tue, 20 May 2025 16:45:19 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-security-module@vger.kernel.org, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: linux-next: Tree for May 16 (security/landlock/ruleset.c)
Message-ID: <20250520.uof4li6vac3I@digikod.net>
References: <20250516202417.31b13d13@canb.auug.org.au>
 <e3754f69-1dea-4542-8de0-a567a14fb95b@infradead.org>
 <20250519.jiveise8Rau8@digikod.net>
 <202505191117.C094A90F88@keescook>
 <20250519.ba8eoZu3XaeJ@digikod.net>
 <202505191212.61EE1AE80@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202505191212.61EE1AE80@keescook>
X-Infomaniak-Routing: alpha

On Mon, May 19, 2025 at 12:15:30PM -0700, Kees Cook wrote:
> On Mon, May 19, 2025 at 08:41:17PM +0200, Mickaël Salaün wrote:
> > On Mon, May 19, 2025 at 11:19:53AM -0700, Kees Cook wrote:
> > > On Mon, May 19, 2025 at 05:29:30PM +0200, Mickaël Salaün wrote:
> > > > On Fri, May 16, 2025 at 07:54:14PM -0700, Randy Dunlap wrote:
> > > > > 
> > > > > 
> > > > > On 5/16/25 3:24 AM, Stephen Rothwell wrote:
> > > > > > Hi all,
> > > > > > 
> > > > > > Changes since 20250515:
> > > > 
> > > > Thanks for the report.
> > > > 
> > > > It is the same warning as reported here:
> > > > https://lore.kernel.org/all/202501040747.S3LYfvYq-lkp@intel.com/
> > > > 
> > > > I don't know what the actual issue is though.
> > > > 
> > > > > 
> > > > > on i386:
> > > > > 
> > > > > In file included from ../arch/x86/include/asm/string.h:3,
> > > > >                  from ../include/linux/string.h:65,
> > > > >                  from ../include/linux/bitmap.h:13,
> > > > >                  from ../include/linux/cpumask.h:12,
> > > > >                  from ../include/linux/smp.h:13,
> > > > >                  from ../include/linux/lockdep.h:14,
> > > > >                  from ../security/landlock/ruleset.c:16:
> > > > > ../security/landlock/ruleset.c: In function 'create_rule':
> > > > > ../arch/x86/include/asm/string_32.h:150:25: warning: '__builtin_memcpy' accessing 4294967295 bytes at offsets 20 and 0 overlaps 6442450943 bytes at offset -2147483648 [-Wrestrict]
> > > > >   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
> > > > >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > ../security/landlock/ruleset.c:137:9: note: in expansion of macro 'memcpy'
> > > > >   137 |         memcpy(new_rule->layers, layers,
> > > > >       |         ^~~~~~
> > > > > 
> > > > > 
> > > > > Full randconfig file is attached.
> > > 
> > > The trigger appears to be CONFIG_PROFILE_ALL_BRANCHES, and GCC getting
> > > tricked into thinking check_mul_overflow() returns true:
> > > 
> > > In file included from ../arch/x86/include/asm/string.h:3,
> > >                  from ../include/linux/string.h:65,
> > >                  from ../include/linux/bitmap.h:13,
> > >                  from ../include/linux/cpumask.h:12,
> > >                  from ../include/linux/smp.h:13,
> > >                  from ../include/linux/lockdep.h:14,
> > >                  from ../security/landlock/ruleset.c:16:
> > > ../security/landlock/ruleset.c: In function 'create_rule':
> > > ../arch/x86/include/asm/string_32.h:150:25: warning: '__builtin_memcpy' accessing 4294967295 bytes at offsets 0 and 0 overlaps 6442450943 bytes at offset -2147483648 [-Wrestrict]
> > >   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
> > >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > ../security/landlock/ruleset.c:137:9: note: in expansion of macro 'memcpy'
> > >   137 |         memcpy(new_rule->layers, layers,
> > >       |         ^~~~~~
> > >   'create_rule': event 1
> > > ../include/linux/compiler.h:69:46:
> > >    68 |         (cond) ?                                        \
> > >       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    69 |                 (__if_trace.miss_hit[1]++,1) :          \
> > >       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
> > >       |                                              |
> > >       |                                              (1) when the condition is evaluated to true
> > >    70 |                 (__if_trace.miss_hit[0]++,0);           \
> > >       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
> > > ../include/linux/compiler.h:57:69: note: in expansion of macro '__trace_if_value'
> > >    57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
> > >       |                                                                     ^~~~~~~~~~~~~~~~
> > > ../include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
> > >    55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
> > >       |                            ^~~~~~~~~~~~~~
> > > ../include/linux/overflow.h:270:9: note: in expansion of macro 'if'
> > >   270 |         if (check_mul_overflow(factor1, factor2, &bytes))
> > >       |         ^~
> > >   'create_rule': event 2
> > > ../arch/x86/include/asm/string_32.h:150:25:
> > >   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
> > >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> > >       |                         |
> > >       |                         (2) out of array bounds here
> > > ../security/landlock/ruleset.c:137:9: note: in expansion of macro 'memcpy'
> > >   137 |         memcpy(new_rule->layers, layers,
> > >       |         ^~~~~~
> > > make[1]: Leaving directory '/srv/code/gcc-bug'
> > 
> > That's interesting...
> > 
> > > 
> > > 
> > > I'll take a look at ways to make either the overflow macros or memcpy
> > > robust against this kind of weirdness...
> > 
> > Thanks!
> 
> I'm doing some build testing, but the below patch makes GCC happy.
> Alternatively we could make CONFIG_PROFILE_ALL_BRANCHES=y depend on
> CONFIG_FORTIFY_SOURCE=y ...
> 
> 
> From 6fbf66fdfd0a7dac809b77faafdd72c60112bb8d Mon Sep 17 00:00:00 2001
> From: Kees Cook <kees@kernel.org>
> Date: Mon, 19 May 2025 11:52:06 -0700
> Subject: [PATCH] string.h: Provide basic sanity checks for fallback memcpy()
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Instead of defining memcpy() in terms of __builtin_memcpy() deep
> in arch/x86/include/asm/string_32.h, notice that it is needed up in
> the general string.h, as done with other common C String APIs. This
> allows us to add basic sanity checking for pathological "size"
> arguments to memcpy(). Besides the run-time checking benefit, this
> avoids GCC trying to be very smart about value range tracking[1] when
> CONFIG_PROFILE_ALL_BRANCHES=y but FORTIFY_SOURCE=n.

It works for me but I couldn't reproduce the issue.  I tried with
CONFIG_PROFILE_ALL_BRANCHES=y and CONFIG_FORTIFY_SOURCE=n but it always
works without a warning.  I'm using GCC 15.  Is it specific to a version
of GCC?

> 
> Link: https://lore.kernel.org/all/202505191117.C094A90F88@keescook/ [1]
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202501040747.S3LYfvYq-lkp@intel.com/
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/e3754f69-1dea-4542-8de0-a567a14fb95b@infradead.org/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: "Mickaël Salaün" <mic@digikod.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: <x86@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Cc: <linux-hardening@vger.kernel.org>
> ---
>  arch/x86/include/asm/string_32.h |  6 ------
>  include/linux/string.h           | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
> index e9cce169bb4c..74397c95fa37 100644
> --- a/arch/x86/include/asm/string_32.h
> +++ b/arch/x86/include/asm/string_32.h
> @@ -145,12 +145,6 @@ static __always_inline void *__constant_memcpy(void *to, const void *from,
>  #define __HAVE_ARCH_MEMCPY
>  extern void *memcpy(void *, const void *, size_t);
>  
> -#ifndef CONFIG_FORTIFY_SOURCE
> -
> -#define memcpy(t, f, n) __builtin_memcpy(t, f, n)
> -
> -#endif /* !CONFIG_FORTIFY_SOURCE */
> -
>  #define __HAVE_ARCH_MEMMOVE
>  void *memmove(void *dest, const void *src, size_t n);
>  
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 01621ad0f598..ffcee31a14f9 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_STRING_H_
>  
>  #include <linux/args.h>
> +#include <linux/bug.h>
>  #include <linux/array_size.h>
>  #include <linux/cleanup.h>	/* for DEFINE_FREE() */
>  #include <linux/compiler.h>	/* for inline */
> @@ -390,7 +391,19 @@ static inline const char *kbasename(const char *path)
>  
>  #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
>  #include <linux/fortify-string.h>
> +#else
> +/* Basic sanity checking even without FORTIFY_SOURCE */
> +# ifndef __HAVE_ARCH_MEMCPY
> +#  define memcpy(t, f, n)					\
> +	do {							\
> +		typeof(n) __n = (n);				\
> +		/* Skip impossible sizes. */			\
> +		if (!WARN_ON(__n < 0 || __n == SIZE_MAX))	\
> +			__builtin_memcpy(t, f, __n);		\
> +	} while (0)
> +# endif
>  #endif
> +
>  #ifndef unsafe_memcpy
>  #define unsafe_memcpy(dst, src, bytes, justification)		\
>  	memcpy(dst, src, bytes)
> -- 
> 2.34.1
> 
> 
> 
> -- 
> Kees Cook
> 

