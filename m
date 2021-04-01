Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08F9351AEF
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Apr 2021 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbhDASDq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 1 Apr 2021 14:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbhDAR7U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Apr 2021 13:59:20 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C07C08E88F
        for <linux-security-module@vger.kernel.org>; Thu,  1 Apr 2021 06:20:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u10so2227443lju.7
        for <linux-security-module@vger.kernel.org>; Thu, 01 Apr 2021 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wc8br82rdSUXocjUVRdeobzbTuG/H9DWpf5YwUpebsM=;
        b=TIxRpaOOIxphi2ILfb/UobjRISoGFs2T1tAJaBLLjQzu+AbbD0FecdbT54DYSLngFe
         3+EADpzGqP2gMrqDdA3TeB2uhst595q7AbwPmYAQuRON+ML+DZ4N/TYyB7yf4c3+jzMq
         Sljkl13NM/ND2qkrqfOqBAtZDnTu2VdmUiTRspBDqq7UK7QsYopO2+k/3807SVFcBQ0j
         9f6es/Xyfesjx8pUTIuP7o7rn/SqrA92pF5tfufSgEsY0BYJvz+WjDMUBKvs1upZIhn9
         zFXi9wHlKfWvZWg/VlcENdoZpwr0a3HJf7h+k9kSC1fzQnF8Ly6Bh161piCYqG1Hb3sk
         AZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wc8br82rdSUXocjUVRdeobzbTuG/H9DWpf5YwUpebsM=;
        b=Hvxob7pi6CZekRE+JuTpv5WegsNN6Hv2db1Pj8gONiQawvDzhpjI++UNPfMamsRAAp
         9ThuqmfKmUM/HbCnRYGFIrDSJNq2cICCCrY1TUNfSPLIL2IZxDAbFzcTP7iNpw0pivOV
         gOpFQm9p2GjTIl6BflhlMJ6g2y8C3PqMbukoMGEZ6qcbwAkwttBkG0MEFew4gfpkF6ed
         fzQfvBBaC0JqseJbHGekvcwHPdy3Hj562IkTl+Lu/TOAFqMxtYEohHq9lqZcXbSrrbcV
         iEmLLya1n1cRaBk+qRnGqJpKB3l1Mu2uw2NSY67iy3HpjD2RCqOVvzkQmdftmQdENMI5
         GqLw==
X-Gm-Message-State: AOAM530g4NKpTd1phwL46DHXTR+JFGFUPf1h1A8A+cPbTm5cUieowi14
        DCGT6epsYGTXG1vOEHaCsNOjzFcSnc2l/hgJSnRyGw==
X-Google-Smtp-Source: ABdhPJzxpxJUHPy/rHadVQcvjnq3ze8Sdx2IjZshc/3dTdswe4RjMnfdGfW2KoJLH94WfM7eO5OZIzl8xYSArYs4cXU=
X-Received: by 2002:a2e:9acc:: with SMTP id p12mr5271081ljj.442.1617283213842;
 Thu, 01 Apr 2021 06:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com>
 <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de> <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com>
 <f01c80a0da7cffd3115ce4e16a793a2db5cbe2ed.camel@linux.ibm.com>
 <1777909690.136833.1617215767704.JavaMail.zimbra@nod.at> <a57192d9d9a5a9a66d11b38d054a5a3a70466a4b.camel@linux.ibm.com>
 <2034693332.137003.1617219379831.JavaMail.zimbra@nod.at> <f3399480-020e-e3ca-7e7c-eec641fe5afc@pengutronix.de>
In-Reply-To: <f3399480-020e-e3ca-7e7c-eec641fe5afc@pengutronix.de>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 1 Apr 2021 18:50:02 +0530
Message-ID: <CAFA6WYNd7PEcZheSYPbEmFbkkMx4dmafeYcSpMBSdNZgqz=TyQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        horia geanta <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        aymen sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        davem <davem@davemloft.net>, kernel <kernel@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        david <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list, ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 1 Apr 2021 at 15:36, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Richard,
>
> On 31.03.21 21:36, Richard Weinberger wrote:
> > James,
> >
> > ----- Urspr=C3=BCngliche Mail -----
> >> Von: "James Bottomley" <jejb@linux.ibm.com>
> >> Well, yes.  For the TPM, there's a defined ASN.1 format for the keys:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engi=
ne.git/tree/tpm2-asn.h
> >>
> >> and part of the design of the file is that it's distinguishable either
> >> in DER or PEM (by the guards) format so any crypto application can kno=
w
> >> it's dealing with a TPM key simply by inspecting the file.  I think yo=
u
> >> need the same thing for CAAM and any other format.
> >>
> >> We're encouraging new ASN.1 formats to be of the form
> >>
> >> SEQUENCE {
> >>    type   OBJECT IDENTIFIER
> >>    ... key specific fields ...
> >> }
> >>
> >> Where you choose a defined OID to represent the key and that means
> >> every key even in DER form begins with a unique binary signature.
> >
> > I like this idea.
> > Ahmad, what do you think?
> >
> > That way we could also get rid off the kernel parameter and all the fal=
l back logic,
> > given that we find a way to reliable detect TEE blobs too...
>
> Sounds good to me. Sumit, your thoughts on doing this for TEE as well?
>

AFAIU, ASN.1 formating should be independent of trusted keys backends
which could be abstracted to trusted keys core layer so that every
backend could be plugged in seamlessly.

James,

Would it be possible to achieve this?

-Sumit

> >
> > Thanks,
> > //richard
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
