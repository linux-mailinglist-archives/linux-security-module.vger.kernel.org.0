Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F57036CD3D
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Apr 2021 22:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbhD0UzW (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 27 Apr 2021 16:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235416AbhD0UzW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Apr 2021 16:55:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2FA3961040;
        Tue, 27 Apr 2021 20:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619556878;
        bh=AwiTtd5vkDQuzzMVTo3n+DBNy3GA69ZpFqG3PG00hsA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tiI7wTmai6M1TopjYCoe0yHNIc/DM3Q90yP2HwXV7ejTJEi3aaMrrS6RdG/Q+zC9m
         Y7zVgJB2GzbPECVW9jhEdMOUHeaTPLTFyYf0j9to+UpxVXSYu+tvjlS/XZEUtVIXQR
         Zz13QUQBPYqvaQ4Ft0I8IFO60xHiviec6SoBrvcDevFNXltgTRVbXWqylZe7LwbPnb
         +hbRDpimVK7drGqzlNrY550Hgf7jG8QXh9BFBZwHrRtezWS+y0bniDW3uiaw7uPejC
         bv4daLatvic3v1pLY5OXlDfmGht+6vX7J6+ZHq38QiPPNSdQiGtXWdgMyn5YlWhT0L
         9Sc7rAv4u0H/A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2560E60A23;
        Tue, 27 Apr 2021 20:54:38 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQc7GguPxuN0cU2D0960LBcDK6fW1fHWyMkQCyxNZ_9FA@mail.gmail.com>
References: <CAHC9VhQc7GguPxuN0cU2D0960LBcDK6fW1fHWyMkQCyxNZ_9FA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQc7GguPxuN0cU2D0960LBcDK6fW1fHWyMkQCyxNZ_9FA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20210426
X-PR-Tracked-Commit-Id: e4c82eafb609c2badc56f4e11bc50fcf44b8e9eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1c921fb70de06c7eda59104470134aecc7a07c4
Message-Id: <161955687808.8723.17319027358639885057.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Apr 2021 20:54:38 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Mon, 26 Apr 2021 19:27:42 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20210426

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1c921fb70de06c7eda59104470134aecc7a07c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
