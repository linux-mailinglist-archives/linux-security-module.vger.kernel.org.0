Return-Path: <linux-security-module+bounces-8328-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95A7A4333F
	for <lists+linux-security-module@lfdr.de>; Tue, 25 Feb 2025 03:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E27189B0E4
	for <lists+linux-security-module@lfdr.de>; Tue, 25 Feb 2025 02:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A39114EC7E;
	Tue, 25 Feb 2025 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UxM7a5Ap"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38914D2BB
	for <linux-security-module@vger.kernel.org>; Tue, 25 Feb 2025 02:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740451498; cv=none; b=fT9+urKSe4u26bNz43lQ/GHAX1sJ112WwJR7KQx/YPTt6FWrqMuXq1u8b+OugVovAklTm9lWgFa4ImXpR1KVYvdcL88AqWKAohg1TsD1s29X5UaSG2MAgeM82Z17etCiZR7Js/YS6qwdWe25so89QYyUaOAhS9nIQfQVxqQagak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740451498; c=relaxed/simple;
	bh=G4AaLuOfuFOLRHwflR3exrlohcUM8IPNRJsM/xbWELk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUJLEISOlljnHpIzFclxpbjZtkSeN3vFmCDX3TCUnEbuRGXe7hwXBwbsBEZMNwqslQgKFtWVM+51jDIP4bkuJTpKzriTIqI3rKbMZV1WymCG9wxVWamkahoTQPotNbbG4H7FusYWQIaiHLkCFslQfbYKg6AwWHSheV/Z279jmuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UxM7a5Ap; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e5dcc411189so4513848276.0
        for <linux-security-module@vger.kernel.org>; Mon, 24 Feb 2025 18:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740451495; x=1741056295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZHMO1MusgqHKcnIcQm7DznqJJ3BDbghAgQCqfbAqbc=;
        b=UxM7a5ApfgMRRK4+wkFuZs0SXswUN/RAo3turaUuSVO+gnmYVIbKqm1Wk9QgYVzkzG
         Mk9I4utu6g6I2Ge6GBlxW1bJhf1yclmE4pPlsSl2W4v5+nn5pj97ZPi58WYi3ctYBz1h
         G78cgp4hJns+zDJkFdOt7s1ODKLTzSLjrzAu1YKNXlqvyZ3UtfBqe4KdDum+Lrodjhlh
         wTC8pbZYzzQf3YgcmtARC/Fb09CjuarnuxqdpRAhdGveH++TCNT40tavlxElb+NyUYYD
         OmtcJPxkvft0k7/aJBMTtwFUIqAObK0iMcH4w2TO1Y1kgtJSkDnIW2eXxVkJIA3z9mzN
         3Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740451495; x=1741056295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZHMO1MusgqHKcnIcQm7DznqJJ3BDbghAgQCqfbAqbc=;
        b=TksCBN2qbLNv/vdBxDRZrjhckRDONWYa261ckixmtKUQrEHwIipjTUi90sPPcxRIyT
         gRBZM9YbKkrw5FW9O9J4frTSM4FVEgnl+EScrdcEuZMFJoT14dsn6mYSSoUxVa+BbWtY
         Nnp+M3nskCN799Z6Q6w8+PosJ0Jp6oSsbTuwnDpcqaJNqu8W0V+WwQMdHKNq1VA2ghTI
         uvRh1EEm7IxrqlIOUVYx7mIguSXCwj8EkDeV5sMJrklxOUxZboGt0Ych4hautP+nFjyV
         W/bDC3mDvzOU2pAUdRezf9Dj7j7/fmF9VXpK54IUwmnyU6jDzO2miCmNba7BDl1Gp0Ac
         w63A==
X-Gm-Message-State: AOJu0YzJHxTiEW22FXi69S53RnRZHDHkkqziamWz8I1iRuVoUaXxigFM
	kb2650Tta3wfU7m/HU7erZ4VljOZ+y81M2BmYnQNyHexefUD+ZGjalp40fd1OhuZrPkzGmqi1wK
	3ujFP9jK/Fay32hltpn0aPlgFu9R80PdKunVd
X-Gm-Gg: ASbGncvqK81NN3B55hmKINR6XGmtaZ2wqp5uWOJPHfhgAuoT2tSk0ghhFijW81F4igA
	zCs+gyfdAmcIWW1+0ARJc2otmTAVGGuOjB67Lxx8J8iO7yaYT9ARyUNconLWDdJbE5KfT7Yc4JP
	z352Bi6JE=
X-Google-Smtp-Source: AGHT+IGEa5U4A4yo9wKCeqXls7VYJGzP9WTgTlGjlbzj8vKJz4/0uKiW+lecKV7cv36qxYkZwt3p/isMQ/xqDtTijDY=
X-Received: by 2002:a05:6902:248c:b0:e60:78b7:faf1 with SMTP id
 3f1490d57ef6-e607a5033a2mr1188408276.21.1740451495085; Mon, 24 Feb 2025
 18:44:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220192935.9014-2-stephen.smalley.work@gmail.com> <CAHC9VhTXzweNA+h37ZBMjymbuar32tmr4aa9Qphk8JM4ya+y0A@mail.gmail.com>
In-Reply-To: <CAHC9VhTXzweNA+h37ZBMjymbuar32tmr4aa9Qphk8JM4ya+y0A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 24 Feb 2025 21:44:44 -0500
X-Gm-Features: AQ5f1JrwR5Q5ueFKhAnYW1GTCbwY8DQ1wmiRFSoelyJ3mEeKiHxAjP12XZyZsH8
Message-ID: <CAHC9VhRp1Q6VsYNPmcQ480j8FLamSkMSj=HzBU0MuikEbgQvRw@mail.gmail.com>
Subject: Re: [PATCH] lsm,nfs: fix memory leak of lsm_context
To: Stephen Smalley <stephen.smalley.work@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, 
	casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Feb 20, 2025 at 2:30=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security=
")
> > did not preserve the lsm id for subsequent release calls, which results
> > in a memory leak. Fix it by saving the lsm id in the nfs4_label and
> > providing it on the subsequent release call.
> >
> > Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security=
")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  fs/nfs/nfs4proc.c    | 7 ++++---
> >  include/linux/nfs4.h | 1 +
> >  2 files changed, 5 insertions(+), 3 deletions(-)
>
> Now that we've seen Casey's patch, I believe this patch is the better
> solution and we should get this up to Linus during the v6.14-rcX
> phase.  I've got one minor nitpick (below), but how would you like to
> handle this patch NFS folks?  I'm guessing you would prefer to pull
> this via the NFS tree, but if not let me know and I can pull it via
> the LSM tree (an ACK would be appreciated).
>
> Acked-by: Paul Moore <paul@paul-moore.com>

I realize it's only been a couple of days, but pinging the NFS
maintainers directly in case this has fallen off their radar ...

> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index df9669d4ded7..c0caaec7bd20 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -133,6 +133,7 @@ nfs4_label_init_security(struct inode *dir, struct =
dentry *dentry,
> >         if (err)
> >                 return NULL;
> >
> > +       label->lsmid =3D shim.id;
> >         label->label =3D shim.context;
> >         label->len =3D shim.len;
> >         return label;
> > @@ -145,7 +146,7 @@ nfs4_label_release_security(struct nfs4_label *labe=
l)
> >         if (label) {
> >                 shim.context =3D label->label;
> >                 shim.len =3D label->len;
> > -               shim.id =3D LSM_ID_UNDEF;
> > +               shim.id =3D label->lsmid;
> >                 security_release_secctx(&shim);
> >         }
> >  }
> > @@ -6269,7 +6270,7 @@ static int _nfs4_get_security_label(struct inode =
*inode, void *buf,
> >                                         size_t buflen)
> >  {
> >         struct nfs_server *server =3D NFS_SERVER(inode);
> > -       struct nfs4_label label =3D {0, 0, buflen, buf};
> > +       struct nfs4_label label =3D {0, 0, 0, buflen, buf};
> >
> >         u32 bitmask[3] =3D { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
> >         struct nfs_fattr fattr =3D {
> > @@ -6374,7 +6375,7 @@ static int nfs4_do_set_security_label(struct inod=
e *inode,
> >  static int
> >  nfs4_set_security_label(struct inode *inode, const void *buf, size_t b=
uflen)
> >  {
> > -       struct nfs4_label ilabel =3D {0, 0, buflen, (char *)buf };
> > +       struct nfs4_label ilabel =3D {0, 0, 0, buflen, (char *)buf };
> >         struct nfs_fattr *fattr;
> >         int status;
> >
> > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > index 71fbebfa43c7..9ac83ca88326 100644
> > --- a/include/linux/nfs4.h
> > +++ b/include/linux/nfs4.h
> > @@ -47,6 +47,7 @@ struct nfs4_acl {
> >  struct nfs4_label {
> >         uint32_t        lfs;
> >         uint32_t        pi;
> > +       u32             lsmid;
>
> I don't think this is a significant problem, but considering that
> lsm_context::id is an int, the lsmid field above should probably be an
> int too.
>
> >         u32             len;
> >         char    *label;
> >  };
> > --
> > 2.47.1

--=20
paul-moore.com

