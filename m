Return-Path: <linux-security-module+bounces-10053-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8526FABC74F
	for <lists+linux-security-module@lfdr.de>; Mon, 19 May 2025 20:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55DB4A242D
	for <lists+linux-security-module@lfdr.de>; Mon, 19 May 2025 18:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA601F0E3A;
	Mon, 19 May 2025 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Z9VguicZ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D211F0984
	for <linux-security-module@vger.kernel.org>; Mon, 19 May 2025 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747680092; cv=none; b=KhIEsbOCJGlnwNyYfMpc2A/z69pWFxQLKzjQyUBxH59Gf3rSNeBaPFUMQ+bf/PRIhJRJ6Um+QHyVKjGnT54oZ3Suo4w/mvOwqEn3Gd6F13npRK4mW7KIoF8weFKOpBt+aGoGIndwkqy1cigqqTLekgmd4le/1nrXicoX4nsLDuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747680092; c=relaxed/simple;
	bh=4Z59AKzz+eO6sGliOCRqj0Hx4FCMMrVoC0DOqtzg23k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBOaJYboPg+RCX7a7Nr9M4CJomAK0/d9KaS/hypnU9V1NEOmc7uX+QrX9dJPLxINMsXuBt6HK5hlCzzznt4RnGCUTH1oo6JFNXIRp5K7x8D3yuLOueY39nJW+c3g3lqrREUiV+jVTfozx0f5FmYGH2kZXticaqdTA6v1tmK1FgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Z9VguicZ; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b1RNH66Xnz1YF;
	Mon, 19 May 2025 20:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1747680079;
	bh=EdZ8+ewZFjqKaifXz4RXBYGfJUWMvYYk96HqDLHav5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9VguicZy4yfrtrVf0iQI0Qd7r6QnIJlK9fjduoMrPVrMnxbxtv9XYBj0DXCYqI4c
	 m9x1NMV8D2SYmcRMGC8yqfa84QY7IVErYUlBDgQGlNDUZDOx/V60QYGtka/17xRLf2
	 dhOEovSV0rA3PnzAT5Kop6bGsq5qtb5S6qZjoO3A=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b1RNG0MMxzgRd;
	Mon, 19 May 2025 20:41:18 +0200 (CEST)
Date: Mon, 19 May 2025 20:41:17 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-security-module@vger.kernel.org, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: linux-next: Tree for May 16 (security/landlock/ruleset.c)
Message-ID: <20250519.ba8eoZu3XaeJ@digikod.net>
References: <20250516202417.31b13d13@canb.auug.org.au>
 <e3754f69-1dea-4542-8de0-a567a14fb95b@infradead.org>
 <20250519.jiveise8Rau8@digikod.net>
 <202505191117.C094A90F88@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202505191117.C094A90F88@keescook>
X-Infomaniak-Routing: alpha

On Mon, May 19, 2025 at 11:19:53AM -0700, Kees Cook wrote:
> On Mon, May 19, 2025 at 05:29:30PM +0200, Mickaël Salaün wrote:
> > On Fri, May 16, 2025 at 07:54:14PM -0700, Randy Dunlap wrote:
> > > 
> > > 
> > > On 5/16/25 3:24 AM, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > Changes since 20250515:
> > 
> > Thanks for the report.
> > 
> > It is the same warning as reported here:
> > https://lore.kernel.org/all/202501040747.S3LYfvYq-lkp@intel.com/
> > 
> > I don't know what the actual issue is though.
> > 
> > > 
> > > on i386:
> > > 
> > > In file included from ../arch/x86/include/asm/string.h:3,
> > >                  from ../include/linux/string.h:65,
> > >                  from ../include/linux/bitmap.h:13,
> > >                  from ../include/linux/cpumask.h:12,
> > >                  from ../include/linux/smp.h:13,
> > >                  from ../include/linux/lockdep.h:14,
> > >                  from ../security/landlock/ruleset.c:16:
> > > ../security/landlock/ruleset.c: In function 'create_rule':
> > > ../arch/x86/include/asm/string_32.h:150:25: warning: '__builtin_memcpy' accessing 4294967295 bytes at offsets 20 and 0 overlaps 6442450943 bytes at offset -2147483648 [-Wrestrict]
> > >   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
> > >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > ../security/landlock/ruleset.c:137:9: note: in expansion of macro 'memcpy'
> > >   137 |         memcpy(new_rule->layers, layers,
> > >       |         ^~~~~~
> > > 
> > > 
> > > Full randconfig file is attached.
> 
> The trigger appears to be CONFIG_PROFILE_ALL_BRANCHES, and GCC getting
> tricked into thinking check_mul_overflow() returns true:
> 
> In file included from ../arch/x86/include/asm/string.h:3,
>                  from ../include/linux/string.h:65,
>                  from ../include/linux/bitmap.h:13,
>                  from ../include/linux/cpumask.h:12,
>                  from ../include/linux/smp.h:13,
>                  from ../include/linux/lockdep.h:14,
>                  from ../security/landlock/ruleset.c:16:
> ../security/landlock/ruleset.c: In function 'create_rule':
> ../arch/x86/include/asm/string_32.h:150:25: warning: '__builtin_memcpy' accessing 4294967295 bytes at offsets 0 and 0 overlaps 6442450943 bytes at offset -2147483648 [-Wrestrict]
>   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> ../security/landlock/ruleset.c:137:9: note: in expansion of macro 'memcpy'
>   137 |         memcpy(new_rule->layers, layers,
>       |         ^~~~~~
>   'create_rule': event 1
> ../include/linux/compiler.h:69:46:
>    68 |         (cond) ?                                        \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    69 |                 (__if_trace.miss_hit[1]++,1) :          \
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
>       |                                              |
>       |                                              (1) when the condition is evaluated to true
>    70 |                 (__if_trace.miss_hit[0]++,0);           \
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
> ../include/linux/compiler.h:57:69: note: in expansion of macro '__trace_if_value'
>    57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>       |                                                                     ^~~~~~~~~~~~~~~~
> ../include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
>    55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>       |                            ^~~~~~~~~~~~~~
> ../include/linux/overflow.h:270:9: note: in expansion of macro 'if'
>   270 |         if (check_mul_overflow(factor1, factor2, &bytes))
>       |         ^~
>   'create_rule': event 2
> ../arch/x86/include/asm/string_32.h:150:25:
>   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>       |                         |
>       |                         (2) out of array bounds here
> ../security/landlock/ruleset.c:137:9: note: in expansion of macro 'memcpy'
>   137 |         memcpy(new_rule->layers, layers,
>       |         ^~~~~~
> make[1]: Leaving directory '/srv/code/gcc-bug'

That's interesting...

> 
> 
> I'll take a look at ways to make either the overflow macros or memcpy
> robust against this kind of weirdness...

Thanks!

> 
> -- 
> Kees Cook
> 

