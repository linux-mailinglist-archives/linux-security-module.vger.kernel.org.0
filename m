Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8E419A1FE
	for <lists+linux-security-module@lfdr.de>; Wed,  1 Apr 2020 00:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgCaWio (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 31 Mar 2020 18:38:44 -0400
Received: from namei.org ([65.99.196.166]:44640 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgCaWin (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 31 Mar 2020 18:38:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02VMcaod016023;
        Tue, 31 Mar 2020 22:38:36 GMT
Date:   Wed, 1 Apr 2020 09:38:36 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Security subsystem updates for 5.7
Message-ID: <alpine.LRH.2.21.2004010936310.15848@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Two minor updates for the core security subsystem:

- kernel-doc warning fixes from Randy Dunlap
- header cleanup from YueHaibing

Please pull.

---

The following changes since commit 10c2d111c906599942efd13109061885631c4a0c:

  security: remove EARLY_LSM_COUNT which never used (2020-01-27 11:19:41 -0800)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/jmorris/linux-security next-general

for you to fetch changes up to 3e27a33932df104f4f9ff811467b0b4ccebde773:

  security: remove duplicated include from security.h (2020-02-21 08:53:48 -0800)

----------------------------------------------------------------
Randy Dunlap (1):
      security: <linux/lsm_hooks.h>: fix all kernel-doc warnings

YueHaibing (1):
      security: remove duplicated include from security.h

 include/linux/lsm_hooks.h | 36 +++++++++++++++++++++++++++++++++++-
 include/linux/security.h  |  1 -
 2 files changed, 35 insertions(+), 2 deletions(-)
