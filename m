Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EE1524656
	for <lists+linux-security-module@lfdr.de>; Thu, 12 May 2022 09:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350641AbiELHBq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 12 May 2022 03:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350646AbiELHBi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 May 2022 03:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCFF243EE4
        for <linux-security-module@vger.kernel.org>; Thu, 12 May 2022 00:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652338894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgYiACZD6/G9rcKhEjYBMoQ95BxFfvkmBPg17ZEoIno=;
        b=Dyma7ZFhUlsCn/RDGsoGvY8Dc4PE8XZAvEsWrXTSTNAar/pL068NHIOPNy3kdgeuqu2KHK
        vBzX8Du4c6FgRq9ILeOuP2fYifvElFdPFPbQcEjU14ZDL/nmK+RO0t3wqeOtI+iogZfrGr
        l49BIZphwp0TvEGb6WxFJdAJq4XNBus=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-gSAzvt77OYyjusPMoMlMRQ-1; Thu, 12 May 2022 03:01:33 -0400
X-MC-Unique: gSAzvt77OYyjusPMoMlMRQ-1
Received: by mail-pl1-f197.google.com with SMTP id y14-20020a1709027c8e00b0015906c1ea31so2285818pll.20
        for <linux-security-module@vger.kernel.org>; Thu, 12 May 2022 00:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vgYiACZD6/G9rcKhEjYBMoQ95BxFfvkmBPg17ZEoIno=;
        b=kHt4Pgb57AryjedQqkn+NLZx3EhZXWZl8OmIm4+bGwSW7TS7Vgdwgr5LEXc7vBy0i5
         7FMAwOj+g3SCTBP0eJecrm78evSNHOVctw8x5hUxX2i/xjrIS8R5jSdSiii/Rg85vm13
         kksdYlST/njQa5WwAOLjkTeR+4rpBAjbiodCzYaZ8uQqk9P/swZ8n7Jv7gmHQfuY96UC
         jQCowdpl3LKyneBnGBGHvSFQDijvKm7KrmEbFXcQjesa1kUXn9+QEkeEC16q/2Gwqe6D
         5EjBVSq7Rk90cETGUIjKhzr7Ts4Y1fMj7GlB0QnqjD2mzyivKuEdjUEcqoMGRXwNYDrN
         nNYQ==
X-Gm-Message-State: AOAM5305S6xfJsUqIhySfDJ0K3x9azo393L9hrEdqb7N73IFkEZ0g1fr
        0Akt/Axx08JqS+/vReQswSthfgn2hxWnjD3i8I7q4Th3q+DTR55FjrW+1Qrp5nGtp2r6ysSx39w
        N9BRvLiLSzHHI8I67qcyYnfX0ozK426aZbLCb
X-Received: by 2002:a63:fd51:0:b0:3c1:977e:1fed with SMTP id m17-20020a63fd51000000b003c1977e1fedmr23315478pgj.246.1652338892409;
        Thu, 12 May 2022 00:01:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9y74pXlU9khxFBVuBbzYeKkQpFrpiEgQKuDz1TjTce3hnPBaW0wZu6AVHdmG3zi3cJQiPWg==
X-Received: by 2002:a63:fd51:0:b0:3c1:977e:1fed with SMTP id m17-20020a63fd51000000b003c1977e1fedmr23315454pgj.246.1652338892150;
        Thu, 12 May 2022 00:01:32 -0700 (PDT)
Received: from localhost ([240e:3a1:2e9:efa0:e73c:e550:ac9e:58fd])
        by smtp.gmail.com with ESMTPSA id y24-20020a63de58000000b003c14af50643sm1035149pgi.91.2022.05.12.00.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:01:31 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v8 2/4] kexec, KEYS: make the code in bzImage64_verify_sig generic
Date:   Thu, 12 May 2022 15:01:21 +0800
Message-Id: <20220512070123.29486-3-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512070123.29486-1-coxu@redhat.com>
References: <20220512070123.29486-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

commit 278311e417be ("kexec, KEYS: Make use of platform keyring for
signature verify") adds platform keyring support on x86 kexec but not
arm64.

The code in bzImage64_verify_sig makes use of system keyrings including
.buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to
verify signed kernel image as PE file. Make it generic so both x86_64
and arm64 can use it.

Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Reviewed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 20 +-------------------
 include/linux/kexec.h             |  7 +++++++
 kernel/kexec_file.c               | 17 +++++++++++++++++
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..f299b48f9c9f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/efi.h>
-#include <linux/verification.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -528,28 +527,11 @@ static int bzImage64_cleanup(void *loader_data)
 	return 0;
 }
 
-#ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
-static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
-{
-	int ret;
-
-	ret = verify_pefile_signature(kernel, kernel_len,
-				      VERIFY_USE_SECONDARY_KEYRING,
-				      VERIFYING_KEXEC_PE_SIGNATURE);
-	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
-		ret = verify_pefile_signature(kernel, kernel_len,
-					      VERIFY_USE_PLATFORM_KEYRING,
-					      VERIFYING_KEXEC_PE_SIGNATURE);
-	}
-	return ret;
-}
-#endif
-
 const struct kexec_file_ops kexec_bzImage64_ops = {
 	.probe = bzImage64_probe,
 	.load = bzImage64_load,
 	.cleanup = bzImage64_cleanup,
 #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
-	.verify_sig = bzImage64_verify_sig,
+	.verify_sig = kexec_kernel_verify_pe_sig,
 #endif
 };
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 413235c6c797..da83abfc628b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 
 #include <uapi/linux/kexec.h>
+#include <linux/verification.h>
 
 /* Location of a reserved region to hold the crash kernel.
  */
@@ -202,6 +203,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
 				 const Elf_Shdr *relsec,
 				 const Elf_Shdr *symtab);
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
+#ifdef CONFIG_KEXEC_SIG
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
+int kexec_kernel_verify_pe_sig(const char *kernel,
+				    unsigned long kernel_len);
+#endif
+#endif
 int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3720435807eb..754885b96aab 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -165,6 +165,23 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_KEXEC_SIG
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
+int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
+{
+	int ret;
+
+	ret = verify_pefile_signature(kernel, kernel_len,
+				      VERIFY_USE_SECONDARY_KEYRING,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
+		ret = verify_pefile_signature(kernel, kernel_len,
+					      VERIFY_USE_PLATFORM_KEYRING,
+					      VERIFYING_KEXEC_PE_SIGNATURE);
+	}
+	return ret;
+}
+#endif
+
 static int kexec_image_verify_sig(struct kimage *image, void *buf,
 		unsigned long buf_len)
 {
-- 
2.35.3

