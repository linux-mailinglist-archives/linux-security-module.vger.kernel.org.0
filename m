Return-Path: <linux-security-module+bounces-5092-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1125595F9CF
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Aug 2024 21:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4408B1C211EB
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Aug 2024 19:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F310199E81;
	Mon, 26 Aug 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V8cvKRlV"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0041991B8
	for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701197; cv=none; b=iyS4ehBiqAxQCIV7FdFxX3VOFePFBTBWqhXRQQ+QXHGgl4sK6pFkqpVx752Y/TtN9T9yJ6s63FVJPEzXAW0FYVFE/MxncGu/QxtTrpcFPbQSUe+cY1sMdxHeTOKCzp43humk2XhkgOPgCpVf9NTFi0wsFp4hn1WR4OYk9ZpZO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701197; c=relaxed/simple;
	bh=XEulr65+yh66N3PPWR+wg8huhyytrpHFe0zJ+ZFzCnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXUZTHYsQrz2i4wwnJXePDEFHvJu9zswtouRGwU2wi2In3QoB1V+kgi3aNd0UbIGhiGoDgwjiHyY35c66W3v3+WnBLs3GFF2XazuMwK5WZGgaEaKxW4eBFcT9FITLIgyZ0aeIx6qFOpK+whg3c1vfy0IF/nknuIe20ApcHx2HX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V8cvKRlV; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 15:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724701193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8E/6L+ulNsRyaHYOTIlLjfcvhy62fxlcDeAIHJ8v4Ks=;
	b=V8cvKRlVtBhQKeYuIHdYYCUBDHWBs7l5h7bwYMUlck2FF7vO0I70RWpj0RHO9D1SxfpY/R
	aOaZ+6ve08kYIPyePAQplsSQyHKdzdyPJjqJpH8sea54fRE8DsES3fVtNbNeYK1C5R627I
	HJLBFnfng6C5djJJ8e4kAR/ovwX0ymE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826085347.1152675-2-mhocko@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 10:47:12AM GMT, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> inode to achieve GFP_NOWAIT semantic while holding locks. If this
> allocation fails it will drop locks and use GFP_NOFS allocation context.
> 
> We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> dangerous to use if the caller doesn't control the full call chain with
> this flag set. E.g. if any of the function down the chain needed
> GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> cause unexpected failure.
> 
> While this is not the case in this particular case using the scoped gfp
> semantic is not really needed bacause we can easily pus the allocation
> context down the chain without too much clutter.

yeah, eesh, nack.

Given the amount of plumbing required here, it's clear that passing gfp
flags is the less safe way of doing it, and this really does belong in
the allocation context.

Failure to pass gfp flags correctly (which we know is something that
happens today, e.g. vmalloc -> pte allocation) means you're introducing
a deadlock.

