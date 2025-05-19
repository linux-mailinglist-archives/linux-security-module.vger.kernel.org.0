Return-Path: <linux-security-module+bounces-10052-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7343ABC700
	for <lists+linux-security-module@lfdr.de>; Mon, 19 May 2025 20:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A951B60BAC
	for <lists+linux-security-module@lfdr.de>; Mon, 19 May 2025 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B111EF0BE;
	Mon, 19 May 2025 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgY69Bxp"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9843171D2;
	Mon, 19 May 2025 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678798; cv=none; b=ulGObdJ2VPGdpUL+020tKaIOqNDV0FZhdeKMHMfOcjViTt+VxhqfQ5KLBwRK7eZ0FeJP22gQNx3zqjBWZe05MJWDRe0MLAQiynE+41PengpyifkIwCWODQNlYqNsLG0ccRw+Cd5htnezsOH2HYlcLqNh6qv+WB8rsIExk+t88rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678798; c=relaxed/simple;
	bh=Kmxs929ZOWp5SNI8oGlYhKZHAd9hzey0D1QNUWF3RgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvoPn2e0mjkrhyr4kSc59lMk16cNQ1LYfDZOOWFJbjB1kPmEqcRg4xiVtaBgDDzUYlFqNkunwzPwj5g5xoT505jwl+7gUDInbOBcOF1idnVAVnhCCMs1+oMvSe0nq7NNlIwI6Q7hZVnaDsy+aeKgKzd1gOpEFuTCgPHv4UYvS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgY69Bxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B97C4CEE4;
	Mon, 19 May 2025 18:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747678796;
	bh=Kmxs929ZOWp5SNI8oGlYhKZHAd9hzey0D1QNUWF3RgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JgY69Bxpk8AB1cILkkJz4CG7zJR5luHUNFhoERMmkl6OheX7U5QK1c42iQk8QQI4U
	 fkEUGwySu+xY0JGEhEwhtzVaDImXqaiBNJ0i7fQd0I/lpQSDd6W+eUyJyusu/8aUCt
	 LKbV/pJizCJ4cOxOK8WRFbplqE44G+8hYLZ3SK37TOQPQrnIy2DGF0dWZc74cdtQ/1
	 C/Fx7IMt9bxIbUwJmhzBgVad/pkY1RBDVSMbkkOI2Y6P5qpTjJTBR53gdNOeU9j1P6
	 /+EkQzWXO1G2VQcOMJgtdLNwj5SXyFf+5XrNay5rX5Y/kHP/eJ6SqjaqmECuy0Fbth
	 SiribDQorXD3Q==
Date: Mon, 19 May 2025 11:19:53 -0700
From: Kees Cook <kees@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-security-module@vger.kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Subject: Re: linux-next: Tree for May 16 (security/landlock/ruleset.c)
Message-ID: <202505191117.C094A90F88@keescook>
References: <20250516202417.31b13d13@canb.auug.org.au>
 <e3754f69-1dea-4542-8de0-a567a14fb95b@infradead.org>
 <20250519.jiveise8Rau8@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250519.jiveise8Rau8@digikod.net>

On Mon, May 19, 2025 at 05:29:30PM +0200, Micka�l Sala�n wrote:
> On Fri, May 16, 2025 at 07:54:14PM -0700, Randy Dunlap wrote:
> > 
> > 
> > On 5/16/25 3:24 AM, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20250515:
> 
> Thanks for the report.
> 
> It is the same warning as reported here:
> https://lore.kernel.org/all/202501040747.S3LYfvYq-lkp@intel.com/
> 
> I don't know what the actual issue is though.
> 
> > 
> > on i386:
> > 
> > In file included from ../arch/x86/include/asm/string.h:3,
> >                  from ../include/linux/string.h:65,
> >                  from ../include/linux/bitmap.h:13,
> >                  from ../include/linux/cpumask.h:12,
> >                  from ../include/linux/smp.h:13,
> >                  from ../include/linux/lockdep.h:14,
> >                  from ../security/landlock/ruleset.c:16:
> > ../security/landlock/ruleset.c: In function 'create_rule':
> > ../arch/x86/include/asm/string_32.h:150:25: warning: '__builtin_memcpy' accessing 4294967295 bytes at offsets 20 and 0 overlaps 6442450943 bytes at offset -2147483648 [-Wrestrict]
> >   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> > ../security/landlock/ruleset.c:137:9: note: in expansion of macro 'memcpy'
> >   137 |         memcpy(new_rule->layers, layers,
> >       |         ^~~~~~
> > 
> > 
> > Full randconfig file is attached.

The trigger appears to be CONFIG_PROFILE_ALL_BRANCHES, and GCC getting
tricked into thinking check_mul_overflow() returns true:

In file included from ../arch/x86/include/asm/string.h:3,
                 from ../include/linux/string.h:65,
                 from ../include/linux/bitmap.h:13,
                 from ../include/linux/cpumask.h:12,
                 from ../include/linux/smp.h:13,
                 from ../include/linux/lockdep.h:14,
                 from ../security/landlock/ruleset.c:16:
../security/landlock/ruleset.c: In function 'create_rule':
../arch/x86/include/asm/string_32.h:150:25: warning: '__builtin_memcpy' accessing 4294967295 bytes at offsets 0 and 0 overlaps 6442450943 bytes at offset -2147483648 [-Wrestrict]
  150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
../security/landlock/ruleset.c:137:9: note: in expansion of macro 'memcpy'
  137 |         memcpy(new_rule->layers, layers,
      |         ^~~~~~
  'create_rule': event 1
../include/linux/compiler.h:69:46:
   68 |         (cond) ?                                        \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   69 |                 (__if_trace.miss_hit[1]++,1) :          \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
      |                                              |
      |                                              (1) when the condition is evaluated to true
   70 |                 (__if_trace.miss_hit[0]++,0);           \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
../include/linux/compiler.h:57:69: note: in expansion of macro '__trace_if_value'
   57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
      |                                                                     ^~~~~~~~~~~~~~~~
../include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
   55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
      |                            ^~~~~~~~~~~~~~
../include/linux/overflow.h:270:9: note: in expansion of macro 'if'
  270 |         if (check_mul_overflow(factor1, factor2, &bytes))
      |         ^~
  'create_rule': event 2
../arch/x86/include/asm/string_32.h:150:25:
  150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
      |                         |
      |                         (2) out of array bounds here
../security/landlock/ruleset.c:137:9: note: in expansion of macro 'memcpy'
  137 |         memcpy(new_rule->layers, layers,
      |         ^~~~~~
make[1]: Leaving directory '/srv/code/gcc-bug'


I'll take a look at ways to make either the overflow macros or memcpy
robust against this kind of weirdness...

-- 
Kees Cook

