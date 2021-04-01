Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023B4351762
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Apr 2021 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhDARmK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 1 Apr 2021 13:42:10 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:40430 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhDARgr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Apr 2021 13:36:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 81C17606BA2C;
        Thu,  1 Apr 2021 15:59:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zwE_aygEcMAG; Thu,  1 Apr 2021 15:59:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1458D60A3592;
        Thu,  1 Apr 2021 15:59:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ETgRfEjK7WK1; Thu,  1 Apr 2021 15:59:26 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D76FC6071A7C;
        Thu,  1 Apr 2021 15:59:26 +0200 (CEST)
Date:   Thu, 1 Apr 2021 15:59:26 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        horia geanta <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        aymen sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        davem <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>,
        kernel <kernel@pengutronix.de>,
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
Message-ID: <1846277009.140163.1617285566823.JavaMail.zimbra@nod.at>
In-Reply-To: <CAFA6WYODfsMTiCEyFA2aRGm+UQE0OTe-ui7mMSK-cqUR_YJFTA@mail.gmail.com>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de> <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com> <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de> <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com> <CAFA6WYO29o73nSg4ikU9cyaOr0kpaXFJpcGLGmFLgjKQWchcEg@mail.gmail.com> <1666035815.140054.1617283065549.JavaMail.zimbra@nod.at> <ea261e53-8f5d-ac52-f3b9-7f2db4532244@pengutronix.de> <CAFA6WYODfsMTiCEyFA2aRGm+UQE0OTe-ui7mMSK-cqUR_YJFTA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
Thread-Index: jPSCsanR7JeNVp3vlsHfcUPQzmg/6A==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Sumit,

----- Ursprüngliche Mail -----
> Von: "Sumit Garg" <sumit.garg@linaro.org>
> In this case why would one prefer to use CAAM when you have standards
> compliant TPM-Chip which additionally offers sealing to specific PCR
> (integrity measurement) values.

I don't think we can dictate what good/sane solutions are and which are not.
Both CAAM and TPM have pros and cons, I don't see why supporting both is a bad idea.

>> > IMHO allowing only one backend at the same time is a little over simplified.
>>
>> It is, but I'd rather leave this until it's actually needed.
>> What can be done now is adopting a format for the exported keys that would
>> make this extension seamless in future.
>>
> 
> +1

As long we don't make multiple backends at runtime impossible I'm
fine and will happily add support for it when needed. :-)

Thanks,
//richard
