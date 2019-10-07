Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13622CDB58
	for <lists+linux-security-module@lfdr.de>; Mon,  7 Oct 2019 07:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfJGF0o (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 7 Oct 2019 01:26:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39880 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfJGF0o (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Oct 2019 01:26:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17so6297578plp.6
        for <linux-security-module@vger.kernel.org>; Sun, 06 Oct 2019 22:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1XpgQPoN+UcClVgrIlyON95HaUMJi3oZGyVlHRQ7/YE=;
        b=oJvL03CNiwIGAzVCpkxpmmFYefUdYS0uFbWbKHzkPIngh4gEhMZaLviuWrACXgMGom
         seIcuVppGarffY4hbgKKh5GD7rtMulaDxxX90phKlid3B8oUIgax+rSsFse06hI5uvbH
         adrSchEYYl6H1gOGEmAjd1vb/s5/h5HhhUQxzbOmu+WJnAcrOTYeMGGPdCm92QEqPF1Q
         N0mgSzfXePsz1O5/seTaS6Hp/rbmyWz+DhAs2G7qpmsY9C23yaA4aZVFlg3mLzZBmU6B
         aUturVn/FXN49wkjO9INicdodor6bW8K3JCk7H8XowXPN5IWb0+ER18dzeAqt5j4pgjE
         Z+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1XpgQPoN+UcClVgrIlyON95HaUMJi3oZGyVlHRQ7/YE=;
        b=dMOyMKkr3sH6ECi44aZiN/1qq43c6vqYgc/mEojFmECJVtPJVtIDAjZ3bX//iIlGMi
         Q2zl3lbxF+hTj3f9LTqVqireP9O4Z29Z/vaSwxyxvlKKJEMkRV+yP2auggnvN72LCHjV
         unynRj82eyqfANOb3MfBIsXR7j/jBWJuHwGk3Y1/271TCLXMy5nH+W8LruZj5G72vpTS
         Xh0kr8NMBpfC7JKdjNpiIBO2y0jDItu3/AR95JHMel7PkeMugrakwzF5HxjdAZiMYP8A
         1EQWZbo3ZYkNexBdAja7RCSLJH2T3XJ9ogpgBx9M/XV2tvStYfuClPLT7wjExUA2swYI
         2Uqw==
X-Gm-Message-State: APjAAAXXLn0A2p9XLrUPD7NQIpPgKlQ0pbirDCxbam02WWSr2t/virHT
        UTqTOTpYpjnPUHExdpcSDgKMqA==
X-Google-Smtp-Source: APXvYqwVrP1ltr11Rwk/RorG9/LvEAH0DFK23AAsbW8dKkGfRlTDdGdcPLHN0IHpS9aXB1RSf96pSw==
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr27735596plq.138.1570426003313;
        Sun, 06 Oct 2019 22:26:43 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.194])
        by smtp.gmail.com with ESMTPSA id x9sm15895448pje.27.2019.10.06.22.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Oct 2019 22:26:42 -0700 (PDT)
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
Subject: [Patch v7 0/4] Create and consolidate trusted keys subsystem
Date:   Mon,  7 Oct 2019 10:55:31 +0530
Message-Id: <1570425935-7435-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch-set does restructuring of trusted keys code to create and
consolidate trusted keys subsystem.

Also, patch #2 replaces tpm1_buf code used in security/keys/trusted.c and
crypto/asymmertic_keys/asym_tpm.c files to use the common tpm_buf code.

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
 drivers/char/tpm/tpm.h                             | 226 ---------------
 drivers/char/tpm/tpm2-cmd.c                        | 307 --------------------
 include/Kbuild                                     |   1 -
 include/keys/{trusted.h => trusted_tpm.h}          |  49 +---
 include/linux/tpm.h                                | 251 ++++++++++++++--
 security/keys/Makefile                             |   2 +-
 security/keys/trusted-keys/Makefile                |   8 +
 .../{trusted.c => trusted-keys/trusted_tpm1.c}     |  96 +++----
 security/keys/trusted-keys/trusted_tpm2.c          | 314 +++++++++++++++++++++
 11 files changed, 652 insertions(+), 759 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (77%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted_tpm1.c} (94%)
 create mode 100644 security/keys/trusted-keys/trusted_tpm2.c

-- 
2.7.4

