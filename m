Return-Path: <linux-security-module+bounces-2241-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F282F88178B
	for <lists+linux-security-module@lfdr.de>; Wed, 20 Mar 2024 19:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51855B2344F
	for <lists+linux-security-module@lfdr.de>; Wed, 20 Mar 2024 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774FF85C43;
	Wed, 20 Mar 2024 18:49:34 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5520C8565E
	for <linux-security-module@vger.kernel.org>; Wed, 20 Mar 2024 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960574; cv=none; b=uUwcxdldf/3cggRHI4dhLU+n69XA4qgxH3+cOZ8Y1XO0X9p18KWb0QHh4XO82IrkD0M8b/+O3FX/Avhi1pjd2c0IHok8oUtactmmSQ+kUCBgc3G79gU62j4Vag4QsAQMsVIzIYT+DeLiB7RqkzXRuDS7Ur7YxgxtxQhBypXGpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960574; c=relaxed/simple;
	bh=kmw01scbYLdXBI2JxgkAuLFMOeAqSg+hTh9USnJMU3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2ayvKINakAUOv6hgHh6Ygky613497n41P0c0Ohk7UUqSmtkP5JnO0dvY+QCGsWJrrOJ/XsRTFzJAD9Rl6SBPECcwoq3DLub20JZJusnXJmBssvpbNyTrn+7UWJeSGV5awanGbwS0iUuVF1W8ylSnODg9iGsbddcdkkkCcMAE0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so119035b6e.3
        for <linux-security-module@vger.kernel.org>; Wed, 20 Mar 2024 11:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710960570; x=1711565370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9PP/b7LVNfeGfffYjCgY25nENsU1ANo/gyFk0VU0ck=;
        b=fj41wN+JPvkDVo3q8AUgrVWlrvzmsgPbz3Xgk7DqhBIEhYibruG/FktVtiOQl7uYof
         ApLtTxi1LjC9vU3t+J+ZkCaoAhFIz9XwiuyhnuYP5DyIJiVmbvCllQas+BvN6fePE0l2
         +n5UVcJHvheRx2uy+cFDBaXNSehHXFJ3DMrFlC4OtaLuJ4KaWCWS3fCWdJYQ18shkGX/
         9pzOnOKHyDxKqSUovf8qR6gxXM+lSZxPe+MpO8uojA/tdewb6gioEbc8FVZS2SjIcUhU
         pqMY8QrLEvD/+Bn7Rr8Ttais7eUJki8EuPOD22y2bkFnoYOA2L5rYSa2hWRijjhO7VeK
         o9ww==
X-Forwarded-Encrypted: i=1; AJvYcCVEr+qULXxipiIE7BZIh8SaO1pwp6TkAsYWe5Gj+7ZoMnzWUViLEfk9NhjruFgX7VR0h+kVwFXhDj0MZnRcfteXFfWeORZFhBWIYHnzhY7RXILhIYYF
X-Gm-Message-State: AOJu0YyBvr3LBzmiOTseltZ0ixCSISciBcv3pTICet9mazejibfP+JIr
	I4WZUXadYkgMHNIhWtiFZm1KqN9KfMk901zpGZv+Svozm6APYtPbhHXopx3s7Q==
X-Google-Smtp-Source: AGHT+IEI5XIxQAsJwMJBVy6HIG87bY5j8Fl4cBm3lf9Nu6m5xZh6kuyb1Sq2oWIje0IU3cTQ/ZITiw==
X-Received: by 2002:a05:6808:490:b0:3c3:7caa:2417 with SMTP id z16-20020a056808049000b003c37caa2417mr12982713oid.58.1710960570360;
        Wed, 20 Mar 2024 11:49:30 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 1-20020a05621420a100b006961c9a2ed8sm4048594qvd.47.2024.03.20.11.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:49:29 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:49:28 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com,
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu,
	ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com,
	eparis@redhat.com, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH RFC v15 14/21] dm verity: consume root hash digest and
 signature data via LSM hook
Message-ID: <ZfsvuPn6fAaG85er@redhat.com>
References: <1710560151-28904-15-git-send-email-wufan@linux.microsoft.com>
 <657b73a0cf531fd4291a0f780d2fcf78@paul-moore.com>
 <ZfpHxkmRy0oqxZVF@redhat.com>
 <CAHC9VhTkpSa665tesTEs8gBjaD3ahUMATGMXuGy+-unt7WL-UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTkpSa665tesTEs8gBjaD3ahUMATGMXuGy+-unt7WL-UQ@mail.gmail.com>

On Wed, Mar 20 2024 at  1:23P -0400,
Paul Moore <paul@paul-moore.com> wrote:

> On Tue, Mar 19, 2024 at 10:19 PM Mike Snitzer <snitzer@kernel.org> wrote:
> > On Tue, Mar 19 2024 at  7:00P -0400,
> > Paul Moore <paul@paul-moore.com> wrote:
> > > On Mar 15, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> > > >
> > > > dm-verity provides a strong guarantee of a block device's integrity. As
> > > > a generic way to check the integrity of a block device, it provides
> > > > those integrity guarantees to its higher layers, including the filesystem
> > > > level.
> > > >
> > > > An LSM that control access to a resource on the system based on the
> > > > available integrity claims can use this transitive property of
> > > > dm-verity, by querying the underlying block_device of a particular
> > > > file.
> > > >
> > > > The digest and signature information need to be stored in the block
> > > > device to fulfill the next requirement of authorization via LSM policy.
> > > > This will enable the LSM to perform revocation of devices that are still
> > > > mounted, prohibiting execution of files that are no longer authorized
> > > > by the LSM in question.
> > > >
> > > > This patch adds two security hook calls in dm-verity to save the
> > > > dm-verity roothash and the roothash signature to the block device's
> > > > LSM blobs. The hook calls are depended on CONFIG_IPE_PROP_DM_VERITY,
> > > > which will be introduced in the next commit.
> > > >
> > > > Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> > > > Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> > > > ---
> > > > v2:
> > > >   + No Changes
> > > >
> > > > v3:
> > > >   + No changes
> > > >
> > > > v4:
> > > >   + No changes
> > > >
> > > > v5:
> > > >   + No changes
> > > >
> > > > v6:
> > > >   + Fix an improper cleanup that can result in
> > > >     a leak
> > > >
> > > > v7:
> > > >   + Squash patch 08/12, 10/12 to [11/16]
> > > >   + Use part0 for block_device, to retrieve the block_device, when
> > > >     calling security_bdev_setsecurity
> > > >
> > > > v8:
> > > >   + Undo squash of 08/12, 10/12 - separating drivers/md/ from
> > > >     security/ & block/
> > > >   + Use common-audit function for dmverity_signature.
> > > >   + Change implementation for storing the dm-verity digest to use the
> > > >     newly introduced dm_verity_digest structure introduced in patch
> > > >     14/20.
> > > >   + Create new structure, dm_verity_digest, containing digest algorithm,
> > > >     size, and digest itself to pass to the LSM layer. V7 was missing the
> > > >     algorithm.
> > > >   + Create an associated public header containing this new structure and
> > > >     the key values for the LSM hook, specific to dm-verity.
> > > >   + Additional information added to commit, discussing the layering of
> > > >     the changes and how the information passed will be used.
> > > >
> > > > v9:
> > > >   + No changes
> > > >
> > > > v10:
> > > >   + No changes
> > > >
> > > > v11:
> > > >   + Add an optional field to save signature
> > > >   + Move the security hook call to the new finalize hook
> > > >
> > > > v12:
> > > >   + No changes
> > > >
> > > > v13:
> > > >   + No changes
> > > >
> > > > v14:
> > > >   + Correct code format
> > > >   + Remove unnecessary header and switch to dm_disk()
> > > >
> > > > v15:
> > > >   + Refactor security_bdev_setsecurity() to security_bdev_setintegrity()
> > > >   + Remove unnecessary headers
> > > > ---
> > > >  drivers/md/dm-verity-target.c | 73 +++++++++++++++++++++++++++++++++++
> > > >  drivers/md/dm-verity.h        |  6 +++
> > > >  include/linux/dm-verity.h     | 12 ++++++
> > > >  include/linux/security.h      |  2 +
> > > >  4 files changed, 93 insertions(+)
> > > >  create mode 100644 include/linux/dm-verity.h
> > > >
> > > > diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> > > > index bb5da66da4c1..e94cc6a755d5 100644
> > > > --- a/drivers/md/dm-verity-target.c
> > > > +++ b/drivers/md/dm-verity-target.c
> > > > @@ -22,6 +22,8 @@
> > > >  #include <linux/scatterlist.h>
> > > >  #include <linux/string.h>
> > > >  #include <linux/jump_label.h>
> > > > +#include <linux/security.h>
> > > > +#include <linux/dm-verity.h>
> > > >
> > > >  #define DM_MSG_PREFIX                      "verity"
> > > >
> > > > @@ -1017,6 +1019,38 @@ static void verity_io_hints(struct dm_target *ti, struct queue_limits *limits)
> > > >     blk_limits_io_min(limits, limits->logical_block_size);
> > > >  }
> > > >
> > > > +#ifdef CONFIG_IPE_PROP_DM_VERITY
> > > > +
> > > > +static int verity_init_sig(struct dm_verity *v, const void *sig,
> > > > +                      size_t sig_size)
> > > > +{
> > > > +   v->sig_size = sig_size;
> > > > +   v->root_digest_sig = kmalloc(v->sig_size, GFP_KERNEL);
> > > > +   if (!v->root_digest)
> > > > +           return -ENOMEM;
> > >
> > > Either you meant to copy @sig into @v->root_digest_sig and forgot to
> > > add the code for that, or we don't need to include @sig as a parameter
> > > to this function.  I'm guessing it is the former as it wouldn't make
> > > sense to even have dm_verity::root_digest_sig if we weren't stashing
> > > it here.
> > >
> > > I'd also suggest looking at kmemdup() instead of a kmalloc()/memcpy()
> > > combo.
> > >
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +static void verity_free_sig(struct dm_verity *v)
> > > > +{
> > > > +   kfree(v->root_digest_sig);
> > > > +}
> > > > +#else
> > > > +
> > > > +static inline int verity_init_sig(struct dm_verity *v, const void *sig,
> > > > +                             size_t sig_size)
> > > > +{
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +static inline void verity_free_sig(struct dm_verity *v)
> > > > +{
> > > > +}
> > > > +
> > > > +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> > >
> > > It's been a while since I looked at this patch in the patchset, so
> > > maybe I'm missing something, but in general we don't want CONFIG_XXX
> > > checks in the kernel, outside of security/, that are specific to a
> > > particular LSM (what happens when multiple LSMs need this?).  Please
> > > use CONFIG_SECURITY instead.
> > >
> > > >  static void verity_dtr(struct dm_target *ti)
> > > >  {
> > > >     struct dm_verity *v = ti->private;
> > > > @@ -1035,6 +1069,7 @@ static void verity_dtr(struct dm_target *ti)
> > > >     kfree(v->salt);
> > > >     kfree(v->root_digest);
> > > >     kfree(v->zero_digest);
> > > > +   verity_free_sig(v);
> > > >
> > > >     if (v->tfm)
> > > >             crypto_free_ahash(v->tfm);
> > > > @@ -1434,6 +1469,13 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
> > > >             ti->error = "Root hash verification failed";
> > > >             goto bad;
> > > >     }
> > > > +
> > > > +   r = verity_init_sig(v, verify_args.sig, verify_args.sig_size);
> > > > +   if (r < 0) {
> > > > +           ti->error = "Cannot allocate root digest signature";
> > > > +           goto bad;
> > > > +   }
> > > > +
> > > >     v->hash_per_block_bits =
> > > >             __fls((1 << v->hash_dev_block_bits) / v->digest_size);
> > > >
> > > > @@ -1584,6 +1626,34 @@ int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest, unsigned i
> > > >     return 0;
> > > >  }
> > > >
> > > > +#ifdef CONFIG_IPE_PROP_DM_VERITY
> > > > +
> > > > +static int verity_finalize(struct dm_target *ti)
> > > > +{
> > > > +   struct block_device *bdev;
> > > > +   struct dm_verity_digest root_digest;
> > > > +   struct dm_verity *v;
> > > > +   int r;
> > > > +
> > > > +   v = ti->private;
> > > > +   bdev = dm_disk(dm_table_get_md(ti->table))->part0;
> > > > +   root_digest.digest = v->root_digest;
> > > > +   root_digest.digest_len = v->digest_size;
> > > > +   root_digest.alg = v->alg_name;
> > > > +
> > > > +   r = security_bdev_setintegrity(bdev, LSM_INTGR_DMV_ROOTHASH, &root_digest,
> > > > +                                  sizeof(root_digest));
> > > > +   if (r)
> > > > +           return r;
> > > > +
> > > > +   return security_bdev_setintegrity(bdev,
> > > > +                                     LSM_INTGR_DMV_SIG,
> > > > +                                     v->root_digest_sig,
> > > > +                                     v->sig_size);
> > >
> > > What happens if the second call fails, should we clear the
> > > LSM_INTGR_DMV_ROOTHASH state in the LSM?
> > >
> > > > +}
> > > > +
> > > > +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> > >
> > > See my comments about CONFIG_SECURITY above.  In fact, I would suggest
> > > moving this up into that part of the file so you only need one #ifdef
> > > block relating to CONFIG_SECURITY.
> > >
> > > I would also recommend making a dummy function so we can get rid of
> > > the conditional compilation in @verity_target below.  For example:
> > >
> > >   #ifdef CONFIG_SECURITY
> > >   static int verity_finalize(struct dm_target *ti)
> > >   {
> > >     /* real implementation */
> > >   }
> > >   #else
> > >   static int verity_finalize(struct dm_target *ti)
> > >   {
> > >     return 0;
> > >   }
> > >   #endif /* CONFIG_SECURITY */
> > >
> > > >  static struct target_type verity_target = {
> > > >     .name           = "verity",
> > > >     .features       = DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
> > > > @@ -1596,6 +1666,9 @@ static struct target_type verity_target = {
> > > >     .prepare_ioctl  = verity_prepare_ioctl,
> > > >     .iterate_devices = verity_iterate_devices,
> > > >     .io_hints       = verity_io_hints,
> > > > +#ifdef CONFIG_IPE_PROP_DM_VERITY
> > > > +   .finalize       = verity_finalize,
> > > > +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> > > >  };
> > > >  module_dm(verity);
> > >
> > > If you create a dummy verity_finalize() function like above you can
> > > get rid of the #ifdef checks.
> >
> > Think it is better to leave it as-is, to avoid calling the .finalize
> > hook if it isn't actually needed.
> 
> Fair enough, my personal preference is to minimize Kconfig conditional
> code flow changes such as this, but I understand your point of view
> and device-mapper is your code after all.
> 
> I believe the other issues still need to be addressed, 

Yes.

> but other than that are you generally okay with the new "finalize"
> hook approach? 

I am, not seeing how we could avoid it.

Thanks,
Mike

