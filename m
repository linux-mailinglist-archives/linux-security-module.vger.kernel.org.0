Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1D852AEA5
	for <lists+linux-security-module@lfdr.de>; Wed, 18 May 2022 01:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiEQXfD (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 17 May 2022 19:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiEQXfC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 May 2022 19:35:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C302C527DA
        for <linux-security-module@vger.kernel.org>; Tue, 17 May 2022 16:35:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q18so187245pln.12
        for <linux-security-module@vger.kernel.org>; Tue, 17 May 2022 16:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9RzasHWL24EeSBATPMbqbdUHGSH0f06CyC7XznUSbQM=;
        b=PLpCdiSATveu+7IC9JT6yzHMROQRP1z49Ou2IJq4n1DdAHB4K3zgWUCI6TbrVwziNz
         rLVrxqmCYpw7/sQNqnGvP0M/Z/XwzOHBMFAbon6M0OzIcoy2w9vyETb3V992kHLYXx+N
         YG12D8m6BKsE4yU1wNi9HfwsOQLNP1jVDkRuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9RzasHWL24EeSBATPMbqbdUHGSH0f06CyC7XznUSbQM=;
        b=NfjQM6QstpgYdqeVrawL1RhcO99b9enIA0HbC/TeaYtU42/I/Q6IZ5a/zlBNQ3BoYN
         woWzsoqm1YdsfDwDE49cJfKHEKgAQYDQY+dOeUABGd0W8IcPYyZxyaU0DrqIFCZEJMS2
         ZGn7/QzhLVtWmcQxoDZqHQSBbxcqg+7H8SYM/4lbvCuFStPO8NugsXf/RvqEsZ3Y8knI
         4+00w37FqRrOuCi3DuS6fmTWQYmbdU84pcX3NzEzb2+2mdNSp3mPU5LJjulWljH51kKd
         kHQ6Fdr6t6PLchUHq95/aPl9oS926V3rzdZO/sGlD8VALipd3Ev0JWFc2+iZ+J/7NtiI
         w5xQ==
X-Gm-Message-State: AOAM5301AcKuTBIGxa1SAwmHkXBrBMzMicHcu2N8fs4tOixmg/HneN3S
        HvadmhahRlXZM4gyt2KYuGXd5g==
X-Google-Smtp-Source: ABdhPJwLpJsEsDMCc9C6tx8HCu70Xu9hN6jrAsbx+Sr1+zbbbmR3L1grNSd3M5FMoDJnngO6WEXaZA==
X-Received: by 2002:a17:902:eb87:b0:15e:bd77:a91 with SMTP id q7-20020a170902eb8700b0015ebd770a91mr24827170plg.49.1652830500281;
        Tue, 17 May 2022 16:35:00 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:a14:3166:4b67:b688])
        by smtp.gmail.com with UTF8SMTPSA id g14-20020a62f94e000000b0050dc762815csm303836pfm.54.2022.05.17.16.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 16:34:59 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 0/3] LoadPin: Enable loading from trusted dm-verity devices
Date:   Tue, 17 May 2022 16:34:54 -0700
Message-Id: <20220517233457.1123309-1-mka@chromium.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

As of now LoadPin restricts loading of kernel files to a single pinned
filesystem, typically the rootfs. This works for many systems, however it
can result in a bloated rootfs (and OTA updates) on platforms where
multiple boards with different hardware configurations use the same rootfs
image. Especially when 'optional' files are large it may be preferable to
download/install them only when they are actually needed by a given board.
Chrome OS uses Downloadable Content (DLC) [1] to deploy certain 'packages'
at runtime. As an example a DLC package could contain firmware for a
peripheral that is not present on all boards. DLCs use dm-verity [2] to
verify the integrity of the DLC content.

This series extends LoadPin to allow loading of kernel files from trusted
dm-verity devices. LoadPin maintains a list of root digests of verity
devices it considers trusted. Userspace can populate this list through an
ioctl on the new LoadPin securityfs entry 'dm-verity'. The ioctl receives
a file descriptor of a file with verity digests as parameter. Verity reads
the digests from this file after confirming that the file is located on the
pinned root. The digest file must contain one digest per line. The list of
trusted digests can only be set up once, which is typically done at boot
time.

When a kernel file is read LoadPin first checks (as usual) whether the file
is located on the pinned root, if so the file can be loaded. Otherwise, if
the verity extension is enabled, LoadPin determines whether the file is
located on a verity backed device and whether the root digest of that
device is in the list of trusted digests. The file can be loaded if the
verity device has a trusted root digest.

[1] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/dlcservice/docs/developer.md
[2] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html

Changes in v4:
- a trusted verity device must have a single target of
  type 'verity'
- changed struct trusted_root_digest to have an unsized
  u8 array instead of a pointer
- use shared list of verity digests, deleted
  dm_verity_loadpin_set_trusted_root_digests()
- use newline as separator in digest file instead of comma
- after reading an invalid/corrupt digest file deny further attempts
  of setting up the list of digests
- added comment to read_trusted_verity_root_digests() explaining that
  an invalid digests entry invalidates the entire list of digests
- minor refactoring of verity related code in LoadPin

Changes in v3:
- added securityfs for LoadPin (currently only populated when
  CONFIG_SECURITY_LOADPIN_VERITY=y)
- added uapi include for LoadPin
- changed the interface for setting up the list of trusted
  digests from sysctl to ioctl on securityfs entry
- added stub for loadpin_is_fs_trusted() to be used
  CONFIG_SECURITY_LOADPIN_VERITY is not select
- depend on CONFIG_SECURITYFS instead of CONFIG_SYSTCL
- updated Kconfig help
- minor changes in read_trusted_verity_root_digests()
- updated commit message

Changes in v2:
- userspace now passes the path of the file with the verity digests
  via systcl, instead of the digests themselves
- renamed sysctl file to 'trusted_verity_root_digests_path'
- have CONFIG_SECURITY_LOADPIN_VERITY depend on CONFIG_SYSCTL
- updated Kconfig doc
- updated commit message

Matthias Kaehlcke (3):
  dm: Add verity helpers for LoadPin
  LoadPin: Enable loading from trusted dm-verity devices
  dm: verity-loadpin: Use CONFIG_SECURITY_LOADPIN_VERITY for conditional
    compilation

 drivers/md/Makefile               |   1 +
 drivers/md/dm-verity-loadpin.c    |  74 +++++++++++++
 drivers/md/dm-verity-target.c     |  33 ++++++
 drivers/md/dm-verity.h            |   4 +
 include/linux/dm-verity-loadpin.h |  27 +++++
 include/uapi/linux/loadpin.h      |  22 ++++
 security/loadpin/Kconfig          |  16 +++
 security/loadpin/loadpin.c        | 167 +++++++++++++++++++++++++++++-
 8 files changed, 343 insertions(+), 1 deletion(-)
 create mode 100644 drivers/md/dm-verity-loadpin.c
 create mode 100644 include/linux/dm-verity-loadpin.h
 create mode 100644 include/uapi/linux/loadpin.h

-- 
2.36.0.550.gb090851708-goog

