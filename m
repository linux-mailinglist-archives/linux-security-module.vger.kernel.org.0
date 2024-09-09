Return-Path: <linux-security-module+bounces-5404-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F350971F74
	for <lists+linux-security-module@lfdr.de>; Mon,  9 Sep 2024 18:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5585128361A
	for <lists+linux-security-module@lfdr.de>; Mon,  9 Sep 2024 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5EF16D4E5;
	Mon,  9 Sep 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dspXmpuu"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D9165EE8
	for <linux-security-module@vger.kernel.org>; Mon,  9 Sep 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900270; cv=none; b=rig0iQuc8TLcwVcUOwrRn+bj1yzMIwSHS1Vmem7Dqhfq3Ab/7YlpxTM2bvQC1rV+aJq7Hd0O3i108ttj+KishzcdKAyJB0paiuE58NRz64BaB3YoYgyexzP8OHCx1HkZ4dmEFMU3tf5xP2Q399kAniiSjcTCoo1CT6HRs7npAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900270; c=relaxed/simple;
	bh=V5SufoawHf+c/KapMgHuCcvMRxuPqRJLaGR2qrGPwSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MO/6Cpzn7dcIso6iqkyOyE4oxvyQTc3FFyc6SA2ot4sCG95hTwJAJx8B9ZQMToOTdcQ++04FvYcidyRRJrg4YDpE5Xn91LP3Ehs9oltkXFmfszuG78irlkTloPkgUyJQFiWnvpPEV4I1vSA+NjQaswf78sGZ1JRbuWC7EDidRnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dspXmpuu; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b47ff8a59aso44213537b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 09 Sep 2024 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725900267; x=1726505067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxOwYLSJGdDaOpYEoZbgLMtvbt8O5f37ZwwE3/MPh0Y=;
        b=dspXmpuu4CctlS61i0tk0zQTTIlNCINnKPgMSeR1uu7BWRsWVYOv76U5KIpLlmU9Ih
         AcdQI03S0sU4hGMI9M1S7aAXFv7TQfzhvOzSW2duHWMFzDhKZKksQSUrL1WTVjPwBc6J
         HQVLegnpMEjwut/snWK5QSKKoWqaNamFF0z+p6P09xLAhGMj9sejtH4bE0BpkggLi2Bp
         W7hLpm379O2xF016SyU9YHzsFUoDMUy++fjVmfYRxB3R6xZA4ev+VlOmQbcM7yhipp2/
         U1rlvAyB/SFUua6ZjS7DUyVF4VUWKxtEpqK1jwo9PSdkceWTcgL3je0nGrebxYs9WSC2
         1CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725900267; x=1726505067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxOwYLSJGdDaOpYEoZbgLMtvbt8O5f37ZwwE3/MPh0Y=;
        b=UYZUTWkp8Wy0FoyTCmFLsALJ21anSzwsGnZEB34jUNDdnP+UWnCm00e4rZSEa+sQ2L
         /C4ZJm+r+wH0oadtuufFNR+j+sZLXpQg3b4h9qc5wYilS/qv1B46VIXzoaO9VsLecUbq
         3G4twpbwHgFJCf8LVoyOyERqFAD0F3nB0tFEIm9Sz/D03rMUymiP0oRxEvCd6hcthtXy
         u2v8Iiw2Om+CIyBuO4e+gv8Q4mF1O+jfA43zH3itoxre8g4b28wxPIUYPMTLZes58Mtz
         QHjsT5otN5w8SKoj5Wx/Qaiuj+rDwL6R5aYN0++BTVqaD5rDndK7Y13MBZ7M/zA88Bz8
         8r9g==
X-Forwarded-Encrypted: i=1; AJvYcCUoqs+PB745x6Qw73cwoNjzw6AWe5CnELPFARQFEiC7OoqUb7RtFWkXdAa+Rgs3omX7fenvtOLYLiDYwyVB9xw9W605ymQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw16L5jXfkbavQ17NcO5s0a1jad/Ln7a4EvGD2SSvPAhARZf6bN
	YBKawqGuCSlAXQBauARcg3AFhRrODD9ohgz3cSXIGXcmfwoST8RJWDYTt388TU77V/fcuPVvF2g
	ZdMtGHS3SHaA6vW3YLEszAy+qLMuHdw/v3mbWWBcWYMsweAA=
X-Google-Smtp-Source: AGHT+IG7ZtUx+p0eIcFiA2aT/49RI9azAwsEGWfUBykItgqPxBanhFUfYeMZLMxZBjYL9zvoU+ThTDKRjel2opLiwVA=
X-Received: by 2002:a05:690c:338c:b0:6b3:f01c:9a57 with SMTP id
 00721157ae682-6db4516cd86mr141309817b3.35.1725900267026; Mon, 09 Sep 2024
 09:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821095609.365176-1-mic@digikod.net> <CAHC9VhQ7e50Ya4BNoF-xM2y+MDMW3i_SRPVcZkDZ2vdEMNtk7Q@mail.gmail.com>
 <20240908.jeim4Aif3Fee@digikod.net> <CAHC9VhSGTOv9eiYCvbY67PJwtuBKWtv6nBgy_T=SMr-JPBO+SA@mail.gmail.com>
In-Reply-To: <CAHC9VhSGTOv9eiYCvbY67PJwtuBKWtv6nBgy_T=SMr-JPBO+SA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Sep 2024 12:44:16 -0400
Message-ID: <CAHC9VhTck26ogxtTK-Z_gxhhdfYR4MgHystKdWttjsXcydyB9A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: Fix file_set_fowner LSM hook inconsistencies
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:03=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sun, Sep 8, 2024 at 2:11=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> >
> > On Wed, Aug 21, 2024 at 12:32:17PM -0400, Paul Moore wrote:
> > > On Wed, Aug 21, 2024 at 5:56=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic=
@digikod.net> wrote:
> > > >
> > > > The fcntl's F_SETOWN command sets the process that handle SIGIO/SIG=
URG
> > > > for the related file descriptor.  Before this change, the
> > > > file_set_fowner LSM hook was always called, ignoring the VFS logic =
which
> > > > may not actually change the process that handles SIGIO (e.g. TUN, T=
TY,
> > > > dnotify), nor update the related UID/EUID.
> > > >
> > > > Moreover, because security_file_set_fowner() was called without loc=
k
> > > > (e.g. f_owner.lock), concurrent F_SETOWN commands could result to a=
 race
> > > > condition and inconsistent LSM states (e.g. SELinux's fown_sid) com=
pared
> > > > to struct fown_struct's UID/EUID.
> > > >
> > > > This change makes sure the LSM states are always in sync with the V=
FS
> > > > state by moving the security_file_set_fowner() call close to the
> > > > UID/EUID updates and using the same f_owner.lock .
> > > >
> > > > Rename f_modown() to __f_setown() to simplify code.
> > > >
> > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: James Morris <jmorris@namei.org>
> > > > Cc: Jann Horn <jannh@google.com>
> > > > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > > ---
> > > >
> > > > Changes since v2:
> > > > https://lore.kernel.org/r/20240812174421.1636724-1-mic@digikod.net
> > > > - Only keep the LSM hook move.
> > > >
> > > > Changes since v1:
> > > > https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> > > > - Add back the file_set_fowner hook (but without user) as
> > > >   requested by Paul, but move it for consistency.
> > > > ---
> > > >  fs/fcntl.c | 14 ++++----------
> > > >  1 file changed, 4 insertions(+), 10 deletions(-)
> > >
> > > This looks reasonable to me, and fixes a potential problem with
> > > existing LSMs.  Unless I hear any strong objections I'll plan to merg=
e
> > > this, and patch 2/2, into the LSM tree tomorrow.
> >
> > I didn't see these patches in -next, did I miss something?
> > Landlock will use this hook really soon and it would make it much easie=
r
> > if these patches where upstream before.
>
> Ah!  My apologies, I'll do that right now and send another update once
> it's done.  FWIW, I'm going to tag 1/2 for stable, but since we are at
> -rc7 presently I'll just plan to send it during the next merge window.

Merged into lsm/dev, thanks for the nudge :)

--=20
paul-moore.com

