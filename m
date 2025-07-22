Return-Path: <linux-security-module+bounces-11144-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E1BB0CDDB
	for <lists+linux-security-module@lfdr.de>; Tue, 22 Jul 2025 01:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4ACF17C5A7
	for <lists+linux-security-module@lfdr.de>; Mon, 21 Jul 2025 23:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF024676C;
	Mon, 21 Jul 2025 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QfZi6/Ej"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549A24C068
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140259; cv=none; b=q3jx7NF6O6Y4/LhjBtzbNloQsnrdNxhfpSmsewCle4GBqAw4GGvedf0gBi4ijCl7ZdjGW7/ROp6K+X5ceUP0SF5b99XLfpCW+uSdeMoLr/YWKY12QGwUnMcJz9yhpC3ETTdnRdidgpmfEFRmzBUhvSXLhFNvq9beV63xHYIPoYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140259; c=relaxed/simple;
	bh=PPSjDo84vW3qAT1jTcLRRiTYnrjeRFQCkJwbKzoEQZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdAe7MDBVRZMPhsrNzfb5yCyN590Z163AOAe+yQjuZu/au01i+mFxywaeABY6lF89JO+jFqAkMBLXIuWUhIBt/Y8gVDgM9geuIpD9g2/14WjopapS8aFFcRLPd4fRs0Q8gV7uaLMlQRH7xSn+HolfNRRMRAeFycgdARSaT9MATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QfZi6/Ej; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab814c4f2dso94079961cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140256; x=1753745056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6Psu6lFsFSrDZpGZLN7h5VG8RxFf8nqQ7eHJGgaGXw=;
        b=QfZi6/EjGJaEML0RiBCEyr7Fks3FKC3OgZry7cDD+WiNsoSLvthUzhtZumSxj7jOBU
         sHIJdUhsEyg0fOE1IthRL+8W1fUPR23aym/7bHABioAdgs5rDjHkyHW8+SZCqKrUZm0f
         i9zRoMu/SPAhFHowD9zwEyacQ1tE/tc8Y4sP0+d2J40oUoA9d/mXWkPhLenNEVB4n7ME
         N8C03kg0iRT1RWKr8qtgrofU2RJJVAqvNjhUtnNm7eMWIrZOZg3RuJIh8sbhqaG0JY4j
         fwwt/uMDtXn5Scjtk5jeLwQ6kGbUU9EA/Vk/1vMdGqCYGEpN4ncVG8p+A99EGBmky+it
         nvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140256; x=1753745056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6Psu6lFsFSrDZpGZLN7h5VG8RxFf8nqQ7eHJGgaGXw=;
        b=UCBjCuym0gl0iqGD75sfupUsiPEV9aVKDS7jjGLzVDuM57ReNZRIhh3RXxPxAmUF3W
         TqWFMwP7VJBmkLgCeIpP3qOTIFf6JEKSylsO7mvV8q7ZUz0kkw3cVzqzazpxGSNz8OlV
         gh04DJ+KN5MGD2j0prgmZnGFwjH/plANN/D/GPxWNtfPu/j27cqWhjZiFhBPM/HgFTKB
         vLqatMK8s8OQoFXyf2QjUrk9PPvaOBcHo5SVDmyeiNlO28vqTFeP8CUSpytOpIhIkihT
         roigCSGCUblgZTKYZ7K+qngKcI8edmKyrLVkaNgbYi2itXqHyWfd+oZj49WblD53qZSM
         wivA==
X-Gm-Message-State: AOJu0Yzv4b5RN1ZZtFzKywy4lTCVlmQ7E9mbOFP9RpXayHfo/lnL1Ogi
	YmtwBidAiojdMWrNL/Unr6zwUq+B8pHaeKlrhAeHprWUMaoI3SQVi/G4zcjyB4HJs8lFAdkYZ+S
	rcxc=
X-Gm-Gg: ASbGnctz9Sw2Jz+hgbfAh6qjKpi5KBUCCmyWlcySG+hxeD9lgWvB+eXPQ0xe9O9RHQP
	Fb042Hr6gcNNxoWSguWFKIsdhSlSpZLR2j8qbE6OenIW9H/ZGftU48Zaslkm/JR7YL/lqyshG+L
	IyJxp41mKigVsT/NDdjc/PhgGlTdoxXC1ZKBv3aT8P5F+PAYyV7Lxsmcg5loRadMVhasfjFse7i
	goamQg+4OZ/CDr1d/UuZDWeHxbQMtIYT0EQXC7irOKWpDgyOpepSnnWt7JO3aEVFplvkpPOnCRJ
	hncm7u58Zet0u54s3wjCTjHYw2ze7/wcMLcfaJwsf0ZbuZqPaUPpH4tp9Ve0dSVVHJOgu9WB/bu
	VKYM3V4+VzZC4o6wrFrdyWRAjhG2vL7P7YaUIxnWAISybD8lcrnb5rA8LNnpMqXDt6Rk=
X-Google-Smtp-Source: AGHT+IH1dYfvMuHMV05ILEA9REG1/3wWF17bVWBtSZkawdhX/yZ5rbQX79S90YHmZxV8qvLUKG5dZA==
X-Received: by 2002:a05:6214:29e9:b0:6fd:75e1:16c4 with SMTP id 6a1803df08f44-704f6b9d86cmr251403276d6.20.1753140256542;
        Mon, 21 Jul 2025 16:24:16 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051ba6b02dsm43943356d6.63.2025.07.21.16.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:16 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v2 16/34] lsm: cleanup the LSM blob size code
Date: Mon, 21 Jul 2025 19:21:19 -0400
Message-ID: <20250721232142.77224-52-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4870; i=paul@paul-moore.com; h=from:subject; bh=PPSjDo84vW3qAT1jTcLRRiTYnrjeRFQCkJwbKzoEQZw=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvBdeKMunxLLSVDe0xxezfPfOH5PPziezZ/F Lkd/lsXZJGJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LwQAKCRDqIPLalzeJ czzTD/4+E2sAA8OtkQB3NWGzYAYIStDQAT/r+DjlTCl+f+yLN/8xpeVo6RwkHcH8IiwTgaOOGNL 2m894QcPrTlIXabL2CikTmwmbZ44DZ9179Jd1yD+4ONSyLH8VcIqx9kEUTApj9afNuTRMMQi9Zt ofcBhh+d9PaxhWSW9Id5OcR5Hzu+tHqRJTLKL9elO1lCjnnK1qwToEVV8Rg3UkMLdlxMTO3XoRJ F6IQWdB8Tj1l5QsD0c4J+Pl1H4l3nRDK4RpSRq13h+YV9LJrnDTpdjp/has4mXL8gH8mqbf2Hk/ blDPRlPvsFOMzRA6VFQsKBVTZfi3mBN7xyVyJms0A4RQuRtDIncq0OPTdLJXJvo9hpHszim2av6 cq1SsCN1vxaCTba7bo5DB7DTKYcd4OEae48wbgxFyaICBIxn1B05UFr+oFsqPHsCJOwrQv5UQfI OQruhVTPuaYHL7KPsWpt1AITuTzlLMwEBpB0Uu4B0AuFFHZ+k6jF1PCY16gxrcwG+EsgTEdGexo yWQb2cqVOkgb72chCCDr9ovEuxOsIQt38h9sh/355FnL8oZy9jY4GoG7fYuIn5c/TVDoNWTIy0H fEZwLqpSIVNr8+WzndUP3G6y+Zv5sQEbTn43J2DMTX2Y1l7HwdQ0S0bp+JIdA9+KQrNqXZiDcO3 BOIC03Z4M9sM2Ng==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Convert the lsm_blob_size fields to unsigned integers as there is no
current need for them to be negative, change "lsm_set_blob_size()" to
"lsm_blob_size_update()" to better reflect reality, and perform some
other minor cleanups to the associated code.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 28 ++++++++++-----------
 security/lsm_init.c       | 51 +++++++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index bc477fb20d02..a7ecb0791a0f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -102,20 +102,20 @@ struct security_hook_list {
  * Security blob size or offset data.
  */
 struct lsm_blob_sizes {
-	int lbs_cred;
-	int lbs_file;
-	int lbs_ib;
-	int lbs_inode;
-	int lbs_sock;
-	int lbs_superblock;
-	int lbs_ipc;
-	int lbs_key;
-	int lbs_msg_msg;
-	int lbs_perf_event;
-	int lbs_task;
-	int lbs_xattr_count; /* number of xattr slots in new_xattrs array */
-	int lbs_tun_dev;
-	int lbs_bdev;
+	unsigned int lbs_cred;
+	unsigned int lbs_file;
+	unsigned int lbs_ib;
+	unsigned int lbs_inode;
+	unsigned int lbs_sock;
+	unsigned int lbs_superblock;
+	unsigned int lbs_ipc;
+	unsigned int lbs_key;
+	unsigned int lbs_msg_msg;
+	unsigned int lbs_perf_event;
+	unsigned int lbs_task;
+	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
+	unsigned int lbs_tun_dev;
+	unsigned int lbs_bdev;
 };
 
 /*
diff --git a/security/lsm_init.c b/security/lsm_init.c
index b1156f414491..aad363e37140 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -169,16 +169,22 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
-static void __init lsm_set_blob_size(int *need, int *lbs)
+/**
+ * lsm_blob_size_update - Update the LSM blob size and offset information
+ * @sz_req: the requested additional blob size
+ * @sz_cur: the existing blob size
+ */
+static void __init lsm_blob_size_update(unsigned int *sz_req,
+					unsigned int *sz_cur)
 {
-	int offset;
+	unsigned int offset;
 
-	if (*need <= 0)
+	if (*sz_req == 0)
 		return;
 
-	offset = ALIGN(*lbs, sizeof(void *));
-	*lbs = offset + *need;
-	*need = offset;
+	offset = ALIGN(*sz_cur, sizeof(void *));
+	*sz_cur = offset + *sz_req;
+	*sz_req = offset;
 }
 
 /**
@@ -193,24 +199,27 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 		return;
 
 	/* Register the LSM blob sizes. */
-	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
-	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
-	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
+	blobs = lsm->blobs;
+	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
+	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
 	/* inode blob gets an rcu_head in addition to LSM blobs. */
 	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
-	lsm_set_blob_size(&blobs->lbs_inode, &blob_sizes.lbs_inode);
-	lsm_set_blob_size(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
-	lsm_set_blob_size(&blobs->lbs_key, &blob_sizes.lbs_key);
-	lsm_set_blob_size(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-	lsm_set_blob_size(&blobs->lbs_perf_event, &blob_sizes.lbs_perf_event);
-	lsm_set_blob_size(&blobs->lbs_sock, &blob_sizes.lbs_sock);
-	lsm_set_blob_size(&blobs->lbs_superblock, &blob_sizes.lbs_superblock);
-	lsm_set_blob_size(&blobs->lbs_task, &blob_sizes.lbs_task);
-	lsm_set_blob_size(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
-	lsm_set_blob_size(&blobs->lbs_xattr_count,
-			  &blob_sizes.lbs_xattr_count);
-	lsm_set_blob_size(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
+	lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
+	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_blob_size_update(&blobs->lbs_perf_event,
+			     &blob_sizes.lbs_perf_event);
+	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
+	lsm_blob_size_update(&blobs->lbs_superblock,
+			     &blob_sizes.lbs_superblock);
+	lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
+	lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
+	lsm_blob_size_update(&blobs->lbs_xattr_count,
+			     &blob_sizes.lbs_xattr_count);
+	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
 }
 
 /* Initialize a given LSM, if it is enabled. */
-- 
2.50.1


