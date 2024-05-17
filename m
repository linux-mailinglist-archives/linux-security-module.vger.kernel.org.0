Return-Path: <linux-security-module+bounces-3283-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90DB8C8CF3
	for <lists+linux-security-module@lfdr.de>; Fri, 17 May 2024 21:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01DF1C21BB8
	for <lists+linux-security-module@lfdr.de>; Fri, 17 May 2024 19:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574F112FF6D;
	Fri, 17 May 2024 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Vxz8rqh7"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958DB7E76D
	for <linux-security-module@vger.kernel.org>; Fri, 17 May 2024 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975373; cv=none; b=JtTgjnKIlajLXFF/UnGlq2WV2oWd3m5QICx09ka6tS9SxmNKGCVyP0rjKNrS3k4bxfMghkU3MDHs06CHpz6fWnmTJHtSfVRlny+Yjm+/cwDOlk3Lm4q1Mq/L0hCnwkWVuzJoQpCV/PO4Y6XtZSVtrMZxRbpZWQg0C/kuFwIC4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975373; c=relaxed/simple;
	bh=0Nj9blmMrWvEhhubnCEXkUK1i7CFuX4cqPmXYCzyIdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiX/6jAA+3pqRGeFXI5HZ+6eDoJ7zTgHX+yuMu+N67tRK0uTrOueIE2NYbi0iUFfwAGKHiO09HtzeXoYlXoMDRTu7Ln4gwOR9AUvb0h2ZHm2uiIXHAYc+g3BP7u2E/Z/gh0AkKCpPVre7LmshDpYEkN33KXLeZXZvUthVULMnXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Vxz8rqh7; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc236729a2bso516899276.0
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2024 12:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715975369; x=1716580169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmvDTTyodSI+XcZWsqtuztFtBkxRRSCDo7mvxANpGII=;
        b=Vxz8rqh7KMqrKxU74+U0hW8bZJ9rP40hTN3BHU3eRSO0qY5UK0m0HZPRVv5hXrCT7L
         7jWpbmTCEymmvS+dSpDPR/oIBO27baMMzyVDiI3UKkOq0GtCfOzMpm3IDOapfG4tfqhf
         MpfJ7kDu7GhttL0OsKedh21UQ4ETL8uiRGL4JW5NAH1u8XmSMBFrsrEglZlVvs27O3bT
         Napk+zY7SAur6mvnzoT+018k0BTgTsEIjN+9cPX+L9tjt7145+EBdTxegKToVM7pcxVV
         fKDKTOdTh2QbquOQb4jbsIGiXcYqPPed2c4+zNpRol8pYCjMn7nVkd4ee7/CtobQ3gbt
         SceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715975369; x=1716580169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmvDTTyodSI+XcZWsqtuztFtBkxRRSCDo7mvxANpGII=;
        b=ArkKGJ2dedQQLRTu4fHYzXscNN/UXJxQqYeXocU+53IUjAGUFQpFf6V4cKdn9Sgytc
         O6aD1RlvTIqL/uyF2yIs2jU48ZXSlbDdSxe2nHz8ZKgKNjx+yRPQchYnHXYhkvtlfwUJ
         L0M+1W70jr/jYayDeb+sYFJl2mLk4vo0AQwfeVEaCbDgNc7ik5TYmIKvF/va6sJ2cxKP
         rRzT8qmevDWROsxybfG6fBniRumbYeVtcGeM3L8T4mZREsD7jral+h8LGGEixBAD7sXf
         ZwbyfnkdxZvfXS3YPT9oKJCbp2kwgmy8bhS8zHoIcfSWmgui2fK0xfLpQaKLGSv9nzwc
         TvKg==
X-Forwarded-Encrypted: i=1; AJvYcCVqqj90VuRGpvl6alTwqtyCzK3TumBiFtFgFX3s+pdme149oaHDG8JihO88uXNInEA79xZWPS/B+GEkruW3dAHvQ/va9PaNZRijXN+/F+iDdekB/HcN
X-Gm-Message-State: AOJu0YwJNLXqAc4G9CEpdCzvkj48WTsu9W33aa7F09QIy16Ik4ktVYPP
	xYunR8GLlyWBKhatIQuOaCk/dlVs6PewFjGI84AJwhK4cflYj0BlYWEWPPSH3lARO/vLtcgeXnQ
	u1sPsd2//d2sqNx3XILkuHD4s2lqqOkwrerxj
X-Google-Smtp-Source: AGHT+IGsbsPMcf3m5f0KQ15GNTX2j9tpXVG7G1p7z67oOrcrMhtINgtZb6Sxeaci+6rPQE0x8ecT306KbYePzgEv8X0=
X-Received: by 2002:a05:6902:311:b0:dd0:97e8:74e6 with SMTP id
 3f1490d57ef6-dee4f387774mr23316256276.55.1715975369546; Fri, 17 May 2024
 12:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416152913.1527166-3-omosnace@redhat.com> <085faf37b4728d7c11b05f204b0d9ad6@paul-moore.com>
 <CAFqZXNvm6T9pdWmExgmuODaNupMu3zSfYyb0gebn5AwmJ+86oQ@mail.gmail.com>
 <CAHC9VhTxhcSDfYCK95UsuZixMSRNFtTGkDvBWjpagHw6328PMQ@mail.gmail.com> <CAFqZXNurJZ-q64gxh54YhoO_GZeFzxXE0Yta_X-DqF_CcRSvRA@mail.gmail.com>
In-Reply-To: <CAFqZXNurJZ-q64gxh54YhoO_GZeFzxXE0Yta_X-DqF_CcRSvRA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 17 May 2024 15:49:18 -0400
Message-ID: <CAHC9VhRjDn3yihw8fpmweWynE9nmcqaCCspM_SpM7ujUnqoGDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 7:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Thu, Apr 25, 2024 at 11:48=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > On Wed, Apr 17, 2024 at 9:03=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > > On Tue, Apr 16, 2024 at 8:39=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Apr 16, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > >
> > > > > As the comment in this function says, the code currently just cle=
ars the
> > > > > CIPSO part with IPOPT_NOP, rather than removing it completely and
> > > > > trimming the packet. This is inconsistent with the other
> > > > > cipso_v4_*_delattr() functions and with CALIPSO (IPv6).
> > > >
> > > > This sentence above implies an equality in handling between those t=
hree
> > > > cases that doesn't exist.  IPv6 has a radically different approach =
to
> > > > IP options, comparisions between the two aren't really valid.
> > >
> > > I don't think it's that radically different.
> >
> > They are very different in my mind.  The IPv4 vs IPv6 option format
> > and handling should be fairly obvious and I'm sure there are plenty of
> > things written that describe the differences and motivations in
> > excruciating detail so I'm not going to bother trying to do that here;
> > as usual, Google is your friend.  I will admit that the skbuff vs
> > socket-based labeling differences are a bit more subtle, but I believe
> > if you look at how the packets are labeled in the two approaches as
> > well as how they are managed and hooked into the LSMs you will start
> > to get a better idea.  If that doesn't convince you that these three
> > cases are significantly different, I'm not sure what else I can say
> > other than we have a difference of opinion.  Regardless, I stand by my
> > original comment that I don't like the text you chose and would like
> > you to remove or change it.
>
> Ok, I amended this part for v2 to hopefully better express what I'm
> alluding to. I also added a paragraph about the routers dropping
> packets with IP options, which explains the motivation better, anyway.

Okay, I'll refrain from further comment until I see the v2 patch.

> I tried to test what you describe - hopefully I got close enough:
>
> My test setup has 3 VMs (running Fedora 39 from the stock qcow2 image)
> A, B, and R, connected via separate links as A <--> R <--> B, where R
> acts as a router between A and B (net.ipv4.ip_forward is set to 1 on
> R, and the appropriate routes are set on A, B, R).
>
> The A <--> R link has subnet 10.123.123.0/24, A having address
> 10.123.123.2 and R having 10.123.123.1.
> The B <--> R link has subnet 10.123.124.0/24, B having address
> 10.123.124.2 and R having 10.123.124.1.
>
> The links are implemented as GRE tunnels over the main network that is
> shared between the VMs.
>
> Netlabel configuration on A:
> netlabelctl cipsov4 add pass doi:16 tags:5
> netlabelctl map del default
> netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
> netlabelctl map add default address:::/0 protocol:unlbl
> netlabelctl map add default address:10.123.123.0/24 protocol:cipsov4,16
> netlabelctl map add default address:10.123.124.0/24 protocol:cipsov4,16
>
> Netlabel configuration on R:
> netlabelctl cipsov4 add pass doi:16 tags:5
> netlabelctl map del default
> netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
> netlabelctl map add default address:::/0 protocol:unlbl
> netlabelctl map add default address:10.123.123.0/24 protocol:cipsov4,16
>
> B has no netlabel configured.
>
> (I.e. A tries to send CIPSO-labeled packets to B, but R treats the
> 10.123.124.0/24 network as unlabeled, so should strip/add the CIPSO
> label when forwarding between A and B.)
>
> A basic TCP connection worked just fine in both directions with and
> without these patches applied (I installed the patched kernel on all
> machines, though it should only matter on machine R). I ignored the
> actual labels/CIPSO content - i.e. I didn't change the default SELinux
> policy and put SELinux into permissive mode on machines A and R.
>
> Capturing the packets on R showed the following IP option content
> without the patches:
> A -> R: CIPSO
> R -> B: NOPs
> B -> R: (empty)
> R -> A: CIPSO
>
> With the patches this changed to:
> A -> R: CIPSO
> R -> B: (empty)
> B -> R: (empty)
> R -> A: CIPSO
>
> Is this convincing enough or do you have different scenarios in mind?

Thanks for verifying your patch, the methodology looks good to me, but
as I mentioned in my previous email I would feel much better if you
verified this with a different client OS/stack.  Do you have access to
Windows/MacOS/BSD/non-Linux system you could use in place of B in your
test above?

--=20
paul-moore.com

