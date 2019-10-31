Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7AEEB1C5
	for <lists+linux-security-module@lfdr.de>; Thu, 31 Oct 2019 14:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfJaN7c (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 31 Oct 2019 09:59:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37924 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfJaN7c (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Oct 2019 09:59:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id c13so4436957pfp.5
        for <linux-security-module@vger.kernel.org>; Thu, 31 Oct 2019 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FInjRudIZ1nBXyYRthwNUoyrlLqGhK39QJ4i7rNkC2w=;
        b=q5NzzfdyvqU9FJ8L/8YVWhVw3zm/TD9+GmoDJBcQbO9fthEhMN0aA0zr1Jrn1Pe7Xv
         3yxVpV1aCIy2BlbrmcRSI52doE+NBDvyhqGBcl545OAR+xdAP/8XKGa9aYsXyxpC6c4r
         u/dLASdI5rFuj8KWg0Vg1ucxIfzi2SA6p0SEDwT5MaAY46LtvSjOArYaKC/ICMwgAn7L
         5yuRCDkCXiEplKpIc1i196ovUMs+7c/jfyoF8FuXwJS2nhJb0Wx7IK586+yvbVU7V+hM
         Z6T46N/XjF+k5fnSVRUiPTy/WMYlR9bd07WIAjbDF892AolQA4/q3VfGdCWxQIZ0w7m6
         3cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FInjRudIZ1nBXyYRthwNUoyrlLqGhK39QJ4i7rNkC2w=;
        b=gHJNJgAuFYzX3wWY1yOzn9vY2giPl1scqITmfvCaK8tr3uc5wO8el80mF+kwFb8G26
         3OCHKjHh3ALGK3Bft6+ArQyDuqzs9079vEck2AXzKOU6NusSHFQLB5/RjYguJrOoLzMG
         u7nhZPkKtpWAucJ2iWFe8EOejAdGfOkqwG3wyYl4WWFRfMk2QBTOHq+7sM2ExIh7uTDf
         hUzwSq1voPklqkKCk31S96OiMD6MAHkfubjC5Hj1tYcvMMy3bo3hk0wbqMLwhCfuuaNK
         /K5c582MDkyC9i7LpgzXSs7ceOJ38tOuvoUHASiFxlI7hpjtxwC2gbx4yhF8V3UtV9hm
         2h0g==
X-Gm-Message-State: APjAAAUHhB8tF5vdrw4BCu1+PgIzAA44F7y5yKKTghyoro9TntbsPnTy
        IyzVPKuVRl4wmTDWjEg0Z8ZJaw==
X-Google-Smtp-Source: APXvYqzSpyD3GqbjVXKqKIxqLX3kf+eG/s3lqHhViq0jkE0RgoF86gbfk8pNgZ03UDv+V7aDn7oogg==
X-Received: by 2002:aa7:8817:: with SMTP id c23mr7024726pfo.162.1572530371532;
        Thu, 31 Oct 2019 06:59:31 -0700 (PDT)
Received: from localhost.localdomain ([117.252.69.143])
        by smtp.gmail.com with ESMTPSA id i16sm3522441pfa.184.2019.10.31.06.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 06:59:30 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, jarkko.sakkinen@linux.intel.com,
        dhowells@redhat.com
Cc:     corbet@lwn.net, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        stuart.yoder@arm.com, janne.karhunen@gmail.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v3 0/7] Introduce TEE based Trusted Keys support
Date:   Thu, 31 Oct 2019 19:28:36 +0530
Message-Id: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add support for TEE based trusted keys where TEE provides the functionality
to seal and unseal trusted keys using hardware unique key. Also, this is
an alternative in case platform doesn't possess a TPM device.

This series also adds some TEE features like:

Patch #1, #2 enables support for registered kernel shared memory with TEE.

Patch #3 enables support for private kernel login method required for
cases like trusted keys where we don't wan't user-space to directly access
TEE service to retrieve trusted key contents.

Rest of the patches from #4 to #7 adds support for TEE based trusted keys.

This patch-set has been tested with OP-TEE based pseudo TA which can be
found here [1].

[1] https://github.com/OP-TEE/optee_os/pull/3082

Changes in v3:
1. Update patch #2 to support registration of multiple kernel pages.
2. Incoporate dependency patch #4 in this patch-set:
   https://patchwork.kernel.org/patch/11091435/
3. Rebased to latest tpmdd-master.

Changes in v2:
1. Add reviewed-by tags for patch #1 and #2.
2. Incorporate comments from Jens for patch #3.
3. Switch to use generic trusted keys framework.

Sumit Garg (7):
  tee: optee: allow kernel pages to register as shm
  tee: enable support to register kernel memory
  tee: add private login method for kernel clients
  KEYS: trusted: Add generic trusted keys framework
  KEYS: trusted: Introduce TEE based Trusted Keys
  doc: keys: Document usage of TEE based Trusted Keys
  MAINTAINERS: Add entry for TEE based Trusted Keys

 Documentation/security/keys/index.rst       |   1 +
 Documentation/security/keys/tee-trusted.rst |  93 ++++++++
 MAINTAINERS                                 |   9 +
 drivers/tee/optee/call.c                    |   7 +
 drivers/tee/tee_core.c                      |   6 +
 drivers/tee/tee_shm.c                       |  26 ++-
 include/keys/trusted-type.h                 |  48 ++++
 include/keys/trusted_tee.h                  |  66 ++++++
 include/keys/trusted_tpm.h                  |  15 --
 include/linux/tee_drv.h                     |   1 +
 include/uapi/linux/tee.h                    |   8 +
 security/keys/Kconfig                       |   3 +
 security/keys/trusted-keys/Makefile         |   2 +
 security/keys/trusted-keys/trusted_common.c | 346 ++++++++++++++++++++++++++++
 security/keys/trusted-keys/trusted_tee.c    | 282 +++++++++++++++++++++++
 security/keys/trusted-keys/trusted_tpm1.c   | 345 +++++----------------------
 16 files changed, 954 insertions(+), 304 deletions(-)
 create mode 100644 Documentation/security/keys/tee-trusted.rst
 create mode 100644 include/keys/trusted_tee.h
 create mode 100644 security/keys/trusted-keys/trusted_common.c
 create mode 100644 security/keys/trusted-keys/trusted_tee.c

-- 
2.7.4

