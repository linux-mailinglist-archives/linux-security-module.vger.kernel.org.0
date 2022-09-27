Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35C95ECA0A
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Sep 2022 18:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiI0Qux (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 27 Sep 2022 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiI0QuK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Sep 2022 12:50:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061525851A
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 09:50:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 9so10164785pfz.12
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Osgivv1xZqrvAofoxgxtt3Fhv5buczncGhXN6IzEZgM=;
        b=MnrEQZGGGi7Zz5FsNy2Hp51B9vBhT3Qw6PnZqJ8R1qlLmr9ahYCagnw0WtklFIQ77J
         WB9FmgJGeez4cna1TcM4yZVBghJmmKK/4rqdTnorUHJKRzyIazqEyoYoDR0ScsJQaQgY
         Lb3shhu74tkzqegJoyfLluUZF7kePYYkzwBNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Osgivv1xZqrvAofoxgxtt3Fhv5buczncGhXN6IzEZgM=;
        b=jeaZFB4y+Xy2y3G+32UbOY98u+Ze6kb4Y0F6wuASGqgIviIRGjPROi/q0gbsje0uS/
         +n+JbXHxgrlpmDT+DJHf6dSww0JpIU/AwdDpuZyQUd/NzxceqSpA/om2W9WP278t3or9
         jquqadX8FCQb4A2RNMTZYGs1qa8XpV7SavBtfGY5N3NrAicKyUaFoURBTFlwppxBpC5t
         Ps4rzsOVRvkZCjtQB+ODqJbsucoPbwM17Gr9iPlzxDbGza1pVgKUF/iGRasbiVKw1sWX
         8Gjh3SLuwo067UL7pfFzCc5nHNnzDUddsi0fmsnNDO7dtk2tgoY6qeFPdu/hXKlgj03e
         ZAWw==
X-Gm-Message-State: ACrzQf0J7t4gZsE9hDsAmNQwQB7FEURHQuM0oNViPbnBmQ9+Ui4YSmVI
        cIrw9vzLccUHl1vsUQoGIHgCoQ==
X-Google-Smtp-Source: AMsMyM6zg6GU62faRZTKgXdQyh5+c6x1H6TPVhoa0Pj8IbzdKDRvUzr6V2vk1Pk1Ou1mPyi78I5E1w==
X-Received: by 2002:a63:8643:0:b0:440:2914:c57 with SMTP id x64-20020a638643000000b0044029140c57mr921010pgd.604.1664297406379;
        Tue, 27 Sep 2022 09:50:06 -0700 (PDT)
Received: from evgreen-glaptop.lan ([73.231.74.141])
        by smtp.gmail.com with ESMTPSA id p13-20020a63950d000000b00434272fe870sm1753509pgd.88.2022.09.27.09.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:50:05 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, apronin@chromium.org,
        dlunev@google.com, jarkko@kernel.org, Pavel Machek <pavel@ucw.cz>,
        Ben Boeckel <me@benboeckel.net>, rjw@rjwysocki.net,
        corbet@lwn.net, linux-pm@vger.kernel.org, zohar@linux.ibm.com,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>, jejb@linux.ibm.com,
        gwendal@chromium.org, Matthew Garrett <mgarrett@aurora.tech>,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Evan Green <evgreen@chromium.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v3 05/11] security: keys: trusted: Allow storage of PCR values in creation data
Date:   Tue, 27 Sep 2022 09:49:16 -0700
Message-Id: <20220927094559.v3.5.I32591db064b6cdc91850d777f363c9d05c985b39@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220927164922.3383711-1-evgreen@chromium.org>
References: <20220927164922.3383711-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <matthewgarrett@google.com>

When TPMs generate keys, they can also generate some information
describing the state of the PCRs at creation time. This data can then
later be certified by the TPM, allowing verification of the PCR values.
This allows us to determine the state of the system at the time a key
was generated. Add an additional argument to the trusted key creation
options, allowing the user to provide the set of PCRs that should have
their values incorporated into the creation data.

Link: https://lore.kernel.org/lkml/20210220013255.1083202-6-matthewgarrett@google.com/
Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v3:
 - Clarified creationpcrs documentation (Ben)

 .../security/keys/trusted-encrypted.rst       |  6 +++++
 include/keys/trusted-type.h                   |  1 +
 security/keys/trusted-keys/trusted_tpm1.c     |  9 +++++++
 security/keys/trusted-keys/trusted_tpm2.c     | 25 +++++++++++++++++--
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 0bfb4c33974890..fd9c7cd72a6254 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -199,6 +199,12 @@ Usage::
        policyhandle= handle to an authorization policy session that defines the
                      same policy and with the same hash algorithm as was used to
                      seal the key.
+       creationpcrs= hex integer representing the set of PCRs to be
+                     included in the creation data. For each bit set, the
+                     corresponding PCR will be included in the key creation
+                     data. Bit 0 corresponds to PCR0. Currently only the first
+                     PC standard 24 PCRs are supported on the currently active
+                     bank. Leading zeroes are optional. TPM2 only.
 
 "keyctl print" returns an ascii hex copy of the sealed key, which is in standard
 TPM_STORED_DATA format.  The key length for new keys are always in bytes.
diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 209086fed240a5..8523d41507b2a4 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -54,6 +54,7 @@ struct trusted_key_options {
 	uint32_t policydigest_len;
 	unsigned char policydigest[MAX_DIGEST_SIZE];
 	uint32_t policyhandle;
+	uint32_t creation_pcrs;
 };
 
 struct trusted_key_ops {
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index aa108bea6739b3..2975827c01bec0 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -713,6 +713,7 @@ enum {
 	Opt_hash,
 	Opt_policydigest,
 	Opt_policyhandle,
+	Opt_creationpcrs,
 };
 
 static const match_table_t key_tokens = {
@@ -725,6 +726,7 @@ static const match_table_t key_tokens = {
 	{Opt_hash, "hash=%s"},
 	{Opt_policydigest, "policydigest=%s"},
 	{Opt_policyhandle, "policyhandle=%s"},
+	{Opt_creationpcrs, "creationpcrs=%s"},
 	{Opt_err, NULL}
 };
 
@@ -858,6 +860,13 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 				return -EINVAL;
 			opt->policyhandle = handle;
 			break;
+		case Opt_creationpcrs:
+			if (!tpm2)
+				return -EINVAL;
+			res = kstrtoint(args[0].from, 16, &opt->creation_pcrs);
+			if (res < 0)
+				return -EINVAL;
+			break;
 		default:
 			return -EINVAL;
 		}
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index e1388d7d799a36..a7ad83bc0e5396 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -401,7 +401,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	struct tpm_buf buf;
 	u32 hash;
 	u32 flags;
-	int i;
+	int i, j;
 	int rc;
 
 	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
@@ -470,7 +470,28 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	tpm_buf_append_u16(&buf, 0);
 
 	/* creation PCR */
-	tpm_buf_append_u32(&buf, 0);
+	if (options->creation_pcrs) {
+		/* One bank */
+		tpm_buf_append_u32(&buf, 1);
+		/* Which bank to use */
+		tpm_buf_append_u16(&buf, hash);
+		/* Length of the PCR bitmask */
+		tpm_buf_append_u8(&buf, 3);
+		/* PCR bitmask */
+		for (i = 0; i < 3; i++) {
+			char tmp = 0;
+
+			for (j = 0; j < 8; j++) {
+				char bit = (i * 8) + j;
+
+				if (options->creation_pcrs & (1 << bit))
+					tmp |= (1 << j);
+			}
+			tpm_buf_append_u8(&buf, tmp);
+		}
+	} else {
+		tpm_buf_append_u32(&buf, 0);
+	}
 
 	if (buf.flags & TPM_BUF_OVERFLOW) {
 		rc = -E2BIG;
-- 
2.31.0

