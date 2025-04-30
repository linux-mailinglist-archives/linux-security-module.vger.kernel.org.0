Return-Path: <linux-security-module+bounces-9595-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE169AA3C42
	for <lists+linux-security-module@lfdr.de>; Wed, 30 Apr 2025 01:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C0B176E12
	for <lists+linux-security-module@lfdr.de>; Tue, 29 Apr 2025 23:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396B82DAF98;
	Tue, 29 Apr 2025 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EKXBOqmu"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FDB13EFF3
	for <linux-security-module@vger.kernel.org>; Tue, 29 Apr 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969463; cv=none; b=GqU5WV8mbnZuiiKhIQ6lPIBiJ1ygfC8pFMuN/vSuPDjETd+6Akk4rkmyBTdcnCPz6zMDVCl+CnTNh6ZF1lS4yCZAkf6b4IMrqgl/gf8VAmhpSApmrs79Y43WsljXKSaipAikr1KbhzjTXXKP92/UXEOnUXimu9OYMavP/O8IjaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969463; c=relaxed/simple;
	bh=6+tn3bVnsdbyoFhXLXW3XNOXO8RdLpvvD8H+IgN8isw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kU9kWH3LdhdPOgkWiOGJvqmwnpmOZxOhfPrZD3dKwgIFufQIma3mNnNoUmrfuAC+OK0QzGv6+ntqfeeWIINMEP3hRBgR87YNGnf9qGrYP8kW4lI6NqVPCYCFVzvaxl2lTh9+U95mluTkqm4vjouQXCK2Et3aOxe4pP39QhSKwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EKXBOqmu; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e730b8d934aso5009277276.2
        for <linux-security-module@vger.kernel.org>; Tue, 29 Apr 2025 16:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745969460; x=1746574260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIuAebnQ3utGP4sRcNF3af9094rXpAxKt1SXsqCPHIU=;
        b=EKXBOqmuBPd3QD0u0uXcMb8RXce8GeOv2o58ReliDmsY6jwHqdPW/JGLY+OEiGpmbT
         lja2QVzmYiVG1FUiP9tnnqOQqueX/mWLevqAKG1cZIgtJibmyj/PZAwSkCrPGfE5S+Vx
         ICYJZd9sxzmS32qWTvu6WGZ0u6715wpCeNxiUM7RroHWdXn5KAPoik7dU67SobIF1Ak0
         W0KKY44pEeikYACgaLWIn6BpYQrRMReyGFibQT7N3PH9iI6TmA6utLBcD5SK0Zgg4D5y
         IW6iZtZ02YU7Yc7nKGNd5Ze+slDFZj9UkpZVrf8WRaYytC14nazrOwLnYtA5MImIgzns
         PeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969460; x=1746574260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIuAebnQ3utGP4sRcNF3af9094rXpAxKt1SXsqCPHIU=;
        b=viPU2T6lBkC3X988RDPQaZPZGTIvcc04FQWJO3+e54mrd+3yvf+SqENWcFQDzlsNsF
         KxNrY1TgptR242tAAOkgnV8XcM/G0m8xrKO/z88B+RYIMefww1DBU2Po+PQHV+xEtQvc
         hwxIvzvsMWveOyLt2pASBrfdoKEup3eGv00DpOiMxvolbYVWC03P2hYAQisr/PrSRCWQ
         uWQkPXfSYhM7HhLfOQQAkl5kBP2cBpJXefxTX8woH4nsOtgWyc+Qt1F0UU2TKUM9VIFj
         Q9Z+QIk5zsIUz3wy28NYb4nFMYEYMFN9dUPUDVf+NE9SDWx2vwH+ZW/ZXNiVdzW9NM9i
         A1hw==
X-Forwarded-Encrypted: i=1; AJvYcCVm+IWp05rC8H++XszZOFq1p4giUj6c0g+AxCucujUH97fPeifal/L63rSEO9H8GcJGxvSV7jnoCq2PngHz4qoayYczz0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32iWdNDpLSEUkeD/My+3uKlWj7f2LsUM6Y8A6rCet1XYarBpU
	6SB4R9A022GR/jzmqT3nRPCY1MsErmYqy4EK56AKLpIEV/ezSMD+KVQFFCZpsfCN0WB1PVGrUPi
	1ruuEVDxOJIuG5rn7qdBAHsAzw5Kz89/Wp+K6
X-Gm-Gg: ASbGnctOgY///o6QSS9geLySuVE2f0PP6iOxzy8Xhk+c0ktcPMZUK3he8sZrUjX17qf
	NcspTH+sFWX/ROep50jmicsKL/tBxbR9peRSxwUVlLMWq9xO+bNZWOG2Fijd6qJkNJh+0OuTpxN
	hHP9feUd3Wk2h27cKS4SLzLg==
X-Google-Smtp-Source: AGHT+IGwua5N9PuQI5YXnZ9QizB13TEvlVyb3ghRMEepupOY9IBACmHRKJ/ceFLULrT2r9vA2fNY/xi9tZpK618tJa8=
X-Received: by 2002:a05:6902:e09:b0:e73:17e3:ef4e with SMTP id
 3f1490d57ef6-e73ecf7cabdmr1474221276.48.1745969460035; Tue, 29 Apr 2025
 16:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net> <20250429-module-hashes-v3-8-00e9258def9e@weissschuh.net>
In-Reply-To: <20250429-module-hashes-v3-8-00e9258def9e@weissschuh.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Apr 2025 19:30:48 -0400
X-Gm-Features: ATxdqUHKCRv2dWw3Z8HwiaRKbffRbebAcIs6GQu6Ludlza-Iyae1SuGp-QceJWc
Message-ID: <CAHC9VhSAANnOYB11AerdtpEwWSu9OoRdxW34dap909D3z=t49A@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] lockdown: Make the relationship to MODULE_SIG a dependency
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	=?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
	Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?UTF-8?Q?C=C3=A2ju_Mihai=2DDrosi?= <mcaju95@gmail.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 9:04=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> The new hash-based module integrity checking will also be able to
> satisfy the requirements of lockdown.
> Such an alternative is not representable with "select", so use
> "depends on" instead.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  security/lockdown/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm hopeful that we will see notice about dedicated Lockdown
maintainers soon, but in the meantime this looks okay to me.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
> index e84ddf48401010bcc0829a32db58e6f12bfdedcb..155959205b8eac2c85897a8c4=
c8b7ec471156706 100644
> --- a/security/lockdown/Kconfig
> +++ b/security/lockdown/Kconfig
> @@ -1,7 +1,7 @@
>  config SECURITY_LOCKDOWN_LSM
>         bool "Basic module for enforcing kernel lockdown"
>         depends on SECURITY
> -       select MODULE_SIG if MODULES
> +       depends on !MODULES || MODULE_SIG
>         help
>           Build support for an LSM that enforces a coarse kernel lockdown
>           behaviour.
>
> --
> 2.49.0

--=20
paul-moore.com

