Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 747D311B906
	for <lists+linux-security-module@lfdr.de>; Wed, 11 Dec 2019 17:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfLKQmJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 11 Dec 2019 11:42:09 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36557 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbfLKQmJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Dec 2019 11:42:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id d15so1634286pll.3
        for <linux-security-module@vger.kernel.org>; Wed, 11 Dec 2019 08:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c4rdCOTuzh9NFLBkEKv9p2rcDGyTXXHdF3UlxgP4Gr4=;
        b=oUHElpViK6TPH1aob+JzbEXJ0Nhu0qR6MG7h6ADGhb1WtDyDx6uy+WyENBHrpNn5uS
         KH8z1FKUGb2eErdw8T+u+JzC0GOoaP7iSll5KwXB3OykTvAJe26FfGM+iPtYD03Oizl8
         TVYeLO62INfRVDNKFhIqKQtOhkvy90D9sLjM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c4rdCOTuzh9NFLBkEKv9p2rcDGyTXXHdF3UlxgP4Gr4=;
        b=nCKtM8QqaK4DKr2I/GTIuuos8uxA0jB0OdOtP/dr27QY3A1UhQ6sj16mNtvtHZ48bT
         FKir41CuKzSjB1ADSd/27GvhRYvIDzNtoRlZoQ/rLig1o4rSPDFUpWscVbgIPLrFVAnK
         YlZ6A6Ee4ocAFXPEDjy8Y/SNFxiQ3lHfscVeLwTi0gdMIg6/XO8cWDZ/B6WN3XDRLuR2
         apGyijyj4czShZ22C4naxwAb5ad+lukRrta/gzODgUsiewE11JNNdeVenCckAKhQblTN
         /lVNGr+kPsLpq8xlL99gEuOIkZBo8lwOgheeuVZCDg6DSmA2DqccWafUaImTDztwBtiU
         1SQA==
X-Gm-Message-State: APjAAAWOGICNmJFN9xEr0R1N1mihLwcqYBQcmIi0b43j207H88hkwP62
        cORDGvlsJsRF7ILX/JAjvzXAKnQbQAc=
X-Google-Smtp-Source: APXvYqyXpgmQQr/RrevmoBVDXLE+KMKSitdjo0VmzeeMb5rJD3OEfGVkKCi10VasouTq6P+sCNb3xQ==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr3957764plp.120.1576082527811;
        Wed, 11 Dec 2019 08:42:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm3652831pfo.123.2019.12.11.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 08:42:06 -0800 (PST)
Date:   Wed, 11 Dec 2019 08:42:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
Message-ID: <201912110840.62A4E64BA@keescook>
References: <20191211140833.939845-1-omosnace@redhat.com>
 <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
> > Instead of deleting the hooks from each list one-by-one (which creates
> > some bad race conditions), allow an LSM to provide a reference to its
> > "enabled" variable and check this variable before calling the hook.
> > 
> > As a nice side effect, this allows marking the hooks (and other stuff)
> > __ro_after_init unconditionally. Since SECURITY_WRITABLE_HOOKS no longer
> > makes sense, remove it and instead use SECURITY_SELINUX_DISABLE directly
> > for turning on the runtime disable functionality, to emphasize that this
> > is only used by SELinux and is meant to be removed in the future.
> 
> Is this fundamentally different/better than adding if (!selinux_enabled)
> return 0; to the beginning of every SELinux hook function?  And as I noted
> to Casey in the earlier thread, that provides an additional easy target to
> kernel exploit writers for neutering SELinux with a single kernel write
> vulnerability. OTOH, they already have selinux_state.enforcing and friends,
> and this new one would only be if SECURITY_SELINUX_DISABLE=y.

Yeah, I agree here -- we specifically do not want there to be a trivial
way to disable LSMs at runtime. CONFIG_SECURITY_SELINUX_DISABLE should
be considered deprecated IMO, and we don't want to widen its features.

-Kees

> 
> > 
> > Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> > 
> > This is an alternative to [1]. It turned out to be less simple than I
> > had hoped, but OTOH the hook arrays can now be unconditionally made
> > __ro_after_init so may be still worth it.
> > 
> > Compile- and boot- tested with SECURITY_SELINUX_DISABLE set to =y and
> > =n; SELinux enabled. Changes to other LSMs only compile-tested (but
> > those are trivial).
> > 
> > [1] https://lore.kernel.org/selinux/20191209075756.123157-1-omosnace@redhat.com/T/
> > 
> >   include/linux/lsm_hooks.h    | 46 +++++++++----------------------
> >   security/Kconfig             |  5 ----
> >   security/apparmor/lsm.c      | 14 ++++++----
> >   security/commoncap.c         | 11 +++++---
> >   security/loadpin/loadpin.c   | 10 +++++--
> >   security/lockdown/lockdown.c | 11 +++++---
> >   security/safesetid/lsm.c     |  9 +++++--
> >   security/security.c          | 52 +++++++++++++++++++++---------------
> >   security/selinux/Kconfig     |  5 ++--
> >   security/selinux/hooks.c     | 28 ++++++++++++++-----
> >   security/smack/smack_lsm.c   | 11 +++++---
> >   security/tomoyo/tomoyo.c     | 13 ++++++---
> >   security/yama/yama_lsm.c     | 10 +++++--
> >   13 files changed, 133 insertions(+), 92 deletions(-)
> > 
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 20d8cf194fb7..91b77ebcb822 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -27,7 +27,6 @@
> >   #include <linux/security.h>
> >   #include <linux/init.h>
> > -#include <linux/rculist.h>
> >   /**
> >    * union security_list_options - Linux Security Module hook function list
> > @@ -2086,6 +2085,9 @@ struct security_hook_list {
> >   	struct hlist_head		*head;
> >   	union security_list_options	hook;
> >   	char				*lsm;
> > +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> > +	const int			*enabled;
> > +#endif
> >   } __randomize_layout;
> >   /*
> > @@ -2112,8 +2114,16 @@ struct lsm_blob_sizes {
> >   extern struct security_hook_heads security_hook_heads;
> >   extern char *lsm_names;
> > -extern void security_add_hooks(struct security_hook_list *hooks, int count,
> > -				char *lsm);
> > +struct security_hook_array {
> > +	struct security_hook_list *hooks;
> > +	int count;
> > +	char *lsm;
> > +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> > +	const int *enabled;
> > +#endif
> > +};
> > +
> > +extern void security_add_hook_array(const struct security_hook_array *array);
> >   #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
> >   #define LSM_FLAG_EXCLUSIVE	BIT(1)
> > @@ -2145,36 +2155,6 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> >   		__used __section(.early_lsm_info.init)			\
> >   		__aligned(sizeof(unsigned long))
> > -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> > -/*
> > - * Assuring the safety of deleting a security module is up to
> > - * the security module involved. This may entail ordering the
> > - * module's hook list in a particular way, refusing to disable
> > - * the module once a policy is loaded or any number of other
> > - * actions better imagined than described.
> > - *
> > - * The name of the configuration option reflects the only module
> > - * that currently uses the mechanism. Any developer who thinks
> > - * disabling their module is a good idea needs to be at least as
> > - * careful as the SELinux team.
> > - */
> > -static inline void security_delete_hooks(struct security_hook_list *hooks,
> > -						int count)
> > -{
> > -	int i;
> > -
> > -	for (i = 0; i < count; i++)
> > -		hlist_del_rcu(&hooks[i].list);
> > -}
> > -#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
> > -
> > -/* Currently required to handle SELinux runtime hook disable. */
> > -#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> > -#define __lsm_ro_after_init
> > -#else
> > -#define __lsm_ro_after_init	__ro_after_init
> > -#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
> > -
> >   extern int lsm_inode_alloc(struct inode *inode);
> >   #endif /* ! __LINUX_LSM_HOOKS_H */
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 2a1a2d396228..456764990a13 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -32,11 +32,6 @@ config SECURITY
> >   	  If you are unsure how to answer this question, answer N.
> > -config SECURITY_WRITABLE_HOOKS
> > -	depends on SECURITY
> > -	bool
> > -	default n
> > -
> >   config SECURITYFS
> >   	bool "Enable the securityfs filesystem"
> >   	help
> > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > index b621ad74f54a..a27f48670b37 100644
> > --- a/security/apparmor/lsm.c
> > +++ b/security/apparmor/lsm.c
> > @@ -1158,13 +1158,13 @@ static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff *skb,
> >   /*
> >    * The cred blob is a pointer to, not an instance of, an aa_task_ctx.
> >    */
> > -struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
> > +struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
> >   	.lbs_cred = sizeof(struct aa_task_ctx *),
> >   	.lbs_file = sizeof(struct aa_file_ctx),
> >   	.lbs_task = sizeof(struct aa_task_ctx),
> >   };
> > -static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
> > +static struct security_hook_list apparmor_hooks[] __ro_after_init = {
> >   	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
> >   	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
> >   	LSM_HOOK_INIT(capget, apparmor_capget),
> > @@ -1368,7 +1368,7 @@ static const struct kernel_param_ops param_ops_aaintbool = {
> >   	.get = param_get_aaintbool
> >   };
> >   /* Boot time disable flag */
> > -static int apparmor_enabled __lsm_ro_after_init = 1;
> > +static int apparmor_enabled __ro_after_init = 1;
> >   module_param_named(enabled, apparmor_enabled, aaintbool, 0444);
> >   static int __init apparmor_enabled_setup(char *str)
> > @@ -1829,6 +1829,11 @@ __initcall(apparmor_nf_ip_init);
> >   static int __init apparmor_init(void)
> >   {
> > +	struct security_hook_array hook_array = {
> > +		.hooks = apparmor_hooks,
> > +		.count = ARRAY_SIZE(apparmor_hooks),
> > +		.lsm = "apparmor",
> > +	};
> >   	int error;
> >   	aa_secids_init();
> > @@ -1864,8 +1869,7 @@ static int __init apparmor_init(void)
> >   		aa_free_root_ns();
> >   		goto buffers_out;
> >   	}
> > -	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
> > -				"apparmor");
> > +	security_add_hook_array(&hook_array);
> >   	/* Report that AppArmor successfully initialized */
> >   	apparmor_initialized = 1;
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index f4ee0ae106b2..6e9f4b6b6b1d 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -1339,7 +1339,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
> >   #ifdef CONFIG_SECURITY
> > -static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
> > +static struct security_hook_list capability_hooks[] __ro_after_init = {
> >   	LSM_HOOK_INIT(capable, cap_capable),
> >   	LSM_HOOK_INIT(settime, cap_settime),
> >   	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
> > @@ -1362,8 +1362,13 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
> >   static int __init capability_init(void)
> >   {
> > -	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
> > -				"capability");
> > +	struct security_hook_array hook_array = {
> > +		.hooks = capability_hooks,
> > +		.count = ARRAY_SIZE(capability_hooks),
> > +		.lsm = "capability",
> > +	};
> > +
> > +	security_add_hook_array(&hook_array);
> >   	return 0;
> >   }
> > diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> > index ee5cb944f4ad..5fadd4969d90 100644
> > --- a/security/loadpin/loadpin.c
> > +++ b/security/loadpin/loadpin.c
> > @@ -180,7 +180,7 @@ static int loadpin_load_data(enum kernel_load_data_id id)
> >   	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
> >   }
> > -static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
> > +static struct security_hook_list loadpin_hooks[] __ro_after_init = {
> >   	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
> >   	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
> >   	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
> > @@ -224,10 +224,16 @@ static void __init parse_exclude(void)
> >   static int __init loadpin_init(void)
> >   {
> > +	struct security_hook_array hook_array = {
> > +		.hooks = loadpin_hooks,
> > +		.count = ARRAY_SIZE(loadpin_hooks),
> > +		.lsm = "loadpin",
> > +	};
> > +
> >   	pr_info("ready to pin (currently %senforcing)\n",
> >   		enforce ? "" : "not ");
> >   	parse_exclude();
> > -	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
> > +	security_add_hook_array(&hook_array);
> >   	return 0;
> >   }
> > diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> > index 5a952617a0eb..bcfa0ff4ee63 100644
> > --- a/security/lockdown/lockdown.c
> > +++ b/security/lockdown/lockdown.c
> > @@ -71,19 +71,24 @@ static int lockdown_is_locked_down(enum lockdown_reason what)
> >   	return 0;
> >   }
> > -static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
> > +static struct security_hook_list lockdown_hooks[] __ro_after_init = {
> >   	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
> >   };
> >   static int __init lockdown_lsm_init(void)
> >   {
> > +	struct security_hook_array hook_array = {
> > +		.hooks = lockdown_hooks,
> > +		.count = ARRAY_SIZE(lockdown_hooks),
> > +		.lsm = "lockdown",
> > +	};
> > +
> >   #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
> >   	lock_kernel_down("Kernel configuration", LOCKDOWN_INTEGRITY_MAX);
> >   #elif defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY)
> >   	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
> >   #endif
> > -	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
> > -			   "lockdown");
> > +	security_add_hook_array(&hook_array);
> >   	return 0;
> >   }
> > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > index 7760019ad35d..4e36e53f033d 100644
> > --- a/security/safesetid/lsm.c
> > +++ b/security/safesetid/lsm.c
> > @@ -156,8 +156,13 @@ static struct security_hook_list safesetid_security_hooks[] = {
> >   static int __init safesetid_security_init(void)
> >   {
> > -	security_add_hooks(safesetid_security_hooks,
> > -			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
> > +	struct security_hook_array hook_array = {
> > +		.hooks = safesetid_security_hooks,
> > +		.count = ARRAY_SIZE(safesetid_security_hooks),
> > +		.lsm = "safesetid",
> > +	};
> > +
> > +	security_add_hook_array(&hook_array);
> >   	/* Report that SafeSetID successfully initialized */
> >   	safesetid_initialized = 1;
> > diff --git a/security/security.c b/security/security.c
> > index 2b5473d92416..a5dd348bd37e 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -68,14 +68,14 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
> >   	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
> >   };
> > -struct security_hook_heads security_hook_heads __lsm_ro_after_init;
> > +struct security_hook_heads security_hook_heads __ro_after_init;
> >   static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
> >   static struct kmem_cache *lsm_file_cache;
> >   static struct kmem_cache *lsm_inode_cache;
> >   char *lsm_names;
> > -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> > +static struct lsm_blob_sizes blob_sizes __ro_after_init;
> >   /* Boot-time LSM user choice */
> >   static __initdata const char *chosen_lsm_order;
> > @@ -467,20 +467,20 @@ static int lsm_append(const char *new, char **result)
> >   /**
> >    * security_add_hooks - Add a modules hooks to the hook lists.
> > - * @hooks: the hooks to add
> > - * @count: the number of hooks to add
> > - * @lsm: the name of the security module
> > + * @array: the struct describing hooks to add
> >    *
> >    * Each LSM has to register its hooks with the infrastructure.
> >    */
> > -void __init security_add_hooks(struct security_hook_list *hooks, int count,
> > -				char *lsm)
> > +void __init security_add_hook_array(const struct security_hook_array *array)
> >   {
> >   	int i;
> > -	for (i = 0; i < count; i++) {
> > -		hooks[i].lsm = lsm;
> > -		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
> > +	for (i = 0; i < array->count; i++) {
> > +		array->hooks[i].lsm = array->lsm;
> > +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> > +		array->hooks[i].enabled = array->enabled;
> > +#endif
> > +		hlist_add_tail_rcu(&array->hooks[i].list, array->hooks[i].head);
> >   	}
> >   	/*
> > @@ -488,7 +488,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
> >   	 * and fix this up afterwards.
> >   	 */
> >   	if (slab_is_available()) {
> > -		if (lsm_append(lsm, &lsm_names) < 0)
> > +		if (lsm_append(array->lsm, &lsm_names) < 0)
> >   			panic("%s - Cannot get early memory.\n", __func__);
> >   	}
> >   }
> > @@ -679,11 +679,22 @@ static void __init lsm_early_task(struct task_struct *task)
> >    *	This is a hook that returns a value.
> >    */
> > +#define for_each_hook(p, func) \
> > +	hlist_for_each_entry(p, &security_hook_heads.func, list)
> > +
> > +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> > +#define for_each_enabled_hook(p, func) \
> > +	for_each_hook(p, func) \
> > +		if (!(p)->enabled || READ_ONCE(*(p)->enabled))
> > +#else
> > +#define for_each_enabled_hook for_each_hook
> > +#endif
> > +
> >   #define call_void_hook(FUNC, ...)				\
> >   	do {							\
> >   		struct security_hook_list *P;			\
> >   								\
> > -		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
> > +		for_each_enabled_hook(P, FUNC)			\
> >   			P->hook.FUNC(__VA_ARGS__);		\
> >   	} while (0)
> > @@ -692,7 +703,7 @@ static void __init lsm_early_task(struct task_struct *task)
> >   	do {							\
> >   		struct security_hook_list *P;			\
> >   								\
> > -		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> > +		for_each_enabled_hook(P, FUNC) {		\
> >   			RC = P->hook.FUNC(__VA_ARGS__);		\
> >   			if (RC != 0)				\
> >   				break;				\
> > @@ -795,7 +806,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
> >   	 * agree that it should be set it will. If any module
> >   	 * thinks it should not be set it won't.
> >   	 */
> > -	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
> > +	for_each_enabled_hook(hp, vm_enough_memory) {
> >   		rc = hp->hook.vm_enough_memory(mm, pages);
> >   		if (rc <= 0) {
> >   			cap_sys_admin = 0;
> > @@ -1343,7 +1354,7 @@ int security_inode_getsecurity(struct inode *inode, const char *name, void **buf
> >   	/*
> >   	 * Only one module will provide an attribute with a given name.
> >   	 */
> > -	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
> > +	for_each_enabled_hook(hp, inode_getsecurity) {
> >   		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
> >   		if (rc != -EOPNOTSUPP)
> >   			return rc;
> > @@ -1361,7 +1372,7 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
> >   	/*
> >   	 * Only one module will provide an attribute with a given name.
> >   	 */
> > -	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
> > +	for_each_enabled_hook(hp, inode_setsecurity) {
> >   		rc = hp->hook.inode_setsecurity(inode, name, value, size,
> >   								flags);
> >   		if (rc != -EOPNOTSUPP)
> > @@ -1744,7 +1755,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> >   	int rc = -ENOSYS;
> >   	struct security_hook_list *hp;
> > -	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
> > +	for_each_enabled_hook(hp, task_prctl) {
> >   		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
> >   		if (thisrc != -ENOSYS) {
> >   			rc = thisrc;
> > @@ -1913,7 +1924,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
> >   {
> >   	struct security_hook_list *hp;
> > -	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
> > +	for_each_enabled_hook(hp, getprocattr) {
> >   		if (lsm != NULL && strcmp(lsm, hp->lsm))
> >   			continue;
> >   		return hp->hook.getprocattr(p, name, value);
> > @@ -1926,7 +1937,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
> >   {
> >   	struct security_hook_list *hp;
> > -	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
> > +	for_each_enabled_hook(hp, setprocattr) {
> >   		if (lsm != NULL && strcmp(lsm, hp->lsm))
> >   			continue;
> >   		return hp->hook.setprocattr(name, value, size);
> > @@ -2327,8 +2338,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
> >   	 * For speed optimization, we explicitly break the loop rather than
> >   	 * using the macro
> >   	 */
> > -	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
> > -				list) {
> > +	for_each_enabled_hook(hp, xfrm_state_pol_flow_match) {
> >   		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
> >   		break;
> >   	}
> > diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> > index 996d35d950f7..f64290de1f8a 100644
> > --- a/security/selinux/Kconfig
> > +++ b/security/selinux/Kconfig
> > @@ -26,7 +26,6 @@ config SECURITY_SELINUX_BOOTPARAM
> >   config SECURITY_SELINUX_DISABLE
> >   	bool "NSA SELinux runtime disable"
> >   	depends on SECURITY_SELINUX
> > -	select SECURITY_WRITABLE_HOOKS
> >   	default n
> >   	help
> >   	  This option enables writing to a selinuxfs node 'disable', which
> > @@ -37,8 +36,8 @@ config SECURITY_SELINUX_DISABLE
> >   	  portability across platforms where boot parameters are difficult
> >   	  to employ.
> > -	  NOTE: selecting this option will disable the '__ro_after_init'
> > -	  kernel hardening feature for security hooks.   Please consider
> > +	  NOTE: Selecting this option might cause memory leaks and random
> > +	  crashes when the runtime disable is used. Please consider
> >   	  using the selinux=0 boot parameter instead of enabling this
> >   	  option.
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 47626342b6e5..b76acd98dda5 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -123,7 +123,13 @@ __setup("enforcing=", enforcing_setup);
> >   #define selinux_enforcing_boot 1
> >   #endif
> > -int selinux_enabled __lsm_ro_after_init = 1;
> > +/* Currently required to handle SELinux runtime hook disable. */
> > +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> > +int selinux_enabled = 1;
> > +#else
> > +int selinux_enabled __ro_after_init = 1;
> > +#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
> > +
> >   #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
> >   static int __init selinux_enabled_setup(char *str)
> >   {
> > @@ -6827,7 +6833,7 @@ static int selinux_lockdown(enum lockdown_reason what)
> >   				    LOCKDOWN__CONFIDENTIALITY, &ad);
> >   }
> > -struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
> > +struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
> >   	.lbs_cred = sizeof(struct task_security_struct),
> >   	.lbs_file = sizeof(struct file_security_struct),
> >   	.lbs_inode = sizeof(struct inode_security_struct),
> > @@ -6896,7 +6902,7 @@ static int selinux_perf_event_write(struct perf_event *event)
> >   }
> >   #endif
> > -static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> > +static struct security_hook_list selinux_hooks[] __ro_after_init = {
> >   	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
> >   	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
> >   	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
> > @@ -7145,6 +7151,15 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> >   static __init int selinux_init(void)
> >   {
> > +	struct security_hook_array hook_array = {
> > +		.hooks = selinux_hooks,
> > +		.count = ARRAY_SIZE(selinux_hooks),
> > +		.lsm = "selinux",
> > +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> > +		.enabled = &selinux_enabled,
> > +#endif
> > +	};
> > +
> >   	pr_info("SELinux:  Initializing.\n");
> >   	memset(&selinux_state, 0, sizeof(selinux_state));
> > @@ -7166,7 +7181,7 @@ static __init int selinux_init(void)
> >   	hashtab_cache_init();
> > -	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
> > +	security_add_hook_array(&hook_array);
> >   	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
> >   		panic("SELinux: Unable to register AVC netcache callback\n");
> > @@ -7319,9 +7334,10 @@ int selinux_disable(struct selinux_state *state)
> >   	pr_info("SELinux:  Disabled at runtime.\n");
> > -	selinux_enabled = 0;
> > +	/* Unregister netfilter hooks. */
> > +	selinux_nf_ip_exit();
> > -	security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
> > +	WRITE_ONCE(selinux_enabled, 0);
> >   	/* Try to destroy the avc node cache */
> >   	avc_disable();
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index ecea41ce919b..c21dda12bc4b 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -4583,7 +4583,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
> >   	return 0;
> >   }
> > -struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
> > +struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
> >   	.lbs_cred = sizeof(struct task_smack),
> >   	.lbs_file = sizeof(struct smack_known *),
> >   	.lbs_inode = sizeof(struct inode_smack),
> > @@ -4591,7 +4591,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
> >   	.lbs_msg_msg = sizeof(struct smack_known *),
> >   };
> > -static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
> > +static struct security_hook_list smack_hooks[] __ro_after_init = {
> >   	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
> >   	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
> >   	LSM_HOOK_INIT(syslog, smack_syslog),
> > @@ -4765,6 +4765,11 @@ static __init void init_smack_known_list(void)
> >    */
> >   static __init int smack_init(void)
> >   {
> > +	struct security_hook_array hook_array = {
> > +		.hooks = smack_hooks,
> > +		.count = ARRAY_SIZE(smack_hooks),
> > +		.lsm = "smack",
> > +	};
> >   	struct cred *cred = (struct cred *) current->cred;
> >   	struct task_smack *tsp;
> > @@ -4787,7 +4792,7 @@ static __init int smack_init(void)
> >   	/*
> >   	 * Register with LSM
> >   	 */
> > -	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
> > +	security_add_hook_array(&hook_array);
> >   	smack_enabled = 1;
> >   	pr_info("Smack:  Initializing.\n");
> > diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> > index 716c92ec941a..a4075379246d 100644
> > --- a/security/tomoyo/tomoyo.c
> > +++ b/security/tomoyo/tomoyo.c
> > @@ -486,7 +486,7 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
> >   	return tomoyo_socket_sendmsg_permission(sock, msg, size);
> >   }
> > -struct lsm_blob_sizes tomoyo_blob_sizes __lsm_ro_after_init = {
> > +struct lsm_blob_sizes tomoyo_blob_sizes __ro_after_init = {
> >   	.lbs_task = sizeof(struct tomoyo_task),
> >   };
> > @@ -533,7 +533,7 @@ static void tomoyo_task_free(struct task_struct *task)
> >    * tomoyo_security_ops is a "struct security_operations" which is used for
> >    * registering TOMOYO.
> >    */
> > -static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
> > +static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
> >   	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
> >   	LSM_HOOK_INIT(bprm_committed_creds, tomoyo_bprm_committed_creds),
> >   	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
> > @@ -569,7 +569,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
> >   /* Lock for GC. */
> >   DEFINE_SRCU(tomoyo_ss);
> > -int tomoyo_enabled __lsm_ro_after_init = 1;
> > +int tomoyo_enabled __ro_after_init = 1;
> >   /**
> >    * tomoyo_init - Register TOMOYO Linux as a LSM module.
> > @@ -578,10 +578,15 @@ int tomoyo_enabled __lsm_ro_after_init = 1;
> >    */
> >   static int __init tomoyo_init(void)
> >   {
> > +	struct security_hook_array hook_array = {
> > +		.hooks = tomoyo_hooks,
> > +		.count = ARRAY_SIZE(tomoyo_hooks),
> > +		.lsm = "tomoyo",
> > +	};
> >   	struct tomoyo_task *s = tomoyo_task(current);
> >   	/* register ourselves with the security framework */
> > -	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
> > +	security_add_hook_array(&hook_array);
> >   	pr_info("TOMOYO Linux initialized\n");
> >   	s->domain_info = &tomoyo_kernel_domain;
> >   	atomic_inc(&tomoyo_kernel_domain.users);
> > diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> > index 94dc346370b1..ed752f6eafcf 100644
> > --- a/security/yama/yama_lsm.c
> > +++ b/security/yama/yama_lsm.c
> > @@ -421,7 +421,7 @@ static int yama_ptrace_traceme(struct task_struct *parent)
> >   	return rc;
> >   }
> > -static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
> > +static struct security_hook_list yama_hooks[] __ro_after_init = {
> >   	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
> >   	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
> >   	LSM_HOOK_INIT(task_prctl, yama_task_prctl),
> > @@ -476,8 +476,14 @@ static inline void yama_init_sysctl(void) { }
> >   static int __init yama_init(void)
> >   {
> > +	struct security_hook_array hook_array = {
> > +		.hooks = yama_hooks,
> > +		.count = ARRAY_SIZE(yama_hooks),
> > +		.lsm = "yama",
> > +	};
> > +
> >   	pr_info("Yama: becoming mindful.\n");
> > -	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
> > +	security_add_hook_array(&hook_array);
> >   	yama_init_sysctl();
> >   	return 0;
> >   }
> > 
> 

-- 
Kees Cook
