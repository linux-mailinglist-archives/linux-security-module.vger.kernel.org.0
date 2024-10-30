Return-Path: <linux-security-module+bounces-6407-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FEB9B5A41
	for <lists+linux-security-module@lfdr.de>; Wed, 30 Oct 2024 04:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5D4B2103B
	for <lists+linux-security-module@lfdr.de>; Wed, 30 Oct 2024 03:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0082015B0F7;
	Wed, 30 Oct 2024 03:18:09 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4143418B09;
	Wed, 30 Oct 2024 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730258288; cv=none; b=F6iirsOwu/hFnefOh/FMdG/4zK7p7lrlZEE5ztnkk1CsyECcqbKemVsQWaDUhgdomPji53pCgHfVA5UWDcJIX5gd3bNh3xAju05bb5vChY+F86o1uhh4iKx+61ON8cSY92UwQ+8/vk0f4AsSwfSqSLe3pgLjHL/skA3ILA6ufQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730258288; c=relaxed/simple;
	bh=6ETqSpjax7dr+09qpp+3hZMqOWah/t0UWz5kzsR7B4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEL/LK8vi3BYTDORTKzFE8Zjo0p+4beg/wbDZx2T7wgR7s1jyXqrwquDeIPkZKoPioPNP5HqIjxp93flh610p1bVvnePj2oc+l7WS8Uo9YN1mS/pXz1yC49kWgeU7nw2gUgrKv60OMVcvpWHxDTP2FDM6AysTwwA2hMdMt7vHI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 0F46515AA; Tue, 29 Oct 2024 22:18:01 -0500 (CDT)
Date: Tue, 29 Oct 2024 22:18:01 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jordan Rome <linux@jordanrome.com>
Cc: linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>, Serge Hallyn <serge@hallyn.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [v4] security: add trace event for cap_capable
Message-ID: <20241030031801.GA149820@mail.hallyn.com>
References: <20241030013314.2188163-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030013314.2188163-1-linux@jordanrome.com>

On Tue, Oct 29, 2024 at 06:33:14PM -0700, Jordan Rome wrote:
> In cases where we want a stable way to observe/trace
> cap_capable (e.g. protection from inlining and API updates)
> add a tracepoint that passes:
> - The credentials used
> - The user namespace of the resource being accessed
> - The user namespace in which the credential provides the
> capability to access the targeted resource
> - The capability to check for
> - Bitmask of options defined in include/linux/security.h
> - The return value of the check
> 
> Signed-off-by: Jordan Rome <linux@jordanrome.com>

Thanks.  I'll pull this into the capability tree tomorrow so it can be
tested in linux-next  (and Andrii's ack unless he objects).

> ---
>  MAINTAINERS                       |  1 +
>  include/trace/events/capability.h | 60 +++++++++++++++++++++++++++++++
>  security/commoncap.c              | 30 +++++++++++-----
>  3 files changed, 83 insertions(+), 8 deletions(-)
>  create mode 100644 include/trace/events/capability.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc40a9d9b8cd..210e9076c858 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4994,6 +4994,7 @@ M:	Serge Hallyn <serge@hallyn.com>
>  L:	linux-security-module@vger.kernel.org
>  S:	Supported
>  F:	include/linux/capability.h
> +F:	include/trace/events/capability.h
>  F:	include/uapi/linux/capability.h
>  F:	kernel/capability.c
>  F:	security/commoncap.c
> diff --git a/include/trace/events/capability.h b/include/trace/events/capability.h
> new file mode 100644
> index 000000000000..e706ce690c38
> --- /dev/null
> +++ b/include/trace/events/capability.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM capability
> +
> +#if !defined(_TRACE_CAPABILITY_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_CAPABILITY_H
> +
> +#include <linux/cred.h>
> +#include <linux/tracepoint.h>
> +#include <linux/user_namespace.h>
> +
> +/**
> + * cap_capable - called after it's determined if a task has a particular
> + * effective capability
> + *
> + * @cred: The credentials used
> + * @targ_ns: The user namespace of the resource being accessed
> + * @capable_ns: The user namespace in which the credential provides the
> + *              capability to access the targeted resource.
> + *              This will be NULL if ret is not 0.
> + * @cap: The capability to check for
> + * @opts: Bitmask of options defined in include/linux/security.h
> + * @ret: The return value of the check: 0 if it does, -ve if it does not
> + *
> + * Allows to trace calls to cap_capable in commoncap.c
> + */
> +TRACE_EVENT(cap_capable,
> +
> +	TP_PROTO(const struct cred *cred, struct user_namespace *targ_ns,
> +		struct user_namespace *capable_ns, int cap, unsigned int opts, int ret),
> +
> +	TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
> +
> +	TP_STRUCT__entry(
> +		__field(const struct cred *, cred)
> +		__field(struct user_namespace *, targ_ns)
> +		__field(struct user_namespace *, capable_ns)
> +		__field(int, cap)
> +		__field(unsigned int, opts)
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cred       = cred;
> +		__entry->targ_ns    = targ_ns;
> +		__entry->capable_ns = capable_ns;
> +		__entry->cap        = cap;
> +		__entry->opts       = opts;
> +		__entry->ret        = ret;
> +	),
> +
> +	TP_printk("cred %p, targ_ns %p, capable_ns %p, cap %d, opts %u, ret %d",
> +		__entry->cred, __entry->targ_ns, __entry->capable_ns, __entry->cap,
> +		__entry->opts, __entry->ret)
> +);
> +
> +#endif /* _TRACE_CAPABILITY_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 162d96b3a676..7a74eb27eebf 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -27,6 +27,9 @@
>  #include <linux/mnt_idmapping.h>
>  #include <uapi/linux/lsm.h>
> 
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/capability.h>
> +
>  /*
>   * If a non-root user executes a setuid-root binary in
>   * !secure(SECURE_NOROOT) mode, then we raise capabilities.
> @@ -52,7 +55,7 @@ static void warn_setuid_and_fcaps_mixed(const char *fname)
>  /**
>   * cap_capable - Determine whether a task has a particular effective capability
>   * @cred: The credentials to use
> - * @targ_ns:  The user namespace in which we need the capability
> + * @targ_ns:  The user namespace of the resource being accessed
>   * @cap: The capability to check for
>   * @opts: Bitmask of options defined in include/linux/security.h
>   *
> @@ -67,7 +70,9 @@ static void warn_setuid_and_fcaps_mixed(const char *fname)
>  int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
>  		int cap, unsigned int opts)
>  {
> -	struct user_namespace *ns = targ_ns;
> +	int ret = -EPERM;
> +	struct user_namespace *capable_ns = NULL,
> +		*ns = targ_ns;
> 
>  	/* See if cred has the capability in the target user namespace
>  	 * by examining the target user namespace and all of the target
> @@ -75,22 +80,30 @@ int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
>  	 */
>  	for (;;) {
>  		/* Do we have the necessary capabilities? */
> -		if (ns == cred->user_ns)
> -			return cap_raised(cred->cap_effective, cap) ? 0 : -EPERM;
> +		if (ns == cred->user_ns) {
> +			if (cap_raised(cred->cap_effective, cap)) {
> +				capable_ns = ns;
> +				ret = 0;
> +			}
> +			break;
> +		}
> 
>  		/*
>  		 * If we're already at a lower level than we're looking for,
>  		 * we're done searching.
>  		 */
>  		if (ns->level <= cred->user_ns->level)
> -			return -EPERM;
> +			break;
> 
>  		/*
>  		 * The owner of the user namespace in the parent of the
>  		 * user namespace has all caps.
>  		 */
> -		if ((ns->parent == cred->user_ns) && uid_eq(ns->owner, cred->euid))
> -			return 0;
> +		if ((ns->parent == cred->user_ns) && uid_eq(ns->owner, cred->euid)) {
> +			capable_ns = ns->parent;
> +			ret = 0;
> +			break;
> +		}
> 
>  		/*
>  		 * If you have a capability in a parent user ns, then you have
> @@ -99,7 +112,8 @@ int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
>  		ns = ns->parent;
>  	}
> 
> -	/* We never get here */
> +	trace_cap_capable(cred, targ_ns, capable_ns, cap, opts, ret);
> +	return ret;
>  }
> 
>  /**
> --
> 2.43.5

