Return-Path: <linux-security-module+bounces-658-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375AC816515
	for <lists+linux-security-module@lfdr.de>; Mon, 18 Dec 2023 03:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC11B21A31
	for <lists+linux-security-module@lfdr.de>; Mon, 18 Dec 2023 02:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E029AF;
	Mon, 18 Dec 2023 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KywYHlYq"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128C5399
	for <linux-security-module@vger.kernel.org>; Mon, 18 Dec 2023 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702867869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icPsuqAL/RWdl4k8H9rLPctNnOC70TqFRcsZSRHgwSQ=;
	b=KywYHlYq1qcyR+gLjvvWtZGJWtdGoh7t8KgJJxEJckEC+XSDX/PbfOUbjsmg4dg93Ayzfr
	2BZ+ZdR0r5k8KLIVBG9xiw91nh57qeogcExFQX8dl6x8tQn7/eVIEUBvvpk9S9BPUsXZmR
	MKyxHyDZAPkJCHmlCvz4k8opDmkNLr0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-Zo7z4nO_PuOElH7QO11WOA-1; Sun, 17 Dec 2023 21:51:07 -0500
X-MC-Unique: Zo7z4nO_PuOElH7QO11WOA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28b172aa2e7so3104121a91.0
        for <linux-security-module@vger.kernel.org>; Sun, 17 Dec 2023 18:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702867867; x=1703472667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icPsuqAL/RWdl4k8H9rLPctNnOC70TqFRcsZSRHgwSQ=;
        b=B46sbZS+K30EmJ+DBRKb852jePcrANB/RjtjeoKy0TIRsCibaxW3+mCwfcCZu3HWby
         I4J+3GQOD2Hu9ufEpcD1QHburc34lH07IRQYQrM/fsrUggZTa0fEW37NLNUGNVWguiLk
         GtkpPHEa+3hA7yoFPIeVrj6ZESQc/NazXljPCtq7UlAYIAO8eBZcutFD176rTDf7AZoa
         aNIEfxNjFmztKl+JIQw9vLHfFcO/6bRy5QLtja6mvg9whq/mI+8LK/MpoxgGQj7xDmRA
         bQfmQWjE9ccaKHkJH0orEUaAmzpiMCJ3Zy3DtJRu2oYyL+SrWpXf8VtvZj9uhbkOu4xR
         Zv5w==
X-Gm-Message-State: AOJu0YyZsAZlLEMM2km1YkkZAchHDfjAQdzkzirwf6564f4N2yVDR6dJ
	1YQ9ZNSl9XfJvy93WH/agRUDahGWStRji4OHclfnq8YBx/PrmEY35415AvYrvdYmlaF0+SXgyw1
	ivU+7NdvSPZ0iAAfEHnLOtwA/+s45gwbaRTvc
X-Received: by 2002:a17:90a:5d11:b0:28b:5cd7:84d0 with SMTP id s17-20020a17090a5d1100b0028b5cd784d0mr787986pji.80.1702867866963;
        Sun, 17 Dec 2023 18:51:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTSMKgDq7tWrXVUBSE4n6rbOgKZ8rdwCoNcSXYRmqgQBb7JQJaDMH4IwqxNytcdJeXP3fOsw==
X-Received: by 2002:a17:90a:5d11:b0:28b:5cd7:84d0 with SMTP id s17-20020a17090a5d1100b0028b5cd784d0mr787978pji.80.1702867866663;
        Sun, 17 Dec 2023 18:51:06 -0800 (PST)
Received: from [10.72.113.27] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b0028ad9d801e3sm3696630pjj.46.2023.12.17.18.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 18:51:06 -0800 (PST)
Message-ID: <ab373a38-7800-4056-9ac4-31fef643c6b1@redhat.com>
Date: Mon, 18 Dec 2023 10:50:57 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v39 20/42] LSM: Use lsmcontext in
 security_dentry_init_security
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 mic@digikod.net, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-21-casey@schaufler-ca.com>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20231215221636.105680-21-casey@schaufler-ca.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/16/23 06:16, Casey Schaufler wrote:
> Replace the (secctx,seclen) pointer pair with a single
> lsmcontext pointer to allow return of the LSM identifier
> along with the context and context length. This allows
> security_release_secctx() to know how to release the
> context. Callers have been modified to use or save the
> returned data from the new structure.
>
> Special care is taken in the NFS code, which uses the
> same data structure for its own copied labels as it does
> for the data which comes from security_dentry_init_security().
> In the case of copied labels the data has to be freed, not
> released.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: ceph-devel@vger.kernel.org
> Cc: linux-nfs@vger.kernel.org
> ---
>   fs/ceph/super.h               |  3 +--
>   fs/ceph/xattr.c               | 19 ++++++-------------
>   fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>   fs/nfs/dir.c                  |  2 +-
>   fs/nfs/inode.c                | 17 ++++++++++-------
>   fs/nfs/internal.h             |  8 +++++---
>   fs/nfs/nfs4proc.c             | 22 +++++++++-------------
>   fs/nfs/nfs4xdr.c              | 22 ++++++++++++----------
>   include/linux/lsm_hook_defs.h |  2 +-
>   include/linux/nfs4.h          |  8 ++++----
>   include/linux/nfs_fs.h        |  2 +-
>   include/linux/security.h      |  7 +++----
>   security/security.c           |  9 ++++-----
>   security/selinux/hooks.c      |  9 +++++----
>   14 files changed, 80 insertions(+), 85 deletions(-)
>
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index fe0f64a0acb2..d503cc7478b7 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1133,8 +1133,7 @@ struct ceph_acl_sec_ctx {
>   	void *acl;
>   #endif
>   #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
> -	void *sec_ctx;
> -	u32 sec_ctxlen;
> +	struct lsmcontext lsmctx;
>   #endif
>   #ifdef CONFIG_FS_ENCRYPTION
>   	struct ceph_fscrypt_auth *fscrypt_auth;
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 113956d386c0..4c767a20ac4c 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1383,8 +1383,7 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
>   	int err;
>   
>   	err = security_dentry_init_security(dentry, mode, &dentry->d_name,
> -					    &name, &as_ctx->sec_ctx,
> -					    &as_ctx->sec_ctxlen);
> +					    &name, &as_ctx->lsmctx);
>   	if (err < 0) {
>   		WARN_ON_ONCE(err != -EOPNOTSUPP);
>   		err = 0; /* do nothing */
> @@ -1409,7 +1408,7 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
>   	 */
>   	name_len = strlen(name);
>   	err = ceph_pagelist_reserve(pagelist,
> -				    4 * 2 + name_len + as_ctx->sec_ctxlen);
> +				    4 * 2 + name_len + as_ctx->lsmctx.len);
>   	if (err)
>   		goto out;
>   
> @@ -1429,11 +1428,9 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
>   		as_ctx->pagelist = pagelist;
>   	}
>   
> -	ceph_pagelist_encode_32(pagelist, name_len);
> -	ceph_pagelist_append(pagelist, name, name_len);
> -

Why remove these ?

> -	ceph_pagelist_encode_32(pagelist, as_ctx->sec_ctxlen);
> -	ceph_pagelist_append(pagelist, as_ctx->sec_ctx, as_ctx->sec_ctxlen);
> +	ceph_pagelist_encode_32(pagelist, as_ctx->lsmctx.len);
> +	ceph_pagelist_append(pagelist, as_ctx->lsmctx.context,
> +			     as_ctx->lsmctx.len);
>   
>   
[...]

Thanks,

- Xiubo


