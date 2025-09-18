Return-Path: <linux-security-module+bounces-11923-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B6DB7D4B3
	for <lists+linux-security-module@lfdr.de>; Wed, 17 Sep 2025 14:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32D517EE5D
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Sep 2025 22:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154C92D062F;
	Tue, 16 Sep 2025 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eNvinvCx"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5725C2BEFFF
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060841; cv=none; b=JVnqABsUzOkQw8GXyyC/C5+jkCCXQLnmxAf3wtdBOCahHutz6z7P9TtH5VL+YccRLHhgRH0eUXE6WWMEySt4u1d5KgWl6LFPsf8fqybPyMqmwDMhQWtAsgtTOB9pwXPuV/RPwrEFwOmbhINbv8anSI3+EphjaIt0XwGqc85SDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060841; c=relaxed/simple;
	bh=k92MwOt9mTyzeYWKAqh2sl8WRFENDrlRbHUPmeZkctA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BM+nOKRLAqrFdtZmdLW8GeuGMhSpFJcauC13kbtLM4QIYTzN5LxpqIYXQWUrbsKwqmDCn2wc1HcwWxaQwPo6SxjDPGSHOZd/gSwdPCQlu9BD0K8SkHJGcQvlk+PX3zNXsV3V4eHNFzWxRVEt7cgnfiMVFa78JDarn5IAoP2hDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eNvinvCx; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-80e2c52703bso531328085a.1
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 15:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060837; x=1758665637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrtH/KsP4LFzahvcKDLMyty8tAhDhmnOKOGFABJolAI=;
        b=eNvinvCxAuTznIJbqE8D94jvactMbPtixP4Gs5saYL1Yh2SsQP7uDonOXiVW1tk1dg
         01DYz0aw4fsp9Zw9Urm7QpkLRcyTqHc4DgcOpmqMV6AAXm9wtGeLgph6vsfWkXX0N2X/
         lSYcgwmC0KUwD+b1k1daQb4N89sNdOk9m8E0H6OjLZMvwsarpNuJOGWFNHAGy6rXkjkO
         zTRmVdnx3fLtlABw5njYsC0dEvJ7wbO0PkNdGt1p+cnqEYVGvCpa+FYTa9XjMVgJT+D1
         23Lij8MSTZwghbZwR/3xSP+HxMOD1fZoCQfk5TicVyuFHz9OSCA0ml1A30qSlxjdgpUM
         9mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060837; x=1758665637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrtH/KsP4LFzahvcKDLMyty8tAhDhmnOKOGFABJolAI=;
        b=XnOTJaFWtG1SLooxo5c/WNghaTMTB7XfLnUnMkvnInx3TmtgYk9eqiw8KV+nBsi4bo
         Eu1hsEHfEET1E9v/XqmA6JUjrG9F3DwsTbCNcsrjFcfQwKn/ot4FEHXi29PRTuAfcsp1
         gxTwrffw2Xkkd5IByvnCIqwmZf2uR/YeV1YNF26wNd+JIlpFeGV3mnufZvbhN9zQnVR0
         uKsshSn4NJ5wVSwJB/iaYgowY3eLMaIvmHywUywW941WoRxvp+BFZiraJQTs45Mt9tOV
         pJ1XxWDSLNdv+QbDL4UOiWbRgFZ943L+sm/NjKAbvfouVprQR4OZB96/hdICxlV3KteX
         CkIw==
X-Gm-Message-State: AOJu0YxARY4RTZn7zsiR7T3IsCzu2HySUZLs6ibsn4RMUy9I2sLsrhA6
	6ejZuonv1WTK+abyFAdYpt5TU7P6Hhs0eOzuN6WGC+AfZA4cZaj9HGNTKMPvz7Og4SgxJlZdsTz
	T7Bs=
X-Gm-Gg: ASbGncvMDe+UVTmJHcMiu6eKQ45VGZGdmm0F+vBQRhFgFWSx4WKozMiHuw3kjoy85h7
	LmqMHOtuCG/w/tCWkRjpxblI3RsJ0A1M+0rdOmrikrnMLh4Zzck4VaSi2uIMfZZ+xPkPpoy9jr3
	C8YXspsxARQ6eFC2tCsgJ4qbgZI8WhZKDMBNGJRAZdA8+3m3DSonSKZndXC0YC/6qztqcqpRlN8
	TbrdHhTdzXJt1Ml+x+Kk/EVMC6GBv7NSwkeTQQYeUfHJl1k3BkrnaLmzfXmu42gpEFD+epdvry8
	23aFS4xYkkxx4aFoKTyz+odx8QGIM07m/kaiHXXVpoZTCfrteQ/CzHRmXy0UeLt4zr0961vit02
	siZaX7T/3rs2a4L4gVkjvvkdX7nrU7OxCF3gMF7F4TBn17Ofbx2j52R2elwFv2aXlRMfI
X-Google-Smtp-Source: AGHT+IGKjXoHDjzxbVzmlEEUMONFlgIJ1ELjwNvAAsfM/KCpBzvReZ4/Qoz/oVoIo2NU9EX9NUNnCg==
X-Received: by 2002:a05:620a:280b:b0:811:e100:4fea with SMTP id af79cd13be357-82402726ccemr2055132185a.51.1758060836960;
        Tue, 16 Sep 2025 15:13:56 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820c974d54asm1025872185a.19.2025.09.16.15.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:55 -0700 (PDT)
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
Subject: [PATCH v4 12/34] lsm: rework the LSM enable/disable setter/getter functions
Date: Tue, 16 Sep 2025 18:03:39 -0400
Message-ID: <20250916220355.252592-48-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5507; i=paul@paul-moore.com; h=from:subject; bh=k92MwOt9mTyzeYWKAqh2sl8WRFENDrlRbHUPmeZkctA=; b=kA0DAAoB6iDy2pc3iXMByyZiAGjJ3vCiAHO901Xf88p+K/LyZETpeItHRBTo9cI3rTg9/ktH5 YkCMwQAAQoAHRYhBEtCqM8H8pnVVJd+7+og8tqXN4lzBQJoyd7wAAoJEOog8tqXN4lz7HwQALl5 dqhG2uweggTvev6L6z0CohHvUSFKNc9xxk5Hvn1DF3AV/If/4MRnIeM8103VpjIGecvJzx9Yyxg IYU7R+46opzrggSrus5uX4EoCdSkJAybC8lsQflLXjzATRUcWp6vtTh5wYTzg/ea1buQVw2wDGU VUlss+4c1Tx41x4rZ+pUKhdUx2CHr9EL8nf7aVG2sGgQo4JuL/5f+OVu26fu+bMjbbN10WW3EEg c2t0EkcKQfrjEq0A5VsQRUCtSqde5LwBHp25kxBWMivOSZSc6hyR5onN/TRoWaETsRVybs/V/RC Z6PYYDuLIqV5c/aDXtpzuaSYvjk1G1HNGaFh9Um9wV2XzzoP0EU2wrOsy4raEURm38IKrD4dU2H YO02oKIjEkI4ZfYCdMIz/3qshpXKrhU3yrwdGE1y42M6tN+p5+j+a7p/ElhbJnYshrygyv3VG+D LWct11Gn5O4JgxMK5V32laGdsSTXVx6MMETLHM35NyZkdXUyBVa4CTGkwP0u/nPijy00+Npcbza qeUAjcwI6wuIvGVU0U4z9feV1TQNde9Je3I7wKFh8cztZCM5OvCfFePzLmdgXuYlZeD2bBGojBr Ht1hUY6s95UYFKpOP3J/znBkK04mkPMxbdZA+97U9mHyt04Qmq+GggIWFEqGfvjP4MuYi+lmIW8 FxZiu
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

In addition to style changes, rename set_enabled() to lsm_enabled_set()
and is_enabled() to lsm_is_enabled() to better fit within the LSM
initialization code.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 62 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 87e2147016b3..2cfd72ade6fb 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -10,6 +10,10 @@
 
 #include "lsm.h"
 
+/* LSM enabled constants. */
+static __initdata int lsm_enabled_true = 1;
+static __initdata int lsm_enabled_false = 0;
+
 /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
@@ -75,37 +79,33 @@ static int __init lsm_debug_enable(char *str)
 }
 __setup("lsm.debug", lsm_debug_enable);
 
-/* Mark an LSM's enabled flag. */
-static int lsm_enabled_true __initdata = 1;
-static int lsm_enabled_false __initdata = 0;
-static void __init set_enabled(struct lsm_info *lsm, bool enabled)
+/**
+ * lsm_enabled_set - Mark a LSM as enabled
+ * @lsm: LSM definition
+ * @enabled: enabled flag
+ */
+static void __init lsm_enabled_set(struct lsm_info *lsm, bool enabled)
 {
 	/*
 	 * When an LSM hasn't configured an enable variable, we can use
 	 * a hard-coded location for storing the default enabled state.
 	 */
-	if (!lsm->enabled) {
-		if (enabled)
-			lsm->enabled = &lsm_enabled_true;
-		else
-			lsm->enabled = &lsm_enabled_false;
-	} else if (lsm->enabled == &lsm_enabled_true) {
-		if (!enabled)
-			lsm->enabled = &lsm_enabled_false;
-	} else if (lsm->enabled == &lsm_enabled_false) {
-		if (enabled)
-			lsm->enabled = &lsm_enabled_true;
+	if (!lsm->enabled ||
+	    lsm->enabled == &lsm_enabled_true ||
+	    lsm->enabled == &lsm_enabled_false) {
+		lsm->enabled = enabled ? &lsm_enabled_true : &lsm_enabled_false;
 	} else {
 		*lsm->enabled = enabled;
 	}
 }
 
-static inline bool is_enabled(struct lsm_info *lsm)
+/**
+ * lsm_is_enabled - Determine if a LSM is enabled
+ * @lsm: LSM definition
+ */
+static inline bool lsm_is_enabled(struct lsm_info *lsm)
 {
-	if (!lsm->enabled)
-		return false;
-
-	return *lsm->enabled;
+	return (lsm->enabled ? *lsm->enabled : false);
 }
 
 /* Is an LSM already listed in the ordered LSMs list? */
@@ -139,7 +139,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	lsm_idlist[last_lsm++] = lsm->id;
 
 	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
-		   is_enabled(lsm) ? "enabled" : "disabled");
+		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
 static void __init lsm_set_blob_size(int *need, int *lbs)
@@ -162,17 +162,17 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 {
 	struct lsm_blob_sizes *blobs;
 
-	if (!is_enabled(lsm)) {
-		set_enabled(lsm, false);
+	if (!lsm_is_enabled(lsm)) {
+		lsm_enabled_set(lsm, false);
 		return;
 	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
 		init_debug("exclusive disabled: %s\n", lsm->id->name);
-		set_enabled(lsm, false);
+		lsm_enabled_set(lsm, false);
 		return;
 	}
 
 	/* Mark the LSM as enabled. */
-	set_enabled(lsm, true);
+	lsm_enabled_set(lsm, true);
 	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
 		init_debug("exclusive chosen:   %s\n", lsm->id->name);
 		lsm_exclusive = lsm;
@@ -206,7 +206,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 /* Initialize a given LSM, if it is enabled. */
 static void __init initialize_lsm(struct lsm_info *lsm)
 {
-	if (is_enabled(lsm)) {
+	if (lsm_is_enabled(lsm)) {
 		int ret;
 
 		init_debug("initializing %s\n", lsm->id->name);
@@ -240,7 +240,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		lsm_for_each_raw(major) {
 			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
 			    strcmp(major->id->name, lsm_order_legacy) != 0) {
-				set_enabled(major, false);
+				lsm_enabled_set(major, false);
 				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
 					   lsm_order_legacy, major->id->name);
 			}
@@ -286,7 +286,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	lsm_for_each_raw(lsm) {
 		if (exists_ordered_lsm(lsm))
 			continue;
-		set_enabled(lsm, false);
+		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
 			   origin, lsm->id->name);
 	}
@@ -319,12 +319,12 @@ static void __init lsm_init_ordered(void)
 
 	pr_info("initializing lsm=");
 	lsm_early_for_each_raw(early) {
-		if (is_enabled(early))
+		if (lsm_is_enabled(early))
 			pr_cont("%s%s",
 				first++ == 0 ? "" : ",", early->id->name);
 	}
 	lsm_order_for_each(lsm) {
-		if (is_enabled(*lsm))
+		if (lsm_is_enabled(*lsm))
 			pr_cont("%s%s",
 				first++ == 0 ? "" : ",", (*lsm)->id->name);
 	}
@@ -440,7 +440,7 @@ int __init security_init(void)
 	 */
 	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->id->name,
-			   is_enabled(lsm) ? "enabled" : "disabled");
+			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 	}
 
 	/* Load LSMs in specified order. */
-- 
2.51.0


