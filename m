Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FA73B79F3
	for <lists+linux-security-module@lfdr.de>; Tue, 29 Jun 2021 23:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhF2Vim (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 29 Jun 2021 17:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbhF2Vim (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Jun 2021 17:38:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84FCC061766
        for <linux-security-module@vger.kernel.org>; Tue, 29 Jun 2021 14:36:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s15so64466edt.13
        for <linux-security-module@vger.kernel.org>; Tue, 29 Jun 2021 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kVbXk/jGkX9FNNfyx7X6Mxyt8GqROWHeQ+D0oZ/1rWQ=;
        b=CKkESIfcf8PxrA+EjyxdXfq/B8pdPyMMuQzo4iLBkBNAO+/4WefIuWjHuhMptM7CvA
         E8zQicV5wwjKbD1D09KAfTx5xWZUjc7tSGATHt2tlTsRBGWcQbfIoiXzHlgVRgB+PhEb
         ixtemYRI4pIsOmEdxuzy7ig+vVJ7n6bvqK6hjC3v1c7wnYpw8gbhzIBd+9++G4i1ZcUj
         /XF8o9HILnUSDESr4I/EeOBN7JOj1xd25r+kTC7lImvpAJvlhjewqFs/vuCISC0puVVc
         hqVM1uOvEYfJqH3j7VMTRpy0dPF6D0sxLuWdMFQoz4ojezvUOdh9wRj4VivXclaCcg3i
         4gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kVbXk/jGkX9FNNfyx7X6Mxyt8GqROWHeQ+D0oZ/1rWQ=;
        b=chpmKEEOl1V5X/o4kh6WPyxVnICz7gQltzWcsUslMp7ghadfqnrPovPiWGpKlorQwx
         mQsgx2BnPSUrD6Rh8rYBJv6xzBLAG/Y4dnTChKM3bzHCZZ57JhB7ASnpxiDL0NRwji0G
         NTGAsZIAFfPkOa0a5kX6kHra0GHFv6TjhGsQ8iMKksNZUo+Dem8FNpscZffhyorohh6l
         wyo1HoZGuRKl1ihehDXhLnY7DdGUj51HBfSAg12D3kagyS43UTCvBhMkaRK2m/ihFc6P
         aNFQv9noywpH7mYUkg3AwVp3G6MgopKwnGn5As0CZVH5UzN4t/6GK9bVHzK6UXOrPtxW
         wd4g==
X-Gm-Message-State: AOAM531fu9L64P04uK752ZC/FR13x1dFQd6ymdYa3d1db8dU7ArXqL8v
        uaAzVWDBVPs6e+TeQxFFkFSfYoRiodNJgkrZeBHbFlTNE12r
X-Google-Smtp-Source: ABdhPJzN1aqZZm7XMoJpKd6Ir0SHqTfq4WjM5AgSiiYOq+rtX1qeG1OUxTUxRqVSF3naE5Hk5Ki+h3+0gV9c4wgj22Y=
X-Received: by 2002:a05:6402:1d17:: with SMTP id dg23mr42849509edb.128.1625002572146;
 Tue, 29 Jun 2021 14:36:12 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Jun 2021 17:36:01 -0400
Message-ID: <CAHC9VhQb03J_9yWKViZb+wD=pMfFQb+FyYwHYndYZTfRdJ8oLg@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Here is the SELinux pull request for v5.14, the highlights are below:

* The slow_avc_audit() function is now non-blocking so we can remove
the AVC_NONBLOCKING tricks; this also includes the 'flags' variant of
avc_has_perm().

* Use kmemdup() instead of kcalloc()+copy when copying parts of the
SELinux policydb.

* The InfiniBand device name is now passed by reference when possible
in the SELinux code, removing a strncpy().

* Minor cleanups including: constification of avtab function args,
removal of useless LSM/XFRM function args, SELinux kdoc fixes, and
removal of redundant assignments.

Everything has been tested against the selinux-testsuite and as of a
few moments ago the tag applies cleanly to your tree; please merge
this for v5.14.

Thanks,
-Paul

--
The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

 Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20210629

for you to fetch changes up to d99cf13f14200cdb5cbb704345774c9c0698612d:

 selinux: kill 'flags' argument in avc_has_perm_flags() and avc_audit()
   (2021-06-11 13:11:45 -0400)

----------------------------------------------------------------
selinux/stable-5.14 PR 20210629

----------------------------------------------------------------
Al Viro (2):
     selinux: slow_avc_audit has become non-blocking
     selinux: kill 'flags' argument in avc_has_perm_flags() and avc_audit()

Jiapeng Chong (1):
     selinux: Remove redundant assignment to rc

Minchan Kim (1):
     selinux: use __GFP_NOWARN with GFP_NOWAIT in the AVC

Ondrej Mosnacek (3):
     selinux: simplify duplicate_policydb_cond_list() by using kmemdup()
     selinux: constify some avtab function arguments
     lsm_audit,selinux: pass IB device name by reference

Souptick Joarder (1):
     selinux: Corrected comment to match kernel-doc comment

Yang Li (1):
     selinux: Fix kernel-doc

Zhongjun Tan (1):
     selinux: delete selinux_xfrm_policy_lookup() useless argument

include/linux/lsm_audit.h         |  8 ++---
include/linux/lsm_hook_defs.h     |  3 +-
include/linux/security.h          |  4 +--
net/xfrm/xfrm_policy.c            |  6 ++--
security/security.c               |  4 +--
security/selinux/avc.c            | 61 ++++++++--------------------------
security/selinux/hooks.c          | 22 ++++----------
security/selinux/include/avc.h    | 13 +--------
security/selinux/include/xfrm.h   |  2 +-
security/selinux/ss/avtab.c       | 28 +++++++++---------
security/selinux/ss/avtab.h       | 16 +++++-----
security/selinux/ss/conditional.c | 14 +++++----
security/selinux/ss/policydb.c    |  1 -
security/selinux/ss/services.c    | 27 +++++++++++++----
security/selinux/xfrm.c           |  2 +-
15 files changed, 90 insertions(+), 121 deletions(-)

-- 
paul moore
www.paul-moore.com
