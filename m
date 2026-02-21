Return-Path: <linux-security-module+bounces-14782-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCPlKw8JmWn1PAMAu9opvQ
	(envelope-from <linux-security-module+bounces-14782-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Sat, 21 Feb 2026 02:23:27 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 373DB16BB52
	for <lists+linux-security-module@lfdr.de>; Sat, 21 Feb 2026 02:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2098730FB1D8
	for <lists+linux-security-module@lfdr.de>; Sat, 21 Feb 2026 01:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D6C3595D;
	Sat, 21 Feb 2026 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjQ5wYdk"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9B31AF2D;
	Sat, 21 Feb 2026 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771636809; cv=none; b=sC9oMNllwWKZwwp+xCbv42YW1vY19g6HZzSyaOR6n3n+wQNaXpUsuaGOir8RhdF1SBpk0cMQzCAL720Z5XbIonwBrmRFjl0o8S7qZBClD2kHmIbZT+jICJgkJZnOHEpRGLaEURRVeCEBpzIAOei+J+1Zn7gEo2z1GOgK/oaNSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771636809; c=relaxed/simple;
	bh=D4tiRqbE1qhtLricor++xQezV4qoEWZDqtwrIuTtUVI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GLoRHyYoZSMgkvC5N5woigC41vqN7kZ0nVEJyHUEKFUHqhejSm+EqMsswc9+a1X9kuyND+uRWcpjif5nrnphWsPWk3PhJM55HQUqdVORsIxnrc918hPmJYZqb7bEgOQqgQxAzm/BvIx8G3kJxEcv58cIKwwlHwf0J5fpUUoVwbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjQ5wYdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E80C2BC86;
	Sat, 21 Feb 2026 01:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771636809;
	bh=D4tiRqbE1qhtLricor++xQezV4qoEWZDqtwrIuTtUVI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FjQ5wYdkXRK0ZGXXTNNTEgAP/b2Ewuwku42Xuuc2VyekDW8W16qZLuLA/Ro1EUQbs
	 WSKukKGRB0yzzlI/2XQP+0YHccU0W7Kh9pnY4wWnt4pC2M1/ajTBmTNmL1lIrC4QLb
	 wn5yKaaSKyWlfycuBEdl7Sq0brXluwMPkAMjyCOTCF60rQy1T2GaRnX0Dxo9tF722D
	 gFDLPN7bDl/uvN7ggIluajQ82AiYTl18q8653tI7ZAnMdb38uSzviz5cZEE5C6igUQ
	 W7Uy1Hhhv2c8KgWpgJuOwhx+tYwoL7bCwIilKlyIoJ3v8baueoFFGYHxcfj9MbSegs
	 /j3WvuSXkUxNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEDF3808200;
	Sat, 21 Feb 2026 01:20:18 +0000 (UTC)
Subject: Re: [GIT PULL] AppArmor updates for 7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <53c39cf4-d9e4-4ccf-ae16-dc5b143c9681@canonical.com>
References: <53c39cf4-d9e4-4ccf-ae16-dc5b143c9681@canonical.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <53c39cf4-d9e4-4ccf-ae16-dc5b143c9681@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-02-18
X-PR-Tracked-Commit-Id: 08020dbe3125e936429e7966bf072e08fa964f36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 219d7660c57ec7457a6020f3d025cfe1139ffc64
Message-Id: <177163681718.969912.6524294585851395256.pr-tracker-bot@kernel.org>
Date: Sat, 21 Feb 2026 01:20:17 +0000
To: John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKLM <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-14782-lists,linux-security-module=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-security-module@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 373DB16BB52
X-Rspamd-Action: no action

The pull request you sent on Wed, 18 Feb 2026 16:19:34 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-02-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/219d7660c57ec7457a6020f3d025cfe1139ffc64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

