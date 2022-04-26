Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E4B510B4D
	for <lists+linux-security-module@lfdr.de>; Tue, 26 Apr 2022 23:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355452AbiDZVe0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 26 Apr 2022 17:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355450AbiDZVe0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Apr 2022 17:34:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFD4255A0
        for <linux-security-module@vger.kernel.org>; Tue, 26 Apr 2022 14:31:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m14-20020a17090a34ce00b001d5fe250e23so125966pjf.3
        for <linux-security-module@vger.kernel.org>; Tue, 26 Apr 2022 14:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NmMY7ZEC2LA8ubdNrSjDuhNzkyHfOdHj22q0EtJVAhk=;
        b=iwn2+1yPZJQNhCl3wV5/gS39Q9nngAozD++huA0MMa/5LT8SIawUCZVR2xGpBv21OC
         htQhbMvQ5EgESv/NODxW48sHdCzxjr58K8N5JHd9yKvHwpvovyqiZp6azlt9+3e3XBqZ
         qSg6CEWVvNOK6weBaEmSbKbNe+oK1LObykPJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NmMY7ZEC2LA8ubdNrSjDuhNzkyHfOdHj22q0EtJVAhk=;
        b=00Uf+KJDFG81/fbaTfg1qc1Cgiy1f6t8sUCHjxu3wXoJdDUxwZZpARBOXm25AB9DAu
         ns9rqgqvuFT8kdAqrQaRxes6io60V4fkgxoe7OECMvjKeiugvPDIKb0GButBAAnJ3GgB
         gqg3aTdar2RMzZUAOcbqMuXPyvYwO7E9H4Wkj1Pti39FpAiuluTL0LxH6WjMVLW1MdAm
         DaF0jwB0r/tdzaiM7G1rNw2tuQpsGCAStKvJ0pUGQSLTSB9NpQyitSl3n/iBEjq/wbM7
         PzFHKNUBoUeSCxltmjJgSA0BFfmT0CPT/d5fZgsKrWwTAdKJIqEg3ydXkQQ0VnJgY4VS
         2pDA==
X-Gm-Message-State: AOAM532q5sXSaHYZVwUzv8ChY189K1vUtf6K/rKBx0l898rCB5gfiD7q
        uazlx2FwjZCVUjD2f8TsLZye+CkSG+kBow==
X-Google-Smtp-Source: ABdhPJzp4X5v15GE3Zc7zJfgHgDSaqiSDbZ9++70lo/F1w6eUXoCvxD8/KcNhsSXYbz+c+W3/7EE0Q==
X-Received: by 2002:a17:90a:f3cb:b0:1d9:62d4:25db with SMTP id ha11-20020a17090af3cb00b001d962d425dbmr15694380pjb.222.1651008675551;
        Tue, 26 Apr 2022 14:31:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:eb63:4211:eb5d:f6b])
        by smtp.gmail.com with UTF8SMTPSA id d5-20020a056a0024c500b004fae56b2921sm17137609pfv.167.2022.04.26.14.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 14:31:15 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Song Liu <song@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 0/3] LoadPin: Enable loading from trusted dm-verity devices
Date:   Tue, 26 Apr 2022 14:31:07 -0700
Message-Id: <20220426213110.3572568-1-mka@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

As of now LoadPin restricts loading of kernel files to a single
pinned filesystem, typically the rootfs. This works for many
systems, however it can result in a bloated rootfs (and OTA
updates) on platforms where multiple boards with different
hardware configurations use the same rootfs image. Especially
when 'optional' files are large it may be preferable to
download/install them only when they are actually needed by a
given board. Chrome OS uses Downloadable Content (DLC) [1] to
deploy certain 'packages' at runtime. As an example a DLC
package could contain firmware for a peripheral that is not
present on all boards. DLCs use dm-verity [2] to verify the
integrity of the DLC content.

This series extends LoadPin to allow loading of kernel files
from trusted dm-verity devices. It adds the concept of
trusted verity devices to LoadPin. Userspace can use the new
systl file 'loadpin/trusted_verity_root_digests_path' to
provide LoadPin with the path of a file with a list of root
digests from dm-verity devices that LoadPin should consider
as trusted. This file must be located on the pinned root.

When a kernel file is read LoadPin first checks (as usual)
whether the file is located on the pinned root, if so the
file can be loaded. Otherwise, if the verity extension is
enabled, LoadPin determines whether the file is located
on a verity backed device and whether the root digest of
that device is in the list of trusted digests. The file
can be loaded if the verity device has a trusted root
digest.

The path of the file with the trusted root digests can
only be written once, which is typically done at boot time.

[1] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/dlcservice/docs/developer.md
[2] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html

(no changes since v1)

Matthias Kaehlcke (3):
  dm: Add verity helpers for LoadPin
  LoadPin: Enable loading from trusted dm-verity devices
  dm: verity-loadpin: Use CONFIG_SECURITY_LOADPIN_VERITY for conditional
    compilation

 drivers/md/Makefile               |   1 +
 drivers/md/dm-verity-loadpin.c    |  80 ++++++++++++
 drivers/md/dm-verity-target.c     |  33 +++++
 drivers/md/dm-verity.h            |   4 +
 include/linux/dm-verity-loadpin.h |  27 ++++
 security/loadpin/Kconfig          |  16 +++
 security/loadpin/loadpin.c        | 200 +++++++++++++++++++++++++++++-
 7 files changed, 360 insertions(+), 1 deletion(-)
 create mode 100644 drivers/md/dm-verity-loadpin.c
 create mode 100644 include/linux/dm-verity-loadpin.h

-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

