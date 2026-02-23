Return-Path: <linux-security-module+bounces-14837-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAm2Mw19nGm6IQQAu9opvQ
	(envelope-from <linux-security-module+bounces-14837-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Feb 2026 17:15:09 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 573B9179871
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Feb 2026 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48773313140D
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Feb 2026 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AEC30B50B;
	Mon, 23 Feb 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ODPQHPnu"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00599309F00
	for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863019; cv=none; b=OQ6MlNooB1gOldNq3ZZEC4o/SWrlkNWqvyOFMMoOk3RSyXaQ6dQmGKTk8A3fAMDswFq3NOFy+/zsVJzaOi9eCq72ZMWE34MepX7YhFmIiuiprFbKNKvtkrtP5pjwO5QPgUIh0il7jxDu3Nnzo8xpV7+fpluccrNz7R+zA2mKl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863019; c=relaxed/simple;
	bh=77ntk9rOtcp+xgTzAdrvYo/WHcxuAj7l6n0abPHLSbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoIKtKDxgRPK72Ibon9pS0kewjhbGUhaIsywFmdUu2NJWEQpdgSwi/7TuT4MUxaQiMv4NVQ+uuurWRmNh9V1LXBWmvipe3CWBcBTlUq/1BLR6SOwgWdBklJ4S8a9ABD92oABtH4GMsoULfvhYKSb4pb4DIvVP04n8A5PWC/K6NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ODPQHPnu; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fKQmb0P65zKlg;
	Mon, 23 Feb 2026 17:10:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771863006;
	bh=jAzWxSI3wqQfKfAB6gkR84EB3yGj/DcEwYjAFJPCs+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODPQHPnuauNwvfTHRxDTdjd8OXlQ7s/hZYuP/fDmLGHkSa/E0Le5lzgjoGHzbjQ02
	 /8ecTpwFp/N5Y5vJxuGPL52W20SNoJT2rxyNVeURIJt0e0SwghDfDUaC5U3BywJT2q
	 yuOU9W+7Lg3dW3ViYZTLQQy7rikPwPUOqGYtWTio=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fKQmX71qKzBVx;
	Mon, 23 Feb 2026 17:10:04 +0100 (CET)
Date: Mon, 23 Feb 2026 17:09:53 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	brauner@kernel.org, demiobenour@gmail.com, fahimitahera@gmail.com, hi@alyssa.is, 
	horms@kernel.org, ivanov.mikhail1@huawei-partners.com, jannh@google.com, 
	jmorris@namei.org, john.johansen@canonical.com, konstantin.meskhidze@huawei.com, 
	linux-security-module@vger.kernel.org, m@maowtm.org, matthieu@buffet.re, netdev@vger.kernel.org, 
	paul@paul-moore.com, samasth.norway.ananda@oracle.com, serge@hallyn.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v6] lsm: Add LSM hook security_unix_find
Message-ID: <20260223.oom0ae8Pohs9@digikod.net>
References: <aZcPd3OKqxwCZV-5@suesslenovo>
 <20260219200459.1474232-1-utilityemal77@gmail.com>
 <20260220.70d0460d1309@gnoack.org>
 <aZmxpoy1oxSl5yGq@suesslenovo>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZmxpoy1oxSl5yGq@suesslenovo>
X-Infomaniak-Routing: alpha
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.75 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.91)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14837-lists,linux-security-module=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,alyssa.is,huawei-partners.com,google.com,namei.org,canonical.com,huawei.com,vger.kernel.org,maowtm.org,buffet.re,paul-moore.com,oracle.com,hallyn.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,linux-security-module@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-security-module];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,digikod.net:mid,digikod.net:dkim]
X-Rspamd-Queue-Id: 573B9179871
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 08:22:46AM -0500, Justin Suess wrote:
> On Fri, Feb 20, 2026 at 04:49:34PM +0100, Günther Noack wrote:
> > Hello!
> > 
> > On Thu, Feb 19, 2026 at 03:04:59PM -0500, Justin Suess wrote:
> > > diff --git a/security/security.c b/security/security.c
> > > index 67af9228c4e9..c73196b8db4b 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
> > >  
> > >  #endif	/* CONFIG_SECURITY_NETWORK */
> > >  
> > > +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> > > +/**
> > > + * security_unix_find() - Check if a named AF_UNIX socket can connect
> > > + * @path: path of the socket being connected to
> > > + * @other: peer sock
> > > + * @flags: flags associated with the socket
> > > + *
> > > + * This hook is called to check permissions before connecting to a named
> > > + * AF_UNIX socket.
> > 
> > Nit: Could we please insert a sentence about locking here?
> > 
> > Something like:
> > 
> >   The caller holds no locks on @other.
> > 
> > (Originally brought up by Mickaël in
> > https://lore.kernel.org/all/20260217.lievaS8eeng8@digikod.net/)
> > 
> > Thanks,
> > –Günther
> Sounds good. Would a "Link:" to the mentioned thread be appropriate in the commit
> message?

Feel free to include relevant parts of our discussion in the commit
message, which would make a Link redundant.  I think a Link is useful if
the commit message doesn't contain the whole context or misses
information, which is often the case wrt discussions or long emails.

> 
> I feel like the reasoning for this is subtle but important for hook
> consumers.

Indeed.  That should be explained in the hook comment.

> 
> Justin
> 

