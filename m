Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D715942AA17
	for <lists+linux-security-module@lfdr.de>; Tue, 12 Oct 2021 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhJLQ60 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 12 Oct 2021 12:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbhJLQ6W (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Oct 2021 12:58:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006D7C061745
        for <linux-security-module@vger.kernel.org>; Tue, 12 Oct 2021 09:56:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f8-20020a2585480000b02905937897e3daso13296ybn.2
        for <linux-security-module@vger.kernel.org>; Tue, 12 Oct 2021 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JIJ5w4TMIICbNZUaDbjDGcHk/fSmd140jim7+0P9yU0=;
        b=TLi8XuzJrNiANRZDenlegnRSqXYaupn5KIuT6u+AGmWVTesxYxntdjILdiFZ+4PrhJ
         7/PAyZELdXYJpgv4pcmR30N9qdukWeLRK2+vJdjCh1wkQWtBdTlJRzNbG/suobRZniwJ
         mKzHZawACwZ8NAsZ92hZhXVvPOHIAaRwBVJIMXeMLtpTizrLqt4w3QpSPo0NlQyuL4Hs
         kLttaXi5jKewEVyxlw0/uO+UTCaOZ819/kfVmwDijiMJCZ6AQ7SGhPUQ4McuL/eOImAT
         Tyfi+2WRtwLKELmBp/XqbXRxrgtsNXkESC1z33xHdHzZjKvrrylU5YD7k7U8TfUZ2nT8
         WwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JIJ5w4TMIICbNZUaDbjDGcHk/fSmd140jim7+0P9yU0=;
        b=DMwhzwTN/yZ+XIxPXMHRBxUN0io14MbhEAkTCZ+v4egD85R7QFFqyRA3tQZgNKoxAS
         buvuUnOL1RdnAOH6szwGby5axPc9G9rUx9u3E0J2ba/twC2EZo/g8vJoEh6Imfgz3J0I
         MyRnQxiE/zxJQeEO5YGSMFUD8fRPvsJdm7m/6gvvKRrsPmYkfgtAEvko7RYSyAExi/rc
         fVkKjLTriljEIWjVMNq41u308y68hMJb2pt6GtQVVuLv5muqCAFSpQsmRcusFOiIanXK
         61aI8kBlkFu1dD+cq+lWJRsQKwHJG6TS/fuJUrBFz3SpRNB70t3HqsPG21uHb+FHhvUR
         tX7Q==
X-Gm-Message-State: AOAM532V+jhyqBRvKGDMOzUTE2hx5AjNshAXLQ/PCzSaUNgEBcPsH6u3
        00h7nHObnPWYS7k0yyMFcoWtLfUz7Q==
X-Google-Smtp-Source: ABdhPJyibaELnh3cCCM9a3Gh2OX2BWVk12YMcQGBurcM2T2GnhfAla+oUTJFMwQRfPSCuXIJVzOq7Gdcqw==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:39c7:8168:c0b2:b46e])
 (user=tkjos job=sendgmr) by 2002:a25:c013:: with SMTP id c19mr30563608ybf.255.1634057779213;
 Tue, 12 Oct 2021 09:56:19 -0700 (PDT)
Date:   Tue, 12 Oct 2021 09:56:11 -0700
Message-Id: <20211012165614.2873369-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v5 0/3] binder: use cred instead of task for security context
From:   Todd Kjos <tkjos@google.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io, jmorris@namei.org,
        serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, jannh@google.com, jeffv@google.com,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This series fixes the possible use of an incorrect security context
when checking selinux permissions, getting a security ID, or lookup
up the euid.

The previous behavior was to save the group_leader 'struct task_struct'
in binder_open() and using that to obtain security IDs or euids.

This has been shown to be unreliable, so this series instead saves the
'struct cred' of the task that called binder_open(). This cred is used
for these lookups instead of the task.

v1 and v2 of this series were a single patch "binder: use euid from"
cred instead of using task". During review, Stephen Smalley identified
two more related issues so the corresponding patches were added to
the series.

v3:
- add 2 patches to fix getsecid and euid

v4:
- fix minor checkpatch issues
- fix build-break for !CONFIG_SECURITY

v5:
- reorder/refactor patches as suggested by Stephen Smalley so eiud fix
  is first and saves the cred during binder_open()
- set *secid=0 for !CONFIG_SECURITY version of secuirty_cred_getsecid()

Todd Kjos (3):
  binder: use euid from cred instead of using task
  binder: use cred instead of task for selinux checks
  binder: use cred instead of task for getsecid

 drivers/android/binder.c          | 14 ++++++++------
 drivers/android/binder_internal.h |  4 ++++
 include/linux/lsm_hook_defs.h     | 14 +++++++-------
 include/linux/lsm_hooks.h         | 14 +++++++-------
 include/linux/security.h          | 28 ++++++++++++++--------------
 security/security.c               | 14 +++++++-------
 security/selinux/hooks.c          | 48 +++++++++++++-----------------------------------
 7 files changed, 60 insertions(+), 76 deletions(-)
