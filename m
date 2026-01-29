Return-Path: <linux-security-module+bounces-14295-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JfFOvTEe2mDIQIAu9opvQ
	(envelope-from <linux-security-module+bounces-14295-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Thu, 29 Jan 2026 21:37:08 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6099AB4453
	for <lists+linux-security-module@lfdr.de>; Thu, 29 Jan 2026 21:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55A8330053C1
	for <lists+linux-security-module@lfdr.de>; Thu, 29 Jan 2026 20:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE9134F47C;
	Thu, 29 Jan 2026 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vT7B+e8u"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29945038
	for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769719019; cv=none; b=CQ7epVH0I2QfHqTOKinDaOds1C9nl4ljTuoZBmIT8nX9uEVnQrDDbOZpludiutryEhrLhSZgapeSrrPgDvN3F01MJ9nOMd22an6WQsoUqTgEK2dmPeVUY4fRzKKzM8cOm6WHU58scX18hUqAQFjYR4FHS7WLpnakkLtwHNlnci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769719019; c=relaxed/simple;
	bh=3gC0Rg9b6VONKUcbhdQMHXo9NfmHjjAj9ycEhmsh6Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6KvuniaptywZWTV8A46hOKKp7ZwfJN/s5H2xNmKaaJHDlWo7Dun8ElD03cxKblYv9VOWV2CCc/Q4sA1uEfhNTsNx5OsUETvo2ygIBT+vzsXGCPyHXWJZtrBhjst1Com+GDAwDPP4FLURUNNG12DT6yNZAnpRuVqrrSVpNaw0uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vT7B+e8u; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f29gz5tpxzBx3;
	Thu, 29 Jan 2026 21:28:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1769718495;
	bh=Y7cy+8QeB8eAJk4LN9dN+l3zJNxrSxky3jIbSSoDZfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vT7B+e8ucPx0NTttoY+XEhWrF+Bgkzl7IWzrGpn5d5NWYEviuN0EpL1aBEzsDeuJ8
	 Ay9357qlyKv+ZGijE+Xa2juRbovZSDdLC1+Tp6pmyGPzl2ecPjn50q1GZXPOvsEIc1
	 Q5LuEEvLcOTHWP9lY2urAo3grVjYa9tOoze9ot2k=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f29gy4N1TzWGK;
	Thu, 29 Jan 2026 21:28:14 +0100 (CET)
Date: Thu, 29 Jan 2026 21:28:08 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/3] landlock: transpose the layer masks data structure
Message-ID: <20260129.oozohZah1Uth@digikod.net>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-4-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260125195853.109967-4-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.99 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,maowtm.org,gmail.com,oracle.com,buffet.re,huawei-partners.com,huawei.com,infradead.org];
	DKIM_TRACE(0.00)[digikod.net:+];
	TAGGED_FROM(0.00)[bounces-14295-lists,linux-security-module=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,linux-security-module@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,digikod.net:mid,digikod.net:dkim]
X-Rspamd-Queue-Id: 6099AB4453
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 08:58:53PM +0100, Günther Noack wrote:
> The layer masks data structure tracks the requested but unfulfilled
> access rights during an operation's security check.  It stores one bit
> for each combination of access right and layer index.  If the bit is
> set, that access right is not granted (yet) in the given layer and we
> have to traverse the path further upwards to grant it.
> 
> Previously, the layer masks were stored as arrays mapping from access
> right indices to layer_mask_t.  The layer_mask_t value then indicates
> all layers in which the given access right is still (tentatively)
> denied.
> 
> This patch introduces struct layer_access_masks instead: This struct
> contains an array with the access_mask_t of each (tentatively) denied
> access right in that layer.
> 
> The hypothesis of this patch is that this simplifies the code enough
> so that the resulting code will run faster:
> 
> * We can use bitwise operations in multiple places where we previously
>   looped over bits individually with macros.  (Should require less
>   branch speculation and lends itself to better loop unrolling.)
> 
> * Code is ~75 lines smaller.
> 
> Other noteworthy changes:
> 
> * In no_more_access(), call a new helper function may_refer(), which
>   only solves the asymmetric case.  Previously, the code interleaved
>   the checks for the two symmetric cases in RENAME_EXCHANGE.  It feels
>   that the code is clearer when renames without RENAME_EXCHANGE are
>   more obviously the normal case.
> 
> Tradeoffs:
> 
> This change improves performance, at a slight size increase to the
> layer masks data structure.
> 
> At the moment, for the filesystem access rights, the data structure
> has the same size as before, but once we introduce the 17th filesystem
> access right, it will double in size (from 32 to 64 bytes), as
> access_mask_t grows from 16 to 32 bit.  See the link below for
> measurements.
> 
> Link: https://lore.kernel.org/all/20260120.haeCh4li9Vae@digikod.net/

When adding extra links, please add a [1] reference at the end and use
this reference in the commit message.

> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  security/landlock/access.h  |  10 +-
>  security/landlock/audit.c   |  84 +++------
>  security/landlock/audit.h   |   3 +-
>  security/landlock/domain.c  |  45 +++--
>  security/landlock/domain.h  |   4 +-
>  security/landlock/fs.c      | 352 ++++++++++++++++--------------------
>  security/landlock/net.c     |  11 +-
>  security/landlock/ruleset.c |  88 ++++-----
>  security/landlock/ruleset.h |  21 ++-
>  9 files changed, 274 insertions(+), 344 deletions(-)

