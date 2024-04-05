Return-Path: <linux-security-module+bounces-2556-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7AE89A3EE
	for <lists+linux-security-module@lfdr.de>; Fri,  5 Apr 2024 20:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C65286536
	for <lists+linux-security-module@lfdr.de>; Fri,  5 Apr 2024 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A56E171E60;
	Fri,  5 Apr 2024 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cyL7wMZ6"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21988171E54
	for <linux-security-module@vger.kernel.org>; Fri,  5 Apr 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340945; cv=none; b=sqCtcaMJ8X0J7jEiiDguWwqr8OksHnzZbnEQglwM5VGbfn+n1CvdTX81Jr5wu5XvwPTfEGSDC/khGBnoKBgDsurPcPRS1fyZAgcD1e0c0Aiy7VUwKUHsi4U7U6VdBW1jQ3lFZPwV03psLJ9TvJgNZ/NrhrSmkxGo+FPCRsBcBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340945; c=relaxed/simple;
	bh=kiwUCEjPx78g1bk35VucSw6ptQJmiUDwfINeVgK5ces=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAQCFGC+arX/4Dz3fwBdnX+GcPZ11RsVY+vIPivkLUV357Fn1qY3fvT90ytERA/o13gGLqOS/LEIp6ghkUc9x1F40hMecVMfE0bV04e7jjoPWGLCwkpqfrMmPOjITGpT1GY+mWTfSYwkIWKHfCaGLl7xa/o0jibthFN/BFGroRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cyL7wMZ6; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VB60H71S8z7Qf;
	Fri,  5 Apr 2024 20:07:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712340463;
	bh=kiwUCEjPx78g1bk35VucSw6ptQJmiUDwfINeVgK5ces=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cyL7wMZ6fGr++bxregCQEm29qB3fuZgv653iTA9GW51TcUaqXfg7KmuPDuTqcUkKe
	 SfxMZxvEY0inVS2JBEN5QQq9vmLag7zRP8f7AnAnC7axhKSIoC8dmhYmcienEPkhH2
	 tyIzl9AeQHADN+6Mrz57ceiG7iQq9xIzLG1VEUcM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VB60G5glFzpnt;
	Fri,  5 Apr 2024 20:07:42 +0200 (CEST)
Date: Fri, 5 Apr 2024 20:07:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	James Morris <jamorris@linux.microsoft.com>, Kees Cook <keescook@chromium.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
	Marco Pagani <marpagan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thara Gopinath <tgopinath@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v4 0/7] Handle faults in KUnit tests
Message-ID: <20240405.pahc6aiX9ahx@digikod.net>
References: <20240326095118.126696-1-mic@digikod.net>
 <60d96894-a146-4ebb-b6d0-e1988a048c64@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60d96894-a146-4ebb-b6d0-e1988a048c64@linuxfoundation.org>
X-Infomaniak-Routing: alpha

On Fri, Apr 05, 2024 at 10:08:00AM -0600, Shuah Khan wrote:
> On 3/26/24 03:51, Mickaël Salaün wrote:
> > Hi,
> > 
> > This patch series teaches KUnit to handle kthread faults as errors, and
> > it brings a few related fixes and improvements.
> > 
> > Shuah, everything should be OK now, could you please merge this series?
> 
> Please cc linux-kselftest and kunit mailing lists. You got the world cc'ed
> except for the important ones. :)

Indeed, I don't know how I missed that... Do you want me to send it
again?

> 
> thanks,
> -- Shuah
> 

