Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6F34F8CB
	for <lists+linux-security-module@lfdr.de>; Sun, 23 Jun 2019 00:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFVWyr (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 22 Jun 2019 18:54:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39313 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfFVWyr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 18:54:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so4768173pls.6
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PGlWcUsXGBLFRuKyxTh7tEOokjgpT+8Fdr+oP6PPweU=;
        b=RcuI78NSBQVjb2S/N/sS8/48KaLzoBPIukgmuxDpBI3va/vwdSZhwel0qF3H7YWz1f
         HJwqrZSei62ZISfRsiOeeP8cDlb+eFN7EsxZ0tK9B2Qz+FVDYLErNLwQbwNAcD1AR5Gq
         1vnmqa5Xglkre+ksGQ6npdsTVb2OJ7ul3uRuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PGlWcUsXGBLFRuKyxTh7tEOokjgpT+8Fdr+oP6PPweU=;
        b=avIKoUUITSD6MY2hesCt3cv7EJ/meoquBXZmsCKz864zyFV+VYQqCf03rlgu8IDng/
         z98Q0E4Wu0CKmABD5lU47QsVkj0vhquFSoYaptVhO/RyrpiM/NbqiKUi84jg3zysmItl
         8V9ezmlmnF77/+SIiph439SW0Q1ou6MwqXTKDc7otgIP3knkltyIfK6YD1ow8BeS8Fxy
         AAho0neUZtoSS5fih/D052rybrQEkPLRPwHEtkXrmm3ltYM9ImxTo0hjzve/lU1cNrbR
         R2jLvTISQ26GiZObLt1+vNwFyMipvQsUjqlZBAr6y6aZHUmgjVN+uVL3Um+ZVMPiMPVb
         YZUw==
X-Gm-Message-State: APjAAAW7F+kVJSVUAZsgTGcUXCgdSHc4keqbmXgi77/0WbQl6doyWjVv
        nksl4h7ZLy09PUM+HTzN3ZXyrA==
X-Google-Smtp-Source: APXvYqzTqGCz47YhEEWdJbczApVBhV8geQiIdgmo+Qdktin0JaiJ77ZPn45uwxuRIw10dXyLW4dkmA==
X-Received: by 2002:a17:902:3341:: with SMTP id a59mr108270787plc.186.1561244086332;
        Sat, 22 Jun 2019 15:54:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 12sm6465419pfi.60.2019.06.22.15.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:54:45 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:54:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 18/24] LSM: Use lsmcontext in
 security_dentry_init_security
Message-ID: <201906221554.8AABDE034@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-19-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-19-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 11:52:27AM -0700, Casey Schaufler wrote:
> Change the security_dentry_init_security() interface to
> fill an lsmcontext structure instead of a void * data area
> and a length. The lone caller of this interface is NFS4,
> which may make copies of the data using its own mechanisms.
> A rework of the nfs4 code to use the lsmcontext properly
> is a significant project, so the coward's way out is taken,
> and the lsmcontext data from security_dentry_init_security()
> is copied, then released directly.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/nfs/nfs4proc.c        | 26 ++++++++++++++++----------
>  include/linux/security.h |  7 +++----
>  security/security.c      | 20 ++++++++++++++++----
>  3 files changed, 35 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index af1c0db29c39..952f805965bb 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -113,6 +113,7 @@ static inline struct nfs4_label *
>  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>  	struct iattr *sattr, struct nfs4_label *label)
>  {
> +	struct lsmcontext context;
>  	int err;
>  
>  	if (label == NULL)
> @@ -122,21 +123,26 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>  		return NULL;
>  
>  	err = security_dentry_init_security(dentry, sattr->ia_mode,
> -				&dentry->d_name, (void **)&label->label, &label->len);
> -	if (err == 0)
> -		return label;
> +					    &dentry->d_name, &context);
> +
> +	if (err)
> +		return NULL;
> +
> +	label->label = kmemdup(context.context, context.len, GFP_KERNEL);
> +	if (label->label == NULL)
> +		label = NULL;
> +	else
> +		label->len = context.len;
> +
> +	security_release_secctx(&context);
> +
> +	return label;
>  
> -	return NULL;
>  }
>  static inline void
>  nfs4_label_release_security(struct nfs4_label *label)
>  {
> -	struct lsmcontext scaff; /* scaffolding */
> -
> -	if (label) {
> -		lsmcontext_init(&scaff, label->label, label->len, 0);
> -		security_release_secctx(&scaff);
> -	}
> +	kfree(label->label);
>  }
>  static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
>  {
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 3cbe43db16f5..2a2785a4e752 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -348,8 +348,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>  int security_add_mnt_opt(const char *option, const char *val,
>  				int len, void **mnt_opts);
>  int security_dentry_init_security(struct dentry *dentry, int mode,
> -					const struct qstr *name, void **ctx,
> -					u32 *ctxlen);
> +					const struct qstr *name,
> +					struct lsmcontext *ctx);
>  int security_dentry_create_files_as(struct dentry *dentry, int mode,
>  					struct qstr *name,
>  					const struct cred *old,
> @@ -720,8 +720,7 @@ static inline void security_inode_free(struct inode *inode)
>  static inline int security_dentry_init_security(struct dentry *dentry,
>  						 int mode,
>  						 const struct qstr *name,
> -						 void **ctx,
> -						 u32 *ctxlen)
> +						 struct lsmcontext *ctx)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/security/security.c b/security/security.c
> index f461ab3fb9c4..842ac65abc08 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -453,6 +453,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  		 * secid in the lsmblob structure.
>  		 */
>  		if (hooks[i].head == &security_hook_heads.audit_rule_match ||
> +		    hooks[i].head ==
> +			&security_hook_heads.dentry_init_security ||
>  		    hooks[i].head == &security_hook_heads.kernel_act_as ||
>  		    hooks[i].head ==
>  			&security_hook_heads.socket_getpeersec_dgram ||
> @@ -1040,11 +1042,21 @@ void security_inode_free(struct inode *inode)
>  }
>  
>  int security_dentry_init_security(struct dentry *dentry, int mode,
> -					const struct qstr *name, void **ctx,
> -					u32 *ctxlen)
> +				  const struct qstr *name,
> +				  struct lsmcontext *cp)
>  {
> -	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
> -				name, ctx, ctxlen);
> +	int *display = current->security;
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
> +			     list)
> +		if (*display == 0 || *display == hp->slot) {

Is this supposed to be == -1 not 0? Isn't 0 an assigned slot?

Otherwise:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> +			cp->slot = hp->slot;
> +			return hp->hook.dentry_init_security(dentry, mode,
> +					name, (void **)&cp->context, &cp->len);
> +		}
> +
> +	return -EOPNOTSUPP;
>  }
>  EXPORT_SYMBOL(security_dentry_init_security);
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
