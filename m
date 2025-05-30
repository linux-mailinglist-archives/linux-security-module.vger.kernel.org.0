Return-Path: <linux-security-module+bounces-10254-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C208DAC9730
	for <lists+linux-security-module@lfdr.de>; Fri, 30 May 2025 23:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FA818884BD
	for <lists+linux-security-module@lfdr.de>; Fri, 30 May 2025 21:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADE027C17F;
	Fri, 30 May 2025 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUbH57Gh"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8A27815C
	for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640839; cv=none; b=jo7ZxSVuaNfaBH+la2PXQmvw6cV08TcFoHJNdlMAft1XO1EbbgfdgP3RzC+XaWYS6R2igNY1cr6n/SM7oWty5Qdmb/F3ZHDJb+/zaa/Os3sGRPHLo299FHz4rS/uTBkOUL9ZmiSU0rrcX7qiVxxTTSG9lrkQIoUffRNiZiUaRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640839; c=relaxed/simple;
	bh=Z7WKpPhKd7mJHiCTEIxzxMzKU0sXmJdsDj1mso24f1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecUjIt0WQb8pRqKDCJ1O8xhtHHSB2REa1+Z1HK1FPv/qLr1ITs8NI2U49NHeTha1aK63XUL4HAUGgSc5r/hyEvOAxV7B3/wf7tjzIBfngZeY1zl7KWwhrjZM3DQTp7/7JVYjb/T3P5+i6raJ/QEln5Fy6Qj2ETLeiEgThYgjZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUbH57Gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E07C4CEEE
	for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 21:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748640838;
	bh=Z7WKpPhKd7mJHiCTEIxzxMzKU0sXmJdsDj1mso24f1I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CUbH57Gh6nzgUJ99+owCFgo+gaNNgOgAfcUbvVE8z8mDiqmD4V8Xji/gZ9uJIQmr2
	 v9Xkfor5CB3DDSUWsJK6qR1e+UlVZcl9fakPDAt/uM+4FvGO1ehr2Cv5wske4IxADz
	 YWfBe3AqmxuyQEhDeqf+I2QnVygHZzJrX0mdoXBHvRy1cRNLBKoUavC+mY9CKI91kB
	 5BOHh6ckSxJGBJ83yB0Rv7W6brFIgDZKyZllhv0wpC8tp8ob1zYyAXcL9mKhbAz+yM
	 7oKvvt7dGtt4AJiH+PMDEJOxoVufcg4cUJZoqa3jzECYccX4GZDpaFY0aI04Qxzqr/
	 0bA7HUlCBmKaQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-601f278369bso4956802a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 14:33:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4b4gJ+oQJq2mSm/xTnY2i+sIqShbsZu+YZ+JxGvt821dwaoZmjlRlFIoa/OhLJ7kS64cIFi3p9v/dTCZpp2AT2eeg0y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiUYSqrBvo6N9W3cnJwaUXzPQAB2Qk1v96LDyYa1nCmQ8eaD8I
	aQsq8DH+vEeJgHka1a0pR4ovnfpvchwY655JkEMIkNH5oSF0HgfsZA0L2+VZbd2916QT20ZPs09
	rBQY3DsGpwCJ6La1P+GeIxoPkbVQ7dqQQviMKIAyx
X-Google-Smtp-Source: AGHT+IEoiomH2xYgGJVG4inLYZvCJ8oUWknh2ggGj5CaECJNv5qS5SBtahRajmodHYw6nzOSjeeinboUEh8+afB8z+A=
X-Received: by 2002:a05:6402:35d4:b0:5f8:afab:9e14 with SMTP id
 4fb4d7f45d1cf-6056f4ca160mr4396691a12.28.1748640837494; Fri, 30 May 2025
 14:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com>
 <87iklhn6ed.fsf@microsoft.com> <CACYkzJ75JXUM_C2og+JNtBat5psrEzjsgcV+b74FwrNaDF68nA@mail.gmail.com>
In-Reply-To: <CACYkzJ75JXUM_C2og+JNtBat5psrEzjsgcV+b74FwrNaDF68nA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 30 May 2025 23:33:46 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4NR3bvrggV=AyNPhPyyLWPL40vw5eAyXons_9wwKAFfQ@mail.gmail.com>
X-Gm-Features: AX0GCFtGQtB3ipdEQ_SanW8CiF1ViasTmENp_pdWQyJewmO4rViHBE_RYsALLlE
Message-ID: <CACYkzJ4NR3bvrggV=AyNPhPyyLWPL40vw5eAyXons_9wwKAFfQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] BPF signature verification
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, jarkko@kernel.org, zeffron@riotgames.com, 
	xiyou.wangcong@gmail.com, kysrinivasan@gmail.com, code@tyhicks.com, 
	linux-security-module@vger.kernel.org, roberto.sassu@huawei.com, 
	James.Bottomley@hansenpartnership.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Ignat Korchagin <ignat@cloudflare.com>, Quentin Monnet <qmo@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Anton Protopopov <aspsk@isovalent.com>, Jordan Rome <linux@jordanrome.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Matteo Croce <teknoraver@meta.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 11:32=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> On Fri, May 30, 2025 at 11:19=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> >
> > KP Singh <kpsingh@kernel.org> writes:
> >
>
> [...]
>
> > >
> >
> > And that isn't at odds with the kernel being able to do it nor is it
> > with what I posted.
> >
> > > If your build environment that signs the BPF program is compromised
> > > and can inject arbitrary code, then signing does not help.  Can you
> > > explain what a supply chain attack would look like here?
> > >
> >
> > Most people here can read C code. The number of people that can read
> > ebpf assembly metaprogramming code is much smaller. Compromising clang
> > is one thing, compromising libbpf is another. Your proposal increases
> > the attack surface with no observable benefit. If I was going to leave =
a
> > hard-to-find backdoor into ring0, gen.c would be a fun place to explore
> > doing it. Module and UEFI signature verification code doesn't live
> > inside of GCC or Clang as set of meta-instructions that get emitted, an=
d
> > there are very good reasons for that.
> >
> > Further, since the signature verification code is unique for each and
> > every program it needs to be verified/proved/tested for each and every
> > program. Additionally, since all these checks are being forced outside
> > of the kernel proper, with the insistence of keeping the LSM layer in
> > the dark of the ultimate result, the only way to test that a program
> > will fail if the map is corrupted is to physically corrupt each and
> > every program and test that individually. That isn't "elegant" nor "use=
r
> > friendly" in any way, shape or form.
> >
> > >> subsystem.  Additionally, it is impossible to verify the code
> > >> performing the signature verification, as it is uniquely regenerated
> > >
> > > The LSM needs to ensure that it allows trusted LOADER programs i.e.
> > > with signatures and potentially trusted signed user-space binaries
> > > with unsigned or delegated signing (this will be needed for Cilium an=
d
> > > bpftrace that dynamically generate BPF programs), that's a more
> > > important aspect of the LSM policy from a BPF perspective.
> > >
> >
> > I would like to be able to sign my programs please and have the kernel
> > verify it was done correctly. Why are you insisting that I *don't* do
> > that?  I'm yet to see any technical objection to doing that. Do you hav=
e
> > one that you'd like to share at this point?
>
> The kernel allows a trusted loader that's signed with your private
> key, that runs in the kernel context to delegate the verification.
> This pattern of a trusted / delegated loader is going to be required
> for many of the BPF use-cases that are out there (Cilium, bpftrace)
> that dynamically generate eBPF programs.
>
> The technical objection is that:
>
> * It does not align with most BPF use-cases out there as most
> use-cases need a trusted loader.
> * Locks us into a UAPI, whereas a signed LOADER allows us to
> incrementally build signing for all use-cases without compromising the
> security properties.
>
> BPF's philosophy is that of flexibility and not locking the users into
> a rigid in-kernel implementation and UAPI.
>
> - KP
>
> >
> > > MAP_EXCLUSIVE is missing and is required which prevents maps from
> > > being accessed by other programs as explained in the proposal.
> > >
> > > Please hold off on further iterations, I am working on a series and
> > > will share these patches based on the design that was proposed.
> > >
> >
> > So the premise here seems to be that people should only be allowed to
> > sign trusted loaders, and that trusted loaders must additionally be
> > authored by you, correct?
> >
> > When can we expect to see your patchset posted?

I will try to get this out by the end of next week.

- KP

> >

