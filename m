Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA761F0184
	for <lists+linux-security-module@lfdr.de>; Fri,  5 Jun 2020 23:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgFEVZx (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 5 Jun 2020 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgFEVZx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Jun 2020 17:25:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B21DC08C5C2
        for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2020 14:25:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g12so4194176pll.10
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2020 14:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=urBqrXmsKuejZqqgq5qc3hGiWIhwGWGivaUeIi7PeY4=;
        b=D/0PbinNTtonxyU59oeCYFc2HloFKq9Ooww0Kt+LmyYSAYYrGlzZpv71At2iuZwnlP
         IyNOyfpVU3tFK3pNCFkbGbvNe+KuyGKXThtVczwTIZnYVkrqekWEqm/N9trRbNCvgKXx
         ILTVHEhdliJKja5YVlRCejy+dZZqs90DP7T8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=urBqrXmsKuejZqqgq5qc3hGiWIhwGWGivaUeIi7PeY4=;
        b=Gh7XfJOf8p3oGuxfQlTeFKOYBtMcR6u1oV3K31ST2GkkWdGQi3m1V8RwBlS8WfmfYB
         6Seqw4GXcMR8I5opbS2LQpLHDpfSRYAkZyYol9E72rV28Mf5oteXLLP6yjxOucfP/BP2
         5Yfk9QcTGyXYD4xRRwWfPoEuMKVZqlKN3Fr8LnD8gfK/M9ezX18/Fih4LYjWaZHTCTgZ
         8bxAB3FF2oQOip/id7yehZAM90G22Qu6YYTp1rqb9IrnwTjvhBzqs0JwodzFx5Efbd96
         tF/NtDabV2JAsKkR4/7Ol+ykX1zDXbde+YV2mz6AEIC4O7vfffXBQ6prUGXvxGxwN42S
         q5/Q==
X-Gm-Message-State: AOAM533HWvBl9iEGBuNfrzcK3j4YnWoEMOW4w2zfI0jzgJW93sQr4F5V
        eDxCVjiipqIZTEIwALMKWW9yww==
X-Google-Smtp-Source: ABdhPJwl/P8c3/89K4fxGoFnECtx8qqZyfKxt1D9O9/uL0gEgOhw5csET73fJdzz+D6WMsWE6NbP+g==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr12077776plp.259.1591392352999;
        Fri, 05 Jun 2020 14:25:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s1sm9077838pjp.27.2020.06.05.14.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 14:25:52 -0700 (PDT)
Date:   Fri, 5 Jun 2020 14:25:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Micah Morton <mortonm@chromium.org>
Cc:     linux-security-module@vger.kernel.org, thomascedeno@google.com
Subject: Re: [PATCH] security: Add LSM hooks to set*gid syscalls
Message-ID: <202006051421.2168E5AA8@keescook>
References: <20200605193805.36531-1-mortonm@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605193805.36531-1-mortonm@chromium.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 05, 2020 at 12:38:05PM -0700, Micah Morton wrote:
> The SafeSetID LSM uses the security_task_fix_setuid hook to filter
> set*uid() syscalls according to its configured security policy. In
> preparation for adding analagous support in the LSM for set*gid()
> syscalls, we add the requisite hook here. Tested by putting print
> statements in the security_task_fix_setgid hook and seeing them get hit
> during kernel boot.
> 
> From: Thomas Cedeno <thomascedeno@google.com>

^^^ this line should be before the commit log body (many tools won't
find it here).

> Signed-off-by: Thomas Cedeno <thomascedeno@google.com>
> Reviewed-by: Micah Morton <mortonm@chromium.org>
> ---
> NOTE: I (Micah) will send this patch as a pull request to Linus through
> my SafeSetID tree if there are no objections.
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/lsm_hooks.h     |  9 +++++++++
>  include/linux/security.h      |  9 +++++++++
>  kernel/sys.c                  | 15 ++++++++++++++-
>  security/security.c           |  6 ++++++
>  5 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index fb3ce6cec997..d5401c09f2d3 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -191,6 +191,8 @@ LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
>  	 loff_t size, enum kernel_read_file_id id)
>  LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
>  	 int flags)
> +LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
> +	 int flags)
>  LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
>  LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
>  LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 3e62dab77699..8012b610fe53 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -659,6 +659,15 @@
>   *	@old is the set of credentials that are being replaces
>   *	@flags contains one of the LSM_SETID_* values.
>   *	Return 0 on success.
> + * @task_fix_setgid:
> + *     Update the module's state after setting one or more of the group
> + *     identity attributes of the current process.  The @flags parameter
> + *     indicates which of the set*gid system calls invoked this hook.
> + *     @new is the set of credentials that will be installed.  Modifications
> + *     should be made to this rather than to @current->cred.
> + *     @old is the set of credentials that are being replaced.
> + *     @flags contains one of the LSM_SETID_* values.
> + *     Return 0 on success.

The indenting here appears to be using spaces instead of a tab.

Everything else looks okay. (There are a surprising number of gid
changing places...)

-- 
Kees Cook
