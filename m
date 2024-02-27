Return-Path: <linux-security-module+bounces-1685-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5159D86A22A
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Feb 2024 23:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B981D1F21D06
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Feb 2024 22:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D859150981;
	Tue, 27 Feb 2024 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TBLwbUNG"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8414F961
	for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071785; cv=none; b=nDzLemmdH2SwWMrPviuUhby8sVSN5naMHwIjKsLaC08DNdKfRQot/DV02N0011qlaFpWtqVdBVL0b6a9aoEf224Tf0Z2HTkK+YzE8SemjWnoJmgPCukdSNBkW+V4S5ZZF6T0Fe7HqQ7tzoSP1YdYHkWJ3OOsgMckOmQwmjr0zf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071785; c=relaxed/simple;
	bh=erW1uia3j0MExRyEPDxD5TYvHqphi6LaJfExyj4/xtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bb0rX38g4s+SfqOmMYpKc99Ccy6uQQ8kUJ5kPk4v6zwo4WIpTF+S7LSlICd6qPxyluYRIJB0e8BpX+N9hPqaTFETdIj3kGxA2THwBtkh5iCWRyH4hRbpCdNqFCQb72PHnQOrfWrWdkqW1v64X83XHbjWQBvbsN6ejIdZxpCcMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TBLwbUNG; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607bfa4c913so48142137b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 14:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709071782; x=1709676582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LScYWTy3C7usAjGNAd7Kwwrogvq/sTUenzJxpJUUtg=;
        b=TBLwbUNGxjMCdKfeTuReGDx6m/cQNpYjdcYIuqqGV7qhGfWS3XwyIw2zXMWI9B595H
         rbJ3HgzSRGxabaYgGtbnnYcEEPzfU5AtJygLeS1GzTMbUMcSWNIQFB34qAJBTGjPKfoY
         wMPQ/wPEGFiSnn076v+MSqiYSuEKbl4Lixu1IVOotIwBehiUFkPQqH31v5rc1VHQZcds
         D8ww9o0jeiT0Rt9YListqDXYANwxzWbDedC31LkUPZbk+EjnL+EYoD+/IRcnXI9kr1wb
         hqZItbuDjd5QnYDYClZVjhnl8cyV+NvvZ1CbmOEdMrM1FyUHCDpG/Eoe1Xlps/FdXl5W
         1QHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071782; x=1709676582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LScYWTy3C7usAjGNAd7Kwwrogvq/sTUenzJxpJUUtg=;
        b=mXhnCIce0DRGhbPgHW/LtureYyr6POKdctdIB3zpZTiazNkmmf8bDpNGRVgCp4EZTC
         Kz1WbrfeFBNweJ2uqHQ/DpCCy2B2lH+Ybs8syBWpjJdr7+VbffNxrKsPVnMAC5Ydg6zl
         nVtwPwURdjJW5phv8Pi+Cse7ekx/KfR176rV+onZR7MhPNwCUUvsseoi5ZFXKGR8NMH6
         yq+WTQomDtQATai6mXN2LFPiAr0/VsERIcEV3PWuygVNUb2KV8gdlHSSTVeIT7kbSaDn
         6+RvTpEVJVoQcOY/CjYHMbPLh0mGsvZ3p2f9k9nkfNF35H6Hk2uyjED0wwuHP/hhAJzS
         eOOg==
X-Forwarded-Encrypted: i=1; AJvYcCX6LINd6U/xVMagHwD9kN+gD3CpDvv+UgoICoDJpeu56hllYt0rpqWTKl/V2rEuYDn+wXNa1Vi6F+LaVQmQn06ZMMxYpqNVDR7+n64OcBt5P0gMHFR+
X-Gm-Message-State: AOJu0YzSz+spem7SrzDkK/vCLImk5LUCtTOABPWUFeCGAKXzjeljrht8
	jUUeNplcAaCrT0GTtLq+NwF6K3JGAHqndqq810nfauuoE3MRx4yPR5M3TUt34nNwnzmA6X5jOjQ
	zaPK7JwPsdw7kJAB34I3e/p93+zmcdVrUek+J
X-Google-Smtp-Source: AGHT+IHtG1MED5oT6RLvr3hpmtsOAPq7j+1feuMfHUZVLClZGmlcZ2s0kKJgCHVkoyuRWPgPmP/jUE/BnVHiDQLxxSc=
X-Received: by 2002:a0d:d8d8:0:b0:609:3231:6c42 with SMTP id
 a207-20020a0dd8d8000000b0060932316c42mr2167274ywe.35.1709071781933; Tue, 27
 Feb 2024 14:09:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
 <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
 <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com> <CAHC9VhQHpZZDOoPcCqRQJeDc_DOh8XGvhFF3M2wZse4ygCXZJA@mail.gmail.com>
In-Reply-To: <CAHC9VhQHpZZDOoPcCqRQJeDc_DOh8XGvhFF3M2wZse4ygCXZJA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Feb 2024 17:09:31 -0500
Message-ID: <CAHC9VhQL9REbeyP6Lp=0HT=0LryPnAOKAbBF4gH9c=cBbJxaFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	John Johansen <john.johansen@canonical.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:01=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> On Mon, Feb 26, 2024 at 2:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Feb 23, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic=
@digikod.net> wrote:
> > > >
> > > > aa_getprocattr() may not initialize the value's pointer in some cas=
e.
> > > > As for proc_pid_attr_read(), initialize this pointer to NULL in
> > > > apparmor_getselfattr() to avoid an UAF in the kfree() call.
> > > >
> > > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > > Cc: John Johansen <john.johansen@canonical.com>
> > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > > ---
> > > >  security/apparmor/lsm.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > If you like John, I can send this up to Linus with the related SELinu=
x
> > > fix, I would just need an ACK from you.
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > This patch looks good to me, and while we've still got at least two
> > (maybe three?) more weeks before v6.8 is tagged, I think it would be
> > good to get this up to Linus ASAP.  I'll hold off for another day, but
> > if we don't see any comment from John I'll go ahead and merge this and
> > send it up to Linus with the SELinux fix; I'm sure John wouldn't be
> > happy if v6.8 went out the door without this fix.
>
> I just merged this into lsm/stable-6.8 and once the automated
> build/test has done it's thing and come back clean I'll send this,
> along with the associated SELinux fix, up to Linus.  Thanks all.

In off-list discussions with Micka=C3=ABl today it was noted that this
patch also needs a fixup to the commit description so I've replaced it
with the following:

  "In apparmor_getselfattr() when an invalid AppArmor
   attribute is requested, or a value hasn't been explicitly
   set for the requested attribute, the label passed to
   aa_put_label() is not properly initialized which can cause
   problems when the pointer value is non-NULL and AppArmor
   attempts to drop a reference on the bogus label object."

I've updated the commit in lsm/stable-6.8 and I'll be sending it to
Linus shortly.

> John, if this commit is problematic please let me know and I'll send a
> fix or a revert.

--=20
paul-moore.com

