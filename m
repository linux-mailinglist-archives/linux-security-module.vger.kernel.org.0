Return-Path: <linux-security-module+bounces-10253-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03426AC9720
	for <lists+linux-security-module@lfdr.de>; Fri, 30 May 2025 23:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342BD4E3D4F
	for <lists+linux-security-module@lfdr.de>; Fri, 30 May 2025 21:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD1C283FD6;
	Fri, 30 May 2025 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZi4ODva"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ABA283159
	for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640746; cv=none; b=iA1nLQhBK5RAsECT3H4gbhgtPyksmAaa//F/4dbr4+GstIpN99FlvwPMl4UERwfhpYZ9CT0eC3sxVZXZlFGUxgZo5+ypsY0OVsWGUQiqmVF408vT3ASNV0urZKs/458ZtXqjIPt2akEZW+kHUQVrUOVWrHpwNK1Z0ES4CqzxoR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640746; c=relaxed/simple;
	bh=mjVP80LsyVqMr8SzfD3fX+uyyMSczZSrqSEdqBQhikQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aj5BRTJYmLxJRi311f/P66GbO+J4kj6K3HwzqLVk8Yytd+2cvRr7owFEUfIYaMlBV5OGRrlwwbbvpaBZg1rmf3yvGvuJdbl2s/T83AVttkRMR90SxgxHknIiG6pJJ5q8ot5QyenzfQDfmYK/m4sllZwzqUfhPVPyqDRlraG/82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZi4ODva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB0FC4CEFC
	for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 21:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748640746;
	bh=mjVP80LsyVqMr8SzfD3fX+uyyMSczZSrqSEdqBQhikQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CZi4ODva0ob9cUo3Q6hd+++3W1LZY511Ved4SfC1fiKgJ7eA39HCuA8Qv49hqDgyr
	 T7G+WoYcl56aioOV+DUVZvkz33hFX66ApHIwqykIweee/c4WgkS+/dLwD7I4r8x5Yy
	 u4HLKOMhDQRdR+xdLESVisKrtJkc8T5cMGJuIF70BVyg6XN+i3Hk/igqJVSB7KnrBe
	 Z7NEMXYF5POPQX6h6uYV9TqvoCcOrt5vRF+hxV258ZMSk2N/yrvXafdONk4wJsfROc
	 qwEVBqYxC7bcpMNucY24Af+dDYcL8YIhWnlYxmJtgcx0A5fXkym4k9D8CinQHXEn3O
	 8PIJ3C4V/UXIA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-602039559d8so4451480a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 14:32:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3DwoGrgnnYjLaLVYd8egxDreHzMe3kYVc9HbyVAzDag6e5NdVr48Royrzs0mg896aij1IjP9hCXd71/G5jnARCiufPNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIDJ59pWAl7QEygOu/nSTVjuXfhlz52skfH2IAUSGSp+a+FyjP
	uYStF8khZs2B0mIn5OiDRrfIjkl4OZFzX3XMJ5efyCsiO/m6jBP+p2M7RyDdayIu1c7YHcDgVUT
	5Q4c8JFQAKynDQVq8bsRtDw20s7/MC82eWdZVlS7L
X-Google-Smtp-Source: AGHT+IGRvgPTQ5NzyWjSBzaam8qjiQiAJjrLVpG5rlkZTlJ4anR3muqMb8vG13bsjgwzb8YDl6Fk8qf2paOLggv06iY=
X-Received: by 2002:a05:6402:4408:b0:5fd:1972:7fac with SMTP id
 4fb4d7f45d1cf-6057c1a509bmr3536113a12.3.1748640744327; Fri, 30 May 2025
 14:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com> <87iklhn6ed.fsf@microsoft.com>
In-Reply-To: <87iklhn6ed.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 30 May 2025 23:32:13 +0200
X-Gmail-Original-Message-ID: <CACYkzJ75JXUM_C2og+JNtBat5psrEzjsgcV+b74FwrNaDF68nA@mail.gmail.com>
X-Gm-Features: AX0GCFvrRMx9UyMuXl-mqwSbtomflk8hXgAKvkXTrVpIT8PG3VIi0lc6UW5_5fU
Message-ID: <CACYkzJ75JXUM_C2og+JNtBat5psrEzjsgcV+b74FwrNaDF68nA@mail.gmail.com>
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

On Fri, May 30, 2025 at 11:19=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> KP Singh <kpsingh@kernel.org> writes:
>

[...]

> >
>
> And that isn't at odds with the kernel being able to do it nor is it
> with what I posted.
>
> > If your build environment that signs the BPF program is compromised
> > and can inject arbitrary code, then signing does not help.  Can you
> > explain what a supply chain attack would look like here?
> >
>
> Most people here can read C code. The number of people that can read
> ebpf assembly metaprogramming code is much smaller. Compromising clang
> is one thing, compromising libbpf is another. Your proposal increases
> the attack surface with no observable benefit. If I was going to leave a
> hard-to-find backdoor into ring0, gen.c would be a fun place to explore
> doing it. Module and UEFI signature verification code doesn't live
> inside of GCC or Clang as set of meta-instructions that get emitted, and
> there are very good reasons for that.
>
> Further, since the signature verification code is unique for each and
> every program it needs to be verified/proved/tested for each and every
> program. Additionally, since all these checks are being forced outside
> of the kernel proper, with the insistence of keeping the LSM layer in
> the dark of the ultimate result, the only way to test that a program
> will fail if the map is corrupted is to physically corrupt each and
> every program and test that individually. That isn't "elegant" nor "user
> friendly" in any way, shape or form.
>
> >> subsystem.  Additionally, it is impossible to verify the code
> >> performing the signature verification, as it is uniquely regenerated
> >
> > The LSM needs to ensure that it allows trusted LOADER programs i.e.
> > with signatures and potentially trusted signed user-space binaries
> > with unsigned or delegated signing (this will be needed for Cilium and
> > bpftrace that dynamically generate BPF programs), that's a more
> > important aspect of the LSM policy from a BPF perspective.
> >
>
> I would like to be able to sign my programs please and have the kernel
> verify it was done correctly. Why are you insisting that I *don't* do
> that?  I'm yet to see any technical objection to doing that. Do you have
> one that you'd like to share at this point?

The kernel allows a trusted loader that's signed with your private
key, that runs in the kernel context to delegate the verification.
This pattern of a trusted / delegated loader is going to be required
for many of the BPF use-cases that are out there (Cilium, bpftrace)
that dynamically generate eBPF programs.

The technical objection is that:

* It does not align with most BPF use-cases out there as most
use-cases need a trusted loader.
* Locks us into a UAPI, whereas a signed LOADER allows us to
incrementally build signing for all use-cases without compromising the
security properties.

BPF's philosophy is that of flexibility and not locking the users into
a rigid in-kernel implementation and UAPI.

- KP

>
> > MAP_EXCLUSIVE is missing and is required which prevents maps from
> > being accessed by other programs as explained in the proposal.
> >
> > Please hold off on further iterations, I am working on a series and
> > will share these patches based on the design that was proposed.
> >
>
> So the premise here seems to be that people should only be allowed to
> sign trusted loaders, and that trusted loaders must additionally be
> authored by you, correct?
>
> When can we expect to see your patchset posted?
>
> >>
> >> for every program.
> >>
> >>
> >>
> >> 2. Timing of Signature Check
> >>
> >> This patchset moves the signature check to a point before
> >> security_bpf_prog_load is invoked, due to an unresolved discussion
> >> here:
> >
> > This is fine and what I had in mind, signature verification does not
> > need to happen in the verifier and the existing hooks are good enough.
> > I did not reply to Paul's comment since this is a fairly trivial
> > detail and would be obvious in the implementation that the verifier is
> > not the right place to check the signature anyways as the instruction
> > buffer is only stable pre-verification.
> >
> >> https://lore.kernel.org/linux-security-module/CAHC9VhTj3=3DZXgrYMNA+G6=
4zsOyZO+78uDs1g=3Dkh91=3DGR5KypYg@mail.gmail.com/
> >> This change allows the LSM subsystem to be informed of the signature
> >> verification result=E2=80=94if it occurred=E2=80=94and the method used=
, all without
> >> introducing a new hook. It improves visibility and auditability,
> >> reducing the =E2=80=9Ctrust me, friend=E2=80=9D aspect of the original=
 design.
> >
> >
> > On Wed, May 28, 2025 at 11:50=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> As suggested or mandated by KP Singh
> >> https://lore.kernel.org/linux-security-module/CACYkzJ6VQUExfyt0=3D-FmX=
z46GHJh3d=3DFXh5j4KfexcEFbHV-vg@mail.gmail.com/,
> >> this patchset proposes and implements an alternative hash-chain
> >> algorithm for signature verification of BPF programs.
> >>
> >> This design diverges in two key ways:
> >>
> >> 1. Signature Strategy
> >>
> >> Two different signature strategies are
> >> implemented. One verifies only the signature of the loader program in
> >> the kernel, as described in the link above. The other verifies the
> >> program=E2=80=99s maps in-kernel via a hash chain.  The original desig=
n
> >> required loader programs to be =E2=80=9Cself-aborting=E2=80=9D and emb=
edded the
> >> terminal hash verification logic as metaprogramming code generation
> >> routines inside libbpf. While this patchset supports that scheme, it
> >> is considered undesirable in certain environments due to the potential
> >> for supply-chain attack vectors and the lack of visibility for the LSM
> >> subsystem.  Additionally, it is impossible to verify the code
> >> performing the signature verification, as it is uniquely regenerated
> >> for every program.
> >>
> >> 2. Timing of Signature Check
> >>
> >> This patchset moves the signature check to a point before
> >> security_bpf_prog_load is invoked, due to an unresolved discussion
> >> here:
> >> https://lore.kernel.org/linux-security-module/CAHC9VhTj3=3DZXgrYMNA+G6=
4zsOyZO+78uDs1g=3Dkh91=3DGR5KypYg@mail.gmail.com/
> >> This change allows the LSM subsystem to be informed of the signature
> >> verification result=E2=80=94if it occurred=E2=80=94and the method used=
, all without
> >> introducing a new hook. It improves visibility and auditability,
> >> reducing the =E2=80=9Ctrust me, friend=E2=80=9D aspect of the original=
 design.
> >>
> >>
> >> Blaise Boscaccy (3):
> >>   bpf: Add bpf_check_signature
> >>   bpf: Support light-skeleton signatures in autogenerated code
> >>   bpftool: Allow signing of light-skeleton programs
> >>
> >>  include/linux/bpf.h            |   2 +
> >>  include/linux/verification.h   |   1 +
> >>  include/uapi/linux/bpf.h       |   4 +
> >>  kernel/bpf/arraymap.c          |  11 +-
> >>  kernel/bpf/syscall.c           | 123 +++++++++++++++++++-
> >>  tools/bpf/bpftool/Makefile     |   4 +-
> >>  tools/bpf/bpftool/common.c     | 204 ++++++++++++++++++++++++++++++++=
+
> >>  tools/bpf/bpftool/gen.c        |  66 ++++++++++-
> >>  tools/bpf/bpftool/main.c       |  24 +++-
> >>  tools/bpf/bpftool/main.h       |  23 ++++
> >>  tools/include/uapi/linux/bpf.h |   4 +
> >>  tools/lib/bpf/libbpf.h         |   4 +
> >>  tools/lib/bpf/skel_internal.h  |  28 ++++-
> >>  13 files changed, 491 insertions(+), 7 deletions(-)
> >>
> >> --
> >> 2.48.1
> >>

