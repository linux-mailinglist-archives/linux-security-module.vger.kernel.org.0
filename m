Return-Path: <linux-security-module+bounces-3580-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC98D431B
	for <lists+linux-security-module@lfdr.de>; Thu, 30 May 2024 03:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7E8284BAA
	for <lists+linux-security-module@lfdr.de>; Thu, 30 May 2024 01:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A0C17BA8;
	Thu, 30 May 2024 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gaHMHYSX"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B318054
	for <linux-security-module@vger.kernel.org>; Thu, 30 May 2024 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717033454; cv=none; b=gPyWW28Bd8PAv9ks08fa1lJ1af0hUJlZzdFsNchXtGg7+48D/7+qU4aPzscmtQBX55SKJ2XfrzSxHSBVCGll4WxR/MqyLJas37+CWKzMye8qlpj3NYtCq57H8fLuXriCbtHz6U1Hu8iAKtZly+VsiXW7vqPNADRhQkUlkMWYbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717033454; c=relaxed/simple;
	bh=XlFPj1RXQZAE85eiIkf3uz2oawhmGHw25xz2yWGVjJs=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=eII/pHitr6W6iMsg1tuta56VPkULHgYufahQgd4It5Z8uRu9ZtUqeuKe1S3tDrg3rshFiB4DkH4F5ihdaB2ycfOLCsI80p1L+GaGNVVI05E23CbATPn6ToB0Dkn2PHxZiQvhW2EDle/394WzXPq204lEmlpOBh8xi6vbakQxlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gaHMHYSX; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ae12762134so69236d6.1
        for <linux-security-module@vger.kernel.org>; Wed, 29 May 2024 18:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717033450; x=1717638250; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L4ABwrC5FtgyoOimiqfOWAU5N+FeuMNhCFfwy0UlI8s=;
        b=gaHMHYSX+in2cyNtu69wcpOjh6zbIKonsN3uczQlXv/Y8ThCV5Zk78jJzZqaos8V/F
         AsfNBPXVZ8t4W+F/aCTL7a97EZOPfFbrjpiyTnLxkT/QX8SgkaWaNb0zf8zocJeICNzC
         sSMpWlsiRXyU0xoAZggJ7FUNj0wg/6a4B8OrRqnWm1agsSmUcD/8WmS7o7zi6N/bDxGu
         CVL5SYStQh4fuSxph3Ij+2RV3bTGCETptV0BiCIhdXfymm5GiVfsrcrBiHysZQwVE3W2
         PxMJW8yYVo9cx0VQxxMVZ0WUFOF1vp/0TzrSol8BdFF/dTMykXaGZpIXtqgg5uJozqso
         ddcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717033450; x=1717638250;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4ABwrC5FtgyoOimiqfOWAU5N+FeuMNhCFfwy0UlI8s=;
        b=r4C3BCgfjubv4eyiTAlmLQW5zR6WFKL/U32BuLLrSxQ/I1IMdccW/+kTmh8HBAIzdK
         30XtmNukZuhVJJE7N/SzOy9GzY+4/OsfIyGC93PyOpmMs78vbUOGAUnK5+N6sRsE+Nus
         rjftS/KrZO316nyvHDtuIL4/ocsxBzKCi9LMDSLAMN0Zc6jOeKyUiy9Fx5uYr1yNu9Y1
         bFmqR0ztz2sJBeg3aAQ2u0f4gCdqUxY4HxMiCcT6D4yQr8uaTS370mj1DF3xRzap6Dq6
         jlghYhD9WxLRMqA4VMZjovyEn8mtg5OFK8d2r9N1hFIgYaHakBcpaMOPmx3UJfBQr3yH
         k3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXWP2DLGISf/XhBg13IN4GmXyD1Y7809yQtIcIn9Gp1JM3NBfjKEU6p8o86ldW/00dUPOhTEk9WgnDId+f2gYEJOKMfH5etG4rNjOMocuX/VOFO8gRd
X-Gm-Message-State: AOJu0YyLoxG8abZiDJPmU+g5JgLa05YMD8FgKrbluZMiqK6mnLKST101
	G1h1aq/p9lEUuCGhZKiLGRDAgP8bWWV+HskYQUOhlTWykCAwpePmTxKU3WQb7A==
X-Google-Smtp-Source: AGHT+IHQp0C1crkZOCMGGvX3eqKW4chrG+mKjNt/WRAkCWU4RNMq/9Ztm3BtBFcPUbJ6oSOp3C66DA==
X-Received: by 2002:a05:6214:3f88:b0:6ab:4e10:838f with SMTP id 6a1803df08f44-6ae0ccaddbdmr10799836d6.35.1717033450457;
        Wed, 29 May 2024 18:44:10 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae01ed9967sm4958596d6.72.2024.05.29.18.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 18:44:10 -0700 (PDT)
Date: Wed, 29 May 2024 21:44:09 -0400
Message-ID: <06bb61dc838eeff63bb5f11cea6d4b53@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Fan Wu <wufan@linux.microsoft.com>, Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v19 15/20] fsverity: expose verified fsverity built-in  signatures to LSMs
References: <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>

On May 24, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> This patch enhances fsverity's capabilities to support both integrity and
> authenticity protection by introducing the exposure of built-in
> signatures through a new LSM hook. This functionality allows LSMs,
> e.g. IPE, to enforce policies based on the authenticity and integrity of
> files, specifically focusing on built-in fsverity signatures. It enables
> a policy enforcement layer within LSMs for fsverity, offering granular
> control over the usage of authenticity claims. For instance, a policy
> could be established to permit the execution of all files with verified
> built-in fsverity signatures while restricting kernel module loading
> from specified fsverity files via fsverity digests.
> 
> The introduction of a security_inode_setintegrity() hook call within
> fsverity's workflow ensures that the verified built-in signature of a file
> is exposed to LSMs. This enables LSMs to recognize and label fsverity files
> that contain a verified built-in fsverity signature. This hook is invoked
> subsequent to the fsverity_verify_signature() process, guaranteeing the
> signature's verification against fsverity's keyring. This mechanism is
> crucial for maintaining system security, as it operates in kernel space,
> effectively thwarting attempts by malicious binaries to bypass user space
> stack interactions.
> 
> The second to last commit in this patch set will add a link to the IPE
> documentation in fsverity.rst.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v1-v6:
>   + Not present
> 
> v7:
>   Introduced
> 
> v8:
>   + Split fs/verity/ changes and security/ changes into separate patches
>   + Change signature of fsverity_create_info to accept non-const inode
>   + Change signature of fsverity_verify_signature to accept non-const inode
>   + Don't cast-away const from inode.
>   + Digest functionality dropped in favor of:
>     ("fs-verity: define a function to return the integrity protected
>       file digest")
>   + Reworded commit description and title to match changes.
>   + Fix a bug wherein no LSM implements the particular fsverity @name
>     (or LSM is disabled), and returns -EOPNOTSUPP, causing errors.
> 
> v9:
>   + No changes
> 
> v10:
>   + Rename the signature blob key
>   + Cleanup redundant code
>   + Make the hook call depends on CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> 
> v11:
>   + No changes
> 
> v12:
>   + Add constification to the hook call
> 
> v13:
>   + No changes
> 
> v14:
>   + Add doc/comment to built-in signature verification
> 
> v15:
>   + Add more docs related to IPE
>   + Switch the hook call to security_inode_setintegrity()
> 
> v16:
>   + Explicitly mention "fsverity builtin signatures" in the commit
>     message
>   + Amend documentation in fsverity.rst
>   + Fix format issue
>   + Change enum name
> 
> v17:
>   + Fix various documentation issues
>   + Use new enum name LSM_INT_FSVERITY_BUILTINSIG_VALID
> 
> v18:
>   + Fix typos
>   + Move the inode_setintegrity hook call into fsverity_verify_signature()
> 
> v19:
>   + Cleanup code w.r.t inode_setintegrity hook refactoring
> ---
>  Documentation/filesystems/fsverity.rst | 23 +++++++++++++++++++++--
>  fs/verity/signature.c                  | 18 +++++++++++++++++-
>  include/linux/security.h               |  1 +
>  3 files changed, 39 insertions(+), 3 deletions(-)

...

> diff --git a/fs/verity/signature.c b/fs/verity/signature.c
> index 90c07573dd77..a4ed91c7049f 100644
> --- a/fs/verity/signature.c
> +++ b/fs/verity/signature.c
> @@ -106,6 +111,17 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
>  		return err;
>  	}
>  
> +	err = security_inode_setintegrity(inode,
> +					  LSM_INT_FSVERITY_BUILTINSIG_VALID,
> +					  signature,
> +					  le32_to_cpu(sig_size));

I like this much better without the explicit inode cast :)

> +	if (err) {
> +		fsverity_err(inode, "Error %d exposing file signature to LSMs",
> +			     err);
> +		return err;
> +	}
> +
>  	return 0;
>  }

--
paul-moore.com

