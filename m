Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947F9698820
	for <lists+linux-security-module@lfdr.de>; Wed, 15 Feb 2023 23:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBOW5S (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 15 Feb 2023 17:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBOW5R (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Feb 2023 17:57:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E982EA5EC;
        Wed, 15 Feb 2023 14:57:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84C5461DE4;
        Wed, 15 Feb 2023 22:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E81DDC433D2;
        Wed, 15 Feb 2023 22:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676501835;
        bh=DGMyazRgF0IVnZtTrpH0KyNlUnskq8UeEyjWF8BqUZk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jpyWDAd+6Z4jjEQ7A14rH7XEHmgGp0Yn0ZATWFM09yx7JXkSigVPsdwJ2TVz/vfFl
         Ee2q5UF2zE9ohVllc+jvghcWDHIa8NHMNfKrY90amZfUUcbcgQGyO1ZBwLkjgNla86
         rIkxw2Z5ivVL6meYcJ9/V7Yb4JoX0KMwiVUn6Cf0U/6G35W1MJBcviNs8GwcS+gk/v
         o1bSuHqJDIVeqZC9/6FHAQpKYbp57Da13I/kk6DFq2NfZ/AVdyzV7L5cRury36+iJ5
         +WmHV+XRUOqMJMvMJmlcUohuIT3SgHi3mQqDVVjD6Z2122SL8enPVU/0pNzHonVU9L
         w4Juvvfap10DA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4212C4166F;
        Wed, 15 Feb 2023 22:57:15 +0000 (UTC)
Subject: Re: [GIT PULL] apparmor fix for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <442b2890-7b94-e2a1-91c6-6dac18d67463@canonical.com>
References: <442b2890-7b94-e2a1-91c6-6dac18d67463@canonical.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <442b2890-7b94-e2a1-91c6-6dac18d67463@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-v6.2-rc9
X-PR-Tracked-Commit-Id: cbb13e12a5d3ecef400716ea7d12a9268b0f37ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 033c40a89f55525139fd5b6342281b09b97d05bf
Message-Id: <167650183586.1740.18210642145263349664.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Feb 2023 22:57:15 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Wed, 15 Feb 2023 12:07:19 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-v6.2-rc9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/033c40a89f55525139fd5b6342281b09b97d05bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
