Return-Path: <linux-security-module+bounces-6089-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0202099A7BA
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Oct 2024 17:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CFC1C2650E
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Oct 2024 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8607418DF60;
	Fri, 11 Oct 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="h3Cr1Sgz"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC39198826
	for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660674; cv=none; b=pjFUsLiRgSW0bxQiH/8rsXyCAMOLFtkmxtPVnsNpzIfv6C6//4iyTvNoVmLDm6f5VjWjyWctWxO4jBeJmE92tAvrhkJdpWQAHiCURgOFoljxcqxW7uZlWPu+npTH5Rz6pnerlqtYgmfQBY3sAHl26akNePEUvCfeC6uoncHYz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660674; c=relaxed/simple;
	bh=NsPGwHwnspM3wr8QfUs6BxeNGWF+VpsB+QOZ6tvMN8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5nAl6fqwZJhxWT8epsqHn8fSiH9e5TcxHvPWU3NFee3txN1LiGR1kZw7qms0Wz6zBMHYXe94bPWoNcX2bvadbrH2/rho/VHBB4U8PQDfdD8o/LwxxsUrOWEwswQrHOAbAw3XLAADjhAqsSZsLif6vtlQBt7PVPvmSfznUrWaqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=h3Cr1Sgz; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XQ9ZJ2v4CzMZH;
	Fri, 11 Oct 2024 17:31:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728660664;
	bh=U55SanGiVovRw6PJWPWfxK7Vw/FiEAp4FEVfyszMD+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3Cr1Sgzp8L4PP+ApIZ1K2Fb4iFt2qMbj9MuPm5xUojHvojzVs5OGes0QonIg5MGX
	 tdbp8xWfkDET5/K0Q9MOudj/UG0wnYtcfe6yv72g30yGOpBQWo1IVbv6RiSncgkFC5
	 Qe8yU8Gmk9OdYD7olLTVP2Qo4vur6fqrJhJgTmlA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XQ9ZH5kdZzb2s;
	Fri, 11 Oct 2024 17:31:03 +0200 (CEST)
Date: Fri, 11 Oct 2024 17:30:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241011.uu1Bieghaiwu@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net>
 <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net>
 <Zwk4pYzkzydwLRV_@infradead.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zwk4pYzkzydwLRV_@infradead.org>
X-Infomaniak-Routing: alpha

On Fri, Oct 11, 2024 at 07:39:33AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 11, 2024 at 03:52:42PM +0200, Mickaël Salaün wrote:
> > > > Yes, but how do you call getattr() without a path?
> > > 
> > > You don't because inode numbers are irrelevant without the path.
> > 
> > They are for kernel messages and audit logs.  Please take a look at the
> > use cases with the other patches.
> 
> It still is useless.  E.g. btrfs has duplicate inode numbers due to
> subvolumes.

At least it reflects what users see.

> 
> If you want a better pretty but not useful value just work on making
> i_ino 64-bits wide, which is long overdue.

That would require too much work for me, and this would be a pain to
backport to all stable kernels.

