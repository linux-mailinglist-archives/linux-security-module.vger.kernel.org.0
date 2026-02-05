Return-Path: <linux-security-module+bounces-14526-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGuNCUfuhGkU6wMAu9opvQ
	(envelope-from <linux-security-module+bounces-14526-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Thu, 05 Feb 2026 20:23:51 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7655F6CE0
	for <lists+linux-security-module@lfdr.de>; Thu, 05 Feb 2026 20:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7992130233CD
	for <lists+linux-security-module@lfdr.de>; Thu,  5 Feb 2026 19:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608B2326957;
	Thu,  5 Feb 2026 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="szdqwHKn"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F2732694C;
	Thu,  5 Feb 2026 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770319411; cv=none; b=BJicJprDhI3WLGS4wV0LQjVfkfIAXoxIppvoYr0J+gl5KlveBDYu+uUcLFczGLqCKWmhH2RSJj7U5wXvC3DUtqQqOAZ+zI+hW2pzHs9kWmhGiNIxXmsZ1Ub1L2r/wT1uqlxrHUUzYuWp8L5+q1QSj6uVkHHYMsuy6PHRTLpJAIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770319411; c=relaxed/simple;
	bh=kRg/IBcvAtyUnZOkipr1zxtEK2FfjxbfOX0yX0hoFjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRNPkHeCxQLw/YibzopX6R/jlyNFGCF7Ux5XSY3zMDiQUw16TTy24buGvwr/AlaOYN+/RfNN8XNi75EgzEST056FzpO5zGrRMbHmSCGAvm1UGQqluoA2Itxt0SWWIBeJixCbYK1nGxkfsmJFpyx97b9gYqMMe44VYsQ4ta20I10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=szdqwHKn; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f6Rvt1FSQz7fg;
	Thu,  5 Feb 2026 20:23:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770319402;
	bh=QsJtEZ8pGXUCb+9wYn0ch99EM24e+hPlJh8dsHAxmOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szdqwHKn177DIba6I9Eb74Vp1w9LR6lrk4W8nEg8lR9Ues9Dlc2/Ws8MJEKAPjPMZ
	 PKt+ZKz6RhM/9CWuHKDe1hFFk7KwyzoDndWVNFLb8W60NrIfhOJQ9s3000/52Q4Ttq
	 JbaUXhWlmsSYt0Y60jbQLFV48uAbQQ+gaa7M7YR4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f6Rvs4Bg1zZHN;
	Thu,  5 Feb 2026 20:23:21 +0100 (CET)
Date: Thu, 5 Feb 2026 20:23:20 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: gnoack@google.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] landlock: documentation improvements
Message-ID: <20260205.Ohrao7yiegai@digikod.net>
References: <20260128031814.2945394-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260128031814.2945394-1-samasth.norway.ananda@oracle.com>
X-Infomaniak-Routing: alpha
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.75 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.91)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[digikod.net];
	TAGGED_FROM(0.00)[bounces-14526-lists,linux-security-module=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,linux-security-module@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-security-module];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7655F6CE0
X-Rspamd-Action: no action

Thanks for these improvements, it helps!  I'll send these changes for
Linux 7.0

On Tue, Jan 27, 2026 at 07:18:09PM -0800, Samasth Norway Ananda wrote:
> This patch series improves Landlock documentation by addressing gaps in
> ABI compatibility examples, adding errata documentation, and documenting
> the audit blockers field format.
> 
> Changes since v2:
> =================
> 
> Patch 1/3:
> - Handle restrict_flags in a separate code block, not in the switch
> - Clear all three ABI v7 logging flags for a generic example
> - Reference sys_landlock_restrict_self() for available flags
> - Use restrict_flags in landlock_restrict_self()
> 
> Patch 2/3:
> - Use kernel-doc directives to include errata from header files
> - Move rephrased ABI version text before errata section
> 
> Patch 3/3:
> - No changes
> 
> Changes since v1:
> =================
> 
> Patch 1/3:
> - Add backwards compatibility section for restrict flags
> - Fix /usr rule description
> 
> Patch 2/3:
> - Enhance existing DOC sections with Impact descriptions
> - Add errata usage documentation
> 
> Patch 3/3:
> - Document audit blocker field format
> 
> Samasth Norway Ananda (3):
>   landlock: add backwards compatibility for restrict flags
>   landlock: add errata documentation section
>   landlock: document audit blockers field format
> 
>  Documentation/admin-guide/LSM/landlock.rst | 20 ++++-
>  Documentation/userspace-api/landlock.rst   | 97 +++++++++++++++++++---
>  security/landlock/errata/abi-1.h           |  8 ++
>  security/landlock/errata/abi-4.h           |  7 ++
>  security/landlock/errata/abi-6.h           | 10 +++
>  security/landlock/syscalls.c               |  4 +-
>  6 files changed, 131 insertions(+), 15 deletions(-)
> 
> -- 
> 2.50.1
> 
> 

