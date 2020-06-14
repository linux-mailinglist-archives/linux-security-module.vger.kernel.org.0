Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF481F8A3A
	for <lists+linux-security-module@lfdr.de>; Sun, 14 Jun 2020 20:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgFNSzb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 14 Jun 2020 14:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgFNSza (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Jun 2020 14:55:30 -0400
Subject: Re: Re: [GIT PULL] SafeSetID LSM changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592160930;
        bh=lL1fGKkbZyXCQL2eS48VPf72RgVcfhKh0JitOJrCACI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XE839U3V2su0tyYzkgMs0yUglaKFI8iPJUiWpeubVn4TMR8wYsgzJusk2DwRiUo2u
         CyhizDAUqAf3BdURJVibXgpIAZEa0OAUV55o7LZ8/01wx8dTTHabQJzU25Me4Ody7G
         ZU7ZaE7ooKcP5EZfKzKyINBFm4AGOuQgOyT0o7r4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
 <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
 <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
X-PR-Tracked-Remote: https://github.com/micah-morton/linux.git
 tags/LSM-add-setgid-hook-5.8-author-fix
X-PR-Tracked-Commit-Id: 39030e1351aa1aa7443bb2da24426573077c83da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a87b197c1da6b16608d5110709e0b3308e25dcd
Message-Id: <159216093006.5153.590414223047911199.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Jun 2020 18:55:30 +0000
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Sun, 14 Jun 2020 11:03:58 -0700:

> https://github.com/micah-morton/linux.git tags/LSM-add-setgid-hook-5.8-author-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a87b197c1da6b16608d5110709e0b3308e25dcd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
