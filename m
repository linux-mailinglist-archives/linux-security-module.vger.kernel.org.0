Return-Path: <linux-security-module+bounces-1889-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3CB873CDC
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Mar 2024 18:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0511C209A0
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Mar 2024 17:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E88A13793C;
	Wed,  6 Mar 2024 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PONFx5lE"
X-Original-To: linux-security-module@vger.kernel.org
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A75132C0C
	for <linux-security-module@vger.kernel.org>; Wed,  6 Mar 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744655; cv=none; b=XaOUwthNDrvOWYQwipgDeLhbOAPI2CyTuMIYMmpLCMDaOsKSFk6w6IXQSieuebsC9bU9x45QEhvq0n+FFAQx5gP94eD6Pl1JRDYPGirAiQKr5OOXKKq1jD5b4y+4dn4de289mquNLvOlFQtcWcrC82NDnQFJR2DZ+RakxxQs68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744655; c=relaxed/simple;
	bh=nVjpTJbqZspHRIdxDEfwTYZMbFoO1dHoOHNlxEN49jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQi8/z+sJAO0JkLWJ9gYkRUG1hsgTmBLWichaEVoS4xoIy7aMVXgdHLyVK3bBbgbqGwjpuX4+BqA3s0GgMsQ0Y/onG/SQ9yvJ1zUL805oecPiDXjxaCidLzainlCxMe9O+/Lwb5c1dXiFjnJahVgkXpXFXhHCu7R/ruOFlQzIpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PONFx5lE; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1709744650; bh=1SMfIpn57reKMM5kAQw8dAp+MNKmHlTsC8k5O/I2P8E=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PONFx5lENbQZ7gRWlVBKDVoTtipXctcIJjzRn9xDkSZR1io88XunhDRJtHN5AblnBIHC9Fj+3VXTFVtzAZ+QsyS97Knp8xzJfVeFMYwzYCHZDIp1y9027syWqfQdv/y4Fi9Rj/vBxinaVnsJUJx4+CDhIxO0HN/coduAukI/RRY3v0A4dczJu4cVTHpahjGx2cj2pUDIciOAiQNaXIhfNL3nqwICg6L5PAFPRjaDPEaQsTlZZ0u/XPSwm2xXQqhHAQY8s6v7VJYHNIBSxq1s3WJCDBMZS21M5CDghd2Uzi07aC40uQnedb6U/naGXpelK4e6TbIj/b0L+DIFeotHQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1709744650; bh=OaPJP8tvxaXNu6WDWkRnChlGcJ6NO+UZiotSVdeQGOj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YAeGSVcI+RS7szWL3I+MnWnzMeH9OD02azEMGrnmfp7rbc8NDiDfnN+mm5G/4B3QNonJHqZPrlzTVnkVXJgVVW7T6mGu8cJbwcqZOL4MWOfiK07js0gttPM1b31BNWWIasvmwmeTvHbr+Ky0nmu20/U4henvUgESzR5dYetP6Ja+s9+LlZcNsN8ei7jKgLnGR4YsJkikb8JQn+GkCCvHrTgj5Y4e+eHSg6hxYZZplmMEEh2L3twCDMC/P5D0iy9wPJPBO2IsbbIHNYg38yW2NG7IC1afHt7VcCXBMeHbIgQfhb4WToZaeYc50LOqhIFTtV07ARWlUfDm5Xw+V0Hr4Q==
X-YMail-OSG: jXPBgZYVM1miqvp1UsVV_vweMb3XOAGEJH5N9km8hxLF7c6zAJ7MXS72xRDIPDX
 QQiDKzsG7hMpARYt8l3H78juRfaAirsvm1RGqHQjrcXRK_3svd33rmlHhxGC3aIztNJHT8WNQIfC
 CBiIsiDJUfBQOf2giM1ZDN3falO7.KFm1u0.P7AECpmk9ZTieKAe2ccYjm7Il0HMfGR6v0Nj7C0q
 12VZ9KgVXZW3GPImY1SY3xokzuuXbZhoZxGjqGOig7gcl2s_1.Vu_CBNKdtcVMkCbQ8CYxxmwojM
 plPZnR8QOZN92IsPJmE.XyzrUfAr4bP07ovTeh_An5xwods1rTW4wPBo9ZeoEywR92pl7GX76p0F
 LYizFOm5gJfOkTDAscTqV4EE1BXVeMDAA15.L9YpZqCezWWHqXESdef0vBNoc.ISxnfLUOncnB9t
 cA_EfvKrBpfCE6CNwsRYA2UzDleKyWDHOQ4EMm39gvt5vfQX_hsifH8larZZ.UIlmSQP9AbfoC7J
 xUwGoq0qsMd3zeU0CwOBopd5tApEmze.2AErass9fCYe5ouN2z.o8MDhbBSAfB2JzRRZ8chdtn88
 JM5DAuk2AsxZ74euIbI_ZRnpTzCgqyb0ZQNzLA_pvyKQP5U9LU5kwlVYe4aEhkbNsbHlLXiOTmcO
 rAbWNiEgQApRtx8ppulLwJu0t_ViEe6YXWmUbpimE7dcRgAsE42L8EdFBTBu32_4zBQx9vR1Kia6
 1P49KGbEUEXEWQE9DCC8DofkIbi01jxEYff2AEqAwWbjUSumysXtMXTAIAVLFTsC_9Ru71ll5q_a
 5PMqktJ_zAvWtq5TIyBJl37l2XvtmIz6bI8UoKyUTtmzHJ8LHQ42MZVoMEX5kIgqF1MZc1FnrFwb
 iLiBQj_VHvxBtVW8RuDhMdu5QxJ7HMCv21OXla.P0Bib508GJTKOIRIhlz8SY727RshDjJT16sV8
 TbwdkboJjzj4iEIkJphG5IeXCChfJFtlJw9ciOIq_DZH1q.rRJcFWOpVvPWLBY4qt_xMZIf.v1eh
 H4En9koFfi4OdEBT6rdTz4uxM8WFL2y4XZlYNFj2oq4adzp0N8U26hMFXblP4Fcp9sayWVdl9Vd7
 GjeyWVhk7qOvkCGOlbTeLXa0v94EZGHuWlUrxOlShe44ne1MjFsiIOsFOQBu6MWYKQg74u6DLrrh
 iYjZUKnV01maxKmWnecQ16Xv.L3NohLA7pXOvErh9XBsV85DDTtzarEnhSm9WzTMjBLP8XX7.gXv
 Ub6cn1pchEHytNPWWmwmFVFydEAkx8Suhf2CVn9EKkmBmwqC4aZTD.cThuRHs.sAIyEf7RfGJHot
 LsYUgmss3lbXdUJXO5wPrYWZ5dSeo_CIePROfAvH0bUtLUL74vs3adUfNaDMkkqcuw5dYjMf1QSa
 ClRsJy0PDcO7uG3C9h.kW0WwivJydzoZPsQtAEnpCjRBk3RiJ8jMbA2SyCEGI9bGCXeDNFiN8.4a
 tgfGCuBM5Opv6QJbfZNDH9fnVsZherPnQIJJENvbZ1cwyww9.CydAWfAeA.nNWdUGOc3XhdRebc8
 yqKFCHhTL7vqpzy6cs8apBQFBbB_fZzk0EHUY_DdWd5d6Jp4U1oINDEz7RG0OANHkpTWIU6Ahpi1
 zoWPV.WZz5UMX6iuLs4U_NsaX1P4akWVJXpfaZ7XANyjxpBxIKrkgjIegV.7s7oRoXjUfYF1KJWa
 RgyntSTFkuLnvZISxaTfESooi21yXP0SRqBI81W0QQ5DzEnsPy8IUqf.vAX3qhjUcAf5DY3nLqY4
 p_o4.eGyuGz1gAxaMaAx.V9ikq4RyjyTkdD9qbH9iOjrNiPPt.8EQ6__T5aXx7l9lC8zkcmO4ntW
 faw9e2deOzuCWNyyD.1GblSlNpOVmBwUQ0RQoH_qFuutdgbs38lEBPbDIONJ2eYTibHmAfYJqxvy
 S3T1ooHWnYIHpt60fFMwgjNN1cez9ZvK8qcT608uJjJt7qx26TYkSaWr4A3Rp_6M4bWNry0tq3Bz
 aObcGvaxdYhcF7YirdPG7qDuQwbifAuB1Szv7HOBVcvGe05WQXkGn7NK9Zu56fscYp_lCPpjGXr.
 3PvltQdIrE4ttMlewrIriwlG.Ca90tJfqhAvrhPclwDsLZ21m0NqtG_jjVQpzYbuv0E7WTKnjATb
 lXQV2GooGD5QpEOSjo3TzT3NlAWzXoAIvsG6Sw6FLkBmK13S591AxInpNoy4rcErjYrkL9BU5FAv
 SouuSVwmDK9fQRga4GVIAQFcb8pIkYuQ6KfkVAlcx5c2QYUEtkr1p7juHBC6iJBNE1B0xD25l_WA
 k0suk1xlXrxFqgGntUJENm4TivpcQuAkJKMMiJig-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 068c55dd-8ae7-4056-add9-6e4a47e373c5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 6 Mar 2024 17:04:10 +0000
Received: by hermes--production-gq1-5c57879fdf-9nrfh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c3cbee969fec4dbe611894f55563aebb;
          Wed, 06 Mar 2024 17:04:07 +0000 (UTC)
Message-ID: <a593b189-c6e1-4dff-9134-ff50e894b851@schaufler-ca.com>
Date: Wed, 6 Mar 2024 09:04:06 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v39 04/42] IMA: avoid label collisions with stacked LSMs
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 mic@digikod.net, Casey Schaufler <casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-5-casey@schaufler-ca.com>
 <c764944e8dad89fd88129168b7fc19fd9948e37a.camel@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <c764944e8dad89fd88129168b7fc19fd9948e37a.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/6/2024 2:09 AM, Roberto Sassu wrote:
> On Fri, 2023-12-15 at 14:15 -0800, Casey Schaufler wrote:
>> Integrity measurement may filter on security module information
>> and needs to be clear in the case of multiple active security
>> modules which applies. Provide a boot option ima_rules_lsm= to
>> allow the user to specify an active security module to apply
>> filters to. If not specified, use the first registered module
>> that supports the audit_rule_match() LSM hook. Allow the user
>> to specify in the IMA policy an lsm= option to specify the
>> security module to use for a particular rule.
> I was hoping somehow that we can rely on the concept of default LSM
> from the LSM infrastructure, so that the extra option would not be
> needed.

What is the "default LSM"? The first "major LSM"? If you never, ever,
under any circumstances want to allow the rules to match an LSM other
than that, sure, we can eliminate the option. I'll bet a refreshing
beverage that BPF is going to want the option on a system that also
has SELinux. Nonetheless, if IMA doesn't want the option I'm willing
to leave it out.

>
> Roberto
>
>> This requires adding the LSM of interest as a parameter
>> to three of the audit hooks.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> To: Mimi Zohar <zohar@linux.ibm.com>
>> To: linux-integrity@vger.kernel.org
>> To: audit@vger.kernel.org
>> ---
>>  Documentation/ABI/testing/ima_policy |  8 +++-
>>  include/linux/lsm_hook_defs.h        |  7 +--
>>  include/linux/security.h             | 26 +++++++---
>>  security/apparmor/audit.c            | 15 ++++--
>>  security/apparmor/include/audit.h    |  7 +--
>>  security/integrity/ima/ima_policy.c  | 71 ++++++++++++++++++++++++----
>>  security/security.c                  | 64 +++++++++++++++++++++----
>>  security/selinux/include/audit.h     | 10 ++--
>>  security/selinux/ss/services.c       | 15 ++++--
>>  security/smack/smack_lsm.c           | 12 ++++-
>>  10 files changed, 192 insertions(+), 43 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
>> index c2385183826c..a59291b97c24 100644
>> --- a/Documentation/ABI/testing/ima_policy
>> +++ b/Documentation/ABI/testing/ima_policy
>> @@ -26,7 +26,7 @@ Description:
>>  				[uid=] [euid=] [gid=] [egid=]
>>  				[fowner=] [fgroup=]]
>>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>> -				 [obj_user=] [obj_role=] [obj_type=]]
>> +				 [obj_user=] [obj_role=] [obj_type=] [lsm=]]
>>  			option:	[digest_type=] [template=] [permit_directio]
>>  				[appraise_type=] [appraise_flag=]
>>  				[appraise_algos=] [keyrings=]
>> @@ -138,6 +138,12 @@ Description:
>>  
>>  			measure subj_user=_ func=FILE_CHECK mask=MAY_READ
>>  
>> +		It is possible to explicitly specify which security
>> +		module a rule applies to using lsm=.  If the security
>> +		module specified is not active on the system the rule
>> +		will be rejected.  If lsm= is not specified the first
>> +		security module registered on the system will be assumed.
>> +
>>  		Example of measure rules using alternate PCRs::
>>  
>>  			measure func=KEXEC_KERNEL_CHECK pcr=4
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index c925a0d26edf..2159013890aa 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -392,10 +392,11 @@ LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
>>  
>>  #ifdef CONFIG_AUDIT
>>  LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
>> -	 void **lsmrule)
>> +	 void **lsmrule, int lsmid)
>>  LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
>> -LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
>> -LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
>> +LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule,
>> +	 int lsmid)
>> +LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule, int lsmid)
>>  #endif /* CONFIG_AUDIT */
>>  
>>  #ifdef CONFIG_BPF_SYSCALL
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index d4103b6cd3fc..2320ed78c4de 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -286,6 +286,8 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
>>  extern int security_init(void);
>>  extern int early_security_init(void);
>>  extern u64 lsm_name_to_attr(const char *name);
>> +extern u64 lsm_name_to_id(const char *name);
>> +extern const char *lsm_id_to_name(u64 id);
>>  
>>  /* Security operations */
>>  int security_binder_set_context_mgr(const struct cred *mgr);
>> @@ -536,6 +538,16 @@ static inline u64 lsm_name_to_attr(const char *name)
>>  	return LSM_ATTR_UNDEF;
>>  }
>>  
>> +static inline u64 lsm_name_to_id(const char *name)
>> +{
>> +	return LSM_ID_UNDEF;
>> +}
>> +
>> +static inline const char *lsm_id_to_name(u64 id)
>> +{
>> +	return NULL;
>> +}
>> +
>>  static inline void security_free_mnt_opts(void **mnt_opts)
>>  {
>>  }
>> @@ -2030,25 +2042,27 @@ static inline void security_audit_rule_free(void *lsmrule)
>>  #endif /* CONFIG_AUDIT */
>>  
>>  #if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
>> -int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
>> -int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
>> -void ima_filter_rule_free(void *lsmrule);
>> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
>> +			 int lsmid);
>> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
>> +			  int lsmid);
>> +void ima_filter_rule_free(void *lsmrule, int lsmid);
>>  
>>  #else
>>  
>>  static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
>> -					   void **lsmrule)
>> +				       void **lsmrule, int lsmid)
>>  {
>>  	return 0;
>>  }
>>  
>>  static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
>> -					    void *lsmrule)
>> +					void *lsmrule, int lsmid)
>>  {
>>  	return 0;
>>  }
>>  
>> -static inline void ima_filter_rule_free(void *lsmrule)
>> +static inline void ima_filter_rule_free(void *lsmrule, int lsmid)
>>  { }
>>  
>>  #endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
>> diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
>> index 45beb1c5f747..0a9f0019355a 100644
>> --- a/security/apparmor/audit.c
>> +++ b/security/apparmor/audit.c
>> @@ -206,10 +206,12 @@ struct aa_audit_rule {
>>  	struct aa_label *label;
>>  };
>>  
>> -void aa_audit_rule_free(void *vrule)
>> +void aa_audit_rule_free(void *vrule, int lsmid)
>>  {
>>  	struct aa_audit_rule *rule = vrule;
>>  
>> +	if (lsmid != LSM_ID_UNDEF || lsmid != LSM_ID_APPARMOR)
>> +		return;
>>  	if (rule) {
>>  		if (!IS_ERR(rule->label))
>>  			aa_put_label(rule->label);
>> @@ -217,10 +219,13 @@ void aa_audit_rule_free(void *vrule)
>>  	}
>>  }
>>  
>> -int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>> +int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
>> +		       int lsmid)
>>  {
>>  	struct aa_audit_rule *rule;
>>  
>> +	if (lsmid != LSM_ID_UNDEF || lsmid != LSM_ID_APPARMOR)
>> +		return 0;
>>  	switch (field) {
>>  	case AUDIT_SUBJ_ROLE:
>>  		if (op != Audit_equal && op != Audit_not_equal)
>> @@ -240,7 +245,7 @@ int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>>  				     GFP_KERNEL, true, false);
>>  	if (IS_ERR(rule->label)) {
>>  		int err = PTR_ERR(rule->label);
>> -		aa_audit_rule_free(rule);
>> +		aa_audit_rule_free(rule, LSM_ID_APPARMOR);
>>  		return err;
>>  	}
>>  
>> @@ -264,12 +269,14 @@ int aa_audit_rule_known(struct audit_krule *rule)
>>  	return 0;
>>  }
>>  
>> -int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
>> +int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule, int lsmid)
>>  {
>>  	struct aa_audit_rule *rule = vrule;
>>  	struct aa_label *label;
>>  	int found = 0;
>>  
>> +	if (lsmid != LSM_ID_UNDEF || lsmid != LSM_ID_APPARMOR)
>> +		return 0;
>>  	label = aa_secid_to_label(sid);
>>  
>>  	if (!label)
>> diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
>> index acbb03b9bd25..a75c45dd059f 100644
>> --- a/security/apparmor/include/audit.h
>> +++ b/security/apparmor/include/audit.h
>> @@ -199,9 +199,10 @@ static inline int complain_error(int error)
>>  	return error;
>>  }
>>  
>> -void aa_audit_rule_free(void *vrule);
>> -int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule);
>> +void aa_audit_rule_free(void *vrule, int lsmid);
>> +int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
>> +		       int lsmid);
>>  int aa_audit_rule_known(struct audit_krule *rule);
>> -int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule);
>> +int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule, int lsmid);
>>  
>>  #endif /* __AA_AUDIT_H */
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index f69062617754..a563e0478cc6 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -117,6 +117,8 @@ struct ima_rule_entry {
>>  		void *rule;	/* LSM file metadata specific */
>>  		char *args_p;	/* audit value */
>>  		int type;	/* audit type */
>> +		int lsm_id;	/* which LSM rule applies to */
>> +		bool lsm_specific;	/* true if lsm is specified */
>>  	} lsm[MAX_LSM_RULES];
>>  	char *fsname;
>>  	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
>> @@ -309,6 +311,25 @@ static int __init default_appraise_policy_setup(char *str)
>>  }
>>  __setup("ima_appraise_tcb", default_appraise_policy_setup);
>>  
>> +static int default_rules_lsm __ro_after_init = LSM_ID_UNDEF;
>> +
>> +static int __init ima_rules_lsm_init(char *str)
>> +{
>> +	int newdrl;
>> +
>> +	newdrl = lsm_name_to_id(str);
>> +	if (newdrl >= 0) {
>> +		default_rules_lsm = newdrl;
>> +		return 1;
>> +	}
>> +
>> +	pr_err("default ima rule lsm \"%s\" not registered, value unchanged.",
>> +		str);
>> +
>> +	return 1;
>> +}
>> +__setup("ima_rules_lsm=", ima_rules_lsm_init);
>> +
>>  static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
>>  {
>>  	struct ima_rule_opt_list *opt_list;
>> @@ -380,7 +401,8 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
>>  	int i;
>>  
>>  	for (i = 0; i < MAX_LSM_RULES; i++) {
>> -		ima_filter_rule_free(entry->lsm[i].rule);
>> +		ima_filter_rule_free(entry->lsm[i].rule,
>> +				     entry->lsm[i].lsm_id);
>>  		kfree(entry->lsm[i].args_p);
>>  	}
>>  }
>> @@ -425,7 +447,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>>  
>>  		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
>>  				     nentry->lsm[i].args_p,
>> -				     &nentry->lsm[i].rule);
>> +				     &nentry->lsm[i].rule,
>> +				     entry->lsm[i].lsm_id);
>>  		if (!nentry->lsm[i].rule)
>>  			pr_warn("rule for LSM \'%s\' is undefined\n",
>>  				nentry->lsm[i].args_p);
>> @@ -451,7 +474,8 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
>>  	 * be owned by nentry.
>>  	 */
>>  	for (i = 0; i < MAX_LSM_RULES; i++)
>> -		ima_filter_rule_free(entry->lsm[i].rule);
>> +		ima_filter_rule_free(entry->lsm[i].rule,
>> +				     entry->lsm[i].lsm_id);
>>  	kfree(entry);
>>  
>>  	return 0;
>> @@ -650,14 +674,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>>  			security_inode_getsecid(inode, &osid);
>>  			rc = ima_filter_rule_match(osid, lsm_rule->lsm[i].type,
>>  						   Audit_equal,
>> -						   lsm_rule->lsm[i].rule);
>> +						   lsm_rule->lsm[i].rule,
>> +						   lsm_rule->lsm[i].lsm_id);
>>  			break;
>>  		case LSM_SUBJ_USER:
>>  		case LSM_SUBJ_ROLE:
>>  		case LSM_SUBJ_TYPE:
>>  			rc = ima_filter_rule_match(secid, lsm_rule->lsm[i].type,
>>  						   Audit_equal,
>> -						   lsm_rule->lsm[i].rule);
>> +						   lsm_rule->lsm[i].rule,
>> +						   lsm_rule->lsm[i].lsm_id);
>>  			break;
>>  		default:
>>  			break;
>> @@ -680,7 +706,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>>  out:
>>  	if (rule_reinitialized) {
>>  		for (i = 0; i < MAX_LSM_RULES; i++)
>> -			ima_filter_rule_free(lsm_rule->lsm[i].rule);
>> +			ima_filter_rule_free(lsm_rule->lsm[i].rule,
>> +					     lsm_rule->lsm[i].lsm_id);
>>  		kfree(lsm_rule);
>>  	}
>>  	return result;
>> @@ -1073,7 +1100,7 @@ enum policy_opt {
>>  	Opt_digest_type,
>>  	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
>>  	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
>> -	Opt_label, Opt_err
>> +	Opt_lsm, Opt_label, Opt_err
>>  };
>>  
>>  static const match_table_t policy_tokens = {
>> @@ -1121,6 +1148,7 @@ static const match_table_t policy_tokens = {
>>  	{Opt_pcr, "pcr=%s"},
>>  	{Opt_template, "template=%s"},
>>  	{Opt_keyrings, "keyrings=%s"},
>> +	{Opt_lsm, "lsm=%s"},
>>  	{Opt_label, "label=%s"},
>>  	{Opt_err, NULL}
>>  };
>> @@ -1140,7 +1168,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>>  	entry->lsm[lsm_rule].type = audit_type;
>>  	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
>>  				      entry->lsm[lsm_rule].args_p,
>> -				      &entry->lsm[lsm_rule].rule);
>> +				      &entry->lsm[lsm_rule].rule,
>> +				      entry->lsm[lsm_rule].lsm_id);
>>  	if (!entry->lsm[lsm_rule].rule) {
>>  		pr_warn("rule for LSM \'%s\' is undefined\n",
>>  			entry->lsm[lsm_rule].args_p);
>> @@ -1878,6 +1907,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>>  						 &(template_desc->num_fields));
>>  			entry->template = template_desc;
>>  			break;
>> +		case Opt_lsm: {
>> +			int i;
>> +
>> +			result = lsm_name_to_id(args[0].from);
>> +			if (result < 0) {
>> +				for (i = 0; i < MAX_LSM_RULES; i++)
>> +					entry->lsm[i].args_p = NULL;
>> +				result = -EINVAL;
>> +				break;
>> +			}
>> +			for (i = 0; i < MAX_LSM_RULES; i++) {
>> +				entry->lsm[i].lsm_id = result;
>> +				entry->lsm[i].lsm_specific = true;
>> +			}
>> +			result = 0;
>> +			break;
>> +			}
>>  		case Opt_err:
>>  			ima_log_string(ab, "UNKNOWN", p);
>>  			result = -EINVAL;
>> @@ -1923,6 +1969,7 @@ ssize_t ima_parse_add_rule(char *rule)
>>  	struct ima_rule_entry *entry;
>>  	ssize_t result, len;
>>  	int audit_info = 0;
>> +	int i;
>>  
>>  	p = strsep(&rule, "\n");
>>  	len = strlen(p) + 1;
>> @@ -1940,6 +1987,11 @@ ssize_t ima_parse_add_rule(char *rule)
>>  
>>  	INIT_LIST_HEAD(&entry->list);
>>  
>> +	for (i = 0; i < MAX_LSM_RULES; i++) {
>> +		entry->lsm[i].lsm_id = default_rules_lsm;
>> +		entry->lsm[i].lsm_specific = false;
>> +	}
>> +
>>  	result = ima_parse_rule(p, entry);
>>  	if (result) {
>>  		ima_free_rule(entry);
>> @@ -2251,6 +2303,9 @@ int ima_policy_show(struct seq_file *m, void *v)
>>  					   entry->lsm[i].args_p);
>>  				break;
>>  			}
>> +			if (entry->lsm[i].lsm_specific)
>> +				seq_printf(m, pt(Opt_lsm),
>> +				    lsm_id_to_name(entry->lsm[i].lsm_id));
>>  			seq_puts(m, " ");
>>  		}
>>  	}
>> diff --git a/security/security.c b/security/security.c
>> index 0a51e3d23570..cdf9ee12b064 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -271,6 +271,46 @@ static void __init initialize_lsm(struct lsm_info *lsm)
>>  u32 lsm_active_cnt __ro_after_init;
>>  const struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT];
>>  
>> +/**
>> + * lsm_name_to_id - get the LSM ID for a registered LSM
>> + * @name: the name of the LSM
>> + *
>> + * Returns the LSM ID associated with the named LSM or
>> + * LSM_ID_UNDEF if the name isn't recongnized.
>> + */
>> +u64 lsm_name_to_id(const char *name)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < LSM_CONFIG_COUNT; i++) {
>> +		if (!lsm_idlist[i]->name)
>> +			return LSM_ID_UNDEF;
>> +		if (!strcmp(name, lsm_idlist[i]->name))
>> +			return lsm_idlist[i]->id;
>> +	}
>> +	return LSM_ID_UNDEF;
>> +}
>> +
>> +/**
>> + * lsm_id_to_name - get the LSM name for a registered LSM ID
>> + * @id: the ID of the LSM
>> + *
>> + * Returns the LSM name associated with the LSM ID or
>> + * NULL if the ID isn't recongnized.
>> + */
>> +const char *lsm_id_to_name(u64 id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < LSM_CONFIG_COUNT; i++) {
>> +		if (!lsm_idlist[i]->name)
>> +			return NULL;
>> +		if (id == lsm_idlist[i]->id)
>> +			return lsm_idlist[i]->name;
>> +	}
>> +	return NULL;
>> +}
>> +
>>  /* Populate ordered LSMs list from comma-separated LSM name list. */
>>  static void __init ordered_lsm_parse(const char *order, const char *origin)
>>  {
>> @@ -5336,7 +5376,8 @@ int security_key_getsecurity(struct key *key, char **buffer)
>>   */
>>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
>>  {
>> -	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
>> +	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule,
>> +			     LSM_ID_UNDEF);
>>  }
>>  
>>  /**
>> @@ -5362,7 +5403,7 @@ int security_audit_rule_known(struct audit_krule *krule)
>>   */
>>  void security_audit_rule_free(void *lsmrule)
>>  {
>> -	call_void_hook(audit_rule_free, lsmrule);
>> +	call_void_hook(audit_rule_free, lsmrule, LSM_ID_UNDEF);
>>  }
>>  
>>  /**
>> @@ -5380,7 +5421,8 @@ void security_audit_rule_free(void *lsmrule)
>>   */
>>  int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
>>  {
>> -	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
>> +	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule,
>> +			     LSM_ID_UNDEF);
>>  }
>>  #endif /* CONFIG_AUDIT */
>>  
>> @@ -5389,19 +5431,23 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
>>   * The integrity subsystem uses the same hooks as
>>   * the audit subsystem.
>>   */
>> -int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
>> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
>> +			 int lsmid)
>>  {
>> -	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
>> +	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule,
>> +			     lsmid);
>>  }
>>  
>> -void ima_filter_rule_free(void *lsmrule)
>> +void ima_filter_rule_free(void *lsmrule, int lsmid)
>>  {
>> -	call_void_hook(audit_rule_free, lsmrule);
>> +	call_void_hook(audit_rule_free, lsmrule, lsmid);
>>  }
>>  
>> -int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
>> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
>> +			  int lsmid)
>>  {
>> -	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
>> +	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule,
>> +			     lsmid);
>>  }
>>  #endif /* CONFIG_IMA_LSM_RULES */
>>  
>> diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
>> index d5495134a5b9..59468baf0c91 100644
>> --- a/security/selinux/include/audit.h
>> +++ b/security/selinux/include/audit.h
>> @@ -21,21 +21,24 @@
>>   *	@op: the operator the rule uses
>>   *	@rulestr: the text "target" of the rule
>>   *	@rule: pointer to the new rule structure returned via this
>> + *	@lsmid: the relevant LSM
>>   *
>>   *	Returns 0 if successful, -errno if not.  On success, the rule structure
>>   *	will be allocated internally.  The caller must free this structure with
>>   *	selinux_audit_rule_free() after use.
>>   */
>> -int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **rule);
>> +int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **rule,
>> +			    int lsmid);
>>  
>>  /**
>>   *	selinux_audit_rule_free - free an selinux audit rule structure.
>>   *	@rule: pointer to the audit rule to be freed
>> + *	@lsmid: which LSM this rule relates to
>>   *
>>   *	This will free all memory associated with the given rule.
>>   *	If @rule is NULL, no operation is performed.
>>   */
>> -void selinux_audit_rule_free(void *rule);
>> +void selinux_audit_rule_free(void *rule, int lsmid);
>>  
>>  /**
>>   *	selinux_audit_rule_match - determine if a context ID matches a rule.
>> @@ -43,11 +46,12 @@ void selinux_audit_rule_free(void *rule);
>>   *	@field: the field this rule refers to
>>   *	@op: the operator the rule uses
>>   *	@rule: pointer to the audit rule to check against
>> + *	@lsmid: the relevant LSM
>>   *
>>   *	Returns 1 if the context id matches the rule, 0 if it does not, and
>>   *	-errno on failure.
>>   */
>> -int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule);
>> +int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule, int lsmid);
>>  
>>  /**
>>   *	selinux_audit_rule_known - check to see if rule contains selinux fields.
>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>> index 1eeffc66ea7d..a9fe8d85acae 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -3487,17 +3487,20 @@ struct selinux_audit_rule {
>>  	struct context au_ctxt;
>>  };
>>  
>> -void selinux_audit_rule_free(void *vrule)
>> +void selinux_audit_rule_free(void *vrule, int lsmid)
>>  {
>>  	struct selinux_audit_rule *rule = vrule;
>>  
>> +	if (lsmid != LSM_ID_UNDEF || lsmid != LSM_ID_SELINUX)
>> +		return;
>>  	if (rule) {
>>  		context_destroy(&rule->au_ctxt);
>>  		kfree(rule);
>>  	}
>>  }
>>  
>> -int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>> +int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
>> +			    int lsmid)
>>  {
>>  	struct selinux_state *state = &selinux_state;
>>  	struct selinux_policy *policy;
>> @@ -3511,6 +3514,8 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>>  
>>  	*rule = NULL;
>>  
>> +	if (lsmid != LSM_ID_UNDEF || lsmid != LSM_ID_SELINUX)
>> +		return 0;
>>  	if (!selinux_initialized())
>>  		return -EOPNOTSUPP;
>>  
>> @@ -3592,7 +3597,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>>  
>>  err:
>>  	rcu_read_unlock();
>> -	selinux_audit_rule_free(tmprule);
>> +	selinux_audit_rule_free(tmprule, LSM_ID_SELINUX);
>>  	*rule = NULL;
>>  	return rc;
>>  }
>> @@ -3622,7 +3627,7 @@ int selinux_audit_rule_known(struct audit_krule *rule)
>>  	return 0;
>>  }
>>  
>> -int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
>> +int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule, int lsmid)
>>  {
>>  	struct selinux_state *state = &selinux_state;
>>  	struct selinux_policy *policy;
>> @@ -3631,6 +3636,8 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
>>  	struct selinux_audit_rule *rule = vrule;
>>  	int match = 0;
>>  
>> +	if (lsmid != LSM_ID_UNDEF || lsmid != LSM_ID_SELINUX)
>> +		return 0;
>>  	if (unlikely(!rule)) {
>>  		WARN_ONCE(1, "selinux_audit_rule_match: missing rule\n");
>>  		return -ENOENT;
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index cd44f7f3f393..4342947f51d8 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -4672,16 +4672,20 @@ static int smack_post_notification(const struct cred *w_cred,
>>   * @op: required testing operator (=, !=, >, <, ...)
>>   * @rulestr: smack label to be audited
>>   * @vrule: pointer to save our own audit rule representation
>> + * @lsmid: the relevant LSM
>>   *
>>   * Prepare to audit cases where (@field @op @rulestr) is true.
>>   * The label to be audited is created if necessay.
>>   */
>> -static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>> +static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
>> +				 int lsmid)
>>  {
>>  	struct smack_known *skp;
>>  	char **rule = (char **)vrule;
>>  	*rule = NULL;
>>  
>> +	if (lsmid != LSM_ID_UNDEF || lsmid != LSM_ID_SMACK)
>> +		return 0;
>>  	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
>>  		return -EINVAL;
>>  
>> @@ -4726,15 +4730,19 @@ static int smack_audit_rule_known(struct audit_krule *krule)
>>   * @field: audit rule flags given from user-space
>>   * @op: required testing operator
>>   * @vrule: smack internal rule presentation
>> + * @lsmid: the relevant LSM
>>   *
>>   * The core Audit hook. It's used to take the decision of
>>   * whether to audit or not to audit a given object.
>>   */
>> -static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
>> +static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule,
>> +				  int lsmid)
>>  {
>>  	struct smack_known *skp;
>>  	char *rule = vrule;
>>  
>> +	if (lsmid != LSM_ID_UNDEF || lsmid != LSM_ID_SMACK)
>> +		return 0;
>>  	if (unlikely(!rule)) {
>>  		WARN_ONCE(1, "Smack: missing rule\n");
>>  		return -ENOENT;

