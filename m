Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837E376E861
	for <lists+linux-security-module@lfdr.de>; Thu,  3 Aug 2023 14:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjHCMfq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 3 Aug 2023 08:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjHCMfp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Aug 2023 08:35:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF673C1F
        for <linux-security-module@vger.kernel.org>; Thu,  3 Aug 2023 05:35:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe55d70973so561445e87.0
        for <linux-security-module@vger.kernel.org>; Thu, 03 Aug 2023 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691066126; x=1691670926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z5pIJWbGUU+IcBqHu09pjkPy7MNVWuLFQRm8HIlUks0=;
        b=gwESsG+WDXDy3C2tsUjbJ1FYYB3SyMjvoJaMALp3YjaZH6mzwR+5HwCxUT9kjr3Lfx
         wazMwpG0cKmlZFEVO33Jg8t0oopFbPtYXdFCpB7UhfMlBgFPRcZUsWg8CwwxG64fpj68
         kGFRPkxwA9WnvdysCECHGIkYBnn3GHZ/PdJk5FHitlyrVhTPiifKJNmNLrS6crB9DRS6
         dugRnqjNCyuMPEzDB6M9535X5HDTQSXkygZ6kpqPGOcwdovmtwMG9JIGZHgSCXjEL/Op
         V8WpqwIHiSMoxMleRDICKC0NUK45JUO0e7Tp64nXwtQ+CLg3kAQjN0yMOYJ0iRwHzX2/
         VIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691066126; x=1691670926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5pIJWbGUU+IcBqHu09pjkPy7MNVWuLFQRm8HIlUks0=;
        b=j17ouXYKG7UwI8d70EiFZvKHUb7uMZv70+9Nb3mhqTVvCMHRZTioj4RnQx+R+sgrHK
         qwl2jHMws90U9vRr5F/lvPIgJxzj7Am3QPlo9BmDiJmnFzX3RqagjQZ8j7F3secnLjD+
         mDT3iIDdgFySo+LC6uATsruh7IjvSv0XpRQTmkdg+k/RZISA5zLkY5swSjXW67GZi5ca
         t+X6vFE8HdAykwt662YfltyBGVJMiuTIIadLH0FQkHTNroP08YuzJFJ39irwbrsfynU9
         lBvO/KEp7iCRwcECWr79k+fxAdRj2pIUOo71LnW7Evl14QciuB4IdOCb/zOEoiFifyQq
         ELJQ==
X-Gm-Message-State: ABy/qLbaCbYW1PV3Ec00IhyApDUJyhTxN2JXkX3Io+xRnNEbBoBLgJnH
        N8V9DK+IAU3TZ+nPFtKOuFgTQ07hOLr2QgFfMK8=
X-Google-Smtp-Source: APBJJlHLHB55LHuoOqYiuGk548/vVQ+RlwPr0wSIpPDIRqwm7EI73ZDM2CoYFB8/oR+IUUpGxDAyJg==
X-Received: by 2002:a19:654e:0:b0:4f8:6831:fd70 with SMTP id c14-20020a19654e000000b004f86831fd70mr2961739lfj.3.1691066125932;
        Thu, 03 Aug 2023 05:35:25 -0700 (PDT)
Received: from rayden.urgonet (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id q18-20020ac25fd2000000b004fdc0023a47sm3304592lfg.238.2023.08.03.05.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 05:35:25 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] KEYS: trusted: tee: use tee_shm_register_alloc_buf()
Date:   Thu,  3 Aug 2023 14:35:15 +0200
Message-Id: <20230803123515.4018838-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Prior to this patch was trusted_tee_seal() and trusted_tee_get_random()
relying on tee_shm_register_kernel_buf() to share memory with the TEE.
Depending on the memory allocation pattern the pages holding the
registered buffers overlap with other buffers also shared with the TEE.

The OP-TEE driver using the old SMC based ABI permits overlapping shared
buffers, but with the new FF-A based ABI each physical page may only
be registered once.

Fix this problem by allocating a temporary page aligned shared memory
buffer to be used as a bounce buffer for the needed data buffers.

Since TEE trusted keys doesn't depend on registered shared memory
support any longer remove that explicit dependency when opening a
context to the TEE.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 security/keys/trusted-keys/trusted_tee.c | 68 +++++++++++++-----------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
index ac3e270ade69..3085343c489a 100644
--- a/security/keys/trusted-keys/trusted_tee.c
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/key-type.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -65,38 +66,37 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
 	int ret;
 	struct tee_ioctl_invoke_arg inv_arg;
 	struct tee_param param[4];
-	struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
+	struct tee_shm *shm;
+	uint8_t *buf;
 
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
 
-	reg_shm_in = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
-						 p->key_len);
-	if (IS_ERR(reg_shm_in)) {
-		dev_err(pvt_data.dev, "key shm register failed\n");
-		return PTR_ERR(reg_shm_in);
+	shm = tee_shm_alloc_kernel_buf(pvt_data.ctx,
+				       p->key_len + sizeof(p->blob));
+	if (IS_ERR(shm)) {
+		dev_err(pvt_data.dev, "key shm alloc failed\n");
+		return PTR_ERR(shm);
 	}
-
-	reg_shm_out = tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
-						  sizeof(p->blob));
-	if (IS_ERR(reg_shm_out)) {
-		dev_err(pvt_data.dev, "blob shm register failed\n");
-		ret = PTR_ERR(reg_shm_out);
+	buf = tee_shm_get_va(shm, 0);
+	if (IS_ERR(buf)) {
+		ret = PTR_ERR(buf);
 		goto out;
 	}
+	memcpy(buf, p->key, p->key_len);
 
 	inv_arg.func = TA_CMD_SEAL;
 	inv_arg.session = pvt_data.session_id;
 	inv_arg.num_params = 4;
 
 	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
-	param[0].u.memref.shm = reg_shm_in;
+	param[0].u.memref.shm = shm;
 	param[0].u.memref.size = p->key_len;
 	param[0].u.memref.shm_offs = 0;
 	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
-	param[1].u.memref.shm = reg_shm_out;
+	param[1].u.memref.shm = shm;
 	param[1].u.memref.size = sizeof(p->blob);
-	param[1].u.memref.shm_offs = 0;
+	param[1].u.memref.shm_offs = p->key_len;
 
 	ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
 	if ((ret < 0) || (inv_arg.ret != 0)) {
@@ -104,14 +104,13 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
 			inv_arg.ret);
 		ret = -EFAULT;
 	} else {
+		memcpy(p->blob, buf + p->key_len,
+		       min(param[1].u.memref.size, sizeof(p->blob)));
 		p->blob_len = param[1].u.memref.size;
 	}
 
 out:
-	if (reg_shm_out)
-		tee_shm_free(reg_shm_out);
-	if (reg_shm_in)
-		tee_shm_free(reg_shm_in);
+	tee_shm_free(shm);
 
 	return ret;
 }
@@ -166,11 +165,9 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
 		p->key_len = param[1].u.memref.size;
 	}
 
+	tee_shm_free(reg_shm_out);
 out:
-	if (reg_shm_out)
-		tee_shm_free(reg_shm_out);
-	if (reg_shm_in)
-		tee_shm_free(reg_shm_in);
+	tee_shm_free(reg_shm_in);
 
 	return ret;
 }
@@ -183,15 +180,21 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
 	int ret;
 	struct tee_ioctl_invoke_arg inv_arg;
 	struct tee_param param[4];
-	struct tee_shm *reg_shm = NULL;
+	struct tee_shm *shm;
+	void *buf;
 
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
 
-	reg_shm = tee_shm_register_kernel_buf(pvt_data.ctx, key, key_len);
-	if (IS_ERR(reg_shm)) {
-		dev_err(pvt_data.dev, "key shm register failed\n");
-		return PTR_ERR(reg_shm);
+	shm = tee_shm_alloc_kernel_buf(pvt_data.ctx, key_len);
+	if (IS_ERR(shm)) {
+		dev_err(pvt_data.dev, "key shm alloc failed\n");
+		return PTR_ERR(shm);
+	}
+	buf = tee_shm_get_va(shm, 0);
+	if (IS_ERR(buf)) {
+		ret = PTR_ERR(buf);
+		goto out;
 	}
 
 	inv_arg.func = TA_CMD_GET_RANDOM;
@@ -199,7 +202,7 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
 	inv_arg.num_params = 4;
 
 	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
-	param[0].u.memref.shm = reg_shm;
+	param[0].u.memref.shm = shm;
 	param[0].u.memref.size = key_len;
 	param[0].u.memref.shm_offs = 0;
 
@@ -209,18 +212,19 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
 			inv_arg.ret);
 		ret = -EFAULT;
 	} else {
+		memcpy(key, buf, min(param[0].u.memref.size, key_len));
 		ret = param[0].u.memref.size;
 	}
 
-	tee_shm_free(reg_shm);
+out:
+	tee_shm_free(shm);
 
 	return ret;
 }
 
 static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 {
-	if (ver->impl_id == TEE_IMPL_ID_OPTEE &&
-	    ver->gen_caps & TEE_GEN_CAP_REG_MEM)
+	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
 		return 1;
 	else
 		return 0;
-- 
2.34.1

