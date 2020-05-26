Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463151A1516
	for <lists+linux-security-module@lfdr.de>; Tue,  7 Apr 2020 20:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDGSmN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 7 Apr 2020 14:42:13 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52638 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgDGSmN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Apr 2020 14:42:13 -0400
Received: by mail-pj1-f67.google.com with SMTP id ng8so127182pjb.2
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2020 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rGMO+JNuJTFMNu+IvjPr6Xa2QJ1yEqPcNRujwJ3PgYs=;
        b=OKm/o5ByckwbS5WxUhxAKL3XHBMmncEXDy5alqCUu5gQBI5p32yxxXMRWtCOO0iFK6
         WCjnr2xBxOrZm1YFmctLuTQ1zk09MPL3Za7Y8S2VBDt1whwa85FgkaPXNJ//q3YpWhai
         byGNa/kmRZ3jV/sakgHzcNRvO4SxxvhlLZVk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rGMO+JNuJTFMNu+IvjPr6Xa2QJ1yEqPcNRujwJ3PgYs=;
        b=EM0AnBl47TfwrgoxmoOvFXPPKGIg5QjrFNo2ebX4jbKB3pUHy3g6XS9eVSypexiSek
         wC7XdygXTv0noK27OB5Q23Obq+gwCUMWvtaMk7MJABY2ag9pkl2wVnLZVBEV2BoDfer2
         JPu9O5Jy7XMvgN0E22Udhli5khsoea8YN4b5L1Jn/bX9aTwgrjJDb3FdFfyq3Z2o7t5p
         bFqTyFet+c4EuHdan7ARlIKNsALU/Efof8CWLryjjvzTjW6UWEJD/ZLNQBONXDZhDJ1p
         d1IJXXtm8WpMKVok4rNyO+kH0PhyVLe2R97DI+hWnET5Mf0+XCFbKEcumPOh8SNg29oy
         6Lvw==
X-Gm-Message-State: AGi0PuYfW3JPBOIVc9BHTUZZ/z5e9G40I+cqSuyL0lNjxccLhjvegpj3
        dv4HtGt8FYjbHHnobgNWgh2WWQ==
X-Google-Smtp-Source: APiQypJ9IYIjuZzf0qtFv2N2USEg/IgxVpKnFdgp2UHq75sWRA3RZIXomTD7OPyoLqzRN5K30gxO1Q==
X-Received: by 2002:a17:902:a411:: with SMTP id p17mr3730363plq.157.1586284932978;
        Tue, 07 Apr 2020 11:42:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p22sm14034306pgn.73.2020.04.07.11.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:42:12 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:42:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: Re: [PATCH v16 19/23] LSM: Verify LSM display sanity in binder
Message-ID: <202004071142.C3250D5@keescook>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
 <20200407000159.43602-20-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407000159.43602-20-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 06, 2020 at 05:01:55PM -0700, Casey Schaufler wrote:
> Verify that the tasks on the ends of a binder transaction
> use the same "display" security module. This prevents confusion
> of security "contexts".
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/security.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/security/security.c b/security/security.c
> index 84f33bd4990a..b7c2ed1eee42 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -769,9 +769,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
>  	return call_int_hook(binder_set_context_mgr, 0, mgr);
>  }
>  
> +/**
> + * security_binder_transaction - Binder driver transaction check
> + * @from: source of the transaction
> + * @to: destination of the transaction
> + *
> + * Verify that the tasks have the same LSM "display", then
> + * call the security module hooks.
> + *
> + * Returns -EINVAL if the displays don't match, or the
> + * result of the security module checks.
> + */
>  int security_binder_transaction(struct task_struct *from,
>  				struct task_struct *to)
>  {
> +	int from_display = lsm_task_display(from);
> +	int to_display = lsm_task_display(to);
> +
> +	/*
> +	 * If the display is LSMBLOB_INVALID the first module that has
> +	 * an entry is used. This will be in the 0 slot.
> +	 *
> +	 * This is currently only required if the server has requested
> +	 * peer contexts, but it would be unwieldly to have too much of
> +	 * the binder driver detail here.
> +	 */
> +	if (from_display == LSMBLOB_INVALID)
> +		from_display = 0;
> +	if (to_display == LSMBLOB_INVALID)
> +		to_display = 0;
> +	if (from_display != to_display)
> +		return -EINVAL;
> +
>  	return call_int_hook(binder_transaction, 0, from, to);
>  }
>  
> -- 
> 2.24.1
> 

-- 
Kees Cook
