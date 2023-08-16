Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD8C77E3EB
	for <lists+linux-security-module@lfdr.de>; Wed, 16 Aug 2023 16:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343734AbjHPOl7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 16 Aug 2023 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343762AbjHPOlz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Aug 2023 10:41:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6CADF;
        Wed, 16 Aug 2023 07:41:53 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GEau5e020561;
        Wed, 16 Aug 2023 14:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ej3Tg6fPMFbdIjBJCSIAQjJhxqb+o+Y3fbmqZTQs+aQ=;
 b=F6femcaLpWIN8+PD9QlpyS0VbifyyB3Pqwpb5w8BZab9lA+9CHhVJw4O/p30fksJCT8F
 WTzLNWlbsReYmtm9vb4McVK/mc51Wxn0z2NrQn/1X8k/HBT62u0fvuRYk/JyejVGBEtK
 CFR6xYPfhooYvzJiXdjMC8Zqb0N4aLqmweK/2zC3Ui3TLL20eZ0JjeuQ1dY/4HqPV+Je
 3DrrvvWHxUrCJuWwF5cv69lX5aYIFD3rdajKtrrLia7RsL6kj41SzQ0eOAfSFfG7Ju6i
 GiES2kNFBTgjLyCFyKxWBrp21euf38qdPjV2bhPyxENQi0T4Q6OHF2KkL+0E0gNp/jD0 ZA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh08w0g3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 14:41:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GDxMP4002409;
        Wed, 16 Aug 2023 14:41:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendndctu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 14:41:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GEfa0U63766852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 14:41:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FC392004D;
        Wed, 16 Aug 2023 14:41:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE43E20043;
        Wed, 16 Aug 2023 14:41:34 +0000 (GMT)
Received: from [9.43.32.205] (unknown [9.43.32.205])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Aug 2023 14:41:34 +0000 (GMT)
Message-ID: <a464b724-4a4e-8836-4050-12a8b6c87a03@linux.ibm.com>
Date:   Wed, 16 Aug 2023 20:11:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 4/6] integrity: check whether imputed trust is enabled
Content-Language: en-US
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org, inux-kernel@vger.kernel.org
References: <20230815112722.1591829-1-nayna@linux.ibm.com>
 <20230815112722.1591829-5-nayna@linux.ibm.com>
From:   R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20230815112722.1591829-5-nayna@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: whjlAgwrX1nRIKl0oZ-F9Hk6C_h6ZwLd
X-Proofpoint-GUID: whjlAgwrX1nRIKl0oZ-F9Hk6C_h6ZwLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_14,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160125
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 15/08/23 4:57 pm, Nayna Jain wrote:
> trust_moklist() is specific to UEFI enabled systems. Other platforms
> rely only on the Kconfig.
> 
> Define a generic wrapper named imputed_trust_enabled().
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Tested with trustedcadb, moduledb scenarios
Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

> ---
>   security/integrity/digsig.c                    |  2 +-
>   security/integrity/integrity.h                 |  5 +++--
>   .../integrity/platform_certs/keyring_handler.c |  3 ++-
>   .../integrity/platform_certs/machine_keyring.c | 18 ++++++++++++++++--
>   4 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index d0704b1597d4..df387de29bfa 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -113,7 +113,7 @@ static int __init __integrity_init_keyring(const unsigned int id,
>   	} else {
>   		if (id == INTEGRITY_KEYRING_PLATFORM)
>   			set_platform_trusted_keys(keyring[id]);
> -		if (id == INTEGRITY_KEYRING_MACHINE && trust_moklist())
> +		if (id == INTEGRITY_KEYRING_MACHINE && imputed_trust_enabled())
>   			set_machine_trusted_keys(keyring[id]);
>   		if (id == INTEGRITY_KEYRING_IMA)
>   			load_module_cert(keyring[id]);
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 7167a6e99bdc..d7553c93f5c0 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -320,13 +320,14 @@ static inline void __init add_to_platform_keyring(const char *source,
>   
>   #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
>   void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
> -bool __init trust_moklist(void);
> +bool __init imputed_trust_enabled(void);
>   #else
>   static inline void __init add_to_machine_keyring(const char *source,
>   						  const void *data, size_t len)
>   {
>   }
> -static inline bool __init trust_moklist(void)
> +
> +static inline bool __init imputed_trust_enabled(void)
>   {
>   	return false;
>   }
> diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
> index 1649d047e3b8..586027b9a3f5 100644
> --- a/security/integrity/platform_certs/keyring_handler.c
> +++ b/security/integrity/platform_certs/keyring_handler.c
> @@ -61,7 +61,8 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
>   __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
>   {
>   	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
> -		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && trust_moklist())
> +		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) &&
> +		    imputed_trust_enabled())
>   			return add_to_machine_keyring;
>   		else
>   			return add_to_platform_keyring;
> diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
> index 9482e16cb2ca..a401640a63cd 100644
> --- a/security/integrity/platform_certs/machine_keyring.c
> +++ b/security/integrity/platform_certs/machine_keyring.c
> @@ -34,7 +34,8 @@ void __init add_to_machine_keyring(const char *source, const void *data, size_t
>   	 * If the restriction check does not pass and the platform keyring
>   	 * is configured, try to add it into that keyring instead.
>   	 */
> -	if (rc && efi_enabled(EFI_BOOT) && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
> +	if (rc && efi_enabled(EFI_BOOT) &&
> +	    IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
>   		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
>   					 data, len, perm);
>   
> @@ -60,7 +61,7 @@ static __init bool uefi_check_trust_mok_keys(void)
>   	return false;
>   }
>   
> -bool __init trust_moklist(void)
> +static bool __init trust_moklist(void)
>   {
>   	static bool initialized;
>   	static bool trust_mok;
> @@ -75,3 +76,16 @@ bool __init trust_moklist(void)
>   
>   	return trust_mok;
>   }
> +
> +/*
> + * Provides platform specific check for trusting imputed keys before loading
> + * on .machine keyring. UEFI systems enable this trust based on a variable,
> + * and for other platforms, it is always enabled.
> + */
> +bool __init imputed_trust_enabled(void)
> +{
> +	if (efi_enabled(EFI_BOOT))
> +		return trust_moklist();
> +
> +	return true;
> +}

-- 
Thanks and Regards
R.Nageswara Sastry
