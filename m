Return-Path: <linux-security-module+bounces-1309-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B245584AA4B
	for <lists+linux-security-module@lfdr.de>; Tue,  6 Feb 2024 00:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122B4B2564F
	for <lists+linux-security-module@lfdr.de>; Mon,  5 Feb 2024 23:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA64F487A5;
	Mon,  5 Feb 2024 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WRiaGYpr"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7FA47A61
	for <linux-security-module@vger.kernel.org>; Mon,  5 Feb 2024 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174662; cv=none; b=GGu4AxEFvAdMvmDRUbF0kC7wCzycmYARWHD06/EP/w6m8Mj6q5MjgfTl7VbYyCu2hJhI3DTJQmB4Ngn6alWgBxyTL5ICQqidUKss06Q28RvrPiezsrglriZRZrkIJfMIV/2VmeAC2TZ9c1Vb5gr2rYtiDzF6RooOd/aDGqNkuYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174662; c=relaxed/simple;
	bh=98ETdYEYjeLAfEolbR/C15K5yV0mp9d6RDnidWccDTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGJt7lVOxVxSOLi3QtbVzVTE/Nnss7jQIS0O7fWk/YjRy5zy6QSqj/L2tiTIdjf5ts2RKmp7/HC/jdC/vkwg810uDyUSlf7Yiidhvbbgf+ijRSeq0K7oPbUtTGQ5G5ijDD7uF7AwTfcDTjDrbXnwjbNjIMHXC5RNUm2VQm+CFX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WRiaGYpr; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc236729a2bso4743256276.0
        for <linux-security-module@vger.kernel.org>; Mon, 05 Feb 2024 15:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707174658; x=1707779458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qukmwsoJr7mQjUV1Px87duNcYP7pZmjoAINvmrLBQgA=;
        b=WRiaGYprqsiqKvdw3zMea/UgTgbfZVAtjOWqrNSG7hs4AeGn1FGpik2WTomgsFjqAx
         hCOFEE25vq0NYUIIx5paFvdF2jMVYV4gME8NCfjU8KlkEU0Conp4qNCeVuOMK6MS7rNW
         NLmLY4ZwacEGNHCUgeV/yDouJeMP7CBh/NTeIuLEE9Ax7NoGa3Ut2FRC8dtchzUiqCT2
         KtIgCkSDOIGfDVNl1a4ecDqfUIZlyWDqmQGcOE5Cb8bb60DiqjOieNV/LqTjl65T1O2n
         CdxKGxUik+1c1Dv9SzAWKcnmLy0Oyt76JorED1EpT7NyhyQujaETMyy4gJ8txYhAA1X1
         PoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707174658; x=1707779458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qukmwsoJr7mQjUV1Px87duNcYP7pZmjoAINvmrLBQgA=;
        b=Nh2hwvuzWniRT0tLxWn4vVqgNki+x8Ise++tlVjdxxgHtxFOvbr7q7AnWVx2BBe2a9
         KJcbNwYG3MuEteAsvqJUI2FiD81l3xlr7ZAY6+L6Up5lkvNEcBq7/GetsqCq0WJ544xD
         hpam8OQz5H/laf1nZLhWqD7zWmdGSyt6uHM40SaYx+p73osh3Ky2Rm+F9a0uOYy4axvT
         NnSbB6g7OSyaFd2InNXZYN5uS/dsxc3IUMg/5wGjv5VAdGqC54mbIMjX/OirqfuhcMRi
         odNoocfbBlZ8olSNCV22ob3tbJFNaJ7IA8Po5tEGvxQoL3SNsQC6P67bjvIO+tQMoGlA
         OITg==
X-Gm-Message-State: AOJu0YzUVFqGhTC/h2FZSYhfoVUuCTNkpJWpdyfBNXghxQCRmJbhLoBY
	TY9jPXhzrc3NWY3SbZdACd00bFrI0nAl6sJqLCF4jgwoCU4+7N6atxV3ChmoQckbhwmNNKT4sut
	ranNAHWGMxA4CCCXBs7Jl3jpl2ryyq/IqHfW6
X-Google-Smtp-Source: AGHT+IFeMStOFrv0XIgr14+fDBGkClnixJ9TyyYhiV9/R7V1nPl7eILrH74xPNpD1d/PL5zMi5bYdlmCJwc/AqNEKig=
X-Received: by 2002:a05:6902:18c7:b0:dc6:a5e1:3a05 with SMTP id
 ck7-20020a05690218c700b00dc6a5e13a05mr1060705ybb.14.1707174658515; Mon, 05
 Feb 2024 15:10:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706654228-17180-9-git-send-email-wufan@linux.microsoft.com>
 <737a8ea0323b3db38044813041215bac@paul-moore.com> <6e7c707c-28cd-42ec-a617-6f8d2ce9da4f@linux.microsoft.com>
In-Reply-To: <6e7c707c-28cd-42ec-a617-6f8d2ce9da4f@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 Feb 2024 18:10:47 -0500
Message-ID: <CAHC9VhSX4iNHEw89-mpF07cSqgGd1myQ6CUfiQnA9pgg3QS7Tw@mail.gmail.com>
Subject: Re: [PATCH RFC v12 8/20] ipe: add userspace interface
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
	snitzer@kernel.org, eparis@redhat.com, linux-doc@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org, 
	dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 6:01=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
> On 2/3/2024 2:25 PM, Paul Moore wrote:
> > On Jan 30, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> >>
> >> As is typical with LSMs, IPE uses securityfs as its interface with
> >> userspace. for a complete list of the interfaces and the respective
> >> inputs/outputs, please see the documentation under
> >> admin-guide/LSM/ipe.rst
> >>
> >> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> >> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> >> ---
> >> v2:
> >>    + Split evaluation loop, access control hooks,
> >>      and evaluation loop from policy parser and userspace
> >>      interface to pass mailing list character limit
> >>
> >> v3:
> >>    + Move policy load and activation audit event to 03/12
> >>    + Fix a potential panic when a policy failed to load.
> >>    + use pr_warn for a failure to parse instead of an
> >>      audit record
> >>    + Remove comments from headers
> >>    + Add lockdep assertions to ipe_update_active_policy and
> >>      ipe_activate_policy
> >>    + Fix up warnings with checkpatch --strict
> >>    + Use file_ns_capable for CAP_MAC_ADMIN for securityfs
> >>      nodes.
> >>    + Use memdup_user instead of kzalloc+simple_write_to_buffer.
> >>    + Remove strict_parse command line parameter, as it is added
> >>      by the sysctl command line.
> >>    + Prefix extern variables with ipe_
> >>
> >> v4:
> >>    + Remove securityfs to reverse-dependency
> >>    + Add SHA1 reverse dependency.
> >>    + Add versioning scheme for IPE properties, and associated
> >>      interface to query the versioning scheme.
> >>    + Cause a parser to always return an error on unknown syntax.
> >>    + Remove strict_parse option
> >>    + Change active_policy interface from sysctl, to securityfs,
> >>      and change scheme.
> >>
> >> v5:
> >>    + Cause an error if a default action is not defined for each
> >>      operation.
> >>    + Minor function renames
> >>
> >> v6:
> >>    + No changes
> >>
> >> v7:
> >>    + Propagating changes to support the new ipe_context structure in t=
he
> >>      evaluation loop.
> >>
> >>    + Further split the parser and userspace interface changes into
> >>      separate commits.
> >>
> >>    + "raw" was renamed to "pkcs7" and made read only
> >>    + "raw"'s write functionality (update a policy) moved to "update"
> >>    + introduced "version", "policy_name" nodes.
> >>    + "content" renamed to "policy"
> >>    + changes to allow the compiled-in policy to be treated
> >>      identical to deployed-after-the-fact policies.
> >>
> >> v8:
> >>    + Prevent securityfs initialization if the LSM is disabled
> >>
> >> v9:
> >>    + Switch to securityfs_recursive_remove for policy folder deletion
> >>
> >> v10:
> >>    + Simplify and correct concurrency
> >>    + Fix typos
> >>
> >> v11:
> >>    + Correct code comments
> >>
> >> v12:
> >>    + Correct locking and remove redundant code
> >> ---
> >>   security/ipe/Makefile    |   2 +
> >>   security/ipe/fs.c        | 101 +++++++++
> >>   security/ipe/fs.h        |  16 ++
> >>   security/ipe/ipe.c       |   3 +
> >>   security/ipe/ipe.h       |   2 +
> >>   security/ipe/policy.c    | 123 ++++++++++
> >>   security/ipe/policy.h    |   9 +
> >>   security/ipe/policy_fs.c | 469 +++++++++++++++++++++++++++++++++++++=
++
> >>   8 files changed, 725 insertions(+)
> >>   create mode 100644 security/ipe/fs.c
> >>   create mode 100644 security/ipe/fs.h
> >>   create mode 100644 security/ipe/policy_fs.c
> >
> > ...
> >
> >> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> >> index f22a576a6d68..61fea3e38e11 100644
> >> --- a/security/ipe/policy.c
> >> +++ b/security/ipe/policy.c
> >> @@ -43,6 +71,68 @@ static int set_pkcs7_data(void *ctx, const void *da=
ta, size_t len,
> >>      return 0;
> >>   }
> >>
> >> +/**
> >> + * ipe_update_policy - parse a new policy and replace old with it.
> >> + * @root: Supplies a pointer to the securityfs inode saved the policy=
.
> >> + * @text: Supplies a pointer to the plain text policy.
> >> + * @textlen: Supplies the length of @text.
> >> + * @pkcs7: Supplies a pointer to a buffer containing a pkcs7 message.
> >> + * @pkcs7len: Supplies the length of @pkcs7len.
> >> + *
> >> + * @text/@textlen is mutually exclusive with @pkcs7/@pkcs7len - see
> >> + * ipe_new_policy.
> >> + *
> >> + * Context: Requires root->i_rwsem to be held.
> >> + * Return:
> >> + * * !IS_ERR        - The existing policy saved in the inode before u=
pdate
> >> + * * -ENOENT        - Policy doesn't exist
> >> + * * -EINVAL        - New policy is invalid
> >> + */
> >> +struct ipe_policy *ipe_update_policy(struct inode *root,
> >> +                                 const char *text, size_t textlen,
> >> +                                 const char *pkcs7, size_t pkcs7len)
> >> +{
> >> +    int rc =3D 0;
> >> +    struct ipe_policy *old, *ap, *new =3D NULL;
> >> +
> >> +    old =3D (struct ipe_policy *)root->i_private;
> >> +    if (!old)
> >> +            return ERR_PTR(-ENOENT);
> >> +
> >> +    new =3D ipe_new_policy(text, textlen, pkcs7, pkcs7len);
> >> +    if (IS_ERR(new))
> >> +            return new;
> >> +
> >> +    if (strcmp(new->parsed->name, old->parsed->name)) {
> >> +            rc =3D -EINVAL;
> >> +            goto err;
> >> +    }
> >> +
> >> +    if (ver_to_u64(old) > ver_to_u64(new)) {
> >> +            rc =3D -EINVAL;
> >> +            goto err;
> >> +    }
> >> +
> >> +    root->i_private =3D new;
> >> +    swap(new->policyfs, old->policyfs);
> >
> > Should the swap() take place with @ipe_policy_lock held?
> >
> I think we are safe here because root->i_rwsem is held. Other two
> operations set_active and delete are also depending on the inode lock.
> >> +    mutex_lock(&ipe_policy_lock);
> >> +    ap =3D rcu_dereference_protected(ipe_active_policy,
> >> +                                   lockdep_is_held(&ipe_policy_lock))=
;
> >> +    if (old =3D=3D ap) {
> >> +            rcu_assign_pointer(ipe_active_policy, new);
> >> +            mutex_unlock(&ipe_policy_lock);
> >> +            synchronize_rcu();
> >
> > I'm guessing you are forcing a synchronize_rcu() here because you are
> > free()'ing @old in the caller, yes?  Looking at the code, I only see
> > one caller, update_policy().  With only one caller, why not free @old
> > directly in ipe_update_policy()?  Do you see others callers that would
> > do something different?
> >
> The call of synchronize_rcu() is because we are updating the current
> active policy so we need to set the new policy as active.

Unless I'm mistaken, a syncronize_rcu() call only ensures that the
current task will see the updated value by waiting until all current
RCU critical sections have finished.  Given the mutex involved here I
don't believe this is necessary, but please correct me if I'm wrong.

--=20
paul-moore.com

