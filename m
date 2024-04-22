Return-Path: <linux-security-module+bounces-2800-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F89B8ACDDC
	for <lists+linux-security-module@lfdr.de>; Mon, 22 Apr 2024 15:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EFB1C2113C
	for <lists+linux-security-module@lfdr.de>; Mon, 22 Apr 2024 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75CA150984;
	Mon, 22 Apr 2024 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XaC5f4gj"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F9E14F13C
	for <linux-security-module@vger.kernel.org>; Mon, 22 Apr 2024 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791346; cv=none; b=iildFQn5HOZm+JieucDGOd4r9J4c+imnlv8K+k1n8fH62sZ3kVZFDy0tG84IJrJGzBjDyWDOwTZXR8+EDCt0EXD4EREE+58qqwF8ar365ubSp1KkgKUbEVMRI1VeZUvUneoetQ/QTje3goexg/zKBeBh4bErBCgvs5kKKLdy8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791346; c=relaxed/simple;
	bh=GjhTJjoSiC3IDIVXzgKQ4P+qNveHUQ6lI+EgnHlfUqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQtDONeke/EgG2Mc/+svcfghTfu6KZrQbwETSNt0NHsNmS/bVViGQDXClOex0f6kAo7bwyL6PefUsi2m5ZydR9azV/aH0PmlzOn2J5cBZGLV4IM65MOdX2saVNfMxQyogTxnxlAp8McT1GB/qIcDGhH80Fo2XP/QS7zOToC+NZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XaC5f4gj; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VNQYc6JShz3q7;
	Mon, 22 Apr 2024 15:08:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1713791332;
	bh=GjhTJjoSiC3IDIVXzgKQ4P+qNveHUQ6lI+EgnHlfUqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XaC5f4gjQmTg7HWgvo8OaBYgvZVVaUnv+Y6B/jdsg0Q4f2OLDr4AYla0dAr871yUg
	 SXigC7/aA4mp4zabDYUfQYwz/kj2V8GznfSGfeIslpVajiSP9OYd5T8+9TTpiL7YOt
	 axM86vO0S3TpXTEvr00XTnMRotQwMoJZqzDgMjqE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VNQYb16q2zrw3;
	Mon, 22 Apr 2024 15:08:50 +0200 (CEST)
Date: Mon, 22 Apr 2024 15:08:50 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Guenter Roeck <linux@roeck-us.net>, David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, James Morris <jamorris@linux.microsoft.com>, 
	Kees Cook <keescook@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Thara Gopinath <tgopinath@microsoft.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>, Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 7/7] kunit: Add tests for fault
Message-ID: <20240422.thesh7quoo0U@digikod.net>
References: <20240319104857.70783-1-mic@digikod.net>
 <20240319104857.70783-8-mic@digikod.net>
 <928249cc-e027-4f7f-b43f-502f99a1ea63@roeck-us.net>
 <b70332b0-3e55-4375-935f-35ef3167a151@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b70332b0-3e55-4375-935f-35ef3167a151@roeck-us.net>
X-Infomaniak-Routing: alpha

On Fri, Apr 19, 2024 at 04:38:01PM -0700, Guenter Roeck wrote:
> On Fri, Apr 19, 2024 at 03:33:49PM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > On Tue, Mar 19, 2024 at 11:48:57AM +0100, Mickaël Salaün wrote:
> > > Add a test case to check NULL pointer dereference and make sure it would
> > > result as a failed test.
> > > 
> > > The full kunit_fault test suite is marked as skipped when run on UML
> > > because it would result to a kernel panic.
> > > 
> > > Tested with:
> > > ./tools/testing/kunit/kunit.py run --arch x86_64 kunit_fault
> > > ./tools/testing/kunit/kunit.py run --arch arm64 \
> > >   --cross_compile=aarch64-linux-gnu- kunit_fault
> > > 
> > 
> > What is the rationale for adding those tests unconditionally whenever
> > CONFIG_KUNIT_TEST is enabled ? This completely messes up my test system
> > because it concludes that it is pointless to continue testing
> > after the "Unable to handle kernel NULL pointer dereference" backtrace.
> > At the same time, it is all or nothing, meaning I can not disable
> > it but still run other kunit tests.
> > 

CONFIG_KUNIT_TEST is to test KUnit itself.  Why does this messes up your
test system, and what is your test system?  Is it related to the kernel
warning and then the message you previously sent?
https://lore.kernel.org/r/fd604ae0-5630-4745-acf2-1e51c69cf0c0@roeck-us.net
It seems David has a solution to suppress such warning.

> 
> Oh, never mind. I just disabled CONFIG_KUNIT_TEST in my test bed
> to "solve" the problem. I'll take that as one of those "unintended
> consequences" items: Instead of more tests, there are fewer.
> 
> Guenter
> 

