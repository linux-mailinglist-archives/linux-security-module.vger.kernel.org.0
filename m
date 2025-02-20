Return-Path: <linux-security-module+bounces-8277-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC6A3E319
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Feb 2025 18:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9BC27A9A67
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Feb 2025 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C311D213E67;
	Thu, 20 Feb 2025 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GCU/qqwr"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F4212B0A
	for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074049; cv=none; b=PgAluZ99eBSdJ5rPbZqv9+5beb/n8fFmvPN60e4yFiKVhfxbmFm9IxxifJ9clGd3eJgsP25Y8MwohaLMgbHHSxhedaijq7HofIfoHvdR9rSvApuS/gRxUbXaXqHP84Of3okGQnp3A/tpjzOmFRHFjnsttCvluJctPUGF+MJOp6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074049; c=relaxed/simple;
	bh=v9o39KN4rf7J0rFTCHfTh5J71196URRoypu2r0Y2nUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKvJIqRv8Etjco5e5ONX5fBgfn0tBoHWV8WLmOHkoBwbnHiDRS603Fy2qgldD220Us2EhTW2CGJRWE5gCsbAiSXrw1XjUjxNYUH/35uIbCFy281/d0tWi+6skh5yOcmSitFOCLNOPt0U+7NTZkse/UdbDGI1liuSP8AiZ4aUd+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GCU/qqwr; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fb8de54da9so8062547b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2025 09:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740074047; x=1740678847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1HtEq2i29q2cCGod66wbAEwSCdOwa+YaZodXQk7MLA=;
        b=GCU/qqwr4ul3h2OA//qtA3Kg4HvKFJcc/I7Jpn7HUjvxUD/Z8pfsU24JR2YX/m+wLo
         m4GDKc1AKm5wQlC84gG7KfZpB4T23bqcpMFSRaIkoQOA3ylfjBwQGTwqkiO2SfUjd/Br
         JtC3+Bq2rvVy3CN3SQ3xAVIMcq/7Y5cvpyeGp8bmEf+2Ga9bPwDdJcjoglw27crknkrW
         l2dVg86ssi5I73ii6at15dvVlvwzLMTYVcywcHXluEb2bjWYDs8Ik0B4Mc2exrpXGTa+
         3t6jOLn5YAck5s38mmywQ4decwEscoGWei4hsR5/Ge8b3CGooQbIMUMVhKrUCdi8lt03
         BzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074047; x=1740678847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1HtEq2i29q2cCGod66wbAEwSCdOwa+YaZodXQk7MLA=;
        b=wiHd4KjCwCWKxwt4nYCmVjbkHBS+Ev2AE52L+KgOWQTGL3cx5Vl93ezRPnGmHC5Z90
         kbFFljzZ3iZHrjUtWGECvAy5T9GQNzQ15kHbM+Nmd/jZiPanW6lMQkr7Yqc7iWiVmQEf
         gVxyNehuAjmrA6ruLArw+c/xwSdzrggHbbeezityqCxSH36F6vSm9TFGP7RO7C5HZrZD
         bqIZ1WSmMKpqQ2Tp2135UrKIGUM98c0Gt1LfE9iJw7gwrVq4l1mceI34C5mEHfEcQutP
         59w9mEMegTXT6/ze1uueeuU8EfgB6bkAFutA8xamFCC+7ZVnT+iDMgl1ZyRajgAvKN/A
         J9Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVmFy7a5k3xwK/zOFHFMjr+u9xtsawPb5jlLuyoBFTesYRGPEjaIr2L7ORdGLZuUnC3IxhQ+gDspuv4/ojv6oYnoT7WJGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRTBi4XI/mFWxmXmPZN3Fqj3hIcUOGdrZI5Gzg9udPRkdGFLPo
	mSkcGsoLba4VrP33EjzU6RW6NQk/1xqsmle4p+/3kmOaSotRxieN9Q7Aukh959UtAboT2Eh2tHO
	MI6eZ3cyfDIPF7qwNh37WASwQFoFjjzb/l9HJ
X-Gm-Gg: ASbGncsj8nk/9Gr1AzKxGwzH2E5l2v8k3yqu2jj+ZfB8RWtIINEOl6R1zW+3Jqla2Eg
	AuFPyVyJ2c2yoQ2NhnMTnZgBaGPMFPUQShVcHzt5ELNWpL64tVmbN+XyBx8C0+Fkr7FWEe4zI
X-Google-Smtp-Source: AGHT+IHrPz3tW5dtSDxUsese0JE02d7KHywEHhvtKWjvvLDIJZskZ/lBY77itdhauU3533DejxGGJ4lZEYLYaXcdqdA=
X-Received: by 2002:a05:690c:360b:b0:6ef:6d61:c254 with SMTP id
 00721157ae682-6fb58355946mr175779697b3.38.1740074046600; Thu, 20 Feb 2025
 09:54:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-5-casey@schaufler-ca.com> <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
 <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
In-Reply-To: <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Feb 2025 12:53:54 -0500
X-Gm-Features: AWEUYZkT0XtBSwseF0EpgbYRnzcGcXTRcWyfKrtkB2GGxStsTDHjaiFMHWD25CU
Message-ID: <CAHC9VhQUUOqh3j9mK5eaVOc6H7JXsjH8vajgrDOoOGOBTszWQw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Thu, Feb 20, 2025 at 11:43=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Oct 23, 2024 at 5:23=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> > >
> > > Replace the (secctx,seclen) pointer pair with a single lsm_context
> > > pointer to allow return of the LSM identifier along with the context
> > > and context length. This allows security_release_secctx() to know how
> > > to release the context. Callers have been modified to use or save the
> > > returned data from the new structure.
> > >
> > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Cc: ceph-devel@vger.kernel.org
> > > Cc: linux-nfs@vger.kernel.org
> > > ---
> > >  fs/ceph/super.h               |  3 +--
> > >  fs/ceph/xattr.c               | 16 ++++++----------
> > >  fs/fuse/dir.c                 | 35 ++++++++++++++++++---------------=
--
> > >  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
> > >  include/linux/lsm_hook_defs.h |  2 +-
> > >  include/linux/security.h      | 26 +++-----------------------
> > >  security/security.c           |  9 ++++-----
> > >  security/selinux/hooks.c      |  9 +++++----
> > >  8 files changed, 50 insertions(+), 70 deletions(-)
> > >
> >
> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > index 76776d716744..0b116ef3a752 100644
> > > --- a/fs/nfs/nfs4proc.c
> > > +++ b/fs/nfs/nfs4proc.c
> > > @@ -114,6 +114,7 @@ static inline struct nfs4_label *
> > >  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
> > >         struct iattr *sattr, struct nfs4_label *label)
> > >  {
> > > +       struct lsm_context shim;
> > >         int err;
> > >
> > >         if (label =3D=3D NULL)
> > > @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir, str=
uct dentry *dentry,
> > >         label->label =3D NULL;
> > >
> > >         err =3D security_dentry_init_security(dentry, sattr->ia_mode,
> > > -                               &dentry->d_name, NULL,
> > > -                               (void **)&label->label, &label->len);
> > > -       if (err =3D=3D 0)
> > > -               return label;
> > > +                               &dentry->d_name, NULL, &shim);
> > > +       if (err)
> > > +               return NULL;
> > >
> > > -       return NULL;
> > > +       label->label =3D shim.context;
> > > +       label->len =3D shim.len;
> > > +       return label;
> > >  }
> > >  static inline void
> > >  nfs4_label_release_security(struct nfs4_label *label)
> > >  {
> > > -       struct lsm_context scaff; /* scaffolding */
> > > +       struct lsm_context shim;
> > >
> > >         if (label) {
> > > -               lsmcontext_init(&scaff, label->label, label->len, 0);
> > > -               security_release_secctx(&scaff);
> > > +               shim.context =3D label->label;
> > > +               shim.len =3D label->len;
> > > +               shim.id =3D LSM_ID_UNDEF;
> >
> > Is there a patch that follows this one to fix this? Otherwise, setting
> > this to UNDEF causes SELinux to NOT free the context, which produces a
> > memory leak for every NFS inode security context. Reported by kmemleak
> > when running the selinux-testsuite NFS tests.
>
> I don't recall seeing anything related to this, but patches are
> definitely welcome.

Looking at this quickly, this is an interesting problem as I don't
believe we have enough context in nfs4_label_release_security() to
correctly set the shim.id value.  If there is a positive, it is that
lsm_context is really still just a string wrapped up with some
metadata, e.g. length/ID, so we kfree()'ing shim.context is going to
be okay-ish, at least for the foreseeable future.

I can think of two ways to fix this, but I'd love to hear other ideas too.

1. Handle the LSM_ID_UNDEF case directly in security_release_secctx()
and skip any individual LSM processing.

2. Define a new LSM_ID_ANY value and update all of the LSMs to also
process the ANY case as well as their own.

I'm not finding either option very exciting, but option #2 looks
particularly ugly, so I think I'd prefer to see someone draft a patch
for option #1 assuming nothing better is presented.

--=20
paul-moore.com

