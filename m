Return-Path: <linux-security-module+bounces-8746-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 903B6A5E8C1
	for <lists+linux-security-module@lfdr.de>; Thu, 13 Mar 2025 00:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E1F189E699
	for <lists+linux-security-module@lfdr.de>; Wed, 12 Mar 2025 23:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC741F3D3E;
	Wed, 12 Mar 2025 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dV/3y4wU"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E041F30DE
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823500; cv=none; b=hPVJRF2mmmlO0iDJDTPgWvZw1jN8mZe+lZIyoCph9hu2LwXEO19cdPbOga5qQ3W5JSvEvC1nrYT1UVcoOsJHg1XvrjQeMQRJX4iLKRjf1mAdnqJPconRD8JeK/GRVRwyhmOsYi/cb0A1pboOdgoaW+NxcWQtPgFw4oDB22cCJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823500; c=relaxed/simple;
	bh=bVgmWPl/5d4vGYxNaZJ2SySJT3kMWw4eW8u4MpoNI+A=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=MVCR9Wg3mUTOvY5K8BVysHCzse2Q3DdRTrCzxlTMVYVgM/ZvfwXs1DEOHd2qczPXatztrVGsgRzdQxFJxhEXdMOR8Bx5P3syS5HQQFHwTDNS23WCOlyq6aV/Y01dBCUW0etWErknh0J7BQDa4EkJhf1EXLbjtlKfeQ52CyJNmXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dV/3y4wU; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dd0d09215aso4366996d6.2
        for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 16:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823497; x=1742428297; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TW0CtuRgje1XagXcTzX1RCPYFUlIY/ELVjgIjkIRo24=;
        b=dV/3y4wUYrdCh7HK5DP3TVUwDPp/wTo+kAJrBgw4wlfFHWhxw3npygDcGh12Mto9Vo
         U4+oYFatMKxbjOB0hiEU920LXgzdrCUNBsC6X+mdDeJLxTEhJaUURKFcYOZOP1pBF6KR
         HLRJTJ+aJqKQpp0kWubC10sEOTDlYL9vnl0TWxqhIClhbX3/tMVBlW9yTdtn/YMfN2l8
         Mf0nOLxLaTxIMTOJPbxeOX5gIoHKhOQ84wRJOMG9MQFuUJ4EeLDdP7hORIrUcKZx7rvX
         iHF/oHqp3TZUelM5EKrM+KRPdChkwTTC/LByHDCBOO6/BhozCYJ5wu23vzgNyBV9IlDO
         7eZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823497; x=1742428297;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TW0CtuRgje1XagXcTzX1RCPYFUlIY/ELVjgIjkIRo24=;
        b=YaIaPTtunGOmrwjyaZHHxXEt3/GLSaPw/wCiXHpLJOPyjWuXCBd2Z8gc90DzxXs8Qd
         x03tCfMU49+2ef8H/MmKfJORZnuy5QnqQmwYCEq6deoFbrlp+snrze5o9lQIMZynWu6/
         zouMvEWTAwaXSEDMlCjsEoqbxurCHwzaPnv1raiDo0qEGN/Lsrtf1fH/EZMAzyRNVKVn
         WRl+B59hbz0vAa53D22AQAB8rvqKJuBMrjJ5VcwLtJFgW4SBmemerM5ezIlM2PbxlC+X
         4WATsZQryWcg69XAzsp0lH8q+YcL6MMjAAEhT8BEYbx2nzlCpzXoWoKlSJ64R+ykgbaB
         a6YA==
X-Forwarded-Encrypted: i=1; AJvYcCVqaRhlZfxSTa4TqZAafXuxBpx5lTBVnkjRsH92wKngNInVx5WiOxVPsZiB2TaGJ+wjOrt6A94aBoukcm/kBFeDuW6AHXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywPJ6IcHvNyZVseg/qLWZILEVW0XBEuMtDOO65fwEuHFujijDK
	r3XxPEYRY4KGFR65igZnIm4HtS3wb2WUfwk8Vitu4HAO1RQqksGvwd8+XhEufA==
X-Gm-Gg: ASbGncu8wqgPwqF6+SXBoEJJcoPm3fxf9cfyVI5lqg3VdA98hx/Z7otSZSrGTRuZeST
	ABzA5luAPXePhviBX3Xtt03H8vl9YhiubCoy1cyF641njBQO8TQCZoZ7Nd0No48Jx7X5gLt4EAu
	wt2ahKY0shyIzJLSMArLF1l4ogLpx5Xp5mWNfxPXiW7rBtOjcS2MbjdcemtCgyadud2ctmniD11
	a40bw62OcMJe7V0gPs4DKcqn7R1zc5tty5xhpQbXImz0gQXnSCI2SyLjR8fYdUAaLncNXfqb6iq
	1UHpkaxv+FXVSdLFg2YosB8jds6lT1T5woxx7KMYJNI7OoLDSKcaJlVoO/9ILySPXKndHX2uj6d
	JcOAuGyJox/Zzgw==
X-Google-Smtp-Source: AGHT+IFFwoLeuGIPcbUYfp16c7Hs2LZsI91C63+Z2jWQ7tqQOgzH5ycXDtVXDqAQwoxtn9vL/OV/Jg==
X-Received: by 2002:a05:6214:c43:b0:6e8:ebfa:42f9 with SMTP id 6a1803df08f44-6ea2dd1e704mr156518386d6.16.1741823497321;
        Wed, 12 Mar 2025 16:51:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade234b92sm1849746d6.43.2025.03.12.16.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:36 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:36 -0400
Message-ID: <5ea749e38c39e783741bdd0491a1338d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250312_1930/pstg-lib:20250312_1930/pstg-pwork:20250312_1930
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 4/6] Audit: Add record for multiple task security  contexts
References: <20250307183701.16970-5-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-5-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS (1423) record is:
> 
>     type=MAC_TASK_CONTEXTS[1423]
>     msg=audit(1600880931.832:113)
>     subj_apparmor=unconfined
>     subj_smack=_
> 
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
> the "subj=" field in other records in the event will be "subj=?".
> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on a subject security context.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  |  1 +
>  include/linux/security.h   |  1 +
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 45 ++++++++++++++++++++++++++++++++------
>  security/apparmor/lsm.c    |  1 +
>  security/bpf/hooks.c       |  1 +
>  security/security.c        |  3 +++
>  security/selinux/hooks.c   |  1 +
>  security/smack/smack_lsm.c |  1 +
>  9 files changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 090d1d3e19fe..e4d303ab1f20 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -81,6 +81,7 @@ struct lsm_static_calls_table {
>  struct lsm_id {
>  	const char *name;
>  	u64 id;
> +	bool subjctx;
>  };

The new field needs to be documented in the comment block for the
struct, and while I'll reserve judgement until I see the description,
I believe this field either needs to be renamed, moved elsewhere, or
simply "disappeared" in favor of something else.

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 540894695c4b..79a9bf4a7cdd 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -168,6 +168,7 @@ struct lsm_prop {
>  
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
>  extern u32 lsm_active_cnt;
> +extern u32 lsm_subjctx_cnt;

I'm not loving this.  More below, but I'd really like to hide some of
this detail inside a LSM API/hook if possible.

>  extern const struct lsm_id *lsm_idlist[];
>  
>  /* These functions are in security/commoncap.c */
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index d9a069b4a775..5ebb5d80363d 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -146,6 +146,7 @@
>  #define AUDIT_IPE_ACCESS	1420	/* IPE denial or grant */
>  #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
>  #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
> +#define AUDIT_MAC_TASK_CONTEXTS	1423	/* Multiple LSM task contexts */
>  
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 293364bba961..59eaf69ee8ac 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -54,6 +54,7 @@
>  #include <net/netlink.h>
>  #include <linux/skbuff.h>
>  #include <linux/security.h>
> +#include <linux/lsm_hooks.h>
>  #include <linux/freezer.h>
>  #include <linux/pid_namespace.h>
>  #include <net/netns/generic.h>
> @@ -2241,21 +2242,51 @@ int audit_log_task_context(struct audit_buffer *ab)
>  {
>  	struct lsm_prop prop;
>  	struct lsm_context ctx;
> +	bool space = false;
>  	int error;
> +	int i;
>  
>  	security_current_getlsmprop_subj(&prop);
>  	if (!lsmprop_is_set(&prop))
>  		return 0;
>  
> -	error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
> -	if (error < 0) {
> -		if (error != -EINVAL)
> -			goto error_path;
> +	if (lsm_subjctx_cnt < 2) {
> +		error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
> +		if (error < 0) {
> +			if (error != -EINVAL)
> +				goto error_path;
> +			return 0;
> +		}
> +		audit_log_format(ab, " subj=%s", ctx.context);
> +		security_release_secctx(&ctx);
>  		return 0;
>  	}
> -
> -	audit_log_format(ab, " subj=%s", ctx.context);
> -	security_release_secctx(&ctx);
> +	/* Multiple LSMs provide contexts. Include an aux record. */
> +	audit_log_format(ab, " subj=?");
> +	error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
> +	if (error)
> +		goto error_path;
> +
> +	for (i = 0; i < lsm_active_cnt; i++) {
> +		if (!lsm_idlist[i]->subjctx)
> +			continue;
> +		error = security_lsmprop_to_secctx(&prop, &ctx,
> +						   lsm_idlist[i]->id);
> +		if (error < 0) {
> +			if (error == -EOPNOTSUPP)
> +				continue;
> +			audit_log_format(ab, "%ssubj_%s=?", space ? " " : "",
> +					 lsm_idlist[i]->name);
> +			if (error != -EINVAL)
> +				audit_panic("error in audit_log_task_context");
> +		} else {
> +			audit_log_format(ab, "%ssubj_%s=%s", space ? " " : "",
> +					 lsm_idlist[i]->name, ctx.context);
> +			security_release_secctx(&ctx);
> +		}
> +		space = true;
> +	}
> +	audit_buffer_aux_end(ab);
>  	return 0;

I'd really like to see us develop something a bit cleaner than the
code above.  It looks like there are two things that we're currently
missing in the LSM API: a count of the number of LSMs supplying data
in a lsm_prop struct, and a mechanism to iterate through a lsm_prop
and act on each LSM's data.

As far as the count is concerned, I think we can take a similar
approach to what we do with MAX_LSM_COUNT to generate a value at
build time, for example (pardon the lazy pseudo code):

 >>> include/linux/lsm_count.h
 
#if IS_ENABLED(CONFIG_SECURITY_SMACK)
#define SMACK_ENABLED 1,
#define SMACK_LSMPROP 1,
#else
#define SMACK_ENABLED
#define SMACK_LSMPROP
#endif

#define MAX_LSM_PROPS \
  COUNT_LSMS(         \
    SMACK_LSMPROP     \
    ...)              \

The iterator mechanism is a little more complex, but I think the
interface and resulting will be a lot cleaner, at least to in my mind.

 >>> LSM hook

int security_lsmprop_walk(void *data,
                          void (*iter)(struct lsm_id *lsm, void *data,
                                      char *secctx, u32 secid));

 >>> example audit code

struct lsmprop_walk_data {
  struct audit_buffer *ab;
  unsigned int count;
};

void audit_lsmprop_walk(struct lsm_id *lsm, void *data,
                        char *secctx, u32 secid)
{
  struct lsmprop_walk_data *walk = data;

  audit_log_format(data->ab, "%ssubj_%s=%s",
                   (data->count++ ? " " : ""),
                   lsm->name, (secctx ? secctx : "?"));
  if (secctx)
    security_release_secctx(secctx);
}

int audit_log_task_context(...)
{
  ...

  if (MAX_LSM_PROPS <= 1) {
    security_lsmprop_to_secctx(...)
    audit_log_format(...);
  } else {
    struct lsmprop_walk_data data = { .ab = ab, count = 0 };

    audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
    security_lsmprop_walk(data, audit_lsmprop_walk);
    audit_buffer_aux_end(
  }
  
  ...
}

--
paul-moore.com

