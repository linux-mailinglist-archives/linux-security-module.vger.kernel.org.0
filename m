Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8476A14C4C6
	for <lists+linux-security-module@lfdr.de>; Wed, 29 Jan 2020 04:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgA2DAJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 28 Jan 2020 22:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgA2DAI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jan 2020 22:00:08 -0500
Subject: Re: [GIT PULL] TOMOYO patches for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580266807;
        bh=D3cPDI4K7/PsdNeu6mHnraNcz2hcxZmFu/xi1TDATao=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=05eOMiP9apHKCuRpddGe3XMpX5ogBmURio8aJVEkstmiQwzVyQo+8SJlUxx82r+c4
         MRpwZoiqKYp5r4psyQNxmf9fmz/t0x3Xwu+/7jx++Uwp8uo4aReSHWBDlgms/HTyY0
         ghU/AQzcE0FUaSmg9TCGAVkOwQcvqLh1M53uQzH4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cdf30cd3-8b0e-9014-0474-ce978e6bcc3b@i-love.sakura.ne.jp>
References: <cdf30cd3-8b0e-9014-0474-ce978e6bcc3b@i-love.sakura.ne.jp>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <cdf30cd3-8b0e-9014-0474-ce978e6bcc3b@i-love.sakura.ne.jp>
X-PR-Tracked-Remote: git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git
 tags/tomoyo-pr-20200128
X-PR-Tracked-Commit-Id: a8772fad0172aeae339144598b809fd8d4823331
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cf64d7cb20b04cf25e4ebffc37833298f1d4bde
Message-Id: <158026680738.3354.16013129913994048480.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 03:00:07 +0000
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 28 Jan 2020 13:17:03 +0900:

> git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20200128

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cf64d7cb20b04cf25e4ebffc37833298f1d4bde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
