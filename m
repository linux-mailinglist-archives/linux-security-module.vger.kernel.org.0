Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851DF4F8BD
	for <lists+linux-security-module@lfdr.de>; Sun, 23 Jun 2019 00:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfFVWtm (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 22 Jun 2019 18:49:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36644 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFVWtm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 18:49:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so4769665plt.3
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6vgEBOUryJGdkiisiwbLc9zDcyOQxk56ts/Ms8k80cc=;
        b=cH+EFikW62yen8Yd96DliC2XGI92rrG1pqMduiU3Bw0/LJwdCNg4L4FwkKDaQFwLOd
         JXa+y1Yea19X32YdlAN7F6s6tBKfNAZw/vmw2Q5cU2Mz/fEL+W3aKy1/xnJp/LvfIJp7
         VN/JN+jr15ryt6WGY74FQ+OwEDdCYXYID7lFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6vgEBOUryJGdkiisiwbLc9zDcyOQxk56ts/Ms8k80cc=;
        b=BeejTknAmofwOOxVtZiiJS6JK2n1pZHcwS+QGUeZp5yXKz13abRzyTMIY3Cu1Xg1Cr
         l2x1f/SUri9ZRGKt41BRwaDgaiJUe91kuwCphdq5wM4CsXLRlLIfp/eECZkJXbl/E48H
         2WWdc4Odg17Qwca/+dgPHNfwnZKFdDIBhgGEdOpNs8H2W6/hRDFBY4vAhcgcm5Ha5o3V
         GxssdCR3QB3LvsMogJmNC35vDHVcvhy4EPssHA2GwWuL4mn+qxQN767Yw6XuCUXSMPQZ
         uxRjkqfevmSRTn6F1bR7LkoL/GgXVRqCLIub6Ou0U3oPBO3beTFkbJzi+lZcQgbmec5s
         qSsQ==
X-Gm-Message-State: APjAAAVWSVXNQL6g2N3nNAU5DwFdgvr31pBqyXLF3K1D4Qx4VxsDTwqF
        ZCbu9RGSqIxLAs6PLWi3NsyxEF+FZSs=
X-Google-Smtp-Source: APXvYqxFziCzZAZdhzfNQR3SV7U13y1NIcq4ZVatX5riA03dUVOp7wz1q7V+4P3D44JfpH+O7giiVQ==
X-Received: by 2002:a17:902:8a94:: with SMTP id p20mr120116381plo.312.1561243781035;
        Sat, 22 Jun 2019 15:49:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f186sm7571866pfb.5.2019.06.22.15.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:49:40 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:49:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 11/24] LSM: Use lsmblob in security_task_getsecid
Message-ID: <201906221549.16C9BB21B9@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-12-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-12-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 11:52:20AM -0700, Casey Schaufler wrote:
> Change the security_task_getsecid() interface to fill in
> a lsmblob structure instead of a u32 secid in support of
> LSM stacking. Audit interfaces will need to collect all
> possible secids for possible reporting.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/android/binder.c              |  4 +---
>  include/linux/security.h              |  7 +++---
>  kernel/audit.c                        |  6 ++---
>  kernel/auditfilter.c                  |  4 +---
>  kernel/auditsc.c                      | 22 ++++++++++++------
>  net/netlabel/netlabel_unlabeled.c     |  5 +++-
>  net/netlabel/netlabel_user.h          |  6 ++++-
>  security/integrity/ima/ima_appraise.c |  4 +++-
>  security/integrity/ima/ima_main.c     | 33 +++++++++++++++------------
>  security/security.c                   |  9 +++++---
>  10 files changed, 60 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 1962f6b8abd0..144ac4f1c24f 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3119,11 +3119,9 @@ static void binder_transaction(struct binder_proc *proc,
>  	t->priority = task_nice(current);
>  
>  	if (target_node && target_node->txn_security_ctx) {
> -		u32 secid;
>  		struct lsmblob blob;
>  
> -		security_task_getsecid(proc->tsk, &secid);
> -		lsmblob_init(&blob, secid);
> +		security_task_getsecid(proc->tsk, &blob);
>  		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
>  		if (ret) {
>  			return_error = BR_FAILED_REPLY;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 0d5e172341fc..c5fdaaff8806 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -396,7 +396,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
>  int security_task_setpgid(struct task_struct *p, pid_t pgid);
>  int security_task_getpgid(struct task_struct *p);
>  int security_task_getsid(struct task_struct *p);
> -void security_task_getsecid(struct task_struct *p, u32 *secid);
> +void security_task_getsecid(struct task_struct *p, struct lsmblob *blob);
>  int security_task_setnice(struct task_struct *p, int nice);
>  int security_task_setioprio(struct task_struct *p, int ioprio);
>  int security_task_getioprio(struct task_struct *p);
> @@ -1025,9 +1025,10 @@ static inline int security_task_getsid(struct task_struct *p)
>  	return 0;
>  }
>  
> -static inline void security_task_getsecid(struct task_struct *p, u32 *secid)
> +static inline void security_task_getsecid(struct task_struct *p,
> +					  struct lsmblob *blob)
>  {
> -	*secid = 0;
> +	lsmblob_init(blob, 0);
>  }
>  
>  static inline int security_task_setnice(struct task_struct *p, int nice)
> diff --git a/kernel/audit.c b/kernel/audit.c
> index d0338411d75d..a0205f3c23c7 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2075,14 +2075,12 @@ int audit_log_task_context(struct audit_buffer *ab)
>  	char *ctx = NULL;
>  	unsigned len;
>  	int error;
> -	u32 sid;
>  	struct lsmblob blob;
>  
> -	security_task_getsecid(current, &sid);
> -	if (!sid)
> +	security_task_getsecid(current, &blob);
> +	if (!lsmblob_is_set(&blob))
>  		return 0;
>  
> -	lsmblob_init(&blob, sid);
>  	error = security_secid_to_secctx(&blob, &ctx, &len);
>  	if (error) {
>  		if (error != -EINVAL)
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index da211065160f..76b4c0ca4fd2 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1323,7 +1323,6 @@ int audit_filter(int msgtype, unsigned int listtype)
>  		for (i = 0; i < e->rule.field_count; i++) {
>  			struct audit_field *f = &e->rule.fields[i];
>  			pid_t pid;
> -			u32 sid;
>  			struct lsmblob blob;
>  
>  			switch (f->type) {
> @@ -1354,8 +1353,7 @@ int audit_filter(int msgtype, unsigned int listtype)
>  			case AUDIT_SUBJ_SEN:
>  			case AUDIT_SUBJ_CLR:
>  				if (f->lsm_rule) {
> -					security_task_getsecid(current, &sid);
> -					lsmblob_init(&blob, sid);
> +					security_task_getsecid(current, &blob);
>  					result = security_audit_rule_match(&blob,
>  						   f->type, f->op, f->lsm_rule);
>  				}
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 148733ec3c72..7112fe31684d 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -444,7 +444,6 @@ static int audit_filter_rules(struct task_struct *tsk,
>  {
>  	const struct cred *cred;
>  	int i, need_sid = 1;
> -	u32 sid;
>  	struct lsmblob blob;
>  	unsigned int sessionid;
>  
> @@ -628,10 +627,9 @@ static int audit_filter_rules(struct task_struct *tsk,
>  			   logged upon error */
>  			if (f->lsm_rule) {
>  				if (need_sid) {
> -					security_task_getsecid(tsk, &sid);
> +					security_task_getsecid(tsk, &blob);
>  					need_sid = 0;
>  				}
> -				lsmblob_init(&blob, sid);
>  				result = security_audit_rule_match(&blob,
>  								   f->type,
>  								   f->op,
> @@ -2365,12 +2363,15 @@ int __audit_sockaddr(int len, void *a)
>  void __audit_ptrace(struct task_struct *t)
>  {
>  	struct audit_context *context = audit_context();
> +	struct lsmblob blob;
>  
>  	context->target_pid = task_tgid_nr(t);
>  	context->target_auid = audit_get_loginuid(t);
>  	context->target_uid = task_uid(t);
>  	context->target_sessionid = audit_get_sessionid(t);
> -	security_task_getsecid(t, &context->target_sid);
> +	security_task_getsecid(t, &blob);
> +	/* scaffolding - until target_sid is converted */
> +	context->target_sid = blob.secid[0];
>  	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
>  }
>  
> @@ -2387,6 +2388,7 @@ int audit_signal_info(int sig, struct task_struct *t)
>  	struct audit_aux_data_pids *axp;
>  	struct audit_context *ctx = audit_context();
>  	kuid_t uid = current_uid(), auid, t_uid = task_uid(t);
> +	struct lsmblob blob;
>  
>  	if (auditd_test_task(t) &&
>  	    (sig == SIGTERM || sig == SIGHUP ||
> @@ -2397,7 +2399,9 @@ int audit_signal_info(int sig, struct task_struct *t)
>  			audit_sig_uid = auid;
>  		else
>  			audit_sig_uid = uid;
> -		security_task_getsecid(current, &audit_sig_sid);
> +		security_task_getsecid(current, &blob);
> +		/* scaffolding until audit_sig_sid is converted */
> +		audit_sig_sid = blob.secid[0];
>  	}
>  
>  	if (!audit_signals || audit_dummy_context())
> @@ -2410,7 +2414,9 @@ int audit_signal_info(int sig, struct task_struct *t)
>  		ctx->target_auid = audit_get_loginuid(t);
>  		ctx->target_uid = t_uid;
>  		ctx->target_sessionid = audit_get_sessionid(t);
> -		security_task_getsecid(t, &ctx->target_sid);
> +		security_task_getsecid(t, &blob);
> +		/* scaffolding until target_sid is converted */
> +		ctx->target_sid = blob.secid[0];
>  		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
>  		return 0;
>  	}
> @@ -2431,7 +2437,9 @@ int audit_signal_info(int sig, struct task_struct *t)
>  	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
>  	axp->target_uid[axp->pid_count] = t_uid;
>  	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
> -	security_task_getsecid(t, &axp->target_sid[axp->pid_count]);
> +	security_task_getsecid(t, &blob);
> +	/* scaffolding until target_sid is converted */
> +	axp->target_sid[axp->pid_count] = blob.secid[0];
>  	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
>  	axp->pid_count++;
>  
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 2d8dd5b84457..2294aa9471e6 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -1552,11 +1552,14 @@ int __init netlbl_unlabel_defconf(void)
>  	int ret_val;
>  	struct netlbl_dom_map *entry;
>  	struct netlbl_audit audit_info;
> +	struct lsmblob blob;
>  
>  	/* Only the kernel is allowed to call this function and the only time
>  	 * it is called is at bootup before the audit subsystem is reporting
>  	 * messages so don't worry to much about these values. */
> -	security_task_getsecid(current, &audit_info.secid);
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until audit_info.secid is converted */
> +	audit_info.secid = blob.secid[0];
>  	audit_info.loginuid = GLOBAL_ROOT_UID;
>  	audit_info.sessionid = 0;
>  
> diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
> index 4a397cde1a48..ab88baaaa50d 100644
> --- a/net/netlabel/netlabel_user.h
> +++ b/net/netlabel/netlabel_user.h
> @@ -48,7 +48,11 @@
>  static inline void netlbl_netlink_auditinfo(struct sk_buff *skb,
>  					    struct netlbl_audit *audit_info)
>  {
> -	security_task_getsecid(current, &audit_info->secid);
> +	struct lsmblob blob;
> +
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until secid is converted */
> +	audit_info->secid = blob.secid[0];
>  	audit_info->loginuid = audit_get_loginuid(current);
>  	audit_info->sessionid = audit_get_sessionid(current);
>  }
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 5fb7127bbe68..85c7692fc4a3 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -51,11 +51,13 @@ bool is_ima_appraise_enabled(void)
>  int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
>  {
>  	u32 secid;
> +	struct lsmblob blob;
>  
>  	if (!ima_appraise)
>  		return 0;
>  
> -	security_task_getsecid(current, &secid);
> +	security_task_getsecid(current, &blob);
> +	lsmblob_secid(&blob, &secid);
>  	return ima_match_policy(inode, current_cred(), secid, func, mask,
>  				IMA_APPRAISE | IMA_HASH, NULL);
>  }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 357edd140c09..fefa848cf0c7 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -335,12 +335,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   */
>  int ima_file_mmap(struct file *file, unsigned long prot)
>  {
> -	u32 secid;
> +	struct lsmblob blob;
>  
>  	if (file && (prot & PROT_EXEC)) {
> -		security_task_getsecid(current, &secid);
> -		return process_measurement(file, current_cred(), secid, NULL,
> -					   0, MAY_EXEC, MMAP_CHECK);
> +		security_task_getsecid(current, &blob);
> +		/* scaffolding - until process_measurement changes */
> +		return process_measurement(file, current_cred(), blob.secid[0],
> +					   NULL, 0, MAY_EXEC, MMAP_CHECK);
>  	}
>  
>  	return 0;
> @@ -363,10 +364,12 @@ int ima_bprm_check(struct linux_binprm *bprm)
>  {
>  	int ret;
>  	u32 secid;
> +	struct lsmblob blob;
>  
> -	security_task_getsecid(current, &secid);
> -	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
> -				  MAY_EXEC, BPRM_CHECK);
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until process_measurement changes */
> +	ret = process_measurement(bprm->file, current_cred(), blob.secid[0],
> +				  NULL, 0, MAY_EXEC, BPRM_CHECK);
>  	if (ret)
>  		return ret;
>  
> @@ -387,10 +390,11 @@ int ima_bprm_check(struct linux_binprm *bprm)
>   */
>  int ima_file_check(struct file *file, int mask)
>  {
> -	u32 secid;
> +	struct lsmblob blob;
>  
> -	security_task_getsecid(current, &secid);
> -	return process_measurement(file, current_cred(), secid, NULL, 0,
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until process_measurement changes */
> +	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
>  				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
>  					   MAY_APPEND), FILE_CHECK);
>  }
> @@ -499,7 +503,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  		       enum kernel_read_file_id read_id)
>  {
>  	enum ima_hooks func;
> -	u32 secid;
> +	struct lsmblob blob;
>  
>  	if (!file && read_id == READING_FIRMWARE) {
>  		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> @@ -521,9 +525,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  	}
>  
>  	func = read_idmap[read_id] ?: FILE_CHECK;
> -	security_task_getsecid(current, &secid);
> -	return process_measurement(file, current_cred(), secid, buf, size,
> -				   MAY_READ, func);
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until process_measurement changes */
> +	return process_measurement(file, current_cred(), blob.secid[0], buf,
> +				   size, MAY_READ, func);
>  }
>  
>  /**
> diff --git a/security/security.c b/security/security.c
> index d55f01041f05..1184ef092bce 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1729,10 +1729,13 @@ int security_task_getsid(struct task_struct *p)
>  	return call_int_hook(task_getsid, 0, p);
>  }
>  
> -void security_task_getsecid(struct task_struct *p, u32 *secid)
> +void security_task_getsecid(struct task_struct *p, struct lsmblob *blob)
>  {
> -	*secid = 0;
> -	call_void_hook(task_getsecid, p, secid);
> +	struct security_hook_list *hp;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.task_getsecid, list)
> +		hp->hook.task_getsecid(p, &blob->secid[hp->slot]);
>  }
>  EXPORT_SYMBOL(security_task_getsecid);
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
