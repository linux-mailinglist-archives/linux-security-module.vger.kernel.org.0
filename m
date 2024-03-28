Return-Path: <linux-security-module+bounces-2145-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC98E87D4DF
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Mar 2024 21:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8671F21906
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Mar 2024 20:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D067336B15;
	Fri, 15 Mar 2024 20:19:25 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EEF182C3;
	Fri, 15 Mar 2024 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710533965; cv=none; b=In/VPsmqPENLDOYkRPthwJXX83gn/Hq6ALBNIruWfEDGy5TEzzIIEQkAXAhmFZM3YIAZWo9dc2qqlrA1VPEDyFqPy8o1a7yZmS2+aUxe1HIII8OuRH2xMpg5DTtUB7SUU8VE5tADaISUvfjcCYdmw5uJ++vjeAPsJNhpDlfMqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710533965; c=relaxed/simple;
	bh=d0hcUXTqOSZ8R8NjxE6s8I/KYB0WW7tkiEpvuiIH2kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzfqGl9D99QMIEFUpxLAK1IMKmrrQOE+OAFLFw1ROD01Kbx85K+hJ1ypUTHMC++INRyWBa+Ntf8DxSu347pVTiJ7u+fP2Gehs/7NRJdE6DlDEdwtp4qFdz2rYm8kjzfJxA7wdbzIyOMk9YTcAqapael3QR9WtdgqrBBh/63M+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Received: from serge-l-PF3DENS3 (unknown [72.163.2.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: serge)
	by mail.hallyn.com (Postfix) with ESMTPSA id 5F8DB888;
	Fri, 15 Mar 2024 15:19:18 -0500 (CDT)
Date: Fri, 15 Mar 2024 15:19:16 -0500
From: Serge Hallyn <serge@hallyn.com>
To: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 02/10] capability: add any wrappers to test for multiple
 caps with exactly one audit message
Message-ID: <ZfStRK6Z6Rm/KTJj@serge-l-PF3DENS3>
References: <20240315113828.258005-1-cgzones@googlemail.com>
 <20240315113828.258005-2-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315113828.258005-2-cgzones@googlemail.com>

On Fri, Mar 15, 2024 at 12:37:23PM +0100, Christian G�ttsche wrote:
> Add the interfaces `capable_any()` and `ns_capable_any()` as an
> alternative to multiple `capable()`/`ns_capable()` calls, like
> `capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
> `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
> 
> `capable_any()`/`ns_capable_any()` will in particular generate exactly
> one audit message, either for the left most capability in effect or, if
> the task has none, the first one.
> 
> This is especially helpful with regard to SELinux, where each audit
> message about a not allowed capability request will create a denial
> message.  Using this new wrapper with the least invasive capability as
> left most argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables
> policy writers to only grant the least invasive one for the particular
> subject instead of both.
> 
> CC: linux-block@vger.kernel.org
> Signed-off-by: Christian G�ttsche <cgzones@googlemail.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
> v5:
>    - add check for identical passed capabilities
>    - rename internal helper according to flag rename to
>      ns_capable_noauditondeny()
> v4:
>    Use CAP_OPT_NODENYAUDIT via added ns_capable_nodenyaudit()
> v3:
>    - rename to capable_any()
>    - fix typo in function documentation
>    - add ns_capable_any()
> v2:
>    avoid varargs and fix to two capabilities; capable_or3() can be added
>    later if needed
> ---
>  include/linux/capability.h | 10 ++++++
>  kernel/capability.c        | 73 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 0c356a517991..eeb958440656 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -146,7 +146,9 @@ extern bool has_capability_noaudit(struct task_struct *t, int cap);
>  extern bool has_ns_capability_noaudit(struct task_struct *t,
>  				      struct user_namespace *ns, int cap);
>  extern bool capable(int cap);
> +extern bool capable_any(int cap1, int cap2);
>  extern bool ns_capable(struct user_namespace *ns, int cap);
> +extern bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2);
>  extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
>  extern bool ns_capable_setid(struct user_namespace *ns, int cap);
>  #else
> @@ -172,10 +174,18 @@ static inline bool capable(int cap)
>  {
>  	return true;
>  }
> +static inline bool capable_any(int cap1, int cap2)
> +{
> +	return true;
> +}
>  static inline bool ns_capable(struct user_namespace *ns, int cap)
>  {
>  	return true;
>  }
> +static inline bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
> +{
> +	return true;
> +}
>  static inline bool ns_capable_noaudit(struct user_namespace *ns, int cap)
>  {
>  	return true;
> diff --git a/kernel/capability.c b/kernel/capability.c
> index dac4df77e376..73358abfe2e1 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -402,6 +402,23 @@ bool ns_capable_noaudit(struct user_namespace *ns, int cap)
>  }
>  EXPORT_SYMBOL(ns_capable_noaudit);
>  
> +/**
> + * ns_capable_noauditondeny - Determine if the current task has a superior capability
> + * (unaudited when unauthorized) in effect
> + * @ns:  The usernamespace we want the capability in
> + * @cap: The capability to be tested for
> + *
> + * Return true if the current task has the given superior capability currently
> + * available for use, false if not.
> + *
> + * This sets PF_SUPERPRIV on the task if the capability is available on the
> + * assumption that it's about to be used.
> + */
> +static bool ns_capable_noauditondeny(struct user_namespace *ns, int cap)
> +{
> +	return ns_capable_common(ns, cap, CAP_OPT_NOAUDIT_ONDENY);
> +}
> +
>  /**
>   * ns_capable_setid - Determine if the current task has a superior capability
>   * in effect, while signalling that this check is being done from within a
> @@ -421,6 +438,62 @@ bool ns_capable_setid(struct user_namespace *ns, int cap)
>  }
>  EXPORT_SYMBOL(ns_capable_setid);
>  
> +/**
> + * ns_capable_any - Determine if the current task has one of two superior capabilities in effect
> + * @ns:  The usernamespace we want the capability in
> + * @cap1: The capabilities to be tested for first
> + * @cap2: The capabilities to be tested for secondly
> + *
> + * Return true if the current task has at least one of the two given superior
> + * capabilities currently available for use, false if not.
> + *
> + * In contrast to or'ing capable() this call will create exactly one audit
> + * message, either for @cap1, if it is granted or both are not permitted,
> + * or @cap2, if it is granted while the other one is not.
> + *
> + * The capabilities should be ordered from least to most invasive, i.e. CAP_SYS_ADMIN last.
> + *
> + * This sets PF_SUPERPRIV on the task if the capability is available on the
> + * assumption that it's about to be used.
> + */
> +bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
> +{
> +	if (cap1 == cap2)
> +		return ns_capable(ns, cap1);
> +
> +	if (ns_capable_noauditondeny(ns, cap1))
> +		return true;
> +
> +	if (ns_capable_noauditondeny(ns, cap2))
> +		return true;
> +
> +	return ns_capable(ns, cap1);
> +}
> +EXPORT_SYMBOL(ns_capable_any);
> +
> +/**
> + * capable_any - Determine if the current task has one of two superior capabilities in effect
> + * @cap1: The capabilities to be tested for first
> + * @cap2: The capabilities to be tested for secondly
> + *
> + * Return true if the current task has at least one of the two given superior
> + * capabilities currently available for use, false if not.
> + *
> + * In contrast to or'ing capable() this call will create exactly one audit
> + * message, either for @cap1, if it is granted or both are not permitted,
> + * or @cap2, if it is granted while the other one is not.
> + *
> + * The capabilities should be ordered from least to most invasive, i.e. CAP_SYS_ADMIN last.
> + *
> + * This sets PF_SUPERPRIV on the task if the capability is available on the
> + * assumption that it's about to be used.
> + */
> +bool capable_any(int cap1, int cap2)
> +{
> +	return ns_capable_any(&init_user_ns, cap1, cap2);
> +}
> +EXPORT_SYMBOL(capable_any);
> +
>  /**
>   * capable - Determine if the current task has a superior capability in effect
>   * @cap: The capability to be tested for
> -- 
> 2.43.0
> 
> 

