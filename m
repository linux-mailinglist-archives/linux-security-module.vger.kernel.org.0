Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B61E6CD4E
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Jul 2019 13:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfGRLZn (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 18 Jul 2019 07:25:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37187 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfGRLZn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jul 2019 07:25:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so13739885plr.4
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jul 2019 04:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=k3a2v4scLqCzIgsIewhCrR8or1GEYNGppEVY9Fy2O/U=;
        b=M1FLy5Kk4LfikIbzpeaUWtN1zq1XlK5JvCef3h2YeRK38Wr6CrReh7qdmTSxBKd0tr
         o+bCMkEycBSfB22Ym3qrIiJhVXMF9RRjehkyX4ib2C30YhMXPk/zH6IB8r7T/nzqnuEx
         ldwsWbOg/J27MJz09b6pj/NMbBOco/WX3y3STg9Qgzjq5H3TaRXVvFHplilz8xmCFaRq
         2SlV3Yy6NxfGr3rWKGOpKjJbtACX48g85y5OprttVWZBrMtKLjw8FkeXjowey0P+3cWN
         oc/Yh0GZ+8n27tCHhwfoDVKKZ5PuL/GM+tRgRcQ9pLybCrQ79gy1bTYJ1liiVoE73HeL
         VkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k3a2v4scLqCzIgsIewhCrR8or1GEYNGppEVY9Fy2O/U=;
        b=j1405CJt159RGY+yY1NXT+niNNZX3yAk3kEpymGuBiMEyc5ftVXe5lWUW8bT4U6iCy
         LJty5b3ZS4/uQ13HM2cbWdJSPbQZe1MnjCBF9v1XsP6HUa0ew8XiQ0A1hLq6LegzDf0X
         lekWzKDW2ofN3ghIqgG/Z4xaGWTt08QGUVMPAQ1A4bjPoRhj1MdyHVbN/LZiEUs8bbQW
         Y4h0mXsNW3/gAJ0p8pf5yqIvKdtP2TxPYvEMkAjDznhLUcLHkPGBNmRqTP25RbspPoWZ
         Y4sP8+KIanFTI69DiECnN2CwpAYg3VXSSYkizTCLepl773rF6DbcXCpIWXKRFKLI+Z34
         LrQw==
X-Gm-Message-State: APjAAAWLqXcJkBtVh3XdVf28YqUwOahZFldIVysv2ZuD7bFNrKj6jDni
        AsCE1lrYLMCNfDglinIlNIqnvg==
X-Google-Smtp-Source: APXvYqzQf4CQsiQAtlZs4mdLJM/AQwjnWt8JUhNrsglzHFXFxeb6/N9wuQp9kLw/Y9rgnv3leMPvBw==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr48096653plp.95.1563449142612;
        Thu, 18 Jul 2019 04:25:42 -0700 (PDT)
Received: from localhost.localdomain ([117.252.69.63])
        by smtp.gmail.com with ESMTPSA id 3sm29648436pfg.186.2019.07.18.04.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jul 2019 04:25:41 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, jejb@linux.ibm.com,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC/RFT v2 0/2] KEYS: trusted: Add generic trusted keys framework
Date:   Thu, 18 Jul 2019 16:54:44 +0530
Message-Id: <1563449086-13183-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch-set is an outcome of discussion here [1].

I have tested this framework with trusted keys support provided via TEE
but I wasn't able to test it with a TPM device as I don't possess one. It
would be really helpful if others could test this patch-set using a TPM
device.

[1] https://www.mail-archive.com/linux-doc@vger.kernel.org/msg30591.html

Changes in v2:

Split trusted keys abstraction patch for ease of review.

Sumit Garg (2):
  KEYS: trusted: create trusted keys subsystem
  KEYS: trusted: Add generic trusted keys framework

 crypto/asymmetric_keys/asym_tpm.c                  |   2 +-
 include/keys/trusted-type.h                        |  45 +++
 include/keys/{trusted.h => trusted_tpm.h}          |  19 +-
 security/keys/Makefile                             |   2 +-
 security/keys/trusted-keys/Makefile                |   7 +
 .../keys/{trusted.c => trusted-keys/trusted-tpm.c} | 347 ++++-----------------
 security/keys/trusted-keys/trusted.c               | 343 ++++++++++++++++++++
 7 files changed, 458 insertions(+), 307 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (85%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted-tpm.c} (77%)
 create mode 100644 security/keys/trusted-keys/trusted.c

-- 
2.7.4

