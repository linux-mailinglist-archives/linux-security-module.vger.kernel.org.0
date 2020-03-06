Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B98F17C81A
	for <lists+linux-security-module@lfdr.de>; Fri,  6 Mar 2020 23:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCFWGt (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 6 Mar 2020 17:06:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34365 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCFWGt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Mar 2020 17:06:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id c21so4276464edt.1
        for <linux-security-module@vger.kernel.org>; Fri, 06 Mar 2020 14:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25rPpRqtp+PUftQedSjsvkJsVlq3iN1SYcfyYA/iZ7o=;
        b=Aqc4+7Fbky55icQYK73rRYTO8HD33OcHEoIwwiYk+2Fyh8223wIsvc3sJ/1ZjslkWk
         w4uCkEorMynIdab3pWXGLKZT5LPnJ5eky4WYDGejmiZmfofah0xKlfw2pIzwKH4b/Ibx
         m0+x974S12JulW9jMt8+8JUqUNJOGpsjL4uy6jIDj3dXS5mj5dX+omnwHOxIU8r8K+OL
         2Ngb5VkBzcWjxVWvLwuG7IrCM4VNI0uBw6ikBP1oXYtBu7fEK/G5sbk366DAM6Mm5YXL
         vpbPJbt2NcdnSWk9ndl5Q/XJyaBOO4HtJQq2jEAFlVeeKvskRAKMHPq9kJ2OIuHNklnd
         tbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25rPpRqtp+PUftQedSjsvkJsVlq3iN1SYcfyYA/iZ7o=;
        b=HMk6NcaL30ok25Om67cBWkOaOyVAv9NFVsT0upDU1/jWdbJEZ3zJ3OrrwSN8TrLb4L
         UgWoS4kyjtsULp5OHpxMvUKCfN4mwM18MlA21vDFsQurGogGQUpG5lh0ViHzlNz0LZxD
         iPdGpBfS0AlBnnR/G70vyb6Im0VKNUXWb+zw3FQvQDz7wNjxeUJ8EL8EUDETAfEPng2W
         fNcv4U49ERMTuP7XzV8jtH3QHPJgR2ErLzLGFq0CpLx71cha2Ycwjn2G+UjggnNunB/C
         j4zm9mUUSjKPsSfCrbpPyh2o4QIuETu2L8sDllek1UUBOwxhEsrF00OvRNOqxGly0c5E
         vt8g==
X-Gm-Message-State: ANhLgQ2YyC8gFSGRQzGuqnBzx4lSi6GT/ssMfrimPNYlNCjfrZL585g+
        AFxhbNOJqhHnIUI7H+nSiZqNGYOizeXZE0XjS6k7
X-Google-Smtp-Source: ADFU+vs2epDXQCKg9s2Kw7bb9iMPgviESbXyz1oCpUspijdKcrX4E1MY2X6hvTazXVndI/USntf/XX3XQhV+P7GcBbo=
X-Received: by 2002:a17:906:370a:: with SMTP id d10mr4975699ejc.281.1583532405956;
 Fri, 06 Mar 2020 14:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20200214234203.7086-1-casey@schaufler-ca.com> <20200214234203.7086-5-casey@schaufler-ca.com>
In-Reply-To: <20200214234203.7086-5-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Mar 2020 17:06:35 -0500
Message-ID: <CAHC9VhQQMwTa41_MftjocsmoWg6Yd8LGhMfM8F2iTJhx9k_NaA@mail.gmail.com>
Subject: Re: [PATCH v15 04/23] LSM: Use lsmblob in security_kernel_act_as
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 14, 2020 at 6:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change the security_kernel_act_as interface to use a lsmblob
> structure in place of the single u32 secid in support of
> module stacking. Change its only caller, set_security_override,
> to do the same. Change that one's only caller,
> set_security_override_from_ctx, to call it with the new
> parameter type.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/cred.h     |  3 ++-
>  include/linux/security.h |  5 +++--
>  kernel/cred.c            | 10 ++++++----
>  security/security.c      | 14 ++++++++++++--
>  4 files changed, 23 insertions(+), 9 deletions(-)

...

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 9d83c6832bae..1bfaf9ece13e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -439,7 +439,7 @@ void security_cred_free(struct cred *cred);
>  int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
>  void security_transfer_creds(struct cred *new, const struct cred *old);
>  void security_cred_getsecid(const struct cred *c, u32 *secid);
> -int security_kernel_act_as(struct cred *new, u32 secid);
> +int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
>  int security_kernel_create_files_as(struct cred *new, struct inode *inode);
>  int security_kernel_module_request(char *kmod_name);
>  int security_kernel_load_data(enum kernel_load_data_id id);
> @@ -1045,7 +1045,8 @@ static inline void security_transfer_creds(struct cred *new,
>  {
>  }
>
> -static inline int security_kernel_act_as(struct cred *cred, u32 secid)
> +static inline int security_kernel_act_as(struct cred *cred,
> +                                        struct lsmblob *blob)
>  {
>         return 0;
>  }
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 809a985b1793..fae63c0a1b36 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -732,14 +732,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
>  /**
>   * set_security_override - Set the security ID in a set of credentials
>   * @new: The credentials to alter
> - * @secid: The LSM security ID to set
> + * @blob: The LSM security information to set
>   *
>   * Set the LSM security ID in a set of credentials so that the subjective
>   * security is overridden when an alternative set of credentials is used.
>   */
> -int set_security_override(struct cred *new, u32 secid)
> +int set_security_override(struct cred *new, struct lsmblob *blob)
>  {
> -       return security_kernel_act_as(new, secid);
> +       return security_kernel_act_as(new, blob);
>  }
>  EXPORT_SYMBOL(set_security_override);
>
> @@ -755,6 +755,7 @@ EXPORT_SYMBOL(set_security_override);
>   */
>  int set_security_override_from_ctx(struct cred *new, const char *secctx)
>  {
> +       struct lsmblob blob;
>         u32 secid;
>         int ret;
>
> @@ -762,7 +763,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
>         if (ret < 0)
>                 return ret;
>
> -       return set_security_override(new, secid);
> +       lsmblob_init(&blob, secid);
> +       return set_security_override(new, &blob);

See my comments in 03/23, this is another case where the value of
lsmblob is not yet clear to me, but perhaps it will make sense later
in the patchset.

>  }
>  EXPORT_SYMBOL(set_security_override_from_ctx);

-- 
paul moore
www.paul-moore.com
