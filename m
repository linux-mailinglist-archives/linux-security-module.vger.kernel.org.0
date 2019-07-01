Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88863193CB
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2019 22:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfEIUuQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 9 May 2019 16:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfEIUuP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 May 2019 16:50:15 -0400
Subject: Re: [GIT PULL] Security subsystem: integrity updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557435014;
        bh=g+2mcgx4bHiy3PItu9Qw6gaIRAC0HYE1p0bNPlW7V54=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=osab8mhVKWSfmoRadwX0ZorJDP99P+w1oJ5nwxk4CoP6w2DmAoAxGA8nrzu2UEz3r
         DJuyV/VpudCxId3oKBYJ9YEGRMgeUMM+5EhFg5wj9BQeGdRTr7ttTYDWyJI67CatG6
         XFzyHX/+upNp1HrYwRZZ6ElM1UxWHYdUvrAJF++c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1905100323410.25349@namei.org>
References: <alpine.LRH.2.21.1905100323410.25349@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1905100323410.25349@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-integrity
X-PR-Tracked-Commit-Id: 2bfebea90dd5e8c57ae1021a5d1bb6c1057eee6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7664cd6e3a0b2709f04c07435e96c7c85e7d7324
Message-Id: <155743501450.12157.12215481746417595982.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 20:50:14 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Fri, 10 May 2019 03:25:24 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-integrity

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7664cd6e3a0b2709f04c07435e96c7c85e7d7324

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
