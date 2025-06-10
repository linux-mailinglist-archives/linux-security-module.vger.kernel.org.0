Return-Path: <linux-security-module+bounces-10437-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7CDAD30DD
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Jun 2025 10:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D963B5BA4
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Jun 2025 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E566828134C;
	Tue, 10 Jun 2025 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UO8Z0mTE"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C203027FD5D
	for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545439; cv=none; b=rCh+idcxDG4SqpcV+rXErSSO+KIuNKYQQwCItP97r9FjChUcVhbU8CTjnV1NzWjrTjYHdbTUc859Ac4pe3CzzJGfu3URt7DT1AxxpqBoondIHw9N4kgMOEhEdJ6HtPjWNCmVsQsXtmwyelFnBEmnImr5Wfn1+sAejBBj4MeNro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545439; c=relaxed/simple;
	bh=Pdlo0r5TXrf3xrhsKn42sIVBAfwAWMvvvs2hVtLkZXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blIhkj1cL/XxHN26ab93cTQZ6iir51RFZ3n9Ouvm4RXlZkzuMOaSZ9M2r9LCN+zPpyzx8R3xWXakGJuS6EmBWEiOqcOzec57K9LCC+cW+/HPtDpsqIVhufjDS4S675yqgU0wbL/BqXux7e73W7PFKId4jljeYY/3FVKJcUjzRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UO8Z0mTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E312C4CEF4
	for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749545439;
	bh=Pdlo0r5TXrf3xrhsKn42sIVBAfwAWMvvvs2hVtLkZXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UO8Z0mTEPRC31T+fPtnoF9sxxtZSilkW4Z0SXLstzim8GaazVMqrvqVNuGFITc0ZR
	 TynRngECerOIsZ0RhTb9SOxdjruOPiY29P/SDmA7FhdvUgtWZIz9hau+NRArVSP/5Q
	 yr9Ue1ko6psiQZRGLAciXJcIcBkMB2A6XXwZhrymO//uzgF6159bcmuQF4zsajPybf
	 miU1yxOhYRT55HYNWv8T+MFgzywE3uMRo59uOWLenCyFsg2OenmgkE9fU5SMv8Bqy5
	 NzH4nQORW0P2GEUwopU5QdHzbYdurCmri49w7K5yqj6crXNMjBWa+2l4S5ZurJwsAD
	 6leyCeniUR6oA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5fff52493e0so6619681a12.3
        for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 01:50:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKiHAC8/gC/GqU6QM0aoMg7v3vvjC+/oS8BtBdPKSX4IVBmmO2fivjlWpB4sd1HsfUCEVph7DK7EsAneReMHFf2ikKqpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqmAKjJDAyO3Pz5GzPQOvnM70grHMxeNl0FDyt1y/ThdryhWW4
	njrerC0NLU+H47bvAAv2IexHfz74KcsF4X63/JxmNz26bnMwmbNq0++4deRL93bocdeBRC1QEIr
	rhLnybJywb93RVboCSEeTPm8jQQoNe9ouBAyp5suy
X-Google-Smtp-Source: AGHT+IEGZeJ0GDw260C12WchBTXu6t51Px5b+uaoqudQPZ6vvLjx+05Ekkt2bohg85ZWUfzSS1cQw+g89jN76M+wcCc=
X-Received: by 2002:a05:6402:3494:b0:607:206f:a2e with SMTP id
 4fb4d7f45d1cf-6082dbed7c3mr1533544a12.32.1749545437888; Tue, 10 Jun 2025
 01:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-12-kpsingh@kernel.org>
 <b2a0c3d722c78de38ffa2664f71654a422d77121.camel@HansenPartnership.com>
In-Reply-To: <b2a0c3d722c78de38ffa2664f71654a422d77121.camel@HansenPartnership.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 10 Jun 2025 10:50:27 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7Mh=VV0FDsfWZbWBcdC6qLdVp4RDbnoMM_Fb4LW7t4=Q@mail.gmail.com>
X-Gm-Features: AX0GCFsJ1BDqwk_WfkHZFG18itTtVpcvyI1cHBtZQFW_a9QjmxoaHJD6FO4pw3c
Message-ID: <CACYkzJ7Mh=VV0FDsfWZbWBcdC6qLdVp4RDbnoMM_Fb4LW7t4=Q@mail.gmail.com>
Subject: Re: [PATCH 11/12] bpftool: Add support for signing BPF programs
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 4:03=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> [+keyrings]
> On Sat, 2025-06-07 at 01:29 +0200, KP Singh wrote:
> [...]
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index f010295350be..e1dbbca91e34 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/err.h>
> >  #include <linux/perf_event.h>
> >  #include <linux/sizes.h>
> > +#include <linux/keyctl.h>
> >
> >  #include <bpf/bpf.h>
> >  #include <bpf/btf.h>
> > @@ -1875,6 +1876,8 @@ static int try_loader(struct gen_loader_opts
> > *gen)
> >  {
> >       struct bpf_load_and_run_opts opts =3D {};
> >       struct bpf_loader_ctx *ctx;
> > +     char sig_buf[MAX_SIG_SIZE];
> > +     __u8 prog_sha[SHA256_DIGEST_LENGTH];
> >       int ctx_sz =3D sizeof(*ctx) + 64 * max(sizeof(struct
> > bpf_map_desc),
> >                                            sizeof(struct
> > bpf_prog_desc));
> >       int log_buf_sz =3D (1u << 24) - 1;
> > @@ -1898,6 +1901,24 @@ static int try_loader(struct gen_loader_opts
> > *gen)
> >       opts.insns =3D gen->insns;
> >       opts.insns_sz =3D gen->insns_sz;
> >       fds_before =3D count_open_fds();
> > +
> > +     if (sign_progs) {
> > +             opts.excl_prog_hash =3D prog_sha;
> > +             opts.excl_prog_hash_sz =3D sizeof(prog_sha);
> > +             opts.signature =3D sig_buf;
> > +             opts.signature_sz =3D MAX_SIG_SIZE;
> > +             opts.keyring_id =3D KEY_SPEC_SESSION_KEYRING;
> > +
>
> This looks wrong on a couple of levels.  Firstly, if you want system
> level integrity you can't search the session keyring because any
> process can join (subject to keyring permissions) and the owner, who is
> presumably the one inserting the bpf program, can add any key they
> like.
>

Wanting system level integrity is a security policy question, so this
is something that needs to be implemented at the security layer, the
LSM can deny the keys / keyring IDs they don't trust.  Session
keyrings are for sure useful for delegated signing of BPF programs
when dynamically generated.

> The other problem with this scheme is that the keyring_id itself has no
> checked integrity, which means that even if a script was marked as

If an attacker can modify a binary that has permissions to load BPF
programs and update the keyring ID then we have other issues. So, this
does not work in independence, signed BPF programs do not really make
sense without trusted execution).

> system keyring only anyone can binary edit the user space program to
> change it to their preferred keyring and it will still work.  If you
> want variable keyrings, they should surely be part of the validated
> policy.

The policy is what I expect to be implemented in the LSM layer. A
variable keyring ID is a critical part of the UAPI to create different
"rings of trust" e.g. LSM can enforce that network programs can be
loaded with a derived key, and have a different keyring for
unprivileged BPF programs.

This patch implements the signing support, not the security policy for it.

- KP

>
> Regards,
>
> James
>

