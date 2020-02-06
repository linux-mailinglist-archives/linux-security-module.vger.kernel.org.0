Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21653154008
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Feb 2020 09:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgBFIUR (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 6 Feb 2020 03:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgBFIUR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Feb 2020 03:20:17 -0500
Subject: Re: [GIT PULL] Smack patch for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580977216;
        bh=+a8SlHhRX279q2JAwWIk7frfnbVohQ6cL/UcWS0GeC4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e7UofIQxwpu0b5wkUFYZsK6p77PWWqdkpgJNwAm01NW+IMfmr0NL3ppwrGDPZwU8g
         VNcnIr3AzVwZibobzN7vwKklh9v0NFsL9rme6Fk8OxhkpIYzWSemXqOy3sagJ1Wj2P
         LTyLpr+HR8mkQz5vbPlKFlpAKhnhp6Htwd5OKshU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7300e604-6fb5-16b1-4e1b-dfae7b494853@schaufler-ca.com>
References: <7300e604-6fb5-16b1-4e1b-dfae7b494853.ref@schaufler-ca.com>
 <7300e604-6fb5-16b1-4e1b-dfae7b494853@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7300e604-6fb5-16b1-4e1b-dfae7b494853@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next
 tags/Smack-for-5.6
X-PR-Tracked-Commit-Id: 87fbfffcc89b92a4281b0aa53bd06af714087889
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85e5529625f0e41beefe8939eb08baf33131f7d6
Message-Id: <158097721690.4470.13197189246194891263.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Feb 2020 08:20:16 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Wed, 5 Feb 2020 18:07:09 -0800:

> https://github.com/cschaufler/smack-next tags/Smack-for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85e5529625f0e41beefe8939eb08baf33131f7d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
