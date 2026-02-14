Return-Path: <linux-security-module+bounces-14671-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPX4ARfhkGlmdgEAu9opvQ
	(envelope-from <linux-security-module+bounces-14671-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Sat, 14 Feb 2026 21:54:47 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6766C13D332
	for <lists+linux-security-module@lfdr.de>; Sat, 14 Feb 2026 21:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5829F301453D
	for <lists+linux-security-module@lfdr.de>; Sat, 14 Feb 2026 20:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D22E5B19;
	Sat, 14 Feb 2026 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R998b/P7"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C221A76DE;
	Sat, 14 Feb 2026 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771102484; cv=none; b=UU+GsrlwTQ5Dja5Uqp/zSDFeDXs/SX219TaWmfWOHLlusIUR/miKcveF8Bfk2rowpAPOqE2sqa03Lo+aWRiZuCUAdT1Krhp2QzD+DydxppLxvx6Q69AdL1CJCx6jsnmF6kNzpIn8kj6dtCc5vQFdNIk/ax2PEbmoQ75zIOHMonM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771102484; c=relaxed/simple;
	bh=Y2HTKx5VO/7pX5rg1LrdHs9CjOb3NDLxWUujW2W8QYk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=APvM5fgKnwFXK8k+GxFdRY9lCztoVyTtP0nPTeLEgMDjJSHzS683BVuQNREa0Sm6XX7Isdyf7q4DH/5Ft6jnmJ+34HNINs0ieQLa75avzU2mM3lpn0ZW4fkt8t5Iixt3BCCgzX7IXswA9e1Rm9rxQAv8U/BMMtbRDjTfQSmPZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R998b/P7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C143C19422;
	Sat, 14 Feb 2026 20:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771102484;
	bh=Y2HTKx5VO/7pX5rg1LrdHs9CjOb3NDLxWUujW2W8QYk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R998b/P7zJsTMaqh71p8neYvfWMF7ENnZdIdX1oe/LVSxUvdYrDdnC7LMLKCsfVMu
	 B17wUsNLrm21hkp4Ko7+IkWNO6SR5i8usVtOGK11E0ZTShFIPwJlVdDDqF1ybdkB1U
	 FqwFvnk0juTYYDOQavJIaQePRxMQwOQHw3qsKpIV6vpFxWvjiy+Ao3SIobp6EkEAND
	 HA4xtUw7TaXZegWIjMLnfRlrkU351DJFbuZVVUTaDjqTQ4KzDdU/Ek5/x+kC9ltv4C
	 GQpnvQpdv9mqQvMelPFr9eGgLPUWGzMMXHxIFU4GKblwyiLH9lsOU2CUt7c1oBgiBb
	 GZZh1c92QDcSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C2221393091E;
	Sat, 14 Feb 2026 20:54:38 +0000 (UTC)
Subject: Re: [GIT PULL] capabilities update for v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <aY+sOhXciC+Xerwo@mail.hallyn.com>
References: <aY+sOhXciC+Xerwo@mail.hallyn.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aY+sOhXciC+Xerwo@mail.hallyn.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20260213
X-PR-Tracked-Commit-Id: 071588136007482d70fd2667b827036bc60b1f8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6179d7a630c2747e2a9329149de2a7aa67a95978
Message-Id: <177110247729.2897141.15869524764740333202.pr-tracker-bot@kernel.org>
Date: Sat, 14 Feb 2026 20:54:37 +0000
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, Ryan Foster <foster.ryan.r@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,paul-moore.com,vger.kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14671-lists,linux-security-module=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-security-module@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6766C13D332
X-Rspamd-Action: no action

The pull request you sent on Fri, 13 Feb 2026 16:56:58 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20260213

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6179d7a630c2747e2a9329149de2a7aa67a95978

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

