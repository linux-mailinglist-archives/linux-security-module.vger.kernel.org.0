Return-Path: <linux-security-module+bounces-8549-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCFBA53FAC
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Mar 2025 02:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F7177A48FC
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Mar 2025 01:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633B83A14;
	Thu,  6 Mar 2025 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CvwX/Aq7"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2754E2E40B
	for <linux-security-module@vger.kernel.org>; Thu,  6 Mar 2025 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223572; cv=none; b=QKsbi1VeI1LZiU/K79MNwvuu45NNPriWNccVvfICB8JcovtYdDWC0STV4/5I1hyDpP17pE0F+fOXkuoismOgttscH5yXGTuHmqAFIqXCFp4p+VnXthBIWkln5Feo3mWy6dYX+4BcZEJZb865qqVLPhuc16+eAzR/ZsoM0LdSpXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223572; c=relaxed/simple;
	bh=iwuGm3ZHGbApYL4XEYwpkiGj6XRB3Wy/awOqe4nijcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIep5eO4r7DceW/FGCpwyamg2A5RUDwwP/Kzeu9yLRZxcDb4GIH2qTAyBgs7aOnj7sVTLZEiakzYw3u37enSbpF48wYnWRoNlJmWyTOoTljqr3bSyS43sSOV2x7ia4AA0050gTTYdn70Me/puO8FdAvdWdvg/piReRJVcizemlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CvwX/Aq7; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e549b0f8d57so89314276.3
        for <linux-security-module@vger.kernel.org>; Wed, 05 Mar 2025 17:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741223570; x=1741828370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns9OcNLiPQZ46N5SAy+lKQOOPBlD1bg4YL1QETokjIw=;
        b=CvwX/Aq7UGvh8jKF6amc8L4Pjg9vIASGNnPFQjiOrAY64bsl/bjq5hsENfPkoWOvBV
         bAUDCN6FkW10z5OU3AHzF4I8P3TZrYGLkIC/wRKaZDdwv7zwOIMDroPhLNO8fpBF6iYE
         FQvmI6sRSc1SmaD3hsW1pcMuoEl5zWH7+NGxZAX4RjINKp9ZsU25e1fc0FR0YByEWfuD
         EO0YuKeJHGRVMyIoJseCdaFMhYvY7qWCOkNWNSvnfrcPOV1oHtOgWPXagbgOxdZ1JPvR
         pcaQ8VUX71UTUBQmg7drw5wC6cqip27x1vIG+C3Lxn9/fKiRO1+TdCfdQo4bAI1IUrku
         UGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741223570; x=1741828370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns9OcNLiPQZ46N5SAy+lKQOOPBlD1bg4YL1QETokjIw=;
        b=MM72CMlKlvdD840SQnkXJLzBodMnlFXY7PzgkHGWeKryJu8k49X3RBMNkkKtuf6R5X
         nPEJ6O1niTNCjPSX96YmCSmLDwaj8YrFFQocyPjxt1kDCwgfeWtpOPMa3H1r05Qa1dWo
         ueA+0B0ThnV/chVCLWYnmiE2yyxaBLf5p0SJCky2rk6pLkGxVduBJJY/ixT0z1xXaQzj
         mkZ7GHjy31Fw5wHyG0I+lIGMOqbiLlR0hhGj9mAsSCxURTrt851DozJUaX7ULQv46z9G
         F07UUPqjxpMcBaFRJgAmw7lG5Awi8qnp2gCkdCK+eD48z2LbwZzdC0ow1C25gLTJgnLm
         dZSA==
X-Forwarded-Encrypted: i=1; AJvYcCWd4i8qqMf3tL4H244pieqz985hqZEt+F4P7Pg8nKAz2G8XynZDVM9jjSQ/oooQdeZfNhFrzt7Hv0ZUYcCWtCsbIDUhWJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsh8MUEJqz0Kg60vl/h7OzDVxg+oBXrDx9ggMYLiB2L9zUUAZU
	9uStFCwfyvVz6ecfBAvdkYMk6qUawFah1LcjV4XgvhH89SfTZdparsL9amKUJL428Vr/Bo1wu2M
	dCXD7yyCdeVKoRvZLl4XwtWgfbKMJ1ykEJYmk
X-Gm-Gg: ASbGncsP/6f1L/G/RjK7kX7H5LGAGUy0pcdHIi8L+wmkA6PhN6p+qSkTbI/NSdwl8iP
	T+J6qX0TJSbSH1EK/dg+eM34agFvHjM7VNO9gkOta+pN3rNkMqpa7prKUteRJvlJsxR/jKTSd3I
	LaD0UNmIx1PAQMtlf3jYKdO/At6g==
X-Google-Smtp-Source: AGHT+IF7pO968cQESwSx4d3Cse0SeXvFnLRkVRGiC/k9GOy1btAF+uyGL5ue4Dp5VeWQu3Cdo1ybcXgzsv8nGNGFq8o=
X-Received: by 2002:a05:6902:2a4a:b0:e5d:dcc5:59bc with SMTP id
 3f1490d57ef6-e611e308b67mr7715694276.39.1741223570094; Wed, 05 Mar 2025
 17:12:50 -0800 (PST)
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
 <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com> <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com> <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
 <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com>
In-Reply-To: <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Mar 2025 20:12:39 -0500
X-Gm-Features: AQ5f1Jodn7KbI0UIW2OdnLduODjPaSZfEKxzP8aA2XiHbTTB_Svl7vi4QeubrRI
Message-ID: <CAHC9VhTObTee95SwZ+C4EwPotovE9R3vy0gVXf+kATtP3vfXrg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
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

On Wed, Mar 5, 2025 at 4:30=E2=80=AFPM Eric Snowberg <eric.snowberg@oracle.=
com> wrote:
> > On Mar 4, 2025, at 5:23=E2=80=AFPM, Paul Moore <paul@paul-moore.com> wr=
ote:
> > On Tue, Mar 4, 2025 at 9:47=E2=80=AFAM Eric Snowberg <eric.snowberg@ora=
cle.com> wrote:
> >>> On Mar 3, 2025, at 3:40=E2=80=AFPM, Paul Moore <paul@paul-moore.com> =
wrote:
> >>> On Fri, Feb 28, 2025 at 12:52=E2=80=AFPM Eric Snowberg <eric.snowberg=
@oracle.com> wrote:
> >>>>> On Feb 28, 2025, at 9:14=E2=80=AFAM, Paul Moore <paul@paul-moore.co=
m> wrote:
> >>>>> On Fri, Feb 28, 2025 at 9:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm=
.com> wrote:
> >>>>>> On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> >>>>>>>
> >>>>>>> I'd still also like to see some discussion about moving towards t=
he
> >>>>>>> addition of keyrings oriented towards usage instead of limiting
> >>>>>>> ourselves to keyrings that are oriented on the source of the keys=
.
> >>>>>>> Perhaps I'm missing some important detail which makes this
> >>>>>>> impractical, but it seems like an obvious improvement to me and w=
ould
> >>>>>>> go a long way towards solving some of the problems that we typica=
lly
> >>>>>>> see with kernel keys.
> >>>>
> >>>> The intent is not to limit ourselves to the source of the key.  The =
main
> >>>> point of Clavis is to allow the end-user to determine what kernel ke=
ys
> >>>> they want to trust and for what purpose, irrespective of the origina=
ting
> >>>> source (.builtin_trusted, .secondary, .machine, or .platform). If we=
 could
> >>>> go back in time, individual keyrings could be created that are orien=
ted
> >>>> toward usage.   The idea for introducing Clavis is to bridge what we
> >>>> have today with kernel keys and allow them to be usage based.
> >>>
> >>> While it is unlikely that the current well known keyrings could be
> >>> removed, I see no reason why new usage oriented keyrings could not be
> >>> introduced.  We've seen far more significant shifts in the kernel ove=
r
> >>> the years.
> >>
> >> Could you further clarify how a usage oriented keyring would work?  Fo=
r
> >> example, if a kernel module keyring was added, how would the end-user
> >> add keys to it while maintaining a root of trust?
> >
> > Consider it an exercise left to the reader :)
> >
> > I imagine there are different ways one could do that, either using
> > traditional user/group/capability permissions and/or LSM permissions,
> > it would depend on the environment and the security goals of the
> > overall system.
>
> These keys are used by the Lockdown LSM to provide signature
> validation.
>
> I realize the contents that follow in this paragraph is outside the
> boundary of mainline kernel code.  Every distro that wants their
> shim signed must explain how their kernel enforces lockdown
> mode.  The minimum requirement is lockdown in integrity mode.
> Also, the expectation is lockdown enforcement continues on
> through a kexec.

I personally find it very amusing the UEFI Secure Boot shim is reliant
on an unmaintained and only marginally supported LSM, Lockdown.  Has
anyone recently verified that Lockdown's protections are still intact
and comprehensive enough to be worthwhile?  Sorry, this is a bit of a
digression, but since you were the one to bring up Lockdown I thought
it would be important to mention that I don't have much faith that it
is still working to the same level as it originally was intended.  I
have a TODO list item to draft a policy around deprecating
unmaintained LSMs after an extended period of time, and once that is
in place if we don't have a qualified maintainer for Lockdown it will
likely fall into the deprecation process (whatever that may be).

> When in lockdown integrity mode, features that allow the kernel
> to be modified at runtime are disabled.  How would what you have
> suggested above adhere to these goals?

For starters, verify that Lockdown is still comprehensive enough to
satisfy these requirements on a modern Linux kernel.  After that has
been done, find someone with some kernel experience to step up and
maintain Lockdown.  Finally, put a mechanism in place so that
someone/something is regularly evaluating changes in the upstream
kernel to ensure that Lockdown is still able to achieve its security
goals.

After all that, then you can start worrying about keys.

> The point of the Clavis LSM is to use the root of trust provided to
> the kernel prior to it booting. This maintains the lockdown integrity
> goals, while also giving the end-user the ability to determine how
> kernel keys are used.

--=20
paul-moore.com

