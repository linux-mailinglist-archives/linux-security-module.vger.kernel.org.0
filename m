Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B646669D32E
	for <lists+linux-security-module@lfdr.de>; Mon, 20 Feb 2023 19:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjBTStk (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 20 Feb 2023 13:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjBTStX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Feb 2023 13:49:23 -0500
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc09])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0888D21968
        for <linux-security-module@vger.kernel.org>; Mon, 20 Feb 2023 10:48:52 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PLBJ356sPzMqt3H;
        Mon, 20 Feb 2023 19:48:03 +0100 (CET)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4PLBJ314zbzMrwPZ;
        Mon, 20 Feb 2023 19:48:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1676918883;
        bh=hVfHEerBKXsl326AUtLr0OsMICrLU9pTDknupkbU7QE=;
        h=From:To:Cc:Subject:Date:From;
        b=V+ORSoh4pZtYUDkVuopdST1gS2ViQG+uJc2VpnnoU65d0ci7Ez/RgXnpXssRjwr3X
         5IVCIxCJpzeXob81mm3WCPQCG1NsIwQ4eD4uvvIJ4D1Zcd7J5XU5s6Ff0Z9l1Y9wnw
         gtX5Z41kwO5UdTuA1DKu4H8UcVlxQf/8lUGC2Khw=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Jeff Xu <jeffxu@google.com>, Paul Moore <paul@paul-moore.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock updates for v6.3
Date:   Mon, 20 Feb 2023 19:47:22 +0100
Message-Id: <20230220184722.573397-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

This PR improves documentation, and makes some tests more flexible to be
able to run on systems without overlayfs or with Yama restrictions.

Please pull this Landlock changes for v6.3-rc1 .  These commits merged
cleanly with your tree, and have been successfully tested in the latest
linux-next releases for a few weeks.

Regards,
 Mickaël

--
The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.3-rc1

for you to fetch changes up to 1c1ea1c3e21d5ba0867f84f6ad04090bd477df25:

  MAINTAINERS: Update Landlock repository (2023-02-10 09:41:55 +0100)

----------------------------------------------------------------
Landlock updates for v6.3-rc1

----------------------------------------------------------------
Jeff Xu (2):
      selftests/landlock: Skip overlayfs tests when not supported
      selftests/landlock: Test ptrace as much as possible with Yama

Mickaël Salaün (2):
      landlock: Explain file descriptor access rights
      MAINTAINERS: Update Landlock repository

 Documentation/security/landlock.rst            |  34 +++++++-
 MAINTAINERS                                    |   2 +-
 tools/testing/selftests/landlock/fs_test.c     |  47 ++++++++++
 tools/testing/selftests/landlock/ptrace_test.c | 113 +++++++++++++++++++++----
 4 files changed, 175 insertions(+), 21 deletions(-)
