Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F04783EBA
	for <lists+linux-security-module@lfdr.de>; Tue, 22 Aug 2023 13:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbjHVL3u (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 22 Aug 2023 07:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjHVL3u (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Aug 2023 07:29:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A55CD1
        for <linux-security-module@vger.kernel.org>; Tue, 22 Aug 2023 04:29:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a3c55532fso1549985b3a.3
        for <linux-security-module@vger.kernel.org>; Tue, 22 Aug 2023 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692703788; x=1693308588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=szLSlXd58emzvGh8mLFeeSOG7azUQ2dbDCLE1VrpSi8=;
        b=MNVyX++Pi1Qqq5D2G2XGu2193X1/nJCr3llMVnAasCgdp1Y3KXWhDwOas9WrhPkgiR
         kYsBD/GDVik/F40EF2Kaqm1YlN9AcZDK7m+JxHbGyBUI3vvmNNQ8P+z27boXH5ke3726
         CrUoYxIwGiIx+9ZZpJdiZBGjIkTQulITi8+m97rj+IaFZhmgWyqb9KDF59MobvT+jwaT
         BDLQLAI3+OPuCA5uxSZVD1Zm4eMvbkViwSaEuZ5/NB04eVSIhHwhA9ITC5aTVeLm6C2+
         1YlPwIecnhWEqcuYr3qAsXecLa73yey8c46Yl5N/kKOUBA99nV/TSRUPJBiDI8prFg44
         b8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692703788; x=1693308588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szLSlXd58emzvGh8mLFeeSOG7azUQ2dbDCLE1VrpSi8=;
        b=gwwlktsqq0XoiOzcJQA2Qm6U6qYs5iFjBh+CJCMytSoBt/O73+bD/ygvntHYhPF435
         fdHxeC3zWIB7qw1KXjEUSsf6rnhUSgww3HSK2Y8pGqP1GxQCk+qJoNynXBGkLbaGaOfX
         UUnmjRFKlvtqt3y1CYpMpvgUIA4e+4j/xt82bQL46sOVZVpQiK1vIz6KpJ2SSvBnnXxP
         LRh7VEVH58sEyH0VwYS17h8L0ra4hApxoaTyV/SYS8tOCeYwhdcpdGGOX0RnYC+/CcSx
         NqvofHIKbCwO0t4BymIDjkBjVW1Pxzcg8YDvNByNofitH3Ujne+wQNoeRV5L6IqatEXk
         kRgQ==
X-Gm-Message-State: AOJu0YyvcPoEbOWlqAwACTQjvbOIiyUAXreCEMxCFgwaE4qEXoEGCSHc
        01AneI708tb035cRjwFOk02Agw==
X-Google-Smtp-Source: AGHT+IFLudj39a+9uK4O+uYImTS+YlROqQRgNV0sWtoLRFSsiWqKOuO3x1yGdd17axNIUd9KOE8JJw==
X-Received: by 2002:a05:6a00:1a88:b0:686:2b60:3348 with SMTP id e8-20020a056a001a8800b006862b603348mr7632147pfv.21.1692703787790;
        Tue, 22 Aug 2023 04:29:47 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.170])
        by smtp.gmail.com with ESMTPSA id k26-20020aa792da000000b006878cc942f1sm7657984pfa.54.2023.08.22.04.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 04:29:47 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     jarkko@kernel.org, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jens.wiklander@linaro.org, sudeep.holla@arm.com,
        achin.gupta@arm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] KEYS: trusted: tee: Refactor register SHM usage
Date:   Tue, 22 Aug 2023 16:59:33 +0530
Message-Id: <20230822112933.1550062-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The OP-TEE driver using the old SMC based ABI permits overlapping shared
buffers, but with the new FF-A based ABI each physical page may only
be registered once.

As the key and blob buffer are allocated adjancently, there is no need
for redundant register shared memory invocation. Also, it is incompatibile
with FF-A based ABI limitation. So refactor register shared memory
implementation to use only single invocation to register both key and blob
buffers.

Fixes: 4615e5a34b95 ("optee: add FF-A support")
Reported-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 security/keys/trusted-keys/trusted_tee.c | 64 ++++++++----------------
 1 file changed, 20 insertions(+), 44 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
index ac3e270ade69..aa3d477de6db 100644
--- a/security/keys/trusted-keys/trusted_tee.c
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -65,24 +65,16 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
 	int ret;
 	struct tee_ioctl_invoke_arg inv_arg;
 	struct tee_param param[4];
-	struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
+	struct tee_shm *reg_shm = NULL;
 
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
 
-	reg_shm_in = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
-						 p->key_len);
-	if (IS_ERR(reg_shm_in)) {
-		dev_err(pvt_data.dev, "key shm register failed\n");
-		return PTR_ERR(reg_shm_in);
-	}
-
-	reg_shm_out = tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
-						  sizeof(p->blob));
-	if (IS_ERR(reg_shm_out)) {
-		dev_err(pvt_data.dev, "blob shm register failed\n");
-		ret = PTR_ERR(reg_shm_out);
-		goto out;
+	reg_shm = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
+					      sizeof(p->key) + sizeof(p->blob));
+	if (IS_ERR(reg_shm)) {
+		dev_err(pvt_data.dev, "shm register failed\n");
+		return PTR_ERR(reg_shm);
 	}
 
 	inv_arg.func = TA_CMD_SEAL;
@@ -90,13 +82,13 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
 	inv_arg.num_params = 4;
 
 	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
-	param[0].u.memref.shm = reg_shm_in;
+	param[0].u.memref.shm = reg_shm;
 	param[0].u.memref.size = p->key_len;
 	param[0].u.memref.shm_offs = 0;
 	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
-	param[1].u.memref.shm = reg_shm_out;
+	param[1].u.memref.shm = reg_shm;
 	param[1].u.memref.size = sizeof(p->blob);
-	param[1].u.memref.shm_offs = 0;
+	param[1].u.memref.shm_offs = sizeof(p->key);
 
 	ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
 	if ((ret < 0) || (inv_arg.ret != 0)) {
@@ -107,11 +99,7 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
 		p->blob_len = param[1].u.memref.size;
 	}
 
-out:
-	if (reg_shm_out)
-		tee_shm_free(reg_shm_out);
-	if (reg_shm_in)
-		tee_shm_free(reg_shm_in);
+	tee_shm_free(reg_shm);
 
 	return ret;
 }
@@ -124,24 +112,16 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
 	int ret;
 	struct tee_ioctl_invoke_arg inv_arg;
 	struct tee_param param[4];
-	struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
+	struct tee_shm *reg_shm = NULL;
 
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
 
-	reg_shm_in = tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
-						 p->blob_len);
-	if (IS_ERR(reg_shm_in)) {
-		dev_err(pvt_data.dev, "blob shm register failed\n");
-		return PTR_ERR(reg_shm_in);
-	}
-
-	reg_shm_out = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
-						  sizeof(p->key));
-	if (IS_ERR(reg_shm_out)) {
-		dev_err(pvt_data.dev, "key shm register failed\n");
-		ret = PTR_ERR(reg_shm_out);
-		goto out;
+	reg_shm = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
+					      sizeof(p->key) + sizeof(p->blob));
+	if (IS_ERR(reg_shm)) {
+		dev_err(pvt_data.dev, "shm register failed\n");
+		return PTR_ERR(reg_shm);
 	}
 
 	inv_arg.func = TA_CMD_UNSEAL;
@@ -149,11 +129,11 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
 	inv_arg.num_params = 4;
 
 	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
-	param[0].u.memref.shm = reg_shm_in;
+	param[0].u.memref.shm = reg_shm;
 	param[0].u.memref.size = p->blob_len;
-	param[0].u.memref.shm_offs = 0;
+	param[0].u.memref.shm_offs = sizeof(p->key);
 	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
-	param[1].u.memref.shm = reg_shm_out;
+	param[1].u.memref.shm = reg_shm;
 	param[1].u.memref.size = sizeof(p->key);
 	param[1].u.memref.shm_offs = 0;
 
@@ -166,11 +146,7 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
 		p->key_len = param[1].u.memref.size;
 	}
 
-out:
-	if (reg_shm_out)
-		tee_shm_free(reg_shm_out);
-	if (reg_shm_in)
-		tee_shm_free(reg_shm_in);
+	tee_shm_free(reg_shm);
 
 	return ret;
 }
-- 
2.34.1

