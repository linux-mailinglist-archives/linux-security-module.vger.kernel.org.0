Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2476F1A82E
	for <lists+linux-security-module@lfdr.de>; Sat, 11 May 2019 17:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfEKPAP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 11 May 2019 11:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbfEKPAP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 11 May 2019 11:00:15 -0400
Subject: Re: [GIT PULL] security subsystem: Tomoyo updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557586814;
        bh=T6pVOfdptkOhickgXKdhwoX33PocrD0eTvc02KmYvUk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N5yOzackAgnUMLRvtQOZyVRD0VD3APVCA+K6FlsF7Qd9WCL2bSsWhamgNHsfVqxKs
         bb6w0WJG6poqm8kvVJQIR44UetonQ+mAW489K60S4KBQ04jJUcOKIac1cazl6ES9bg
         4RecJY8C4Vuh0GmqvXXA2AQiO2uwvcHZwRbJFLdg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1905110801350.9392@namei.org>
References: <alpine.LRH.2.21.1905110801350.9392@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1905110801350.9392@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-tomoyo2
X-PR-Tracked-Commit-Id: 4ad98ac46490d5f8441025930070eaf028cfd0f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c367dc8d0dd2a1e1ed9fdc2dd831053bdfdf0968
Message-Id: <155758681477.22634.12296218789154770772.pr-tracker-bot@kernel.org>
Date:   Sat, 11 May 2019 15:00:14 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Sat, 11 May 2019 08:09:22 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tomoyo2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c367dc8d0dd2a1e1ed9fdc2dd831053bdfdf0968

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
