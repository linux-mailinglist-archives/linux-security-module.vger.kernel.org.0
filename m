Return-Path: <linux-security-module+bounces-3663-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 093328FA702
	for <lists+linux-security-module@lfdr.de>; Tue,  4 Jun 2024 02:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B35DB2273E
	for <lists+linux-security-module@lfdr.de>; Tue,  4 Jun 2024 00:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B78801;
	Tue,  4 Jun 2024 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2KK4FGe"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E964C69
	for <linux-security-module@vger.kernel.org>; Tue,  4 Jun 2024 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717461016; cv=none; b=uw4cJxC4HAWJsMl46XIL5bof6M4F2/Jauaq9uOPVfHTRldDjL69t9uI1wBt6pFSHvs89b+rjFibiolq+PJUqUoYVjn5mNENBthV5rD4ThUAlmzIMzWYqtuLJmqbYIBRE7V/ArfAJL388rj8oH84c9k5nE8FgR29TaHY4ziNTaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717461016; c=relaxed/simple;
	bh=bvM0pADJsf/ny8qy1qpxXNEPBHi9kStugKigbeIsfP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RYnCjgxhAc8biEmZOV1h3EN6QPH+ygq4NZw6SxRj6pZ253OeN6HkJZkDPF8gFmkkOJZRL/sIODmJ/7R7uBUUzgXE8L1xPyYjfQ+/X4yMRcdRXxtSkpew8rtsV7unJKxK67BQiY7gyAe0MN8nN15HpTZVqht7FhqYU8eSWm9uTaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m2KK4FGe; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c1ad0f8aa2so4308823a91.0
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2024 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717461015; x=1718065815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxZAvQthUOLtrgNKYUD6oiL7rAnsVeqwoSoZowsNkW0=;
        b=m2KK4FGe9BT/QQ/yEsgjs4ak7dheQP+1HG++Sqie8fp8fTVNWg11en94TXwZkLYUk+
         jY7JfL4SZf+2m/7ZAueFnpMCGEHcgQQq9X5O19Qs2lVbTdPOiBifVAQJ2JANykfyB9Lw
         j8qcfFSLww12UeSqwh24V/n/beXQwD6jUG8V07kLld87un/QeM1ao4h5gpUdzXsXbQW9
         JZzu9g+UDVfwbIhFjfA12LU2YTmlpzE9u5Ano0uTZ749Hy2QPYw6SKlZKkyf1BOoNMDE
         8DwtD8HfPLBRzdYT42zNtIesT5Ojgx68zbNXcUO5g7PCZrUit3dsGKBUNJNk3/jMNGmN
         bIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717461015; x=1718065815;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qxZAvQthUOLtrgNKYUD6oiL7rAnsVeqwoSoZowsNkW0=;
        b=DAHxwfTcS+Kebyp+BrYClQc0kyhV4pJNO0EV3JOGlnk/IfWUHOjRRf5BOwu4UtO7Y9
         t0/KHp+Ez1Z+7FNd2ie3mnjmTQXCcsXxvlIquePQKqEnzP04rXwZYH/vgcEjsQ0lfhZd
         Rk1S/m85NO+KGF63EAV3xz27kP/qaAMdJNOhCbuk/2sYJhsa+W/gTnJsK3Ybf7qj0Khw
         ROhi4FGwHZUhu6z/vB+sKiJQF0sK04BfaJ007cI0d/MZkfMntXwzXPWc0cstKmrlLCPR
         nKAtN5XdR/G184d4G/c0mcVR84qf6v9H8A1MWeDhYm7ztfVPQsEPgTu6qLVIP7D+s1cv
         UTiA==
X-Forwarded-Encrypted: i=1; AJvYcCXf2gltMvKRNDVA7KSPZ5jWzRt9n4D4jLFpZicB3uARgyKiuhFCA7VeTswd6dUUNRrbYnT4qDc8CDRJHyuU6KN5qMdVo+8xXu4tKdBV+8LQWWWY9z/d
X-Gm-Message-State: AOJu0YwXOhIS3HI4qrz4rQSjo/MuWsB8VOM0ZlNDPWCnaDStzR7fAnQm
	QqkebZLccvVPnmoqWLuAgE9WIFZbsMitijihHkka4z7PbBQm4ZloVRs+xlTOnfnm3mnUtEARMx8
	sCw==
X-Google-Smtp-Source: AGHT+IHQGaBTeBmAnXtOHPKtCDExst6sxM2uUbRh6POZbhCe3IxNIvO17m1N9WlbQ/aSMCylqTV+FPzEOtI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2c86:b0:2c1:aa8e:13cb with SMTP id
 98e67ed59e1d1-2c1dc5e0ab2mr29758a91.9.1717461014195; Mon, 03 Jun 2024
 17:30:14 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:30:12 -0700
In-Reply-To: <20240603.ahNg8waif6Fu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503131910.307630-4-mic@digikod.net> <ZjTuqV-AxQQRWwUW@google.com>
 <20240506.ohwe7eewu0oB@digikod.net> <ZjmFPZd5q_hEBdBz@google.com>
 <20240507.ieghomae0UoC@digikod.net> <ZjpTxt-Bxia3bRwB@google.com>
 <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com> <20240514.mai3Ahdoo2qu@digikod.net>
 <ZkUb2IWj4Z9FziCb@google.com> <20240603.ahNg8waif6Fu@digikod.net>
Message-ID: <Zl5gFMJp3nECJVW-@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>, 
	Angelina Vu <angelinavu@linux.microsoft.com>, 
	Anna Trikalinou <atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
	James Morris <jamorris@linux.microsoft.com>, John Andersen <john.s.andersen@intel.com>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, 
	"Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
	"=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>, Thara Gopinath <tgopinath@microsoft.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	"=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>, dev@lists.cloudhypervisor.org, 
	kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
	virtualization@lists.linux-foundation.org, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> On Wed, May 15, 2024 at 01:32:24PM -0700, Sean Christopherson wrote:
> > On Tue, May 14, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> > > On Fri, May 10, 2024 at 10:07:00AM +0000, Nicolas Saenz Julienne wrot=
e:
> > > > Development happens
> > > > https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-n=
ext
> > > > branch, but I'd advice against looking into it until we add some or=
der
> > > > to the rework. Regardless, feel free to get in touch.
> > >=20
> > > Thanks for the update.
> > >=20
> > > Could we schedule a PUCK meeting to synchronize and help each other?
> > > What about June 12?
> >=20
> > June 12th works on my end.
>=20
> Can you please send an invite?

I think this is all the info?

Time:  6am PDT
Video: https://meet.google.com/vdb-aeqo-knk
Phone: https://tel.meet/vdb-aeqo-knk?pin=3D3003112178656

Calendar: https://calendar.google.com/calendar/u/0?cid=3DY182MWE1YjFmNjQ0Nz=
M5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb=
3VwLmNhbGVuZGFyLmdvb2dsZS5jb20
Drive:    https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986S=
ngGlhPH?resourcekey=3D0-FDy0ykM3RerZedI8R-zj4A&usp=3Ddrive_link

