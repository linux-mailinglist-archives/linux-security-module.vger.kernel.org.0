Return-Path: <linux-security-module+bounces-14795-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMwoOeZfm2kmywMAu9opvQ
	(envelope-from <linux-security-module+bounces-14795-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Sun, 22 Feb 2026 20:58:30 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0993C1703C4
	for <lists+linux-security-module@lfdr.de>; Sun, 22 Feb 2026 20:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 855FF30091C0
	for <lists+linux-security-module@lfdr.de>; Sun, 22 Feb 2026 19:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001FC35BDBC;
	Sun, 22 Feb 2026 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SBJ+6oAl"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141516F288;
	Sun, 22 Feb 2026 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771790305; cv=none; b=AlIYgkxkOqLjGBQESFrEuQN4uLsB4YdDUO4RuHQYxlnjems76MHQTk5GWIjCuBt2SQRI75eCIN7cdhFdt6rENgQ8nJcMG4TqNpIFL8295CiFZAgu7TQQi6duzX8plHcgnHhh4O5rKoEJos0WBYxRAIgvJ3b/yjg4uHISGlrBGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771790305; c=relaxed/simple;
	bh=wEZ2iXj9fKWRKgqv3okN8kg0V6cL2BHzXcExwQymWNs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MSwJ67Ngk6ZVZkDb7SIfu6NKCSoEhFPo3/ihEKq9ltN48b2Er6/pv3cp+7FSVBzBY7Yu2zuNZMwTF56DknF1zzYDGO1+bnCc74pc6Zt2bH4Hq3Dw115xTpLiHsc84WfiUglrLQPeVxZW8Zk3UGjif9qjllxzcG5+JY2k6+KkxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SBJ+6oAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112FAC116D0;
	Sun, 22 Feb 2026 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771790305;
	bh=wEZ2iXj9fKWRKgqv3okN8kg0V6cL2BHzXcExwQymWNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SBJ+6oAlEn3KD3oKjm0R0Qv0TZ+RgCxgFZs5XghOt3Q6e1QrG7zURCQuASPxzgpHd
	 mfQHZ7gxSHpUT+2Gpijv81i4vFcqm6/7F0y90Cdj/9GnkTPmubXRth9subktg5LFgK
	 EIi9yPWuYxw2/hUAcAfPmJPn/QLkxBppPcqifBUg=
Date: Sun, 22 Feb 2026 11:58:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn"
 <serge@hallyn.com>, "Eric W . Biederman" <ebiederm@xmission.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
Subject: Re: [PATCH] ucount: check for CAP_SYS_RESOURCE using
 ns_capable_noaudit()
Message-Id: <20260222115824.37ae0de1eb183997a23669ae@linux-foundation.org>
In-Reply-To: <CAHC9VhQOW4BQR+UCvrcXa_yiSqADN0HC2Xp0pMKs3FtnjcVaOQ@mail.gmail.com>
References: <20260122140745.239428-1-omosnace@redhat.com>
	<CAHC9VhSgbHx4NcMVjMMk0D332b0DTEQi6dD_wO1fvQne-JVisw@mail.gmail.com>
	<aXgZI1td0Hremulj@mail.hallyn.com>
	<CAFqZXNve_7oKFWydUrskOcvsfbRZVKyWRmLvHKsTzBhG+RmEmQ@mail.gmail.com>
	<CAHC9VhQOW4BQR+UCvrcXa_yiSqADN0HC2Xp0pMKs3FtnjcVaOQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14795-lists,linux-security-module=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-security-module@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hallyn.com:email,linux-foundation.org:mid,linux-foundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0993C1703C4
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 17:09:40 -0500 Paul Moore <paul@paul-moore.com> wrote:

> > > > > Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
> > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > ---
> > > > >  kernel/ucount.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Acked-by: Serge Hallyn <serge@hallyn.com>
> > >
> > > Looks good to me.  What tree should this go through?  Network?
> >
> > Andrew has already applied the two patches I posted into his
> > mm-nonmm-unstable branch, so I assume they are set to go through his
> > tree.
> 
> Andrew, any chance we can get a reply to these threads when you merge
> a patch into your tree?

I already spray out soooo much email.

A better approach would be for me to become more chatty.  Reply
"thanks, applied <reasons> <caveats> <etc>".  Shall do this.


