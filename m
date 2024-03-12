Return-Path: <linux-security-module+bounces-2064-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DC7879E2E
	for <lists+linux-security-module@lfdr.de>; Tue, 12 Mar 2024 23:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4206B22CAE
	for <lists+linux-security-module@lfdr.de>; Tue, 12 Mar 2024 22:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38BD14375F;
	Tue, 12 Mar 2024 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Lx9bYC/i"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22B143732
	for <linux-security-module@vger.kernel.org>; Tue, 12 Mar 2024 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281207; cv=none; b=frGCyYhlY9K5mivI8tWiBjY2LxS4yGmCDj46KMlF0HGYxp5+hBxx6Vo6FaRInQHAtSYOP7+TqURTzTP2X8t1k5ol17nP847g6RctDRxhTx+U0yS+IEYy2FEnFcHMVcAOP33wGSbtPQNZaCKQmoJyyS6IVJBjF7vT1u92AXjQbQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281207; c=relaxed/simple;
	bh=5+qo60/Nn81h1esAukUTu0Ind2nRjfw/+jJvnTo2ly0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0fWzRY7e69CKpqgorW9bux/iAcoSARV9nFWxm5qquEg5Pg7yCaLHlECkiYj2r40HwlKYdFJiRXJLQSjUp9b0IBapxivF6oYI/VGYxQWPT7roJTQs5gnWeA2sH8nKZKqa5+rCRVA8w3oL3OLL4TgJs1NYp5W4XLE2MVwMZ8WT7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Lx9bYC/i; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc71031680so4322524276.2
        for <linux-security-module@vger.kernel.org>; Tue, 12 Mar 2024 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710281205; x=1710886005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rljCAk91ZC1UWPEyj6MFfUZuIlnZoRlAONsBjxSTjiU=;
        b=Lx9bYC/iESaDMUUr/DWARFc0JTNEzO7qfgfxQtVfgTwln7/mtk/N3Nf/kBhEMyJVvW
         oKRlNtCMwINe9ivuKcWaJIb05Hm2I50/msA01xOYFASOX52RXiTB+6AGiT5mX3ygfFnw
         NXVYc0T3+iRWn5PJIstiF3EgLPS3GpjRGaWBGDAOcoiqmaaWkLujFIRPO3WrW76ULtk3
         kw0Mpc171tFmfD+jItWQKJtNFOwtoLxbPvkpwNwzzmN8hwoRc7nlygSl8LofXX9iNRH3
         2qUa04YJWqINQFrpX9SD0AHPjDV5aOyZrHhCpTp97iFpYjtZ9JgaEoi+aViZtRSzupkj
         lfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281205; x=1710886005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rljCAk91ZC1UWPEyj6MFfUZuIlnZoRlAONsBjxSTjiU=;
        b=dfDWv/cLhlPTpDqQaQmqbGaSswP5rX95xgKQQUrDqMGyr5p8SwZ5MxoxaA9J6XWkhC
         6komL7CQBEaryomVOsNqVLAxbaTcCxzj+T//WGNcqmXXWskvbmsKRwAlkQmwSgWtpkkX
         rh5n3s4H6nK7E9jg1RgEkgZ6AwgO4qvonJMeXn4Yh0+PYf0Ug4FydZiMOW7VLNCcnE19
         7uQQevZTYW6uYZf25yg6PACrbyQwWrQeOxY/j61j4DePHpNzdsKicdFBJmedZiloNl5q
         1WGpUS01ZYjc1uO8Rc6YFJPDKpZw24f8vLGCPZgZjfFfZxwn5ZceOecfHS2kGRx07yyv
         PrAA==
X-Gm-Message-State: AOJu0Yy8c4OsTqU8bVvGxVEsGNpd8k8UqMeSaz/QECtlXSbofm5uM1wQ
	CxNbugcVCHiNrtMeeHELDoxCgcCboHUL88yolA1qX+IqOpfR++TlNGTN2mCoGg4hW7i8bqjOGjx
	1vALUnqekRwzJtPqpfVWo4ljhItWBqS3iTGOs
X-Google-Smtp-Source: AGHT+IEbSGAzRH01xCLLF1/8M75DfDxJMlOt9d6401k2ku4ehhxO+1Dv82YBnXRa10mpZ8+NqX+6UTvJEb3SoOYWeuE=
X-Received: by 2002:a81:7c85:0:b0:607:b0d3:ebc0 with SMTP id
 x127-20020a817c85000000b00607b0d3ebc0mr885362ywc.21.1710281205002; Tue, 12
 Mar 2024 15:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912205658.3432-1-casey@schaufler-ca.com> <20230912205658.3432-6-casey@schaufler-ca.com>
 <20240312101630.GA903@altlinux.org> <CAHC9VhRgjNT2YnVgCqMJnyr227qUjmfrWZ+LBnu_DGxnJZgeKw@mail.gmail.com>
 <f122b3a9-1208-4c0b-9289-73eb070a8337@schaufler-ca.com> <CAHC9VhRfwjsGiHXBRcWA6S9+H_kj0vMdQC0gyHr3ZnX-u7KzRQ@mail.gmail.com>
 <f4f5d993-552b-483a-9a3e-1be99ea48757@schaufler-ca.com> <20240312182820.GA5122@altlinux.org>
In-Reply-To: <20240312182820.GA5122@altlinux.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Mar 2024 18:06:33 -0400
Message-ID: <CAHC9VhTw2h6V3Z4fut8vHf59kOJeYqDrPqbRmRDNtZmVnM4g6Q@mail.gmail.com>
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
To: Casey Schaufler <casey@schaufler-ca.com>, "Dmitry V. Levin" <ldv@strace.io>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 2:28=E2=80=AFPM Dmitry V. Levin <ldv@strace.io> wro=
te:
> On Tue, Mar 12, 2024 at 10:44:38AM -0700, Casey Schaufler wrote:
> > On 3/12/2024 10:06 AM, Paul Moore wrote:
> > > On Tue, Mar 12, 2024 at 11:27=E2=80=AFAM Casey Schaufler <casey@schau=
fler-ca.com> wrote:
> > >> On 3/12/2024 6:25 AM, Paul Moore wrote:
> > >>> On Tue, Mar 12, 2024 at 6:16=E2=80=AFAM Dmitry V. Levin <ldv@strace=
.io> wrote:
> > >>>> On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
> > >>>> [...]
> > >>>>> --- a/security/lsm_syscalls.c
> > >>>>> +++ b/security/lsm_syscalls.c
> > >>>>> @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned in=
t, attr, struct lsm_ctx __user *,
> > >>>>>  {
> > >>>>>       return security_getselfattr(attr, ctx, size, flags);
> > >>>>>  }
> > >>>>> +
> > >>>>> +/**
> > >>>>> + * sys_lsm_list_modules - Return a list of the active security m=
odules
> > >>>>> + * @ids: the LSM module ids
> > >>>>> + * @size: pointer to size of @ids, updated on return
> > >>>>> + * @flags: reserved for future use, must be zero
> > >>>>> + *
> > >>>>> + * Returns a list of the active LSM ids. On success this functio=
n
> > >>>>> + * returns the number of @ids array elements. This value may be =
zero
> > >>>>> + * if there are no LSMs active. If @size is insufficient to cont=
ain
> > >>>>> + * the return data -E2BIG is returned and @size is set to the mi=
nimum
> > >>>>> + * required size. In all other cases a negative value indicating=
 the
> > >>>>> + * error is returned.
> > >>>>> + */
> > >>>>> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __us=
er *, size,
> > >>>>> +             u32, flags)
> > >>>> I'm sorry but the size of userspace size_t is different from the k=
ernel one
> > >>>> on 32-bit compat architectures.
> > >>> D'oh, yes, thanks for pointing that out.  It would have been nice t=
o
> > >>> have caught that before v6.8 was released, but I guess it's better
> > >>> than later.
> > >>>
> > >>>> Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modul=
es, ..)
> > >>>> now.  Other two added lsm syscalls also have this issue.
> > >>> Considering that Linux v6.8, and by extension these syscalls, are o=
nly
> > >>> a few days old, I think I'd rather see us just modify the syscalls =
and
> > >>> avoid the compat baggage.  I'm going to be shocked if anyone has
> > >>> shifted to using the new syscalls yet, and even if they have (!!),
> > >>> moving from a "size_t" type to a "u64" should be mostly transparent
> > >>> for the majority of native 64-bit systems.  Those running the absol=
ute
> > >>> latest kernels on 32-bit systems with custom or bleeding edge
> > >>> userspace *may* see a slight hiccup, but I think that user count is=
 in
> > >>> the single digits, if not zero.
> > >>>
> > >>> Let's fix this quickly with /size_t/u64/ in v6.8.1 and avoid the
> > >>> compat shim if we can.
> > >>>
> > >>> Casey, do you have time to put together a patch for this (you shoul=
d
> > >>> fix the call chains below the syscalls too)?  If not, please let me
> > >>> know and I'll get a patch out ASAP.
> > >> Grumble. Yes, I'll get right on it.
> > > Great, thanks Casey.
> >
> > Look like lsm_get_self_attr() needs the same change. lsm_set_self_attr(=
)
> > doesn't, need it, but I'm tempted to change it as well for consistency.
> > Thoughts?
>
> As lsm_get_self_attr() has the same issue, it needs the same treatment.
>
> lsm_set_self_attr() could be left unchanged.  In fact, changing the type
> of syscall arguments from size_t to an explicit 64-bit type would be
> problematic because 32-bit syscalls cannot have 64-bit arguments.

You might as well convert all of the size_t parameters, pointers or
otherwise, in the three syscalls to u32 Casey.

I'd leave the lsm_ctx struct alone, the individual fields are nicely
aligned on both 32-bit and 64-bit systems and worst case we have some
unused bits.

The 64-bit LSM IDs are perhaps a bit more problematic, but I believe
we are okay and I don't think we should change that.  With one of the
primary motivations behind the LSM syscalls being support for multiple
LSMs, I suspect any future LSMs will use an array of LSM IDs (the u64
is hidden behind a pointer) as we do in lsm_list_modules() or the LSM
ID will be part of a larger struct like lsm_ctx.

--
paul-moore.com

