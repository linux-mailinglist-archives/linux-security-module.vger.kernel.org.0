Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B279D87D9
	for <lists+linux-security-module@lfdr.de>; Wed, 16 Oct 2019 07:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfJPFPU (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 16 Oct 2019 01:15:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40516 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfJPFPU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Oct 2019 01:15:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so13924497pfb.7
        for <linux-security-module@vger.kernel.org>; Tue, 15 Oct 2019 22:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=t9/za3FSNI+nWYnls/YkfcKZQCH6Udse6CzJVH/I/fg=;
        b=BwXQgkLN2RA+shEgesXS9BP68Z3xU+nrV7SdKCEZB4oOqm58QVTMQnF0TZHVe49p5l
         7nUcBVWCJECdmMiOY1vGnfKYV8xqgwHOnFfbeItVMtV5pKp0/MgpEj0KO1gcWqy/F8PK
         exYsHgtPjBABP3K9tNaDAQehQqaD3ukHrulUiBIB8uyz6W7I1betj6joG27BYNOHD1RP
         btRV07EjrwaH6H0oadoicz5CVziQU4QWGrKelwoRcn3IqcwNSHfo3Fqo897cnkMcCHwg
         pjWz2OmqdQAVjR0YY5LktzGiss0vzgcPQXCaNHP4lTEpJP4Jg3RGtYXB9axtEmjYgwwq
         KFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t9/za3FSNI+nWYnls/YkfcKZQCH6Udse6CzJVH/I/fg=;
        b=DhTsg4sCo3YrNH+c5McBLgHm+yb0oUa2Tnvz7klzv7WDjXVwah8Z2fiwzoeURqcaOZ
         Vwkqxpd0hczZbnUpDEVmhZByYbRgJNtILElpJbudnwoJqrJZlCaG1aD0FhfXoqzsZ5AB
         dtk3LZ/G20twR2JTrY2bZUwv2PN0kHQ3hlUtmEmcQQX+JWxs1lQhDmbq8w4IHGDhCUZc
         DC2zaEH3ZXprVEE/k3Q/JiC8/dkndJJ0TcKkeKu0/nb6kZBQcFLD/jqfNAfsuP0dEA9Q
         8bWze1tedcJnu07xorLZCMtQ8HI9xP2ulzD7rV7T/qxyGsW7axqeNsm/HMGWOLyvljxV
         /yKw==
X-Gm-Message-State: APjAAAU73Xp/fH9PrU1gRNLNmhZAAMfs4AV0gtUYq2oBBT8FKXIkQAtT
        c5veQWlCrDqg7FJdLdNriKsTWA==
X-Google-Smtp-Source: APXvYqzkWIM3jmKMEoadF765aTKzSZAJGrbaiP36VpGJPmBFt9PYn/hz61qsJUZzgNhb/7L+a8j1Kw==
X-Received: by 2002:a62:ab02:: with SMTP id p2mr42986356pff.92.1571202919655;
        Tue, 15 Oct 2019 22:15:19 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.194])
        by smtp.gmail.com with ESMTPSA id r81sm953297pgr.17.2019.10.15.22.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Oct 2019 22:15:18 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        peterhuewe@gmx.de
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        jsnitsel@redhat.com, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v8 0/4] Create and consolidate trusted keys subsystem
Date:   Wed, 16 Oct 2019 10:44:51 +0530
Message-Id: <1571202895-32651-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch-set does restructuring of trusted keys code to create and
consolidate trusted keys subsystem.

Also, patch #2 replaces tpm1_buf code used in security/keys/trusted.c and
crypto/asymmertic_keys/asym_tpm.c files to use the common tpm_buf code.

Changes in v8:
1. Rebased to latest tpmdd/master.
2. Added Reviewed-by tags.

Changes in v7:
1. Rebased to top of tpmdd/master
2. Patch #4: update tpm2 trusted keys code to use tpm_send() instead of
   tpm_transmit_cmd() which is an internal function.

Changes in v6:
1. Switch TPM asymmetric code also to use common tpm_buf code. These
   changes required patches #1 and #2 update, so I have dropped review
   tags from those patches.
2. Incorporated miscellaneous comments from Jarkko.

Changes in v5:
1. Drop 5/5 patch as its more relavant along with TEE patch-set.
2. Add Reviewed-by tag for patch #2.
3. Fix build failure when "CONFIG_HEADER_TEST" and
   "CONFIG_KERNEL_HEADER_TEST" config options are enabled.
4. Misc changes to rename files.

Changes in v4:
1. Separate patch for export of tpm_buf code to include/linux/tpm.h
2. Change TPM1.x trusted keys code to use common tpm_buf
3. Keep module name as trusted.ko only

Changes in v3:

Move TPM2 trusted keys code to trusted keys subsystem.

Changes in v2:

Split trusted keys abstraction patch for ease of review.

Sumit Garg (4):
  tpm: Move tpm_buf code to include/linux/
  KEYS: Use common tpm_buf for trusted and asymmetric keys
  KEYS: trusted: Create trusted keys subsystem
  KEYS: trusted: Move TPM2 trusted keys code

 crypto/asymmetric_keys/asym_tpm.c                  | 101 +++----
 drivers/char/tpm/tpm-interface.c                   |  56 ----
 drivers/char/tpm/tpm.h                             | 223 ---------------
 drivers/char/tpm/tpm2-cmd.c                        | 307 --------------------
 include/Kbuild                                     |   1 -
 include/keys/{trusted.h => trusted_tpm.h}          |  49 +---
 include/linux/tpm.h                                | 248 ++++++++++++++--
 security/keys/Makefile                             |   2 +-
 security/keys/trusted-keys/Makefile                |   8 +
 .../{trusted.c => trusted-keys/trusted_tpm1.c}     |  96 +++----
 security/keys/trusted-keys/trusted_tpm2.c          | 314 +++++++++++++++++++++
 11 files changed, 649 insertions(+), 756 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (77%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted_tpm1.c} (94%)
 create mode 100644 security/keys/trusted-keys/trusted_tpm2.c

-- 
2.7.4

