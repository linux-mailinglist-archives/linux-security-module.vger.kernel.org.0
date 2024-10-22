Return-Path: <linux-security-module+bounces-6319-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BAA9AB423
	for <lists+linux-security-module@lfdr.de>; Tue, 22 Oct 2024 18:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2341F23AA2
	for <lists+linux-security-module@lfdr.de>; Tue, 22 Oct 2024 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7279E1BCA01;
	Tue, 22 Oct 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xm75Fo7u"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B01B654C
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614967; cv=none; b=cDSb01EILcLEaxHeO0CD7ZZoF7DeldG4KGiIW4grSeeVzHCEqL87V2zXiHD+/OCjrIOxwXFO1bkyJbTSS6ySOvKlYiSz5ovX5IVWb+oRA4RZEeEziHfGc6ayHVnbkH/db6h1V1+BCxBX8vk3xJJiCzR9cZTJoDhYJPSDtq+wmqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614967; c=relaxed/simple;
	bh=5yuWmOUKZ4Ih5Rq09LpxFOCTv3VM9FGQMb3BvP4KQRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVMcqUstuoa8A3txg+1Gyf7GwZiim0bT2GEszBrzoWEExQqdGdl61FlK6jcIRMdfl9MJq+gRz6VRSLg8yES0Yn1dF6XVGD4pHPBMabfXRDsiIjRt/PiDlELioBeDWH8gF5vH6C+DOqewDzL2/GYmGTRcDPoswGsb4MLUC2tiPGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xm75Fo7u; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e28fea0f5b8so5529619276.1
        for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729614964; x=1730219764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kHdKq4o6U8pickeExw5lIFKL9p1l4H9o3slgOCVYVE=;
        b=Xm75Fo7uAZtg2+ZRZo69HQZlH4/EbtA7+4dpHhLwEg9tk9t1FHILQd7Sirz7wfR2rE
         hlAcolaDdw4U5e+QuGbuS+TKSNilBo3M6PAAyMEJmpz5mb6e7qKbjwWrkWJggwIAT3Kl
         cUIZotkmg6P87U2sVESlejEJQps6AtTXvFCBsf9hoWQpoWKnF1jdoYCF3bO6QuBklAbS
         lcpjCmGoglQzxFp4QkNjni0FSFw1JSxA9SkOhG3XcfOc0OXHH9mNpHqRn9LXvWLrpbP1
         FCoDEoeVFFL1wbddv9x7yzGhnsUfwUQE5HzYjytI+CrlrXCBLU7PGBWbHOo3NaUZMaD1
         L/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614964; x=1730219764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kHdKq4o6U8pickeExw5lIFKL9p1l4H9o3slgOCVYVE=;
        b=GML4csdXbX22nos5PRw5JrUPvZvVaW1Z6x+5sIz+VocqRUD0JdDrJK6LV4WYbz2p+2
         P8rTeo+PVaAkhNqOpdOCLr5454ICqbWJcbzbfZ+s/YfCEuPJRoms7YmmwgmMTJdHjEo6
         N4KT2Y9NSQMX+wZYiyXtClNKcLiCW6JgOuwScBE666RSQykodO3NEvWUSf4FKGYYNXqI
         aDFI64AjChB0EBBTJso/TC4DfY4nl3PUyx5YAhBAfF5ytSG5EMTBg7LhQB8+eaY9L1Qv
         e1ncJtjTkpbohwpbuYFTzH3uhh62auqswzA0NP3DRMEtd2MHpiXXelKcAw/DRonx9vvQ
         xliQ==
X-Gm-Message-State: AOJu0Ywe9vRtUs6/u0ycKTgnWthTmiyDkAiu88/nCQA2vTSX26XykO89
	Yl/u6orj5YDA4pzTM5hApoxyAkyLC1r8RdDRlhCcyVrZgCvEFmkgybPOFMEPs0c8hoFh9wUCGUC
	lJQ0S15eXe5WtwohcTz8nle3OMLKec17BissD
X-Google-Smtp-Source: AGHT+IEibkCXXaIjJ9u3v16H+Mr2NsLiwq+BFSdV6/LvrT71yWId1tZt2dUederqlS/v2vbOxbL74ObTLEGqOowez9c=
X-Received: by 2002:a05:6902:1009:b0:e29:33d1:a3ac with SMTP id
 3f1490d57ef6-e2bb11e5b40mr14407735276.11.1729614963943; Tue, 22 Oct 2024
 09:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014151450.73674-5-casey@schaufler-ca.com>
 <b94aa34a25a19ea729faa1c8240ebf5b@paul-moore.com> <d2d34843-e23c-40a7-92ae-5ebd7c678ad4@schaufler-ca.com>
In-Reply-To: <d2d34843-e23c-40a7-92ae-5ebd7c678ad4@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Oct 2024 12:35:53 -0400
Message-ID: <CAHC9VhS0zagjyqQmN6x=_ftHeeeeF50NW91yY5eEW4RF4sE98g@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] LSM: lsm_context in security_dentry_init_security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:00=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 10/21/2024 4:39 PM, Paul Moore wrote:
> > On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Replace the (secctx,seclen) pointer pair with a single lsm_context
> >> pointer to allow return of the LSM identifier along with the context
> >> and context length. This allows security_release_secctx() to know how
> >> to release the context. Callers have been modified to use or save the
> >> returned data from the new structure.
> >>
> >> Special care is taken in the NFS code, which uses the same data struct=
ure
> >> for its own copied labels as it does for the data which comes from
> >> security_dentry_init_security().  In the case of copied labels the dat=
a
> >> has to be freed, not released.
> >>
> >> The scaffolding funtion lsmcontext_init() is no longer needed and is
> >> removed.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> Cc: ceph-devel@vger.kernel.org
> >> Cc: linux-nfs@vger.kernel.org
> >> ---
> >>  fs/ceph/super.h               |  3 +--
> >>  fs/ceph/xattr.c               | 16 ++++++----------
> >>  fs/fuse/dir.c                 | 35 ++++++++++++++++++----------------=
-
> >>  fs/nfs/dir.c                  |  2 +-
> >>  fs/nfs/inode.c                | 17 ++++++++++-------
> >>  fs/nfs/internal.h             |  8 +++++---
> >>  fs/nfs/nfs4proc.c             | 22 +++++++++-------------
> >>  fs/nfs/nfs4xdr.c              | 22 ++++++++++++----------
> >>  include/linux/lsm_hook_defs.h |  2 +-
> >>  include/linux/nfs4.h          |  8 ++++----
> >>  include/linux/nfs_fs.h        |  2 +-
> >>  include/linux/security.h      | 26 +++-----------------------
> >>  security/security.c           |  9 ++++-----
> >>  security/selinux/hooks.c      |  9 +++++----
> >>  14 files changed, 80 insertions(+), 101 deletions(-)

...

> >> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> >> index 039898d70954..47652d217d05 100644
> >> --- a/include/linux/nfs_fs.h
> >> +++ b/include/linux/nfs_fs.h
> >> @@ -457,7 +457,7 @@ static inline void nfs4_label_free(struct nfs4_lab=
el *label)
> >>  {
> >>  #ifdef CONFIG_NFS_V4_SECURITY_LABEL
> >>      if (label) {
> >> -            kfree(label->label);
> >> +            kfree(label->lsmctx.context);
> > Shouldn't this be a call to security_release_secctx() instead of a raw
> > kfree()?
>
> As mentioned in the description, the NFS data is a copy that NFS
> manages, so it does need to be freed, not released.

It does, my apologies.

However, this makes me wonder if using the lsm_context struct for the
private NFS copy is the right decision.  The NFS code assumes and
requires a single string, ala secctx, but I think we want the ability
to potentially do other/additional things with lsm_context, even if
this patchset doesn't do that.

I would suggest keeping the NFS private copy as sec_ctx/sec_ctxlen and
keep the concept of a translation between the data structures in
place, even though it is just a simple string duplication right now.

--=20
paul-moore.com

