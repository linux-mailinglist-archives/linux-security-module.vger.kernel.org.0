Return-Path: <linux-security-module+bounces-2230-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92FF8807F0
	for <lists+linux-security-module@lfdr.de>; Wed, 20 Mar 2024 00:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7F41F22C5F
	for <lists+linux-security-module@lfdr.de>; Tue, 19 Mar 2024 23:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D045FBB1;
	Tue, 19 Mar 2024 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PFa9wgD8"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37DE5FBA6
	for <linux-security-module@vger.kernel.org>; Tue, 19 Mar 2024 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889242; cv=none; b=CGXVeAcyqt+ka3u9ji8v0Japa6TiJkfYR21Z/F47Ksv7HEdFHG9DJRXbxAPYOb/8MNtZRMKxM6KvrWuyLcHkNKMeeYh4CRsWupCSuYFgidAtih7rMy1X0oXfQxSP4SGnM37Cp/HxY16Tjc1sssFcMHOR/Xq4hwtCbnjWzlmgCVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889242; c=relaxed/simple;
	bh=E762NAPS43QjZsYEiULgQrDtRez3B/IFtTzBdbpUG0g=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=nDHwaA2jmmmuwpzhvBT5RKkoNLfvsrkOEVsKqvOsOUepllBShWvIflWs5Wx8JiekWbfbb+yQgVKkd+MFZquZCy3PFQWHMUBkZ8L7pW1JdMK9SJAZBl+ADLNX1UaVFAUIUmBOhHotVXNwkp28KhUWUDyxF0LU05nkhm1cu32D7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PFa9wgD8; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7e05b1ef7caso1251075241.2
        for <linux-security-module@vger.kernel.org>; Tue, 19 Mar 2024 16:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710889239; x=1711494039; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fRAdU1O8uX5eeFQhWDbWRq5mcacOhyVBQ2wPZcKp8BI=;
        b=PFa9wgD8E1YV3bt5olT64XpCslJ1Nfcb06IiBMM0zqArhVZwUt+DC3kNuQBIqohaO7
         baQyBLKD6L4YPdK1kbEV/yOo3zoBeAPXiSosHXPGCjl7HvaaEAAcm+o0m/4PgK1MEx5O
         m14PKzLVViQI/tGZneBZQVQWOVDDU7jnm3UFBhey8TEi73kG8UxAZ0y2mlLILHHk4bsn
         ICf5Y6twYyEseaw5bbISaWnqxqtDcEoi9vZEeFp58uYC17lNTTtGH0yJ31teqaZ7zBTa
         TfHwKa+7XhB21jAgCMqPgsIPFmY0RJA4y5nZvyxVvQs65ELygKT5Vbi/EAAOeBLdL5zv
         MnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710889239; x=1711494039;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRAdU1O8uX5eeFQhWDbWRq5mcacOhyVBQ2wPZcKp8BI=;
        b=LcMd6CcnsvAikni3wUompC6fL9Cj2n2F3iwdl8PU9Kno3crA6GGq9g9GaZoeBTqDhL
         xKEL8i3ekhiIq/bnfYVw6Pb5RwONjKgcyDV5bNtXKSJlO3ORu94KeyUQfmbalUMy63Bq
         7ytihYAAw72nsi4cMBwSVQrM7mt8pd772/K4uF4RZNMfbnmxPSA7zeBdVtiUDL9DTOj2
         LLu5bB9ore2HIWOjFzIeO9BgMVDNJIzkV5SSGaTxIIKd2qzu0uFBWtQ46g42fZ5VTPfK
         mWhHkulweW90nrWTBDQwoGX5dC00dqksy6DSF3WpzMo8KYBc9nxWDwdRPMvGbzcByWoq
         vFNw==
X-Forwarded-Encrypted: i=1; AJvYcCUy58xUYjDk7hmx+qHKGYKdgpvNev276NN3j++/kjFws7KqTkLthm4AHfBl8U1kWEMCktWlpyur9SxeDMoQpGLLQIKXtQTYvcqs8m0fuWH9Qp/Sh45k
X-Gm-Message-State: AOJu0Yyk+zz+fKKYkREektu1uw1FV9zl2f3S7caSzdQ+0JRjTpq36oyL
	BRxR/OSldJtconKqi1e+Ao1TZBDZjNER5bwOyWEAduE3ZCBhnKnIdOv1rWOy4Q==
X-Google-Smtp-Source: AGHT+IFLvS2BXOJOQmUSEklcGu3uEGWwzGt4hPkqhO59SfYS1mmAQ62xUlSvev0sAvO/ERSRfJY83g==
X-Received: by 2002:a05:6102:19cb:b0:473:ac7f:8663 with SMTP id jn11-20020a05610219cb00b00473ac7f8663mr14845218vsb.1.1710889238742;
        Tue, 19 Mar 2024 16:00:38 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690c963f1a4sm6969820qvc.107.2024.03.19.16.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 16:00:38 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:00:37 -0400
Message-ID: <657b73a0cf531fd4291a0f780d2fcf78@paul-moore.com>
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
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>, Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH RFC v15 14/21] dm verity: consume root hash digest and  signature data via LSM hook
References: <1710560151-28904-15-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1710560151-28904-15-git-send-email-wufan@linux.microsoft.com>

On Mar 15, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> dm-verity provides a strong guarantee of a block device's integrity. As
> a generic way to check the integrity of a block device, it provides
> those integrity guarantees to its higher layers, including the filesystem
> level.
> 
> An LSM that control access to a resource on the system based on the
> available integrity claims can use this transitive property of
> dm-verity, by querying the underlying block_device of a particular
> file.
> 
> The digest and signature information need to be stored in the block
> device to fulfill the next requirement of authorization via LSM policy.
> This will enable the LSM to perform revocation of devices that are still
> mounted, prohibiting execution of files that are no longer authorized
> by the LSM in question.
> 
> This patch adds two security hook calls in dm-verity to save the
> dm-verity roothash and the roothash signature to the block device's
> LSM blobs. The hook calls are depended on CONFIG_IPE_PROP_DM_VERITY,
> which will be introduced in the next commit.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v2:
>   + No Changes
> 
> v3:
>   + No changes
> 
> v4:
>   + No changes
> 
> v5:
>   + No changes
> 
> v6:
>   + Fix an improper cleanup that can result in
>     a leak
> 
> v7:
>   + Squash patch 08/12, 10/12 to [11/16]
>   + Use part0 for block_device, to retrieve the block_device, when
>     calling security_bdev_setsecurity
> 
> v8:
>   + Undo squash of 08/12, 10/12 - separating drivers/md/ from
>     security/ & block/
>   + Use common-audit function for dmverity_signature.
>   + Change implementation for storing the dm-verity digest to use the
>     newly introduced dm_verity_digest structure introduced in patch
>     14/20.
>   + Create new structure, dm_verity_digest, containing digest algorithm,
>     size, and digest itself to pass to the LSM layer. V7 was missing the
>     algorithm.
>   + Create an associated public header containing this new structure and
>     the key values for the LSM hook, specific to dm-verity.
>   + Additional information added to commit, discussing the layering of
>     the changes and how the information passed will be used.
> 
> v9:
>   + No changes
> 
> v10:
>   + No changes
> 
> v11:
>   + Add an optional field to save signature
>   + Move the security hook call to the new finalize hook
> 
> v12:
>   + No changes
> 
> v13:
>   + No changes
> 
> v14:
>   + Correct code format
>   + Remove unnecessary header and switch to dm_disk()
> 
> v15:
>   + Refactor security_bdev_setsecurity() to security_bdev_setintegrity()
>   + Remove unnecessary headers
> ---
>  drivers/md/dm-verity-target.c | 73 +++++++++++++++++++++++++++++++++++
>  drivers/md/dm-verity.h        |  6 +++
>  include/linux/dm-verity.h     | 12 ++++++
>  include/linux/security.h      |  2 +
>  4 files changed, 93 insertions(+)
>  create mode 100644 include/linux/dm-verity.h
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index bb5da66da4c1..e94cc6a755d5 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -22,6 +22,8 @@
>  #include <linux/scatterlist.h>
>  #include <linux/string.h>
>  #include <linux/jump_label.h>
> +#include <linux/security.h>
> +#include <linux/dm-verity.h>
>  
>  #define DM_MSG_PREFIX			"verity"
>  
> @@ -1017,6 +1019,38 @@ static void verity_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  	blk_limits_io_min(limits, limits->logical_block_size);
>  }
>  
> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> +
> +static int verity_init_sig(struct dm_verity *v, const void *sig,
> +			   size_t sig_size)
> +{
> +	v->sig_size = sig_size;
> +	v->root_digest_sig = kmalloc(v->sig_size, GFP_KERNEL);
> +	if (!v->root_digest)
> +		return -ENOMEM;

Either you meant to copy @sig into @v->root_digest_sig and forgot to
add the code for that, or we don't need to include @sig as a parameter
to this function.  I'm guessing it is the former as it wouldn't make
sense to even have dm_verity::root_digest_sig if we weren't stashing
it here.

I'd also suggest looking at kmemdup() instead of a kmalloc()/memcpy()
combo.

> +	return 0;
> +}
> +
> +static void verity_free_sig(struct dm_verity *v)
> +{
> +	kfree(v->root_digest_sig);
> +}
> +#else
> +
> +static inline int verity_init_sig(struct dm_verity *v, const void *sig,
> +				  size_t sig_size)
> +{
> +	return 0;
> +}
> +
> +static inline void verity_free_sig(struct dm_verity *v)
> +{
> +}
> +
> +#endif /* CONFIG_IPE_PROP_DM_VERITY */

It's been a while since I looked at this patch in the patchset, so
maybe I'm missing something, but in general we don't want CONFIG_XXX
checks in the kernel, outside of security/, that are specific to a
particular LSM (what happens when multiple LSMs need this?).  Please
use CONFIG_SECURITY instead.

>  static void verity_dtr(struct dm_target *ti)
>  {
>  	struct dm_verity *v = ti->private;
> @@ -1035,6 +1069,7 @@ static void verity_dtr(struct dm_target *ti)
>  	kfree(v->salt);
>  	kfree(v->root_digest);
>  	kfree(v->zero_digest);
> +	verity_free_sig(v);
>  
>  	if (v->tfm)
>  		crypto_free_ahash(v->tfm);
> @@ -1434,6 +1469,13 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  		ti->error = "Root hash verification failed";
>  		goto bad;
>  	}
> +
> +	r = verity_init_sig(v, verify_args.sig, verify_args.sig_size);
> +	if (r < 0) {
> +		ti->error = "Cannot allocate root digest signature";
> +		goto bad;
> +	}
> +
>  	v->hash_per_block_bits =
>  		__fls((1 << v->hash_dev_block_bits) / v->digest_size);
>  
> @@ -1584,6 +1626,34 @@ int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest, unsigned i
>  	return 0;
>  }
>  
> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> +
> +static int verity_finalize(struct dm_target *ti)
> +{
> +	struct block_device *bdev;
> +	struct dm_verity_digest root_digest;
> +	struct dm_verity *v;
> +	int r;
> +
> +	v = ti->private;
> +	bdev = dm_disk(dm_table_get_md(ti->table))->part0;
> +	root_digest.digest = v->root_digest;
> +	root_digest.digest_len = v->digest_size;
> +	root_digest.alg = v->alg_name;
> +
> +	r = security_bdev_setintegrity(bdev, LSM_INTGR_DMV_ROOTHASH, &root_digest,
> +				       sizeof(root_digest));
> +	if (r)
> +		return r;
> +
> +	return security_bdev_setintegrity(bdev,
> +					  LSM_INTGR_DMV_SIG,
> +					  v->root_digest_sig,
> +					  v->sig_size);

What happens if the second call fails, should we clear the
LSM_INTGR_DMV_ROOTHASH state in the LSM?

> +}
> +
> +#endif /* CONFIG_IPE_PROP_DM_VERITY */

See my comments about CONFIG_SECURITY above.  In fact, I would suggest
moving this up into that part of the file so you only need one #ifdef
block relating to CONFIG_SECURITY.

I would also recommend making a dummy function so we can get rid of
the conditional compilation in @verity_target below.  For example:

  #ifdef CONFIG_SECURITY
  static int verity_finalize(struct dm_target *ti)
  {
    /* real implementation */
  }
  #else
  static int verity_finalize(struct dm_target *ti)
  {
    return 0;
  }
  #endif /* CONFIG_SECURITY */

>  static struct target_type verity_target = {
>  	.name		= "verity",
>  	.features	= DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
> @@ -1596,6 +1666,9 @@ static struct target_type verity_target = {
>  	.prepare_ioctl	= verity_prepare_ioctl,
>  	.iterate_devices = verity_iterate_devices,
>  	.io_hints	= verity_io_hints,
> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> +	.finalize	= verity_finalize,
> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
>  };
>  module_dm(verity);

If you create a dummy verity_finalize() function like above you can
get rid of the #ifdef checks.

> diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
> index 20b1bcf03474..6a5b8df5bafd 100644
> --- a/drivers/md/dm-verity.h
> +++ b/drivers/md/dm-verity.h
> @@ -43,6 +43,9 @@ struct dm_verity {
>  	u8 *root_digest;	/* digest of the root block */
>  	u8 *salt;		/* salt: its size is salt_size */
>  	u8 *zero_digest;	/* digest for a zero block */
> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> +	u8 *root_digest_sig;	/* digest signature of the root block */
> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
>  	unsigned int salt_size;
>  	sector_t data_start;	/* data offset in 512-byte sectors */
>  	sector_t hash_start;	/* hash start in blocks */
> @@ -56,6 +59,9 @@ struct dm_verity {
>  	bool hash_failed:1;	/* set if hash of any block failed */
>  	bool use_bh_wq:1;	/* try to verify in BH wq before normal work-queue */
>  	unsigned int digest_size;	/* digest size for the current hash algorithm */
> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> +	unsigned int sig_size;	/* digest signature size */
> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
>  	unsigned int ahash_reqsize;/* the size of temporary space for crypto */
>  	enum verity_mode mode;	/* mode for handling verification errors */
>  	unsigned int corrupted_errs;/* Number of errors for corrupted blocks */

See the previous comments about CONFIG_SECURITY.

> diff --git a/include/linux/dm-verity.h b/include/linux/dm-verity.h
> new file mode 100644
> index 000000000000..a799a8043d85
> --- /dev/null
> +++ b/include/linux/dm-verity.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_DM_VERITY_H
> +#define _LINUX_DM_VERITY_H
> +
> +struct dm_verity_digest {
> +	const char *alg;
> +	const u8 *digest;
> +	size_t digest_len;
> +};
> +
> +#endif /* _LINUX_DM_VERITY_H */
> diff --git a/include/linux/security.h b/include/linux/security.h
> index eaff8868766a..60b40b523d57 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -84,6 +84,8 @@ enum lsm_event {
>  };
>  
>  enum lsm_intgr_type {
> +	LSM_INTGR_DMV_SIG,
> +	LSM_INTGR_DMV_ROOTHASH,
>  	__LSM_INTGR_MAX
>  };
>  
> -- 
> 2.44.0

--
paul-moore.com

