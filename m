Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2442333CC
	for <lists+linux-security-module@lfdr.de>; Thu, 30 Jul 2020 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgG3OH0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 30 Jul 2020 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbgG3OHZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Jul 2020 10:07:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1362C061575
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2020 07:07:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p14so5853451wmg.1
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2020 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0IG2zqVou670EWuwadK3PaDAiaWJXT9eJnNO0hKRQcg=;
        b=G7RjaGf3J5CCo8vM8HMRtajN/iiNGY2U1F1f2BZlJxc10UVkbr2bLHA3vG+tTGStzn
         p463ti/KHK7xTLnztqX8o95TxWeOzy+ohCBdR3YijMDerbdhwHEG70GrTGS4btlGhG+b
         dsBY3LCXNRWe/3FPV0UX9620GxqXokpiCjWek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0IG2zqVou670EWuwadK3PaDAiaWJXT9eJnNO0hKRQcg=;
        b=aX+SWg1tJ4XGKapNb1ClaEJ+QrfbPK8lwxTNkv5wyCO9FU1OR0thc/gjJjS26CEQMt
         751Mf3dLANuqQnrUktiEi8vri7ih+4uiHXrG3zYd+liWf+ixPPUX0qqkuKwcycuT3wVM
         dbUDcEIFpu2JmHdY/z/xnOKMd4qrPO2Xf6rru1sy4sJ22zcs7IaYY/Z2EGzvTqNhtinE
         3uYx0EDQDBE5VboOHLK+qyEo0MliDnX108Rt0aUGzdnPWAk55+4SO4mYK3kYrt4LXiw6
         SSnc5pv2r8aUsgjwwD5IE+IhE5/zRt/4ygakrQ8P4Sg66jVr5Y1Ixb85O4xhZU0QyNFN
         x9BA==
X-Gm-Message-State: AOAM5334YUoyTPlOjFrrKKFPl6WsIdmS4qIXukWmXusTDY+iR3oAos0R
        UIOgjlwwZea3BVG/7lqMQFMpBw==
X-Google-Smtp-Source: ABdhPJwXfklCgZpLWouF+DqIAqMNvZb4ArNbbyzJKlUdu1nEuKDDnGRl3jsnJfVW77Uw2d5LottwXg==
X-Received: by 2002:a1c:1f85:: with SMTP id f127mr14439545wmf.154.1596118042428;
        Thu, 30 Jul 2020 07:07:22 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id a10sm19088599wmd.3.2020.07.30.07.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 07:07:21 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v7 0/7] Generalizing bpf_local_storage
Date:   Thu, 30 Jul 2020 16:07:09 +0200
Message-Id: <20200730140716.404558-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>


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
  A purely mechanical change to split the renaming from the actual
    generalization.
  bpf: Generalize caching for sk_storage.
  bpf: Generalize bpf_sk_storage
  bpf: Split bpf_local_storage to bpf_sk_storage
  bpf: Implement bpf_local_storage for inodes
  bpf: Allow local storage to be used from LSM programs
  bpf: Add selftests for local_storage

 include/linux/bpf.h                           |   9 +
 include/linux/bpf_local_storage.h             | 173 ++++
 include/linux/bpf_lsm.h                       |  21 +
 include/linux/bpf_types.h                     |   3 +
 include/net/bpf_sk_storage.h                  |  13 +
 include/net/sock.h                            |   4 +-
 include/uapi/linux/bpf.h                      |  54 +-
 kernel/bpf/Makefile                           |   2 +
 kernel/bpf/bpf_inode_storage.c                | 254 ++++++
 kernel/bpf/bpf_local_storage.c                | 600 +++++++++++++
 kernel/bpf/bpf_lsm.c                          |  21 +-
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  10 +
 net/core/bpf_sk_storage.c                     | 827 +++---------------
 security/bpf/hooks.c                          |   7 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +-
 tools/bpf/bpftool/map.c                       |   3 +-
 tools/include/uapi/linux/bpf.h                |  54 +-
 tools/lib/bpf/libbpf_probes.c                 |   5 +-
 .../bpf/prog_tests/test_local_storage.c       |  60 ++
 .../selftests/bpf/progs/local_storage.c       | 136 +++
 22 files changed, 1553 insertions(+), 711 deletions(-)
 create mode 100644 include/linux/bpf_local_storage.h
 create mode 100644 kernel/bpf/bpf_inode_storage.c
 create mode 100644 kernel/bpf/bpf_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c

-- 
2.28.0.rc0.142.g3c755180ce-goog

