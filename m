Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46F2FD087
	for <lists+linux-security-module@lfdr.de>; Wed, 20 Jan 2021 13:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbhATMkV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 20 Jan 2021 07:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388932AbhATLOQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Jan 2021 06:14:16 -0500
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29612C0613D3;
        Wed, 20 Jan 2021 03:13:12 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DLNDN5227zMqLkr;
        Wed, 20 Jan 2021 12:13:08 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DLNDL1gRxzlh8T2;
        Wed, 20 Jan 2021 12:13:06 +0100 (CET)
Subject: Re: [PATCH v3 02/10] certs: Fix blacklisted hexadecimal hash string
 check
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ben Boeckel <mathstuf@gmail.com>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-3-mic@digikod.net> <YAem+DjBR92WG+bK@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <05e3ce56-c27c-877d-8ebe-d088ba95f248@digikod.net>
Date:   Wed, 20 Jan 2021 12:12:50 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <YAem+DjBR92WG+bK@kernel.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 20/01/2021 04:43, Jarkko Sakkinen wrote:
> On Thu, Jan 14, 2021 at 04:19:01PM +0100, Micka�l Sala�n wrote:
>> From: Micka�l Sala�n <mic@linux.microsoft.com>
>>
>> When looking for a blacklisted hash, bin2hex() is used to transform a
>> binary hash to an ascii (lowercase) hexadecimal string.  This string is
>> then search for in the description of the keys from the blacklist
>> keyring.  When adding a key to the blacklist keyring,
>> blacklist_vet_description() checks the hash prefix and the hexadecimal
>> string, but not that this string is lowercase.  It is then valid to set
>> hashes with uppercase hexadecimal, which will be silently ignored by the
>> kernel.
>>
>> Add an additional check to blacklist_vet_description() to check that
>> hexadecimal strings are in lowercase.
>>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Signed-off-by: Micka�l Sala�n <mic@linux.microsoft.com>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> Reviewed-by: Ben Boeckel <mathstuf@gmail.com>
>> ---
>>
>> Changes since v2:
>> * Cherry-pick v1 patch from
>>   https://lore.kernel.org/lkml/2659836.1607940186@warthog.procyon.org.uk/
>>   to rebase on v5.11-rc3.
>> * Rearrange Cc order.
>> ---
>>  certs/blacklist.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/certs/blacklist.c b/certs/blacklist.c
>> index 2719fb2fbc1c..a888b934a1cd 100644
>> --- a/certs/blacklist.c
>> +++ b/certs/blacklist.c
>> @@ -37,7 +37,7 @@ static int blacklist_vet_description(const char *desc)
>>  found_colon:
>>  	desc++;
>>  	for (; *desc; desc++) {
>> -		if (!isxdigit(*desc))
>> +		if (!isxdigit(*desc) || isupper(*desc))
>>  			return -EINVAL;
>>  		n++;
>>  	}
>> -- 
>> 2.30.0
>>
> 
> Shouldn't this rather convert the upper case to lower case? I don't like
> the ABI break that this causes.

It doesn't break the ABI because keys loaded in the blacklist keyring
can only happen with builtin hashes.  Moreover these builtin hashes will
be checked by patch 10/10 at build time.

This patch is also important to remove a false sense of security and
warns about mis-blacklisted certificates or binaries:
https://lore.kernel.org/lkml/c9664a67-61b7-6b4a-86d7-5aca9ff06fa5@digikod.net/

Hot-patching keys doesn't seem a good idea, especially when these keys
are signed. Moreover, it would bring additional complexity and will
require to change the core of the key management.

> 
> /Jarkko
> 
