Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127E926C8F0
	for <lists+linux-security-module@lfdr.de>; Wed, 16 Sep 2020 21:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgIPTAe (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 16 Sep 2020 15:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbgIPTAc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Sep 2020 15:00:32 -0400
Subject: Re: [GIT PULL] security: device_cgroup RCU warning fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600282831;
        bh=oaz8HL1otIoKWjPUlvmLiJY79GIVto05KDjnxKyQ4nk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=guvbKrT61V/fj3s96sP3Xpa9fvlv9j2/QU7T0tM+hEQS4QxWYDyQsPbX8DuDZUHu8
         sAu5a1tPk+duUM36rA2BNUPKSTSQpfdeRL4YRlR99PbWa2GVFMhs/jlgCtSUwqD6zF
         8cQuSSgvKF14DI3W3ouT9nvvUfog4af9P5Y6ERwA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.2009160619400.8445@namei.org>
References: <alpine.LRH.2.21.2009160619400.8445@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.2009160619400.8445@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.9a
X-PR-Tracked-Commit-Id: bc62d68e2a0a69fcdcf28aca8edb01abf306b698
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e484d388773b0a984236a181fb21e133630df42
Message-Id: <160028283109.10613.12855946136222501469.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Sep 2020 19:00:31 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Wed, 16 Sep 2020 06:21:29 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.9a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e484d388773b0a984236a181fb21e133630df42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
