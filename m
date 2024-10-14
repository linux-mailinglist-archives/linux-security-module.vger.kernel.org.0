Return-Path: <linux-security-module+bounces-6162-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B0699D5D8
	for <lists+linux-security-module@lfdr.de>; Mon, 14 Oct 2024 19:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FC828300C
	for <lists+linux-security-module@lfdr.de>; Mon, 14 Oct 2024 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AEC1C7287;
	Mon, 14 Oct 2024 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="iPNSFfdr"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B96231C8A
	for <linux-security-module@vger.kernel.org>; Mon, 14 Oct 2024 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928298; cv=none; b=VLdx1GO5kMadGWPsxlYHyTA/0hcmC/yJ94Xf6pIjecYwIdhY4DCJ7zojjomq5XS84sO+x5I9OEYZjoZaWZCEZyy4/DM7u+HJ1/eFmSdbV9M7o4ECewGUBKj+/It2Q97TpfFn0Phm6E+++2CfJJdO7oDh2IEJhlye00T9BFi+R4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928298; c=relaxed/simple;
	bh=YDpK8DElrGggMuygJgQHlKxi+iqaIvRMgS+t8kxYB9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeO5EqKZ1H9hHpsNh9dndePzGIrfXpf3tW0O0obex9KX9v6Vrt6sqsPXBmgYoTANIAgRMEDCzFVcNY95bl3U4jRXhHJI+VM82fdCBG3P6Y/5Ba4VH42EtEgwVsV6bcckX6cY4jc+x2Z/ojwqUe4OaJwp8XKepS7jw1joZLG2wLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=iPNSFfdr; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XS4Xt5rf6zM0v;
	Mon, 14 Oct 2024 19:51:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728928286;
	bh=ZefrrTPDl3Jk7cEYA8aBvb4pJxUrCXTEIHSc8TD2YTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPNSFfdrDJ6Ob7LIGnnpWicwhW/cx0Q9NgEsqn3ftTDWrP3c8uqhN9iapVArdi/dX
	 jCqayCuBnap8qHcgK6wtleiKArAZcAYdSTWIBPQHc8tRsUn2p5ByyyzO0S7LrDVdey
	 vhXF4oVGdsyRhgnoisRKn+t84Bn7jiKsfwwAhmjw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XS4Xs6f5Pzh7Z;
	Mon, 14 Oct 2024 19:51:25 +0200 (CEST)
Date: Mon, 14 Oct 2024 19:51:21 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241014.ij8ohshuv7Op@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241014-bestnote-rundweg-ed234af3b86a@brauner>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014-bestnote-rundweg-ed234af3b86a@brauner>
X-Infomaniak-Routing: alpha

On Mon, Oct 14, 2024 at 04:47:17PM +0200, Christian Brauner wrote:
> On Thu, Oct 10, 2024 at 05:26:41PM +0200, Mickaël Salaün wrote:
> > When a filesystem manages its own inode numbers, like NFS's fileid shown
> > to user space with getattr(), other part of the kernel may still expose
> > the private inode->ino through kernel logs and audit.
> > 
> > Another issue is on 32-bit architectures, on which ino_t is 32 bits,
> > whereas the user space's view of an inode number can still be 64 bits.
> > 
> > Add a new inode_get_ino() helper calling the new struct
> > inode_operations' get_ino() when set, to get the user space's view of an
> > inode number.  inode_get_ino() is called by generic_fillattr().
> 
> I mean, you have to admit that this is a pretty blatant hack and that's
> not worthy of a separate inode method, let alone the potential
> performance implication that multiple people already brought up.

My initial approach was to use u64 for struct inode's i_ino, but I
realized it had too much implications on potentially all filesystems and
other parts of the kernel.  I'm sure they are much more legitimate folks
to handle this transition.  I'd be curious to know how such i_ino type
change could be backported though.

