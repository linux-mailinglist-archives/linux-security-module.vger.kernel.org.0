Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA2F4F8F7
	for <lists+linux-security-module@lfdr.de>; Sun, 23 Jun 2019 01:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfFVXg7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 22 Jun 2019 19:36:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43600 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVXg7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 19:36:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so4766340plb.10
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 16:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U+5+2Qh/0QhRiiupiu6zSUwgYpKyCd0X95gaOjYABfk=;
        b=mdDnDSfmcYlWmUo92BUO0QQMxLUdJRK+3Kaz+JtuuRPjWgWZB6ElP9F/+FjeJtOFrM
         dkuW7RLVIYzmgKjAu3oFlXbyHhVCxnKvwYaCW2v/mrdNdl8984BxeaylqA7/FQqP/yld
         m5ZPCcFQsWRJVY9fSW6tCqwZ1D9DaTsLLY/Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U+5+2Qh/0QhRiiupiu6zSUwgYpKyCd0X95gaOjYABfk=;
        b=c/uCvIavWPdjpUQBh2eQXR1JasQ43h5uIx+xtmRengJjbMCd+T7u2DwxkV/zdABYWH
         3R20/Zudt8LMCPX3041Hft1SSk1pCd5s7Wr2rccncwHthkalKqYG0bueYO5/m7MO6d/3
         uwIIAAk3o9YcnuhKVeITwsxyPVhwgpDVDfQ92itII4TuCdCQErbch6d6Gfnc5GoSCVrU
         TLS81yz5hIVbWi655mwvMEYU9aU6Osb9kXaEZNVdASUsiI6Owcm5KlgdqaCj6k9D1u/J
         QIa4Cz+vABj0BF1LKfVHrgJDcPr0MVHjvml9tTDuMUKNeQ6ha20szzji3zWh+1a6kXPy
         sG/g==
X-Gm-Message-State: APjAAAVu83EPVsQxwNfGDLWQFZHudPIIjysNOFxlq0/+zvHLpDi1rfPx
        s7nlkBydrr3duYMCdcseYwgHsQ==
X-Google-Smtp-Source: APXvYqwvZ24Ee6HPTmlNABz/Lo+TOB6eOulnrTmw9hNkLKLAX7SruGI6kaIgYYVsN4QaOJ8pRVF5uQ==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr117342042plo.225.1561246618166;
        Sat, 22 Jun 2019 16:36:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4sm6190875pji.24.2019.06.22.16.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:36:56 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:36:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V34 01/29] security: Support early LSMs
Message-ID: <201906221636.AABF971@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-2-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-2-matthewgarrett@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 05:03:30PM -0700, Matthew Garrett wrote:
> The lockdown module is intended to allow for kernels to be locked down
> early in boot - sufficiently early that we don't have the ability to
> kmalloc() yet. Add support for early initialisation of some LSMs, and
> then add them to the list of names when we do full initialisation later.
> Early LSMs are initialised in link order and cannot be overridden via
> boot parameters, and cannot make use of kmalloc() (since the allocator
> isn't initialised yet).
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/asm-generic/vmlinux.lds.h |  8 ++++-
>  include/linux/lsm_hooks.h         |  6 ++++
>  include/linux/security.h          |  1 +
>  init/main.c                       |  1 +
>  security/security.c               | 50 ++++++++++++++++++++++++++-----
>  5 files changed, 57 insertions(+), 9 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index f8f6f04c4453..e1963352fdb6 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -208,8 +208,13 @@
>  			__start_lsm_info = .;				\
>  			KEEP(*(.lsm_info.init))				\
>  			__end_lsm_info = .;
> +#define EARLY_LSM_TABLE()	. = ALIGN(8);				\
> +			__start_early_lsm_info = .;			\
> +			KEEP(*(.early_lsm_info.init))			\
> +			__end_early_lsm_info = .;
>  #else
>  #define LSM_TABLE()
> +#define EARLY_LSM_TABLE()
>  #endif
>  
>  #define ___OF_TABLE(cfg, name)	_OF_TABLE_##cfg(name)
> @@ -610,7 +615,8 @@
>  	ACPI_PROBE_TABLE(irqchip)					\
>  	ACPI_PROBE_TABLE(timer)						\
>  	EARLYCON_TABLE()						\
> -	LSM_TABLE()
> +	LSM_TABLE()							\
> +	EARLY_LSM_TABLE()
>  
>  #define INIT_TEXT							\
>  	*(.init.text .init.text.*)					\
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a240a3fc5fc4..66fd1eac7a32 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2085,12 +2085,18 @@ struct lsm_info {
>  };
>  
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
> +extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>  
>  #define DEFINE_LSM(lsm)							\
>  	static struct lsm_info __lsm_##lsm				\
>  		__used __section(.lsm_info.init)			\
>  		__aligned(sizeof(unsigned long))
>  
> +#define DEFINE_EARLY_LSM(lsm)						\
> +	static struct lsm_info __early_lsm_##lsm			\
> +		__used __section(.early_lsm_info.init)			\
> +		__aligned(sizeof(unsigned long))
> +
>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>  /*
>   * Assuring the safety of deleting a security module is up to
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 49f2685324b0..1bb6fb2f1523 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -194,6 +194,7 @@ int unregister_lsm_notifier(struct notifier_block *nb);
>  
>  /* prototypes */
>  extern int security_init(void);
> +extern int early_security_init(void);
>  
>  /* Security operations */
>  int security_binder_set_context_mgr(struct task_struct *mgr);
> diff --git a/init/main.c b/init/main.c
> index 598e278b46f7..f3faeb89c75f 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -563,6 +563,7 @@ asmlinkage __visible void __init start_kernel(void)
>  	boot_cpu_init();
>  	page_address_init();
>  	pr_notice("%s", linux_banner);
> +	early_security_init();
>  	setup_arch(&command_line);
>  	/*
>  	 * Set up the the initial canary and entropy after arch
> diff --git a/security/security.c b/security/security.c
> index 23cbb1a295a3..487e1f3eb2df 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -37,6 +37,7 @@
>  
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> +#define EARLY_LSM_COUNT (__end_early_lsm_info - __start_early_lsm_info)
>  
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
> @@ -281,6 +282,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  static void __init lsm_early_cred(struct cred *cred);
>  static void __init lsm_early_task(struct task_struct *task);
>  
> +static int lsm_append(const char *new, char **result);
> +
>  static void __init ordered_lsm_init(void)
>  {
>  	struct lsm_info **lsm;
> @@ -327,6 +330,26 @@ static void __init ordered_lsm_init(void)
>  	kfree(ordered_lsms);
>  }
>  
> +int __init early_security_init(void)
> +{
> +	int i;
> +	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
> +	struct lsm_info *lsm;
> +
> +	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
> +	     i++)
> +		INIT_HLIST_HEAD(&list[i]);
> +
> +	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +		if (!lsm->enabled)
> +			lsm->enabled = &lsm_enabled_true;
> +		prepare_lsm(lsm);
> +		initialize_lsm(lsm);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * security_init - initializes the security framework
>   *
> @@ -334,14 +357,18 @@ static void __init ordered_lsm_init(void)
>   */
>  int __init security_init(void)
>  {
> -	int i;
> -	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
> +	struct lsm_info *lsm;
>  
>  	pr_info("Security Framework initializing\n");
>  
> -	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
> -	     i++)
> -		INIT_HLIST_HEAD(&list[i]);
> +	/*
> +	 * Append the names of the early LSM modules now that kmalloc() is
> +	 * available
> +	 */
> +	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +		if (lsm->enabled)
> +			lsm_append(lsm->name, &lsm_names);
> +	}
>  
>  	/* Load LSMs in specified order. */
>  	ordered_lsm_init();
> @@ -388,7 +415,7 @@ static bool match_last_lsm(const char *list, const char *lsm)
>  	return !strcmp(last, lsm);
>  }
>  
> -static int lsm_append(char *new, char **result)
> +static int lsm_append(const char *new, char **result)
>  {
>  	char *cp;
>  
> @@ -426,8 +453,15 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  		hooks[i].lsm = lsm;
>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
>  	}
> -	if (lsm_append(lsm, &lsm_names) < 0)
> -		panic("%s - Cannot get early memory.\n", __func__);
> +
> +	/*
> +	 * Don't try to append during early_security_init(), we'll come back
> +	 * and fix this up afterwards.
> +	 */
> +	if (slab_is_available()) {
> +		if (lsm_append(lsm, &lsm_names) < 0)
> +			panic("%s - Cannot get early memory.\n", __func__);
> +	}
>  }
>  
>  int call_lsm_notifier(enum lsm_event event, void *data)
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
