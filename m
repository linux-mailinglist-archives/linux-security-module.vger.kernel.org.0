Return-Path: <linux-security-module+bounces-11471-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D443FB272AC
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Aug 2025 00:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F22A22CF2
	for <lists+linux-security-module@lfdr.de>; Thu, 14 Aug 2025 22:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2247A2857F8;
	Thu, 14 Aug 2025 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CJNU5390"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2A22857F9
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212111; cv=none; b=iAAbDBYjFgEIngK7142Yva1urZ2l6+pe4OucyJgXQJr2h3IOEjHteqZbXtSLu5wDGJmdOgDSgYf/RmX2tCB2GSSBPYYPmlY+dqr9QXRaGhCN5eMWLNCBaO+mK7q3z8j3UGGh/mcuUa4VcE8UvW0sJ8b6I+n8ZEZ7p8HL6yYmrgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212111; c=relaxed/simple;
	bh=fdl7CzqY59D2dLsC4jc8NY8hiLlk4gTFAqpYUh2VbuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnFAfJPJyAi5cj0lyGVrIVBVVG0zSIHeaDSW0SUyq6Y2TuU6Hx2nlVoJLsAazR22tZ/rScGY8SrkRBHo1clNGOBNPDeZCfV9EgAzigEb/xUonZtYfxAdaD+rOJk3G4DBvYV50J0HeMukHbd+9dGFHtgK1acywgB3Z+iiDamW+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CJNU5390; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b109c4af9eso13207371cf.3
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212108; x=1755816908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oxe9YEWGmig4Lx2hQHLyZ4lS+p5Qn9z0718KHQhmI2s=;
        b=CJNU5390rHlHQeqZ9K7q7msBe5y9hERyoh652gRWYh9SzcWT0BHVAI35BQsi41LCo9
         MIgcpaREnJG7XQ7NA+hfscgzXB/Ih1cOcxOVq9o0bcJ/Ii2QK4YuYy+O0O135pHWldmo
         Y/xM/XPmsTglhUKAf0HNn9A7MTeeaPODJLP8ZX7ZzpPXelMIsXVaZLzrKzubyuYOyAlH
         ivmLnBftxTulJT/6mKx724Fh9ZptcwV+DlXZYPYEAYuR0fZXv0ae1tnyEdMQRRm/HeWz
         KFT5OOcJdRUuIlRe5PUtNHzy7pEUe4meBJAMk8/vmd5cVxC0cqdl8nHr3dqS0DEStsE5
         mt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212108; x=1755816908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oxe9YEWGmig4Lx2hQHLyZ4lS+p5Qn9z0718KHQhmI2s=;
        b=Iaa5K/sIfAKnTN7Ophnnsq0uSl0mPlMKtWkUWQwaxZ07wJ4Bq1U2HBO4jFmOqismxT
         njT2jaVDQTUaZFcbWrG8NCcdPXR83haKBk1Q2Nh5mIn5/ypuOuO9jEG+J/qlLpFzLQCz
         QNkHG49ET6tYSWQWd5mKjZ60tHd0F3jAVSym8OstoEIOwkQn2FutA+ZvrnjbPJGTOHmh
         D8GdB/ensxZcw/ZbYIM6t1KXNBDD+bP9dBPZmL6+9oi9qCRsLQEnAFfnxTC92hvTVDHL
         QM6Us72LMpVbCj+hV7Cv+2h3UCQodZfvu/4C86o/h1qG7PJEjlVv1w1XmzY2lxTbMDNt
         +xlw==
X-Gm-Message-State: AOJu0YygQPBRsVmF1YeVWp1jVuUU19Litox9qXhjazAZbr2C2b8XXP9s
	z6ilAkNSrVr3/mj0+jGVrGpIuDY/dHZKSxfhfv/Z0xAc+eUW6zPf2iNogheU34Y3++aZ3zo7q7P
	4kbA=
X-Gm-Gg: ASbGnctyP32VngDyRjubuZ4ZT1n9kzDgXA3P7QYJon8PX6PQ2usKLI9SMxZmbcpo1bn
	CIt/VAnAoPQorNHnknopFnBFAE9/a/BtxTG3kr15tbiW4XuWrcq5na57+txfXphUGjfV43U1ERv
	CEXBATdoo9hrW2iHxV+6TfF1aumOcwF2NIa8IMlz7HuhebXlxNMgb2U0wnp84hPZQFdimtxjBdr
	AagaUA2NodzhvA+2nlVT9/s1RPnO4W0zyQPmlLPl2xhLnVBJXyDPskCtzMB1dI/qSdlopwQXyG6
	wP1JOkTjjJRv75yQnNtayM8c4+oD+tzdKGklY6hVX1qEnVHwmRNKImNrTA4D75QOMpa7ytzF3uy
	gFMRN75uZoaXoTzpz0QQDRuyONrR7tfEqW0sSWu+3DlJFdnWrRlAXpNnuFntjb5S+RYl4lFJ2e0
	tP5g==
X-Google-Smtp-Source: AGHT+IG4cuhWSAP2h+Qyau+cGWtn54Cvnt6cc0Dk6EYYnulcoYcagXhlg8oEvE0PduHFsEToMbkDQw==
X-Received: by 2002:a05:622a:4c0c:b0:4ab:3c02:c449 with SMTP id d75a77b69052e-4b10c5213a6mr74481871cf.17.1755212107784;
        Thu, 14 Aug 2025 15:55:07 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b32b1dcsm44910785a.11.2025.08.14.15.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:55:06 -0700 (PDT)
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
Subject: [PATCH v3 34/34] lsm: add a LSM_STARTED_ALL notification event
Date: Thu, 14 Aug 2025 18:50:43 -0400
Message-ID: <20250814225159.275901-70-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=paul@paul-moore.com; h=from:subject; bh=fdl7CzqY59D2dLsC4jc8NY8hiLlk4gTFAqpYUh2VbuE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmj7rGty3eNbiLBayPaBS0jB5uAjUcq3lXHPV bH9KTnAfjaJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o+wAKCRDqIPLalzeJ c7jQD/49TAYBsfxYR13eJLmK2MD1NehvnHrPVZB8DDt27MYzR8T2nBeDVO/4RYDQyzQ9kIMal/w H0KCfERXDU/1eUTshg5DP86iddygWpypciU4+rV2wQDNH7vGdBYvDLj1BH0mAd4EZdV3izIx4sT /8/m7i/jmBtN6bpURG37jI3lXWYwgERkoSexmJ2s60VxK1TgOl7rK9Owx3ZS6Kweq9AylnU6rHP dsJjDXkU9Xo74VVYKis1LdOUIcm4jwgdfqs7b9IfUoMaExWlAHcNh7W5fOOoQfbckVLiYEIs9wN Kc25nncwqTC+kPpQlG64ygxjcD0TMBOMJgbllqfBDqGAAjnhr6y+7YoYirSOT51EDxF6X1VMPvr rGM1aajS2q1UMG/aBPxKV2opGhqe5Lwkitydf0swuE1cmItM4IwgOHcy9QC+K1nCpaFxZVjJ0wA CMGD60bnYXO0DBtfForehRfKBfigOk6LftnaqpIn+7Ug/hoW3lPIMMLaJY3aa97vNJNyT92ry8k zAd7+CwgEQr/5i1aMtRCwK96Cg0leQhwo7Y9x5s0NkTX1mrTOVo0JDWRQ1mJByBlGcgcjXayx1y 9v4/OPCMPy1XQFZFPaWq2yXl8afCOm8AKPQm8+lq06HnU0uYYzknEKWQH3A/WqYFDkx35gjNzI0 8elFjuAmXDUb2Kw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add a new LSM notifier event, LSM_STARTED_ALL, which is fired once at
boot when all of the LSMs have been started.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 1 +
 security/lsm_init.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8560c50edd2e..c13f0a849024 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,6 +85,7 @@ struct timezone;
 
 enum lsm_event {
 	LSM_POLICY_CHANGE,
+	LSM_STARTED_ALL,
 };
 
 struct dm_verity_digest {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 2bd705836df8..af4046c5c581 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -556,6 +556,7 @@ static int __init security_initcall_late(void)
 
 	rc = lsm_initcall(late);
 	lsm_pr_dbg("all enabled LSMs fully activated\n");
+	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
 
 	return rc;
 }
-- 
2.50.1


