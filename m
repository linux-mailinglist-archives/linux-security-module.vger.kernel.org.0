Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7205318EEF
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2019 19:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEIRZ0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 9 May 2019 13:25:26 -0400
Received: from namei.org ([65.99.196.166]:38266 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfEIRZZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 May 2019 13:25:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x49HPOMA025900;
        Thu, 9 May 2019 17:25:24 GMT
Date:   Fri, 10 May 2019 03:25:24 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Security subsystem: integrity updates for v5.2
Message-ID: <alpine.LRH.2.21.1905100323410.25349@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-194307007-1557422724=:25349"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-194307007-1557422724=:25349
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

From Mimi:
    
    "This pull request contains just three patches, the remainder are
    either included in other pull requests (eg. audit, lockdown) or will
    be upstreamed via other subsystems (eg. kselftests, Power). �Included
    in this pull request is one bug fix, one documentation update, and
    extending the x86 IMA arch policy rules to coordinate the different
    kernel module signature verification methods."

The following changes since commit fe9fd2ef383c2f5883fcd3f7adce0de9ce2556ff:

  Revert "security: inode: fix a missing check for securityfs_create_file" (2019-04-10 14:59:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-integrity

for you to fetch changes up to 2bfebea90dd5e8c57ae1021a5d1bb6c1057eee6d:

  Merge branch 'next-integrity-for-james' of git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity into next-integrity (2019-04-12 15:20:23 -0700)

----------------------------------------------------------------
James Morris (1):
      Merge branch 'next-integrity-for-james' of git://git.kernel.org/.../zohar/linux-integrity into next-integrity

Mimi Zohar (2):
      x86/ima: require signed kernel modules
      x86/ima: add missing include

Petr Vorel (1):
      doc/kernel-parameters.txt: Deprecate ima_appraise_tcb

 Documentation/admin-guide/kernel-parameters.txt |  5 ++---
 arch/x86/kernel/ima_arch.c                      | 10 +++++++++-
 include/linux/module.h                          |  5 +++++
 kernel/module.c                                 |  5 +++++
 4 files changed, 21 insertions(+), 4 deletions(-)
--1665246916-194307007-1557422724=:25349--
