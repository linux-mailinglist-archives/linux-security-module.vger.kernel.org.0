Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3285A327F1D
	for <lists+linux-security-module@lfdr.de>; Mon,  1 Mar 2021 14:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbhCANMh (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 1 Mar 2021 08:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbhCANMd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Mar 2021 08:12:33 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCF6C06178B
        for <linux-security-module@vger.kernel.org>; Mon,  1 Mar 2021 05:11:53 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s7so2646846plg.5
        for <linux-security-module@vger.kernel.org>; Mon, 01 Mar 2021 05:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b3ExXcrTKtaMKYTLWvaQqay72x46/EzChsHCCF6qzCU=;
        b=b7sA/vRm3WrAy3bA3s72thm96GXP3C0iIoAmX4jN9pYjQl0r5bYZemIFYL1D7mdLPO
         k05WugUa2MpwiovRwKnXYw4IXWJmkcQtuwHQ/n9CHO9ejxb6r6s7bbP7QUQESrItpO6Y
         oyASWNdvVq3nIil5HSbzF+yQNjV7M2E6+Zv6V9Do8DL85lR7GZjBGXJHSj4kMR7XP30W
         6ZqC3zCcKih4QsFHFmeZhdxJPKCHXgVP2uYCmSsqmlCaof0V+65bGCJI0/jFIuztXHeX
         1z5ZoImHLP572W4obDz3LssDrMtgDektzGkLh7qZzjB5sfi0F8K8IF2pz3T7yqOWX9YJ
         YkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b3ExXcrTKtaMKYTLWvaQqay72x46/EzChsHCCF6qzCU=;
        b=B79fnWK75FWUE+a0G8gg/OBUZPb5bSjrT7Mb8yNgVJtLNajJQi+NUt3bwvYKyA/ksh
         4BOq2JQRRy7cMUEy11SgbW6hihasYjfkl0b1eAPHrFIBzBMMLZRpmwFAIkhqt9L2i2+W
         7/xgBMsb2ZOzkq5VJB6rTt8YVJwbvLN2Gv41oLdVMLPdFx8iQcjjOK3PlyKiQkWHYfBt
         k5VYBCSdEKoBaRZf6vMP9Vjplhs+L0F+/J4JxJhWMcLWgIZ1JSFE61y+R2fjU/o3LwuP
         vjkl2lDqMjiTbeQespgNH6Y938pFDCes4jUkt2ksKpq0NgKaWfIc4mOq0HrqoG4UARXj
         amgQ==
X-Gm-Message-State: AOAM531ZjrxMRxcPqb+qM4EyHrG7+AJaHrCk0xDkGteLc7hVrfmGyIAA
        6Jm90B19LV29ed10b0CTmJ75Xg==
X-Google-Smtp-Source: ABdhPJzEwXoFW5aHXjckvLnyESk7reRavQszrdC8mYNQ9CxHGgFAhrl6FUGikFWhCrRy8h0bxbZLBg==
X-Received: by 2002:a17:90a:1a59:: with SMTP id 25mr16193091pjl.54.1614604312435;
        Mon, 01 Mar 2021 05:11:52 -0800 (PST)
Received: from localhost.localdomain ([110.226.35.200])
        by smtp.gmail.com with ESMTPSA id b3sm13964523pjg.41.2021.03.01.05.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 05:11:51 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        erpalmer@us.ibm.com, a.fatoum@pengutronix.de,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v9 0/4] Introduce TEE based Trusted Keys support
Date:   Mon,  1 Mar 2021 18:41:23 +0530
Message-Id: <20210301131127.793707-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add support for TEE based trusted keys where TEE provides the functionality
to seal and unseal trusted keys using hardware unique key. Also, this is
an alternative in case platform doesn't possess a TPM device.

This patch-set has been tested with OP-TEE based early TA which is already
merged in upstream [1].

[1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37ee070d7e5b86b

Changes in v9:
1. Rebased to latest tpmdd/master.
2. Defined pr_fmt() and removed redundant tags.
3. Patch #2: incorporated misc. comments.
4. Patch #3: incorporated doc changes from Elaine and misc. comments
   from Randy.
5. Patch #4: reverted to separate maintainer entry as per request from
   Jarkko.
6. Added Jarkko's Tested-by: tag on patch #2.

Changes in v8:
1. Added static calls support instead of indirect calls.
2. Documented trusted keys source module parameter.
3. Refined patch #1 commit message discription.
4. Addressed misc. comments on patch #2.
5. Added myself as Trusted Keys co-maintainer instead.
6. Rebased to latest tpmdd master.

Changes in v7:
1. Added a trusted.source module parameter in order to enforce user's
   choice in case a particular platform posses both TPM and TEE.
2. Refine commit description for patch #1.

Changes in v6:
1. Revert back to dynamic detection of trust source.
2. Drop author mention from trusted_core.c and trusted_tpm1.c files.
3. Rebased to latest tpmdd/master.

Changes in v5:
1. Drop dynamic detection of trust source and use compile time flags
   instead.
2. Rename trusted_common.c -> trusted_core.c.
3. Rename callback: cleanup() -> exit().
4. Drop "tk" acronym.
5. Other misc. comments.
6. Added review tags for patch #3 and #4.

Changes in v4:
1. Pushed independent TEE features separately:
  - Part of recent TEE PR: https://lkml.org/lkml/2020/5/4/1062
2. Updated trusted-encrypted doc with TEE as a new trust source.
3. Rebased onto latest tpmdd/master.

Changes in v3:
1. Update patch #2 to support registration of multiple kernel pages.
2. Incoporate dependency patch #4 in this patch-set:
   https://patchwork.kernel.org/patch/11091435/

Changes in v2:
1. Add reviewed-by tags for patch #1 and #2.
2. Incorporate comments from Jens for patch #3.
3. Switch to use generic trusted keys framework.

Sumit Garg (4):
  KEYS: trusted: Add generic trusted keys framework
  KEYS: trusted: Introduce TEE based Trusted Keys
  doc: trusted-encrypted: updates with TEE as a new trust source
  MAINTAINERS: Add entry for TEE based Trusted Keys

 .../admin-guide/kernel-parameters.txt         |  12 +
 .../security/keys/trusted-encrypted.rst       | 171 ++++++--
 MAINTAINERS                                   |   8 +
 include/keys/trusted-type.h                   |  53 +++
 include/keys/trusted_tee.h                    |  16 +
 include/keys/trusted_tpm.h                    |  29 +-
 security/keys/trusted-keys/Makefile           |   2 +
 security/keys/trusted-keys/trusted_core.c     | 358 +++++++++++++++++
 security/keys/trusted-keys/trusted_tee.c      | 317 +++++++++++++++
 security/keys/trusted-keys/trusted_tpm1.c     | 366 ++++--------------
 10 files changed, 981 insertions(+), 351 deletions(-)
 create mode 100644 include/keys/trusted_tee.h
 create mode 100644 security/keys/trusted-keys/trusted_core.c
 create mode 100644 security/keys/trusted-keys/trusted_tee.c

-- 
2.25.1

