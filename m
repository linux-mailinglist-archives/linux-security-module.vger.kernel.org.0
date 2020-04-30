Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061DD1C0B1A
	for <lists+linux-security-module@lfdr.de>; Fri,  1 May 2020 01:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgD3XuP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 30 Apr 2020 19:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgD3XuN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Apr 2020 19:50:13 -0400
Subject: Re: [GIT PULL] SELinux fixes for v5.7 (#2)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588290613;
        bh=/RxoykwLQ6LsgORNuS+1y42Y9m3kK1OucyrMWfHPLpI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sgHIZNOFqdlHao+qX8wf2m49aGE5Kd1UN29kKmeqv1t75XJOagWTHT1Aw+bHsJRv2
         cdf4Dw7ULFbfmNXjgCG9sOklZ6qiL1HoOqumEiYxxciLsA/KbFua8USeC0sodwNIQX
         9niym380IWGLs42GmYGFLcMVOf5YqZL8u/m8N3WM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTu3YWPmwtA7RERHDRhQt0wAkmN4GJCmaRY7KSFRwtACQ@mail.gmail.com>
References: <CAHC9VhTu3YWPmwtA7RERHDRhQt0wAkmN4GJCmaRY7KSFRwtACQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTu3YWPmwtA7RERHDRhQt0wAkmN4GJCmaRY7KSFRwtACQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20200430
X-PR-Tracked-Commit-Id: fb73974172ffaaf57a7c42f35424d9aece1a5af6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39e16d93424b61e0b5bd182e308a56d5f0e489d6
Message-Id: <158829061335.2910.993997153559109286.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Apr 2020 23:50:13 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Thu, 30 Apr 2020 17:24:20 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20200430

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39e16d93424b61e0b5bd182e308a56d5f0e489d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
