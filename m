Return-Path: <linux-security-module+bounces-9289-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA446A84BBF
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Apr 2025 19:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A31E8A093C
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Apr 2025 17:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5332836AA;
	Thu, 10 Apr 2025 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rZEaIgxK"
X-Original-To: linux-security-module@vger.kernel.org
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC028C5D0
	for <linux-security-module@vger.kernel.org>; Thu, 10 Apr 2025 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307888; cv=none; b=DmdEWaoTjJxUnjllylupFV2/saYwygPbpF3CfH/aCkE59Q1dQJSphNYmPUjb0p6ZR7LY/f9nR8nFes/sLrz6jpInKmxT8ET+Qn/ZXrH5pIbLz5h8/kny/o95qKgVjZatvDfabnXt4vtTFt2AcBN6L49lfSpYC/LQmjM3bTYjHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307888; c=relaxed/simple;
	bh=OlIsAcYX2VHdPjVpTPCaZwULIbuGv9Sa1X7qnqTi/vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tg5fyEiyuyKY6hFCsDK9qeEJNs59WYWZY+HpsC7CEBnfyqp/vBmt26+oU+ziSNq67ll9HsnIJiX7ddlHofxHw8W+/ZK8OaU/8KVR7OcuGrMxKmAgMmqCcR/DaaXYDyHyRsGfO9bm0/V+el8cW3wZJ+g+fKVBeJbN7chvo+lgFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rZEaIgxK; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744307880; bh=YD3xdj/z4oZdPq+V3H/76woWKciR/Y28VfQIXJ1rClg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=rZEaIgxKS7qcZRB/cZd9s9XlGVFtTiXaBSfnAEY0lGxU+vGEfgKpQ4YNXrevwOaXlTjjCBXiybnRv/X3Kf0mDEcrV7Hpj1CkJLziiaXhR1ZeZ3fryBb3dYSea3s+6Ct1clPXWVb37HlsZadOgSld/6W2e4YeeuxKIs+riQWbfshXBmN9qNwvEk3ZsFbA0/LnfUBO8UVNUg9ntA+vRZlwPX0CF9FX7+l8CC/oUgFfxriNR5Dwk/WGflp13tKZmV9+E2Mp5J5PjWn0AQmmmU682MxPWc16Jd/87iuRLQLlntq+8EmYUzxaId9PoD5uI80bJcrYEOn3Xy4Pe+M8O0UHiA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744307880; bh=VkUad3dPdG5+yrnwScq9F8uhrDECTjkixCsSg5zs5CH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rYYvB9ZTeM5JOhsJeOxbUAvxoR0s94vys6syn0GBnBIA5x37QQgB9szmau7itRXoNuEHdrLYX8PoDeTCrAuGrx28GXrA+0KioFawVhAKpyG6IaUlgKQ2VhqVmY4wJUrs6Gh0H/bHoDz+/s6Q1F1ZrtPWuaMT7VnaGczP2ZC0QBLmWfe5Kp1R6veoWI7tCkFPiDQE4vYG4xg/fnA3Ei+aUwJKnjF0pKcmXj6xf1FZbYEsKHeV1A4lRPAFUB+YJ53aAg1iTwUqvsVZ2uFy84e8WvkFn36xj6FVDcTNwQNWyxBlzG5RW5uf6ptDrdCnD/KmJ4MSRf2PioWIEducHiH0JQ==
X-YMail-OSG: d6wiBfMVM1kWTs4Olt9LCrNBxqmN0KxZ0t97Oye7Vznrnitq6GELfs_Hc94_xG8
 jwScbi1xQfVmEB7Naj2wE69FufJHENUiDIuTDH1_W8kpV6aHiZpW1uFLnJ7ol2PXqiH9b986rBsy
 sL9t0Zsua6vLJMRUyQFULhSe_Tgep1bxjrNmR7txqRIho.15w67wQRq95EZAZGsh0ENv0uNxd8yi
 fhFc5IVynodeD9Devi7rxTObhu170MNSM4kSSEg6o3zznNbXcu0elaACR1bFnvCL2Wx7Z2Ex35mC
 0i.YDE2UZvlUUhhvCPBZrCO.PXsHf9vHzdoIeYaIRvX5d5oE8m6K5YumRJNurzswHRu6gRLrJ.g5
 BgMdn5m1CXKQu4qvZtU6UVJ.5kQVseEqiDB3NRMNEU3zjidTW0lkAII3LOmhaBe3lK.DYrQH2lHf
 yAHM081cnC7cn5uHGJSXlFIlYDk9IQPYJdKccddmg4qHltNIHXubiXoCKGI_B.YTNeQhU.xgb2mG
 mjLkIUNK.7saUazg5FC4p56O8vZFDyRJKeh_bdee4utwiCVgNa_iAVfwVtRbGB._LxIIyFXUEh34
 ZxhjS.ydQ0sEjsY9lmSYqYJms9or_7ppYkNG._3s9FkuvKPnU3VoZAnnmB_aWQRaIKGXsThtJEe_
 qjm9ynWSgtHRa6tmKvJaqXxZHfoxvcRhirF0PiLTYBjFFSbZadkcksz0_byjMI9s8uCB3SeCBn8T
 MEUEsyr2U8D5QBhAfADKWCmgGVbfSh5u1L0Pi9Nv7eQxY7Mv4jYA7E.R4hvRbKkvDGP5n6xOiwCL
 3VrZH2vjrwg1uVM2K0jqXmlqJsuU0osDV6kr9GI3akaccsJP.kz2g8.bonBWfSiZ7Mfg3tv2oEvz
 e.8QvwROUGrC4.QRrlztwsrW5P7Zazv574avGRwxdVRFPjUdnfH_azpE_mRrQ_PPjNotfcb_f8w3
 mxV6KbpzDI9vlZT4CNYwPxfALCU0MWtRM1PBm0EYk2o3zqO7jzHtTGJRiL7SvV3BzGd5KleEOe_C
 _.CGgE6ZCFF5fwZ4DgAJLiNoyQMoM.IxCVkJktJiiadPLVG.k8OJOZrzN9Mx6pUvzqrMlxJNdE0Z
 f0qiLgrZf8HOYWGP7dN8MJohW1OIl3CcElWXVUuogVaI1w8q6yxqrgCquUVlEeIV5lenE4ZFUDgt
 dJcDXNQUMXz9aBJqlHgmJr9ibumGqChmIJYoppwZ5xwVQKFJW3MUHyauo0IIDOZdTin6z1E99s1n
 fg2EVJjXevtAg9xHiNGBJgrzRpTG9itXbbsM7n_Gpemh.hCeJAOz7j1YM1P0GevLvPAjzonyqzgO
 2fQQ1v3nhgK9rSqjhUqkudJxuNstmLiOSrF7gAaTFTCb8rKomMnzKtB2c0eQ5TIml8Ro6xkAG2f0
 yyeO7PGNw8_XTQuaWKiV1OTKRDh6bBePQPNGWJsg5.bFHPznTaDfTHa9ldyWMRAY_pP4Xm_4tS0r
 eeYanzlta0yWupR1MyL.gasH6pzCizhRuFD7B.f0qZ_ZFoxUZhtJgt5r669vb.Dd51DCKbAB6opL
 TbKIJn_IQ1z_Rt0DQMcnyacnJG2ra1IYXKDf2SGpnTH6X.wqZ5_5ZJPrMUMcVVK0UP34V2S4KAkJ
 JdnQZqoo9Fo1lIeHsiWQf1.ifNOlBR6X6zl3xV61h1CzGk4B4mR2Xt40.w54Ys3KZXpvKhtsNFRA
 KMP6dcJ75rl9EZJizQf45TDREK5co1TH0f.fNEG6eFimrYItVGwBAdLwtrLBjZGwoPR3AsSkE5Vu
 JeZZBmyK_vjN9T7lM5UTTTB0htwUZIyKJPEZ4K8ieuLBslLSRHk_VCs7HZy9WhSm0Pjp3QF_418r
 7y_41O4AjExnLRH2ROGQBj5a5_IU2TvsiitGYF7Cfr.OCymdHNSAFGp3JqC_W3YQKEatH239C1Fp
 FJSaoQ_URQmoSbDfqFhtZ8YIsDIGYI8bGqgSFARXptu8IZZdoRztMZdqcq6PSlk0yFLmUR.4w4Z6
 vhqX78pFoJLIOmN.mHdzL2s8U_k65M_UTFWuOH_avGdfH1_3lplD38WZblKWH7ipTamYIOzbKiSW
 F9JGM6hFZ9PKAYV5S1mIyGpTsuef466ue_QYYL2LVOc74AuZonKaAYdsK_3rL8MQKprsTVczWTVw
 uMHrIFLPxr8SA1y6T.zVNCm1AKef5qMBmGFOQs_Pt6Uc2pweGvIwifF9jIbjCacaDE8236ZJOlek
 fTgLwLUwQq9x3EyGNG1MPLbzarelirHECTLoVoKGrk8iVcnbYvhiMcDmk_WgW4MbqU1IY.tF1BMS
 nnQ2v.Q5P56mo8hyPg.I1tmSSDqZzvkyw
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9696b047-ce8e-4ba2-abbe-3b5022ba2333
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Apr 2025 17:58:00 +0000
Received: by hermes--production-gq1-6f8bfcd964-n4g77 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 31944fcd114ef8bfb5b41c83c1fc6d82;
          Thu, 10 Apr 2025 17:47:51 +0000 (UTC)
Message-ID: <ec1e40a9-16aa-41c3-9417-c474c4bc344c@schaufler-ca.com>
Date: Thu, 10 Apr 2025 10:47:50 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 20/29] smack: move initcalls to the LSM framework
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-51-paul@paul-moore.com>
 <d16f307c-349b-4409-a237-ae7092584576@schaufler-ca.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <d16f307c-349b-4409-a237-ae7092584576@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23665 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/10/2025 10:30 AM, Casey Schaufler wrote:
> On 4/9/2025 11:50 AM, Paul Moore wrote:
>> As the LSM framework only supports one LSM initcall callback for each
>> initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
>> wrapped with a new function, smack_initcall() that is registered with
>> the LSM framework.
>>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  security/smack/smack.h           |  6 ++++++
>>  security/smack/smack_lsm.c       | 16 ++++++++++++++++
>>  security/smack/smack_netfilter.c |  4 +---
>>  security/smack/smackfs.c         |  4 +---
>>  4 files changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/security/smack/smack.h b/security/smack/smack.h
>> index bf6a6ed3946c..709e0d6cd5e1 100644
>> --- a/security/smack/smack.h
>> +++ b/security/smack/smack.h
>> @@ -275,6 +275,12 @@ struct smk_audit_info {
>>  #endif
>>  };
>>  
>> +/*
>> + * Initialization
>> + */
>> +int init_smk_fs(void);
>> +int smack_nf_ip_init(void);
>> +
>>  /*
>>   * These functions are in smack_access.c
>>   */
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index e09b33fed5f0..80b129a0c92c 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -5277,6 +5277,21 @@ static __init int smack_init(void)
>>  	return 0;
>>  }
>>  
>> +static int smack_initcall(void)
>> +{
>> +	int rc, rc_tmp;
> separate lines for the declarations please.
>
>> +
>> +	rc_tmp = init_smk_fs();
>> +	if (rc_tmp)
>> +		rc = rc_tmp;
> Replace these three lines with:
>
>  +	rc = init_smk_fs();
>
>> +
>> +	rc_tmp = smack_nf_ip_init();
>> +	if (!rc && rc_tmp)
>> +		rc = rc_tmp;
> Change this to
>
>  +	rc_tmp = smack_nf_ip_init();
>  +	return rc ? rc : rc_tmp;
>
> Also change rc_tmp to rc_nf and rc to rc_fs.
>
>> +
>> +	return rc;
>> +}
>> +
> Or:
>
> static int smack_initcall(void)
> {
> 	int rc_fs = init_smk_fs();
> 	int rc_nf = smack_nf_ip_init();
>
> 	return rc_fs ? rc_fs : rc:nf;

Whoops - return rc_fs ? rc_fs : rc_nf;

> }
>
>>  /*
>>   * Smack requires early initialization in order to label
>>   * all processes and objects when they are created.
>> @@ -5286,4 +5301,5 @@ DEFINE_LSM(smack) = {
>>  	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>>  	.blobs = &smack_blob_sizes,
>>  	.init = smack_init,
>> +	.initcall_device = smack_initcall,
>>  };
>> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
>> index 8fd747b3653a..17ba578b1308 100644
>> --- a/security/smack/smack_netfilter.c
>> +++ b/security/smack/smack_netfilter.c
>> @@ -68,7 +68,7 @@ static struct pernet_operations smack_net_ops = {
>>  	.exit = smack_nf_unregister,
>>  };
>>  
>> -static int __init smack_nf_ip_init(void)
>> +int __init smack_nf_ip_init(void)
>>  {
>>  	if (smack_enabled == 0)
>>  		return 0;
>> @@ -76,5 +76,3 @@ static int __init smack_nf_ip_init(void)
>>  	printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
>>  	return register_pernet_subsys(&smack_net_ops);
>>  }
>> -
>> -__initcall(smack_nf_ip_init);
>> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
>> index 90a67e410808..d33dd0368807 100644
>> --- a/security/smack/smackfs.c
>> +++ b/security/smack/smackfs.c
>> @@ -2980,7 +2980,7 @@ static struct vfsmount *smackfs_mount;
>>   * Returns true if we were not chosen on boot or if
>>   * we were chosen and filesystem registration succeeded.
>>   */
>> -static int __init init_smk_fs(void)
>> +int __init init_smk_fs(void)
>>  {
>>  	int err;
>>  	int rc;
>> @@ -3023,5 +3023,3 @@ static int __init init_smk_fs(void)
>>  
>>  	return err;
>>  }
>> -
>> -__initcall(init_smk_fs);

