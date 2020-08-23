Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B4924EEDA
	for <lists+linux-security-module@lfdr.de>; Sun, 23 Aug 2020 18:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHWQ4U (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 23 Aug 2020 12:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgHWQ4T (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 23 Aug 2020 12:56:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A8C061573
        for <linux-security-module@vger.kernel.org>; Sun, 23 Aug 2020 09:56:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so6209134wmi.2
        for <linux-security-module@vger.kernel.org>; Sun, 23 Aug 2020 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9VV0VUKWdKHrZoZz+bAO4AdD0M5HnXZsnWHlLxVB6M=;
        b=UMeUwR6etEL/eS6zVJBLfsO6LqOADW8C+YVfMTVz2AwAGxY+gZLPgmt6ZjQsM2BPWX
         4VnGZKCt5BXluaf623gXfO2dU+2GYpdeVMW+09hbYvsMHNrzMB7h4iMxkcXZhIQu2i5z
         2O7XesC0dmfmALO5Envzj4vGDut6MX/CCdLVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9VV0VUKWdKHrZoZz+bAO4AdD0M5HnXZsnWHlLxVB6M=;
        b=o1t2Q1plwzLZDi6RcMlMsR8zO5RPnLkGhRbQ/UPLhVVwqzLg542MMg8FTBjX8fnVIG
         1/tf++J/O2lmc2kBa64CYNa4cOm1Ge/+pzskROPBgtegMCkqwCiUb3lbyoyc0GtRikPa
         bJ3WAJXZJKZkrTbnyB7fPR4tCoOKi0Znc6Kujln0BpiXX6fWm4U/Up6sH4/73NNgJdi6
         vsfD0taqldVM8uoSIs5zm8PELjI/1AjgBHdf5B81GySYp+T5HnQN+4w6gz3N6h06JhP5
         uPeNd5aUAotlbnOiZcJC5RkWdX1glLHIAKdf5P91eBBzpZmaPqUCIgqXKwmLK0PVXj3m
         ZPhw==
X-Gm-Message-State: AOAM5314b28p2SgN7bJHDXHl4rcmUJ1C9pdy8qCLjGQoLECO2a9Ui7NG
        cF6AOtUBAetSrHIJLCkqgNEgR7zxBh0A2w==
X-Google-Smtp-Source: ABdhPJyK463/MZaqw9Mr5vZyyPpODXteH13nvjHT/Vt4TwEfctmO5SmOa65LMqohhCFoqcG1VTVbmA==
X-Received: by 2002:a1c:a385:: with SMTP id m127mr2166694wme.189.1598201777210;
        Sun, 23 Aug 2020 09:56:17 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id d10sm5425974wrg.3.2020.08.23.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 09:56:16 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v9 0/7] Generalizing bpf_local_storage
Date:   Sun, 23 Aug 2020 18:56:05 +0200
Message-Id: <20200823165612.404892-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

# v8 -> v9

- Fixed reference count logic for files for inode maps.
- Other fixes suggested by Martin
- Rebase

# v7 -> v8

- Fixed an issue with BTF IDs for helpers and added
  bpf_<>_storage_delete to selftests to catch this issue.
- Update comments about refcounts and grabbed a refcount to the open
  file for userspace inode helpers.
- Rebase.

# v6 -> v7

- Updated the series to use Martin's POC patch:

  https://lore.kernel.org/bpf/20200725013047.4006241-1-kafai@fb.com/

  I added a Co-developed-by: tag, but would need Martin's Signoff
  (was not sure of the procedure here).

- Rebase.

# v5 -> v6

- Fixed a build warning.
- Rebase.

# v4 -> v5

- Split non-functional changes into separate commits.
- Updated the cache macros to be simpler.
- Fixed some bugs noticed by Martin.
- Updated the userspace map functions to use an fd for lookups, updates
  and deletes.
- Rebase.

# v3 -> v4

- Fixed a missing include to bpf_sk_storage.h in bpf_sk_storage.c
- Fixed some functions that were not marked as static which led to
  W=1 compilation warnings.

# v2 -> v3

* Restructured the code as per Martin's suggestions:
  - Common functionality in bpf_local_storage.c
  - bpf_sk_storage functionality remains in net/bpf_sk_storage.
  - bpf_inode_storage is kept separate as it is enabled only with
    CONFIG_BPF_LSM.
* A separate cache for inode and sk storage with macros to define it.
* Use the ops style approach as suggested by Martin instead of the
  enum + switch style.
* Added the inode map to bpftool bash completion and docs.
* Rebase and indentation fixes.

# v1 -> v2

* Use the security blob pointer instead of dedicated member in
  struct inode.
* Better code re-use as suggested by Alexei.
* Dropped the inode count arithmetic as pointed out by Alexei.
* Minor bug fixes and rebase.

bpf_sk_storage can already be used by some BPF program types to annotate
socket objects. These annotations are managed with the life-cycle of the
object (i.e. freed when the object is freed) which makes BPF programs
much simpler and less prone to errors and leaks.

This patch series:

* Generalizes the bpf_sk_storage infrastructure to allow easy
  implementation of local storage for other objects
* Implements local storage for inodes
* Makes both bpf_{sk, inode}_storage available to LSM programs.

Local storage is safe to use in LSM programs as the attachment sites are
limited and the owning object won't be freed, however, this is not the
case for tracing. Usage in tracing is expected to follow a white-list
based approach similar to the d_path helper
(https://lore.kernel.org/bpf/20200506132946.2164578-1-jolsa@kernel.org).

Access to local storage would allow LSM programs to implement stateful
detections like detecting the unlink of a running executable from the
examples shared as a part of the KRSI series
https://lore.kernel.org/bpf/20200329004356.27286-1-kpsingh@chromium.org/
and
https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_detect_exec_unlink.c

KP Singh (7):
  bpf: Renames in preparation for bpf_local_storage
  bpf: Generalize caching for sk_storage.
  bpf: Generalize bpf_sk_storage
  bpf: Split bpf_local_storage to bpf_sk_storage
  bpf: Implement bpf_local_storage for inodes
  bpf: Allow local storage to be used from LSM programs
  bpf: Add selftests for local_storage

 include/linux/bpf.h                           |   8 +
 include/linux/bpf_local_storage.h             | 163 ++++
 include/linux/bpf_lsm.h                       |  29 +
 include/linux/bpf_types.h                     |   3 +
 include/net/bpf_sk_storage.h                  |  14 +
 include/net/sock.h                            |   4 +-
 include/uapi/linux/bpf.h                      |  53 +-
 kernel/bpf/Makefile                           |   2 +
 kernel/bpf/bpf_inode_storage.c                | 265 ++++++
 kernel/bpf/bpf_local_storage.c                | 600 +++++++++++++
 kernel/bpf/bpf_lsm.c                          |  21 +-
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  10 +
 net/core/bpf_sk_storage.c                     | 830 +++---------------
 security/bpf/hooks.c                          |   7 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +-
 tools/bpf/bpftool/map.c                       |   3 +-
 tools/include/uapi/linux/bpf.h                |  53 +-
 tools/lib/bpf/libbpf_probes.c                 |   5 +-
 .../bpf/prog_tests/test_local_storage.c       |  60 ++
 .../selftests/bpf/progs/local_storage.c       | 140 +++
 22 files changed, 1566 insertions(+), 712 deletions(-)
 create mode 100644 include/linux/bpf_local_storage.h
 create mode 100644 kernel/bpf/bpf_inode_storage.c
 create mode 100644 kernel/bpf/bpf_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c

-- 
2.28.0.297.g1956fa8f8d-goog

