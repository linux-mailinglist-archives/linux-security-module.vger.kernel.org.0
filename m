Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234143B8A7A
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Jul 2021 00:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhF3Wgd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 30 Jun 2021 18:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhF3Wgc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Jun 2021 18:36:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0DE6961469;
        Wed, 30 Jun 2021 22:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625092443;
        bh=TFMn0fKbMGoLdQaWKKcnvS4bWRJTTA+Uej136tQWgys=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pzx7XcH4jZDSVecN+RdnWMGt1lskSgZffAHBtp+vHH+uTqOJQakOy9rYCkAWk9QQ+
         ynGQv+EZd9tdgG1axqCPqHi947LaIRHxQOAUYyNYr915rGL4V3y6OZOJ1w6wr1kAl5
         pMKZNbIT463p+OkRvbCJrnDpfPHL0cEsOdN911Okt+vdLUGDjq6YUkWYfe7gYU6sxL
         pSMhCFlQoHBnQEJXpALbvQds4GAHDcGIT2HTj+cn6WopQPhqTlg7d/R9C5OoU/g4Sm
         so0tgQWo+KxGvly6DYzwPkwRCyg7/xjdbd1sGiLfdsVKbY0vcUmjPgt5tvakBCtQhb
         Ca3yDa1XzWE1A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ECD18609D8;
        Wed, 30 Jun 2021 22:34:02 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQb03J_9yWKViZb+wD=pMfFQb+FyYwHYndYZTfRdJ8oLg@mail.gmail.com>
References: <CAHC9VhQb03J_9yWKViZb+wD=pMfFQb+FyYwHYndYZTfRdJ8oLg@mail.gmail.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQb03J_9yWKViZb+wD=pMfFQb+FyYwHYndYZTfRdJ8oLg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20210629
X-PR-Tracked-Commit-Id: d99cf13f14200cdb5cbb704345774c9c0698612d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bd344e55f73f7ae671bf5c1ebe5bd814f3c4b27
Message-Id: <162509244290.2480.16459133091878287398.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 22:34:02 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 29 Jun 2021 17:36:01 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20210629

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bd344e55f73f7ae671bf5c1ebe5bd814f3c4b27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
