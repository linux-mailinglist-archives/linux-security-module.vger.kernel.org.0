Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C411B574F76
	for <lists+linux-security-module@lfdr.de>; Thu, 14 Jul 2022 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbiGNNl3 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 14 Jul 2022 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbiGNNlW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Jul 2022 09:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BC2B61134
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jul 2022 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657806079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=O1AWLKOn0yn4kfIvDEt3fEEoE/qVkSxP9IhgWZ4mSjASVhkhauaSudFhxqB6mvGmcd8hp9
        tfAxGwvTj8eJgCAFJFg4Tb6j8HRak0WNt0xRWgSnV7JXmFNVjI/oahZWgZotj/5hG2BTo+
        nx+4YAswYXIolZYiunuO1ypPWCQR5Zs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-NR74tsqhOqGJ1pSZqu6JjQ-1; Thu, 14 Jul 2022 09:41:11 -0400
X-MC-Unique: NR74tsqhOqGJ1pSZqu6JjQ-1
Received: by mail-pg1-f200.google.com with SMTP id 79-20020a630252000000b004125da7d520so1266149pgc.11
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jul 2022 06:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=vhvCLXtSx1Uf+D+qUN6KKN5fK3mSk5cSY0T21DARLiSvRT41vJUf6Nb0US2VM1ITp5
         CRNmE4/PsYRSsSSHgTrZsAKzK7098WTx54pbyOOY8mjIYzBi2uPLEN06tFJ+VIa8RvIk
         PDT8aB2esW5X8AGiYh9tjAsBBAk4a4nSMpGJx2Tx/xU3/sHrAC4uYfojom8h1UrlEvdY
         QiACj2XOQAt6u2pnEnGpLCJu2lpflf29fDZfToAWsZilmflpTxqk52XHZXNpOhIJWZEs
         cAV6zC+dgDw703cMINKJ7xBPy/ldHNgIk8SfzxPKiYEkOn4G7j/pI5Uv/AItvu2m5OP4
         jW9Q==
X-Gm-Message-State: AJIora/pvKoKcCRiaPug+3D7V1O0KVmQgYHdC0jGt+rN7zX788O9ZfPp
        kgKmd3GCRyzYTylU0DIGQ05C+0YQu0iWW/Bh7n4XeYWXBshVSMLGbxecwWgAzUXjEgL8Ruy9olG
        chAI/XMA9zMiAQGUjVa6E8X3gFtJl9XO3PrzW
X-Received: by 2002:a17:90b:4b82:b0:1f0:196d:4204 with SMTP id lr2-20020a17090b4b8200b001f0196d4204mr16396528pjb.194.1657806070933;
        Thu, 14 Jul 2022 06:41:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v6W73kkND0lzdShUq0XCk7I59w6K6H/HhxbM9LJ4h4Bhv+gs6tfqbnzg5qbuZf1Ex6YUHUFA==
X-Received: by 2002:a17:90b:4b82:b0:1f0:196d:4204 with SMTP id lr2-20020a17090b4b8200b001f0196d4204mr16396483pjb.194.1657806070591;
        Thu, 14 Jul 2022 06:41:10 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h10-20020aa79f4a000000b00528d880a32fsm1663006pfr.78.2022.07.14.06.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:41:10 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, stable@vger.kernel.org,
        Philipp Rudo <prudo@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org (open list:S390),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 4/4] kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification
Date:   Thu, 14 Jul 2022 21:40:27 +0800
Message-Id: <20220714134027.394370-5-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220714134027.394370-1-coxu@redhat.com>
References: <20220714134027.394370-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Michal Suchanek <msuchanek@suse.de>

commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
adds support for KEXEC_SIG verification with keys from platform keyring
but the built-in keys and secondary keyring are not used.

Add support for the built-in keys and secondary keyring as x86 does.

Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
Cc: stable@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8f43575a4dd3..fc6d5f58debe 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -31,6 +31,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature *ms;
 	unsigned long sig_len;
+	int ret;
 
 	/* Skip signature verification when not secure IPLed. */
 	if (!ipl_secure_flag)
@@ -65,11 +66,18 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 		return -EBADMSG;
 	}
 
-	return verify_pkcs7_signature(kernel, kernel_len,
-				      kernel + kernel_len, sig_len,
-				      VERIFY_USE_PLATFORM_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
+	ret = verify_pkcs7_signature(kernel, kernel_len,
+				     kernel + kernel_len, sig_len,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_MODULE_SIGNATURE,
+				     NULL, NULL);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+		ret = verify_pkcs7_signature(kernel, kernel_len,
+					     kernel + kernel_len, sig_len,
+					     VERIFY_USE_PLATFORM_KEYRING,
+					     VERIFYING_MODULE_SIGNATURE,
+					     NULL, NULL);
+	return ret;
 }
 #endif /* CONFIG_KEXEC_SIG */
 
-- 
2.35.3

