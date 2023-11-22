Return-Path: <linux-security-module+bounces-12-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA407F3CF1
	for <lists+linux-security-module@lfdr.de>; Wed, 22 Nov 2023 05:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7D71C20752
	for <lists+linux-security-module@lfdr.de>; Wed, 22 Nov 2023 04:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D074B8494
	for <lists+linux-security-module@lfdr.de>; Wed, 22 Nov 2023 04:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LIp4UK5+"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFBCBD
	for <linux-security-module@vger.kernel.org>; Tue, 21 Nov 2023 20:21:38 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-db40898721fso104896276.3
        for <linux-security-module@vger.kernel.org>; Tue, 21 Nov 2023 20:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700626897; x=1701231697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVXWPvtRBhDeG90a/ZedgAdRgWMSJ7Pm+mRwu5c61Bk=;
        b=LIp4UK5+wVWLF5T3o8WstaWzh2Ll++NeLK7bnLZNdYp+0vXVuCuREuol78DN1E8QdW
         dj+/MK6X3XBU3ixJmPbuDDAbupTH7uGHAhedPDx+rEa19evEqaiJt872jqqnoWO0dwBz
         ofolIf2OZcKoDhSATk6z6eiZjn+VgmKApPmqtznsqF7BA1LGAww6T0oS1iDuIm9gyiZF
         98CHYzROdwE95bTHnHFdS6KMVFvUfC1l5SwZDUcq3OuCYfy4KjnoQa02oRRBnn0LuM1X
         9nov61RfuKqnjQbfE0aI1m6rhz4Q3E2j+cMW5D4LakHgqEVyu93d+wvSMd4Z6cHLYQ7D
         GHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700626897; x=1701231697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVXWPvtRBhDeG90a/ZedgAdRgWMSJ7Pm+mRwu5c61Bk=;
        b=sZaL8zuhgrrToe5OtYcBHWDReMl733OHT5nnXsaCfeQXFPJAWkqRmNMUTgvj0BM5dB
         XyKI7GtVNf0TN8aAS93dun3/L/QmlhvENXpBK9dMea5Qfx0udPZ+2g4QupoRwwyCETcT
         R1EsKmXU3N3U2bQVKykKKPTTBKsWoy12GbBuCcgO9vivJVIDHz3ndNlwh541NKlHQNZ6
         KMsLUOEA2FKZT1Ux9MZB3cGWVneWK8o4F1QtDAYIatTv3sb2Cj57ULXaz/NYWy8db9uc
         wWijp/QmlDkdYfI4yAEnZq/ZdECz7GvE4KHQSZ9Gh+Ps0D6tEJS3QapOhsMffWG1Zpqz
         Bq3g==
X-Gm-Message-State: AOJu0YyxwyGtv7ZqqDOw5CgWcVFH1A2AN50q9UzOA6At+dAfiDZhDm4P
	mSA6kW8F3hOXjogyvJGfKeq0hx3ME2nqBGOXbY5VDmrNXBpmIuw=
X-Google-Smtp-Source: AGHT+IE8nMjmv+MMpdCveL8Z01wo2xacBMBUWnBQYMDDwZPg7dC5Q9T1luKYJbPJkntVIqlYW/2qIZJDkEN2u1qQXGk=
X-Received: by 2002:a25:9184:0:b0:d9a:401d:f5da with SMTP id
 w4-20020a259184000000b00d9a401df5damr896533ybl.51.1700626897254; Tue, 21 Nov
 2023 20:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114022503.6310-1-kelvie@kelvie.ca> <a66a805c-3e1f-4b9a-a38e-aca84b8678a6@infradead.org>
 <CAHC9VhR6mr0XRrq=Apy00HD3tdgpKi4RyMr8f5kdx2sjA0sfig@mail.gmail.com> <CAK2bC5rN_P7WP_E57wJjz+7icVjrwS0e6fqg_5uNaPhy3YR2dQ@mail.gmail.com>
In-Reply-To: <CAK2bC5rN_P7WP_E57wJjz+7icVjrwS0e6fqg_5uNaPhy3YR2dQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Nov 2023 23:21:26 -0500
Message-ID: <CAHC9VhQeQcEKFKWi2pvGE-DhkaccqBn9Yf_+r7JbZ2UPN+z3-g@mail.gmail.com>
Subject: Re: [PATCH RFC] Add a lockdown_hibernate parameter
To: Kelvie Wong <kelvie@kelvie.ca>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 10:07=E2=80=AFPM Kelvie Wong <kelvie@kelvie.ca> wro=
te:
> On Mon, 20 Nov 2023 at 13:12, Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Nov 13, 2023 at 11:01=E2=80=AFPM Randy Dunlap <rdunlap@infradea=
d.org> wrote:
> > >
> > > [add security & dhowells]
> > >
> > > On 11/13/23 18:23, Kelvie Wong wrote:
> > > > This allows the user to tell the kernel that they know better (name=
ly,
> > > > they secured their swap properly), and that it can enable hibernati=
on.
> > > >
> > > > I've been using this for about a year now, as it doesn't seem like
> > > > proper secure hibernation was going to be implemented back then, an=
d
> > > > it's now been a year since I've been building my own kernels with t=
his
> > > > patch, so getting this upstreamed would save some CO2 from me build=
ing
> > > > my own kernels every upgrade.
> > > >
> > > > Some other not-me users have also tested the patch:
> > > >
> > > > https://community.frame.work/t/guide-fedora-36-hibernation-with-ena=
bled-secure-boot-and-full-disk-encryption-fde-decrypting-over-tpm2/25474/17
> > > >
> > > > Signed-off-by: Kelvie Wong <kelvie@kelvie.ca>
> >
> > I would feel a lot better about this if there was a way to verify that
> > the swap was protected as opposed to leaving that as a note in a doc
> > that the majority of users will never see, read, or understand.
>
> I'd argue that this wouldn't even be necessary if we detect the swap was
> protected -- hibernation should just be enabled in that case without sett=
ing
> any parameters.
>
> My understanding is that it was disabled waiting for this
> functionality, and it's been
> at least a couple of years now [1], so it looks like it's not such an
> easy problem.

I've got to warn you that I have an allergic reaction to arguments
that start with "the right solution is really hard, so let's pick the
easier, worse solution." ;)

> Anyway, my argument is that the majority of users will never use this ker=
nel
> parameter anyway, so I think it's a fair assumption that the power users =
that
> *do* use this will educate themselves on why this parameter even exists.

I guess I'm still not sold on this idea, I'm sorry.

--=20
paul-moore.com

