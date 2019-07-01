Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 477B127F21
	for <lists+linux-security-module@lfdr.de>; Thu, 23 May 2019 16:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfEWOI7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 23 May 2019 10:08:59 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:40578 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfEWOI7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 May 2019 10:08:59 -0400
Received: by mail-qt1-f202.google.com with SMTP id 37so2794786qtc.7
        for <linux-security-module@vger.kernel.org>; Thu, 23 May 2019 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JQ1oCxUU1IPVRVLwTDKqVi9a5cWuQ5HVxcskTOhO4aM=;
        b=QSVcDQxMHDwf8m/Z00oyTMaxgkEpAavtybAzTn6owaPo+gAmLQ7/HmGrhaVojqa/Z9
         H3RWBQuoUt7y1CPFPUSYmC3KFwZXYCXhsfg3TCzVqJhn8CbhPgjm9rKJWQDX7Lu/2d0W
         Dsq823bTZbsbvOS3FJZxLzlDpc2K/sJx5F3y4OG8DQxWxVuNEHRX3wswKeIrOLGu4JEH
         1P1KizLqCGCvxfpwPbt4JvR7LuXsduw83cDbNhfkxg3jxs4SgNA4G18Cufc/NtkbcRrW
         nuizYWd0dCXGDuYT3EFJtWHxhGMyOtpdRhrfsgswuXoX+qLlyEVvHWcK2HoojRAzEzvn
         4BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JQ1oCxUU1IPVRVLwTDKqVi9a5cWuQ5HVxcskTOhO4aM=;
        b=cCjpxORAHqBx0Z/wzAM1TP/BUmMQL4X+L93lm6kQ6RR4Uz0z35erTfWtgjdEro09qF
         yL3EPJK3p2JN/v61yrfRx0VtOXaod6EmqUsdKq3BOhdZE0aIepe1k9zVSuB20Jqllba7
         iyDo2BG6qCeoPO3pYMoWqaliPl57bzFPHDLN5/kRck7NFk3HTqIOjBqxV3DWhURgh1my
         ckG2JUzkSMhoElrk1Qm0HhvWNzHl3dHYPiu64BjFE/B/kTMECH2UJxWHjnvJoGJ5jvGF
         SmHMK5XhNRq9MiftfDR24NtRbCzE1nCVLPbCU2lQ2omGL+iiUnKly5AwxOCohRAlJc/V
         nWRQ==
X-Gm-Message-State: APjAAAUwStIhSeRYV0AnVPwiFIfjt0dajVJ/kqbg3OPvwVKzVeej4ZmK
        KPKAhvFi+CSR4AnzbKh3ooVKtIOHgJs=
X-Google-Smtp-Source: APXvYqwSUxwQ8ZuNx1PgcNhs9sqtZK2tJMlDKqjgJyD1uwOWdZQSCxHOVN2MDcLXkAW2ECB0c+wPbMvjU8c=
X-Received: by 2002:a0c:9562:: with SMTP id m31mr59699151qvm.27.1558620538065;
 Thu, 23 May 2019 07:08:58 -0700 (PDT)
Date:   Thu, 23 May 2019 16:08:41 +0200
Message-Id: <20190523140844.132150-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v4 0/3] RFC: add init_on_alloc/init_on_free boot options
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, cl@linux.com, keescook@chromium.org
Cc:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Provide init_on_alloc and init_on_free boot options.

These are aimed at preventing possible information leaks and making the
control-flow bugs that depend on uninitialized values more deterministic.

Enabling either of the options guarantees that the memory returned by the
page allocator and SL[AOU]B is initialized with zeroes.

Enabling init_on_free also guarantees that pages and heap objects are
initialized right after they're freed, so it won't be possible to access
stale data by using a dangling pointer.

As suggested by Michal Hocko, right now we don't let the heap users to
disable initialization for certain allocations. There's not enough
evidence that doing so can speed up real-life cases, and introducing
ways to opt-out may result in things going out of control.

Alexander Potapenko (3):
  mm: security: introduce init_on_alloc=1 and init_on_free=1 boot
    options
  mm: init: report memory auto-initialization features at boot time
  lib: introduce test_meminit module

 .../admin-guide/kernel-parameters.txt         |   8 +
 drivers/infiniband/core/uverbs_ioctl.c        |   2 +-
 include/linux/mm.h                            |  22 ++
 init/main.c                                   |  24 ++
 kernel/kexec_core.c                           |   2 +-
 lib/Kconfig.debug                             |   8 +
 lib/Makefile                                  |   1 +
 lib/test_meminit.c                            | 208 ++++++++++++++++++
 mm/dmapool.c                                  |   2 +-
 mm/page_alloc.c                               |  63 +++++-
 mm/slab.c                                     |  16 +-
 mm/slab.h                                     |  16 ++
 mm/slob.c                                     |  22 +-
 mm/slub.c                                     |  27 ++-
 net/core/sock.c                               |   2 +-
 security/Kconfig.hardening                    |  14 ++
 16 files changed, 416 insertions(+), 21 deletions(-)
 create mode 100644 lib/test_meminit.c
---
 v3: dropped __GFP_NO_AUTOINIT patches

-- 
2.21.0.1020.gf2820cf01a-goog

