Return-Path: <linux-security-module+bounces-5909-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288459917AD
	for <lists+linux-security-module@lfdr.de>; Sat,  5 Oct 2024 17:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516EC1C21112
	for <lists+linux-security-module@lfdr.de>; Sat,  5 Oct 2024 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361E01E50D;
	Sat,  5 Oct 2024 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CZ6yMY04"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F31C6A3
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728141710; cv=none; b=c5Vr3a8p+Zom4eMypDhulZ3SCDf/+46HvVzSfQTcrB6lcbV2mKAevfb5hMYc4+LmOELOiwFAdeQtfIdeDW4XYvPI10yrUWa5xLHytzaG1hVlxDgdEtJ8+LcpoaYL4+ANHsNgyLPNsVl5aYNS71oagGkSVvERI7iW2/UGVERLhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728141710; c=relaxed/simple;
	bh=4SrFSSF687gJVku8Rtojdn3GUU4nta+vaSjYHgNmc+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkIFrW42ng/Wk1ArY+5MNZid3QsFB6xIZTOcPTI0a4HmanAPmLIuL/F/hwAdL7LvLTWBkD/DTmetsdPmABZTURKUNFCPKykw8AKOqYIXHb5H8h6jRsB1CloaAeMf2ryJqXl50M0vQA16GI/WBKQNDFTb+ZDH/OrcvDaKWaU8gWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CZ6yMY04; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XLTf7420Rz88R;
	Sat,  5 Oct 2024 17:21:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728141695;
	bh=TMmKMveFTVlLxU+hFC0f2OEpfMZOkNIAwt3exPPn9rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZ6yMY04Dd5KWkDXa7rH9PMe3wawomnxfM97NRMOyhWqlvqduq/XHbJY0sUZTi3K9
	 u+lU0gZcPIo5PQG1dqsQnCNid75MXGb/ckXr/Ul9f6wuezUJS4+JSmrWbItZAAwTbe
	 LkuQpiqkhCu9s0YtHz9TdtXY7Klu9qGilyNHxXfQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XLTf50tYZzSvN;
	Sat,  5 Oct 2024 17:21:33 +0200 (CEST)
Date: Sat, 5 Oct 2024 17:21:30 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev, torvalds@linux-foundation.org, 
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, 
	Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <20241005.phah4Yeiz4oo@digikod.net>
References: <20241003115721.kg2caqgj2xxinnth@quack3>
 <Zv6J34fwj3vNOrIH@infradead.org>
 <20241003122657.mrqwyc5tzeggrzbt@quack3>
 <Zv6Qe-9O44g6qnSu@infradead.org>
 <20241003125650.jtkqezmtnzfoysb2@quack3>
 <Zv6jV40xKIJYuePA@dread.disaster.area>
 <20241003161731.kwveypqzu4bivesv@quack3>
 <Zv8648YMT10TMXSL@dread.disaster.area>
 <20241004-abgemacht-amortisieren-9d54cca35cab@brauner>
 <ZwBy3H/nR626eXSL@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwBy3H/nR626eXSL@dread.disaster.area>
X-Infomaniak-Routing: alpha

On Sat, Oct 05, 2024 at 08:57:32AM +1000, Dave Chinner wrote:
> On Fri, Oct 04, 2024 at 09:21:19AM +0200, Christian Brauner wrote:
> > On Fri, Oct 04, 2024 at 10:46:27AM GMT, Dave Chinner wrote:
> > > On Thu, Oct 03, 2024 at 06:17:31PM +0200, Jan Kara wrote:
> > > > On Thu 03-10-24 23:59:51, Dave Chinner wrote:
> > > > > As for the landlock code, I think it needs to have it's own internal
> > > > > tracking mechanism and not search the sb inode list for inodes that
> > > > > it holds references to. LSM cleanup should be run before before we
> > > > > get to tearing down the inode cache, not after....
> > > > 
> > > > Well, I think LSM cleanup could in principle be handled together with the
> > > > fsnotify cleanup but I didn't check the details.
> > > 
> > > I'm not sure how we tell if an inode potentially has a LSM related
> > > reference hanging off it. The landlock code looks to make an
> > > assumption in that the only referenced inodes it sees will have a
> > > valid inode->i_security pointer if landlock is enabled. i.e. it
> > > calls landlock_inode(inode) and dereferences the returned value
> > > without ever checking if inode->i_security is NULL or not.

Correct, i_security should always be valid when this hook is called
because it means that at least Landlock is enabled and then i_security
refers to a valid LSM blob.

> > > 
> > > I mean, we could do a check for inode->i_security when the refcount
> > > is elevated and replace the security_sb_delete hook with an
> > > security_evict_inode hook similar to the proposed fsnotify eviction
> > > from evict_inodes().

That would be nice.

> > > 
> > > But screwing with LSM instructure looks ....  obnoxiously complex
> > > from the outside...
> > 
> > Imho, please just focus on the immediate feedback and ignore all the
> > extra bells and whistles that we could or should do. I prefer all of
> > that to be done after this series lands.
> 
> Actually, it's not as bad as I thought it was going to be. I've
> already moved both fsnotify and LSM inode eviction to
> evict_inodes() as preparatory patches...

Good, please Cc me and Günther on related patch series.

FYI, we have the two release_inodes tests to check this hook in
tools/testing/selftests/landlock/fs_test.c

> 
> Dave Chinner (2):
>       vfs: move fsnotify inode eviction to evict_inodes()
>       vfs, lsm: rework lsm inode eviction at unmount
> 
>  fs/inode.c                    |  52 +++++++++++++---
>  fs/notify/fsnotify.c          |  60 -------------------
>  fs/super.c                    |   8 +--
>  include/linux/lsm_hook_defs.h |   2 +-
>  include/linux/security.h      |   2 +-
>  security/landlock/fs.c        | 134 ++++++++++--------------------------------
>  security/security.c           |  31 ++++++----
> 7 files changed, 99 insertions(+), 190 deletions(-)
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

