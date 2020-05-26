Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295AA1CA103
	for <lists+linux-security-module@lfdr.de>; Fri,  8 May 2020 04:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgEHCpF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 7 May 2020 22:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgEHCpE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 May 2020 22:45:04 -0400
Subject: Re: [GIT PULL] security: Fix the default value of
 fs_context_parse_param hook
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588905904;
        bh=jbzlnIkQDf+mSuSI4o/HjVxh4ISuq+Bo4gJsQYBzwm4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iNvAuJlVihS3un/C6oOekG+567upSrHPiWTkhroxIFUNJavvThl/z0kITLwjKsVUR
         WhhsnPfGu+Y55ML+tpd9CJl2zloRZHDtSPwIVwW0E8wur0s7nIZ5c9RZe+W7vBZ0iw
         4CA/VxIi80ceBjjDPJCRd0mz05QJqIJjfz8KTWIw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.2005080942390.15191@namei.org>
References: <alpine.LRH.2.21.2005080942390.15191@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.2005080942390.15191@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 for-v5.7
X-PR-Tracked-Commit-Id: 54261af473be4c5481f6196064445d2945f2bdab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79dede78c0573618e3137d3d8cbf78c84e25fabd
Message-Id: <158890590444.28720.16406974480455612819.pr-tracker-bot@kernel.org>
Date:   Fri, 08 May 2020 02:45:04 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, KP Singh <kpsingh@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Fri, 8 May 2020 09:45:11 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git for-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79dede78c0573618e3137d3d8cbf78c84e25fabd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
