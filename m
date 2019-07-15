Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC133698D5
	for <lists+linux-security-module@lfdr.de>; Mon, 15 Jul 2019 18:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfGOQFA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 15 Jul 2019 12:05:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33004 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfGOQFA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 12:05:00 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so34997095iog.0
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=abd3MzgGdND+mibf+9QP7+SAzCXmIg9aBJBUAlhxoSE=;
        b=Vx5UHmP4FSl+2sW2xSMATHmt/TstgDDB2D2BYOmRytxQn8jrzjv9CHvBN6ziokACKV
         yzABsXIgYMdyMShtxK0HrEeZ6yqmlt1ErRBouLjdWGCgNDX8nI3gIQGZ6TbZfGsRZAHQ
         G91t8osAi33e15JefGOz/Q8Tfy03uYvccBxHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=abd3MzgGdND+mibf+9QP7+SAzCXmIg9aBJBUAlhxoSE=;
        b=SmccNtKR07DWU/tadN3VCHn7FM8KcU78dICb/Ign6EfKHISy8E8fSck0FyIi+S1wzu
         XknQPxFi+PC5w2cpav5totXcXa3bkdbfxDKyRBJez3GFymiC+Y8nVXxSZ6bedun+Oshr
         bM0UzvPhoAYIgYXqX7HulAkbwRBaynsJbgKagiNUqa5HFVKT4PI3prTKjq0foIxh98g2
         q8fJReMwlmORoCRjR97LEqR/iRMbrxu5xMWe5trFpRD2fZnO8pVO1CN7JZ46aJamKbU7
         AuX10gjx8Q9OiGDzOhv8UcW0EsL6iMDUHEzdJkmFuC8zsWAbADtZW6ieWXer+D8ErZoW
         QXEw==
X-Gm-Message-State: APjAAAWTfQ8DRdx1PNoGKysKL3GtntraEqeWzzANds296pH+VZuFO/Af
        QO+uWCeB94VNHVh3jzFx/pXxns/KHCsxubC6bZ8MBw==
X-Google-Smtp-Source: APXvYqxIWrDZQA5aJHb2ZwP6MlOqQQByu0F7zWYD236UlUTqOmdsc6Xfpir6+WTeVaRUAFknNlgvqiYC7RyKKDGoS4g=
X-Received: by 2002:a05:6638:81:: with SMTP id v1mr27332807jao.72.1563206699374;
 Mon, 15 Jul 2019 09:04:59 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 15 Jul 2019 09:04:48 -0700
Message-ID: <CAJ-EccPGqp4PmRkFk505QhDKHWn-ajxS0__Nk9VS32jV_+3Y2A@mail.gmail.com>
Subject: [GIT PULL] SafeSetID LSM changes for 5.3
To:     torvalds@linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

I'm maintaining the new SafeSetID LSM and was told to set up my own
tree for sending pull requests rather than sending my changes through
James Morris and the security subsystem tree.

This is my first time doing one of these pull requests so hopefully I
didn't screw something up.

Thanks,
Micah
---
The following changes since commit fec88ab0af9706b2201e5daf377c5031c62d11f7:
Merge tag 'for-linus-hmm' of
git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2019-07-14
19:42:11 -0700)
are available in the Git repository at:
https://github.com/micah-morton/linux.git tags/safesetid-5.3
for you to fetch changes up to e10337daefecb47209fd2af5f4fab0d1a370737f:
LSM: SafeSetID: fix use of literal -1 in capable hook (2019-07-15
08:08:03 -0700)
----------------------------------------------------------------
SafeSetID patches for 5.3
These changes from Jann Horn fix a couple issues in the recently added
SafeSetID LSM:

(1) There was a simple logic bug in one of the hooks for the LSM where
the code was incorrectly returning early in some cases before all
security checks had been passed.
(2) There was a more high level issue with how this LSM gets configured
that could allow for a program to bypass the security restrictions
by switching to an allowed UID and then again to any other UID on
the system if the target UID of the first transition is
unconstrained on the system. Luckily this is an easy fix that we now
enforce at the time the LSM gets configured.

There are also some changes from Jann that make policy updates for this
LSM atomic. Kees Cook, Jann and myself have reviewed these changes and they
look good from our point of view.
Signed-off-by: Micah Morton <mortonm@chromium.org>
----------------------------------------------------------------
Jann Horn (10):
LSM: SafeSetID: fix pr_warn() to include newline
LSM: SafeSetID: fix check for setresuid(new1, new2, new3)
LSM: SafeSetID: refactor policy hash table
LSM: SafeSetID: refactor safesetid_security_capable()
LSM: SafeSetID: refactor policy parsing
LSM: SafeSetID: fix userns handling in securityfs
LSM: SafeSetID: rewrite userspace API to atomic updates
LSM: SafeSetID: add read handler
LSM: SafeSetID: verify transitive constrainedness
LSM: SafeSetID: fix use of literal -1 in capable hook
security/safesetid/lsm.c | 276 +++++++++++++-----------------------------
security/safesetid/lsm.h | 34 ++++--
security/safesetid/securityfs.c | 307
+++++++++++++++++++++++++++++------------------
tools/testing/selftests/safesetid/safesetid-test.c | 18 ++-
4 files changed, 306 insertions(+), 329 deletions(-)
