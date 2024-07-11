Return-Path: <linux-security-module+bounces-4265-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944C492F03D
	for <lists+linux-security-module@lfdr.de>; Thu, 11 Jul 2024 22:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C8F1C20F6C
	for <lists+linux-security-module@lfdr.de>; Thu, 11 Jul 2024 20:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1490E19E82A;
	Thu, 11 Jul 2024 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C3Ky6eWn"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FE716EB67
	for <linux-security-module@vger.kernel.org>; Thu, 11 Jul 2024 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729204; cv=none; b=rpl7UAIeTePf/LynzUF7urQhBFYRCxaO2AY+kVeMPlJMZGyhZVRWtG8TEgDpxAu0lAKuPqrEzzTglLMQ0Sw3KJKSToUxKNKrRp6KIkkKde3Exz7rq1uRmDclHOTc1la4yyKhhPpnYvD33MvaJj+jptTazboehJ/QwkA0It4Au8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729204; c=relaxed/simple;
	bh=ETkiDjCIYqZOsYZLH9m3oS9V5QLej6zvp3CNZZVdVRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNX6CRfdovG6qxL6jyPVbM9+32OmiTZ2o+UUmtp9TcBrHG54CqAR9TE7dXYe2tjnifQQTCUOrFVZmfGi2crCmbQpRGXA45HPe1uzGhye9hjZpQgCxaDLNnCj5Vw0Pt/ClcXRBAYyIyC7kQEyNJ3otwIIUyCyjL8GwepMqWpO+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C3Ky6eWn; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so1327574276.2
        for <linux-security-module@vger.kernel.org>; Thu, 11 Jul 2024 13:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720729201; x=1721334001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpGLuWmIByUZ32h1aPkKyY2/mbjLh0uz0qKbiFZflrw=;
        b=C3Ky6eWnNY/9CBDHGIkvpsFJso/be14LtAhPbZthzDP0JwqOCcydQNfG/gS3e9ccOO
         HvR1Jjs+b7Y+zgkNOF2kuSyACeZHsYtgQ3QadAJL/PTjQnEtF18uTt96F4RKoTYWAn1i
         QFVuzAnKHZ7je4vLIKkf/nNxFYoNlYNd/Gc32lVEd9SeOLyrqy0gDFQDvHrTwTj4mqhU
         UU5iH1PeMXuneBfFgw2XOvh5SPMDgPxbljw5lujknb2oYirlAaNEZsZjzaDpjqSPWHeK
         t2Pqpcg9AIU3H2yplPqfhwXu8abLrK96Kx4rTYph94tKUT9vLYSXiDfj8Ydt9d6S7y7B
         Fg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720729201; x=1721334001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpGLuWmIByUZ32h1aPkKyY2/mbjLh0uz0qKbiFZflrw=;
        b=vX7BDIDP4UdTlvOO5LKAGhyiNPX4yJpqgvHi71psIqmu8fKCuHrELbXtvetrhv0Db3
         u+Mpfo+/q+2oFCpXHoV1TtHvhHi8adKYHn2dlecMTIKROAIdoAVF1C89y1dzJx4PW48t
         wN2W3q8dpETHcM30OQFisG4vThS3Lrmpwidmj8VeQbPGZCqvFVjMus0kLzR9qWAObtE2
         lckxLYLgivrgAsQHO8y6RKmESzGg7kzv75mfR27jyYl3QJEEBNWcShlzhHbpTNX8TX6U
         62uIUpn5PH78fg+IF5IPdZTIXJDDADpWViDS1bL1/KM2UVavIIOC9J4T9J2QTzvKkcRb
         oSMQ==
X-Gm-Message-State: AOJu0YxRyuKyOHQCjFeXSraxb0wHijdd7xcOR5OMkxxLQQab+CqnPHuw
	BSANhkAIMd+R/2h7UaN0kGm1yrpkDk1KFC9lDb0LDtTm7q4TPqbybC8jUpd53ajCOlj2HypVWK4
	c/jQ1/FWniziDGFgDd6ats6O+NhdnfWxoKJP4
X-Google-Smtp-Source: AGHT+IEyeQskhwK4RLGcQdAzm9DCDw4TSrfYV8NeTF8AA958yBnk0jiBsJHNXF9yiHB+Srb6Y6BaVcp+b7BUPLbU+8c=
X-Received: by 2002:a5b:601:0:b0:e02:b545:1bf9 with SMTP id
 3f1490d57ef6-e041b05836cmr11643687276.17.1720729201396; Thu, 11 Jul 2024
 13:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710000500.208154-4-kpsingh@kernel.org> <b23e0868802853a9ab17e17fdc35c678@paul-moore.com>
 <CACYkzJ6HGdW1Vqs_KPtGLZEyX4NO8ZpreJfhoCoOwsWDdmAueQ@mail.gmail.com> <CAHC9VhSKrgzzpxZ4SemHcuSvHMegVzqQRqv1hs=EG1A47MBnyA@mail.gmail.com>
In-Reply-To: <CAHC9VhSKrgzzpxZ4SemHcuSvHMegVzqQRqv1hs=EG1A47MBnyA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Jul 2024 16:19:50 -0400
Message-ID: <CAHC9VhRXoDtuKyNnQav+qNeqh76-YYSo2V2r6dDYYrk9E0oPaQ@mail.gmail.com>
Subject: Re: [PATCH v14 3/3] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 9:59=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Jul 10, 2024 at 7:15=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> > On Wed, Jul 10, 2024 at 10:41=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Jul  9, 2024 KP Singh <kpsingh@kernel.org> wrote:
>
> ...
>
> > > > A static key guards whether an LSM static call is enabled or not,
> > > > without this static key, for LSM hooks that return an int, the pres=
ence
> > > > of the hook that returns a default value can create side-effects wh=
ich
> > > > has resulted in bugs [1].
> > >
> > > I don't want to rehash our previous discussions on this topic, but I =
do
> > > think we either need to simply delete the paragraph above or update i=
t
> > > to indicate that all known side effects involving LSM callback return
> > > values have been addressed.  Removal is likely easier if for no other
> > > reason than we don't have to go back and forth with edits, but I can
> >
> > Agreed, we can just delete this paragraph. Thanks!
>
> Okay, I'll do that.  I'll send another note when it is merged into
> lsm/dev, but as I said earlier, that is likely a few weeks out.  This
> will likely end up in lsm/dev-staging before that for testing, etc.

Quick follow-up that these patches are now in lsm/dev-staging, I'll
send another note when they are merged into lsm/{dev,next}.

--=20
paul-moore.com

