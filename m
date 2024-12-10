Return-Path: <linux-security-module+bounces-6989-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A1A9EB90B
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Dec 2024 19:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059A1281985
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Dec 2024 18:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD792046A0;
	Tue, 10 Dec 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jLCYgM0u"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1568D1A9B31
	for <linux-security-module@vger.kernel.org>; Tue, 10 Dec 2024 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854126; cv=none; b=sGx2R5C9+GYDfHLRKrO3Bu6tfsJrDGDVf02Yf9Yt6SXmldKpDkxST6PTRY7l22ZomRmuFmeunS+DpUQPlcaW+RIRIxAo846ETam/DLxPz/XKmHZjnDm7Q5rHmhqP72Zn4on9T0mjtQRMYLu1GT1rCMjUg55g8KT1zQXrO0YZMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854126; c=relaxed/simple;
	bh=0L32j+48L5/C1ckA1+9PzTkc44tytvDkq0fJxShThLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3swrskWL3EQLQdCa6Wvngt7GnqhHUSHoE38xz+20VroxzDitp68qURFOCeoJCiJSX3bRxy+AvOKgCUDBZhGRKkAcuQNRRCs5JS9WGlhicQzTs5hBWqAy8rMELfMw25vdt78uQR6RcphUXVy4YCPKlXUTn/A3+9vPh2JHmaalQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jLCYgM0u; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y76DV1BdKzdph;
	Tue, 10 Dec 2024 19:08:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1733854122;
	bh=0qopliW3n6b/P0mt1erYYhpZSXGN8vK7req/A45Wx7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jLCYgM0uiGQdRHXKO9NOloAT+UHCGUFuzgYnVgKEI9Lecp6ZCc/Rx0mXCiJqGzhRR
	 KxHrn7Smeg+DYvHXTsRZc+Zxky2EPwwUBgqTiIFjDrlGpq7dX9ePKJJ3VtRJxKkkrL
	 6MavwNLSBURLg3vdKjjiCUOTGVGscy13PAzJgYGE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y76DT4TGpzPBb;
	Tue, 10 Dec 2024 19:08:41 +0100 (CET)
Date: Tue, 10 Dec 2024 19:08:38 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Paul Moore <paul@paul-moore.com>
Cc: gnoack@google.com, willemdebruijn.kernel@gmail.com, matthieu@buffet.re, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH v2 7/8] landlock: Add note about errors consistency
 in documentation
Message-ID: <20241210.kohGhez4osha@digikod.net>
References: <20241017110454.265818-1-ivanov.mikhail1@huawei-partners.com>
 <20241017110454.265818-8-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017110454.265818-8-ivanov.mikhail1@huawei-partners.com>
X-Infomaniak-Routing: alpha

On Thu, Oct 17, 2024 at 07:04:53PM +0800, Mikhail Ivanov wrote:
> Add recommendation to specify Landlock first in CONFIG_LSM list, so user
> can have better LSM errors consistency provided by Landlock.
> 
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
>  Documentation/userspace-api/landlock.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index bb7480a05e2c..0db5eee9bffa 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -610,7 +610,8 @@ time as the other security modules.  The list of security modules enabled by
>  default is set with ``CONFIG_LSM``.  The kernel configuration should then
>  contains ``CONFIG_LSM=landlock,[...]`` with ``[...]``  as the list of other
>  potentially useful security modules for the running system (see the
> -``CONFIG_LSM`` help).
> +``CONFIG_LSM`` help). It is recommended to specify Landlock first of all other
> +modules in CONFIG_LSM list since it provides better errors consistency.

This is partially correct because Landlock may not block anything
whereas another LSM could deny a network action, with potentially a
wrong error code.  I don't think this patch is worth it, especially
because other LSMs have bugs that should be fixed.

>  
>  Boot time configuration
>  -----------------------
> -- 
> 2.34.1
> 
> 

