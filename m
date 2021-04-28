Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CCB36D0A3
	for <lists+linux-security-module@lfdr.de>; Wed, 28 Apr 2021 04:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhD1Co2 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 27 Apr 2021 22:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235422AbhD1Co1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Apr 2021 22:44:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 94EF2613BF;
        Wed, 28 Apr 2021 02:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619577823;
        bh=sHYjtFfEQNiXpCeTMcprDBstLSJOrWLBqhGEntxJohw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XnwOiJxnNMZgYF789KQ8ngoNCJuuhcDrZ1MPOQ6vjMB5mlHjMZc1RKA/m6pw29+P+
         nwK/V07VFUh+Oh1M53SYsnjw14Xht1OjURGfdSPV+j/VjypfxpsEsi7UOaOkod8X4i
         1E7OnomCRIF61+bro6iDW4S9FvPgHDF9sBHV7UOIsraZ+cNpdVD5xyGStb/Y5Sk0KW
         voq2zexyx7F3PvNbRIYddTTPIOJIwK5sNuuRPQ9ZQBPVARUjKXIDyTVFgm6W6XJtty
         VQgrup2jeLKpTtwHBdYgLzp2uR3zVA+radnoH+y3cjXDVPaxPHha31/JqGrOLBIJRX
         djK5lL8jZigSQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8AA7560A23;
        Wed, 28 Apr 2021 02:43:43 +0000 (UTC)
Subject: Re: [GIT PULL][Security Subsystem] Fixes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bed5f880-9651-5ee1-c3c2-713c1ac194f0@namei.org>
References: <bed5f880-9651-5ee1-c3c2-713c1ac194f0@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bed5f880-9651-5ee1-c3c2-713c1ac194f0@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.13
X-PR-Tracked-Commit-Id: 049ae601f3fb3d5b1c1efdb434499770c96237f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acd3d28594536e9096c1ea76c5867d8a68babef6
Message-Id: <161957782350.6484.6716461834501073563.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 02:43:43 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Wed, 28 Apr 2021 09:16:37 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acd3d28594536e9096c1ea76c5867d8a68babef6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
