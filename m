Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7671321ABF
	for <lists+linux-security-module@lfdr.de>; Mon, 22 Feb 2021 16:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhBVPFq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 22 Feb 2021 10:05:46 -0500
Received: from smtp-190e.mail.infomaniak.ch ([185.125.25.14]:55693 "EHLO
        smtp-190e.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230133AbhBVPFp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Feb 2021 10:05:45 -0500
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DklpY6mVJzMq5lT;
        Mon, 22 Feb 2021 16:04:53 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DklpY3Lhvzlpq04;
        Mon, 22 Feb 2021 16:04:52 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/1] Automatic LSM stack ordering
Date:   Mon, 22 Feb 2021 16:06:07 +0100
Message-Id: <20210222150608.808146-1-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

This patch series gives the opportunity to users to not manually
configure the list of LSM enabled at boot but instead always rely on the
up-to-date list of existing LSMs.  Indeed, CONFIG_LSM may never be
updated with a make oldconfig whereas users may select new LSMs over
time.  With this patch, when running make oldconfig, a new option
CONFIG_LSM_AUTO is pre-selected to delegate LSM ordering to the kernel
developers, according to the user configuration.

This third series replace the previous virtual dependencies with a new
option to automatically enable all selected LSMs.  This is cleaner,
simpler, and makes the transition more convenient.

This patch series can be applied on v5.11-7580-gea914b7ffbfd (or v5.11).
Previous version:
https://lore.kernel.org/r/20210215181511.2840674-1-mic@digikod.net

Mickaël Salaün (1):
  security: Add CONFIG_LSM_AUTO to handle default LSM stack ordering

 security/Kconfig    | 19 +++++++++++++++++++
 security/security.c | 26 +++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)


base-commit: 31caf8b2a847214be856f843e251fc2ed2cd1075
-- 
2.30.0

