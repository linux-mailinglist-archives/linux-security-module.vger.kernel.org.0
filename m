Return-Path: <linux-security-module+bounces-1593-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A39B185ED4F
	for <lists+linux-security-module@lfdr.de>; Thu, 22 Feb 2024 00:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B532830B2
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Feb 2024 23:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9212AAE2;
	Wed, 21 Feb 2024 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DMYN6N90"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6612B14D
	for <linux-security-module@vger.kernel.org>; Wed, 21 Feb 2024 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559037; cv=none; b=U0vlmO57CPSWoofSg5E6vPRds+I3N5puPHEgYwwxGWfWHd8MVIUED5JKc3ArvSkqmXJcuD/vof1hLCcb8+9q1uvYbct05Bod5rxv4BolCI9nFBU5SdFCFHtvRlbtCbZCJ9omkr3dAHJmOg9wulwlexH6jKbsWjl9xdEmGxrnhOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559037; c=relaxed/simple;
	bh=jXUi7DaHH/tYkfvmdZwdL5O6ldHOILbUbl8SwoK93vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdVik8P8vUeda72Lne9ccyQM6mRWuEL9320JBFdOe974boAWLTOtv6k02K9nx0HH6o+L1pg/pxEdXF0ks+kixWvPRsC6tpK9o8srC+G7AjoIKWmh/oyd6keT6m9oMOB9sj218+oABgl69EAZAEYR5qzYpWUdrRr8LA4O+ipmG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DMYN6N90; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc236729a2bso6909168276.0
        for <linux-security-module@vger.kernel.org>; Wed, 21 Feb 2024 15:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708559034; x=1709163834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozpdHgEMJtLxc8z0f/xCObDDvWnU+f1l4TdamibeEB0=;
        b=DMYN6N90YpElzCrVcquPcjL+68ZSO5M7iyX1Ysv42qTiwp/rotMVr8o6Mewie3EVWH
         6VkCYIDs9OZsceV8eT/715SqP5vipSQq8BJm53ev7Jak8bqLfejNRGC60ZEdngFaBjHD
         yR2Xa+KweEdyCQ1U/IYiFUyc+gff3XevcnQRwIclqaZGPbO7+Gyh/N2bDhHANboRBTfA
         F/SqCwaEdM3e7maAwCzEolx3GWicHLwuXvWGnzGIKmfCUrRrES38YR7gNI3H2wQklfPE
         31p2G69/JMdWuV0Uo5dNqkjAX0N7C3gMXqT723vE4AIFKOiqlqkWwlveEk0rhSpt0vd3
         esLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559034; x=1709163834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozpdHgEMJtLxc8z0f/xCObDDvWnU+f1l4TdamibeEB0=;
        b=USxjFXAklZ5H1o+Mc62nWOWuY67ZP8zrriCY921w4Vr1yMDyxJGVnCejhlyRWmFvwD
         51Y6b8paWSJ3jp5HZgXv8s9/dmxWfxieg2Q5M+JyczyVRtD5bRKTYcO6T+K+kHWzTKot
         nXT7E48rqHV6BrXbUuofZ3p65+uYZjzkqsIM0lZYjra07Q1vch2x5fnsXuAPdk5OeEP1
         iEMTRdbhgEMslOYu27bnCnLIWYyvUAJYs6wflDSlZD0LuXZdkq2aR4w9XiqiAyjZokih
         gHJDM2fC9p+c19Q3wnUrT/d7iJlxIxoZNCw7Igdy/rOA8akdwmSz2rNskRhMpHhElLGu
         Rmvg==
X-Forwarded-Encrypted: i=1; AJvYcCVTsBiaTdzgXpLa3JQ/dHWfFcZN3uQ/7x6py0njvfZwQEpMKa5czLtDvTklpBiAs590E6HjQ0Eav96fq0BUj3jaDurKLYpaIG0YGYPucfMWR8NtZqpU
X-Gm-Message-State: AOJu0Yxpf9A5QpHlZjf1FllkIG5R2l+Q69XsFewmcoZYbaoH/OgKRWV/
	T19zY4iVx3RIG9RW68S7YdPDvuvnNPsTwybwCAI1nMPoKAY74uyGJcop8rFHcFR/0NW8O7MC/aS
	fTjsZ3i82+v+YWC7ow9QVmR2PcWS5m+wh4Rck
X-Google-Smtp-Source: AGHT+IGHrH5g+9KgtuY77JnAmJfeyj21kEZdzhwPpy55HJt0kZAi28H0jeAtPv8SyPEbdcHCUbHgVHOylR1JMSl3Amo=
X-Received: by 2002:a25:a285:0:b0:dc6:db0c:4ff0 with SMTP id
 c5-20020a25a285000000b00dc6db0c4ff0mr912234ybi.32.1708559033944; Wed, 21 Feb
 2024 15:43:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org> <20240221-idmap-fscap-refactor-v2-15-3039364623bd@kernel.org>
In-Reply-To: <20240221-idmap-fscap-refactor-v2-15-3039364623bd@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Feb 2024 18:43:43 -0500
Message-ID: <CAHC9VhRQ7Xa2_rAjKYA_nkpmfUd9jn2D0SNcb6SjQFg=k8rn=w@mail.gmail.com>
Subject: Re: [PATCH v2 15/25] security: call evm fscaps hooks from generic
 security hooks
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:25=E2=80=AFPM Seth Forshee (DigitalOcean)
<sforshee@kernel.org> wrote:
>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  security/security.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

First off, you've got to write *something* for the commit description,
even if it is just a single sentence.

> diff --git a/security/security.c b/security/security.c
> index 0d210da9862c..f515d8430318 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2365,9 +2365,14 @@ int security_inode_remove_acl(struct mnt_idmap *id=
map,
>  int security_inode_set_fscaps(struct mnt_idmap *idmap, struct dentry *de=
ntry,
>                               const struct vfs_caps *caps, int flags)
>  {
> +       int ret;
> +
>         if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>                 return 0;
> -       return call_int_hook(inode_set_fscaps, 0, idmap, dentry, caps, fl=
ags);
> +       ret =3D call_int_hook(inode_set_fscaps, 0, idmap, dentry, caps, f=
lags);
> +       if (ret)
> +               return ret;
> +       return evm_inode_set_fscaps(idmap, dentry, caps, flags);
>  }
>
>  /**
> @@ -2387,6 +2392,7 @@ void security_inode_post_set_fscaps(struct mnt_idma=
p *idmap,
>         if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>                 return;
>         call_void_hook(inode_post_set_fscaps, idmap, dentry, caps, flags)=
;
> +       evm_inode_post_set_fscaps(idmap, dentry, caps, flags);
>  }
>
>  /**
> @@ -2415,9 +2421,14 @@ int security_inode_get_fscaps(struct mnt_idmap *id=
map, struct dentry *dentry)
>   */
>  int security_inode_remove_fscaps(struct mnt_idmap *idmap, struct dentry =
*dentry)
>  {
> +       int ret;
> +
>         if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>                 return 0;
> -       return call_int_hook(inode_remove_fscaps, 0, idmap, dentry);
> +       ret =3D call_int_hook(inode_remove_fscaps, 0, idmap, dentry);
> +       if (ret)
> +               return ret;
> +       return evm_inode_remove_fscaps(dentry);
>  }

If you take a look at linux-next or the LSM tree's dev branch you'll
see that we've gotten rid of the dedicated IMA and EVM hooks,
promoting both IMA and EVM to "proper" LSMs that leverage the existing
LSM hook infrastructure.  In this patchset, and moving forward, please
don't add dedicated IMA/EVM hooks like this, instead register them as
LSM hook implementations with LSM_HOOK_INIT().

--=20
paul-moore.com

