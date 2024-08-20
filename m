Return-Path: <linux-security-module+bounces-4959-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36465958F7A
	for <lists+linux-security-module@lfdr.de>; Tue, 20 Aug 2024 23:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3102B2219A
	for <lists+linux-security-module@lfdr.de>; Tue, 20 Aug 2024 21:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF991C579A;
	Tue, 20 Aug 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="USTz7YFO"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A001BE228
	for <linux-security-module@vger.kernel.org>; Tue, 20 Aug 2024 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724188275; cv=none; b=MsjhH9NXVYW9/ykyZcgEPFU31pqImKy/psOy8cCjMNzSQqy69HUX2+wglawM9BaYnLLbAlVAS9v7/XU8wugHUmYIn9aMJOsWwf57ZEmUYeZYbAsbLkstJ6jboY5nThCfPHTHPC65WEDPcV4IlecLJoSKVAvwci+w7AF/5GwTHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724188275; c=relaxed/simple;
	bh=EXmtwN9WYu5r9hb1G06mSDSZ5jR9OiA6OQQFjalEZNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxSYpTrkfHmnOGQSt/zttQ6ugoyl6RfGZATxFJYF008uowjopByifFL576jaQgZj1j007H47Xs1XRzsn2g7rCAWMUBWreCUecD3PX/GpegjNcL62CnJ1eIHKSmpQVTXonBbjLS0k09SgRKHLnVvf4b9GmWiuh8cyXskQG5RliD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=USTz7YFO; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6b2e6e7ad28so1245977b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 20 Aug 2024 14:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724188273; x=1724793073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4u4JZXVf3fbTLvsAUW5memSWwVG5jYMuxlS/FZaFGqQ=;
        b=USTz7YFOdTh2v6bsxrilGeFIx0VBTGt0LyD+av7pbWdC7SGfV+HM/jm8vVBRV7GjJc
         IjR5XJ3jcivzFwtZbKN/pOKLiUug/g1/yXC3rtaGQzLFWrAeTXXZ1FyvxEmE3voF8wQx
         QZMLpHP1aigERaIBQjWeTlpN2k3P/UVDFIqb0kQS83A61G396GFZSjfzwNnPlIl61fQE
         xhnJW9+Zi/2xxM7+F0GlKMC9NEgnN0pkJ50XWEztURahDbNV500EbEhu1hmklHExBmJj
         zoo4/rAkVVOYldud13G4Y6Ck47stu2c+do8i78rZqI1OdR1MSHEs3VOEMazQAt8CsWiT
         sFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724188273; x=1724793073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4u4JZXVf3fbTLvsAUW5memSWwVG5jYMuxlS/FZaFGqQ=;
        b=ePwah8QuNiZLs9uiXChF63phm3PJceTnTye5CdjKUhSM67uzisUf2joVMT74EWc3G6
         LvJlJ8ke91xGeHpALQe/4oNyMJPEH8Rpqmq1wTIfo8tUF5d9N4UYUzmA0y2dMwRr5evc
         XCp4Bd/iml+XvJTFOHs6kVdC66f1Ih8bPVrzxWuDzGgoN4ihfa7O+5Van3bSXNoUXSH4
         WkyFxTluUyGtz3uIAXRnx6/VZpJQVYa5neyHGwjchesBTW4WVMvMhW7VC+tr/zu/Ywtp
         C3qfE+1uFwKTrlqsWY31BbkSZO6IW3gerDj3shGSOYLct3rkwypfY3Otz0FHTHMDxDkr
         DvNw==
X-Forwarded-Encrypted: i=1; AJvYcCUEab7NUuZbWOLTi/YcKz+2JXdoMx7JfuWVSdFseueuBNZBvvdFv9b7h+usfIaSQA2NO2LBoHpuclEjo3WOhD6QdxxIX7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfo6mRK676/aJw7C2VPlklN2No8BSBFLOqrZzi+dxvn0ghDmnE
	86vbjckuhA89l5/LrqvFGvRDzFJhmoMOPi0rCkKuDKZQ1AT89IaK/HuXgoZrziPKD0TCtBvelrZ
	DFl7e7GXlAiaLXYp8o9srCCxm3Fgh1ZB7wDr7BruHVv5FOOo=
X-Google-Smtp-Source: AGHT+IFjR4IpW2i5A2QBopIgS953eWYvBoGSZ6/OdZCVoBwe1iS+H7W43WgDgm2EzqEA3tHpnD1imThTf7c/exuDAME=
X-Received: by 2002:a05:690c:67c7:b0:6b5:d1ed:468e with SMTP id
 00721157ae682-6c0d9707e2fmr2003157b3.8.1724188272854; Tue, 20 Aug 2024
 14:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
 <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com> <20240819-keilen-urlaub-2875ef909760@brauner>
 <20240819.Uohee1oongu4@digikod.net> <370A8DB0-5636-4365-8CAC-EF35F196B86F@fb.com>
 <20240820.eeshaiz3Zae6@digikod.net> <1FFB2F15-EB60-4EAD-AEB0-6895D3E216C1@fb.com>
In-Reply-To: <1FFB2F15-EB60-4EAD-AEB0-6895D3E216C1@fb.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Aug 2024 17:11:02 -0400
Message-ID: <CAHC9VhQ3Sq_vOCo_XJ4hEo6fA8RvRn28UDaxwXAM52BAdCkUSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for bpf_get_dentry_xattr
To: Song Liu <songliubraving@meta.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "mattbobrowski@google.com" <mattbobrowski@google.com>, 
	Liam Wisehart <liamwisehart@meta.com>, Liang Tang <lltang@meta.com>, 
	Shankaran Gnanashanmugam <shankaran@meta.com>, LSM List <linux-security-module@vger.kernel.org>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 1:43=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
> > On Aug 20, 2024, at 5:45=E2=80=AFAM, Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:

...

> > What about adding BPF hooks to Landlock?  User space could create
> > Landlock sandboxes that would delegate the denials to a BPF program,
> > which could then also allow such access, but without directly handling
> > nor reimplementing filesystem path walks.  The Landlock user space ABI
> > changes would mainly be a new landlock_ruleset_attr field to explicitly
> > ask for a (system-wide) BPF program to handle access requests if no
> > Landlock rule allow them.  We could also tie a BPF data (i.e. blob) to
> > Landlock domains for consistent sandbox management.  One of the
> > advantage of this approach is to only run related BPF programs if the
> > sandbox policy would deny the request.  Another advantage would be to
> > leverage the Landlock user space interface to let any program partially
> > define and extend their security policy.
>
> Given there is BPF LSM, I have never thought about adding BPF hooks to
> Landlock or other LSMs. I personally would prefer to have a common API
> to walk the path, maybe something like vma_iterator. But I need to read
> more code to understand whether this makes sense?

Just so there isn't any confusion, I want to make sure that everyone
is clear that "adding BPF hooks to Landlock" should mean "add a new
Landlock specific BPF hook inside Landlock" and not "reuse existing
BPF LSM hooks inside Landlock".

--=20
paul-moore.com

