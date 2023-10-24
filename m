Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B88A7D57DB
	for <lists+linux-security-module@lfdr.de>; Tue, 24 Oct 2023 18:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjJXQUi (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 24 Oct 2023 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjJXQUg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Oct 2023 12:20:36 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CF6A1
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 09:20:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9936b3d0286so706868966b.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1698164432; x=1698769232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRO+xCDaQbDKnIXJCwBi3Y2yF65udPG/2rEKc0aYwBQ=;
        b=R7vVo7ccej2Kfs+GhsAisurVFY5nd6/bOfFqi0lXMDbO7a2l8lPqzysC4bL6r+RnYp
         h2R/+0PJJi1Juys2Ad2ooxjzYS/0EDXJM7BdmV0MUNYn7QFt0XbrdtIplDW4DahSmNjX
         PQX5zN5YeCI6VJiOP3yuD3AyyKoSp3hjbq2X75cVYz5IyFfFO5deMPQPoQvUWAnRkd4m
         S3G10SyPHpyl1NzNqhUGPHcVoJS2a311Tmny59lwn45IDHKio7va1vx+DmiZyi9HySY/
         aWF9w345QCcIP8HGqiHwa8uhb44Dg/NNcWWXf6bJuKLrlUONDjMW9bmMNTUPE84JayzK
         4cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698164432; x=1698769232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRO+xCDaQbDKnIXJCwBi3Y2yF65udPG/2rEKc0aYwBQ=;
        b=owql67Lba2vgjQE1mLGaF/1nUkxYxkoCPet3/fU3ng2OmuhPq8dpLluCiz+n54+mRj
         2DcI+N+oc2vKiGz2fveylp0jrKaBd+S9UT8+MhtNH/9UnpNliud/7GG3wXwpKct0uFDy
         eTiMhDJAKvj0qqfR3yYOFE++ubD7C0UJuH5KHWOLTfiC1hXMzwxq8Rwi8UJG8lRPSJuT
         wRAQ8s2SmJxJz9aumHpJzY+mBlQ0ZbTFj8FU+FN+NQVfq8qrQpxtymXOoVGEa6gtEEKE
         aPk21DSdHF8psepxG6HOW+hc4KD/BomHdo1jYUIHPuZRZaUVhe7OiQ8mENB5Hgj4Wf9L
         n4fw==
X-Gm-Message-State: AOJu0YwqS0yazLio6v1Jf1xKl0xI1u+qpjn2DhtI3I6c3A0oFgi/PX3q
        3ZpRsFDRKfKGnZEc0BOfe9NmGQ==
X-Google-Smtp-Source: AGHT+IEIk3iJ6GCsHRYMeMdo8uw1QNTL6gntpg/5SaGUAZHqkqQekLyT81Tgpt8fo9diZdiabupYpQ==
X-Received: by 2002:a17:907:c0d:b0:9be:8693:66bb with SMTP id ga13-20020a1709070c0d00b009be869366bbmr9625930ejc.59.1698164431055;
        Tue, 24 Oct 2023 09:20:31 -0700 (PDT)
Received: from localhost (clnet-p106-198.ikbnet.co.at. [83.175.106.198])
        by smtp.gmail.com with UTF8SMTPSA id cw11-20020a170906c78b00b009add084a00csm8489556ejb.36.2023.10.24.09.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 09:20:30 -0700 (PDT)
From:   David Gstir <david@sigma-star.at>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     David Gstir <david@sigma-star.at>, Shawn Guo <shawnguo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        sigma star Kernel Team <upstream+dcp@sigma-star.at>,
        David Howells <dhowells@redhat.com>,
        Li Yang <leoyang.li@nxp.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 0/5] DCP as trusted keys backend
Date:   Tue, 24 Oct 2023 18:20:14 +0200
Message-ID: <20231024162024.51260-1-david@sigma-star.at>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is a revival of the previous patch set submitted by Richard Weinberger:
https://lore.kernel.org/linux-integrity/20210614201620.30451-1-richard@nod.at/

v3 is here:
https://lore.kernel.org/keyrings/20230918141826.8139-1-david@sigma-star.at/

v3 -> v4:
- Split changes on MAINTAINERS and documentation into dedicated patches
- Use more concise wording in commit messages as suggested by Jarkko Sakkinen
v2 -> v3:
- Addressed review comments from Jarkko Sakkinen
v1 -> v2:
- Revive and rebase to latest version
- Include review comments from Ahmad Fatoum

The Data CoProcessor (DCP) is an IP core built into many NXP SoCs such
as i.mx6ull.

Similar to the CAAM engine used in more powerful SoCs, DCP can AES-
encrypt/decrypt user data using a unique, never-disclosed,
device-specific key. Unlike CAAM though, it cannot directly wrap and
unwrap blobs in hardware. As DCP offers only the bare minimum feature
set and a blob mechanism needs aid from software. A blob in this case
is a piece of sensitive data (e.g. a key) that is encrypted and
authenticated using the device-specific key so that unwrapping can only
be done on the hardware where the blob was wrapped.

This patch series adds a DCP based, trusted-key backend and is similar
in spirit to the one by Ahmad Fatoum [0] that does the same for CAAM.
It is of interest for similar use cases as the CAAM patch set, but for
lower end devices, where CAAM is not available.

Because constructing and parsing the blob has to happen in software,
we needed to decide on a blob format and chose the following:

struct dcp_blob_fmt {
	__u8 fmt_version;
	__u8 blob_key[AES_KEYSIZE_128];
	__u8 nonce[AES_KEYSIZE_128];
	__le32 payload_len;
	__u8 payload[];
} __packed;

The `fmt_version` is currently 1.

The encrypted key is stored in the payload area. It is AES-128-GCM
encrypted using `blob_key` and `nonce`, GCM auth tag is attached at
the end of the payload (`payload_len` does not include the size of
the auth tag).

The `blob_key` itself is encrypted in AES-128-ECB mode by DCP using
the OTP or UNIQUE device key. A new `blob_key` and `nonce` are generated
randomly, when sealing/exporting the DCP blob.

This patchset was tested with dm-crypt on an i.MX6ULL board.

[0] https://lore.kernel.org/keyrings/20220513145705.2080323-1-a.fatoum@pengutronix.de/

David Gstir (5):
  crypto: mxs-dcp: Add support for hardware-bound keys
  KEYS: trusted: Introduce NXP DCP-backed trusted keys
  MAINTAINERS: add entry for DCP-based trusted keys
  docs: document DCP-backed trusted keys kernel params
  docs: trusted-encrypted: add DCP as new trust source

 .../admin-guide/kernel-parameters.txt         |  13 +
 .../security/keys/trusted-encrypted.rst       |  85 +++++
 MAINTAINERS                                   |   9 +
 drivers/crypto/mxs-dcp.c                      | 104 +++++-
 include/keys/trusted_dcp.h                    |  11 +
 include/soc/fsl/dcp.h                         |  17 +
 security/keys/trusted-keys/Kconfig            |   9 +-
 security/keys/trusted-keys/Makefile           |   2 +
 security/keys/trusted-keys/trusted_core.c     |   6 +-
 security/keys/trusted-keys/trusted_dcp.c      | 311 ++++++++++++++++++
 10 files changed, 554 insertions(+), 13 deletions(-)
 create mode 100644 include/keys/trusted_dcp.h
 create mode 100644 include/soc/fsl/dcp.h
 create mode 100644 security/keys/trusted-keys/trusted_dcp.c

-- 
2.35.3

