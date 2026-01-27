Return-Path: <linux-security-module+bounces-14228-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKa/HBUbeGnooAEAu9opvQ
	(envelope-from <linux-security-module+bounces-14228-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Jan 2026 02:55:33 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DEA8ED1A
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Jan 2026 02:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAA8C301808D
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Jan 2026 01:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCFB296BB6;
	Tue, 27 Jan 2026 01:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="Vm1bRwVE"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B04502A;
	Tue, 27 Jan 2026 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769478928; cv=none; b=tXV3JYzM0L9vTJGjaDtwLrZdZHN0HcWT4H6jzsEYQ3274TwCJbyMS1ppENs9A0HdsxhlQByz1dyoj/USQMwm2aaSJKYqp3sjDlQQgfaQFOke9mQ8CnKab1JYT3hP+iceIwCnywvWTIbkKY93/+AIQEj9qCftW3QalDPY+nI/Bcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769478928; c=relaxed/simple;
	bh=H61QH7wNaPdXc99Fa+/4nPwYWneJqTLK/cUtCuRzJ24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPCvv7BCN7OPBGSW31vuv8z9CJ40Ls05uzxvQ1LgP1cJnllNojOVXYbhsBAQaxBRvbKFoj6DJdikdmZs/75lVimM+q2AztlS2HEmwMmtfMEDQItpzjIzDR3fyFoyvMoDQVYqPTTvON56yf07lZPm4ev7pfIHjscbh9Vpufy/4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=Vm1bRwVE; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1769478435; bh=H61QH7wNaPdXc99Fa+/4nPwYWneJqTLK/cUtCuRzJ24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vm1bRwVET21e9xb5IjDrGXjVNZsN48mSlpiNYa7V+WzcdCxiKywtb5Br6zhCUaj7R
	 /vmhtpJJsNyWQ+fXnkDnX8vSW4AKTgZRVJoKOC6ecuk5rs1TJglNJ+XLOic4ZPVI2/
	 kugarJ8Il73+/zSTfgWibYFSR3hjn52V+qUwttfs0h32iowGGN0+gQu38uIH8WdS+c
	 GRLTbOAjlqEC2qXP9XzLzfon7smGRg4PNk1jUw+mfEtOyaqfh6sNgt+JkQalIdqBEc
	 EcO9X/RGaO3TO+VX/uECmI++zbaM7YEIWZEpdb+i9r3XBt+ZBaHYVN8u2HhJvwlohu
	 TWI3P+JzKT6Fw==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 0D3DB43D; Mon, 26 Jan 2026 19:47:15 -0600 (CST)
Date: Mon, 26 Jan 2026 19:47:15 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH] ucount: check for CAP_SYS_RESOURCE using
 ns_capable_noaudit()
Message-ID: <aXgZI1td0Hremulj@mail.hallyn.com>
References: <20260122140745.239428-1-omosnace@redhat.com>
 <CAHC9VhSgbHx4NcMVjMMk0D332b0DTEQi6dD_wO1fvQne-JVisw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSgbHx4NcMVjMMk0D332b0DTEQi6dD_wO1fvQne-JVisw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hallyn.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hallyn.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14228-lists,linux-security-module=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[hallyn.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[serge@hallyn.com,linux-security-module@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:email]
X-Rspamd-Queue-Id: C2DEA8ED1A
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:52:03PM -0500, Paul Moore wrote:
> On Thu, Jan 22, 2026 at 9:25 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The user.* sysctls implement the ctl_table_root::permissions hook and
> > they override the file access mode based on the CAP_SYS_RESOURCE
> > capability (at most rwx if capable, at most r-- if not). The capability
> > is being checked unconditionally, so if an LSM denies the capability, an
> > audit record may be logged even when access is in fact granted.
> >
> > Given the logic in the set_permissions() function in kernel/ucount.c and
> > the unfortunate way the permission checking is implemented, it doesn't
> > seem viable to avoid false positive denials by deferring the capability
> > check. Thus, do the same as in net_ctl_permissions() (net/sysctl_net.c)
> > - switch from ns_capable() to ns_capable_noaudit(), so that the check
> > never logs an audit record.
> >
> > Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  kernel/ucount.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

Looks good to me.  What tree should this go through?  Network?

