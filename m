Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB08347674
	for <lists+linux-security-module@lfdr.de>; Wed, 24 Mar 2021 11:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhCXKrg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 24 Mar 2021 06:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbhCXKrf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Mar 2021 06:47:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A90C0613DF
        for <linux-security-module@vger.kernel.org>; Wed, 24 Mar 2021 03:47:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n138so31219267lfa.3
        for <linux-security-module@vger.kernel.org>; Wed, 24 Mar 2021 03:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ey+2292BkH6x041fX3yRwofo+kD7iZk7X6ckEEcQYiM=;
        b=wOpDYenTLNC5o8Rarb2OFmUczdkjNuWqZymzj6lBygep5Yd7GB2gh5V4iK5s09JlP6
         yrGBhqkmBeK5d1pbDMSFFgsrPAZy3mE0skMAgab3K7copJacg2MO/0lfbvDl9pLGn5rr
         5BkjddszhsrZCY3P2ZyhvTQ+//m8JOKbckvDK71Eu14aDkiGUgwPFlFcornRoc+Ut2sS
         IBrxfX8eCVRlKa3D+BsNyrmFNi03KIH29UMMMiW0maebcG2AFLrpZ0LZPWWclW6Act8s
         pyXZxz3WbZAIogJ0uMjCxkqr5kHcJOrQ6xsvKobcwu0WDXurBq/B0FmwrxLO73e2b0Nh
         HeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ey+2292BkH6x041fX3yRwofo+kD7iZk7X6ckEEcQYiM=;
        b=HJ+Hs3UaQj5VhkO/gfM/zd+TS07Ytg/m0qc01/iTL+lnLZ95huPX0EGLs9BNJ2kaNw
         A1pCfwFmdwmfe0Nxg9nHHWayRGmqs12XB8LXtPCcvF9meEJESUbqWKzuOqSrW+nSe/cW
         IPQ6jCaI8uT9DMr5iLC+QH7TQp0o1g+NLKUE8WM1GxF68KhGwol2iBNPoDsXz6q2KZj8
         WG41HjsjWFy8jnItlGeL11p6HqKyhTh3rZPekaQFqaiujbcmiKan8OUOvLoWShEvbYhJ
         sOLJZuvQGCCtka7/7cmI02zz/tCe3pi5RLQlA1DUlr/xQtcEim1o0HcoDrl5v1ug6s2w
         GjCA==
X-Gm-Message-State: AOAM533jRf4lEgRof2+itcC5Xh8d8Nph1ZV/J4AeqUZPmYHQSdVRmpfb
        BFWrRZSkw6r74lP+QpvS/JgfNyyvRtIO8jiSwa8VxQ==
X-Google-Smtp-Source: ABdhPJzmEK8UFfoOBxPtEBmqPf6Hoc+0fs0j6LtMLq04iyal514Inhwtzy/LLK66UpNucjWsaSeaq6z/MCalVaqGZrM=
X-Received: by 2002:a19:6109:: with SMTP id v9mr1632879lfb.546.1616582853107;
 Wed, 24 Mar 2021 03:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
 <01e6e13d-2968-0aa5-c4c8-7458b7bde462@nxp.com> <45a9e159-2dcb-85bf-02bd-2993d50b5748@pengutronix.de>
 <f9c0087d299be1b9b91b242f41ac6ef7b9ee3ef7.camel@linux.ibm.com> <63dd7d4b-4729-9e03-cd8f-956b94eab0d9@pengutronix.de>
In-Reply-To: <63dd7d4b-4729-9e03-cd8f-956b94eab0d9@pengutronix.de>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 24 Mar 2021 16:17:21 +0530
Message-ID: <CAFA6WYOw_mQwOUN=onhzb7zCTyYDBrcx0E7C3LRk6nPLAVCWEQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 24 Mar 2021 at 14:56, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Mimi,
>
> On 23.03.21 19:07, Mimi Zohar wrote:
> > On Tue, 2021-03-23 at 17:35 +0100, Ahmad Fatoum wrote:
> >> On 21.03.21 21:48, Horia Geant=C4=83 wrote:
> >>> caam has random number generation capabilities, so it's worth using t=
hat
> >>> by implementing .get_random.
> >>
> >> If the CAAM HWRNG is already seeding the kernel RNG, why not use the k=
ernel's?
> >>
> >> Makes for less code duplication IMO.
> >
> > Using kernel RNG, in general, for trusted keys has been discussed
> > before.   Please refer to Dave Safford's detailed explanation for not
> > using it [1].
>
> The argument seems to boil down to:
>
>  - TPM RNG are known to be of good quality
>  - Trusted keys always used it so far
>
> Both are fine by me for TPMs, but the CAAM backend is new code and neithe=
r point
> really applies.
>
> get_random_bytes_wait is already used for generating key material elsewhe=
re.
> Why shouldn't new trusted key backends be able to do the same thing?
>

Please refer to documented trusted keys behaviour here [1]. New
trusted key backends should align to this behaviour and in your case
CAAM offers HWRNG so we should be better using that.

Also, do update documentation corresponding to CAAM as a trusted keys backe=
nd.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/=
tree/Documentation/security/keys/trusted-encrypted.rst#n87

-Sumit

> Cheers,
> Ahmad
>
> >
> > thanks,
> >
> > Mimi
> >
> > [1]
> > https://lore.kernel.org/linux-integrity/BCA04D5D9A3B764C9B7405BBA4D4A3C=
035F2A38B@ALPMBAPA12.e2k.ad.ge.com/
> >
> >
> >
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
