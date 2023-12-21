Return-Path: <linux-security-module+bounces-695-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 532DB81BA75
	for <lists+linux-security-module@lfdr.de>; Thu, 21 Dec 2023 16:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A225AB241F9
	for <lists+linux-security-module@lfdr.de>; Thu, 21 Dec 2023 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C1D4F1E9;
	Thu, 21 Dec 2023 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YH3IlKNK"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D6539E5
	for <linux-security-module@vger.kernel.org>; Thu, 21 Dec 2023 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbd73cc1e52so856019276.0
        for <linux-security-module@vger.kernel.org>; Thu, 21 Dec 2023 07:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703172045; x=1703776845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqMpSSIZ78PXpXDobSVHHnmSfZfFYRwg43+u7EmiBX0=;
        b=YH3IlKNKGkWLdzfUeUi2NIzrBdzNip8TzdVNLlPlV5BC2uYLva+1BWbl5GbNvuSFZf
         Fw1hiQpGpXXZIu0SQJRCTumG4BotIpjCGVM8PpbTDyBUQDoA76atDjqGZvosCuv/FBJW
         26ox3BATE4uMKgxjHJRHmxICPzeuUtsCL/POtJcK2N8jUmCQheUVT86Efok38+ybE0pS
         7UeujZxui1rdp/f2lp/r+7xIRYf0rhT4zUCWjV1G5WHKg6/J9bWmR5aQ5n1ENJcWQyaA
         tTt0IyBHuR3maGLK79yytAwOmlTUr152sYIJU/bJM5PsRkUNUNVUcmVTiIAbkbYgra7m
         IcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172045; x=1703776845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqMpSSIZ78PXpXDobSVHHnmSfZfFYRwg43+u7EmiBX0=;
        b=SRGO7rkmTkIR+CXR273+s/IwuhltxrYnQlL+cmJmLfF+T5Yxr0FKk+TW/i+8yG/abk
         qHBJPbGWVxGoIVoZkTppFWdFoa9NzIsQ+tSylCsSqf2T5G3/yVVwskCKzJrNtNTkyWyZ
         XhOMT5z6fMg/PetexWq3KjFTETvvCuBReS4lhKUTLH9iIyoB/BTQFM5pH3aYz7s8KMJ+
         54IWtjuyEPvw8HhBr4dsysrLPhSftGI6ESKxXGvK8//Kc3mDe17UBu6WZeb2hmIIaYPi
         ppllJBRDh89eiuTZiosMNAokXYBQzmLqHoUN42TvwLNl4FkFVGbmaOGtnIt8Gk+s32sr
         IG+g==
X-Gm-Message-State: AOJu0Yw86RAvh3KK+izljRtVYm6bJc+jW7FYAdaQ1KG9ku1HCxNI2egv
	hbudaXrmvjrapmrWHYJeF5elwAELBoNeOc0//bIU
X-Google-Smtp-Source: AGHT+IECyGfKtslmyZL3ZJ/ubxm255SRJ+QgrThanH21ILGaTj05vwz/qfSPuEJZJ+XbLMcVwPXfR4sOLgCkslWNLGY=
X-Received: by 2002:a25:b307:0:b0:dbd:45b4:cc40 with SMTP id
 l7-20020a25b307000000b00dbd45b4cc40mr1146208ybj.129.1703172044794; Thu, 21
 Dec 2023 07:20:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024213525.361332-4-paul@paul-moore.com> <20231024213525.361332-7-paul@paul-moore.com>
 <3717b995-5209-4db8-be77-c6303bb1c0db@arm.com> <CAHC9VhSABo8PO0q0EUSw7uh+r8CjPFTwK6DJk8Vs4oDcckPwHg@mail.gmail.com>
 <bbfee04e-d5a7-4537-a9ab-467eecb00940@sirena.org.uk>
In-Reply-To: <bbfee04e-d5a7-4537-a9ab-467eecb00940@sirena.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 21 Dec 2023 10:21:04 -0500
Message-ID: <CAHC9VhSZ6SQ=2tspLk+kFhXKPoOcAcGzkVrWVneT5_cXBUyrUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] lsm: consolidate buffer size handling into lsm_fill_user_ctx()
To: Mark Brown <broonie@kernel.org>, Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 8:01=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
> On Wed, Dec 20, 2023 at 08:40:24PM -0500, Paul Moore wrote:
> > Looking at the lsm_ctx definition in include/uapi/linux/lsm.h I see
> > the following:
>
> >   struct lsm_ctx {
> >     __u64 id;       /* offset:  0 */
> >     __u64 flags;    /* offset:  8 */
> >     __u64 len;      /* offset: 16 */
> >     __u64 ctx_len;  /* offset: 24 */
> >     __u8 ctx[];     /* offset: 32 */
> >   };
>
> > and given that the offending line of code is trying to do a memcpy
> > into the ctx field, an offset of 32 looks correct to me.
>
> > Suggestions on how to annotate the struct, or the code doing the
> > memcpy() are welcome.
>
> You're looking for a __counted_by() annotation here I think.

Can you verify and submit a patch for that?  I'm asking because my
build/toolchain configuration never produced these warnings/errors
during my testing.

--=20
paul-moore.com

