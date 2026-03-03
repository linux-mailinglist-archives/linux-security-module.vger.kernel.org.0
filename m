Return-Path: <linux-security-module+bounces-15263-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oErJCp4hp2mMegAAu9opvQ
	(envelope-from <linux-security-module+bounces-15263-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Tue, 03 Mar 2026 18:59:58 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8199F1F4E34
	for <lists+linux-security-module@lfdr.de>; Tue, 03 Mar 2026 18:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CD4E305C6D2
	for <lists+linux-security-module@lfdr.de>; Tue,  3 Mar 2026 17:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD423D6686;
	Tue,  3 Mar 2026 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VGWMF9FC"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337FD3DEAF5
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560577; cv=none; b=HKzxtcPkOIRE3U5tL5NH57zdu93P4t104TLGFPoJFtuJnyPaRQjAXFlZtgbzaApQSaPclycGjQg/NOkKfqz+OgwsltmroO6Ztxiu/5TWLAzE30+Na5gHT55MxRKfaH51e+N0iYav6hi4HrBosIDYj+ozygipmn37To/F+3siK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560577; c=relaxed/simple;
	bh=5/Gvp2eCQvtcL1rVyEUIfBbRNPHWG/CB8kjWWdYQHyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2AjQRec1WPDbw3AV36GSWL8u+zKmREZ7RZgzRuznSTjry78H2h1zQYrmuyhiwMDRx47i639MHzWyA6BTRERvUSKPyq2sYDdqSiRT62uYy5RLMIInuKspffHH6mqkazMm6RYRN9cukPTrZ18f42+v6Ierk0KQXGLG0evMMseQKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VGWMF9FC; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fQNBv0q2tzZjV;
	Tue,  3 Mar 2026 18:31:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1772559095;
	bh=Iir+orx5t1mnrEsKm8XvxlPebDloR49W85SNaSbC0iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGWMF9FC0NxTVKdsZJDfpTpchA9uIBz3k0sWwMS3e+wUDwqxcnNkaiz814H3kGTZA
	 22YxSogeuqol98dNVugsgINc6JvqBr6jxMR6hISjELRD9TWi5/YZTaXzwxOmH1fINr
	 00gBVHWPpIoUADpqFATLBZD5NYWiHtvL0temSqqg=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fQNBt3n21ztMQ;
	Tue,  3 Mar 2026 18:31:34 +0100 (CET)
Date: Tue, 3 Mar 2026 18:31:32 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 0/2] landlock: Fix TSYNC deadlock and clean up error
 path
Message-ID: <20260303.Jijiez6IaT3f@digikod.net>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226015903.3158620-1-dingyihan@uniontech.com>
X-Infomaniak-Routing: alpha
X-Rspamd-Queue-Id: 8199F1F4E34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.43 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[digikod.net];
	FREEMAIL_CC(0.00)[gmail.com,paul-moore.com,google.com,vger.kernel.org,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[digikod.net:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15263-lists,linux-security-module=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,linux-security-module@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module,7ea2f5e9dfd468201817];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,digikod.net:dkim,digikod.net:mid]
X-Rspamd-Action: no action

Thanks!  It's been in -next since last week and I'll send a PR with it
soon.

On Thu, Feb 26, 2026 at 09:59:01AM +0800, Yihan Ding wrote:
> Hello,
> 
> This patch series fixes a deadlock in the Landlock TSYNC multithreading 
> support, originally reported by syzbot, and cleans up the associated 
> interrupt recovery path.
> 
> The deadlock occurs when multiple threads concurrently call 
> landlock_restrict_self() with sibling thread restriction enabled, 
> causing them to mutually queue task_works on each other and block 
> indefinitely.
> 
> * Patch 1 fixes the root cause by serializing the TSYNC operations 
>   within the same process using the exec_update_lock.
> * Patch 2 cleans up the interrupt recovery path by replacing an 
>   unnecessary wait_for_completion() with a straightforward loop break, 
>   avoiding Use-After-Free while unblocking remaining task_works.
> 
> Changes in v3:
> - Patch 1: Changed down_write_killable() to down_write_trylock() and
>   return -ERESTARTNOINTR on failure. This avoids a secondary deadlock 
>   where a blocking wait prevents a sibling thread from waking up to 
>   execute the requested TSYNC task_work. (Noted by Günther Noack. 
>   down_write_interruptible() was also suggested but is not implemented 
>   for rw_semaphores in the kernel).
> - Patch 2: No changes.
> 
> Changes in v2:
> - Split the changes into a 2-patch series.
> - Patch 1: Adopted down_write_killable() instead of down_write().
> - Patch 2: Removed wait_for_completion(&shared_ctx.all_prepared) and 
>   replaced it with a `break` to prevent UAF.
> 
> Link to v2: https://lore.kernel.org/all/20260225024734.3024732-1-dingyihan@uniontech.com/
> Link to v1: https://lore.kernel.org/all/20260224062729.2908692-1-dingyihan@uniontech.com/
> 
> Yihan Ding (2):
>   landlock: Serialize TSYNC thread restriction
>   landlock: Clean up interrupted thread logic in TSYNC
> 
>  security/landlock/tsync.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> -- 
> 2.51.0

