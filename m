Return-Path: <linux-security-module+bounces-14656-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJrODgIZjWngywAAu9opvQ
	(envelope-from <linux-security-module+bounces-14656-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Thu, 12 Feb 2026 01:04:18 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E44E1286B8
	for <lists+linux-security-module@lfdr.de>; Thu, 12 Feb 2026 01:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC3C2301BBA7
	for <lists+linux-security-module@lfdr.de>; Thu, 12 Feb 2026 00:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDD53EBF0C;
	Thu, 12 Feb 2026 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deM35gBZ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0992B33E7;
	Thu, 12 Feb 2026 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770854653; cv=none; b=ZXdkZxwR0HmJH7MfJyPdmYsEe3ugEqfC0OSjxh55X9BiGuymg/+VIdz/sLAuz1igkq1PONPUgfzPFPw+wbwYDdvC3J2GT6YT9sY3LCrovOwZ3v/3QTh1o3HMTtgb5CsXvBRL81wB20F7hzIkU12iEpwqpqkFIODHsXJCP7yxh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770854653; c=relaxed/simple;
	bh=9+4vj33P0pyMKcBzYxVbvPh2z3dFZIgCkpq8VYUskaU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H61QudkAXxTSgWLaaBMev6C/WMCzklqgpElOB6oCVuZbYGO0XC2Uam2pW4eVbR/eTSGKF1GWkzNCxg4orEInhqMVgGG7x0rsjRC1sywCKjjfkOzs56uE2AGks+HMR92uR0zV69E6SOlOigxvMYZvRyHxV9bIVe0qoXHvlBS+v+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deM35gBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BEEC4CEF7;
	Thu, 12 Feb 2026 00:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770854652;
	bh=9+4vj33P0pyMKcBzYxVbvPh2z3dFZIgCkpq8VYUskaU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=deM35gBZ9RUmUN1/ZKGG1JXShVh4sHJmiJCkxK6Ls266lgOuEjAAwBEVgWb8dHMj1
	 NKE2qXsLdD4Pfzd8/LgdQuBDs0N5sE5Y6DKfIug+ZU+57g3N6X0t9MVPO6WrrpRHaB
	 PKCtcMtVDVD8vNU+U3O2LICnGFz6xjUuW9OiiTD5o+DFJ7/KFC2K+KcYHK/yNAvw8e
	 uS8MlV6WpCGEKzFTVTmIVaQZU2gzEYaQFUE1HlcKgFLNbE8mAnYGW6bZhn/lcCvilM
	 QYUCRkU48SFXM4fv2O7XYDbq712VGSVEgyM6PXwnMBqll04QxAJZaFtnQVTT/eFk8m
	 +ehnPHWVqnrdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8561539EF966;
	Thu, 12 Feb 2026 00:04:08 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <28dea16f-18c3-4a2f-821c-e85b660125ed@schaufler-ca.com>
References: <28dea16f-18c3-4a2f-821c-e85b660125ed.ref@schaufler-ca.com> <28dea16f-18c3-4a2f-821c-e85b660125ed@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <28dea16f-18c3-4a2f-821c-e85b660125ed@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-7.0
X-PR-Tracked-Commit-Id: 33d589ed60ae433b483761987b85e0d24e54584e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 146fa666d89f233b87f1cdc7b9bce34c61b45cbd
Message-Id: <177085464704.803048.12676574365773070452.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 00:04:07 +0000
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LSM List <linux-security-module@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Konstantin Andreev <andreev@swemel.ru>, Taimoor Zaeem <taimoorzaeem@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,swemel.ru,gmail.com,schaufler-ca.com];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-14656-lists,linux-security-module=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-security-module@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E44E1286B8
X-Rspamd-Action: no action

The pull request you sent on Mon, 9 Feb 2026 13:15:00 -0800:

> https://github.com/cschaufler/smack-next tags/Smack-for-7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/146fa666d89f233b87f1cdc7b9bce34c61b45cbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

