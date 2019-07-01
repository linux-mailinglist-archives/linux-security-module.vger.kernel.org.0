Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6823625881
	for <lists+linux-security-module@lfdr.de>; Tue, 21 May 2019 21:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfEUTzX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 21 May 2019 15:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfEUTzW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 May 2019 15:55:22 -0400
Subject: Re: [GIT PULL] SELinux fixes for v5.2 (#1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558468522;
        bh=u27768RvRmrG6ljslQy4Ulxx7VFqp5XA2XQT7s4BOrI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=a/nRs9YpbrugpES6cewxUZrJmErj+Lc/t1xJZ/IOHAp1Ea+26BLPPfkbT30MNLdvI
         nGTC+DEpA94ziRKWMrp6HgE4O8B+2Fn4z1YZuutdLDCe6csArAC7vWuQzOJy8aW0qG
         NTpbp84G6UQ3V4zBYLLI/vqWnH2Rl8qO36BKI2WQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTvU7kQ7D8OwRPvc0tpjtXVK6FiiT07WuQyjtJ80TeQrQ@mail.gmail.com>
References: <CAHC9VhTvU7kQ7D8OwRPvc0tpjtXVK6FiiT07WuQyjtJ80TeQrQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTvU7kQ7D8OwRPvc0tpjtXVK6FiiT07WuQyjtJ80TeQrQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190521
X-PR-Tracked-Commit-Id: 05174c95b83f8aca0c47b87115abb7a6387aafa5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c7db5004280767566e91a33445bf93aa479ef02
Message-Id: <155846852224.2650.7566519227438481199.pr-tracker-bot@kernel.org>
Date:   Tue, 21 May 2019 19:55:22 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 21 May 2019 12:49:55 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190521

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c7db5004280767566e91a33445bf93aa479ef02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
