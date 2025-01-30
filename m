Return-Path: <linux-security-module+bounces-8014-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27492A22C0A
	for <lists+linux-security-module@lfdr.de>; Thu, 30 Jan 2025 11:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F1D3A6303
	for <lists+linux-security-module@lfdr.de>; Thu, 30 Jan 2025 10:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD619F120;
	Thu, 30 Jan 2025 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXB+OxBF"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C931BEF77
	for <linux-security-module@vger.kernel.org>; Thu, 30 Jan 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738234664; cv=none; b=jyNduwqwaigHLQVtuk0BY1I2CoPk1U8PtvFj3vJmJr7J2GzW8dmyLOgg3x6nwv2+siWQPUU2jNWxuoTbtUkbHVqjJgsmMAg+qJWjiH7+fGmaVZnGYXdk0kS2SrJtG6sjFKfMgOSr1yMZnuUcEvgazYGnknjxeZUJUS0rBlYHMG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738234664; c=relaxed/simple;
	bh=nNu9Wao+7prXi/lZmkqsyM/BD7Vjd0eXW4mg6ypLdK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhvyjh5ezsFliKApLOfnn1+r6k6fYGIhv3aBnEk/ux1bwvMvBlRIFlvWlLr5HW/S7ZSvQhOB1SLhXPaU4jd4Cb4HZkBwJzrVTAe7KJu6t8fMJTnF11Lq8bBqRrzZ0VlpXdaG0K+WhlqR0km/wq5knYC3cFUjuGuiKQwxs1U3uXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXB+OxBF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9e44654ae3so108501266b.1
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jan 2025 02:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738234661; x=1738839461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4buYOzRn3STaO6q6gOT5tyrD4opUgcG/7dM/VZkAIwU=;
        b=gXB+OxBFJi6AUs+RjuIWleNEHOJI5ToBBhj7tAFTZFT+uLl3uY3O5TAQrhPLZCNpAD
         CIddkVjlXfGiNwL5dgRxaxBpG/aooAGPaRircb3uLcjZ9bcsTQwYd2VHXhwMAWxIqPtH
         ukYK6VdxWx/gUi/wnJEoyO95sAwH94A6bwhu0RpnlcWW9zYx2aYmEZnN94eErUqKpGMd
         Hx1JFS9/rrRLFG+5RhG200NEsvnuLfivsRm5/xu/R6iy8I9EfuzUiqjb269UOKd3QV1U
         kKeropsbO5cR0NJ7czMWJXo3J4g3ef4VKUIuR4nRGH5DS77t0LOs9NYUSopdrkEAPuI2
         13Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738234661; x=1738839461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4buYOzRn3STaO6q6gOT5tyrD4opUgcG/7dM/VZkAIwU=;
        b=vgxqpqYMd3XzzpjvWciUTbtsbGZlAYAPqm6y4dfK2E7/BhX0BinEilG8Obi723HW2e
         UH1CLvsO2YhPDna4jap2D/FbQWAiTOcQQRu6jdCexzYuNjkx2G6QIMAadyRMUrKDHB2w
         CNfb7Lf1PuwfTV+CF7mBxJn4eNIM8Nv38MIOIU5/0jBmEJ72SbLGmiKmiuwfFQ/72Sif
         uGcdzIMr1DtdAzcDJZ2wfGVZ5IcsFz7y9IJ3rbphbjfYl9mjaEjbk1D5sKHJKirqk7s4
         iLTD2T81NBpYY6rTnNxBR/kxSXFQgDY1IsM9u4jLknLGX+wkt2pEkZZR19l1AEUBOJPU
         SGiw==
X-Forwarded-Encrypted: i=1; AJvYcCVeZoqPKQ4eloukZn2g6g+Sqg+hmv8Fg9fKMTbWerLy0D/knPXbBOap6kTeCPgIqsntm5den/iM7nl7ZrPX4gmo4ALojog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzIvPHSr7D4xt8+MuprF9pkGuFnj0VNyhLSQxYvPnuGcbxLYP
	VVQ1kSYzTLCytBmhieiC8CQNnT3QL7MWh2qfcdwEnJpfuynXoVzC4zQWsEliNA==
X-Gm-Gg: ASbGnctvTkx9UxKT43ORBQvnIF+Y0kxf6Fh7YHuoB1C7HmfZTmCgvXQrmDvBBBK6aPW
	F447xvIWfZEu/+2LgqFhsH02YQfr/xwWZot9AMx4RDiKYgIAzBTNZMWOxAtVzJ2m7Zb6aU+syRN
	trvFv8CiDx36wKzhC/Gku6itI8M0TB+GenecRWTNyl4S/P3b98Gp4sVkJwUCiWxiuXBF2drYVjE
	2T/smCf1QoIaDh6rqbc2zERLLE1zYFtZGQbSgal4brnElIysoBCVzUSh/+O1YRFmXNcZbPPL+S8
	qq70ufteEZG/0QK7JiYhAKRaIhQRRyDiQxCk79E5YQrH8Z2h+rTCl8zG9Q==
X-Google-Smtp-Source: AGHT+IFtF+henE/8ZRauZhMwrPj3UgPcvyIRaqNYReNS1dcsHzGE0KZapxpRvfWEVPtVflrXOmEgNw==
X-Received: by 2002:a17:907:94cd:b0:ab6:3633:13e with SMTP id a640c23a62f3a-ab6cfdbd071mr781688366b.41.1738234660778;
        Thu, 30 Jan 2025 02:57:40 -0800 (PST)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723efc45sm871854a12.32.2025.01.30.02.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 02:57:40 -0800 (PST)
Date: Thu, 30 Jan 2025 10:57:35 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kpsingh@kernel.org, liamwisehart@meta.com, shankaran@meta.com
Subject: Re: [PATCH v11 bpf-next 1/7] fs/xattr: bpf: Introduce security.bpf.
 xattr name prefix
Message-ID: <Z5tbH13qK6rLJVUI@google.com>
References: <20250129205957.2457655-1-song@kernel.org>
 <20250129205957.2457655-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129205957.2457655-2-song@kernel.org>

On Wed, Jan 29, 2025 at 12:59:51PM -0800, Song Liu wrote:
> Introduct new xattr name prefix security.bpf., and enable reading these
> xattrs from bpf kfuncs bpf_get_[file|dentry]_xattr().
> 
> As we are on it, correct the comments for return value of
> bpf_get_[file|dentry]_xattr(), i.e. return length the xattr value on
> success.

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/bpf_fs_kfuncs.c         | 19 ++++++++++++++-----
>  include/uapi/linux/xattr.h |  4 ++++
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 3fe9f59ef867..8a65184c8c2c 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -93,6 +93,11 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
>  	return len;
>  }
>  
> +static bool match_security_bpf_prefix(const char *name__str)
> +{
> +	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
> +}

I think this can also just be match_xattr_prefix(const char
*name__str, const char *prefix, size_t len) such that we can do the
same checks for aribitrary xattr prefixes i.e. XATTR_USER_PREFIX,
XATTR_NAME_BPF_LSM.

>  /**
>   * bpf_get_dentry_xattr - get xattr of a dentry
>   * @dentry: dentry to get xattr from
> @@ -101,9 +106,10 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
>   *
>   * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
>   *
> - * For security reasons, only *name__str* with prefix "user." is allowed.
> + * For security reasons, only *name__str* with prefix "user." or
      	  	   	    	 	     	  ^ prefixes
						  
> + * "security.bpf." is allowed.
                      ^ are

Out of curiosity, what is the security reasoning here? This isn't
obvious to me, and I'd like to understand this better. Is it simply
frowned upon to read arbitrary xattr values from the context of a BPF
LSM program, or has it got something to do with the backing xattr
handler that ends up being called once we step into __vfs_getxattr()
and such?  Also, just so that it's clear, I don't have anything
against this allow listing approach either, I just genuinely don't
understand the security implications.

> - * Return: 0 on success, a negative value on error.
> + * Return: length of the xattr value on success, a negative value on error.
>   */
>  __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__str,
>  				     struct bpf_dynptr *value_p)
> @@ -117,7 +123,9 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
>  	if (WARN_ON(!inode))
>  		return -EINVAL;
>  
> -	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> +	/* Allow reading xattr with user. and security.bpf. prefix */
> +	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
> +	    !match_security_bpf_prefix(name__str))

I think it would be cleaner to have single function
i.e. is_allowed_xattr_prefix(const char *name__str) which simply
checks all the allowed xattr prefixes that can be read by this BPF
kfunc.

>  		return -EPERM;
>  
>  	value_len = __bpf_dynptr_size(value_ptr);
> @@ -139,9 +147,10 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
>   *
>   * Get xattr *name__str* of *file* and store the output in *value_ptr*.
>   *
> - * For security reasons, only *name__str* with prefix "user." is allowed.
> + * For security reasons, only *name__str* with prefix "user." or
      	  	   	    	 	     	  ^ prefixes

> + * "security.bpf." is allowed.
      		      ^ are

> - * Return: 0 on success, a negative value on error.
> + * Return: length of the xattr value on success, a negative value on error.
>   */
>  __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
>  				   struct bpf_dynptr *value_p)
> diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
> index 9854f9cff3c6..c7c85bb504ba 100644
> --- a/include/uapi/linux/xattr.h
> +++ b/include/uapi/linux/xattr.h
> @@ -83,6 +83,10 @@ struct xattr_args {
>  #define XATTR_CAPS_SUFFIX "capability"
>  #define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
>  
> +#define XATTR_BPF_LSM_SUFFIX "bpf."
> +#define XATTR_NAME_BPF_LSM (XATTR_SECURITY_PREFIX XATTR_BPF_LSM_SUFFIX)
> +#define XATTR_NAME_BPF_LSM_LEN (sizeof(XATTR_NAME_BPF_LSM) - 1)
> +
>  #define XATTR_POSIX_ACL_ACCESS  "posix_acl_access"
>  #define XATTR_NAME_POSIX_ACL_ACCESS XATTR_SYSTEM_PREFIX XATTR_POSIX_ACL_ACCESS
>  #define XATTR_POSIX_ACL_DEFAULT  "posix_acl_default"
> -- 
> 2.43.5
> 

