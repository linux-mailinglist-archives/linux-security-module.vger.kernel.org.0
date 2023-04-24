Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E676EB286
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Apr 2023 21:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjDUTtp (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Apr 2023 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjDUTtn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Apr 2023 15:49:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386A92D4F
        for <linux-security-module@vger.kernel.org>; Fri, 21 Apr 2023 12:49:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5fca48bcso2310991b3a.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Apr 2023 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682106579; x=1684698579;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JIvd4x7LTmDxMSDhcMvwp3CwwVRBeE4EwRrm8E3OHq4=;
        b=Qf4Fe9MPe5Sj8cgdIfHhirtvk0msL50MfrH/MbU696GxuEuSEK4DkX7X54jWkmKTkt
         92UodqD70fJK92aU4yCXHFdiyKfFNouCzW+CnAxELl24bUhr1MV0RGZlKp+BqK/AYK9m
         aymxZOALqVgWFAJoAzMFPfsQXI9dNbU8iaRoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682106579; x=1684698579;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIvd4x7LTmDxMSDhcMvwp3CwwVRBeE4EwRrm8E3OHq4=;
        b=RSk9HiOhIC9DZsbYdmU8Gxv8T72DcHAXLiwnowvRSXHlElhR60lqU4LeKC21AtinoH
         IzjYzrhSOlPXH6YKDEVtr16HqKdqKUSEdyuEH75oXVAx/UbRaUoWe6gfRMWt6h6Cj23d
         M61+ahfsJhgR75QKK70V6Jb8H6SgbuPwbQ9cCMfxpXFYBd/PCqlGpszVYzDXfFm3M3RT
         z1f3dYP9zY2bqORqQfbBED4nKKSFR8SfwrVm98NltyTc1cPb4UqC6wPEa+JCWC9WRJQa
         UeKzNRBQYGmIYrLXovStVN2DfKgmsv/NXT5lkwu88Bady2ROQFO0X+wzrgnW421+PWr0
         u2hA==
X-Gm-Message-State: AAQBX9etg0o5cNqK8eAKz3B4anMIyLdEWGaapVNvIT0IJ6+2mK+IgcTq
        GHuNvYluD5ELnVybzxdmycctiw==
X-Google-Smtp-Source: AKy350Y5XxLtjv4JulE2GGm+rJvmzJmA407m70wz0D8uBy7wGU21LL3TEB+ZO1R9v4L5F34Xq6yOEQ==
X-Received: by 2002:a05:6a20:3941:b0:f0:1b0b:acf7 with SMTP id r1-20020a056a20394100b000f01b0bacf7mr8411267pzg.2.1682106579571;
        Fri, 21 Apr 2023 12:49:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t9-20020a6549c9000000b0051b3ef1295csm2926598pgs.53.2023.04.21.12.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:49:39 -0700 (PDT)
Message-ID: <6442e8d3.650a0220.f3e8d.6a3f@mx.google.com>
X-Google-Original-Message-ID: <202304211247.@keescook>
Date:   Fri, 21 Apr 2023 12:49:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v9 08/11] Smack: implement setselfattr and getselfattr
 hooks
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-9-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-9-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 21, 2023 at 10:42:56AM -0700, Casey Schaufler wrote:
> Implement Smack support for security_[gs]etselfattr.
> Refactor the setprocattr hook to avoid code duplication.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/smack/smack_lsm.c | 105 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 100 insertions(+), 5 deletions(-)
> 
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 3cf862fcbe08..902b39c187bf 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3552,6 +3552,41 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  	return;
>  }
>  
> +/**
> + * smack_getselfattr - Smack current process attribute
> + * @attr: which attribute to fetch
> + * @ctx: buffer to receive the result
> + * @size: available size in, actual size out
> + * @flags: unused
> + *
> + * Fill the passed user space @ctx with the details of the requested
> + * attribute.
> + *
> + * Returns 1, the number of attributes, on success, an error code otherwise.
> + */
> +static int smack_getselfattr(unsigned int __user attr,
> +			     struct lsm_ctx __user *ctx, size_t *size,
> +			     u32 __user flags)
> +{
> +	struct smack_known *skp = smk_of_current();
> +	int total;
> +	int slen;
> +	int rc = 1;
> +
> +	if (attr != LSM_ATTR_CURRENT)
> +		return -EOPNOTSUPP;
> +
> +	slen = strlen(skp->smk_known) + 1;
> +	total = ALIGN(slen + sizeof(*ctx), 8);
> +	if (total > *size)
> +		rc = -E2BIG;
> +	else
> +		lsm_fill_user_ctx(ctx, skp->smk_known, slen, LSM_ID_SMACK, 0);
> +
> +	*size = total;
> +	return rc;
> +}
> +
>  /**
>   * smack_getprocattr - Smack process attribute access
>   * @p: the object task
> @@ -3581,8 +3616,8 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
>  }
>  
>  /**
> - * smack_setprocattr - Smack process attribute setting
> - * @name: the name of the attribute in /proc/.../attr
> + * do_setattr - Smack process attribute setting
> + * @attr: the ID of the attribute
>   * @value: the value to set
>   * @size: the size of the value
>   *
> @@ -3591,7 +3626,7 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
>   *
>   * Returns the length of the smack label or an error code
>   */
> -static int smack_setprocattr(const char *name, void *value, size_t size)
> +static int do_setattr(u64 attr, void *value, size_t size)
>  {
>  	struct task_smack *tsp = smack_cred(current_cred());
>  	struct cred *new;
> @@ -3605,8 +3640,8 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>  	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
>  		return -EINVAL;
>  
> -	if (strcmp(name, "current") != 0)
> -		return -EINVAL;
> +	if (attr != LSM_ATTR_CURRENT)
> +		return -EOPNOTSUPP;
>  
>  	skp = smk_import_entry(value, size);
>  	if (IS_ERR(skp))
> @@ -3645,6 +3680,64 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>  	return size;
>  }
>  
> +/**
> + * smack_setselfattr - Set a Smack process attribute
> + * @attr: which attribute to set
> + * @ctx: buffer containing the data
> + * @size: size of @ctx
> + * @flags: unused
> + *
> + * Fill the passed user space @ctx with the details of the requested
> + * attribute.
> + *
> + * Returns 0 on success, an error code otherwise.
> + */
> +static int smack_setselfattr(unsigned int __user attr,
> +			     struct lsm_ctx __user *ctx, size_t __user size,

"size_t __user" isn't valid: it's not a pointer.

> +			     u32 __user flags)
> +{
> +	struct lsm_ctx *lctx;
> +	void *context;

Why is "context" used here at all? Can't this entirely be lctx?

> +	int rc;
> +
> +	context = kmalloc(size, GFP_KERNEL);
> +	if (context == NULL)
> +		return -ENOMEM;
> +
> +	lctx = (struct lsm_ctx *)context;
> +	if (copy_from_user(context, ctx, size))
> +		rc = -EFAULT;
> +	else if (lctx->ctx_len > size)
> +		rc = -EINVAL;
> +	else
> +		rc = do_setattr(attr, lctx + 1, lctx->ctx_len);

There is no "second lctx", please pass lctx->ctx instead.

> +
> +	kfree(context);
> +	if (rc > 0)
> +		return 0;
> +	return rc;
> +}
> +
> +/**
> + * smack_setprocattr - Smack process attribute setting
> + * @name: the name of the attribute in /proc/.../attr
> + * @value: the value to set
> + * @size: the size of the value
> + *
> + * Sets the Smack value of the task. Only setting self
> + * is permitted and only with privilege
> + *
> + * Returns the length of the smack label or an error code
> + */
> +static int smack_setprocattr(const char *name, void *value, size_t size)
> +{
> +	int attr = lsm_name_to_attr(name);
> +
> +	if (attr)
> +		return do_setattr(attr, value, size);
> +	return -EINVAL;
> +}
> +
>  /**
>   * smack_unix_stream_connect - Smack access on UDS
>   * @sock: one sock
> @@ -4955,6 +5048,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  
>  	LSM_HOOK_INIT(d_instantiate, smack_d_instantiate),
>  
> +	LSM_HOOK_INIT(getselfattr, smack_getselfattr),
> +	LSM_HOOK_INIT(setselfattr, smack_setselfattr),
>  	LSM_HOOK_INIT(getprocattr, smack_getprocattr),
>  	LSM_HOOK_INIT(setprocattr, smack_setprocattr),
>  
> -- 
> 2.39.2
> 

-- 
Kees Cook
