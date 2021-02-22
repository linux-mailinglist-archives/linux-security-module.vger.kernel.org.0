Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77681320F06
	for <lists+linux-security-module@lfdr.de>; Mon, 22 Feb 2021 02:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhBVBVe (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 21 Feb 2021 20:21:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230151AbhBVBVc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 21 Feb 2021 20:21:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 976F164E61;
        Mon, 22 Feb 2021 01:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613956851;
        bh=9Ft49tSsns8fhCRLNTSgyf7vr+4Sm4bGOPGSBZ5IjNM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gTnDOSNrlYCnc/EtGEwrem5sVfAXLa37vqvab7jP261FEAfLrsWxdVIuIlPAI7G9p
         H+GmtWjNNnvxMhN2CrnjxsEG10oTd2izVbnGjevYZYfFg68ojLMhlhpnzzpasjXYzZ
         XOtzwZMm+Arq4HxfOAA+lXGLZB7tRX7KFTfVUYdko/yRgGPyjKwssZGrRiu/QKkqrc
         RCP7JKFyGOliyJpBuDtVuLKpMLzic2Alq/uNMjwq1wnuToffhSNSGLCalDSUVe1/lI
         OsgsO/6hGyxiOVPCsZvjR2NV5rEUtnhI7Tm5imQ5y/o3351rizE69WrUQGsW8O8Xn9
         VDYFkffMohIPg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 84B1760192;
        Mon, 22 Feb 2021 01:20:51 +0000 (UTC)
Subject: Re: [GIT PULL] tomoyo fixes for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1616df1b-0d97-2bdd-9d89-d4393fc837a0@i-love.sakura.ne.jp>
References: <1616df1b-0d97-2bdd-9d89-d4393fc837a0@i-love.sakura.ne.jp>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <1616df1b-0d97-2bdd-9d89-d4393fc837a0@i-love.sakura.ne.jp>
X-PR-Tracked-Remote: git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20210215
X-PR-Tracked-Commit-Id: 9c83465f3245c2faa82ffeb7016f40f02bfaa0ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e210761fb3ba172ecb44b717711af1d1b5d27cbf
Message-Id: <161395685148.836.18083713597357270038.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 01:20:51 +0000
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Mon, 15 Feb 2021 10:39:36 +0900:

> git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20210215

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e210761fb3ba172ecb44b717711af1d1b5d27cbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
