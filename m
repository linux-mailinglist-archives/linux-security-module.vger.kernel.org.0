Return-Path: <linux-security-module+bounces-12534-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9DFC04FDA
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Oct 2025 10:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8F6188BF62
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Oct 2025 08:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3CC3019BD;
	Fri, 24 Oct 2025 08:11:48 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299DF238C1B
	for <linux-security-module@vger.kernel.org>; Fri, 24 Oct 2025 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293508; cv=none; b=FDhStYEz5eQRv51gwqthBT24OLM1PWJobvkRbMwfTbt6rQ7CDiU3FnAmHmV0pAlwn3PzBgN6BxyXCsO0GCIAbj3esNVMChcv023RLwVKIyhlMoku3WBjQTUgFZ1VBDhX8ZKIH1G+0ksm1gKPpoeo5kagYHlgl3O8jtZ+RBhNQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293508; c=relaxed/simple;
	bh=EL8Md2vnm/vHXUXU2vV+VZr0Ecd+4ixEmKEa41zlpX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cGhSVl/abEJvHDePnoaOpFidHOCsnthxM+osbWtzgFRc23qNUEFNirZ/DGNHzME9wBQ0cBlvmu5cpSW1tlnitLf2AfPxqWjd4gslGrIf6v+998wg986ZH+y8ZQSYZSP+ILOYV4onZfMvi7U+a0PBIpTvFSEARfl0LDb+wk+wu3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1vCCt6-00071f-PI; Fri, 24 Oct 2025 10:11:04 +0200
Message-ID: <85aca6f9-f279-4977-8888-416af127edac@pengutronix.de>
Date: Fri, 24 Oct 2025 10:10:58 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KEYS: fix compilation warnings in the dump_options()
 function
To: yebin <yebin@huaweicloud.com>, kernel@pengutronix.de,
 James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
 zohar@linux.ibm.com, dhowells@redhat.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
 yebin10@huawei.com
References: <20251024061153.61470-1-yebin@huaweicloud.com>
 <68FB2470.4000206@huaweicloud.com>
Content-Language: en-US, de-DE, de-BE
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <68FB2470.4000206@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org

Hello,

On 10/24/25 9:02 AM, yebin wrote:
> Ignore this patch as 275a9a3f9b6a（“KEYS: trusted: Pass argument by
> pointer in dump_options”）already fix this issue.

What tree are you looking at? I can't find this commit in my git and the
code you are purportedly patching never existed upstream.

If you run into issues exclusive to a vendor fork, you need to submit
your patches to the vendor. The upstream mailing lists are for upstream.

Thanks,
Ahmad

> 
> On 2025/10/24 14:11, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> There's issue as follows:
>> security/keys/trusted-keys/trusted_caam.c: In function ‘dump_options’:
>> security/keys/trusted-keys/trusted_caam.c:37:20: note: the ABI of
>> passing struct with a flexible array member has changed in GCC 4.4
>>     37 | static inline void dump_options(struct caam_pkey_info pkey_info)
>>        |                    ^~~~~~~~~~~~
>>
>> To solve the above problem, pass 'struct caam_pkey_info*' type parameter
>> to the dump_options() function.
>>
>> Fixes: 9eb25ca6c973 ("KEYS: trusted: caam based protected key")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   security/keys/trusted-keys/trusted_caam.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/
>> keys/trusted-keys/trusted_caam.c
>> index 090099d1b04d..dd7a69bcf6a3 100644
>> --- a/security/keys/trusted-keys/trusted_caam.c
>> +++ b/security/keys/trusted-keys/trusted_caam.c
>> @@ -29,12 +29,12 @@ static const match_table_t key_tokens = {
>>   };
>>
>>   #ifdef CAAM_DEBUG
>> -static inline void dump_options(struct caam_pkey_info pkey_info)
>> +static inline void dump_options(struct caam_pkey_info *pkey_info)
>>   {
>> -    pr_info("key encryption algo %d\n", pkey_info.key_enc_algo);
>> +    pr_info("key encryption algo %d\n", pkey_info->key_enc_algo);
>>   }
>>   #else
>> -static inline void dump_options(struct caam_pkey_info pkey_info)
>> +static inline void dump_options(struct caam_pkey_info *pkey_info)
>>   {
>>   }
>>   #endif
>> @@ -108,7 +108,7 @@ static int trusted_caam_seal(struct
>> trusted_key_payload *p, char *datablob)
>>           ret = get_pkey_options(datablob, &info.pkey_info);
>>           if (ret < 0)
>>               return 0;
>> -        dump_options(info.pkey_info);
>> +        dump_options(&info.pkey_info);
>>       }
>>
>>       ret = caam_encap_blob(blobifier, &info);
>> @@ -140,7 +140,7 @@ static int trusted_caam_unseal(struct
>> trusted_key_payload *p, char *datablob)
>>           ret = get_pkey_options(datablob, &info.pkey_info);
>>           if (ret < 0)
>>               return 0;
>> -        dump_options(info.pkey_info);
>> +        dump_options(&info.pkey_info);
>>
>>           p->key_len = p->blob_len + sizeof(struct caam_pkey_info);
>>           memcpy(p->key, &info.pkey_info, sizeof(struct caam_pkey_info));
>>
> 
> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


