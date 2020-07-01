Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF91F211349
	for <lists+linux-security-module@lfdr.de>; Wed,  1 Jul 2020 21:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgGATKL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 1 Jul 2020 15:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGATKK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Jul 2020 15:10:10 -0400
Subject: Re: [GIT PULL] Security subsystem fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593630610;
        bh=jLKz4rsOoFVw3/fsyO/V0r6Y1EZZJYT66gFiotM3VHY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ilQQJVGNgNK1FU6sAexneXWzBcUlg59aUZfEhG1Kdi+ixkbNfN36BrIhodsen29Vc
         fCpWY/BCzmC2AQsTSIRXPv2rIWnSVwRUTAx7yf8G/ZQbbK6Uxe+lXe3Kqkg8weAg6Q
         VH3yPAcoyhXuGb5CE4Wt7d/2ToEpS3W5RmHFIzrQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.2006300659080.10756@namei.org>
References: <alpine.LRH.2.21.2006300659080.10756@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.2006300659080.10756@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 tags/fixes-v5.8-rc3-a
X-PR-Tracked-Commit-Id: 23e390cdbe6f85827a43d38f9288dcd3066fa376
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 615bc218d628d90a3afebcfa772aa41865acd301
Message-Id: <159363061030.32760.2449826778122735864.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jul 2020 19:10:10 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 30 Jun 2020 07:00:03 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.8-rc3-a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/615bc218d628d90a3afebcfa772aa41865acd301

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
