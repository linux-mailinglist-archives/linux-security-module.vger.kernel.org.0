Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8322829831D
	for <lists+linux-security-module@lfdr.de>; Sun, 25 Oct 2020 19:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418139AbgJYSfX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 25 Oct 2020 14:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418125AbgJYSfW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 25 Oct 2020 14:35:22 -0400
Subject: Re: [GIT PULL] SafeSetID changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603650922;
        bh=lcIcIKf9BHGLAzeZSpg8APnEWtS2Qc86wT+wS8lw7Ms=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z47+mnvIeYluX97dWzsQxp/Sm6tGsDjmjREfg4urG99k+XLvvJTAT64Cjjt6S6Plz
         P+x4ResjQpQn2fMBwK8D/Ggp7+gCWmA2MD2jXMDg4uqfTqrLw3cjOw/Ucb7z/qMG6f
         vVy/Uhk+bP+cst9izQ5qgEC6pv7aFttlWKcnUYDU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
References: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
X-PR-Tracked-Remote: https://github.com/micah-morton/linux.git tags/safesetid-5.10
X-PR-Tracked-Commit-Id: 03ca0ec138927b16fab0dad7b869f42eb2849c94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81ecf91eab1045c009b5d73408c44033ba86bb4d
Message-Id: <160365092234.20889.9139468711814756163.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Oct 2020 18:35:22 +0000
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Thu, 15 Oct 2020 11:15:18 -0700:

> https://github.com/micah-morton/linux.git tags/safesetid-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81ecf91eab1045c009b5d73408c44033ba86bb4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
