Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35035240D31
	for <lists+linux-security-module@lfdr.de>; Mon, 10 Aug 2020 20:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgHJSzf (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 10 Aug 2020 14:55:35 -0400
Received: from namei.org ([65.99.196.166]:58356 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgHJSzf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Aug 2020 14:55:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 07AItXuf028307;
        Mon, 10 Aug 2020 18:55:33 GMT
Date:   Tue, 11 Aug 2020 04:55:33 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Security subsystem updates for v5.9
Message-ID: <alpine.LRH.2.21.2008110454190.26986@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

A couple of minor documentation updates only for this release. Please 
pull.

---

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/for-v5.9

for you to fetch changes up to bb22d80b47d5dd641d09d31946c4be0f610f3f45:

  LSM: drop duplicated words in header file comments (2020-08-06 12:00:17 -0700)

----------------------------------------------------------------
Minor fixes for v5.9.

----------------------------------------------------------------
Alexander A. Klimov (1):
      Replace HTTP links with HTTPS ones: security

Randy Dunlap (1):
      LSM: drop duplicated words in header file comments

 include/linux/lsm_hook_defs.h                    | 2 +-
 include/linux/lsm_hooks.h                        | 2 +-
 security/Kconfig                                 | 2 +-
 security/apparmor/Kconfig                        | 2 +-
 security/integrity/ima/Kconfig                   | 2 +-
 security/integrity/ima/ima_template.c            | 2 +-
 security/integrity/ima/ima_template_lib.c        | 2 +-
 security/integrity/ima/ima_template_lib.h        | 2 +-
 security/keys/encrypted-keys/ecryptfs_format.c   | 2 +-
 security/keys/encrypted-keys/ecryptfs_format.h   | 2 +-
 security/keys/encrypted-keys/encrypted.c         | 2 +-
 security/keys/encrypted-keys/masterkey_trusted.c | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)
