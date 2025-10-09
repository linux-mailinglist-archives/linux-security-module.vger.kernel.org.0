Return-Path: <linux-security-module+bounces-12356-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D85EABCA9A8
	for <lists+linux-security-module@lfdr.de>; Thu, 09 Oct 2025 20:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C89774E4E3C
	for <lists+linux-security-module@lfdr.de>; Thu,  9 Oct 2025 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE60241679;
	Thu,  9 Oct 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcDZcqqi"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B01FFC48
	for <linux-security-module@vger.kernel.org>; Thu,  9 Oct 2025 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035777; cv=none; b=RzkF664wr9muJAUOJZop9u3hGQZJa1ExfiWlKDiirVp1oNJffQ4/aYO1cHVRHgAQbeaOr5DEXRyGXEN7a9EeHAq1tRoGCGeIaoENTpDIyRnbKlAeEl+Nlwb6AsGVaM8oCWni0TprmpcSfHd3N8FF4kCN7q2T7SDqiuhAcNfTBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035777; c=relaxed/simple;
	bh=UShdFoBuAwfbyO6hqQqzp5FMsu6U9c0iB6HC4U7g1ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErNc64FczS5EKr1No9W8cOn/8nHSaDnnjs+5Uf2PCq/OOIp5xl/Lg91U0c/NvEGroEuvjkG8reg7rzku18pSZZx2hJHN82QJUGDu8B8ysqusDtNxstafB14SHDqJsMbnOUAsjA39l+EhwwiyHSLsgGVJlTo259HO0IHxa+bgGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcDZcqqi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so1246328a91.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 Oct 2025 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760035775; x=1760640575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDSmbrF8JzunGw/f0Rpkl5VvvKxlJtr9tXEz0PlojHg=;
        b=EcDZcqqiBtsbi61N8h7wS7XhQuCtkwIhRqwcUwfWdoCTZSXVqpqcEOowupGf3JbCet
         fqpbyQBNNWZ/4Qf1FS4WJ4MXuo1j7Bw0Fed06oddlPUnIsj52NDJrQG/CCP8IiASX5cW
         /wGVdHTRjheuPf8R4ErLbagj5vQnrNNTNbg1B8jFRrsBQnE8+/LzqhvUVXoGTxCjet3h
         TpvJrfF8OC8+w0GcqJiI2vtlegfiuYEoxcKavBZnbTeVucGLSJM4m7aqEIC5McZgM/G/
         mc+ZmklaBiuQ8urvf1pr1SXPDECyfP34AFlz9P1yPsxaJEjg6unOa+Cb+aRpA5b7cZct
         jHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760035775; x=1760640575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDSmbrF8JzunGw/f0Rpkl5VvvKxlJtr9tXEz0PlojHg=;
        b=KB+9TseGAsi3KxhukAmJIirX5H+Wa0OB+PzJ/QF3vZ/sYlnAcC2Xs2hXAvLDY1J7Hh
         tSboQBxJPwv4xUEazSx1uSZJc/dWIgFi3k3h+WNsBAnSQK8aDm1//cO5P9zxmodoj2aZ
         dkJtjhCN1jN9yGX7ryMiawSfMUEv2YyXTB+hHgbZrmD3ZOE6zqMim77O8YEPCmBhfoiC
         zAGaodgqVm4HQPGmCpOq0t3j0smwN+V2Dw3d+okaHqv1dFXaz2il+3j/57I95scr+HPU
         wZbxlv2N6NdRSnQf0To4cocqO3e0mG/DVf7ayu2+fi9WpLwoFi0CbVVxBsVIGjsxBgkL
         kJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCXzik14+TYPpH/WvpaviWUizGXz0XRV9a97wpRTYmJgimDCs77PxEqjJ/ZGJ63rFM+OPGFPyIlAnqApHsuwBQ7E8y5UeOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+6PMpZy9x9OF3NRJrPb34dykzQWRON5F8qviA/VdoZuQI92/J
	GCxPBd5YU7Xn9ZrItOEHKNTxeccfasXy0Iz2AeKRWwGopbPkZhCSwqoqVdsMVX8qDWJtiDX1IVY
	D0+QymlFYdWEZ51lMWLW5Icxr7IfSwBs=
X-Gm-Gg: ASbGncs+Om4P1rHDhQnjwTMbJUj+/aX8MrdjHP8UOnS/b9IN1WqE6yCVDKJopY8Xzym
	XpWlWoV39WRq1qg5Hkx6stVVs1mG1HLp2dOgBy42ipDfiHmmW8Si89tIk27dUzegJRhygGT09sH
	sjDNK3CpJCJ5C976J7hV2oBAwfPNqJ0qEOMShT63cV8XnfC659VeuqakFXLAVXQqkGa6hLvEUIt
	bIjDzTdl+cudu7fBHozfKOUyYgZYZ0zmo6x3aI0DQ==
X-Google-Smtp-Source: AGHT+IFuJsC04j2tmVoA6UgpF4mz4gEVXtC5ekRaUxk+SFE0MHfOmJZkmq0YlRac/ZOBjT6dSC2Ll9q/RZoioR72pRA=
X-Received: by 2002:a17:90b:1e11:b0:330:6d2f:1b5d with SMTP id
 98e67ed59e1d1-33b513840bamr12506871a91.26.1760035774918; Thu, 09 Oct 2025
 11:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001215643.31465-1-casey@schaufler-ca.com> <20251001215643.31465-2-casey@schaufler-ca.com>
In-Reply-To: <20251001215643.31465-2-casey@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Oct 2025 14:49:23 -0400
X-Gm-Features: AS18NWDBurz4VRzNl04xbd9NuEilFgbv9pRjpgx67-Z7i2XTMbO9mkM42Ls_urM
Message-ID: <CAEjxPJ7M4qySg+ZMujTqMQFSncWNbG21W+kpLzji6c4F+hyprA@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: Exclusive secmark usage
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 5:56=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> The network secmark can only be used by one security module
> at a time. Establish mechanism to identify to security modules

a mechanism to inform security modules?

> whether they have access to the secmark. SELinux already
> incorparates mechanism, but it has to be added to Smack and

incorporates

> AppArmor.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h        |  1 +
>  security/apparmor/include/net.h  |  5 +++++
>  security/apparmor/lsm.c          |  7 ++++---
>  security/security.c              |  6 ++++++
>  security/selinux/hooks.c         |  4 +++-
>  security/smack/smack.h           |  5 +++++
>  security/smack/smack_lsm.c       |  3 ++-
>  security/smack/smack_netfilter.c | 10 ++++++++--
>  8 files changed, 34 insertions(+), 7 deletions(-)
>

> diff --git a/security/security.c b/security/security.c
> index ad163f06bf7a..e59e3d403de6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -283,6 +283,12 @@ static void __init lsm_set_blob_sizes(struct lsm_blo=
b_sizes *needed)
>         lsm_set_blob_size(&needed->lbs_xattr_count,
>                           &blob_sizes.lbs_xattr_count);
>         lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
> +       if (needed->lbs_secmark) {
> +               if (blob_sizes.lbs_secmark)
> +                       needed->lbs_secmark =3D false;
> +               else
> +                       blob_sizes.lbs_secmark =3D true;
> +       }

So if I understand correctly, the first LSM to register with
lbs_secmark set wins.
Not sure that's a great idea - seemingly some LSMs may want to insist
that they get to use secmark regardless of registration order?

