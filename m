Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069AA1F1062
	for <lists+linux-security-module@lfdr.de>; Mon,  8 Jun 2020 01:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgFGXUZ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 7 Jun 2020 19:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:32874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgFGXUZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 7 Jun 2020 19:20:25 -0400
Subject: Re: [GIT PULL] apparmor updates for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591572024;
        bh=K8Y9gTguNEjLWcNjeyv6g1Bzwf1U4ltlXcbuZFGecZU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H4mrmyO1TU4tdd3+rVcOUeR6F4xPGhCYUXYcxu9U1eePnJn9fEov1QuQ4g9TwjAL6
         o9ZWnyJ6/ZX65//x8TNDEmgE17LQJbJiWySiHuDMTOvMssLVl+RPDN0wmM1NPjmxz3
         J4makwvySAN3puqg6S8Jvvr/SS7lUc2nIcB8e4f8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9856bf93-c801-6831-fe9d-e12e43245f6f@canonical.com>
References: <9856bf93-c801-6831-fe9d-e12e43245f6f@canonical.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9856bf93-c801-6831-fe9d-e12e43245f6f@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
 tags/apparmor-pr-2020-06-07
X-PR-Tracked-Commit-Id: 3622ad25d4d68fcbdef3bc084b5916873e785344
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2b447066cacb6db82a1f69b46d9f894f695badf
Message-Id: <159157202469.17419.9226288427332705882.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Jun 2020 23:20:24 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Sun, 7 Jun 2020 14:12:54 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2020-06-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2b447066cacb6db82a1f69b46d9f894f695badf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
