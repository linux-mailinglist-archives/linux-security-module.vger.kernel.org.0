Return-Path: <linux-security-module+bounces-11624-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3573B3B988
	for <lists+linux-security-module@lfdr.de>; Fri, 29 Aug 2025 12:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDBEA21652
	for <lists+linux-security-module@lfdr.de>; Fri, 29 Aug 2025 10:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969E0311598;
	Fri, 29 Aug 2025 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W+mcKVMq"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6431062C
	for <linux-security-module@vger.kernel.org>; Fri, 29 Aug 2025 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465017; cv=none; b=rzwmQDSKQwKmgXTx/jgMtF+z9MF+sANyDMaud0oJaubU0xENkCtbNC809DTEouUu6t/nSDlnRFKeEJVigVlLv34TWZ822My+Txwu04EarjrItyRe50AohoNNB5uPto3GI73dCadJS6KwdqE0sgikGTzXkb0eLqy8cAhEEkWA5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465017; c=relaxed/simple;
	bh=4JhnELOzvG8e3FT52auD4scH9nQubd86lYx6BkLcuWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQfeb/gHH27C/7OTKZnIseVEiGF7lolrTUgVRNcypKo5i32rkS0/oSquMyjTEpfY7A+8TixyU08ched66V7UOvCtgW5ygxrw21eaL44RsObYsiyauCLyh9Ln3RJGPQzo2unAcfRBrVzMp8hBULnbGJIsX9nJZ5JXzT6D5Fl5Nvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=W+mcKVMq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so1589202a91.2
        for <linux-security-module@vger.kernel.org>; Fri, 29 Aug 2025 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756465015; x=1757069815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6MPSbkVIlc+V387DVzsSzTxYHOue4NoSXRJwOKRRC4=;
        b=W+mcKVMq+nWiUQA68i2gIqIOl0K4KWfARp+OVsi1I2sDcmLkkOXsewgYzs5PChRSKq
         x8xxtTqW21eQqjSAGsjjA0NapSNsq6XbS6ba4r9j8X0YT99dO1V/rIFZCOE/iBgAxuF2
         bxxJ5SXxoUTX5hu2hOMJjGpsjY0ZTqbNQ1XFdgYyVU/nwEW8rzZiJYItSxilp5GBshIu
         K1fPVY3pibILmSfsRyJb2cFMMl8MIRSrZKRT23xrMnXsxzdm/wVQvnvcLvVfnw5Hagdf
         1I+CutVJFYSRLOW08yj7uKd7aEuhu9T37Fdremp9xrKVArLaGnErDGzRAHvNnbLpsSz7
         3mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756465015; x=1757069815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6MPSbkVIlc+V387DVzsSzTxYHOue4NoSXRJwOKRRC4=;
        b=cTVFA2nFOacQ7FY10ii5zujRggtvyQklR4lbezM5C2e7MWiL0AVyZhULOTYezMh7t5
         49dELa1RaaZJJYsGGGy1apVZxLYpAEhzzpBNVozY0uUQz9PurhyQGleZhlh27VePwFyb
         I3Nl24kT9PtkBWym81sW7fm9RgpZuO5JFEnb+4VfhbOF+Pjne1iB55o3tDMXkj3ANAW3
         eleodnAm3QY/gLaZTqMjHxvHLccmwlhAhulnFkdzT6LLH3LDsoY2KyuiEFeAg6cNbrgb
         p0HAGhHJT8CLYCFS4ww/Z6yTiloyrKZzF3PSqBOntd0NdZbDeW0iurUwURjoP8NiWmU9
         gqiw==
X-Forwarded-Encrypted: i=1; AJvYcCWW0RS2mmnEcv1QNzRAS0W5YWI2GJYSZtc5FN0fgLbOrvbmAMQlw31SEx2eMDJcPwp0JyDv+Ku3GW0+HTV06Zftu4a28Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydM9pOacrBr7H3kd6HeRBL7LBiuMzc9A4Ct0s+aDR7LfwDksij
	RNz/qFgwoC/uB++trDLZr8WaqNUkHNHLpWPPy53NiKSk1+MU3ZTaNz4Yuej45y4YIFkSYd/bs/G
	S4Ok1GWG47lbRaGbh6vWhSYxfllwElLiZzBzvrGaq
X-Gm-Gg: ASbGncshF53p8TWovY5gK3adGd8a2muQG5ptdHpmzorcVpTrgOvsLF7V/AOs5O1PLws
	PPIzWEP8XRVxzi6rqvMonfuotK0tlklilUVxPLDQL+UxXsTyGUf6v6SWxLVsx/86xc8vP8SC7di
	4iAEXcZ7KqVJKP4zCDLM9bjCUmikNSfI8cf6VlGgn0CfhbWXp8YnovynTl0DJ4en+HSmpfCyZn8
	4AQJ+zdJQBodp3c+9U=
X-Google-Smtp-Source: AGHT+IGDPrqU3qCXUsbx1z+D7spAudal7m6VvB/YAbl6Q44JNBA1bTqtvYkoa8fRk6dewuZp4Ua7WUer9nRt/kc21go=
X-Received: by 2002:a17:90b:2f87:b0:31f:8723:d128 with SMTP id
 98e67ed59e1d1-32517b2db8fmr34283941a91.34.1756465015189; Fri, 29 Aug 2025
 03:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826031824.1227551-1-tweek@google.com> <CAEjxPJ6G2iK9Yp8eCwbwHQfF1J3WBEVU42kAMQHNuuC_H5QHNw@mail.gmail.com>
 <CAEjxPJ70O5SY=XYJKrQDLkHOO3spD4VSjYCv0LkhYKCvK=GP7Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ70O5SY=XYJKrQDLkHOO3spD4VSjYCv0LkhYKCvK=GP7Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Aug 2025 06:56:43 -0400
X-Gm-Features: Ac12FXwA4RT9c8sFjxx8AgkdJv47bPShawvWIx_UbmmXOiQU9WoRBN8gx-RGKJY
Message-ID: <CAHC9VhSkBSyHRRimb0Br9nJD02ZN_wgDY1A7uWuMh9rXhFSuzg@mail.gmail.com>
Subject: Re: [PATCH] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	James Morris <jmorris@namei.org>, Hugh Dickins <hughd@google.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 9:30=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Aug 27, 2025 at 9:23=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Mon, Aug 25, 2025 at 11:18=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@=
google.com> wrote:
> > >
> > > Prior to this change, no security hooks were called at the creation o=
f a
> > > memfd file. It means that, for SELinux as an example, it will receive
> > > the default type of the filesystem that backs the in-memory inode ...
>
> Also, we'll need a corresponding patch to define the new policy
> capability in libsepol, and will need to de-conflict with the other
> pending patches that are also trying to claim the next available
> policy capability bit (so you may end up with a different one
> upstream).

My apologies for the late reply, I have limited network access this
week and haven't yet been able to give this a proper review, but I
expect things to get back to normal next week.  That said, Stephen's
comments about a test suite addition are important, and I would like
to see a test addition before merging this code both to ensure this
works on a wider range of SELinux based systems beyond Android (you
should also test this on something other than Android, e.g. a modern
Fedora system) and to provide a reliable test that we can use to test
for regressions in the future.

As far as the policy capability bit offset is concerned, don't worry
too much about that right now.  Allocated magic numbers like the
policy capability bits are never really fixed until they land in an
upstream tree (technically not until they land in a proper tagged
release from Linus); if/when a patch is merged that requires a new
capability bit I simply assign it the next unused offset at the time
the patch is merged.  Other approaches either end up potentially
creating holes in the capability bitmap (yuck) or creating merge
dependencies between otherwise independent pact{sets} (extra double
yuck).

--=20
paul-moore.com

