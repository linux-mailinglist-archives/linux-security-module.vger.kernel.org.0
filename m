Return-Path: <linux-security-module+bounces-1684-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0E4869C2D
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Feb 2024 17:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8021F22570
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Feb 2024 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E1F1CD3E;
	Tue, 27 Feb 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zwGig5jZ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C111DA37
	for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051551; cv=none; b=O3IvHWYKrz5YiC2egFn96lgh6ZWHW0I7jl+eCCbbbYTEo5/wmD2K47AlfOLvwHis5V6E5ki+RYevV3B2KbfxEeWc37UeJIs0m3IBLFcxKFrznpHz8z0G2HgV5udLj2b98d+zxih8kyyToRBhoiVTIub1ePU1lcDx9Q9uO5YRBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051551; c=relaxed/simple;
	bh=VwaM4TGE7WzbXuL2owqLIfl8UDopXMwoZLqlae/zpt4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=ciihFD1o/Kq0G9Qg2V2U+vFMGBSnlJerUWtukH21xKRA/LcJfjNh+jHDtclnLzVrjpvTe8gacN4Wq5tQV8LI5CWheRU1p/TqNoubR1CdN9Wk39dySYvRVUlRmEhbYCojDtib79D7Xm3CVahQQ1E/UMXNigkkYhFevr9mC4gJAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zwGig5jZ; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a3e931d4491so295065966b.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 08:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709051548; x=1709656348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGLM6msTnPiYGE047U6w31wTMpGKpq/ku8c4CLDd44M=;
        b=zwGig5jZorXZGIC12BzDvn5cDFT7Z9W/cCQkpirwon1zXRWMFBExID67fTwyAe8w5E
         dZ46uC2JK5F0o8MufLNukhcsWvHj2tPPaHLmKZXMS1smYppF6JU/E338pCMwkies+2c8
         K8hofQSFfPDa1VTGSXJXXomiVtZzZjk9clYRBLq7SqhZl/udxtZD+xsOhYIcEbScZKr4
         Zb50je3XZ2lIfPpLbjyYGHyM0v9MQxBpRgFmdagmCWmCz94Blj+gywvMEAlY0ilaQvcm
         YgblPRsWv2z4fQEKBozUFz++qGwZle5bvlwfmE2kOlMMufTcPW0UWJd74zAHhfxXP3O5
         QoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051548; x=1709656348;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oGLM6msTnPiYGE047U6w31wTMpGKpq/ku8c4CLDd44M=;
        b=HkgxFG8ojCvB30htOaibzW1Orb9KbLc7pCyre83s8QyAnD73Uz+h6lCcTiXCN1XXsT
         QxPGmI3+hUIAIkSp2294U8SwULWMAR2FjuFYqT9DkHsHzor6zrBu8avzxhGkjBOagEr8
         aQ4v8amjbIynR13RLV2+RA1RvqFuBEo4eabkcz/rpsqAa2nLWDDY4WmVWKHpvzsBhGa2
         5fmHUK1rPkAfZEEAeKoaNFsZlaCmNtY6RbYoL58CUYpDWlWzcPgeP7VelfVer3H5tOPb
         g2chjY7X8WHyxMVcbTKMklQlVSuo5N6CKCsdy0Qt7AvWNCFnHD+yNcvf0hzJT3J3iKEI
         4B7g==
X-Forwarded-Encrypted: i=1; AJvYcCXenxzvG0T49uXnBbuhUqBC70vq5Y4Q+Hu5bUrPysrKxpb8d5cy2ycNmHwmTKoTQ6DC/9uoXRlzGapYAZXPhPJUTnIGvJwid31Cr53k6asCTq2nArK4
X-Gm-Message-State: AOJu0YwsxqilmntVFlVfzQii2yAP+vvRuiQexcqy01HxPPe3frfaeiP3
	Bte9FfsSTPPTNJuzy7Dp6y1rPm6D6SIZmTSapwoHHvyZRJqcCxoGXvWDzhop3GRO5EG0edDC1dp
	bXA==
X-Google-Smtp-Source: AGHT+IHxiYuri1W9KUnm7rvgXvnst0dfGu9BH35r2xYwG5xmzTBUc7nx+APscQ4Xryj8t9ypMETY6Vr2jqQ=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:a340:5a1b:3a37:50cc])
 (user=gnoack job=sendgmr) by 2002:a17:906:9c88:b0:a3e:81de:78c0 with SMTP id
 fj8-20020a1709069c8800b00a3e81de78c0mr31089ejc.3.1709051548382; Tue, 27 Feb
 2024 08:32:28 -0800 (PST)
Date: Tue, 27 Feb 2024 17:32:20 +0100
In-Reply-To: <20240227110550.3702236-1-mic@digikod.net>
Message-Id: <Zd4OlL1G3t1D3TgC@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227110550.3702236-1-mic@digikod.net>
Subject: Re: [PATCH v2 1/2] landlock: Extend documentation for kernel support
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Shervin Oloumi <enlightened@chromium.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 12:05:49PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Extend the kernel support section with one subsection for build time
> configuration and another for boot time configuration.
>=20
> Extend the boot time subsection with a concrete example.
>=20
> Update the journalctl command to include the boot option.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>=20
> Changes since v1:
> * New patch, suggested by Kees Cook.
> ---
>  Documentation/userspace-api/landlock.rst | 57 +++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/use=
rspace-api/landlock.rst
> index 2e3822677061..838cc27db232 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> +Boot time configuration
> +-----------------------
> +
>  If the running kernel does not have ``landlock`` in ``CONFIG_LSM``, then=
 we can
> -still enable it by adding ``lsm=3Dlandlock,[...]`` to
> +enable Landlock by adding ``lsm=3Dlandlock,[...]`` to
>  Documentation/admin-guide/kernel-parameters.rst thanks to the bootloader
>  configuration.

I would suggest: s/thanks to/in/

> +For example, if the current built-in configuration is:
> +
> +.. code-block:: console
> +
> +    $ zgrep -h "^CONFIG_LSM=3D" "/boot/config-$(uname -r)" /proc/config.=
gz 2>/dev/null
> +    CONFIG_LSM=3D"lockdown,yama,integrity,apparmor"
> +
> +...and if the cmdline doesn't contain ``landlock`` either:
> +
> +.. code-block:: console
> +
> +    $ sed -n 's/.*\(\<lsm=3D\S\+\).*/\1/p' /proc/cmdline
> +    lsm=3Dlockdown,yama,integrity,apparmor
> +
> +...we should configure the bootloader to set a cmdline extending the ``l=
sm``
> +list with the ``landlock,`` prefix::

Nit: Is the double colon at the end of this line accidental?
(It does not appear before the previous code block.)

> +
> +  lsm=3Dlandlock,lockdown,yama,integrity,apparmor
> +
> +After a reboot, we can check that Landlock is up and running by looking =
at
> +kernel logs:
> +
> +.. code-block:: console
> +
> +    # dmesg | grep landlock || journalctl -kb -g landlock
> +    [    0.000000] Command line: [...] lsm=3Dlandlock,lockdown,yama,inte=
grity,apparmor
> +    [    0.000000] Kernel command line: [...] lsm=3Dlandlock,lockdown,ya=
ma,integrity,apparmor
> +    [    0.000000] LSM: initializing lsm=3Dlockdown,capability,landlock,=
yama,integrity,apparmor
> +    [    0.000000] landlock: Up and running.
> +
> +Note that according to the built time kernel configuration,

s/built time/build time/
                 ^

It feels like the phrase "according to" could be slightly more specific her=
e.

To paraphrase Alejandro Colomar, "Note that" is usually redundant.
https://lore.kernel.org/all/0aafcdd6-4ac7-8501-c607-9a24a98597d7@gmail.com/

I'd suggest:

  The kernel may be configured at build time to always load the ``lockdown`=
` and
  ``capability`` LSMs.  In that case, these LSMs will appear at the beginni=
ng of
  the ``LSM: initializing`` log line as well, even if they are not configur=
ed in
  the boot loader.

> +``lockdown,capability,`` may always stay at the beginning of the ``LSM:
> +initializing lsm=3D`` list even if they are not configured with the boot=
loader,

Nit: The man pages spell this in two words as "boot loader".


> +which is OK.
> +
> +Network support
> +---------------
> +
>  To be able to explicitly allow TCP operations (e.g., adding a network ru=
le with
>  ``LANDLOCK_ACCESS_NET_BIND_TCP``), the kernel must support TCP
>  (``CONFIG_INET=3Dy``).  Otherwise, sys_landlock_add_rule() returns an
>=20
> base-commit: b4007fd27206c478a4b76e299bddf4a71787f520
> --=20
> 2.44.0
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

