Return-Path: <linux-security-module+bounces-8391-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC32A49E77
	for <lists+linux-security-module@lfdr.de>; Fri, 28 Feb 2025 17:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558B018835C9
	for <lists+linux-security-module@lfdr.de>; Fri, 28 Feb 2025 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F79028E7;
	Fri, 28 Feb 2025 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U78h7DY+"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26427183A
	for <linux-security-module@vger.kernel.org>; Fri, 28 Feb 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759305; cv=none; b=uPnwO31L28M/bQGodCMM46QLjTpOREDbzw1dR/iwFNZHoOVenOuaT6al5PQVeBtlgDmvWYPv2+kSnOYjcGNTJQERndg1YNDvCfNxRiMSjfk/et3YFkotqHZpljzramlpC2gz9yxosfbQ97YFGFoXUu7tYajVAlQP68gZxMSXgi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759305; c=relaxed/simple;
	bh=NN2BSvMz+vImvYnvvmxzYFCR0/diT4E56OolYQ8gpNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIUSTac0V8m3Rl3ORNdSRfptfvyqYAETyG3NASzSm8/PP46Y41+I6HZ330HCUT7sQU1hia4RwSRx9dsGpzrYh9y6/uOWI4T0/kep2AfUoeJ0av/1JP5dQahXKC62WsjqYrRZGuUg+8WeRh3dtS2ZuMsmZCssHIBmEkGsPhtQgzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U78h7DY+; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e461015fbd4so1667932276.2
        for <linux-security-module@vger.kernel.org>; Fri, 28 Feb 2025 08:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740759302; x=1741364102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNQH/48xhzRNzyZG7WNVKT1O7klmUGoSz27GU//AGac=;
        b=U78h7DY+eGX3gUwoHCVJG/8mIVMzXAlYZq+BrgoEPjLFyPpMoV/I7XbEW4Vx8M3R6J
         X7kPiDn2zT12xvndEX1KzUNskxM+1q++vjyV8jPANfWPvyjskq6dRufmz6sQTdcnahAe
         2foTP5cdzTJxEZHz+fVDWzbVSDFQGt1V2PlKvTNhobqXPMwzIS0o6NiKVFV4Fws8+F6K
         5tY85jaqh/UII+nCsQF7M8vXslfXc0DUQBQuZtigFGeO5ORowXasFOYQZQPUQw5ktI4s
         j3qw7I3eY2Gw/7KEFIm5+0DXXMMzFw8rxPplVLdmJFzDGL4bgQyT5yc96AtWIpR+XauU
         FC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759302; x=1741364102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNQH/48xhzRNzyZG7WNVKT1O7klmUGoSz27GU//AGac=;
        b=iHOpQ+38ogW79eOVlRaDTHE/W7ppaThQ1qQ+eOtUvvSrltPtU1siGPvjuVWBsngiVT
         RzLKFToq0HkEIHrtc88ZB4L5rRU+yuE9ScGPCV5ThkEQZ18TWx851NwudR+ATSLOwM+L
         YLFWdY6c6Lf7/9iMXqaj0tO9f9ETCYwQ6NszVtce7xIGXO/9P8W63H4NL97ceM5M8HzS
         vUVI/9M4i1sqKkfyKScYsv5vTp2agbVrxZ3K/e8hNm9KFLfUrywps+UH9N6EYGCK/S+4
         tNNpp6VqWdLPrKxgJC6F7T0y8nz1t18A3nE9GNMqVwzMODNo+dulj2NSFAHDyQL4b1L3
         h6NA==
X-Forwarded-Encrypted: i=1; AJvYcCVcZ64j46WBo68TN6wUZylJfakmti7TqnoUorr/+2ky9c+O+7o10PJ28yOrvbqPG+EtDshhLuiQCyGn1ePoHccge56UDcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFJv3Zd0bH6aertThZdPHuImz2/ykQoNgvZcc35L8MODZ0bbZV
	sTbCw87IIDYThGlglzfWSaj/y1T1pDp64C0Wpn4CofaVZtZJem68/LeUyqg0uMymmrjl5q1Q4Ez
	2Fmc/PcMxu8TELCYoOgGyNiRzg0cJurJjRt6D
X-Gm-Gg: ASbGnct9CkJAbbxWiXo0WYn34TpnnOqIQqWuMro3ksKqKEhvAeBtviOitPLv9z9v4Aa
	1uNRkn6AAmBJCPkbpf1C0Urlzji0kHLh+dm7gwGKusHf1iXu7NyGerDU7LoMx5VUtZZz16NsoYb
	9TeuSE5Lw=
X-Google-Smtp-Source: AGHT+IHZE6Uns2cbOQYVhvG8TYtNK8Tv1OsaBBXNMiqWNmZVSbVWlxDtSg+Lrq9TfWchcohSXBzjfLpZS1izyDom1TM=
X-Received: by 2002:a05:6902:11c2:b0:e5b:458a:dec2 with SMTP id
 3f1490d57ef6-e60b2eb2ccbmr4310016276.21.1740759302079; Fri, 28 Feb 2025
 08:15:02 -0800 (PST)
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
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com> <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
In-Reply-To: <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Feb 2025 11:14:52 -0500
X-Gm-Features: AQ5f1Jp5EkE_-0FggbQWB-ImfqO7NRM-jd_0qziHHIp1srmUnL-YEUrpKVWAWJI
Message-ID: <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
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

On Fri, Feb 28, 2025 at 9:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> >
> > I'd still also like to see some discussion about moving towards the
> > addition of keyrings oriented towards usage instead of limiting
> > ourselves to keyrings that are oriented on the source of the keys.
> > Perhaps I'm missing some important detail which makes this
> > impractical, but it seems like an obvious improvement to me and would
> > go a long way towards solving some of the problems that we typically
> > see with kernel keys.
>
> The proliferation of keyrings won't solve the key usage problem for IMA-
> appraisal.  IMA-appraisal can be used to verify the kexec image, kernel m=
odules,
> firwmare, etc, but it also verifies file signatures contained in userspac=
e
> packages.

To be clear I don't think the usage oriented keyring idea will solve
every keyring problem, but it seems like it solves a fair number of
things that I've heard lately.

>  To support the latter case, keyrings would need to be application
> specific.  (This version of Clavis doesn't solve the latter key usage for=
 IMA-
> appraisal either.)

Application specific keyrings are more-or-less what I've been trying
to describe.

> The keys baked into the kernel are trusted because the kernel itself was =
signed
> and verified (secure boot).  Anyone building a kernel can build a key int=
o the
> kernel image, which establishes a "root of trust".  That key can then be =
used to
> verify and load other keys onto the IMA keyring.

Sure, I'm not saying that trust isn't important, and that there are
varying levels of trust.  My argument is that having additional,
usage/application oriented keyrings which contain links back to keys
imported and stored in the traditional trust oriented keyrings could
neatly solve a number of keyring access control issues.

> The problem is how to safely establish a root of trust without baking the=
 key
> into the kernel image and then limiting that trust to specific usages or
> applications.

My takeaway from Clavis was that it was more about establishing a set
of access controls around keys already present in the keyrings and my
comments about usage/spplication oriented keyrings have been in that
context.  While the access control policy, regardless of how it is
implemented, should no doubt incorporate the trust placed in the
individual keys, how that trust is established is a separate issue
from access control as far as I'm concerned.

--=20
paul-moore.com

