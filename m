Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 717C018F1B
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2019 19:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfEIR2u (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 9 May 2019 13:28:50 -0400
Received: from namei.org ([65.99.196.166]:38274 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfEIR2u (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 May 2019 13:28:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x49HSnbA026139;
        Thu, 9 May 2019 17:28:49 GMT
Date:   Fri, 10 May 2019 03:28:49 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Security subsystem: Smack updates for v5.2
Message-ID: <alpine.LRH.2.21.1905100325330.25349@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From Casey: "There's one bug fix for IPv6 handling and two memory use 
improvements."

Plus a couple of further bugfixes.

The following changes since commit fe9fd2ef383c2f5883fcd3f7adce0de9ce2556ff:

  Revert "security: inode: fix a missing check for securityfs_create_file" (2019-04-10 14:59:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-smack

for you to fetch changes up to 8d31a5c35ed179825a2145881ad7cd8f9907d94b:

  Merge branch 'smack-for-5.2-b' of https://github.com/cschaufler/next-smack into next-smack (2019-05-06 20:24:51 -0700)

----------------------------------------------------------------
Casey Schaufler (3):
      Smack: Create smack_rule cache to optimize memory usage
      Smack: Fix IPv6 handling of 0 secmark
      Smack: Fix kbuild reported build error

James Morris (3):
      Merge branch 'smack-for-5.2' of https://github.com/cschaufler/next-smack into next-smack
      Merge branch 'smack-for-5.2-b' of https://github.com/cschaufler/next-smack into next-smack
      Merge branch 'smack-for-5.2-b' of https://github.com/cschaufler/next-smack into next-smack

Tetsuo Handa (1):
      smack: Check address length before reading address family

Vishal Goel (1):
      smack: removal of global rule list

 security/smack/smack.h     |  1 +
 security/smack/smack_lsm.c | 34 +++++++++++++++++++++++-----
 security/smack/smackfs.c   | 55 ++++++++++++++--------------------------------
 3 files changed, 45 insertions(+), 45 deletions(-)
