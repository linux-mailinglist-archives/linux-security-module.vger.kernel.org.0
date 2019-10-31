Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21248EB1D3
	for <lists+linux-security-module@lfdr.de>; Thu, 31 Oct 2019 15:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfJaN7t (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 31 Oct 2019 09:59:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42745 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfJaN7t (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Oct 2019 09:59:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id j12so793015plt.9
        for <linux-security-module@vger.kernel.org>; Thu, 31 Oct 2019 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rBi9pDvmSRW/gfGz1S5LaiY/M3/1mDENiO/ALWeCgpk=;
        b=vQtn5epM7BmXndczOajGVGAnDDTih0deQtjDHqOZaIno2sYSm5HgUpe9M/7tqsey17
         JcgSTwFY/6xWrV+8iWqWzgWyz0OJ1KQ8VkRfHUX2V9qiUlAp1qHQCPlRPO3VZjqPglme
         iDFSD+n12Tl45aTDsljHPGU1HSJZQH0J8DDYa7iVWrhovtRN1+WcIknfWRrt5npqTisz
         qjYz+EqFAjDFNwFzeb2uxMlGTvMUNBpgN/uHLEcIhsUhQ3P0jCVsW6GLSldnblMq82fu
         ltdsXfA3qM4hFrffaFAyC70OkJ8YQVOci0NA28T1yGIBut65i64DP9fivni/267D/coO
         +C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rBi9pDvmSRW/gfGz1S5LaiY/M3/1mDENiO/ALWeCgpk=;
        b=EasAic+dr8iKTI7GxANc3uA/dPWBUonqiCmyDyjdxC3wauE+rrlzNlLrHmft9wacIN
         2TT2p+6HkP6UB71pAwGRa1ktBjrX23I6mYbUMaFf+/676YeBJNeeaafJApXo1uX7T0PE
         BreJpVvttFLXAgsID3zWXo3UcWG8e/qDW25kehesjPYOjlQyfnr0jLSCude9JN+UObQw
         Edkvl79Al2buDednEEvMZwbuqoF1GZ343qhwUqrlnH6wx1mTNLcawx0RkOWlm76uFJx7
         cFvIKAm2eQTlk1cqZXTQjpPsGJw/aLcrr6piR9T8A4vvLfBFZ/j2bYhVHtBWAm6wyY4a
         zATg==
X-Gm-Message-State: APjAAAV0EMM7Bx0xA0hn29HXxfXdMgGUTW05yLbtGdHbV3g5al+qTGPQ
        wMpA2zZJprY664yfhGDi7jXExg==
X-Google-Smtp-Source: APXvYqxvxuXZl/u6hfe9tV8jGqosv3YQ51/spMygFoU8LspT81JCa6iermf94WbaR84nA4XCB+w3XA==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr6386152ply.142.1572530388055;
        Thu, 31 Oct 2019 06:59:48 -0700 (PDT)
Received: from localhost.localdomain ([117.252.69.143])
        by smtp.gmail.com with ESMTPSA id i16sm3522441pfa.184.2019.10.31.06.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 06:59:47 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, jarkko.sakkinen@linux.intel.com,
        dhowells@redhat.com
Cc:     corbet@lwn.net, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        stuart.yoder@arm.com, janne.karhunen@gmail.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v3 2/7] tee: enable support to register kernel memory
Date:   Thu, 31 Oct 2019 19:28:38 +0530
Message-Id: <1572530323-14802-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Enable support to register kernel memory reference with TEE. This change
will allow TEE bus drivers to register memory references.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_shm.c   | 26 ++++++++++++++++++++++++--
 include/linux/tee_drv.h |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 09ddcd0..1ec1577 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
+#include <linux/uio.h>
 #include "tee_private.h"
 
 static void tee_shm_release(struct tee_shm *shm)
@@ -224,13 +225,14 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 {
 	struct tee_device *teedev = ctx->teedev;
 	const u32 req_flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
+	const u32 req_ker_flags = TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED;
 	struct tee_shm *shm;
 	void *ret;
 	int rc;
 	int num_pages;
 	unsigned long start;
 
-	if (flags != req_flags)
+	if (flags != req_flags && flags != req_ker_flags)
 		return ERR_PTR(-ENOTSUPP);
 
 	if (!tee_device_get(teedev))
@@ -265,7 +267,27 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 		goto err;
 	}
 
-	rc = get_user_pages_fast(start, num_pages, FOLL_WRITE, shm->pages);
+	if (flags & TEE_SHM_USER_MAPPED) {
+		rc = get_user_pages_fast(start, num_pages, FOLL_WRITE,
+					 shm->pages);
+	} else {
+		struct kvec *kiov;
+		int i;
+
+		kiov = kcalloc(num_pages, sizeof(*kiov), GFP_KERNEL);
+		if (!kiov) {
+			ret = ERR_PTR(-ENOMEM);
+			goto err;
+		}
+
+		for (i = 0; i < num_pages; i++) {
+			kiov[i].iov_base = (void *)(start + i * PAGE_SIZE);
+			kiov[i].iov_len = PAGE_SIZE;
+		}
+
+		rc = get_kernel_pages(kiov, num_pages, 0, shm->pages);
+		kfree(kiov);
+	}
 	if (rc > 0)
 		shm->num_pages = rc;
 	if (rc != num_pages) {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 7a03f68..dedf8fa 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -26,6 +26,7 @@
 #define TEE_SHM_REGISTER	BIT(3)  /* Memory registered in secure world */
 #define TEE_SHM_USER_MAPPED	BIT(4)  /* Memory mapped in user space */
 #define TEE_SHM_POOL		BIT(5)  /* Memory allocated from pool */
+#define TEE_SHM_KERNEL_MAPPED	BIT(6)  /* Memory mapped in kernel space */
 
 struct device;
 struct tee_device;
-- 
2.7.4

