Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649E43E438B
	for <lists+linux-security-module@lfdr.de>; Mon,  9 Aug 2021 12:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhHIKDd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 9 Aug 2021 06:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbhHIKDQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Aug 2021 06:03:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD612C061799
        for <linux-security-module@vger.kernel.org>; Mon,  9 Aug 2021 03:02:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mD27K-0004Xk-4p; Mon, 09 Aug 2021 12:02:46 +0200
Subject: Re: [PATCH v2] fscrypt: support trusted keys
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        David Howells <dhowells@redhat.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-security-module@vger.kernel.org,
        James Bottomley <jejb@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-integrity@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <20210806150928.27857-1-a.fatoum@pengutronix.de>
 <20210809094408.4iqwsx77u64usfx6@kernel.org>
 <10dac5c6-4530-217c-e1ea-a7e2e3572f43@pengutronix.de>
Message-ID: <57619a74-8292-64c6-0dbb-2f01de281652@pengutronix.de>
Date:   Mon, 9 Aug 2021 12:02:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <10dac5c6-4530-217c-e1ea-a7e2e3572f43@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 09.08.21 12:00, Ahmad Fatoum wrote:
> Hello Jarkko,
> 
> On 09.08.21 11:44, Jarkko Sakkinen wrote:
>> On Fri, Aug 06, 2021 at 05:09:28PM +0200, Ahmad Fatoum wrote:
>>> Kernel trusted keys don't require userspace knowledge of the raw key
>>> material and instead export a sealed blob, which can be persisted to
>>> unencrypted storage. Userspace can then load this blob into the kernel,
>>> where it's unsealed and from there on usable for kernel crypto.
>>>
>>> This is incompatible with fscrypt, where userspace is supposed to supply
>>> the raw key material. For TPMs, a work around is to do key unsealing in
>>> userspace, but this may not be feasible for other trusted key backends.
>>>
>>> Make it possible to benefit from both fscrypt and trusted key sealing
>>> by extending fscrypt_add_key_arg::key_id to hold either the ID of a
>>> fscrypt-provisioning or a trusted key.
>>>
>>> A non fscrypt-provisioning key_id was so far prohibited, so additionally
>>> allowing trusted keys won't break backwards compatibility.
>>>
>>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>> ---
>>> Tested with:
>>> https://github.com/google/fscryptctl/pull/23
>>> -	if (key->type != &key_type_fscrypt_provisioning)
>>> -		goto bad_key;
>>> -	payload = key->payload.data[0];
>>> +	if (key->type == &key_type_fscrypt_provisioning) {
>>
>> Why does fscrypt have own key type, and does not extend 'encrypted' with a
>> new format [*]?
> 
> See the commit[1] adding it for more information. TL;DR:
> 
> fscrypt maintainers would've preferred keys to be associated with
> a "domain". So an encrypted key generated for fscrypt use couldn't be reused
> for e.g. dm-crypt. They are wary of fscrypt users being more exposed if their
> keys can be used with weaker ciphers via other kernel functionality that could
> be used to extract information about the raw key material.
> 
> Eric also mentioned dislike of the possibility of rooting encrypted keys to
> user keys. v2 is only restricted to v2, so we didn't discuss this further.

Typo: v2 (of my series) is only restricted to s/v2/trusted keys/

> 
> Restricting the key to fscrypt-only precludes this reuse.
> 
> My commit makes no attempts in changing that. It just adds a new way to pass
> raw key material into fscrypt. For more information, see the commit[1] adding
> that key type.
> 
>> [*] https://www.kernel.org/doc/html/v5.13/security/keys/trusted-encrypted.html
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=93edd392ca
> 
> Cheers,
> Ahmad
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
