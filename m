Return-Path: <linux-security-module+bounces-2099-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D057187C5C9
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Mar 2024 00:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADBF2824B4
	for <lists+linux-security-module@lfdr.de>; Thu, 14 Mar 2024 23:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFD6101CF;
	Thu, 14 Mar 2024 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZNXzVTY"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33323FC0E;
	Thu, 14 Mar 2024 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458042; cv=none; b=fVjTDfWm8QqvYzSVZeAaz87WQntNlfBr9kWahXiCkN750oMX1UNrV0Bf25gTMJzirjreoSXQFqv257MOsjCO9WJ/5Dp1kJTx0m1VP+i8+DRIglLrdN0I289x/t/xjwQP1f0XZPw6WDgFzFvu6Zhq7nJSiJtqjXL8thHX8cdj3f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458042; c=relaxed/simple;
	bh=4o8gVBNKrxwm+IikKUz9LM1qIFbrzYCFYBqgey5Ji9c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=imYBw45iN4vKaJci2tJkSGOcJAjuSGx3Nrfkl4uGj8Q7B1bGEvV/23uMubEwHFkg493B8ECraKmaK3qhtBfNxnkbdN988um2X+/y8mYrrJch6JWcd5pjscJ2rHv3hU9UEwiOjurQdu5ecDellkHCui+ba7RqwGRMSPNXFwMyRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZNXzVTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1441EC43390;
	Thu, 14 Mar 2024 23:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710458042;
	bh=4o8gVBNKrxwm+IikKUz9LM1qIFbrzYCFYBqgey5Ji9c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TZNXzVTYQA1N0m8FWj1GgvMNyBbO37OUlTQEuinyi7jLmToHTcRAqjx/RYLc4trLO
	 DVjAZCV3vUXUkwM2OUq90eARrRksb3pLh3xh2Y5nNSjz2j3M/9SYJESIFvfuQulDYv
	 c1KCghMnyxjhw1Jpodp3ZyEPaficasLNRRelI/lUtFaAnUbIXcZFeMFqw4X4wYXSCA
	 TdVaDq9FdCFYYe6QyNbhD8sCUgOcIHSYyc1pJQLaxQ6mszvjtQr/3hHTXc5QXkOHlg
	 w9uWuE01lKY4F1vdvN+bmQBthnxRkYQBFFlsJDRbqPfADZH0KLgIM69wgNxUWq2jVD
	 HdSlJZr56lh2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BA98D95055;
	Thu, 14 Mar 2024 23:14:02 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20240314
From: pr-tracker-bot@kernel.org
In-Reply-To: <3f2a695a148db9e1daae8c07d9ce5c85@paul-moore.com>
References: <3f2a695a148db9e1daae8c07d9ce5c85@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3f2a695a148db9e1daae8c07d9ce5c85@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240314
X-PR-Tracked-Commit-Id: eaf0e7a3d2711018789e9fdb89191d19aa139c47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0a614e82ece41d15b7a66f43ee79f4dbdbc925a
Message-Id: <171045804204.7563.1098860944707764914.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 23:14:02 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Mar 2024 16:31:05 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240314

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0a614e82ece41d15b7a66f43ee79f4dbdbc925a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

