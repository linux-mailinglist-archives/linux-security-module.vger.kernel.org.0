Return-Path: <linux-security-module+bounces-8525-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC5FA4F4AA
	for <lists+linux-security-module@lfdr.de>; Wed,  5 Mar 2025 03:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579453AB858
	for <lists+linux-security-module@lfdr.de>; Wed,  5 Mar 2025 02:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA82157A5C;
	Wed,  5 Mar 2025 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SH5/CTsl"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0EF84039
	for <linux-security-module@vger.kernel.org>; Wed,  5 Mar 2025 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141466; cv=none; b=JJnkbQNkaFlRQcAxIY6oiFpmceBVtxUbdAdXDdkLAGkiS4t4LhZDZU4sNuBzWc35mVRgoAyMKtOb/JCqiroywwL2+S91QqemermMQp9t3kSzfhKs5iVKEhW3EuhjCmQ5znLdlPfbfbFDm3eAuERYYUu1rRshe3D+7xhemJpDl38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141466; c=relaxed/simple;
	bh=AgwFFQtEuifNourVx+tLk3zjZ3DvJgh61y+UczYSgaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKBaI/ldHP60g9YZED227tL5Fk6nA76fMmiqLlhbNTHDYX7muG1W9SLW+EvYz08lt9Af7chJipdL2jcEL53ZIJVL11i7SM4K4VgkBbKHDPW+YtaNgo7ix3bk65W21M1yBNumpUk+6zjYNuED3uOQPSwoemCakT9kk8WeYJE4eow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SH5/CTsl; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so5353128276.1
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 18:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741141464; x=1741746264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kMF9Dym4tz6vqOqqczuHDu3SZSd/waaI0Ftwvs+VkU=;
        b=SH5/CTsl8us9+2w986sr65NUpZPpPNSK8W0gxljx7d9un/pP2Wn5avrgSF4Rw8neKj
         MZ/dikXkxrRxFzUuOarBejKQzSIeGvrUTqnzzrCSUpIsxQ6SfJNrDprrOIGS/n13bpkP
         +pqGdxTgQeDBBvk+S83hNU1/WYIYyae/xloIxB6YUQJugyt8KHJ8AnTw+kVAsVcc0yiR
         ERYZF8ANa1f1tFQJnzbPFeKOMOrlNzAGoD6qj0DgcKX5iYmYAXbkGbgdXUXXFC1jZuR2
         S3iShZ3chFSLkliWYDwAPaTpy9e9pFvi1qVDfG25dMTj6B7xy4inP7iTfe+W/ICDUHt5
         z8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141464; x=1741746264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kMF9Dym4tz6vqOqqczuHDu3SZSd/waaI0Ftwvs+VkU=;
        b=BVzFDCP9chWckfZOcuIllBn3R2F+62Ctxq1HEsd/X7Cv/tRfE3s1bGkuMFwu0r45/N
         P1u6uP7mzsVlABfnm+yU1EOAdSxky9RzIABOvprNEHQP/Mf5h5vI3utFY4y48uONsDCf
         ii2zjz2wSNbGV43OyVnw0N+Dc/fEZtyB05pAN9glQUdbGyTCPumXLPDe1X6U50vKwV2P
         b4wVMm04wZ4mohraVHi8u2FcbUd2ZXfjdJA+lw/y45xSoOSgdcWJtysf6QicJWkbd7Em
         wSduC0ZukYLkr8PXXpWMrn/XcO1ketBZ4wbu78XwFvRAytw2Skt2ELmg2fQbjKjjKzT6
         Upxw==
X-Forwarded-Encrypted: i=1; AJvYcCWR93pj8rTNzk0nJsyZQgp92lIJ5FUGa5J/I/6v20rKxfQB2+khc3jtiDwYviiSM8LRE/zesAZvioRdtEo4fU+0+q+y+Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL7OdIhfL7F1Kskw6Fc9z6mcYW187M7IdGsmKxhhHbuJyx1qUE
	hEPBfVXRJbgY9npV7OP6zI36BO7YF3wNs4JnXkPkUpxH84oc895DhmKfbTCsrLzza0Gm0GkLqSU
	UUAA5cgojo1uKb7BLj4W4adPgvpGyHxCSDGJU
X-Gm-Gg: ASbGncti3fi0qbVRBSRyGK8f/b6xnrKNryUAStAXbrPhSiCNy4rFr9RQyFAKt4txyAA
	xmoH3H1pD17/gHIQCuUBmitjILhT8C8jJNnHrx6x/6tx3N0qLg95oMC1K5rgNXOHVnBaeHSOtVx
	HPajQTQLgaHwY+MdgBbReoX4vSOA==
X-Google-Smtp-Source: AGHT+IFEh6e6KF3avbSlOkT/C8VTB+3rxBE4DMHORzH7o48m83jvAvVGaMqAvJgwUzS2EPoYJl63n61rs2jWoqJVC4M=
X-Received: by 2002:a05:6902:100f:b0:e5b:4482:a4f7 with SMTP id
 3f1490d57ef6-e611e1f7a0amr2368591276.12.1741141463666; Tue, 04 Mar 2025
 18:24:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com> <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com> <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
 <e0e7c0971d42e45c7b4641bd58cb7ea20b36e2e1.camel@linux.ibm.com>
 <CAHC9VhSzc6N0oBesT8V21xuwB11T7e6V9r0UmiqHXvCg5erkVA@mail.gmail.com>
 <a1d6ce786256bbade459f98e0b4074e449048fee.camel@linux.ibm.com>
 <CAHC9VhT27Ge6woKbBExu2nT_cQE79rG+rrgp3nDYjvjcztVQXg@mail.gmail.com>
 <049a04b2e07e9e984ada32277cbbde42bdf7bb1b.camel@linux.ibm.com>
 <CAHC9VhRrko_CdZJg81=s-ShGfusaJqhvrX8+R6STPbMhpnEwCQ@mail.gmail.com> <b464675506fa8d7ccef737d3bcddd0ec26b9b2c3.camel@linux.ibm.com>
In-Reply-To: <b464675506fa8d7ccef737d3bcddd0ec26b9b2c3.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 21:24:12 -0500
X-Gm-Features: AQ5f1Jqpip5THNPkWYuHQHFGVe_RbmHQJEHYfBQMGKSQG1o2BNCOxD9C4D6hUiA
Message-ID: <CAHC9VhQzALRBZ3mMDL5fmdJepjeHLUz=Tm4xtoLJrL8R6Y0QKg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
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

On Tue, Mar 4, 2025 at 9:20=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Tue, 2025-03-04 at 21:09 -0500, Paul Moore wrote:
> > On Tue, Mar 4, 2025 at 8:50=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com>=
 wrote:
> > > On Tue, 2025-03-04 at 19:19 -0500, Paul Moore wrote:
> > > > On Tue, Mar 4, 2025 at 7:54=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.=
com> wrote:
> > > > > On Mon, 2025-03-03 at 17:38 -0500, Paul Moore wrote:
> > > > > > On Fri, Feb 28, 2025 at 12:19=E2=80=AFPM Mimi Zohar <zohar@linu=
x.ibm.com> wrote:
> > > > > > > On Fri, 2025-02-28 at 11:14 -0500, Paul Moore wrote:
> > > > > > > > On Fri, Feb 28, 2025 at 9:09=E2=80=AFAM Mimi Zohar <zohar@l=
inux.ibm.com> wrote:
> > > > > > > > > On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > Ok, let's go through different scenarios to see if it would s=
cale.
> > > > > > >
> > > > > > > Scenario 1: Mostly distro signed userspace applications, mini=
mum number of
> > > > > > > developer, customer, 3rd party applications.
> > > > > > >
> > > > > > > Scenario 2: Multiple developer, customer, 3rd party applicati=
ons, signed by the
> > > > > > > same party.
> > > > > > >
> > > > > > > Scenario 3: extreme case - every application signed by differ=
ent party.
> > > > > > >
> > > > > > > With the minimum case, there would probably be a default key =
or sets of
> > > > > > > permissible keys.  In the extreme case, the number of keyring=
s would be
> > > > > > > equivalent to the number of application/software packages.
> > > > > >
> > > > > > Perhaps we're not understanding each other, but my understandin=
g of
> > > > > > the above three scenarios is that they are all examples of sign=
ed
> > > > > > applications where something (likely something in the kernel li=
ke IMA)
> > > > > > verifies the signature on the application.  While there are goi=
ng to
> > > > > > be differing numbers of keys in each of the three scenarios, I =
believe
> > > > > > they would all be on/linked-to the same usage oriented keyring =
as they
> > > > > > all share the same usage: application signatures.
> > > > >
> > > > > Yes they're all verifying file signatures, but the software packa=
ges are from
> > > > > different sources (e.g. distro, chrome), signed by different keys=
.
> > > >
> > > > Yep.
> > > >
> > > > > Only a
> > > > > particular key should be used to verify the file signatures for a=
 particular
> > > > > application.
> > > >
> > > > That's definitely one access control policy, but I can also envisio=
n a
> > > > scenario where I have just one keyring for application signatures w=
ith
> > > > multiple keys from multiple vendors.
> > >
> > > Having a single keyring with keys from multiple software vendors is t=
he status
> > > quo.
> >
> > A single keyring with keys from multiple vendors does happen today
> > yes, but there is no separation based on how those keys are used, e.g.
> > separate application signature and kernel module signature keyrings.
>
> As soon as you add multiple vendors keys on the kernel module signature k=
eyring,
> you'll need finer grained access control.

Maybe.  It depends on your security policy, some solutions might be
okay with keyring level access control granularity, others may want
finer grained control.

--=20
paul-moore.com

