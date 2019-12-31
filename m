Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7569912DB38
	for <lists+linux-security-module@lfdr.de>; Tue, 31 Dec 2019 20:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfLaTpJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 31 Dec 2019 14:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfLaTpI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 31 Dec 2019 14:45:08 -0500
Subject: Re: [GIT PULL] tomoyo fixes for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577821507;
        bh=TMZ9nFmfu8e8CoXb06vsJ87Jepx8RgHod/W8wgbiVXY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PqVUHKGjdFWaThE1CT2PybILOqJqjb38FuLFAhpK5GCLK22UBy2no045lrqv8flgp
         /KGAlIP2VsYDafnQ8xhmltixkKfEdCPwKF1GnCABcxREWLNc7UBQqc8QsBkEYA691Q
         84aPoCSrk6dpjJ+mCcprA+BQpYa9QYsBGLXIHDbk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8483f2c2-626d-382f-3994-ee29daebff75@i-love.sakura.ne.jp>
References: <8483f2c2-626d-382f-3994-ee29daebff75@i-love.sakura.ne.jp>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <8483f2c2-626d-382f-3994-ee29daebff75@i-love.sakura.ne.jp>
X-PR-Tracked-Remote: git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git master
X-PR-Tracked-Commit-Id: 6bd5ce6089b561f5392460bfb654dea89356ab1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5c928c667cd1e34cbcac6af5b7c2f9f4512d612
Message-Id: <157782150758.7858.11815825056089969574.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Dec 2019 19:45:07 +0000
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Mon, 30 Dec 2019 20:31:40 +0900:

> git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5c928c667cd1e34cbcac6af5b7c2f9f4512d612

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
