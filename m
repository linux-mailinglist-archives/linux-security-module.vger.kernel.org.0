Return-Path: <linux-security-module+bounces-9477-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC79A99104
	for <lists+linux-security-module@lfdr.de>; Wed, 23 Apr 2025 17:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1DD1B86EB6
	for <lists+linux-security-module@lfdr.de>; Wed, 23 Apr 2025 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5CE28CF5F;
	Wed, 23 Apr 2025 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BV467kOY"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F2728CF4F
	for <linux-security-module@vger.kernel.org>; Wed, 23 Apr 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421043; cv=none; b=hGMsgsTk4nB4fg/Lo3KqnyBaKT3aAeunC4YJdEIN3m0uKbgBaZB5ZBafFY64MMPvOLTfFRNFTn2hnZe5eynZ8k9HJ3Q8ewqchEUIkPbm2pcP3iQhiu9oUz98sQ3n0VL7z+gRvwimv9qkrW6EZfT/bGMg14XEzRRULpu7kAkBauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421043; c=relaxed/simple;
	bh=uFV3fDxHeTVor0I1L/M53Jf1QkJJii9mgN/m4+mnqe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbEW64S46LEd1p+xfp71neDIsRa+C65HP3BDtelCaeXqVuoJqaWdex06o6Rz8Me80Uy7DuyaRQzBXpfI/snfiNWoAq6NT5TE/PR49ck9/QJO3zok0V8bwu8hirDv9acpD+Y7CcbjClrVNRdUA3+0DvfBz5cH8zPPzQAPqvJlskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BV467kOY; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e53a91756e5so5390873276.1
        for <linux-security-module@vger.kernel.org>; Wed, 23 Apr 2025 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745421041; x=1746025841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppDTLRNI5D/DHlJ104+9klrOmugo96Z4EzkqmTSr+tw=;
        b=BV467kOYvg9v1zan0/6j+x47F8k96sTz/PYM0TdS2w+WeWy7o3I1OK3YpPMw2RYbPn
         YBo32qVaE2CpT/F0kqYkX6ESu30MQ5Zs4SVO6Ngktc83G8A9DZ52LypKy6vxTaZRnDXv
         nCvVf9KcnMy3bFIrmJSvtCa5JU5K5bavjj3/uG/IgXj26dO++/pnJtPQzyTlTur5U5E4
         M27BjyuJxCnK+1YTgD8oA2zvnQoEkgi2Yr8lPHPA/hYOeURaQ2HMRRPT45VNgrE6JOba
         JVDZYlvx1cuiQ5EbAJTRGFyV9ytozEWODCcZLDQ6CJLlgX0C1fzENfaWaSI3Jc1TGnDg
         AhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745421041; x=1746025841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppDTLRNI5D/DHlJ104+9klrOmugo96Z4EzkqmTSr+tw=;
        b=gP49rT8VeiXZ8b75jgWK0CuClHVjHt8P2FW19Iyqc5JO9pgM9rdEnRD2vrfA3kgK67
         Besf7AkzQV2Po38C8GIQ0fpAiWTNLyGlYmm29865MRs5jBElHDHTBppu9PimP2Sn00pz
         rLl+1oaRyjYib4FYuwBStX2h3/LLDFKhA0EeZimBfCLSfA9igPoe7SX4MRfGikpBStre
         EvStgA9ldq+mzWJHNX3Jijrn/dTbodBnnY3TpCW6KbM3Wbt6/Ji+Xppyl3DO2Z05deYa
         e6GO7dde7QehsFPKC3JEgJOsA134qvKZ3+aCvoJKF/fdvFu6KNNdfbNkVpLuBpxvv1SD
         2PUA==
X-Forwarded-Encrypted: i=1; AJvYcCXNtZANYT/8UexhqPnN6ajGvmmtfZpt9ttMVOITAQFt0GufoJzGsmPefosa6AV5HZnKRdj3D9k5uesyzRnAO3qFgpXN/JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpy570DlAZAPw5uPHrrHenVZbZ/lH+ugAI2d97E2XQR0Nk+ia6
	9AyjZ9AutosGM0KPb77+E+CjnbYwu8UFaciqtASt82sJQKhEM7eypNOgSM4U08qO2yV0Fklhbsi
	g46h1n29rfrCZndAGt3bIEaLNiBa5iQ/m/wqV
X-Gm-Gg: ASbGncth3XTpJJQeTJ0m68Wk31HnsGpCDhdodIPq0KD3CRbys5CbQURH8BId+txR7tV
	PGGRh6VCKx7XPotF3SoWThTgL1PZaOcrR5NEPilvtfJ6poTCDWW+SHT0lLAk86RepaPzFKDk+xo
	MQyMG1cq95ly/5/X7PXNl1ky2oNRx2IegJ
X-Google-Smtp-Source: AGHT+IHNlf00p8r3DHcmCpgY+IFBhYtAhRgyVsFb6FFk96MPIernB0HKWY5qgWQbLL58D4kTom9itSs/0uIOQcHE5fg=
X-Received: by 2002:a05:690c:6801:b0:6fd:33a5:59a with SMTP id
 00721157ae682-706ccd1a5ccmr309843197b3.18.1745421040868; Wed, 23 Apr 2025
 08:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com> <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <87semdjxcp.fsf@microsoft.com> <CAADnVQ+JGfwRgsoe2=EHkXdTyQ8ycn0D9nh1k49am++4oXUPHg@mail.gmail.com>
 <87friajmd5.fsf@microsoft.com> <CAADnVQKb3gPBFz+n+GoudxaTrugVegwMb8=kUfxOea5r2NNfUA@mail.gmail.com>
 <87a58hjune.fsf@microsoft.com> <CAADnVQ+LMAnyT4yV5iuJ=vswgtUu97cHKnvysipc6o7HZfEbUA@mail.gmail.com>
 <87y0w0hv2x.fsf@microsoft.com> <CAADnVQKF+B_YYwOCFsPBbrTBGKe4b22WVJFb8C0PHGmRAjbusQ@mail.gmail.com>
 <2bd95ca78e836db0775da8237792e8448b8eec62.camel@HansenPartnership.com>
In-Reply-To: <2bd95ca78e836db0775da8237792e8448b8eec62.camel@HansenPartnership.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Apr 2025 11:10:29 -0400
X-Gm-Features: ATxdqUEil0O912atUTQeKlUUv4Sfsc4c76L7yegeINodkXYOkWCpNQ86Ynaeoaw
Message-ID: <CAHC9VhTi6+CHD9OtWj5=pPDrtwF+S9yfBOKqghe=9wXmd7jrxA@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, nkapron@google.com, 
	Matteo Croce <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 10:12=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Mon, 2025-04-21 at 13:12 -0700, Alexei Starovoitov wrote:
> [...]
> > Calling bpf_map_get() and
> > map->ops->map_lookup_elem() from a module is not ok either.
>
> I don't understand this objection.  The program just got passed in to
> bpf_prog_load() as a set of attributes which, for a light skeleton,
> directly contain the code as a blob and have the various BTF
> relocations as a blob in a single element array map.  I think everyone
> agrees that the integrity of the program would be compromised by
> modifications to the relocations, so the security_bpf_prog_load() hook
> can't make an integrity determination without examining both.  If the
> hook can't use the bpf_maps.. APIs directly is there some other API it
> should be using to get the relocations, or are you saying that the
> security_bpf_prog_load() hook isn't fit for purpose and it should be
> called after the bpf core has loaded the relocations so they can be
> provided to the hook as an argument?
>
> The above, by the way, is independent of signing, because it applies to
> any determination that might be made in the security_bpf_prog_load()
> hook regardless of purpose.

I've also been worrying that some of the unspoken motivation behind
the objection is simply that Hornet is not BPF.  If/when we get to a
point where Hornet is sent up to Linus and Alexei's objection to the
Hornet LSM inspecting BPF maps stands, it seems as though *any* LSM,
including BPF LSMs, would need to be prevented from accessing BPF
maps.  I'm fairly certain no one wants to see it come to that.

--=20
paul-moore.com

