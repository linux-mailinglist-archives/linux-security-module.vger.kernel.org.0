Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B95C219D28
	for <lists+linux-security-module@lfdr.de>; Thu,  9 Jul 2020 12:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgGIKMo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 9 Jul 2020 06:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIKMo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Jul 2020 06:12:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003DAC061A0B
        for <linux-security-module@vger.kernel.org>; Thu,  9 Jul 2020 03:12:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so1732012wrm.4
        for <linux-security-module@vger.kernel.org>; Thu, 09 Jul 2020 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F6g7fDptGIzcY72zTri5KBvJJQVzV3/1jzTXQNV3HuM=;
        b=coFPDVVuvafd81nThgtSu0cQL7bq1mh93sEFCf+KGqyoIo5FBqkxkIUod13S1KaPLu
         uXLU67/XWgjX/Knt7+yNrZdrx90+sADqntqOb2FgqXvmg+UFOcdAkEHE7pZEaVwfCD6n
         TpydZ84o6TTExBrj92STaQRWNhRTmdKhfvhEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F6g7fDptGIzcY72zTri5KBvJJQVzV3/1jzTXQNV3HuM=;
        b=LDuWDrtw+KIyWTSxDUICN/5TVJ670lN4jmaIvTQipbjKjmwkYklrRfGumb1zcf1sIw
         4zHFZnvbiwT73lbeByvCAh0EIrD20Ei4sH5gte4mUvQmsgMcJO96MK39/xA7WU1Tjvhr
         Z/cad3hBV3UmXjzD+n7I5iqVPCTSszkDbD3+nOBolQHsP5rPUBaR/aXUrhQLftmDkyqi
         YT/I6Xpzl6uKcHeQmq1iYZJo6pRODGkX0IRRfRQgECx5UcBZCGQF52k4uMbkOAV/7TOn
         lVowsdRas2uncBa7G7SpymkoXvIPm11qlMb4FLCE076leq0G3BthIj3S0jETmrw18IXg
         +XuA==
X-Gm-Message-State: AOAM532iYSHGiWGiXEoVWWQVGLG+jCefGR3bq9pzMePTLFatEozKGI4t
        4KsPlWRfgcSsCp3QPHyvvhKlIA==
X-Google-Smtp-Source: ABdhPJztxd9ybzuPdUmBiF9b0n0gq1IqMMvtclokdmjAg/DXj6rkBJNamKoGI+PesauLp51wDgEtRg==
X-Received: by 2002:adf:e546:: with SMTP id z6mr58343987wrm.99.1594289562595;
        Thu, 09 Jul 2020 03:12:42 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id g3sm5538287wrb.59.2020.07.09.03.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 03:12:42 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4 0/4] Generalizing bpf_local_storage
Date:   Thu,  9 Jul 2020 12:12:35 +0200
Message-Id: <20200709101239.3829793-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

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


KP Singh (4):
  bpf: Generalize bpf_sk_storage
  bpf: Implement bpf_local_storage for inodes
  bpf: Allow local storage to be used from LSM programs
  bpf: Add selftests for local_storage

 include/linux/bpf.h                           |  14 +
 include/linux/bpf_local_storage.h             | 190 ++++
 include/linux/bpf_lsm.h                       |  21 +
 include/linux/bpf_types.h                     |   3 +
 include/net/bpf_sk_storage.h                  |   2 +
 include/net/sock.h                            |   4 +-
 include/uapi/linux/bpf.h                      |  54 +-
 kernel/bpf/Makefile                           |   2 +
 kernel/bpf/bpf_inode_storage.c                | 333 +++++++
 kernel/bpf/bpf_local_storage.c                | 517 +++++++++++
 kernel/bpf/bpf_lsm.c                          |  21 +-
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  10 +
 net/core/bpf_sk_storage.c                     | 825 ++++--------------
 security/bpf/hooks.c                          |   7 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +-
 tools/bpf/bpftool/map.c                       |   3 +-
 tools/include/uapi/linux/bpf.h                |  54 +-
 tools/lib/bpf/libbpf_probes.c                 |   5 +-
 .../bpf/prog_tests/test_local_storage.c       |  60 ++
 .../selftests/bpf/progs/local_storage.c       | 136 +++
 22 files changed, 1599 insertions(+), 670 deletions(-)
 create mode 100644 include/linux/bpf_local_storage.h
 create mode 100644 kernel/bpf/bpf_inode_storage.c
 create mode 100644 kernel/bpf/bpf_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c

-- 
2.27.0.389.gc38d7665816-goog

