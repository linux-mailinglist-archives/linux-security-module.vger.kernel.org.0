Return-Path: <linux-security-module+bounces-669-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06200817EF0
	for <lists+linux-security-module@lfdr.de>; Tue, 19 Dec 2023 01:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D8E1F2116E
	for <lists+linux-security-module@lfdr.de>; Tue, 19 Dec 2023 00:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B739E10EF;
	Tue, 19 Dec 2023 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LqEnhT3+"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0127FB
	for <linux-security-module@vger.kernel.org>; Tue, 19 Dec 2023 00:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbcfd61bd0fso2713858276.1
        for <linux-security-module@vger.kernel.org>; Mon, 18 Dec 2023 16:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702946745; x=1703551545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oasQpdQEdRdV5iTLy9b03b575xEh8lY+6DBy55U7VgY=;
        b=LqEnhT3+a+75yoCOyPmBl41RJ7jwkObERW3lG2ZIL08Wx4+TSQANXr31ju52BBmUJ1
         A71eYmv3PanU7wvWn1wzpVsVHVI22JetZL1N1VCudBPOvlda1UHAU4d4cCMjEBs8ihnv
         JixbhPjvThzyKSCjWlKTqc208dPSldcx5ZAyOoKgNu6emMoZKC9FAeoxj/6vg4Yzhkc1
         DBDjlMv+QXWQTuD5fXRI8RUM4UWU3F7mwKt0kH/RG/dbRGRWxHDDBm0BkBli7tg/d3Qd
         y2QuyDvbOi/3tg1Wc/rCEhok/Xy+hUVcuMrL1N5O+y2TO63kGVqSRD4qkf3WT5fiedVf
         EafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702946745; x=1703551545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oasQpdQEdRdV5iTLy9b03b575xEh8lY+6DBy55U7VgY=;
        b=sSnpTTmyqaid/FAZ1T0X+aCuDuJLjVn0N/Mtwy/a0DcHP+PQhNfkmnwXgpYFaHoDFl
         7+Epvg0G5Rh/NwqL2HYiAvWYWIZNnPpU89A2UmCSfr2v6lxYlK9h2zIOqTp81g0V0N9T
         7tzV9NgkGMFT3BgXY/X9zPyfLlhzQw2aFvKC/okenb744oC74YcUNaJcmqxJCz/6uCOx
         xlAw3bRzOFJBuDfH9I8K+ISIbI+6wI48J3zoKJWdAf2QlmritWi5meAu+yWs+Esj/icU
         iPjMqkGAyRIynlGYO70wh1QiHRucvKxr54NQfuEBvIKARET8PdUDBYERKsUa7mi/BKq7
         gizQ==
X-Gm-Message-State: AOJu0Yy3QLTVNGvGIZ1eKxjSpdo6wt/ehqLVlhLiFoTwTrgps2NAxWuE
	0koyRLoFYYeziYTunJ3qoJBXUQZNUzGUm3G1AEZx3P0LKLnX
X-Google-Smtp-Source: AGHT+IHFtpoGslhpNZUWQ9Yvh/0J3BP+vucf5ghv5vQv8fV6Ebtbue95F9C+pqRj+w9X/e1PwDGZwltTgDSmFXCRZ9M=
X-Received: by 2002:a25:d785:0:b0:dbc:f85e:eb39 with SMTP id
 o127-20020a25d785000000b00dbcf85eeb39mr196775ybg.3.1702946745056; Mon, 18 Dec
 2023 16:45:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215110639.45522-1-david@sigma-star.at>
In-Reply-To: <20231215110639.45522-1-david@sigma-star.at>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 Dec 2023 19:45:34 -0500
Message-ID: <CAHC9VhSRjwN=a9=V--m46_xh4fQNwZ9781YBCDpAmAV1mofhQg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] DCP as trusted keys backend
To: David Gstir <david@sigma-star.at>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>
Cc: James Bottomley <jejb@linux.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Shawn Guo <shawnguo@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	sigma star Kernel Team <upstream+dcp@sigma-star.at>, Li Yang <leoyang.li@nxp.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Tejun Heo <tj@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 6:07=E2=80=AFAM David Gstir <david@sigma-star.at> w=
rote:
>
> This is a revival of the previous patch set submitted by Richard Weinberg=
er:
> https://lore.kernel.org/linux-integrity/20210614201620.30451-1-richard@no=
d.at/
>
> v4 is here:
> https://lore.kernel.org/keyrings/20231024162024.51260-1-david@sigma-star.=
at/
>
> v4 -> v5:
> - Make Kconfig for trust source check scalable as suggested by Jarkko Sak=
kinen
> - Add Acked-By from Herbert Xu to patch #1 - thanks!
> v3 -> v4:
> - Split changes on MAINTAINERS and documentation into dedicated patches
> - Use more concise wording in commit messages as suggested by Jarkko Sakk=
inen
> v2 -> v3:
> - Addressed review comments from Jarkko Sakkinen
> v1 -> v2:
> - Revive and rebase to latest version
> - Include review comments from Ahmad Fatoum
>
> The Data CoProcessor (DCP) is an IP core built into many NXP SoCs such
> as i.mx6ull.
>
> Similar to the CAAM engine used in more powerful SoCs, DCP can AES-
> encrypt/decrypt user data using a unique, never-disclosed,
> device-specific key. Unlike CAAM though, it cannot directly wrap and
> unwrap blobs in hardware. As DCP offers only the bare minimum feature
> set and a blob mechanism needs aid from software. A blob in this case
> is a piece of sensitive data (e.g. a key) that is encrypted and
> authenticated using the device-specific key so that unwrapping can only
> be done on the hardware where the blob was wrapped.
>
> This patch series adds a DCP based, trusted-key backend and is similar
> in spirit to the one by Ahmad Fatoum [0] that does the same for CAAM.
> It is of interest for similar use cases as the CAAM patch set, but for
> lower end devices, where CAAM is not available.
>
> Because constructing and parsing the blob has to happen in software,
> we needed to decide on a blob format and chose the following:
>
> struct dcp_blob_fmt {
>         __u8 fmt_version;
>         __u8 blob_key[AES_KEYSIZE_128];
>         __u8 nonce[AES_KEYSIZE_128];
>         __le32 payload_len;
>         __u8 payload[];
> } __packed;
>
> The `fmt_version` is currently 1.
>
> The encrypted key is stored in the payload area. It is AES-128-GCM
> encrypted using `blob_key` and `nonce`, GCM auth tag is attached at
> the end of the payload (`payload_len` does not include the size of
> the auth tag).
>
> The `blob_key` itself is encrypted in AES-128-ECB mode by DCP using
> the OTP or UNIQUE device key. A new `blob_key` and `nonce` are generated
> randomly, when sealing/exporting the DCP blob.
>
> This patchset was tested with dm-crypt on an i.MX6ULL board.
>
> [0] https://lore.kernel.org/keyrings/20220513145705.2080323-1-a.fatoum@pe=
ngutronix.de/
>
> David Gstir (6):
>   crypto: mxs-dcp: Add support for hardware-bound keys
>   KEYS: trusted: improve scalability of trust source config
>   KEYS: trusted: Introduce NXP DCP-backed trusted keys
>   MAINTAINERS: add entry for DCP-based trusted keys
>   docs: document DCP-backed trusted keys kernel params
>   docs: trusted-encrypted: add DCP as new trust source
>
>  .../admin-guide/kernel-parameters.txt         |  13 +
>  .../security/keys/trusted-encrypted.rst       |  85 +++++
>  MAINTAINERS                                   |   9 +
>  drivers/crypto/mxs-dcp.c                      | 104 +++++-
>  include/keys/trusted_dcp.h                    |  11 +
>  include/soc/fsl/dcp.h                         |  17 +
>  security/keys/trusted-keys/Kconfig            |  18 +-
>  security/keys/trusted-keys/Makefile           |   2 +
>  security/keys/trusted-keys/trusted_core.c     |   6 +-
>  security/keys/trusted-keys/trusted_dcp.c      | 311 ++++++++++++++++++
>  10 files changed, 562 insertions(+), 14 deletions(-)
>  create mode 100644 include/keys/trusted_dcp.h
>  create mode 100644 include/soc/fsl/dcp.h
>  create mode 100644 security/keys/trusted-keys/trusted_dcp.c

Jarkko, Mimi, David - if this patchset isn't already in your review
queue, can you take a look at it from a security/keys perspective?

Thanks.

--=20
paul-moore.com

