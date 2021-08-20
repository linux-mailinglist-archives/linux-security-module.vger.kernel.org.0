Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422083F3176
	for <lists+linux-security-module@lfdr.de>; Fri, 20 Aug 2021 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhHTQ0k (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 20 Aug 2021 12:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhHTQ0j (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Aug 2021 12:26:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACFDC061575
        for <linux-security-module@vger.kernel.org>; Fri, 20 Aug 2021 09:26:01 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mH7LB-0004DB-Ev; Fri, 20 Aug 2021 18:25:57 +0200
Subject: Re: [PATCH 0/4] KEYS: trusted: Introduce support for NXP CAAM-based
 trusted keys
To:     David Gstir <david@sigma-star.at>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        linux-integrity@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
 <b9e44f8e-84a0-90be-6cfc-d3a0bde12178@pengutronix.de>
 <20210809093519.er32rmspuvkrww45@kernel.org>
 <8321cac9-350b-1325-4b7e-390f4f292070@pengutronix.de>
 <74737543-4A73-49F8-92F7-F7FFE64A00DB@sigma-star.at>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <7f14dbb8-57a9-cbf5-a1f4-2ef7472da18d@pengutronix.de>
Date:   Fri, 20 Aug 2021 18:25:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <74737543-4A73-49F8-92F7-F7FFE64A00DB@sigma-star.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello David,

On 10.08.21 13:28, David Gstir wrote:
> Hi Ahmad,
> 
>> On 09.08.2021, at 12:16, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> 
> [...]
> 
>> If it interests you, I described[2] my CAAM+ubifs+fscrypt use case in the
>> discussion thread on my fscrypt-trusted-keys v1. Jan, a colleague of mine, held a
>> talk[3] on the different solutions for authenticated and encrypted storage, which
>> you may want to check out.
>>
>> I'd really appreciate feedback here on the the CAAM parts of this series, so this can
>> eventually go mainline.
> 
> Since you mention the fscrypt trusted-keys use case:
> 
> I noticed that the key length for trusted-keys is limited to
> 256 - 1024bit keys. fscrypt does however also support keys
> with e.g. 128bit keys (AES-128-CBC-ESSIV, AES-128-CTS-CBC).
> AFAIK, CAAM and TEE key blobs would also support key lengths outside the 256 - 1024bit range.
> 
> Wouldn’t it make sense to align the supported key lengths?
> I.e. extend the range of supported key lengths for trusted keys.
> Or is there a specific reason why key lengths below 256bit are
> not supported by trusted-keys?

No idea. I would suggest staying clear about arguing in its favor though
until CAAM and DCP are merged. My parallel fscrypt endeavors seem to have
only diverted maintainer attention. ;-)

Cheers,
Ahmad

> 
> Cheers,
> David
> 
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
