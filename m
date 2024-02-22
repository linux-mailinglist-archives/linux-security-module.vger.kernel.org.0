Return-Path: <linux-security-module+bounces-1621-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8B8860050
	for <lists+linux-security-module@lfdr.de>; Thu, 22 Feb 2024 19:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBE4289D78
	for <lists+linux-security-module@lfdr.de>; Thu, 22 Feb 2024 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D7155A39;
	Thu, 22 Feb 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JyKBbDev"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2423118657;
	Thu, 22 Feb 2024 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624993; cv=none; b=IzrXhhmDI+L9vqSnMHR87INl9r37q0sBKX3P8fY9RDWWPZGrW3MeU/0o4d8CXLJpBNd/9vGHu3ItCZDEeK5Q6/FVa6QfscxQV6ELXyhAlKYRYc3+FIGEuvVMaT5G3qycV7PkxwsSHDA9Z0TfreiNax55Zo2T6Pjp2GJZTiy1tTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624993; c=relaxed/simple;
	bh=eWIgrng0fomPV+v6ms8u6IZCYZ5GywPfM/uBGfotOyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcG9OPhom+G6NN+vP9A6BY4bB10E4jKncT4qU3lHcSO0/ZMMr4Z/idaBMX5wD82klVkOYq9iU9mlMQOoxFIili4KiGphZY99rcu9SvqmAquldoMw/cxRqWTwjBMQtyA3zPysQFceh/ROWfFyFqTFhQBL9R6F1vP9wAqqmwPDPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JyKBbDev; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708624991; x=1740160991;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eWIgrng0fomPV+v6ms8u6IZCYZ5GywPfM/uBGfotOyI=;
  b=JyKBbDev1Sd21eLt0tVADK+fBhzTmDtmf99xVkKeZNLCnlawo2B1uYoQ
   ov1mH7wqLvoeivBEhtR+Kgrdyd/8o16hFRtjLWoOn8WC/oExpaQoq2vDv
   L0hbl4RvubUYE5wdUfEQ1x/Uqm5Bm6EfT+xgI3eqCRmOzimtpGa5k7XXd
   mh8+0aeGSkx/5Ht9oGHMsMz6DxUrbXWQq7fechcj+kX1x5fg+qSQtbdTa
   C7556YEN6oUNvI0sFLj3AUR5fAGBUfzc8uXk9au0QeZkjmR7tNFxVnEVS
   bRgksN1wNY+9fmhGq6bX8LOioln3asR/hPIhe+PYRQDEQZ10KNvxMKGhA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3010774"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3010774"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:03:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10188836"
Received: from jwbates1-mobl.amr.corp.intel.com (HELO [10.209.48.22]) ([10.209.48.22])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:03:05 -0800
Message-ID: <5de7d665-7047-497b-94fb-76ec2af3c9e2@intel.com>
Date: Thu, 22 Feb 2024 10:03:03 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] sbm: fix up calls to dynamic memory allocators
Content-Language: en-US
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Xin Li <xin3.li@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kees Cook <keescook@chromium.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Pengfei Xu <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ze Gao <zegao2021@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Brian Gerst <brgerst@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <jroedel@suse.de>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
 <20240222131230.635-1-petrtesarik@huaweicloud.com>
 <20240222131230.635-5-petrtesarik@huaweicloud.com>
 <f6135f2c-bc8f-41c3-9c6a-8346d685e4dc@intel.com>
 <20240222185744.509e4958@meshulam.tesarici.cz>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240222185744.509e4958@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/22/24 09:57, Petr Tesařík wrote:
> * Hardware designers are adding (other) hardware security defenses to
>   ring-0 that are not applied to ring-3.
> 
>   Could you give an example of these other security defenses, please?

Here's one example:

> https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/data-dependent-prefetcher.html

"DDP is neither trained by nor triggered by supervisor-mode accesses."

But seriously, this is going to be my last message on this topic.  I
appreciate your enthusiasm, but I don't see any viable way forward for
this approach.

