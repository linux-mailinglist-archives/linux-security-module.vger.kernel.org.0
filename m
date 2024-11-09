Return-Path: <linux-security-module+bounces-6507-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5649C2F50
	for <lists+linux-security-module@lfdr.de>; Sat,  9 Nov 2024 20:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA519B2128F
	for <lists+linux-security-module@lfdr.de>; Sat,  9 Nov 2024 19:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C822619D899;
	Sat,  9 Nov 2024 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lzH2pgZY"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05EB1537C9;
	Sat,  9 Nov 2024 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731180819; cv=none; b=oqJOZ7HyMDOBOcB9wAuAns1FQkc+gV+V+hAX/gV4Ty3N3INUNOGrOy1EWltYflganCu70sC8YB+2ker5dAR3s42/X6QzmwKwz0E1o2KDtgCcLGyDeIC8sh90DUbbayA1ExHRP5a5ieSK/oHQnma/+lpNC8GSQCO7LNU6qe9e4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731180819; c=relaxed/simple;
	bh=COrX2a4YJoZpHmjW20T7HHhWPRJ7i6wXy155nD9ponk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+wCXQJf5JbF9A+JnADxJdYOssLLvIMrzqPFYi8iqsBlzss5IPF40bnkCMj7yxNEai+xxtG8YzRlpo1zI8L2dJFUL2ii8cMSdce1jtqXY6o5b1spGfBmxCM0Y/GJbVD1irN2Jpu5BN6Db6jypdNYG1FsjCs0f41Z3v5mP2jalfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lzH2pgZY; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.84] (unknown [50.39.104.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5D80A3F0C6;
	Sat,  9 Nov 2024 19:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731180807;
	bh=qbR0tDDfzH0feL7HDqsjIvVSntAiDF20wi6FDCV72Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=lzH2pgZY3h4v1wVYflo9MxKVYxRotCdXOI+cHCa6gytL+XoEtzwnvPR/ThvSfSAE6
	 dUZxgvCLWUOT6F8zqYeRKdHhWg3zLDPOgy6NYrW7t41zCvZJf++CYO39Xj6vyETDKx
	 ru79vpMMsbs1Ntr5Ahb6JE0JeWBu66NE1/TAV0i43FtjdlpdNaTCr3vCdQqW+9bOvq
	 k2yxpfOnYk8WyA160G5bYZS/V8vUx8wry9P0FuuSCbDi+KKm3qfY8nGddl70o+utLC
	 fVHceq+T6R0Hf6QK3HJu8SjeSGf51YaNUc31bH5q4AsPYv6kLL7cIYx2p5C+K1EZZx
	 OT+C+vo9mk3fg==
Message-ID: <2c2691c2-17d6-49dc-842e-289d8afced74@canonical.com>
Date: Sat, 9 Nov 2024 11:33:24 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: Remove deadcode
To: "Dr. David Alan Gilbert" <linux@treblig.org>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240920235517.615309-1-linux@treblig.org>
 <ZxUXBBI4XE0oqcee@gallifrey>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <ZxUXBBI4XE0oqcee@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/24 07:43, Dr. David Alan Gilbert wrote:
> * linux@treblig.org (linux@treblig.org) wrote:
>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>
>> aa_label_audit, aa_label_find, aa_label_seq_print and aa_update_label_name
>> were added by commit
>> f1bd904175e8 ("apparmor: add the base fns() for domain labels")
>> but never used.
>>
>> aa_profile_label_perm was added by commit
>> 637f688dc3dc ("apparmor: switch from profiles to using labels on contexts")
>> but never used.
>>
>> aa_secid_update was added by commit
>> c092921219d2 ("apparmor: add support for mapping secids and using secctxes")
>> but never used.
>>
>> aa_split_fqname has been unused since commit
>> 3664268f19ea ("apparmor: add namespace lookup fns()")
>>
>> aa_lookup_profile has been unused since commit
>> 93c98a484c49 ("apparmor: move exec domain mediation to using labels")
>>
>> aa_audit_perms_cb was only used by aa_profile_label_perm (see above).
>>
>> All of these commits are from around 2017.
>>
>> Remove them.
>>
>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> Ping.
> 
> Dave
> 
>> ---
>>   security/apparmor/include/label.h  |  4 --
>>   security/apparmor/include/lib.h    |  1 -
>>   security/apparmor/include/perms.h  |  3 --
>>   security/apparmor/include/policy.h |  1 -
>>   security/apparmor/include/secid.h  |  1 -
>>   security/apparmor/label.c          | 33 ------------
>>   security/apparmor/lib.c            | 84 ------------------------------
>>   security/apparmor/policy.c         |  5 --
>>   security/apparmor/secid.c          | 14 -----
>>   9 files changed, 146 deletions(-)
>>
>> diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
>> index 2a72e6b17d68..83a840d935bc 100644
>> --- a/security/apparmor/include/label.h
>> +++ b/security/apparmor/include/label.h
>> @@ -291,8 +291,6 @@ bool aa_label_replace(struct aa_label *old, struct aa_label *new);
>>   bool aa_label_make_newest(struct aa_labelset *ls, struct aa_label *old,
>>   			  struct aa_label *new);
>>   
>> -struct aa_label *aa_label_find(struct aa_label *l);
>> -
>>   struct aa_profile *aa_label_next_in_merge(struct label_it *I,
>>   					  struct aa_label *a,
>>   					  struct aa_label *b);
>> @@ -320,8 +318,6 @@ void aa_label_seq_xprint(struct seq_file *f, struct aa_ns *ns,
>>   			 struct aa_label *label, int flags, gfp_t gfp);
>>   void aa_label_xprintk(struct aa_ns *ns, struct aa_label *label, int flags,
>>   		      gfp_t gfp);
>> -void aa_label_audit(struct audit_buffer *ab, struct aa_label *label, gfp_t gfp);
>> -void aa_label_seq_print(struct seq_file *f, struct aa_label *label, gfp_t gfp);
>>   void aa_label_printk(struct aa_label *label, gfp_t gfp);
>>   
>>   struct aa_label *aa_label_strn_parse(struct aa_label *base, const char *str,
>> diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
>> index d7a894b1031f..f11a0db7f51d 100644
>> --- a/security/apparmor/include/lib.h
>> +++ b/security/apparmor/include/lib.h
>> @@ -59,7 +59,6 @@ extern int apparmor_initialized;
>>   
>>   /* fn's in lib */
>>   const char *skipn_spaces(const char *str, size_t n);
>> -char *aa_split_fqname(char *args, char **ns_name);
>>   const char *aa_splitn_fqname(const char *fqname, size_t n, const char **ns_name,
>>   			     size_t *ns_len);
>>   void aa_info_message(const char *str);
>> diff --git a/security/apparmor/include/perms.h b/security/apparmor/include/perms.h
>> index 0f7e913c3fc2..bbaa7d39a39a 100644
>> --- a/security/apparmor/include/perms.h
>> +++ b/security/apparmor/include/perms.h
>> @@ -213,9 +213,6 @@ void aa_perms_accum_raw(struct aa_perms *accum, struct aa_perms *addend);
>>   void aa_profile_match_label(struct aa_profile *profile,
>>   			    struct aa_ruleset *rules, struct aa_label *label,
>>   			    int type, u32 request, struct aa_perms *perms);
>> -int aa_profile_label_perm(struct aa_profile *profile, struct aa_profile *target,
>> -			  u32 request, int type, u32 *deny,
>> -			  struct apparmor_audit_data *ad);
>>   int aa_check_perms(struct aa_profile *profile, struct aa_perms *perms,
>>   		   u32 request, struct apparmor_audit_data *ad,
>>   		   void (*cb)(struct audit_buffer *, void *));
>> diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
>> index 75088cc310b6..757e3c232c57 100644
>> --- a/security/apparmor/include/policy.h
>> +++ b/security/apparmor/include/policy.h
>> @@ -264,7 +264,6 @@ void aa_free_profile(struct aa_profile *profile);
>>   struct aa_profile *aa_find_child(struct aa_profile *parent, const char *name);
>>   struct aa_profile *aa_lookupn_profile(struct aa_ns *ns, const char *hname,
>>   				      size_t n);
>> -struct aa_profile *aa_lookup_profile(struct aa_ns *ns, const char *name);
>>   struct aa_profile *aa_fqlookupn_profile(struct aa_label *base,
>>   					const char *fqname, size_t n);
>>   
>> diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
>> index a912a5d5d04f..b49dd0253118 100644
>> --- a/security/apparmor/include/secid.h
>> +++ b/security/apparmor/include/secid.h
>> @@ -32,6 +32,5 @@ void apparmor_release_secctx(char *secdata, u32 seclen);
>>   
>>   int aa_alloc_secid(struct aa_label *label, gfp_t gfp);
>>   void aa_free_secid(u32 secid);
>> -void aa_secid_update(u32 secid, struct aa_label *label);
>>   
>>   #endif /* __AA_SECID_H */
>> diff --git a/security/apparmor/label.c b/security/apparmor/label.c
>> index c71e4615dd46..91483ecacc16 100644
>> --- a/security/apparmor/label.c
>> +++ b/security/apparmor/label.c
>> @@ -899,23 +899,6 @@ struct aa_label *aa_vec_find_or_create_label(struct aa_profile **vec, int len,
>>   	return vec_create_and_insert_label(vec, len, gfp);
>>   }
>>   
>> -/**
>> - * aa_label_find - find label @label in label set
>> - * @label: label to find (NOT NULL)
>> - *
>> - * Requires: caller to hold a valid ref on l
>> - *
>> - * Returns: refcounted @label if @label is in tree
>> - *          refcounted label that is equiv to @label in tree
>> - *     else NULL if @label or equiv is not in tree
>> - */
>> -struct aa_label *aa_label_find(struct aa_label *label)
>> -{
>> -	AA_BUG(!label);
>> -
>> -	return vec_find(label->vec, label->size);
>> -}
>> -
>>   
>>   /**
>>    * aa_label_insert - insert label @label into @ls or return existing label
>> @@ -1811,22 +1794,6 @@ void aa_label_xprintk(struct aa_ns *ns, struct aa_label *label, int flags,
>>   		pr_info("%s", label->hname);
>>   }
>>   
>> -void aa_label_audit(struct audit_buffer *ab, struct aa_label *label, gfp_t gfp)
>> -{
>> -	struct aa_ns *ns = aa_get_current_ns();
>> -
>> -	aa_label_xaudit(ab, ns, label, FLAG_VIEW_SUBNS, gfp);
>> -	aa_put_ns(ns);
>> -}
>> -
>> -void aa_label_seq_print(struct seq_file *f, struct aa_label *label, gfp_t gfp)
>> -{
>> -	struct aa_ns *ns = aa_get_current_ns();
>> -
>> -	aa_label_seq_xprint(f, ns, label, FLAG_VIEW_SUBNS, gfp);
>> -	aa_put_ns(ns);
>> -}
>> -
>>   void aa_label_printk(struct aa_label *label, gfp_t gfp)
>>   {
>>   	struct aa_ns *ns = aa_get_current_ns();
>> diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
>> index cd569fbbfe36..7db62213e352 100644
>> --- a/security/apparmor/lib.c
>> +++ b/security/apparmor/lib.c
>> @@ -45,44 +45,6 @@ void aa_free_str_table(struct aa_str_table *t)
>>   	}
>>   }
>>   
>> -/**
>> - * aa_split_fqname - split a fqname into a profile and namespace name
>> - * @fqname: a full qualified name in namespace profile format (NOT NULL)
>> - * @ns_name: pointer to portion of the string containing the ns name (NOT NULL)
>> - *
>> - * Returns: profile name or NULL if one is not specified
>> - *
>> - * Split a namespace name from a profile name (see policy.c for naming
>> - * description).  If a portion of the name is missing it returns NULL for
>> - * that portion.
>> - *
>> - * NOTE: may modify the @fqname string.  The pointers returned point
>> - *       into the @fqname string.
>> - */
>> -char *aa_split_fqname(char *fqname, char **ns_name)
>> -{
>> -	char *name = strim(fqname);
>> -
>> -	*ns_name = NULL;
>> -	if (name[0] == ':') {
>> -		char *split = strchr(&name[1], ':');
>> -		*ns_name = skip_spaces(&name[1]);
>> -		if (split) {
>> -			/* overwrite ':' with \0 */
>> -			*split++ = 0;
>> -			if (strncmp(split, "//", 2) == 0)
>> -				split += 2;
>> -			name = skip_spaces(split);
>> -		} else
>> -			/* a ns name without a following profile is allowed */
>> -			name = NULL;
>> -	}
>> -	if (name && *name == 0)
>> -		name = NULL;
>> -
>> -	return name;
>> -}
>> -
>>   /**
>>    * skipn_spaces - Removes leading whitespace from @str.
>>    * @str: The string to be stripped.
>> @@ -275,33 +237,6 @@ void aa_audit_perm_mask(struct audit_buffer *ab, u32 mask, const char *chrs,
>>   	audit_log_format(ab, "\"");
>>   }
>>   
>> -/**
>> - * aa_audit_perms_cb - generic callback fn for auditing perms
>> - * @ab: audit buffer (NOT NULL)
>> - * @va: audit struct to audit values of (NOT NULL)
>> - */
>> -static void aa_audit_perms_cb(struct audit_buffer *ab, void *va)
>> -{
>> -	struct common_audit_data *sa = va;
>> -	struct apparmor_audit_data *ad = aad(sa);
>> -
>> -	if (ad->request) {
>> -		audit_log_format(ab, " requested_mask=");
>> -		aa_audit_perm_mask(ab, ad->request, aa_file_perm_chrs,
>> -				   PERMS_CHRS_MASK, aa_file_perm_names,
>> -				   PERMS_NAMES_MASK);
>> -	}
>> -	if (ad->denied) {
>> -		audit_log_format(ab, "denied_mask=");
>> -		aa_audit_perm_mask(ab, ad->denied, aa_file_perm_chrs,
>> -				   PERMS_CHRS_MASK, aa_file_perm_names,
>> -				   PERMS_NAMES_MASK);
>> -	}
>> -	audit_log_format(ab, " peer=");
>> -	aa_label_xaudit(ab, labels_ns(ad->subj_label), ad->peer,
>> -				      FLAGS_NONE, GFP_ATOMIC);
>> -}
>> -
>>   /**
>>    * aa_apply_modes_to_perms - apply namespace and profile flags to perms
>>    * @profile: that perms where computed from
>> @@ -349,25 +284,6 @@ void aa_profile_match_label(struct aa_profile *profile,
>>   }
>>   
>>   
>> -/* currently unused */
>> -int aa_profile_label_perm(struct aa_profile *profile, struct aa_profile *target,
>> -			  u32 request, int type, u32 *deny,
>> -			  struct apparmor_audit_data *ad)
>> -{
>> -	struct aa_ruleset *rules = list_first_entry(&profile->rules,
>> -						    typeof(*rules), list);
>> -	struct aa_perms perms;
>> -
>> -	ad->peer = &target->label;
>> -	ad->request = request;
>> -
>> -	aa_profile_match_label(profile, rules, &target->label, type, request,
>> -			       &perms);
>> -	aa_apply_modes_to_perms(profile, &perms);
>> -	*deny |= request & perms.deny;
>> -	return aa_check_perms(profile, &perms, request, ad, aa_audit_perms_cb);
>> -}
>> -
>>   /**
>>    * aa_check_perms - do audit mode selection based on perms set
>>    * @profile: profile being checked
>> diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
>> index 14df15e35695..74c854e8889f 100644
>> --- a/security/apparmor/policy.c
>> +++ b/security/apparmor/policy.c
>> @@ -580,11 +580,6 @@ struct aa_profile *aa_lookupn_profile(struct aa_ns *ns, const char *hname,
>>   	return profile;
>>   }
>>   
>> -struct aa_profile *aa_lookup_profile(struct aa_ns *ns, const char *hname)
>> -{
>> -	return aa_lookupn_profile(ns, hname, strlen(hname));
>> -}
>> -
>>   struct aa_profile *aa_fqlookupn_profile(struct aa_label *base,
>>   					const char *fqname, size_t n)
>>   {
>> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
>> index 83d3d1e6d9dc..a52c789d4f18 100644
>> --- a/security/apparmor/secid.c
>> +++ b/security/apparmor/secid.c
>> @@ -39,20 +39,6 @@ int apparmor_display_secid_mode;
>>    * TODO: use secid_update in label replace
>>    */
>>   
>> -/**
>> - * aa_secid_update - update a secid mapping to a new label
>> - * @secid: secid to update
>> - * @label: label the secid will now map to
>> - */
>> -void aa_secid_update(u32 secid, struct aa_label *label)
>> -{
>> -	unsigned long flags;
>> -
>> -	xa_lock_irqsave(&aa_secids, flags);
>> -	__xa_store(&aa_secids, secid, label, 0);
>> -	xa_unlock_irqrestore(&aa_secids, flags);
>> -}
>> -
>>   /*
>>    * see label for inverse aa_label_to_secid
>>    */
>> -- 
>> 2.46.1
>>


