Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399AC2E2900
	for <lists+linux-security-module@lfdr.de>; Thu, 24 Dec 2020 23:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgLXWQC (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 24 Dec 2020 17:16:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgLXWQB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Dec 2020 17:16:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 06B8C22AAA;
        Thu, 24 Dec 2020 22:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608848121;
        bh=Bd8VX02xWTtsq1T0uej5Eqbo5albsMaKez49Cj68ro0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CNbfeWZKfZBZZy3VRr7VcFEAq0XDndTUtdtMRKn6Rh48DUhJ+FWOWLivKa5QGHHLR
         YEqIDwh8IRhpCy1NslVbIP06l2BxIFvSTJDBxwADFLhEjvfIWf/UKcaigyRMhhmhx/
         xbE3n1QbneWR809Umd0nf6ZqsksXhvBPhsScpohtYt+J9/TOU9ovEIBKOo+7kodcqX
         yImDDierkGkK3/c8ur22KyCSJFSnA2ifJnsTmyx8uAusVJ/e3EkxRl15zvwb4vVqFq
         d0qsgNy3dHH+webfOAYkpYmT5QRo9XA/hm1TWY2FVKJ/I8HSCRX2bEZ9K8ibgv27pv
         j6skSXAPgEqYw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id E8EDC604E9;
        Thu, 24 Dec 2020 22:15:20 +0000 (UTC)
Subject: Re: [GIT PULL] Smack additional patch for v5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b73e7af1-25d3-1e68-c810-3858abc489d7@schaufler-ca.com>
References: <b73e7af1-25d3-1e68-c810-3858abc489d7.ref@schaufler-ca.com> <b73e7af1-25d3-1e68-c810-3858abc489d7@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b73e7af1-25d3-1e68-c810-3858abc489d7@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next smack-for-5.11
X-PR-Tracked-Commit-Id: 942cb357ae7d9249088e3687ee6a00ed2745a0c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f2fce3d535779cb1b0d77ce839029d5d875d4f4
Message-Id: <160884812088.9963.4935181452697151471.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Dec 2020 22:15:20 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 22 Dec 2020 16:43:25 -0800:

> https://github.com/cschaufler/smack-next smack-for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f2fce3d535779cb1b0d77ce839029d5d875d4f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
