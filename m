Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653CC8B17D
	for <lists+linux-security-module@lfdr.de>; Tue, 13 Aug 2019 09:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfHMHxr (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 13 Aug 2019 03:53:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41611 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfHMHxq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Aug 2019 03:53:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so40485427pgg.8
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2019 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BkX27APDVJ4zeW7H5E4Qx7Yc0d0xGm41vKaV5VvGjbc=;
        b=EUdHy4gMsfvnN4CUa0oecjGACMAqEVtxiUGdmUM3Ngncip9f6n/2Rw3ZJn3X3l9sZS
         ny7AGcTCFJ27zwjOfnJYgheFkweH5FQbRnDxSUbatFM1XzLPKIrQ0NsauE3UI+Pn2wN4
         UE/C03Zfv4d623FqJOP5vQnECBcvuG6mCHsddHNdxCQiCpjZsrsiXlkRAF4EwV8bKEuE
         eDubrM7GZHn2mlNSjuQ8nRtqxC1F6z4Zpxp6mFZ46jTNGRrarGKsv3ypYdN2n9ojSJNd
         Ysgt6PpD7gEePDOcIc4ocX6twitoDfuOom2ZT+6tneIx2mXRrQjm58Ql21kdt6VTnIo6
         YyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BkX27APDVJ4zeW7H5E4Qx7Yc0d0xGm41vKaV5VvGjbc=;
        b=eb9KyAMaos/4pNHRKdxkWX3ewN34aBkoGTW6S8yIq3npglHWjZI9snzfPZ/8K2KvJ/
         0PrKv9/j0SwTSGMPc175IPyfSRAvxssGP1qbKZA2uLHasGJjbXNRRL6p7i96QDpGbZUX
         QWuOcXoYpE0Wg0FlmPKNq7WObAv4l+Azx259OdOpLjNA5DKKK8ZDa3GxJ8pwpnQJQMBa
         U2y9J0Pyt4+DK/MfkPsL7rO3IlYpKMuj9vNFFD+SJmNEq2Ub5J3KLhsM4b06oBSByUou
         gPZft3gr+rfjSNG5jmp9CrksaqFEtTJKkJ6hMsmjv3racLKu4ze9Dj7Nz/0BzGHZSv9b
         3/lg==
X-Gm-Message-State: APjAAAVElmi+FonrLK9Pe2FQ5Hr5kkFw7MuH4i2ucHfhrbU2FJWBwbey
        5rPsH66iILuoryZDXA029DdEYA==
X-Google-Smtp-Source: APXvYqxRe3kDEnRmKsgK98qrW7tpR2Jo5TKYlmK35RYqch6gNYKDeSUOOqqDMefeWOISDFFAHhX7kQ==
X-Received: by 2002:a17:90b:8c1:: with SMTP id ds1mr1040437pjb.114.1565682826009;
        Tue, 13 Aug 2019 00:53:46 -0700 (PDT)
Received: from localhost.localdomain ([45.114.72.100])
        by smtp.gmail.com with ESMTPSA id l25sm131462563pff.143.2019.08.13.00.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 00:53:45 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC/RFT v4 0/5] Add generic trusted keys framework/subsystem
Date:   Tue, 13 Aug 2019 13:22:59 +0530
Message-Id: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch-set is an outcome of discussion here [1]. It has evolved very
much since v1 to create, consolidate and generalize trusted keys
subsystem.

This framework has been tested with trusted keys support provided via TEE
but I wasn't able to test it with a TPM device as I don't possess one. It
would be really helpful if others could test this patch-set using a TPM
device.

[1] https://www.mail-archive.com/linux-doc@vger.kernel.org/msg30591.html

Changes in v4:
1. Separate patch for export of tpm_buf code to include/linux/tpm.h
2. Change TPM1.x trusted keys code to use common tpm_buf
3. Keep module name as trusted.ko only

Changes in v3:

Move TPM2 trusted keys code to trusted keys subsystem.

Changes in v2:

Split trusted keys abstraction patch for ease of review.

Sumit Garg (5):
  tpm: move tpm_buf code to include/linux/
  KEYS: trusted: use common tpm_buf for TPM1.x code
  KEYS: trusted: create trusted keys subsystem
  KEYS: trusted: move tpm2 trusted keys code
  KEYS: trusted: Add generic trusted keys framework

 crypto/asymmetric_keys/asym_tpm.c                  |   2 +-
 drivers/char/tpm/tpm-chip.c                        |   1 +
 drivers/char/tpm/tpm-interface.c                   |  56 ---
 drivers/char/tpm/tpm.h                             | 230 -----------
 drivers/char/tpm/tpm2-cmd.c                        | 308 +--------------
 include/keys/trusted-type.h                        |  45 +++
 include/keys/{trusted.h => trusted_tpm.h}          |  61 +--
 include/linux/tpm.h                                | 270 ++++++++++++-
 security/keys/Makefile                             |   2 +-
 security/keys/trusted-keys/Makefile                |   9 +
 security/keys/trusted-keys/trusted-common.c        | 343 ++++++++++++++++
 .../keys/{trusted.c => trusted-keys/trusted-tpm.c} | 437 +++++----------------
 security/keys/trusted-keys/trusted-tpm2.c          | 378 ++++++++++++++++++
 13 files changed, 1141 insertions(+), 1001 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (64%)
 create mode 100644 security/keys/trusted-keys/Makefile
 create mode 100644 security/keys/trusted-keys/trusted-common.c
 rename security/keys/{trusted.c => trusted-keys/trusted-tpm.c} (72%)
 create mode 100644 security/keys/trusted-keys/trusted-tpm2.c

-- 
2.7.4

