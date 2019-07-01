Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDB318EDE
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2019 19:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfEIRXY (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 9 May 2019 13:23:24 -0400
Received: from namei.org ([65.99.196.166]:38258 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfEIRXX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 May 2019 13:23:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x49HNMvU025826;
        Thu, 9 May 2019 17:23:22 GMT
Date:   Fri, 10 May 2019 03:23:22 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] security subsytem: TPM changes for v5.2
Message-ID: <alpine.LRH.2.21.1905100320110.25349@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From Jarkko:

Bugfixes and new selftests for v5.1 features (partial reads in /dev/tpm0).


The following changes since commit 8d93e952fba216cd0811247f6360d97e0465d5fc:

  LSM: lsm_hooks.h: fix documentation format (2019-03-26 16:46:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

for you to fetch changes up to a94e55b91c7d1494c1a4598178dc5f1d7dfe12aa:

  Merge tag 'tpmdd-next-20190329' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm (2019-03-29 11:39:20 -0700)

----------------------------------------------------------------
James Morris (1):
      Merge tag 'tpmdd-next-20190329' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm

Jarkko Sakkinen (2):
      KEYS: trusted: allow trusted.ko to initialize w/o a TPM
      tpm: turn on TPM on suspend for TPM 1.x

Tadeusz Struk (3):
      selftests/tpm2: Open tpm dev in unbuffered mode
      selftests/tpm2: Extend tests to cover partial reads
      tpm: fix an invalid condition in tpm_common_poll

Yue Haibing (1):
      tpm: Fix the type of the return value in calc_tpm2_event_size()

ndesaulniers@google.com (1):
      KEYS: trusted: fix -Wvarags warning

 drivers/char/tpm/eventlog/tpm2.c           |  4 +-
 drivers/char/tpm/tpm-dev-common.c          |  9 ++++-
 drivers/char/tpm/tpm-interface.c           | 14 +++----
 include/keys/trusted.h                     |  2 +-
 security/keys/trusted.c                    | 32 +++++++++++----
 tools/testing/selftests/tpm2/tpm2.py       |  5 ++-
 tools/testing/selftests/tpm2/tpm2_tests.py | 63 ++++++++++++++++++++++++++++++
 7 files changed, 108 insertions(+), 21 deletions(-)
