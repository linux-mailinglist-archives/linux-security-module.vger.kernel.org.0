Return-Path: <linux-security-module+bounces-2143-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA4287D49D
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Mar 2024 20:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B3E284DC9
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Mar 2024 19:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1D352F9E;
	Fri, 15 Mar 2024 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CnbLJSNB"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A052F85
	for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532149; cv=none; b=AM6IZOtWw+hqkf2H3M6vQEUhIFHp/PGwrMpuswvfdL4jVDM51/0kzd+7uHDlDrw5DAI4B/fG5Q3ImU721/KMeZ3tc+tDmjUbx+GVa6dpyL1UOhH6NPva8dzKzSpl0Ylvj9mDOFdN99HA87N0fUSLz0tA4T2O6XZAoOidIZbpcQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532149; c=relaxed/simple;
	bh=ZfQ8x5dH4x5DWUpBJmuLHOLodi5CZsFApbL/gAswl2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqAPeidej6UnYMthqikL/DktBj03Y1UP+TAfb3AdHcs6K9uVmMdHJ3hQD93aAefilvbnX6JExmngrhjepJKwfkOg+cllDSg5mzYcmOER9NLdNA/CdaEyhQe3tcBVv/XOi4Zkpal1BXVmfuIrvhq1x1AVvhBIE83z0JVi61xyQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CnbLJSNB; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dd161eb03afso2211582276.0
        for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710532145; x=1711136945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrPHDfVM1LJbs09LU1eQrP0j2lULZw9AOoce47S0QjY=;
        b=CnbLJSNBjdQyDHAHN0qBeXGwczhNZa200ldLwVa2zo+qgcHbkwgPQZlYQLyaHkd02e
         S5FswNzNeWEgWTmpuziPaguxVpxzDCQHm+Pm9CS1zmZWXIJfWE79QZuVoZHn59dwaPZN
         SHQMyE/Z/iHNBXpiRixvwABxVC9Wvyf5AL2I4nZgDfKniOq0fk6QZfdz0YoDgisP0kpv
         vYfUVcO7ejMGHHMLrHi5Yb4CnKWY4xz8aWjV5lHs/P60iwuvP8Ti9ZkpZioLo4Gtv1pH
         zEJOIzjo3cZHUlyKSonzVNdfKTQM/t/zXezhKXHbpUWemKHbFYi3YTrrKLOD+QnJ0aQh
         s4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710532145; x=1711136945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrPHDfVM1LJbs09LU1eQrP0j2lULZw9AOoce47S0QjY=;
        b=lYe5oLlcoc1H3LmaEz776Uz8ga65yV/87TIN3XxwUp4rjZntWe1WY5HS2zbpnEszgr
         Vmhrh3+V0S7SdT0t/mMB4v3FyTju0yO90ZCfFLx5bc50jYzUCLThfJ/QPSk17PSpmgPP
         SDqvI5eiZWD7bWEBK/v4OjcYc6SV9vyg7THBNkldoYy9PEkFo/IKymi3xZNR8miutGPD
         Y772VefdRaIW4nv/eUY55ed3x/0eoG0UTzwOGzecwqF8UZVdl//nfcGrZOfbBvBIf6nf
         VddGPJhLocHJrVqtNltUBZZNqXi9dz05u7TAYTSD3yCndaro07SIb3kAoOOvPIhI2W/I
         GRaw==
X-Forwarded-Encrypted: i=1; AJvYcCVjmataKZCNU+kpd0s7VaZiP8diCad5c/Ti6Td3wvc4QJC72KGDTtL88P5ESQ8V3xri/JyCDTGKxjure654oERHIY5BZfq4sP+aVfyoI6t69RkEKsnR
X-Gm-Message-State: AOJu0YxaEqR/UyftGRk+AJUCglYB4n2dUUoFSQvU0NmqxcbJcc2/Icea
	n2tcMFHTZvjqSNGN4e7bj4WDxfdlSMPI20JG0E212OmWvTJzzInWa5ReXBpCqztcAURnMUZZgTr
	UQUQeZZmlwBr3ySil+861KWrL1ZmD/qPgVm3Z
X-Google-Smtp-Source: AGHT+IHwst5TyUeb5tW6MfflqpvFB5F4B4ooBz3Wi0KHfdEId2X9D9NYeBtrW+pZioCvi3AEZ5oYfZafRRbAkRSKQiE=
X-Received: by 2002:a25:26c4:0:b0:dc6:ebca:c2e8 with SMTP id
 m187-20020a2526c4000000b00dc6ebcac2e8mr6228967ybm.5.1710532145662; Fri, 15
 Mar 2024 12:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315113828.258005-1-cgzones@googlemail.com>
 <20240315113828.258005-2-cgzones@googlemail.com> <CAEf4BzZF0A9qEzmRigHFLQ4vBQshGUQWZVG5L0q2_--kx4=AXA@mail.gmail.com>
 <0f8291f7-48b1-4be1-8a57-dbad5d0ab28c@kernel.dk>
In-Reply-To: <0f8291f7-48b1-4be1-8a57-dbad5d0ab28c@kernel.dk>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Mar 2024 15:48:54 -0400
Message-ID: <CAHC9VhRUkgVUJiGKHjmJo5e4o1NGL_Gc9zpipAbQbMqyn1ZFzg@mail.gmail.com>
Subject: Re: [PATCH 02/10] capability: add any wrappers to test for multiple
 caps with exactly one audit message
To: Jens Axboe <axboe@kernel.dk>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-security-module@vger.kernel.org, linux-block@vger.kernel.org, 
	Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 2:41=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
> On 3/15/24 10:45 AM, Andrii Nakryiko wrote:
> >> +/**
> >> + * ns_capable_any - Determine if the current task has one of two supe=
rior capabilities in effect
> >> + * @ns:  The usernamespace we want the capability in
> >> + * @cap1: The capabilities to be tested for first
> >> + * @cap2: The capabilities to be tested for secondly
> >> + *
> >> + * Return true if the current task has at least one of the two given =
superior
> >> + * capabilities currently available for use, false if not.
> >> + *
> >> + * In contrast to or'ing capable() this call will create exactly one =
audit
> >> + * message, either for @cap1, if it is granted or both are not permit=
ted,
> >> + * or @cap2, if it is granted while the other one is not.
> >> + *
> >> + * The capabilities should be ordered from least to most invasive, i.=
e. CAP_SYS_ADMIN last.
> >> + *
> >> + * This sets PF_SUPERPRIV on the task if the capability is available =
on the
> >> + * assumption that it's about to be used.
> >> + */
> >> +bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
> >> +{
> >> +       if (cap1 =3D=3D cap2)
> >> +               return ns_capable(ns, cap1);
> >> +
> >> +       if (ns_capable_noauditondeny(ns, cap1))
> >> +               return true;
> >> +
> >> +       if (ns_capable_noauditondeny(ns, cap2))
> >> +               return true;
> >> +
> >> +       return ns_capable(ns, cap1);
> >
> > this will incur an extra capable() check (with all the LSMs involved,
> > etc), and so for some cases where capability is expected to not be
> > present, this will be a regression. Is there some way to not redo the
> > check, but just audit the failure? At this point we do know that cap1
> > failed before, so might as well just log that.
>
> Not sure why that's important - if it's a failure case, and any audit
> failure should be, then why would we care if that's now doing a bit of
> extra work?

Exactly.  We discussed this in an earlier patchset in 2022 (lore link below=
):

https://lore.kernel.org/all/CAHC9VhS8ASN+BB7adi=3DuoAj=3DLeNhiD4LEidbMc=3D_=
bcD3UTqabg@mail.gmail.com

> I say this not knowing the full picture, as I unhelpfully was only CC'ed
> on two of the patches... Please don't do that when sending patchsets.

Agreed, if the patchset touches anything in the audit, LSM, or SELinux
code please send the full patchset to the related lists.  If I have to
dig the full patchset out of lore for review it makes me grumpy.
Don't resend the patchset for just this reason, but please keep it in
mind for future patchsets.

--
paul-moore.com

