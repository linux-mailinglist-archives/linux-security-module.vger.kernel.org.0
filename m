Return-Path: <linux-security-module+bounces-11451-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1D9B27270
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Aug 2025 00:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792ED5E3F42
	for <lists+linux-security-module@lfdr.de>; Thu, 14 Aug 2025 22:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2C283FC8;
	Thu, 14 Aug 2025 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="agjPvLdo"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486AF28312D
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212071; cv=none; b=p+MuXP97yUXzGrqdihbdTB+S4gcXu1UVRksh7UvZoBD4mTVygM3HW2rQf9RTri2G8Apv4lL4RYyU5vHGacy2u2eNPkfzKBb1XOt8alQRktdaZY0CoM9VeZXCm4dItW6V0JvEAnuOQQTHy75s4w+fn3lwQB+gCZLEz8G/ADPvaDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212071; c=relaxed/simple;
	bh=UaYvKcicR+Q7vMoIAgW3eYjmXHV1gDYBla+TXaB3Vhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXFzrTxEFyBYp2U3R6QTsBsmngrENQ7QxuewDZ8GoGoa4wfWXgU7VQSqJMLcZ+lCk/7Y2lD1MqfqsBPUjpYid1MKdUtbN7bjzIts30J6INscABMCPngQ4kP0hhONlEyQJcanUPgM/W0mHZ3EAqVlnbf9r4Og7csmQ8sL028IFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=agjPvLdo; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70a9282f475so13326456d6.1
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212068; x=1755816868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+XJ9Qbaj2E+d3rpGg6XUJPNcIGY05oT436zQ9wbRRc=;
        b=agjPvLdosfgC/t0+gAwntBFjjrdH6nyVuVV2xROYINxQjQWKiiwrudBgTqiuXr4FJY
         KjPgVgMFAwuNQk3DJeyB/UMGVs4YLW/SJrMtM1BpYDvulNkgRkMZGqX9+D/JncPo6Rrt
         vMmEC78xTjtgDcKAs/YbaT+LZFtX93pAm3sESg2c7rdCT5cUqix91bbIhKi35afHF2sn
         vP8L1pBnkX1eaEY9dq4L/gNrSmX6zzJ74xfl9xannykVYrqnZAMhDpEKGmNfn095H337
         dQzqA9vfsJCN65rgIDCuXPgrp3c08TLPPnEk9H5+Rh09v9wba2aQ75eXqnvkR0PRyBD4
         9x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212068; x=1755816868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+XJ9Qbaj2E+d3rpGg6XUJPNcIGY05oT436zQ9wbRRc=;
        b=d40IRZCizl6hm5RezOUZXY8lb76SUEWr7AICRN9nFW00yhO4Wqi06brSCB8Sk2J8IY
         sYT43gOalDpd9vjnSaoHSc9Ks62oF7HN9o7nUIXKHBf84Kb+dsed47gn6tbRiI9dhTs+
         wMJL3iNcNZcVHVCHItOJXbr2ZNIZSM630akMvdNs7wudVvHp/VtuT6M8oYa6fhMsR4sk
         MOrZ2JAWbeGa3tayaRUwHH4hXVnYkQs//Vjb5Kv/czOyJxW6S+aq+IIm21I/l5XHEhHx
         SwsuPZpPujqBQUw9NzqrqPcIWiY8SRXybSkzC68+NxHuar2Wilxo1kxFbSNq5Ju5P71G
         W/dA==
X-Gm-Message-State: AOJu0YxMnQ4wFX3AX58wNCy8kPKgHusnJEFBiezX97puwLggYqcnc+Z0
	QXmTjXYiXZRJpMnaqwcWbIhXk5JPh8R/vcrFohS+8pnXwvkbfK7yIg1FOzjwzb1dIa947y7jWdl
	b3ys=
X-Gm-Gg: ASbGnctb+Kj3tCtV/w17n/vpy7ZT1iXaJ0Zgr0tpKnrfk2XHbEBw/5W5AnAu12v30FE
	33TNtlVgS7R7wNZAHBg//0M5k66RGsrj7/G+/AxESg4V9cBDvIJDnfTQyVV/ZoGfZaPKVO4kRYS
	FankWW4g4h1plG8QvCWs4AeIT01OUbEF+yFe7w9D6UXE2OcTdzsfxwB2ATm98+0XU/7bhJC9Bxl
	e9y4hnzX5IVFQVqr9TDA/c05sMp2aAv+Pn1xc/cs14LRAE4JIdTq2KHIjz3QVt5lO1nDFLhmSEi
	nfZdqRkaM5uluxweBkEM7/5fixd4nWvWWxmjTqrBeFw2rE5Zjo9mpUkFrdCL8xydzwaF7JNOevB
	rW58AJrZCLUNnWOCYe/mXglNU2cHE/QNHiIikQsofdNSb1G0MZx8nrcGYDSABX065csM=
X-Google-Smtp-Source: AGHT+IG2Imq/lmniU+psnbHt2UK3woyEDBr4rUFbXhalF6jOB8ocbRwR9lkNXuox0BvA/kOrYHRCZw==
X-Received: by 2002:a05:6214:3018:b0:707:6c5:55ad with SMTP id 6a1803df08f44-70b982e529dmr59719136d6.12.1755212068231;
        Thu, 14 Aug 2025 15:54:28 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70af5bff7c3sm19031716d6.78.2025.08.14.15.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:26 -0700 (PDT)
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
Subject: [PATCH v3 14/34] lsm: rename/rework append_ordered_lsm() into lsm_order_append()
Date: Thu, 14 Aug 2025 18:50:23 -0400
Message-ID: <20250814225159.275901-50-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5094; i=paul@paul-moore.com; h=from:subject; bh=UaYvKcicR+Q7vMoIAgW3eYjmXHV1gDYBla+TXaB3Vhw=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmi5mKaFGlehjkq1JB5SNwjszw7thELvLb9V5 1c7EO7V2/+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5ouQAKCRDqIPLalzeJ cyGfEACM549E+wPnlpkMfE8qpQG1bsITmPJqcT8bv1ch9SSXAh+srSHl+F7cKSa2L1/Ayua7co3 sHAJLLFg/+rL9867gJ597bG8nxfew17FigREZbuyAnHN0QH9afaGhYcE+QKsFwHEvIEoNIxhU7W wcoatJ3UbM39xlsWBWWd/Uo3U4S7NgLStvz4waZvL5IRsPBZaaN5NuuN6Q2udhk0FgWGlgvCPG+ 3UHnJCMPOu9tenvgPmxrBXtXp7bW8rqXWp52FN8FSXs0K2lXw6/j+4qRenpe879RRF9NC+Bkr44 MftZnm3+sg48Okp5upB8xTNoSA2BStzwmTK3WDpoHzIHOa560Af1PkkqmzIWK4ZikWVg/xrhtD0 J3W6cTpShlVg1wlLw1gUXlEtZlXoJ0SyezTsNHtT703TM/DHwQL8L4ZpqzqlG29OWev7pGsIxqM 2BWMsMzIcRFYZwn5VtI5aI/4BaJYbhVXfvrZQaA8LsGjLXtUQY1mie2tfdBqQxKbelrTSE19QRT XWXRgVdJlVXF04kGVIBTxjqoavZ8CBneoLpL5EQ6bMfy2zEzgr4bD7YC4D2TZs0YT3eXVX1DmNp Ei8Py833np3IP1UHwUT/afKYs+RxPlqs4jX2wyypw1+AAnj2Swn7Vmay10CdZetzeQza9CRI9aN OJdgBsUxkdrvagg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename append_ordered_lsm() to lsm_order_append() to better match
convention and do some rework.  The rework includes moving the
LSM_FLAG_EXCLUSIVE logic from lsm_prepare() to lsm_order_append()
in order to consolidate the individual LSM append/activation code,
and adding logic to skip appending explicitly disabled LSMs to the
active LSM list.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 76 +++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index ec46ddb18e1e..a314484d7c2f 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -124,24 +124,48 @@ static bool __init lsm_order_exists(struct lsm_info *lsm)
 	return false;
 }
 
-/* Append an LSM to the list of ordered LSMs to initialize. */
-static int last_lsm __initdata;
-static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
+/**
+ * lsm_order_append - Append a LSM to the ordered list
+ * @lsm: LSM definition
+ * @src: source of the addition
+ *
+ * Append @lsm to the enabled LSM array after ensuring that it hasn't been
+ * explicitly disabled, is a duplicate entry, or would run afoul of the
+ * LSM_FLAG_EXCLUSIVE logic.
+ */
+static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 {
 	/* Ignore duplicate selections. */
 	if (lsm_order_exists(lsm))
 		return;
 
-	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
-		return;
+	/* Skip explicitly disabled LSMs. */
+	if (lsm->enabled && !lsm_is_enabled(lsm))
+		goto out;
 
-	/* Enable this LSM, if it is not already set. */
-	if (!lsm->enabled)
-		lsm->enabled = &lsm_enabled_true;
-	lsm_order[last_lsm] = lsm;
-	lsm_idlist[last_lsm++] = lsm->id;
+	if (WARN(lsm_active_cnt == MAX_LSM_COUNT,
+		 "%s: out of LSM static calls!?\n", src)) {
+		lsm_enabled_set(lsm, false);
+		goto out;
+	}
 
-	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
+	if (lsm->flags & LSM_FLAG_EXCLUSIVE) {
+		if (lsm_exclusive) {
+			init_debug("exclusive disabled: %s\n", lsm->id->name);
+			lsm_enabled_set(lsm, false);
+			goto out;
+		} else {
+			init_debug("exclusive chosen:   %s\n", lsm->id->name);
+			lsm_exclusive = lsm;
+		}
+	}
+
+	lsm_enabled_set(lsm, true);
+	lsm_order[lsm_active_cnt] = lsm;
+	lsm_idlist[lsm_active_cnt++] = lsm->id;
+
+out:
+	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
@@ -163,26 +187,12 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
  */
 static void __init lsm_prepare(struct lsm_info *lsm)
 {
-	struct lsm_blob_sizes *blobs;
+	struct lsm_blob_sizes *blobs = lsm->blobs;
 
-	if (!lsm_is_enabled(lsm)) {
-		lsm_enabled_set(lsm, false);
+	if (!blobs)
 		return;
-	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
-		init_debug("exclusive disabled: %s\n", lsm->id->name);
-		lsm_enabled_set(lsm, false);
-		return;
-	}
-
-	/* Mark the LSM as enabled. */
-	lsm_enabled_set(lsm, true);
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
-		init_debug("exclusive chosen:   %s\n", lsm->id->name);
-		lsm_exclusive = lsm;
-	}
 
 	/* Register the LSM blob sizes. */
-	blobs = lsm->blobs;
 	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
 	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
@@ -227,7 +237,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* LSM_ORDER_FIRST is always first. */
 	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_FIRST)
-			append_ordered_lsm(lsm, "  first");
+			lsm_order_append(lsm, "  first");
 	}
 
 	/* Process "security=", if given. */
@@ -259,7 +269,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		lsm_for_each_raw(lsm) {
 			if (strcmp(lsm->id->name, name) == 0) {
 				if (lsm->order == LSM_ORDER_MUTABLE)
-					append_ordered_lsm(lsm, origin);
+					lsm_order_append(lsm, origin);
 				found = true;
 			}
 		}
@@ -275,14 +285,14 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 			if (lsm_order_exists(lsm))
 				continue;
 			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
-				append_ordered_lsm(lsm, "security=");
+				lsm_order_append(lsm, "security=");
 		}
 	}
 
 	/* LSM_ORDER_LAST is always last. */
 	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_LAST)
-			append_ordered_lsm(lsm, "   last");
+			lsm_order_append(lsm, "   last");
 	}
 
 	/* Disable all LSMs not in the ordered list. */
@@ -415,8 +425,8 @@ int __init early_security_init(void)
 	struct lsm_info *lsm;
 
 	lsm_early_for_each_raw(lsm) {
-		if (!lsm->enabled)
-			lsm->enabled = &lsm_enabled_true;
+		lsm_enabled_set(lsm, true);
+		lsm_order_append(lsm, "early");
 		lsm_prepare(lsm);
 		initialize_lsm(lsm);
 	}
-- 
2.50.1


