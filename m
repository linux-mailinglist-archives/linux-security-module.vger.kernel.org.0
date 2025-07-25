Return-Path: <linux-security-module+bounces-11251-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DABB1166C
	for <lists+linux-security-module@lfdr.de>; Fri, 25 Jul 2025 04:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0B2AE33AC
	for <lists+linux-security-module@lfdr.de>; Fri, 25 Jul 2025 02:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7CF237704;
	Fri, 25 Jul 2025 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WHRR0his"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C9233156
	for <linux-security-module@vger.kernel.org>; Fri, 25 Jul 2025 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753410522; cv=none; b=Y3H9yL5PRtTtoY1Sf98tZDhFO4YHu4gCbD1FQN0W0OKuP5uKU7q6AVUyOwTQpcLMxYLax+hl6fg6bn3Wx72fHAAGvdyQflZyRw3qLAsx447i9da1nQC+Dzjw2TuFpnpOAfgnB3x3cB+kiFVF8fgvTdLXuDKBmkArmj6YucQuDgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753410522; c=relaxed/simple;
	bh=GAnMHTlCdd99u3tfdAsMu7FC3xYg7vAJjeLv7IlrUcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBBZAV8BChDZ1CvC2+31T2EuFuZsROSRyAsG2Ko9N98XsgIN/mUvj/5NI1tZOVlUve9Ke5n6Dx81IZ+yU6k63bhOb44nj2O6mp7rwaQPnRUxw0Sjqxd4A0ixtXqN/BHAiEOM3II7joKIw49x/dMz+THvjLBfmQZ4mpyjWQn/xHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WHRR0his; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8d70c65a0aso1307641276.0
        for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 19:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753410518; x=1754015318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76kf2nT7BLoBgPFUTjrSe3BF7zBjdFtl9axEtNhkDAA=;
        b=WHRR0hisT7/TjHIoZrAL5ykqISRi1UTWMPFxYKm02upcVH4TmoYfa5/VcA+IZlxa18
         6DUDWbUaQrMtj5RyPJN4AS+W9msDkwmfW7Cxvw95ZOWpJpXbG+HYVUTT6SEl+ofgueaa
         PSPGxzuEYWfhL92ApJ7LIxp2yBlk/GAvghq+BDLGj34ZoM++ShY4sdPDw3DPpLoAaKaZ
         HPzdCXZt73+xO/M2VTV68a6msiBxqyCjrR+oC6EVf9IbnY24AqbZr3aYH/doIJNwUDlw
         87UGPU+ZInJQf9anHJUoT18AhTVbggBRB5J3NCra1fzEM3pQMRryiMOU8oB86QHafXaQ
         sFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753410518; x=1754015318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76kf2nT7BLoBgPFUTjrSe3BF7zBjdFtl9axEtNhkDAA=;
        b=tdnxE/VJhwz+EMGMv/cnITAZ8a/kD9K0RJBMoMhb2WUJa8zYLYt2UpCZNrYvXTeTuq
         vZdBSBSeG7MNDRLMYYkGo5B5WzbTo3avMVpAhwraT87pMwALws4SgV9L4reeN45cm0jv
         cGkJ4k1gULgQyEWSdpmrzfdH4gmDVwGcMb97tMuziiIs2//wfqhl7aM2yaRMb78UR/p2
         sZx4CzdOMv5lwNdWxfHX0zhslgec7V2rpgVpBEtu64kmWaGiavlai+EFz0Fb8ap9Zr9F
         TUtKlcBDifl0JGYvgFR9BWnnQeO0zUdJ+ajFkKhJ7lEpbMG6v/7Lgg9IH8KJJP9uKdix
         jHMQ==
X-Gm-Message-State: AOJu0YyaeN1z1LKpy+6DM1LUAwghRA1pwqWPZoEAPavIogxxkUWRRkH/
	4fhzjkXJVNjX3LXK8j2TEgzNWAfCo90wBVbL3OWlc7hE8kFFzq6ZL51XXUPqqNJh2bPJRhmTTUy
	YDQqyBHVmOH2uqEqFtINE/vTiOuSKMfHMDV/gmrGV
X-Gm-Gg: ASbGncuxuVg/ra3EgXg5V+KtdzxQQ7ztv2gWv7km/FMFowTgeh96Cd2tkGmvJinYSdG
	y28vy7hwKQBKmQHodFTPPLqgnaODf8sTdrZq7wCMfaULwaASps62R6a2U0J7l12aN6/Xk/aL9nG
	rtbtrBGYZMzstvXunIQJbXuPgtIkOLBV5bPrc9ocyaVH9477SFK9QAsAKVNmaD0M3NOoFDq5Yp2
	48JGqY=
X-Google-Smtp-Source: AGHT+IEJ9GccTLafI+eecGRlClmMtuHE2kwpnWx8W6YsYJWnDUno+dKKfkfNq2iUaGnrMXJN6U+a7Y6k027a8lR6STc=
X-Received: by 2002:a05:6902:12ca:b0:e8d:868a:bae1 with SMTP id
 3f1490d57ef6-e8df11147c2mr144468276.13.1753410518164; Thu, 24 Jul 2025
 19:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-47-paul@paul-moore.com>
 <6e5422c4-0458-4a15-8833-462e318f283d@schaufler-ca.com>
In-Reply-To: <6e5422c4-0458-4a15-8833-462e318f283d@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Jul 2025 22:28:26 -0400
X-Gm-Features: Ac12FXyKd_Ubn7_Mym9qREpK7hYDPp8KcVHvLsUwOoojDPjjfmv8o5G-4OtQEiM
Message-ID: <CAHC9VhThNtGCA-jmjRagJfzPJaTh9myqFcwqA4J5Zv3ojEFDfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/34] lsm: get rid of the lsm_names list and do
 some cleanup
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 11:39=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 7/21/2025 4:21 PM, Paul Moore wrote:
> > The LSM currently has a lot of code to maintain a list of the currently
> > active LSMs in a human readable string, with the only user being the
> > "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> > generate the string on first use and then cache it for subsequent use.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  include/linux/lsm_hooks.h |  1 -
> >  security/inode.c          | 59 +++++++++++++++++++++++++++++++++++++--
> >  security/lsm_init.c       | 49 --------------------------------
> >  3 files changed, 57 insertions(+), 52 deletions(-)

...

> > +/* NOTE: we never free the string below once it is set. */
> > +static DEFINE_SPINLOCK(lsm_read_lock);
> > +static char *lsm_read_str =3D NULL;
> > +static ssize_t lsm_read_len =3D 0;
> > +
> >  static ssize_t lsm_read(struct file *filp, char __user *buf, size_t co=
unt,
> >                       loff_t *ppos)
> >  {
> > -     return simple_read_from_buffer(buf, count, ppos, lsm_names,
> > -             strlen(lsm_names));
> > +     int i;
> > +     char *str;
> > +     ssize_t len;
> > +
> > +restart:
> > +
> > +     rcu_read_lock();
> > +     if (!lsm_read_str) {
> > +             /* we need to generate the string and try again */
> > +             rcu_read_unlock();
> > +             goto generate_string;
> > +     }
> > +     len =3D simple_read_from_buffer(buf, count, ppos,
> > +                                   rcu_dereference(lsm_read_str),
> > +                                   lsm_read_len);
> > +     rcu_read_unlock();
> > +     return len;
> > +
> > +generate_string:
> > +
> > +     for (i =3D 0; i < lsm_active_cnt; i++)
> > +             /* the '+ 1' accounts for either a comma or a NUL */
> > +             len +=3D strlen(lsm_idlist[i]->name) + 1;
> > +
> > +     str =3D kmalloc(len, GFP_KERNEL);
> > +     if (!str)
> > +             return -ENOMEM;
> > +     str[0] =3D '\0';
> > +
> > +     for (i =3D 0; i < lsm_active_cnt; i++) {
> > +             if (i > 0)
> > +                     strcat(str, ",");
> > +             strcat(str, lsm_idlist[i]->name);
> > +     }
> > +
> > +     spin_lock(&lsm_read_lock);
> > +     if (lsm_read_str) {
> > +             /* we raced and lost */
> > +             spin_unlock(&lsm_read_lock);
> > +             kfree(str);
> > +             goto restart;
> > +     }
> > +     lsm_read_str =3D str;
> > +     lsm_read_len =3D len;
>
> You're going to get a nul byte at the end of the string because
> you accounted for the ',' above, but there isn't one at the end
> of the string.

I'm not sure I understand your concern here, can you phrase it differently?

If you're worried about lsm_read_str potentially not being terminated
with a NUL byte, the strcat() should copy over the trailing NUL.

> > +     spin_unlock(&lsm_read_lock);
> > +
> > +     goto restart;
> >  }

--=20
paul-moore.com

