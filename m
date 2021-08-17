Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239E53EECFF
	for <lists+linux-security-module@lfdr.de>; Tue, 17 Aug 2021 15:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbhHQNFq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 17 Aug 2021 09:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbhHQNFn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 Aug 2021 09:05:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE253C0613C1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Aug 2021 06:05:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mFymB-0006MT-9m; Tue, 17 Aug 2021 15:05:07 +0200
Subject: Re: [PATCH v2] fscrypt: support trusted keys
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, kernel@pengutronix.de,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Howells <dhowells@redhat.com>,
        linux-fscrypt@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210806150928.27857-1-a.fatoum@pengutronix.de>
 <20210809094408.4iqwsx77u64usfx6@kernel.org> <YRGVcaquAJiuc8bp@gmail.com>
 <20210810180636.vqwaeftv7alsodgn@kernel.org> <YRLJmaafp941uOdA@gmail.com>
 <20210810212140.sdq5dq2wy5uaj7h7@kernel.org> <YRLvPJehAeMiYb2Z@gmail.com>
 <20210811001743.ofzkwdwa6rcjsf4d@kernel.org>
 <d4f5c2593380c82ceebae2c8782a1c440b35f165.camel@linux.ibm.com>
 <YRQF09f8st95yrFZ@gmail.com>
 <0e69a0aa394dd20347b06ae4e700aa17d52583ef.camel@linux.ibm.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <a6eb6f38-b9f4-c59c-4181-2049f181e67d@pengutronix.de>
Date:   Tue, 17 Aug 2021 15:04:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <0e69a0aa394dd20347b06ae4e700aa17d52583ef.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

On 12.08.21 02:54, Mimi Zohar wrote:
> On Wed, 2021-08-11 at 10:16 -0700, Eric Biggers wrote:
> 
>> Neither of you actually answered my question, which is whether the support for
>> trusted keys in dm-crypt is a mistake.  I think you're saying that it is?  That
>> would imply that fscrypt shouldn't support trusted keys, but rather encrypted
>> keys -- which conflicts with Ahmad's patch which is adding support for trusted
>> keys.  Note that your reasoning for this is not documented at all in the
>> trusted-encrypted keys documentation; it needs to be (email threads don't really
>> matter), otherwise how would anyone know when/how to use this feature?
> 
> True, but all of the trusted-encrypted key examples in the
> documentation are "encrypted" type keys, encrypted/decrypted based on a
> "trusted" type key.  There are no examples of using the "trusted" key
> type directly.  Before claiming that adding "trusted" key support in
> dm-crypt was a mistake, we should ask Ahmad why he felt dm-crypt needed
> to directly support "trusted" type keys.

I wanted to persist the dm-crypt key as a sealed blob. With encrypted keys,
I would have to persist and unseal two blobs (load trusted key blob, load
encrypted key blob rooted to trusted key) with no extra benefit.

I thus added direct support for trusted keys. Jarkko even commented on the
thread, but didn't voice objection to the approach (or agreement for that
matter), so I assumed the approach is fine.

I can see the utility of using a single trusted key for TPMs, but for CAAM,
I see none and having an encrypted key for every trusted key just makes
it more cumbersome.

In v1 here, I added encrypted key support as well, but dropped it for v2,
because I am not in a position to justify its use. Now that you and Eric
discussed it, should I send v3 with support for both encrypted and trusted
keys like with dm-crypt or how should we proceed?

Cheers,
Ahmad

> 
> Mimi
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
