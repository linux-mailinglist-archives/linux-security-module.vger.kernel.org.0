Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 879D843C21
	for <lists+linux-security-module@lfdr.de>; Thu, 13 Jun 2019 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfFMPeN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 13 Jun 2019 11:34:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38446 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbfFMKcj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Jun 2019 06:32:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so11570266pfa.5
        for <linux-security-module@vger.kernel.org>; Thu, 13 Jun 2019 03:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BG6KAi08hN8hMpB1R8APRtbarxqkieDJBwiiKnKxNvA=;
        b=qXrt3EVTApU5PvFn4bX//ulUNLUoEPsUKJqd/tEwgQrVBEW7kK6cIqJbHvlbz0ZwZw
         yXkdyYL78AAok2TZ4dUIK02ownxUUArBRRhlZFyofgOaJ5Ab0Xqmfb61n4o8y6gNLDFA
         9uq1ElY6ote0C9kIBMHRPLdLqbL7XZUgXPfzQaKaRLdAe00jHCagKg7cvHL/ECbtjyr6
         O5B0MYJenVXtiZPFm2DIsWKMKQpoYDyi9ooepPfnJACg1HGlqLmyY9jYOmIbj1SFpKWo
         dR9tq4Slzc5DwWnZCRZ6ifEeYJDQNLKZ6Ip3CeXwhTQgjdCNZQuDE2Nn0S6CbrO9y+l0
         tWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BG6KAi08hN8hMpB1R8APRtbarxqkieDJBwiiKnKxNvA=;
        b=FgXFhuQ4ffG9XcDuLspyP/ivrIvXE3RAU4375yZYWoPdv6uVRaDj81jZTljYQzIu5V
         DyD+JUyRwQtgtUBDX0J/MnLcrESzsmma/YYrdTllBtJIqFti27q6WdhFar7zg+C0RSYJ
         WMb7AKZITxAEoL9pZyBJJ0nsTC9bCw4g0Rm1/FAY4WYf9Gn2lB+9ywr8Vi8SCsL5CS60
         Y+r5WdeDUA8tAXU+JHgfqX1cDFntwRQu7b+exPsm/QIj0JD0hAZfknkLfbRGz83db+ZB
         yU7P4RAIdZXaZ2M/gpYUJDiuKuELBYdc2HAfzIYn67FcOAW4SmT8QAphEQuIlHj9OweU
         QiWQ==
X-Gm-Message-State: APjAAAX/AyHHjm0uoFlJX5P29biOpQI1lpqA4d4iQHm/VPgwZtFQPHur
        NhlHaoShQokQ8ZTIBcuWU2wPgw==
X-Google-Smtp-Source: APXvYqwugJNID3a+Q06ltN9H4nYz1MsjaA/m5NgmF0QwxbLeIBkdJqh8Wkw1R9zzI/mvvBxALIBd2g==
X-Received: by 2002:a62:ee17:: with SMTP id e23mr94599955pfi.130.1560421958641;
        Thu, 13 Jun 2019 03:32:38 -0700 (PDT)
Received: from localhost.localdomain ([117.196.234.139])
        by smtp.gmail.com with ESMTPSA id a12sm2265078pgq.0.2019.06.13.03.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 03:32:37 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 6/7] doc: keys: Document usage of TEE based Trusted Keys
Date:   Thu, 13 Jun 2019 16:00:32 +0530
Message-Id: <1560421833-27414-7-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Provide documentation for usage of TEE based Trusted Keys via existing
user-space "keyctl" utility. Also, document various use-cases.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/security/keys/tee-trusted.rst | 93 +++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/security/keys/tee-trusted.rst

diff --git a/Documentation/security/keys/tee-trusted.rst b/Documentation/security/keys/tee-trusted.rst
new file mode 100644
index 0000000..ef03745
--- /dev/null
+++ b/Documentation/security/keys/tee-trusted.rst
@@ -0,0 +1,93 @@
+======================
+TEE based Trusted Keys
+======================
+
+TEE based Trusted Keys provides an alternative approach for providing Trusted
+Keys in case TPM chip isn't present.
+
+Trusted Keys use a TEE service/device both to generate and to seal the keys.
+Keys are sealed under a hardware unique key in the TEE, and only unsealed by
+the TEE.
+
+For more information about TEE, refer to ``Documentation/tee.txt``.
+
+Usage::
+
+    keyctl add trusted name "new keylen" ring
+    keyctl add trusted name "load hex_blob" ring
+    keyctl print keyid
+
+"keyctl print" returns an ascii hex copy of the sealed key, which is in format
+specific to TEE device implementation.  The key length for new keys are always
+in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
+
+Examples of trusted key and its usage as 'master' key for encrypted key usage:
+
+More details about encrypted keys can be found here:
+``Documentation/security/keys/trusted-encrypted.rst``
+
+Create and save a trusted key named "kmk" of length 32 bytes::
+
+    $ keyctl add trusted kmk "new 32" @u
+    754414669
+
+    $ keyctl show
+    Session Keyring
+     827385718 --alswrv      0 65534  keyring: _uid_ses.0
+     274124851 --alswrv      0 65534   \_ keyring: _uid.0
+     754414669 --als-rv      0     0       \_ trusted: kmk
+
+    $ keyctl print 754414669
+    15676790697861b422175596ae001c2f505cea2c6f3ebbc5fb08eeb1f343a07e
+
+    $ keyctl pipe 754414669 > kmk.blob
+
+Load a trusted key from the saved blob::
+
+    $ keyctl add trusted kmk "load `cat kmk.blob`" @u
+    491638700
+
+    $ keyctl print 491638700
+    15676790697861b422175596ae001c2f505cea2c6f3ebbc5fb08eeb1f343a07e
+
+The initial consumer of trusted keys is EVM, which at boot time needs a high
+quality symmetric key for HMAC protection of file metadata.  The use of a
+TEE based trusted key provides security that the EVM key has not been
+compromised by a user level problem and tied to particular hardware.
+
+Create and save an encrypted key "evm" using the above trusted key "kmk":
+
+option 1: omitting 'format'::
+
+    $ keyctl add encrypted evm "new trusted:kmk 32" @u
+    608915065
+
+option 2: explicitly defining 'format' as 'default'::
+
+    $ keyctl add encrypted evm "new default trusted:kmk 32" @u
+    608915065
+
+    $ keyctl print 608915065
+    default trusted:kmk 32 f380ac588a925f488d5be007cf23e4c900b8b652ab62241c8
+    ed54906189b6659d139d619d4b51752a2645537b11fd44673f13154a65b3f595d5fb2131
+    2fe45529ea0407c644ea4026f2a1a75661f2c9b66
+
+    $ keyctl pipe 608915065 > evm.blob
+
+Load an encrypted key "evm" from saved blob::
+
+    $ keyctl add encrypted evm "load `cat evm.blob`" @u
+    831684262
+
+    $ keyctl print 831684262
+    default trusted:kmk 32 f380ac588a925f488d5be007cf23e4c900b8b652ab62241c8
+    ed54906189b6659d139d619d4b51752a2645537b11fd44673f13154a65b3f595d5fb2131
+    2fe45529ea0407c644ea4026f2a1a75661f2c9b66
+
+Other uses for trusted and encrypted keys, such as for disk and file encryption
+are anticipated.  In particular the 'ecryptfs' encrypted keys format can be used
+to mount an eCryptfs filesystem.  More details about the usage can be found in
+the file ``Documentation/security/keys/ecryptfs.rst``.
+
+Another format 'enc32' can be used to support encrypted keys with payload size
+of 32 bytes.
-- 
2.7.4

