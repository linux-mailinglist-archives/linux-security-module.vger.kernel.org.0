Return-Path: <linux-security-module+bounces-6160-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B9A99D2DB
	for <lists+linux-security-module@lfdr.de>; Mon, 14 Oct 2024 17:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772511C22AF2
	for <lists+linux-security-module@lfdr.de>; Mon, 14 Oct 2024 15:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DA41CC168;
	Mon, 14 Oct 2024 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pIS/CYhF"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3491C7608
	for <linux-security-module@vger.kernel.org>; Mon, 14 Oct 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919667; cv=none; b=O7lB4hVU9bDdr+jaruvAtdZDmIChg1bMkpQ/Otd1JP9fuxCG5RY3ttOwNWqtiI2PxEoykK/001lJkgNH/CjwcfTxsQq4HUcnFOdZK703EW6vqS2W4npukC60pn7GvXod63xFeuZWDb4Eho6aUkIOAveioZvhBFZho9CteuuJm1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919667; c=relaxed/simple;
	bh=ZaL14WUwdi6F3kzXD+mi70gTGNWTgDHFcdA3KEcOryo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECbqkITjFlnzRetwzKSOZZ42XvCar6czzPXe9UgbggkekefGlG3hBbjpowMB3kbBWOr0LHbuEwP6AsM+N+o0q9x+d2fGAqIK4OkUJuEWXI/0Amh2Gt4KGbq3Mjtb2NJon2/+3LybLfS+uIjAOPgJ0UQrlOOAziB694a9CTQ6kz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pIS/CYhF; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XS1Lx1Chczqx0;
	Mon, 14 Oct 2024 17:27:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728919657;
	bh=OLKb3K8uazK1UPw7MoVio/7qjqTmsfRrQxE/pjnvijA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIS/CYhFQ1TNL/IMdoq69XonPx8/xjFwbZ4RzCnRYMQsVnLGQT09iaeFSZuPUxTXM
	 z6dT38lGAxDnRRr22vdCYJisHNy6jKSgS8t3FHLSA/V2+3mt03qXWhAsRi5Uo+E6vb
	 O7TOejl6dLA9eigYLqV9KHisgEPT/YeNo2xTma6A=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XS1Lw1Vj6z73H;
	Mon, 14 Oct 2024 17:27:36 +0200 (CEST)
Date: Mon, 14 Oct 2024 17:27:32 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241014.Duivaxoo0pae@digikod.net>
References: <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net>
 <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net>
 <Zwk4pYzkzydwLRV_@infradead.org>
 <20241011.uu1Bieghaiwu@digikod.net>
 <05cb94c0dda9e1b23fe566c6ecd71b3d1739b95b.camel@kernel.org>
 <20241014-turmbau-ansah-37d96a5fd780@brauner>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014-turmbau-ansah-37d96a5fd780@brauner>
X-Infomaniak-Routing: alpha

On Mon, Oct 14, 2024 at 04:45:00PM +0200, Christian Brauner wrote:
> On Sun, Oct 13, 2024 at 06:17:43AM -0400, Jeff Layton wrote:
> > On Fri, 2024-10-11 at 17:30 +0200, Mickaël Salaün wrote:
> > > On Fri, Oct 11, 2024 at 07:39:33AM -0700, Christoph Hellwig wrote:
> > > > On Fri, Oct 11, 2024 at 03:52:42PM +0200, Mickaël Salaün wrote:
> > > > > > > Yes, but how do you call getattr() without a path?
> > > > > > 
> > > > > > You don't because inode numbers are irrelevant without the path.
> > > > > 
> > > > > They are for kernel messages and audit logs.  Please take a look at the
> > > > > use cases with the other patches.
> > > > 
> > > > It still is useless.  E.g. btrfs has duplicate inode numbers due to
> > > > subvolumes.
> > > 
> > > At least it reflects what users see.
> > > 
> > > > 
> > > > If you want a better pretty but not useful value just work on making
> > > > i_ino 64-bits wide, which is long overdue.
> > > 
> > > That would require too much work for me, and this would be a pain to
> > > backport to all stable kernels.
> > > 
> > 
> > Would it though? Adding this new inode operation seems sub-optimal.
> 
> I agree.

Of course it would be better to fix the root of the issue.  Who is up
for the challenge?

> 
> > Inode numbers are static information. Once an inode number is set on an
> > inode it basically never changes.  This patchset will turn all of those
> > direct inode->i_ino fetches into a pointer chase for the new inode
> > operation, which will then almost always just result in a direct fetch.
> 
> Yup.
> 
> > A better solution here would be to make inode->i_ino a u64, and just
> > fix up all of the places that touch it to expect that. Then, just
> 
> I would like us to try and see to make this happen. I really dislike
> that struct inode is full of non-explicity types.

Also, it would be OK to backport it, right?

