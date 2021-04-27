Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5ED36CF85
	for <lists+linux-security-module@lfdr.de>; Wed, 28 Apr 2021 01:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhD0XV0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 27 Apr 2021 19:21:26 -0400
Received: from namei.org ([65.99.196.166]:53970 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239429AbhD0XVZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Apr 2021 19:21:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id E58508B0;
        Tue, 27 Apr 2021 23:16:37 +0000 (UTC)
Date:   Wed, 28 Apr 2021 09:16:37 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL][Security Subsystem] Fixes for v5.13
Message-ID: <bed5f880-9651-5ee1-c3c2-713c1ac194f0@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Please pull these minor fixes for the security subsystem for v5.13.

---

The following changes since commit f40ddce88593482919761f74910f42f4b84c004b:

  Linux 5.11 (2021-02-14 14:32:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.13

for you to fetch changes up to 049ae601f3fb3d5b1c1efdb434499770c96237f6:

  security: commoncap: clean up kernel-doc comments (2021-04-15 09:21:58 -0700)

----------------------------------------------------------------
Miscellaneous minor fixes for v5.13.

----------------------------------------------------------------
Arnd Bergmann (1):
      security: commoncap: fix -Wstringop-overread warning

Randy Dunlap (1):
      security: commoncap: clean up kernel-doc comments

 security/commoncap.c | 52 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 18 deletions(-)
