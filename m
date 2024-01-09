Return-Path: <linux-security-module+bounces-879-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65804828EFF
	for <lists+linux-security-module@lfdr.de>; Tue,  9 Jan 2024 22:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892651C23D25
	for <lists+linux-security-module@lfdr.de>; Tue,  9 Jan 2024 21:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327243DBB0;
	Tue,  9 Jan 2024 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9lkYyb5"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134503DB8F;
	Tue,  9 Jan 2024 21:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDF51C433C7;
	Tue,  9 Jan 2024 21:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704836403;
	bh=kvsBYNbFTCF3Dytux3XmCSv2ryK9gn9krpSU9O4MDlI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u9lkYyb5O/WE2pJ8VL3uMYw0xKfHWrGs2zsk/I0su0JVM6ZaRrLBwR6nwvEwLcpRX
	 1ekuqbfmS+quxwq0Ls8xWRgOnYeU+5eiRHZ/Kc9vkvZp+/7qEd4IPwQvfEeIk1vefA
	 O7K2tbqwQyDzL1RqfYHXD2YqCo3WKK0AYYFB6u0XTqUMCMfop6uMPnb8hna2pn3J5q
	 woSTsKhtemuw1nQfj4GjxzeHij7b3D0+KuekzzaEZ8SkkUJOvaYW8mv1F+xdI4rYa7
	 sRS3bkR9nNAjHiicm0kghnOrVjBeOwWGSpcu4VBdauQSqZmlsFpIqgQcMbhDWMVKRj
	 xRJq0v3l3meZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA8BBD8C97D;
	Tue,  9 Jan 2024 21:40:03 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20240105
From: pr-tracker-bot@kernel.org
In-Reply-To: <7502247c0a4439b9bcf2c2ae315f2433@paul-moore.com>
References: <7502247c0a4439b9bcf2c2ae315f2433@paul-moore.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <7502247c0a4439b9bcf2c2ae315f2433@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240105
X-PR-Tracked-Commit-Id: bbf5a1d0e5d0fb3bdf90205aa872636122692a50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f9310bf87348e36a98ffa09c4e285908c14f592
Message-Id: <170483640372.1854.8716271357643713939.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 21:40:03 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Jan 2024 18:21:08 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240105

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f9310bf87348e36a98ffa09c4e285908c14f592

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

