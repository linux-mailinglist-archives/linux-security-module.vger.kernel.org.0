Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10B534F8DC
	for <lists+linux-security-module@lfdr.de>; Sun, 23 Jun 2019 01:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfFVXNk (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 22 Jun 2019 19:13:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36099 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfFVXNk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 19:13:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so4784292plt.3
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 16:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xWSJ0Mi7LeYJOANhEwDd+dfizN3bUqnpAdTQe0Jsg/U=;
        b=gzQGQIgrzqSBscnu9omyCwW15Zxg0vTRCc6MY3eksKF6t4FtXF0+KsftrfHjJcmwDJ
         DKA1/Ogei6vpsVAS8XcTd8RLNyAVrnFCk5kDjlvy3naZ8ZBZ6Q5bBNtDd1zmJnxbXzpy
         R1JXmt6fvwKzVm+Y0z9U+x4lJTDbVNt2PdJhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xWSJ0Mi7LeYJOANhEwDd+dfizN3bUqnpAdTQe0Jsg/U=;
        b=uCRjtxHc/dDfsxzRIXcsmv1qONkKc919ydW6mxLY3tpUuIi8TQsWMy41HopD+W8fF7
         4a7Rc3MLvDws7w9Ou75CAypoQK5WVKO9X7BykJwpbUE6npw0OBaVRiCyGgIR/YuKK5uK
         VjdaI348VZkJ4dJsnVoi6UMyncEC2nhO+xKOVg/O7TfUG+8Nd/F/tVvu/PhwqvvqIcso
         jfh3Fn9/WeCTMo30stEoq17B0qtTn2/4q/vKLJCq1HsKL2uQr0RKGvHc2OeuA9j7rHIm
         ChX4CsS2aOa5eNIeg1irgyplfkm3+NnwSd7RkqSnp+52fC/sJmcb5ohLV4WE6XQmS1nu
         HiRg==
X-Gm-Message-State: APjAAAWopilIV90PjI/F9DEa1U4Fq0R8dcMbUuUwLyu+l1vvaANdfXIQ
        9lJq0gGz9ocJhNUJmVbk/Ar70g==
X-Google-Smtp-Source: APXvYqyq+vaCrLg2kMNUu2zmDvscCoY1O5dC1aZr5dmcPnz9jUcr2M8b5FI7nfwNhmPxKTwZlTYlrA==
X-Received: by 2002:a17:902:9a87:: with SMTP id w7mr30073677plp.221.1561245219533;
        Sat, 22 Jun 2019 16:13:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 131sm10697908pfx.57.2019.06.22.16.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:13:38 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:13:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 22/24] LSM: Return the lsmblob slot on initialization
Message-ID: <201906221613.3443FA528B@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-23-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-23-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 11:52:31AM -0700, Casey Schaufler wrote:
> Return the slot allocated to the calling LSM in the lsmblob
> structure. This can be used to set lsmblobs explicitly for
> netlabel interfaces.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

(I have some thoughts on refactoring the slot assignment, but that
should happen after this series -- it's nothing more than a storage
optimization.)

-Kees

> ---
>  include/linux/lsm_hooks.h  | 4 ++--
>  security/apparmor/lsm.c    | 8 ++++++--
>  security/security.c        | 9 +++++++--
>  security/selinux/hooks.c   | 5 ++++-
>  security/smack/smack_lsm.c | 5 ++++-
>  5 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4d1ddf1a2aa6..ce341bcbce5d 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2068,8 +2068,8 @@ struct lsm_blob_sizes {
>  extern struct security_hook_heads security_hook_heads;
>  extern char *lsm_names;
>  
> -extern void security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm);
> +extern int security_add_hooks(struct security_hook_list *hooks, int count,
> +			      char *lsm);
>  
>  #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
>  #define LSM_FLAG_EXCLUSIVE	BIT(1)
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 2716e7731279..dcbbefbd95ff 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -47,6 +47,9 @@
>  /* Flag indicating whether initialization completed */
>  int apparmor_initialized;
>  
> +/* Slot for the AppArmor secid in the lsmblob structure */
> +int apparmor_lsmblob_slot;
> +
>  DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
>  
>  
> @@ -1678,8 +1681,9 @@ static int __init apparmor_init(void)
>  		aa_free_root_ns();
>  		goto buffers_out;
>  	}
> -	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
> -				"apparmor");
> +	apparmor_lsmblob_slot = security_add_hooks(apparmor_hooks,
> +						   ARRAY_SIZE(apparmor_hooks),
> +						   "apparmor");
>  
>  	/* Report that AppArmor successfully initialized */
>  	apparmor_initialized = 1;
> diff --git a/security/security.c b/security/security.c
> index b2ffcd1f3057..c93a368b697b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -437,9 +437,12 @@ static int lsm_slot __initdata;
>   * Each LSM has to register its hooks with the infrastructure.
>   * If the LSM is using hooks that export secids allocate a slot
>   * for it in the lsmblob.
> + *
> + * Returns the slot number in the lsmblob structure if one is
> + * allocated or LSMBLOB_INVALID if one was not allocated.
>   */
> -void __init security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm)
> +int __init security_add_hooks(struct security_hook_list *hooks, int count,
> +			      char *lsm)
>  {
>  	int slot = LSMBLOB_INVALID;
>  	int i;
> @@ -479,6 +482,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  	}
>  	if (lsm_append(lsm, &lsm_names) < 0)
>  		panic("%s - Cannot get early memory.\n", __func__);
> +
> +	return slot;
>  }
>  
>  int call_lsm_notifier(enum lsm_event event, void *data)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ee840fecfebb..1e09acbf9630 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -103,6 +103,7 @@
>  #include "avc_ss.h"
>  
>  struct selinux_state selinux_state;
> +int selinux_lsmblob_slot;
>  
>  /* SECMARK reference count */
>  static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
> @@ -6877,7 +6878,9 @@ static __init int selinux_init(void)
>  
>  	hashtab_cache_init();
>  
> -	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
> +	selinux_lsmblob_slot = security_add_hooks(selinux_hooks,
> +						  ARRAY_SIZE(selinux_hooks),
> +						  "selinux");
>  
>  	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
>  		panic("SELinux: Unable to register AVC netcache callback\n");
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 3834b751d1e9..273f311fb153 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -60,6 +60,7 @@ static LIST_HEAD(smk_ipv6_port_list);
>  #endif
>  static struct kmem_cache *smack_inode_cache;
>  int smack_enabled;
> +int smack_lsmblob_slot;
>  
>  #define A(s) {"smack"#s, sizeof("smack"#s) - 1, Opt_##s}
>  static struct {
> @@ -4749,7 +4750,9 @@ static __init int smack_init(void)
>  	/*
>  	 * Register with LSM
>  	 */
> -	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
> +	smack_lsmblob_slot = security_add_hooks(smack_hooks,
> +						ARRAY_SIZE(smack_hooks),
> +						"smack");
>  	smack_enabled = 1;
>  
>  	pr_info("Smack:  Initializing.\n");
> -- 
> 2.20.1
> 

-- 
Kees Cook
