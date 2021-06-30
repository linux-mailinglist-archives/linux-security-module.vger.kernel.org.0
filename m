Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8BB3B8A7E
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Jul 2021 00:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhF3Wgi (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 30 Jun 2021 18:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232724AbhF3Wge (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Jun 2021 18:36:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 642816147E;
        Wed, 30 Jun 2021 22:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625092445;
        bh=B0KkVEPxeN97BE/6lmXR6PmYefr7Q016ebncgqnE5Cw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U5jjUQf550JrLTM4v5EFc4DmdWZKy8wPQ16ROduKjIen9kQvPdjedCrSiRcfqyONl
         XiHdCxM5GRfMsh4u4he5skWH0ayBz6NaK806UUTyrjgJGAb6LGJ18zXQRZFWzg803N
         FUcedKxKODqRRSPS3RuX/VM2vCmZVM4P1Bc8Nu7lyW3RlHSm9S/M8YhD9LyuEsRiAr
         Aiftrz6MhzzrnkSZoxkVzfn68pyDkABnlx7MuJX/2Q5QJouVA71Ou0NwEjHOrXY/Fr
         U6LkoQUoHwbZw3Q46gJe83n0V7JK8vSl5Ac9dlUxThI50xNi2GuIj2UqtUT6hNp344
         in4ie56U6pcaA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5ECC4609D8;
        Wed, 30 Jun 2021 22:34:05 +0000 (UTC)
Subject: Re: [GIT PULL] SafeSetID changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJ-EccODUD45ZFgqqSxwZ9-DkqJL7F9fYOiHt+2tLZBss3VoAA@mail.gmail.com>
References: <CAJ-EccODUD45ZFgqqSxwZ9-DkqJL7F9fYOiHt+2tLZBss3VoAA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJ-EccODUD45ZFgqqSxwZ9-DkqJL7F9fYOiHt+2tLZBss3VoAA@mail.gmail.com>
X-PR-Tracked-Remote: https://github.com/micah-morton/linux.git tags/safesetid-5.14
X-PR-Tracked-Commit-Id: 1b8b719229197b7afa1b1191e083fb41ace095c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92183137e6c14b68ff4de51f6ef371b2b1fe6e68
Message-Id: <162509244538.2480.7233563406303797176.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 22:34:05 +0000
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Wed, 30 Jun 2021 10:22:11 -1000:

> https://github.com/micah-morton/linux.git tags/safesetid-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92183137e6c14b68ff4de51f6ef371b2b1fe6e68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
