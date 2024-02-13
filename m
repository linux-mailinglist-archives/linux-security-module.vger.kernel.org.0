Return-Path: <linux-security-module+bounces-1445-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AE6852D59
	for <lists+linux-security-module@lfdr.de>; Tue, 13 Feb 2024 11:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC041F27EA1
	for <lists+linux-security-module@lfdr.de>; Tue, 13 Feb 2024 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1822319;
	Tue, 13 Feb 2024 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="t3Nh5fOM"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFE5225D5
	for <linux-security-module@vger.kernel.org>; Tue, 13 Feb 2024 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818403; cv=none; b=gcv0uICdihSQfTEH6ZVE0a2PTfc15VnPlFLHykHrED8x07euKi5Oo/NueHY8+qlE//skRCuUnLcVqc1/UK3B8w1AhqTU6RXj376VuD2WRsj5z3x9PmWBYt1CZK4IC4v6RV9QJExqvX89IrVsNoWprxGlQmeQyJMw2MGAlM9ARTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818403; c=relaxed/simple;
	bh=ACSk1jf/AZFiby2B/e9ooFgYbhyONiPoItuRKcyxhT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlwELWihgpWhqW9fkJH4zvJtGkGjcTDEtxAbCElnlag96A2/YtcDvpD4Fl5RoOIKNRaPRs35XamPgSOSJG1WWa+Wy/WW9YO7HTuEG6auqgyjzIWYfmF3Fp7AArou57CkVnZVTrPCMOIEtp2AiJXeUR+TYOD15Fkt/7CYSebNfKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=t3Nh5fOM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26fa294e56so560659066b.0
        for <linux-security-module@vger.kernel.org>; Tue, 13 Feb 2024 02:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1707818399; x=1708423199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyeDtepLgx0McOY1pO4WdkIJtQMiPkAy0vk69/uR3rI=;
        b=t3Nh5fOMdbo5hs3AYuhV7+iRzgscPMB5IgBZynixUnDsGoYpfPt/5eYSV+PeQJQDq5
         V8P8pWAaj8oG7kxiSh1YI5vDnYp1y2rbIFESWUtuOnHSg71ZTW5aAqjWq8VZ8GbvmeDR
         hSvG5D//CTaEPNL7Pe+aUr8DmUd3eG9xAqzLqOhIF30OW1f5kDpahMLFca4jp9TZgurc
         Uym+reZWagKZ31l5azkjmIgjR4JxNZtbi46yZFSYKj+4iiItYwOfkJizK4zlq1W05cpn
         rjF8eXFU9L3mPUbmnQKxzyQH9mlPduVqSTZC0kWzciWrVxoN5jpqxJlhwrW257g8O4gB
         UQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707818399; x=1708423199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyeDtepLgx0McOY1pO4WdkIJtQMiPkAy0vk69/uR3rI=;
        b=ZdctPzMIkAZ4pUPJhf4hgkDue883PsNLfiagPkxefcktano5e0o6XB1hcKgx0qQpeS
         hvQQE1gqm8dOfLRTu5beE9JQVbGHm1Ib1PYer1EHAs5CVGlrR/3YdkyTI/hXOCJm+di7
         HVL1f+k5Sjgx6pw27ZeaHBLbCcQM092In6j+Q6BQbNg2Z3qoPY5o0+SQyfqNKDiMMY1C
         m9oMzWqJKA68ZFhT+ZE7Zjb1rLcuT9F6eB4dsN5VCkNUmKbitb4JkCo8eYzEwwMP3FPW
         O+7MxZ9HYiEyDOcQxFLDALpB++WaW9xE5Z/HcwO1gKvHWJ5b3zFAvgI6fglGKQ6Bm/aH
         NVkg==
X-Forwarded-Encrypted: i=1; AJvYcCWNU19mFT/+vKu70ofD8/Nx0dvwDXFsPvKlFqcG0OBHcxEZUtyo31a7lmRlKNDSyos6xt9B2spjRvvd7S1SiMPlKAon0ACno6U3l11yRK0LLhnw1Qgb
X-Gm-Message-State: AOJu0Yw4cCen9IwNCuxjufNadiOdkWb267+IpvnhMODBeSe4z7vr9Ssg
	eWK5bj+HBNKUglRn2r4VkxWk+GgmdjNLQYwMdfadiI4JzBvddGQAAQH25q8cOGk=
X-Google-Smtp-Source: AGHT+IHEjTCzJQiMRtlAWhiS4vBU8FucNsWEQmzIuMGcPfQWtxNPG6A/AHgXHP88FZXuf9FpsLb1RA==
X-Received: by 2002:a17:906:da03:b0:a3c:8772:97bc with SMTP id fi3-20020a170906da0300b00a3c877297bcmr4593945ejb.70.1707818399072;
        Tue, 13 Feb 2024 01:59:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9Lvd0gIyxW7fyt4/vBOTtTFhw8BwSuz+lp9azwGwU/sEacO3hp4UP5b9jT4ZdzTXdpxRrNw3yWTkRA2mZc0ViUYvJI1T1Wil0XREjFxK6TG0gNqfdSgjrNF3pi9+7ljipOLTqFxTmPut2EvJvoC8REQLk9w3hNJDOA5mnxH5VIGqWmQD6wpqUTTkgCCec3TIQHVlmxYJ+RIbhuiDhlBe61VOjQ6ixhteHpfb50d+9J3rO+r26f2iEIQN04Loa/NxVD9DoebEX0YjEI/E0wU7EuKGFQhUzHfBc7zRzkZICZaXj2PpNdGdV7ULDQtMx1e2tHpcuaNgXcZxx53a3PrQpPSWkPLUGh9PLTugf22ZPoLA79U+WpqCLjlqJ+wMIuGy4aRX2astyccDTpqopsnoZwr+Le8XQl44nQ6XGse4g+ZsL5HSIoGYaTdcc8put9I/V4NLPaVXKQeFqCJgyDybNC8Laewb91SL/TQRVdzTVLx9+dhvfWHwYXfHQeMNJCe72RkbkPzT6l/CPkYElYVrWj8wfEITjz6UKfDibWZB9i9ao8mCJ6B/0uiw9X6zcxuJUKi9qESLTeVDKBnfWtk8P58ZkCAu03Y+qtfwccvG07ICfkjzsKxpE5Pt861yDtMR6V1bK7JZVoQ72CkFkr4h1JAMpgffeNn5a8693YQG0btUA22KCxYl748oIeBuUaU5weN0OgylotSAWDn3J+w9D8+iAVNcYDDDm6vrBuVEVe/nkWh3eCqeE3h4+ixmPB1guSaScYDm3pSJsYggz3f3662OrPJO66ThrXIAoTwKOuD3gEuyFt9um4e5fU1zMso7lcn9Y4JkbAlXk5eM5zUfdLJX36PrPI/Cm6fIT2meQUyuGG0ZG0cYTECFnY1/RtGANkJEWV5Z1TL7Y/e+1gt9IS9+hus0u+UJ6M37+PAiCR0b1Lib4J7X75weyMTYmwhW0AK
 mqmjwh2l9tVFgBdCifZBmXLaCEPzP813Cy13sEjfE6Aw/xPVQ1s23IRXd3yquvCIyW2lH73g1yk3Yd1QO9sJHXm84uLvW1g9PraVncRy64krUOqC22xsO9nxpucuoBjrbq
Received: from blindfold.localnet ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id vg9-20020a170907d30900b00a3cf4e8fdf5sm657479ejc.150.2024.02.13.01.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:59:58 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: Mimi Zohar <zohar@linux.ibm.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, upstream@sigma-star.at
Cc: Shawn Guo <shawnguo@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Sascha Hauer <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	sigma star Kernel Team <upstream+dcp@sigma-star.at>, David Howells <dhowells@redhat.com>, 
	Li Yang <leoyang.li@nxp.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Tejun Heo <tj@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, linux-doc@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, David Gstir <david@sigma-star.at>
Subject: Re: [PATCH v5 0/6] DCP as trusted keys backend
Date: Tue, 13 Feb 2024 10:59:56 +0100
Message-ID: <47439997.XUcTiDjVJD@somecomputer>
In-Reply-To: <7AED262F-9387-446D-B11A-C549C02542F9@sigma-star.at>
References: <20231215110639.45522-1-david@sigma-star.at> <7AED262F-9387-446D-B11A-C549C02542F9@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Montag, 5. Februar 2024, 09:39:07 CET schrieb David Gstir:
> Hi,
>=20
> > On 15.12.2023, at 12:06, David Gstir <david@sigma-star.at> wrote:
> >=20
> > This is a revival of the previous patch set submitted by Richard Weinbe=
rger:
> > https://lore.kernel.org/linux-integrity/20210614201620.30451-1-richard@=
nod.at/
> >=20
> > v4 is here:
> > https://lore.kernel.org/keyrings/20231024162024.51260-1-david@sigma-sta=
r.at/
> >=20
> > v4 -> v5:
> > - Make Kconfig for trust source check scalable as suggested by Jarkko S=
akkinen
> > - Add Acked-By from Herbert Xu to patch #1 - thanks!
> > v3 -> v4:
> > - Split changes on MAINTAINERS and documentation into dedicated patches
> > - Use more concise wording in commit messages as suggested by Jarkko Sa=
kkinen
> > v2 -> v3:
> > - Addressed review comments from Jarkko Sakkinen
> > v1 -> v2:
> > - Revive and rebase to latest version
> > - Include review comments from Ahmad Fatoum
> >=20
> > The Data CoProcessor (DCP) is an IP core built into many NXP SoCs such
> > as i.mx6ull.
> >=20
> > Similar to the CAAM engine used in more powerful SoCs, DCP can AES-
> > encrypt/decrypt user data using a unique, never-disclosed,
> > device-specific key. Unlike CAAM though, it cannot directly wrap and
> > unwrap blobs in hardware. As DCP offers only the bare minimum feature
> > set and a blob mechanism needs aid from software. A blob in this case
> > is a piece of sensitive data (e.g. a key) that is encrypted and
> > authenticated using the device-specific key so that unwrapping can only
> > be done on the hardware where the blob was wrapped.
> >=20
> > This patch series adds a DCP based, trusted-key backend and is similar
> > in spirit to the one by Ahmad Fatoum [0] that does the same for CAAM.
> > It is of interest for similar use cases as the CAAM patch set, but for
> > lower end devices, where CAAM is not available.
> >=20
> > Because constructing and parsing the blob has to happen in software,
> > we needed to decide on a blob format and chose the following:
> >=20
> > struct dcp_blob_fmt {
> > __u8 fmt_version;
> > __u8 blob_key[AES_KEYSIZE_128];
> > __u8 nonce[AES_KEYSIZE_128];
> > __le32 payload_len;
> > __u8 payload[];
> > } __packed;
> >=20
> > The `fmt_version` is currently 1.
> >=20
> > The encrypted key is stored in the payload area. It is AES-128-GCM
> > encrypted using `blob_key` and `nonce`, GCM auth tag is attached at
> > the end of the payload (`payload_len` does not include the size of
> > the auth tag).
> >=20
> > The `blob_key` itself is encrypted in AES-128-ECB mode by DCP using
> > the OTP or UNIQUE device key. A new `blob_key` and `nonce` are generated
> > randomly, when sealing/exporting the DCP blob.
> >=20
> > This patchset was tested with dm-crypt on an i.MX6ULL board.
> >=20
> > [0] https://lore.kernel.org/keyrings/20220513145705.2080323-1-a.fatoum@=
pengutronix.de/
> >=20
> > David Gstir (6):
> >  crypto: mxs-dcp: Add support for hardware-bound keys
> >  KEYS: trusted: improve scalability of trust source config
> >  KEYS: trusted: Introduce NXP DCP-backed trusted keys
> >  MAINTAINERS: add entry for DCP-based trusted keys
> >  docs: document DCP-backed trusted keys kernel params
> >  docs: trusted-encrypted: add DCP as new trust source
> >=20
> > .../admin-guide/kernel-parameters.txt         |  13 +
> > .../security/keys/trusted-encrypted.rst       |  85 +++++
> > MAINTAINERS                                   |   9 +
> > drivers/crypto/mxs-dcp.c                      | 104 +++++-
> > include/keys/trusted_dcp.h                    |  11 +
> > include/soc/fsl/dcp.h                         |  17 +
> > security/keys/trusted-keys/Kconfig            |  18 +-
> > security/keys/trusted-keys/Makefile           |   2 +
> > security/keys/trusted-keys/trusted_core.c     |   6 +-
> > security/keys/trusted-keys/trusted_dcp.c      | 311 ++++++++++++++++++
> > 10 files changed, 562 insertions(+), 14 deletions(-)
> > create mode 100644 include/keys/trusted_dcp.h
> > create mode 100644 include/soc/fsl/dcp.h
> > create mode 100644 security/keys/trusted-keys/trusted_dcp.c
>=20
> Jarkko, Mimi, David do you need anything from my side for these patches t=
o get them merged?

=46riendly ping also from my side. :-)

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y



