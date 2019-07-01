Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDDFA4F8B9
	for <lists+linux-security-module@lfdr.de>; Sun, 23 Jun 2019 00:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFVWs2 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 22 Jun 2019 18:48:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33184 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFVWs1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 18:48:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so5407959pfq.0
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 15:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jWf3tMq6KXMP5NmdheIqaEMtPaufm4kFhjWMlPES0co=;
        b=YZxuas5BoyeV+4dFhguhnFXkT+LGgKIWuYno8VdKbgodqTDRT2gZ+xWTmpjAnbazw7
         e1HIz9zSQDD0vfLdHIqmzz5zh2SneV3wVxnOp0W9xkKUAUJoBrQ26bx5wHAaFSHfSfZS
         V3AImMxa1FJUtj8MxMMOve6Vvld9rN6ZzHIsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jWf3tMq6KXMP5NmdheIqaEMtPaufm4kFhjWMlPES0co=;
        b=jqHN0ce/XNT/I9LRr+cBAUXJzg45RU4MS2IAsZK8kYZh1KzHTQdPVhdAN0+Es88jst
         qP3/eGfLgNkJP5xkdqsWKZupef7JHOcZt8+Er5Jic1ieMTKVt6in5dJKdGaBWYvpRaiU
         s6XSqTZKuEKDyz3fmJmwZCj0IGiDVxJ9D5FUA+l8D5p1mNhD+qe30O2X2lHyPJN1mBul
         zRQTJXmxe0v6Hi+Enl0fhdJBbr8HkUhtrpNrlw3QZxdR3SAADnZUaCc4Mv6R1oKyAxDN
         shJ0BOMsKeJ6US12OhZhenffBkq2uL9CEmXPXLCRKXw1fUeL9NBj/HeewNKq6h6VFi5K
         /C1w==
X-Gm-Message-State: APjAAAXJpRtwzo0hP43beOSKuVLESmnW+QLsUJNRcsP3fcSWxCYv7agQ
        ti+OMx+XUnBlRI3DI6p0T5W6Pw==
X-Google-Smtp-Source: APXvYqyrbHt1R05A4D0a0zZuWbKC0RYGFDQyBq8cJkOe5mHjlVtILv7dQ3mcfFO7hNMTyC7Z4OXZhw==
X-Received: by 2002:a63:5d45:: with SMTP id o5mr25656887pgm.40.1561243706948;
        Sat, 22 Jun 2019 15:48:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s129sm6829454pfb.186.2019.06.22.15.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:48:25 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:48:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 10/24] Use lsmblob in security_ipc_getsecid
Message-ID: <201906221545.43D54F0F@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-11-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-11-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 11:52:19AM -0700, Casey Schaufler wrote:
> There may be more than one LSM that provides IPC data
> for auditing. Change security_ipc_getsecid() to fill in
> a lsmblob structure instead of the u32 secid. The
> audit data structure containing the secid will be updated
> later, so there is a bit of scaffolding here.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

One thought below...

> ---
>  include/linux/security.h | 7 ++++---
>  kernel/auditsc.c         | 5 ++++-
>  security/security.c      | 9 ++++++---
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c6cddeff8a17..0d5e172341fc 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -413,7 +413,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  			unsigned long arg4, unsigned long arg5);
>  void security_task_to_inode(struct task_struct *p, struct inode *inode);
>  int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
> +void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
>  int security_msg_msg_alloc(struct msg_msg *msg);
>  void security_msg_msg_free(struct msg_msg *msg);
>  int security_msg_queue_alloc(struct kern_ipc_perm *msq);
> @@ -1098,9 +1098,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
>  	return 0;
>  }
>  
> -static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
> +static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
> +					 struct lsmblob *blob)
>  {
> -	*secid = 0;
> +	lsmblob_init(blob, 0);
>  }
>  
>  static inline int security_msg_msg_alloc(struct msg_msg *msg)
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d31914088a82..148733ec3c72 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2268,11 +2268,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
>  void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
>  	struct audit_context *context = audit_context();
> +	struct lsmblob blob;
>  	context->ipc.uid = ipcp->uid;
>  	context->ipc.gid = ipcp->gid;
>  	context->ipc.mode = ipcp->mode;
>  	context->ipc.has_perm = 0;
> -	security_ipc_getsecid(ipcp, &context->ipc.osid);
> +	security_ipc_getsecid(ipcp, &blob);
> +	/* scaffolding on the [0] - change "osid" to a lsmblob */
> +	context->ipc.osid = blob.secid[0];
>  	context->type = AUDIT_IPC;
>  }
>  
> diff --git a/security/security.c b/security/security.c
> index 5ab07631df75..d55f01041f05 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1812,10 +1812,13 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
>  	return call_int_hook(ipc_permission, 0, ipcp, flag);
>  }
>  
> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
> +void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
>  {
> -	*secid = 0;
> -	call_void_hook(ipc_getsecid, ipcp, secid);
> +	struct security_hook_list *hp;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list)
> +		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->slot]);

Just for sanity when using hp->slot, it might be good to do something
like this in the places it gets used. Like for here:

	if (!WARN_ON(hp->slot < 0 || hp->slot >= LSMBLOB_COUNT))
		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->slot]);

This _should_ be overkill, but since lists of hooks that trigger slot
assignment is hardcoded, it seems nice to cover any future problems or
mismatches.

-- 
Kees Cook
