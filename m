Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8632D64BBB3
	for <lists+linux-security-module@lfdr.de>; Tue, 13 Dec 2022 19:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiLMSNs (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 13 Dec 2022 13:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbiLMSNn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Dec 2022 13:13:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF2F21E16;
        Tue, 13 Dec 2022 10:13:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8095B815B4;
        Tue, 13 Dec 2022 18:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 670C1C433EF;
        Tue, 13 Dec 2022 18:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670955218;
        bh=uOGGovyRo10ItJsqJlbXaYB3/VhGvdeoz1mxh4zRRHM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OgNjM1wk2xJQbyBDjJdnvKljZAZ4YA0LVy7qciaiikd7K8QmhNBBm4njmCV3ONRGH
         l8zlKsyWTCSEbZZypWkgEvGWWj/WPV+JOPa1p6yINh7BtwKkGpJt8+gfCNZQiWWQn0
         Rc8BLJOBxwXaGnR2d5RbtPyV+3TgF1WIlBOQLe2sopBGr51sCtY3xkKKubUZrw3Hs+
         qJUscV+yYSTyL5FumojQQ/riDCIQsTOSk9+/LBw6w//jho08ldIgAYNr9EQerrvV5Y
         on8MlEl3WLph0ixV3wRv38wPWpNAZwA+ZdZAIsqZvT3Ajuck/9nOYMjkr3Sap2hOpP
         pbg6Ud5XprYXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55CFEC00445;
        Tue, 13 Dec 2022 18:13:38 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212121918.1315195-1-mic@digikod.net>
References: <20221212121918.1315195-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212121918.1315195-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.2-rc1
X-PR-Tracked-Commit-Id: f6e53fb2d7bd70547ba53232415976cb70ad6d97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 299e2b1967578b1442128ba8b3e86ed3427d3651
Message-Id: <167095521834.23919.6522052360251251026.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 18:13:38 +0000
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Mon, 12 Dec 2022 13:19:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/299e2b1967578b1442128ba8b3e86ed3427d3651

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
