Return-Path: <linux-security-module+bounces-11517-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0190B2DFCA
	for <lists+linux-security-module@lfdr.de>; Wed, 20 Aug 2025 16:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571B656285E
	for <lists+linux-security-module@lfdr.de>; Wed, 20 Aug 2025 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98132DBF52;
	Wed, 20 Aug 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1CzxXx9Z"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A628150F
	for <linux-security-module@vger.kernel.org>; Wed, 20 Aug 2025 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701093; cv=none; b=n1sA0wjddNHZ/4hUOVQHFNmVknKDwvKCSEFo6csGye/NzkNFIcsnVphf7/x+0BBLKUkAot3ngxYu8b/q5bcYML/Gu+Vr5tKXRacPehGhYDZqXn4BxZjEt419/92nIiUaiJ1WRLDxAuaIi+bAOCe2PQFVtXNerX08Z1ialx9gbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701093; c=relaxed/simple;
	bh=zCh6qK9xv4CQicnQ5qrWcgEC3rrgEK8HXP9qElrkPSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISHBhxhz8fJfJ4v0DbBcy9E5PPiZLOoDLrRxEFEXL+24zusyHWYZm3J5rswAc0m39datQuy5ppLavECI0NDMME2pdvYe2PGEU9s1dZQWjIP7mGEA0j8i3QI5Ooh6LUY/cKGLLYycuvyOOB5umaNMdej8w55ahgIvhZghJKdBin4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1CzxXx9Z; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c6TkR4k16zfyh;
	Wed, 20 Aug 2025 16:44:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1755701087;
	bh=6T9cQdp2s0GiiasprizIFB2Oul/nL9rjbsqRDs6iQX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1CzxXx9ZCPyXYqGbH2Ad3FbV23ZFpUfRX/Tde8TxaPT+Ct6LvyTR247ZNIt3WXkjO
	 da9q/7fHRoA+Vftfn3z4aqQ1IUaYSeJP+WOPp0Cw7RqHQEOUfPYATrkpwe5+Q+4Gkv
	 AiTO0xkKOwi4kVeqtqzIu4GxvNNHx38+c2t97JSw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4c6TkR08bNz235;
	Wed, 20 Aug 2025 16:44:47 +0200 (CEST)
Date: Wed, 20 Aug 2025 16:44:46 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Maxime =?utf-8?Q?B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: Re: LSM namespacing API
Message-ID: <20250820.ieNg1quoRouz@digikod.net>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Aug 19, 2025 at 02:51:00PM -0400, Paul Moore wrote:
> On Tue, Aug 19, 2025 at 1:47 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > I think we want to be able to unshare a specific security module
> > namespace without unsharing the others, i.e. just SELinux or just
> > AppArmor.
> > Not sure if your suggestion above supports that already but wanted to note it.
> 
> The lsm_set_self_attr(2) approach allows for LSM specific unshare
> operations.  Take the existing LSM_ATTR_EXEC attribute as an example,
> two LSMs have implemented support (AppArmor and SELinux), and
> userspace can independently set the attribute as desired for each LSM.
> 
> > Serge pointed out that we also will need an API to attach to an
> > existing SELinux namespace, which I captured here:
> > https://github.com/stephensmalley/selinuxns/issues/19
> > This is handled for other Linux namespaces by opening a pseudo file
> > under /proc/pid/ns and invoking setns(2), so not sure how we want to
> > do it.
> 
> One option would be to have a the LSM framework return a LSM namespace
> "handle" for a given LSM using lsm_get_self_attr(2) and then do a
> setns(2)-esque operation using lsm_set_self_attr(2) with that
> "handle".  We would need to figure out what would constitute a
> "handle" but let's just mark that as TBD for now with this approach (I
> think better options are available).
> 
> Since we have an existing LSM namespace combination, with processes
> running inside of it, it might be sufficient to simply support moving
> into an existing LSM namespace set with setns(2) using only a pidfd
> and a new CLONE_LSMNS flag (or similar, upstream might want this as
> CLONE_NEWLSM).  This would simply set the LSM namespace set for the

Bike shedding but, I would prefer CLONE_NEWSEC or something without LSM
because the goal is not to add a new LSM but a new "security" namespace.
To fit with existing capabilities that could be reused by such security
namespace (CAP_MAC_ADMIN), CLONE_NEWMAC is another option.  I know that
LSM may not be enforce MAC, but I think "LSM" would be confusing for
users.

> setns(2) caller to match that of the target pidfd.  We still wouldn't
> want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().

Why making clone*() support this flag would be an issue?

> 
> Any other ideas?

The goal of a namespace is to configure absolute references (e.g. file
path, network address, PID, time).  I think it would make sense to have
an LSM/MAC/SEC namespace that would enforce a consistent access control
on every processes in this namespace.  A related namespace file
descriptor could then be used with an LSM-specific syscall to configure
the policy related to a specific namespace (instead of only the current
namespace), see
https://lore.kernel.org/r/20250820.Ao3iquoshaiB@digikod.net
That would enables us to build a context before running untrusted code
in it, and to update the related security policy without requiring a
trusted (and exposed) process in each namespace.

I guess a security namespace would not be exclusive to an LSM but could
be shared, right?  If yes, then it's OK to only have one new security
namespace instead of one per LSM. ;)

