Return-Path: <linux-security-module+bounces-1779-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B886E94F
	for <lists+linux-security-module@lfdr.de>; Fri,  1 Mar 2024 20:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FCE2878E5
	for <lists+linux-security-module@lfdr.de>; Fri,  1 Mar 2024 19:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17DF39AF4;
	Fri,  1 Mar 2024 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ekdE8C1Y"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFC739AF3
	for <linux-security-module@vger.kernel.org>; Fri,  1 Mar 2024 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320582; cv=none; b=E4kBiDZwmE0bXbEWOvIKPGo3WDG8pACy6JDe+joFurnyrtcofugRnygmeEgTJNFx2uCjG6ZDONbK/3Grd9Dt2BFUvGdlZKNIbZ2cj9Xe3GuCvdJ6kA+KHif6SoEpfBv2ocKBal6QhASZlPSmP6vhpGQ+C8LJGU4UeEU7qIqGJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320582; c=relaxed/simple;
	bh=Q7fU6Ub3q+6YxoCBFaoEp7a/GqkOwDsLuYbxuGhGrJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O29G2lrpn68uR/EzApYwU1HdywVTNs6dm5KNwvWKk13PYZJnpAbCnUqZ8Ld6iTyxtV3HjLOfpkwvxzaEiOHHME6uyxnsnzO5jhdnJ6FbpTh5X3jmpp59bLbRwHmw/AoGyxuXjGi8s6ulybgZsksqrz3wAFo3ndoE0JWV2HV6wJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ekdE8C1Y; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tmd9Y1VK2zXyj;
	Fri,  1 Mar 2024 20:16:17 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tmd9W6JqCzpmw;
	Fri,  1 Mar 2024 20:16:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709320577;
	bh=Q7fU6Ub3q+6YxoCBFaoEp7a/GqkOwDsLuYbxuGhGrJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekdE8C1Ycehc5cU0FFdPBLOQIWYuuwCoAVIcd6blq2ECeRFY83hIegduUPkzETJSJ
	 1aED213nnnjEoQbHieGvuKeSAmm8UB1bPBZPlrobr+nQOfkOfTvxMUACoi0q1XEtyO
	 1h134Jafh7/zywAVozq8HQY0K0a+ZnyoDROUVHAo=
Date: Fri, 1 Mar 2024 20:16:05 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <keescook@chromium.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	James Morris <jamorris@linux.microsoft.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Thara Gopinath <tgopinath@microsoft.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>, Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v1 8/8] kunit: Add tests for faults
Message-ID: <20240301.aekiung2aL7K@digikod.net>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-9-mic@digikod.net>
 <202402291027.6F0E4994@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202402291027.6F0E4994@keescook>
X-Infomaniak-Routing: alpha

On Thu, Feb 29, 2024 at 10:28:18AM -0800, Kees Cook wrote:
> On Thu, Feb 29, 2024 at 06:04:09PM +0100, Mickaël Salaün wrote:
> > The first test checks NULL pointer dereference and make sure it would
> > result as a failed test.
> > 
> > The second and third tests check that read-only data is indeed read-only
> > and trying to modify it would result as a failed test.
> > 
> > This kunit_x86_fault test suite is marked as skipped when run on a
> > non-x86 native architecture.  It is then skipped on UML because such
> > test would result to a kernel panic.
> > 
> > Tested with:
> > ./tools/testing/kunit/kunit.py run --arch x86_64 kunit_x86_fault
> > 
> > Cc: Brendan Higgins <brendanhiggins@google.com>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Rae Moar <rmoar@google.com>
> > Cc: Shuah Khan <skhan@linuxfoundation.org>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> 
> If we can add some way to collect WARN/BUG output for examination, I
> could rewrite most of LKDTM in KUnit! I really like this!

Thanks!  About the WARN/BUG examination, I guess the easier way would be
to do in in user space by extending kunit_parser.py.

> 
> > ---
> >  lib/kunit/kunit-test.c | 115 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 114 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> > index f7980ef236a3..57d8eff00c66 100644
> > --- a/lib/kunit/kunit-test.c
> > +++ b/lib/kunit/kunit-test.c
> > @@ -10,6 +10,7 @@
> >  #include <kunit/test-bug.h>
> >  
> >  #include <linux/device.h>
> > +#include <linux/init.h>
> >  #include <kunit/device.h>
> >  
> >  #include "string-stream.h"
> > @@ -109,6 +110,117 @@ static struct kunit_suite kunit_try_catch_test_suite = {
> >  	.test_cases = kunit_try_catch_test_cases,
> >  };
> >  
> > +#ifdef CONFIG_X86
> 
> Why is this x86 specific?

Because I didn't test on other architecture, and it looks it crashed on
arm64. :)

I'll test on arm64 and change this condition with !CONFIG_UML.

> 
> -- 
> Kees Cook
> 

