Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA031FC6
	for <lists+linux-security-module@lfdr.de>; Sat,  1 Jun 2019 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFAPXn (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 1 Jun 2019 11:23:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35225 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfFAPXn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 1 Jun 2019 11:23:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so5220948plo.2
        for <linux-security-module@vger.kernel.org>; Sat, 01 Jun 2019 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F0B1ps+ogRvMl+w6JhEnp7ZTeNOfQPalt9N+gdwQfXY=;
        b=WGASHefWAFVXlwrt8GhItKHS04JYwRLyTz10b2erx6HAd9LAyV1mY4k8W9wr7eRCMA
         7EoTOEH4OnAkR1v6uBcFE+3s58uMTslw0+r46UIBX8XGxlj4BCk7hmnTmaMlc1aNO16A
         6AjnM9qdtyMatMFwNncjH4j69roQLD3t3mlW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0B1ps+ogRvMl+w6JhEnp7ZTeNOfQPalt9N+gdwQfXY=;
        b=uT9XOlt5/JpfbAKiK5gjQQzLse9pMLYbgGei+XkEq6LNGNMAZ66umqfKnltetGc2Bk
         I78FdOmUjbfXnpBhTdK6yPW496BFlmX6wmu6bF1RKO5L25XJmZx6r0yjMJL+Iw0iijAc
         6oHIqDSTxU7NHKD0DtpUHB2HoPDmO0u1+UXkPzGlSLgz8P9xFgA7t+HaqBma2zbfSe5p
         f5QviEhQh7bt+vSSg48koNEWkz88vHXbhI6LLnv4lHIFsWGJV6vjiJK5c3U9jWYZONYv
         rYk/r6YwqrJ4wGTIMJ+FcacNZgv0NCkdoqSQjZW5yWqqTPTP2R9AJgh34PNEpF4wcaAB
         B9+g==
X-Gm-Message-State: APjAAAU1f4vQBJenBzwFiCr2SW5o3tkqY8150D73ZLhKY2NKJB0gr+xN
        ZPGIq0Jj1oY54SKwWMMdSsFYDA==
X-Google-Smtp-Source: APXvYqwGnmV7QqOvSFxwr0SsrW853jFK6X2Z7OKZ+88zmXB2h/SSTiYWKG9ugw1TV1x+G/eM5xMaaw==
X-Received: by 2002:a17:902:1029:: with SMTP id b38mr16786384pla.72.1559402622661;
        Sat, 01 Jun 2019 08:23:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p21sm12498214pfn.129.2019.06.01.08.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 08:23:41 -0700 (PDT)
Date:   Sat, 1 Jun 2019 08:23:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 04/58] LSM: Create an lsm_export data structure.
Message-ID: <201906010822.03972E152B@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531231020.628-5-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 31, 2019 at 04:09:26PM -0700, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thoughts below...

> ---
>  include/linux/security.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 49f2685324b0..81f9f79f9a1e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -76,6 +76,18 @@ enum lsm_event {
>  	LSM_POLICY_CHANGE,
>  };
>  
> +/* Data exported by the security modules */
> +struct lsm_export {
> +	u32	selinux;
> +	u32	smack;
> +	u32	apparmor;
> +	u32	flags;
> +};

I think it might make more logical sent to leave flags at the start.
While I don't expect to add more fields, I find it surprising that
it is at the end. :)

-Kees

> +#define LSM_EXPORT_NONE		0x00
> +#define LSM_EXPORT_SELINUX	0x01
> +#define LSM_EXPORT_SMACK	0x02
> +#define LSM_EXPORT_APPARMOR	0x04
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>  		       int cap, unsigned int opts);
> -- 
> 2.19.1
> 

-- 
Kees Cook
