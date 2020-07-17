Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5822426B
	for <lists+linux-security-module@lfdr.de>; Fri, 17 Jul 2020 19:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgGQRnQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 17 Jul 2020 13:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgGQRnP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Jul 2020 13:43:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A97AC0619D6
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2020 10:43:15 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ch3so6887419pjb.5
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2020 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wV1gvV23mO4MSWHgMeM+r7999nuQAFQGTkfq3zyvhrU=;
        b=TkI+hwhyWG7WZvnJTwRRMikLIXphh/PU89bCIE8P6SFs0SaHpCf4VAcMkSYIWejrmC
         UHjYj/pWqealOdMvuvGnbGyDGiR092Y/coL6eRwohd6FSkw/1x0lTSsWwdlxAmTbJF9z
         MG+bnlBW3Pz3hPqkiZYjpkgP2T6E3WFs4nd00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wV1gvV23mO4MSWHgMeM+r7999nuQAFQGTkfq3zyvhrU=;
        b=pq2dNDOC+emTiugPRuZdLJdzhK0AFcpMDZAEaiQ9Q2mCHh8FP8zYCdF6GM0FcVqLKM
         eWqNKaMPHEohMt0gN2WThQM+QyhNqQi2A8wWsOpO5LJjc61d5W78JzzjjdZOmA0jemQE
         SW7242ihfW4pqBAn8yzIdvI7ES8VdPiRC9KgjrAkFC9umZdltw6bL8CwiTIdR1ChA2yn
         /GvgY+94BDp6/qy6bATcziIw2/6a3lm40kBibBEkc70xkNu5bhErpLaLxbdlhuVpiBOg
         BEkPmMv81o9syW0n+NF1yayq0OIwOXksiB0tk4prPMvaRLlGTfGCQ8n4yHRDDsyAzfF1
         iF/Q==
X-Gm-Message-State: AOAM5319JupkgMGSQsOtRXg/PKztG+bYjEzWEijklBjduONtIjjSFo2A
        8e1l5pEuVjFoSudlFy1IIO20fg==
X-Google-Smtp-Source: ABdhPJxKZBG7RqgWoCxDb3CWPD97sCGFFzSrqXIIWjriKiDJA4WPNj/7bJe6bdbUYimvfgj8GzzH+g==
X-Received: by 2002:a17:90b:1386:: with SMTP id hr6mr10767858pjb.93.1595007794310;
        Fri, 17 Jul 2020 10:43:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 21sm8245611pfu.124.2020.07.17.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:43:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] Introduce partial kernel_read_file() support
Date:   Fri, 17 Jul 2020 10:42:55 -0700
Message-Id: <20200717174309.1164575-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

Here's my attempt at clearing the path to partial read support in
kernel_read_file(), which fixes a number of issues along the way. I'm
still fighting with the firmware test suite (it doesn't seem to pass
for me even in stock v5.7... ?) But I don't want to block Scott's work[1]
any this week, so here's the series as it is currently.

The primary difference to Scott's approach is to avoid adding a new set of
functions and just adapt the existing APIs to deal with "offset". Also,
the fixes for the enum are first in the series so they can be backported
without the header file relocation.

I'll keep poking at the firmware tests...

-Kees

[1] https://lore.kernel.org/lkml/202007161415.10D015477@keescook/

Kees Cook (12):
  firmware_loader: EFI firmware loader must handle pre-allocated buffer
  fs/kernel_read_file: Remove FIRMWARE_PREALLOC_BUFFER enum
  fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED enum
  fs/kernel_read_file: Split into separate source file
  fs/kernel_read_file: Remove redundant size argument
  fs/kernel_read_file: Switch buffer size arg to size_t
  fs/kernel_read_file: Add file_size output argument
  LSM: Introduce kernel_post_load_data() hook
  firmware_loader: Use security_post_load_data()
  module: Call security_kernel_post_load_data()
  LSM: Add "contents" flag to kernel_read_file hook
  fs/kernel_file_read: Add "offset" arg for partial reads

Scott Branden (1):
  fs/kernel_read_file: Split into separate include file

 drivers/base/firmware_loader/fallback.c       |   8 +-
 .../base/firmware_loader/fallback_platform.c  |  12 +-
 drivers/base/firmware_loader/main.c           |  13 +-
 fs/Makefile                                   |   3 +-
 fs/exec.c                                     | 132 +-----------
 fs/kernel_read_file.c                         | 189 ++++++++++++++++++
 include/linux/fs.h                            |  39 ----
 include/linux/ima.h                           |  19 +-
 include/linux/kernel_read_file.h              |  55 +++++
 include/linux/lsm_hook_defs.h                 |   6 +-
 include/linux/lsm_hooks.h                     |  12 ++
 include/linux/security.h                      |  19 +-
 kernel/kexec.c                                |   2 +-
 kernel/kexec_file.c                           |  18 +-
 kernel/module.c                               |  24 ++-
 security/integrity/digsig.c                   |   8 +-
 security/integrity/ima/ima_fs.c               |   9 +-
 security/integrity/ima/ima_main.c             |  58 ++++--
 security/integrity/ima/ima_policy.c           |   1 +
 security/loadpin/loadpin.c                    |  17 +-
 security/security.c                           |  26 ++-
 security/selinux/hooks.c                      |   8 +-
 22 files changed, 432 insertions(+), 246 deletions(-)
 create mode 100644 fs/kernel_read_file.c
 create mode 100644 include/linux/kernel_read_file.h

-- 
2.25.1

