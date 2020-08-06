Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93FF23E02D
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Aug 2020 20:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgHFSKO (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 6 Aug 2020 14:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbgHFSJz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Aug 2020 14:09:55 -0400
Subject: Re: [GIT PULL] Smack patches for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596737394;
        bh=s2E2AZg9Rq24AcGg3lWK4zcwHLb91fKHlAzIexnkNv0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ShfW0YRIsAUEae61UgU1p62cG4v+u1kGD2Zg0tNwcn81g1WO4bWdKw7YHA/qKL3Cz
         ZT4+srS3tLUO7svGCBQ0am3+WlKPgMK4dhjsyq4cgNeRN+Z9hNJBMHH2UBZP0sU1gD
         4TDtiJlM6D69+Q6jlJg7dD9F9q6qSFTCjs2uxxmg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8ce85723-5656-0ee8-67a7-35597d9df0dd@schaufler-ca.com>
References: <8ce85723-5656-0ee8-67a7-35597d9df0dd.ref@schaufler-ca.com> <8ce85723-5656-0ee8-67a7-35597d9df0dd@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8ce85723-5656-0ee8-67a7-35597d9df0dd@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next smack-for-5.9
X-PR-Tracked-Commit-Id: 42a2df3e829f3c5562090391b33714b2e2e5ad4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfdd5aaa54b0a44d9df550fe4c9db7e1470a11b8
Message-Id: <159673739379.10708.792636659703040715.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Aug 2020 18:09:53 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 4 Aug 2020 10:49:09 -0700:

> https://github.com/cschaufler/smack-next smack-for-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfdd5aaa54b0a44d9df550fe4c9db7e1470a11b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
