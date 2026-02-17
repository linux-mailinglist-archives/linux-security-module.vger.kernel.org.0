Return-Path: <linux-security-module+bounces-14707-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN0xBVM3lGlpAgIAu9opvQ
	(envelope-from <linux-security-module+bounces-14707-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Tue, 17 Feb 2026 10:39:31 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FCA14A7CA
	for <lists+linux-security-module@lfdr.de>; Tue, 17 Feb 2026 10:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 916DB3008766
	for <lists+linux-security-module@lfdr.de>; Tue, 17 Feb 2026 09:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34330F805;
	Tue, 17 Feb 2026 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvVPfUb6"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7430F552;
	Tue, 17 Feb 2026 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771321117; cv=none; b=fyi7rb0s1cfyEClve3zRa7Q06xqikUAeh/oQ+ySRZiwJm2PoByBm9KYO1r1uJLZ+1+RMvtpDXmjYZDELYovIpj5i1OZuZJoHSnph6PvfBehNCb8JwM6WQJV8BLU+nT48D9wTbvDzUkmh8tPE8D2Mh4powrCGk72+977dro8/ACc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771321117; c=relaxed/simple;
	bh=axSJ2gC8Rn7tlVNjob9xVqKHbQVyw9TBS+RRUPCUwZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na4Ce8Rv89HigHhM3Q9yGXgAsPUctX2742qCY9qYG5DHxhyusUdyOF+ESuvvAmEI0UYyo7OBe6QXHE4m+Y7oNFB7iML2iVxS1ukGfHMvaY5NnGrSNvqKbihfgiPNbJ+axuuKpMISm3H9lCaOa6+4v0Rlk9OBpBTNabiwnd2lfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvVPfUb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11284C4CEF7;
	Tue, 17 Feb 2026 09:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771321117;
	bh=axSJ2gC8Rn7tlVNjob9xVqKHbQVyw9TBS+RRUPCUwZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rvVPfUb6ejBStqjzD7N16rmj6UrDO5JuR2aP+XilSV13mxCjoNRzZiXqaKIso5Tdc
	 22jRJ/HLyNmvrJPmpoR+Xmx8uDELM7ugZ+hDJ0WCvEmCLWokzSKXNpz4vwibm78p4K
	 a2hIczZv9LgxR63/KG10N44my2h1DqXSyxy2C+8nllIZ3rVlT+z5JdS/rlN73pgo9O
	 VuNEX9C5FzoMG8+hXpQb4mDeBU1lcUJ53la8xRcJfPg92t1NaPq0UKK/2pjEpTn9eS
	 S4WNPClkm/yAPsLHMm7NGy2L5UkjVTKVho9EJTN6Mkh/xWhVYy387RTLSEOxyXRPdB
	 7vB8tGQwq0gQA==
Date: Tue, 17 Feb 2026 10:38:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] security: add LSM blob and hooks for namespaces
Message-ID: <20260217-glasur-hinnimmt-ac72b3e67661@brauner>
References: <20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org>
 <fb40e938-f6b2-45cf-b8ab-246cd6939582@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb40e938-f6b2-45cf-b8ab-246cd6939582@schaufler-ca.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14707-lists,linux-security-module=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-security-module@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-security-module];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 68FCA14A7CA
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 09:34:57AM -0800, Casey Schaufler wrote:
> On 2/16/2026 5:52 AM, Christian Brauner wrote:
> > All namespace types now share the same ns_common infrastructure. Extend
> > this to include a security blob so LSMs can start managing namespaces
> > uniformly without having to add one-off hooks or security fields to
> > every individual namespace type.
> 
> The implementation appears sound.
> 
> I have to question whether having LSM controls on namespaces is reasonable.

This is already in active use today but only in a very limited capacity.
This generalizes it.

> I suppose that you could have a system where (for example) SELinux runs
> in permissive mode except within a specific user namespace, where it would
> enforce policy. Do you have a use case in mind?

We will use it in systemd services and containers to monitor and
supervise namespaces.

