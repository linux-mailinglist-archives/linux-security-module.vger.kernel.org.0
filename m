Return-Path: <linux-security-module+bounces-8511-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E3BA4F2A3
	for <lists+linux-security-module@lfdr.de>; Wed,  5 Mar 2025 01:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDAA3A5592
	for <lists+linux-security-module@lfdr.de>; Wed,  5 Mar 2025 00:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5056B2F3B;
	Wed,  5 Mar 2025 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JUqcU8zb"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B390317548
	for <linux-security-module@vger.kernel.org>; Wed,  5 Mar 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134327; cv=none; b=RG+KAQb4XGFoPfzggFBeJvO0WR6rNCotiDQ6XxfZ57HuUdUQZbh7nIh4rvFLrbi1kiYXXdI8RIDgHTE/5Bd3/SFWi4os+nBS1yKxkrolMb+LWKus9Ha3YKGJl9XIiI/7WORl0mjdATcOYf+lxoDmdy4g/wV4dlnC1Ri4wCZd3ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134327; c=relaxed/simple;
	bh=bTT/iAzEA9G4Yn3WUTZD9W7f5Sy0fcceFNnEE0+/Low=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjJNUn/CDFPaUi0p4AuVhN1qhyBFbJU8GSN9s08/7ZiJV+avGa8TxHCYThT+J2fY88tXZpscc/72tJCfb4M9ExJkXoBdxSgTIFR7iWgI8nikYzrSEDMmXCJykECKlkkWVAltrfWues963fggqP1+jF4x/8hfIHxvS3S/lWYKvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JUqcU8zb; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e611ebd9a61so252082276.1
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 16:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741134325; x=1741739125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP1sniriid7A1+BAl3nr1n1m5HEYZjwBGPO77MLhGoU=;
        b=JUqcU8zbaxw62Eg6gRJ+NDv7Jar1Vr0BVSvFSbJ7XmnyfxtZV5ULAH6fVA3nR+k2mu
         UGZmsoUmmmYyGrTmB8n6XEY/BhzqHoI+dKAemmB4tYYgCGoG7qBdsA/U9UwUk6+dQgU8
         jEx0Fsd2kWm3+wGAxm++eCe7CbNxdQ7XMiEtZIFgyqwXZZqZ3O9yxh8FKtnSNkec6P6c
         b0Q3s1r2D8K7pRJhizioWUbYzh7WEuaPn4WMU1BmHzoUk2TOMnhrXb5YQ16xn2XVyIPv
         1YQDcRuCqIPX2TQ5M1cNU09Zk+zto5xoV1gcDYVXMRGo24LZad821nfeGThvwo/Z5/sH
         hYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741134325; x=1741739125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP1sniriid7A1+BAl3nr1n1m5HEYZjwBGPO77MLhGoU=;
        b=pnEa4JtfPBZzgD7inpQdXQppsYhNZAfd/0tpPvsr8RQyPLHen9AdTd1dwWDu6RGuAA
         X71++MEeAxQEZMW4AxvsZG6lQdILj+t4y3eXFHoD0ZbtmxDlbcUb/X0QpHMDzCq8pFOs
         R+RAYYp7QQYCZRclzvyyr0ewwhxYi1ftNCEZJvYoiXtT0hdOzUaYh6d/aWc7MMmHF5qy
         8Ow3tAFbHiPGmC7u71G6h6PmXTHQ+lNexMDrTbGB4WFO1WzMFCElvV68ki/6O5XU2lRq
         Oopdserl1cMAKKusZqChVLSoKzLYxj6el3rY29akRswfhXTQxkLaEYx/c7Cd3aAGPX+h
         xykw==
X-Forwarded-Encrypted: i=1; AJvYcCXEfKNjW2zV3ZrmGHtCQdIjN17JM8CNfle5RlS3BHOfBZTfoTjJ0oLpP6z8ykiHnjdjhWwgU4/h7WkxilUbNF7yelwhTwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpepuY3p5bmFsuueyxqOqp5e5OTta2glLloUr9oC/RycksZ2/L
	w5A0u7DEXDg3rgBJ/i64MwuSMJ5GW5y131iCgwfth6KwxCq4gUE/Dyt3ERFn4Fq9gLtokv2JSTw
	pp2wRnI82AmuxO4QSDMCVah4EXZuoZJaI6CWQ
X-Gm-Gg: ASbGnct+qwYMYegjpmUhG4SFfPWkItnxoAW5/IWD36IYOJAqwfao01D1TiEZ3H8p9tf
	3b/AcUoL273Hmi00Wr30MdL+FLqw6Dctq1Eh0vzHV0vf4nLi9TobJqLB+qOGtjE/NtvQHyrDOOU
	knX8YLtGBRJ7otM3H51hqyrxEYxg==
X-Google-Smtp-Source: AGHT+IErI7OVB3GKpa1+20vqszLs2+aJASJZ8+v+9BPQxGrDB866hl27/av1JxG+UdClM0JLtHNtSQgdyWrmYfPGOx8=
X-Received: by 2002:a05:6902:2584:b0:e5d:f98f:6f33 with SMTP id
 3f1490d57ef6-e610c33f3damr7144244276.10.1741134324795; Tue, 04 Mar 2025
 16:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com>
 <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com> <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
 <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com> <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <Z8d9ulOirAeHmFJV@kernel.org>
In-Reply-To: <Z8d9ulOirAeHmFJV@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 19:25:13 -0500
X-Gm-Features: AQ5f1JoS9cGXy6wY5h42Ewu7LkXmKHYAIabAt3pdhKnhffyArcWMPbTInPMv6EE
Message-ID: <CAHC9VhQC_bqZAFiABMUhTO6jTUFgHB8vjpb6-Eo7SA-2-5xfuQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"casey@schaufler-ca.com" <casey@schaufler-ca.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"ebiggers@kernel.org" <ebiggers@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:25=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
> On Mon, Mar 03, 2025 at 05:40:54PM -0500, Paul Moore wrote:
> > On Fri, Feb 28, 2025 at 12:52=E2=80=AFPM Eric Snowberg <eric.snowberg@o=
racle.com> wrote:
> > > > On Feb 28, 2025, at 9:14=E2=80=AFAM, Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Fri, Feb 28, 2025 at 9:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm=
.com> wrote:
> > > >> On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> > > >>>
> > > >>> I'd still also like to see some discussion about moving towards t=
he
> > > >>> addition of keyrings oriented towards usage instead of limiting
> > > >>> ourselves to keyrings that are oriented on the source of the keys=
.
> > > >>> Perhaps I'm missing some important detail which makes this
> > > >>> impractical, but it seems like an obvious improvement to me and w=
ould
> > > >>> go a long way towards solving some of the problems that we typica=
lly
> > > >>> see with kernel keys.
> > >
> > > The intent is not to limit ourselves to the source of the key.  The m=
ain
> > > point of Clavis is to allow the end-user to determine what kernel key=
s
> > > they want to trust and for what purpose, irrespective of the originat=
ing
> > > source (.builtin_trusted, .secondary, .machine, or .platform). If we =
could
> > > go back in time, individual keyrings could be created that are orient=
ed
> > > toward usage.   The idea for introducing Clavis is to bridge what we
> > > have today with kernel keys and allow them to be usage based.
> >
> > While it is unlikely that the current well known keyrings could be
> > removed, I see no reason why new usage oriented keyrings could not be
> > introduced.  We've seen far more significant shifts in the kernel over
> > the years.
>
> Could we implement such change in a way that these new imaginary
> (at this point) usage oriented keyrings would be used to create
> the "legacy" keyrings?

I think it would be easier for them to coexist so that one could have
an easier migration.  It's possible that even once everything was
migrated to the new usage oriented keyrings it would still make sense
to keep the existing keyrings in place and always link keys from there
to the newer usage keyrings.

--=20
paul-moore.com

