Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158A336BC09
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Apr 2021 01:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhDZX2i (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 26 Apr 2021 19:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhDZX2i (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Apr 2021 19:28:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF86C061756
        for <linux-security-module@vger.kernel.org>; Mon, 26 Apr 2021 16:27:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id zl7so7226676ejb.6
        for <linux-security-module@vger.kernel.org>; Mon, 26 Apr 2021 16:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vlMq+OnnkaeutSkOJCo2HWQTyPWbMfqniLhEvi6+JTw=;
        b=PhAsPBcgEIif6QgM58SPw3LjlP/5Grg0OoaeI1HEM3jd+iyGQplCVgIx6ERbwVa7MD
         gzvupdHqdeGkdaZ63g61IHarvQeWJus31cXq6Hfy2vUWlD3QOD7J7nXdpZ0QEdrIeGhh
         1TOvT4Awq1hkJ5AfChigOftNwY8l4LJvr/1AtN6kdK35qiebtIiwpCe3YwA4XsA1DYVo
         rXKrDpasXVO72gAiOeOCsxBnmbf11hFoE07S4k8Rnodd42J1Dq2/WvD2HFXs1oVOTeVy
         chkDyvvyCIdl9YqOaHFu20SRKoTSxoSW/AhkYohIXPrWzvMx1GswEDYTNfoYhJq36pTt
         uZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vlMq+OnnkaeutSkOJCo2HWQTyPWbMfqniLhEvi6+JTw=;
        b=hqe/DtKOMHI1ESAqbQxlQbb67+mh1QjRuT75CaV3h1eUeXs2XD3YqBfXl2y1MZB2aK
         dQqpI4Rn+OVuEr/hRQ3dxBx7e/WtUt2zgLYIrrlZ2lgvCFM4PLVPmg5LGMlU3CoKCCPj
         cr4ZfCDT859QZEpo53IBs8FN4IEzytr05MZ0tK4JKpuT0JAjQVquKvC5mh1tUNR36VpI
         pPxHQB3yvgaWZcDBzTgjqQYko/SFdxC+Y+be/DPCw0OiH9elcqggErG0ydYmKD1QMMkJ
         jx1Sw+g06hvBNO0Vb4tR3N4toTjc1ktXqORpsifIsxJxsZN1oKxx4vsRBaycw0X1tmML
         MHOg==
X-Gm-Message-State: AOAM532bhQZJtx3QUnD/d+z4A3ilI3n5F3w4Rff7Fb9VLpBC8hF937Vz
        P1e/as1tcb+Mdag2zWHZbYVR7ekwBnFa1h408Md6
X-Google-Smtp-Source: ABdhPJyWAhcjyTttA68bCC5z/U8kw7BEjKy0yIOfXVotmGpMpvUFJHY3UFsievc+TukYzQ2g+OFpJoHgeuClFwTTzvI=
X-Received: by 2002:a17:906:608a:: with SMTP id t10mr21074575ejj.374.1619479673016;
 Mon, 26 Apr 2021 16:27:53 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Apr 2021 19:27:42 -0400
Message-ID: <CAHC9VhQc7GguPxuN0cU2D0960LBcDK6fW1fHWyMkQCyxNZ_9FA@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.13
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Here is the SELinux pull request for v5.13, the highlights are below:

* Add support for measuring the SELinux state and policy capabilities using IMA.

* A handful of SELinux/NFS patches to compare the SELinux state of one
mount with a set of mount options.  Olga goes into more detail in the
patch descriptions, but this is important as it allows more
flexibility when using NFS and SELinux context mounts.

* Properly differentiate between the subjective and objective LSM
credentials; including support for the SELinux and Smack.  My clumsy
attempt at a proper fix for AppArmor didn't quite pass muster so John
is working on a proper AppArmor patch, in the meantime this set of
patches shouldn't change the behavior of AppArmor in any way.  This
change explains the bulk of the diffstate beyond security/.

* Fix a problem where we were not properly terminating the permission
list for two SELinux object classes.

Everything has been tested against the selinux-testsuite and as of a
few moments ago the tag applies cleanly to your tree; please merge
this for v5.13.

Thanks,
-Paul

--
The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

 Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20210426

for you to fetch changes up to e4c82eafb609c2badc56f4e11bc50fcf44b8e9eb:

 selinux: add proper NULL termination to the secclass_map permissions
   (2021-04-21 21:43:25 -0400)

----------------------------------------------------------------
selinux/stable-5.13 PR 20210426

----------------------------------------------------------------
Lakshmi Ramasubramanian (1):
     selinux: measure state and policy capabilities

Olga Kornievskaia (3):
     lsm,selinux: add new hook to compare new mount to an existing mount
     nfs: remove unneeded null check in nfs_fill_super()
     nfs: account for selinux security context when deciding to share
          superblock

Paul Moore (4):
     lsm: separate security_task_getsecid() into subjective and objective
          variants
     selinux: clarify task subjective and objective credentials
     smack: differentiate between subjective and objective task credentials
     selinux: add proper NULL termination to the secclass_map permissions

Vivek Goyal (1):
     selinux: Allow context mounts for unpriviliged overlayfs

Xiong Zhenwu (2):
     selinux: fix misspellings using codespell tool
     selinux: fix misspellings using codespell tool

drivers/android/binder.c              |  11 ++-
fs/nfs/fs_context.c                   |   3 +
fs/nfs/internal.h                     |   1 +
fs/nfs/super.c                        |   6 +-
include/linux/cred.h                  |   2 +-
include/linux/lsm_hook_defs.h         |   6 +-
include/linux/lsm_hooks.h             |  18 +++-
include/linux/nfs_fs_sb.h             |   1 +
include/linux/security.h              |  18 +++-
kernel/audit.c                        |   4 +-
kernel/auditfilter.c                  |   3 +-
kernel/auditsc.c                      |   8 +-
kernel/bpf/bpf_lsm.c                  |   3 +-
net/netlabel/netlabel_unlabeled.c     |   2 +-
net/netlabel/netlabel_user.h          |   2 +-
security/apparmor/lsm.c               |   3 +-
security/integrity/ima/ima_appraise.c |   2 +-
security/integrity/ima/ima_main.c     |  14 +--
security/security.c                   |  20 +++-
security/selinux/hooks.c              | 170 ++++++++++++++++++++++++------
security/selinux/ima.c                |  87 +++++++++++++++-
security/selinux/include/classmap.h   |   5 +-
security/selinux/include/ima.h        |   6 ++
security/selinux/include/security.h   |   2 +-
security/selinux/selinuxfs.c          |   6 ++
security/selinux/ss/hashtab.c         |   2 +-
security/selinux/ss/services.c        |   2 +-
security/smack/smack.h                |  18 +++-
security/smack/smack_lsm.c            |  39 +++++---
29 files changed, 372 insertions(+), 92 deletions(-)

-- 
paul moore
www.paul-moore.com
