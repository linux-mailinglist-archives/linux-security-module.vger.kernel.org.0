Return-Path: <linux-security-module+bounces-3648-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E22F8D88C0
	for <lists+linux-security-module@lfdr.de>; Mon,  3 Jun 2024 20:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F34A1C22E71
	for <lists+linux-security-module@lfdr.de>; Mon,  3 Jun 2024 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABBA1386D2;
	Mon,  3 Jun 2024 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xgOLEnz6"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F91386CF
	for <linux-security-module@vger.kernel.org>; Mon,  3 Jun 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439980; cv=none; b=XEIsqDQJs2i5Zsot2envNWwKOVS6+v+XZNNlDoTUVEWi4HDpOL84wmjfhdVc3dj4BsljAiPTgmakC9cb/dSXXOastK3JTLzi9LOZH3vTTXj7qEJLLjqxRZP4OEF7bvnqJpDcguzKOS83zfoAHTw8SACLtfqROwtitqNO6RjS1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439980; c=relaxed/simple;
	bh=45DMRn2FH77YelrORvqcFvTIqhXAmUJq7b7LNS71ris=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYl4JcglcHal5GqDCxDMdultYXJu/uZJqmozKJc3apGtD0sGmtAeo/6mA4sfCDsrdIE6a5FDSB6CJBkTircjxGftASBXjbBo2AhojIY4y5J0KVYftr5kHUW3BYmyHpHW/W/pxK4i/QpE9Rbfb3iBEXpuWaU7z2JUGZSqxBTmwQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xgOLEnz6; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VtMvh6qFGzbqD;
	Mon,  3 Jun 2024 20:39:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1717439968;
	bh=gtIaPUDSXyeON8s2CCg1DgIhDlLJpeFMkqvOS8MasVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xgOLEnz6SJcIhFjVsyAJkws+cB0hDF1vBl5UhdAnMFZ3IwIv9+mfJG3z/z022GaLC
	 hucCNjddaf0O63psa6tLWOQ3L5xKcN9U7KIay9a2JpyiZ7tPESeMWs+1ppcAXahNNL
	 fGKNj5z+dog4VQDnEUOYMq6wUCsWbim9yiLiW2VQ=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VtMvf5T4yz1Y3;
	Mon,  3 Jun 2024 20:39:26 +0200 (CEST)
Date: Mon, 3 Jun 2024 20:39:24 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Sean Christopherson <seanjc@google.com>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Alexander Graf <graf@amazon.com>, Angelina Vu <angelinavu@linux.microsoft.com>, 
	Anna Trikalinou <atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
	James Morris <jamorris@linux.microsoft.com>, John Andersen <john.s.andersen@intel.com>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, 
	Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>, =?utf-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>, 
	Thara Gopinath <tgopinath@microsoft.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, =?utf-8?Q?=C8=98tefan_=C8=98icleru?= <ssicleru@bitdefender.com>, 
	dev@lists.cloudhypervisor.org, kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, 
	x86@kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
Message-ID: <20240603.ahNg8waif6Fu@digikod.net>
References: <20240503131910.307630-1-mic@digikod.net>
 <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com>
 <20240506.ohwe7eewu0oB@digikod.net>
 <ZjmFPZd5q_hEBdBz@google.com>
 <20240507.ieghomae0UoC@digikod.net>
 <ZjpTxt-Bxia3bRwB@google.com>
 <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com>
 <20240514.mai3Ahdoo2qu@digikod.net>
 <ZkUb2IWj4Z9FziCb@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkUb2IWj4Z9FziCb@google.com>
X-Infomaniak-Routing: alpha

On Wed, May 15, 2024 at 01:32:24PM -0700, Sean Christopherson wrote:
> On Tue, May 14, 2024, Mickaël Salaün wrote:
> > On Fri, May 10, 2024 at 10:07:00AM +0000, Nicolas Saenz Julienne wrote:
> > > Development happens
> > > https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-next
> > > branch, but I'd advice against looking into it until we add some order
> > > to the rework. Regardless, feel free to get in touch.
> > 
> > Thanks for the update.
> > 
> > Could we schedule a PUCK meeting to synchronize and help each other?
> > What about June 12?
> 
> June 12th works on my end.

Can you please send an invite?

 Mickaël

