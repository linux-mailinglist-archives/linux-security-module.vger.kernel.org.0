Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFCA5003BF
	for <lists+linux-security-module@lfdr.de>; Thu, 14 Apr 2022 03:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbiDNBqs (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 13 Apr 2022 21:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbiDNBqq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Apr 2022 21:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 124E7C00
        for <linux-security-module@vger.kernel.org>; Wed, 13 Apr 2022 18:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649900661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZWiQAF9GRIP7WU8AYwYkyBhsIYEfbcorZXD7uAiyqQ=;
        b=XxR6IuAWLorn/F9Aaj0vRvLg0BAP9gpVaHU9ob8GwFBY60xO7OAUMFrqlo7XyAd6VaYbLS
        jJYaWyggj2nwGh1HdGaiMoyQKtGITKA5Qt+wIVs7gw4MwHHjQnYFj2n+brVymYkr6EVw3i
        ZMxbvJ20vnzshRDsyrI2rbHE7opxr5w=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-xo2A-9UcOoSc0CS_xP-HRQ-1; Wed, 13 Apr 2022 21:44:20 -0400
X-MC-Unique: xo2A-9UcOoSc0CS_xP-HRQ-1
Received: by mail-pj1-f71.google.com with SMTP id q10-20020a17090a2dca00b001cb87691fbaso2051489pjm.5
        for <linux-security-module@vger.kernel.org>; Wed, 13 Apr 2022 18:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZWiQAF9GRIP7WU8AYwYkyBhsIYEfbcorZXD7uAiyqQ=;
        b=CdCTlyfJs7Tow9ANdkRW56aEtExzAYV6T2Y3JIIyqIF/8elEdCPPwa0RSUwEnbAWwi
         gC2cVxmuoUJvOzdI+QeO8zdFtMZINnFxV+NWGVzigQfaGg9kxeoJPpQzwouqf3h7fe6o
         19TcBDwMxqhCxw4gGZRlEhxRjyLr5b1TfI69ReWfYFnkd7PohXvRBvYDCH8ERRw+nplA
         wbcCABotmzcTkoIjhjviUKwN8mPoZocRW0WoPTE222sDVHEwH7ufwwGhaIKxibvaARP8
         q9GgcPtFR4loavuIlZ7v/laJp4/v1dOQqsoXEyfNQtoWlJaXBdd3AHBPtcur3cbBAR37
         G1+A==
X-Gm-Message-State: AOAM530QlV/iHYzhABXAUlPScUnCkwZ+iXKw0FfvedXczF1ObRX8TY+N
        89bTjqpDU60i/I/sZSvniDqyAQ6f8OAhPx/VYZsHeWZR3NQ3PB8ArsS7E22vpQA0uvtH4SE+Gh9
        DUr/QQsxiBJIe3fMLYlMWPt2EmclpPwy8Tbjn
X-Received: by 2002:a17:90a:dd45:b0:1bc:9466:9b64 with SMTP id u5-20020a17090add4500b001bc94669b64mr1694818pjv.23.1649900659135;
        Wed, 13 Apr 2022 18:44:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdzkDNxJ5ETNGa8+WNGA9rufymeL8qpXrk4exAuId9yogv97m9d/zBf7JK2uUxgm00wjeIBg==
X-Received: by 2002:a17:90a:dd45:b0:1bc:9466:9b64 with SMTP id u5-20020a17090add4500b001bc94669b64mr1694808pjv.23.1649900658928;
        Wed, 13 Apr 2022 18:44:18 -0700 (PDT)
Received: from localhost ([240e:3a1:31c:360:52fc:c968:cb41:efbc])
        by smtp.gmail.com with ESMTPSA id e6-20020a056a001a8600b004fac74c8382sm334069pfv.47.2022.04.13.18.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:44:18 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 3/4] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Thu, 14 Apr 2022 09:43:43 +0800
Message-Id: <20220414014344.228523-4-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414014344.228523-1-coxu@redhat.com>
References: <20220414014344.228523-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Currently, a problem faced by arm64 is if a kernel image is signed by a
MOK key, loading it via the kexec_file_load() system call would be
rejected with the error "Lockdown: kexec: kexec of unsigned images is
restricted; see man kernel_lockdown.7".

This happens because image_verify_sig uses only the primary keyring that
contains only kernel built-in keys to verify the kexec image.

This patch allows to verify arm64 kernel image signature using not only
.builtin_trusted_keys but also .platform and .secondary_trusted_keys
keyring.

Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: stable@kernel.org
Co-developed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/arm64/kernel/kexec_image.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 9ec34690e255..5ed6a585f21f 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -14,7 +14,6 @@
 #include <linux/kexec.h>
 #include <linux/pe.h>
 #include <linux/string.h>
-#include <linux/verification.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
 #include <asm/image.h>
@@ -130,18 +129,10 @@ static void *image_load(struct kimage *image,
 	return NULL;
 }
 
-#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-static int image_verify_sig(const char *kernel, unsigned long kernel_len)
-{
-	return verify_pefile_signature(kernel, kernel_len, NULL,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
-}
-#endif
-
 const struct kexec_file_ops kexec_image_ops = {
 	.probe = image_probe,
 	.load = image_load,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-	.verify_sig = image_verify_sig,
+	.verify_sig = kexec_kernel_verify_pe_sig,
 #endif
 };
-- 
2.34.1

