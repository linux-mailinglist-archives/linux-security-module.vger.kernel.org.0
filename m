Return-Path: <linux-security-module+bounces-6080-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58EE99A4E6
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Oct 2024 15:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B7B1C23181
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Oct 2024 13:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1E721B437;
	Fri, 11 Oct 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="E9+1MEB8"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1321B42A
	for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652839; cv=none; b=dRXYnTXfQx03F61FI+J9Iu7cGxt+SIl0VRXdl6eRCxS/J5WGjR+gzWkLbopVMfnl4yPzRDf/2M4jK8eQMgq1+EUfrJFGCYrKReF+YBF0ij4Fn5PKOv5eBs+gRxVe6FsBMMAxSloLbP83MAh0VZFeaHp3dLtxk7sdcss6NH9cDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652839; c=relaxed/simple;
	bh=ZXF83piWzI3Zr1ZbvAwOoHydCarQmxoJOvM0bNPBoQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSAVdkINAfeNdq8LFcW2YpfJHp7EpETh83j6u/Z00VBZ993WofSMDHDArnn5TBRg76hs+DMrqTGwsf9d8cycpyF6khKdfnuQEdqqJBdMlPup1IC94RmRnprl53NbZmkzwnfmb4eoRY0pdrUkkL4NKXD4ReQSCmDHhZBh/s5bWCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=E9+1MEB8; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XQ6gk1wpTz1bb;
	Fri, 11 Oct 2024 15:20:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728652834;
	bh=t6ZV+Aef3oPv3lyEENojOAVZ16/VitLu0VzEYiYccvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9+1MEB8gIvfq69xVhtuLunwoxi8XY6JouvIgYwzQr8dxGYAT/pg8XE3hjMK1v44X
	 YECUDqbUYgrRKVY3rtpl8SB7jCklNWUWxzQaHoHIOZKPmm/tOXHQcSh7hbds6pKOnT
	 QOezwOMY5Pei4iq+1PSR/02UNXI2NHErgpd8Swe8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XQ6gj3zvGz7HN;
	Fri, 11 Oct 2024 15:20:33 +0200 (CEST)
Date: Fri, 11 Oct 2024 15:20:30 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241011.yai6KiDa7ieg@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwkgDd1JO2kZBobc@infradead.org>
X-Infomaniak-Routing: alpha

On Fri, Oct 11, 2024 at 05:54:37AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 11, 2024 at 02:47:14PM +0200, Mickaël Salaün wrote:
> > How to get the inode number with ->getattr and only a struct inode?
> 
> You get a struct kstat and extract it from that.

Yes, but how do you call getattr() without a path?

