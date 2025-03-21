Return-Path: <linux-security-module+bounces-8927-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1BCA6C2E0
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Mar 2025 19:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4241A1B622DD
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Mar 2025 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01F422F164;
	Fri, 21 Mar 2025 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QC0JtafT"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD831EE7DF
	for <linux-security-module@vger.kernel.org>; Fri, 21 Mar 2025 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583444; cv=none; b=CE4+HVyL0hAACOLqiFwsClmI8en3nLlyLnATdr9BqOPsHQ9EWrUE+1Rxocuye4xdCXum1wRckEh6JvTwdQ5ay9p4lH8qOUljsq84E7WKpFeIK/1NYv1bGtwuf3KKEM1/SlAdR0+MJ7w1OmivdA21YGpfaXEB6IOwTAa04/hYIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583444; c=relaxed/simple;
	bh=R9jLZ0JS/I/Nk0Iz0Fs5IHkSxU6QsL7aQ1XSqeyU8Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/he0+Ru7J72HVB2Kjuz1RgJ0r3AeeL37q4SitPPTz1Z+3LAoE7aAZARndArjlnud+RG/ZA/GVoko3EUz0Qzs7dnA+fx1q3blwn0irv4ZV6ZvEvpk22GOCWys2WHpdHgywHwa3yRmFBoBOuMzO4/Ka1MAqp3ErV6WAFmzjvG/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QC0JtafT; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so1809388276.3
        for <linux-security-module@vger.kernel.org>; Fri, 21 Mar 2025 11:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742583442; x=1743188242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX53KeX8QdfdkHuGZL3pdegSXRrN5TG6dmB2yHiIl9U=;
        b=QC0JtafTjLYnReunsyFX4LGaxjmtHg0EVVJEojotz08Zwhq5mKW92FvOugkwHGgZu5
         0opXpQ0BpiZ7Hdtp3vRofn8pGNNdrAMPBX9dpi+Epn867rSu9t4Lo5J1C+p8LcKOO+GK
         MSfIQ9YxN9Cp8f0EiiaxW7utlvt7B9mpLrmXAQU4IuzRVuLO6+ZWCGDwDc/fFT7Xh9cn
         lz7NouYffWf7G2EhPJhOdBReWc+0wrNsGNp081zH1B0sgwSmm9GiKa5MTpA52Qq9//My
         5MX5qRbeeAGQtu5BPtVZFOjPFXzhrpQKUQglS8/l06BOuPlr0pryogZbrXSOKrv7nbyF
         AwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742583442; x=1743188242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PX53KeX8QdfdkHuGZL3pdegSXRrN5TG6dmB2yHiIl9U=;
        b=taSKo7pWnwGgOe41qz/P4Zu18fd8QA6gMGjeeVQWkalGIDMQ6ZwGO1Jt7c6mutDPdj
         vEY1Bf1HSHlk/CIO1SYYBVaf5qqHgB7G4TzXQP7QpOsEKPEtLPQerGR3FZTc9WOjxKNg
         tjcrNu8/DCdhFHPC1nhqA5h++gQCbwdJQg8RsBSvD4mHxCO4gxNyLVpQgQMFx0vDYaLg
         6XHo+DDR9loHbJdL0oWUHmRoHBPH27qc90ykaK5kKKjUsuT0N6O4L1ZzUajkQyMWScGV
         TroAZIxjyfGTzOIkCysy7bwI9c/QaGg5xtYe7TFAbMyA6YAbUyC8dz1NUwhjmA33Blac
         kaAg==
X-Forwarded-Encrypted: i=1; AJvYcCVe0SJNZEOhYD/HWhh6dF1x0Fdtn9soUumwHWqKSH91R2Im5pbe+3J6D3ZAuwtzHxJ/OrgB5qNlvzUnONXIu2TyNV9G0MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwctuY0cEN0byaanwz+iyixo1hhe/uHG/HatYJ4FpKqpUsVGi/z
	GVGqGMd7Mb+R0rCQfT1f+yFamzvfTLb9ozH5gi+4TfTb+/Bl4ssJoJnAbbUS/YXbTSWaP/jcQjY
	f3Xz/KMeneXKfbXlpp5X1PwBqQyPoLf78mxwy
X-Gm-Gg: ASbGncvbi6Onf3WjcEKcrDBZJ3pVgKK6Ti+OFZZxXli/rQJg56M59jp4gvGZvZb//zs
	SVRHMVCRESqH4yWs3IJJHfe+FvdUDYnk08je3B5QKMYnKhZzHoY5YLU/Tzo7pfVTY8STyZPYb4e
	6k0G0Py6rVpdF1S37kIqpNI7EeHg==
X-Google-Smtp-Source: AGHT+IHWOfZuod7gXcYVT7pQNeKd7Yx7NruRIAvwDJwwJA0Zn5j0qTeOw7UV9AmgyOEamkLXhmLVnNJPDbaPxH+JWSw=
X-Received: by 2002:a05:6902:2709:b0:e63:6f6a:ab03 with SMTP id
 3f1490d57ef6-e66a4dbd62cmr6107284276.22.1742583441566; Fri, 21 Mar 2025
 11:57:21 -0700 (PDT)
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
 <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com> <CAHC9VhTObTee95SwZ+C4EwPotovE9R3vy0gVXf+kATtP3vfXrg@mail.gmail.com>
 <EB757F96-E152-4EAB-B3F7-75C1DBE3A03B@oracle.com> <1956e7f9d60.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <A3A29FB9-E015-4C87-B5F0-190A4C779CB3@oracle.com> <CAHC9VhQMN6cgWbxdAgBNffpCAo=ogGdm4qBGS_kKdDmiT8b3cw@mail.gmail.com>
 <B89ED288-1A01-41D2-8ECF-285669139553@oracle.com>
In-Reply-To: <B89ED288-1A01-41D2-8ECF-285669139553@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Mar 2025 14:57:10 -0400
X-Gm-Features: AQ5f1JoZ0K8YLyq-d626n3YkVM423cC9evLtvBNR5_Xa6ss3FNArdL28zS4Umlo
Message-ID: <CAHC9VhQb55+SmwmrsVpyw5X2Ys0oo6gJ_dbDf64mS5c008230A@mail.gmail.com>
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

On Fri, Mar 21, 2025 at 12:37=E2=80=AFPM Eric Snowberg <eric.snowberg@oracl=
e.com> wrote:
> > On Mar 20, 2025, at 3:36=E2=80=AFPM, Paul Moore <paul@paul-moore.com> w=
rote:
> > On Thu, Mar 20, 2025 at 12:29=E2=80=AFPM Eric Snowberg <eric.snowberg@o=
racle.com> wrote:
> >>> On Mar 6, 2025, at 7:46=E2=80=AFPM, Paul Moore <paul@paul-moore.com> =
wrote:
> >>> On March 6, 2025 5:29:36 PM Eric Snowberg <eric.snowberg@oracle.com> =
wrote:
> >
> > ...
> >
> >>>> Does this mean Microsoft will begin signing shims in the future with=
out
> >>>> the lockdown requirement?
> >>>
> >>> That's not a question I can answer, you'll need to discuss that with =
the UEFI SB people.
> >>
> >> Based on your previous lockdown comments, I thought you might have
> >> some new information.  Having lockdown enforcement has always been
> >> a requirement to get a shim signed by Microsoft.
>
> ...
>
> >> The alternative "usage-oriented keyring" approach you've suggested
> >> wouldn't align with the threat model that lockdown aims to achieve.
> >
> > That's a Lockdown problem, or more specifically a problem for the
> > people who are freeloading on the Lockdown LSM and expecting it to be
> > maintained without contributing anything meaningful.
>
> There are past examples of previous contributions, but they don't seem to
> go anywhere:
>
> https://lkml.org/lkml/2023/5/26/1057

Those patches proposed loosening Lockdown restrictions, which is
particularly concerning given the intent behind Lockdown, and
considering the author did not have any existing patches under
security/ (they still do not, I just checked) there was room for
concern.  If your first introduction to your neighbour includes
proposing the removal of the locks on their front door, you have to
understand that they might not consider this a valuable contribution
and might bristle at the idea of handing over responsibility of their
home's security to you.

You are welcome to continue to criticize me and my handling of things,
that's the popular thing to do these days when you disagree with a
maintainer, but I will note that I don't recall you offering to step
up and maintain Lockdown anywhere in this thread.

> Which causes us to carry patches like this downstream.

Which is your choice, and I'm sure you have plenty more patches
unrelated to Lockdown in your downstream repo.

> >> With Clavis, I attempted to develop
> >> an approach that would meet the lockdown threat model requirements
> >> while allowing the end user to control key usage as they deem fit.
> >
> > As mentioned previously, the design/implementation choices you made
> > for Clavis means it is better suited for inclusion in the key
> > subsystem and not as a standalone LSM.  If you wanted to
> > redesign/rework Clavis to stick to the traditional LSM security blobs
> > perhaps that is something we could consider as a LSM, but it's
> > probably worth seeing if David and Jarkko have any interest in
> > including Clavis functionality in the key subsystem first.
>
> The direction of creating a new LSM was based on this discussion ...

Oh so we are going to repeat ourselves, are we?

> A lot of time could have been saved had your concerns been
> voiced in either the first or second round ...

I'm still waiting for someone to connect the dots between a lack of
"timely" review (feel free to define that however you like) and these
never ending threads where we keep rehashing arguments over and over
and over ...

--=20
paul-moore.com

