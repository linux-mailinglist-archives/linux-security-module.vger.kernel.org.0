Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C442C43C3A
	for <lists+linux-security-module@lfdr.de>; Thu, 13 Jun 2019 17:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfFMPeq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 13 Jun 2019 11:34:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34591 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbfFMKcB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Jun 2019 06:32:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id c85so11584566pfc.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Jun 2019 03:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TYugXC8ytxOCfgDh3mg7Chcw/fQ6qx25pA1xGAB2wEo=;
        b=om1b7q3qqqL3hVwwom76w942uIQ0/B4EPiCLfCuWVjwAg29AoGLw6WXFFUHqXBibE+
         0j0OKdm3jdlxA1D/O0QRQOpLhNv5Ogrd9JNks1szszwbDlTE8sSL+SuHA47qdtkMVcBK
         fh0ruIWuUdE46y+O1g9vrHQwJ2XRu4UtkLoRcxKKBfjvZ+D+584zH7JEa39p/I12YLsd
         c4SCaI0zDdmJTRvb82Hyib1W7COcIB0wpLY7Sh0Zb0Rch/NfitptGgRpcVvVcY2jHp4N
         Dv9pfi9mVEfWv5k4TDh02gX+UvZQ5e9qjmJ5q90DuaaSymHzayeEBweOhsV/SAvK222W
         fDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TYugXC8ytxOCfgDh3mg7Chcw/fQ6qx25pA1xGAB2wEo=;
        b=MFpLm8XL1gJn3sbAZCtAjv33PRHyWE0wU4KwHrhqFjFArSA+scuYCpWTcnHye5Rt7R
         t4YBudAig40yns1663DurM2cx9nzuY3Q23hBKwGHsehlbMssxnP/dDhB5p7vMUn9K/9O
         5GK9S/kQKvbQPdjlK0Mibak7Dv+88AUt9DaEsei/eakNDoPSxd5uXcQOzawG91BZE8S+
         ofHomLc/HwxTZ+/yO4ZGeRs6Y3rnXvZm+FjB+tg843OiMOTZzeKBEdtIsUpbxOyojpdw
         Vb03L+oLcWVe4JGxyL2Cp10J90ZmungzzOiot71wx8Q2c2UWrETEneMOwQ/xfFxtFUO9
         VbJg==
X-Gm-Message-State: APjAAAVrFThlYFZMxaTxsU0F6NdLsxCUpV0MGMQd2OCFWnEhyy9zFq5N
        PAlqF6Vv3P3n0f9K4sL7Gfbwyg==
X-Google-Smtp-Source: APXvYqxmU/pTtNFnVKD+LmruR3Lv1HQKoTORB4xR6IcJsmcwYl4ehUJoxUdXSONGKCUx4lvt1igbXQ==
X-Received: by 2002:a62:1c92:: with SMTP id c140mr92232910pfc.258.1560421920566;
        Thu, 13 Jun 2019 03:32:00 -0700 (PDT)
Received: from localhost.localdomain ([117.196.234.139])
        by smtp.gmail.com with ESMTPSA id a12sm2265078pgq.0.2019.06.13.03.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 03:31:59 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 3/7] tee: add private login method for kernel clients
Date:   Thu, 13 Jun 2019 16:00:29 +0530
Message-Id: <1560421833-27414-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

There are use-cases where user-space shouldn't be allowed to communicate
directly with a TEE device which is dedicated to provide a specific
service for a kernel client. So add a private login method for kernel
clients and disallow user-space to open-session using this login method.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_core.c   | 6 ++++++
 include/uapi/linux/tee.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 0f16d9f..4581bd1 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -334,6 +334,12 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
 			goto out;
 	}
 
+	if (arg.clnt_login == TEE_IOCTL_LOGIN_REE_KERNEL) {
+		pr_err("login method not allowed for user-space client\n");
+		rc = -EPERM;
+		goto out;
+	}
+
 	rc = ctx->teedev->desc->ops->open_session(ctx, &arg, params);
 	if (rc)
 		goto out;
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 4b9eb06..f33c69c 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -172,6 +172,8 @@ struct tee_ioctl_buf_data {
 #define TEE_IOCTL_LOGIN_APPLICATION		4
 #define TEE_IOCTL_LOGIN_USER_APPLICATION	5
 #define TEE_IOCTL_LOGIN_GROUP_APPLICATION	6
+/* Private login method for REE kernel clients */
+#define TEE_IOCTL_LOGIN_REE_KERNEL		0x80000000
 
 /**
  * struct tee_ioctl_param - parameter
-- 
2.7.4

