Return-Path: <linux-security-module+bounces-11446-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BE1B27261
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Aug 2025 00:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C525E3F5C
	for <lists+linux-security-module@lfdr.de>; Thu, 14 Aug 2025 22:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565392836BD;
	Thu, 14 Aug 2025 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QrDW7PgY"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8042E283128
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212062; cv=none; b=svoaRCHwKiy82NzOUVvcm3DplwQLQD3GTyyPzn6ByUWQNffJMXuqgAerow6iG8W6GhEpmwZ2nfE7zxKtFa75w0dCfiDRJsEI8RyPPqNdAXaebl4PuBZ3uPyrUxVbgJ7JrcVaBJcGaWX76hFFDoe01i+QCA67NktRsfm9Kee8AZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212062; c=relaxed/simple;
	bh=OgjRSdzGbxwdMyUY/57Vu+d8OdymFTIGeeJ8qveJEdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYUafiPwCiZNTh9IHiA1Cn3ZiqXiSbipW8rB6HCad2ZKj7BbbHAqymp0HpToFgeYEB+kvCH0Z/pJcuuGDsXVUAU970+W6iJ1UYLKslNYKhT3YC9AXW9gWqS+wLETcpefsXnM53pyCuhG+7fGUuprJL0CUQh7zMt1UthFPKSD008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QrDW7PgY; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109921fe7so14924181cf.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212059; x=1755816859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rS0o+RXD4uaMrwvz+FW2e5QesfrfGb/7MdPjPBs5rt8=;
        b=QrDW7PgYGwyotUyMzw+LV7q+1ISqlDa7da/41ZEfHEPgMchXOvE0dcCBfrpXATb1el
         Dbn1vso+k/oRrPbRtJ52BqRcpJPeV6CgP6y+TCUG151NtUi+VJm2xgYtM1+TTDsQOPkL
         pCZdCEPKehbI8V2cENSP05OVrnkuwlUG50Coc3/QMuTk4b8Vmpwr9zFFXrPype3lA63M
         GQgSiAzsmfvUPj2wEttOjmiPyBAvXmmXyZG1mNKRmYH4f6Hs/AHvGhWfE8fA7YjmlvnB
         4zghQUQe3IUuRSOuVZ1pe0sIKFypezVosylbV7Co9gqHUaavBniMokNClAgeDbqIDBmE
         ZRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212059; x=1755816859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rS0o+RXD4uaMrwvz+FW2e5QesfrfGb/7MdPjPBs5rt8=;
        b=tsEIgaPGisAxwANqdJB4wLci9VPcPsTpZbeN7QhZylnGlSVi5Swn05NIzbGcFfBRZb
         H8oenrsa6yevOxzobEyUJIQ2wGmn6WdIrSyj/dJ5QDln1WFVj5iNNpeG18ccJ6PTMBis
         OGi5fvlVSUCay+SPssvhTFwSXKnmYqDziP/cYRJdHGXMfkbkJ+sKpGKHq9pWjMOUWoUh
         ueglx5X35QXva9xm3pBvPg9tFZxvR9pIqJT+H2rg9BHtmpxP+/JEdu+ZaslKttnj0+Jc
         GyHDQP8SnNJTYDZMrcDUVjgKu/XYXN93LkStZTk6zUKsc0QpZ4hvv29CxlrQAnOdcoZB
         FKbA==
X-Gm-Message-State: AOJu0YzzVsP1qYOAlacjAvQ1aoWYM22nu4gjEzhF+MDHv2v3+OSPiKPo
	M6D4Db/l9bAg8emuptX7V059NZ74Rew2DSSH745UY5s4HSD4QwcOfK0emhH+H4t6Rqektr2jXFh
	lnj4=
X-Gm-Gg: ASbGncv1p1BakYCLJ2aQc5j1rGRKsxnr/l01dGtSjyj6WL5KXUuqXhylTxG/l56TMjs
	i4vUy05QDkDRDEeQjMWHWZyYlUlFV8iFylnzCCkEWAytIiObwcBwL2cLLzvSvUc7m5lBya2m4RC
	jGohKqnvVVAkdYU+NVKLS25Qr9xKytyJ8xU6TtN/Vvyj31zcLHVFGpPuXdCbU40eFCTGho7qeT7
	U4zoLnNBVVTuZBvl9ZFaiccU02bKWcj2MOCwMZXU1ni9IDKMNOkVDxdPLrY2Xw7RLpXD9O0eT2o
	x21aHVjHJsMBDutNODQDmiYQpUsdgJETFUran1n023pXJUM5DIS/RKHXvtOzV2m/8MO3ZdUHnLN
	C5ccxbN6OO7PL6Ji/JshyyyRmrW3QzV4OpUarNRAzgn6vcKfPn/5Q+Q94ViY6NJmynufhQu5PWV
	JlDQ==
X-Google-Smtp-Source: AGHT+IHC/gofy6QSGP1mb3nPWpvKm6tDagGCOTgbrX6zHuzaCmYyf3amXtqTrs0C6gohtrHUBShtTg==
X-Received: by 2002:ac8:7e83:0:b0:4b0:a098:1f75 with SMTP id d75a77b69052e-4b10c392203mr55182401cf.8.1755212058587;
        Thu, 14 Aug 2025 15:54:18 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b34bcc4sm43907485a.18.2025.08.14.15.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:17 -0700 (PDT)
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
Subject: [PATCH v3 09/34] lsm: rename the lsm order variables for consistency
Date: Thu, 14 Aug 2025 18:50:18 -0400
Message-ID: <20250814225159.275901-45-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7523; i=paul@paul-moore.com; h=from:subject; bh=OgjRSdzGbxwdMyUY/57Vu+d8OdymFTIGeeJ8qveJEdI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmip8B2KuJFcuS+Nq39VrU9A3aVdWFLJqke/E O4WbimMEYWJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5oqQAKCRDqIPLalzeJ c10uD/sGG8zNhxfyZrZQm4NwrK32ch/Vdtwlti4QJZdgg6zFD7L6qqwiDzDyuY8YkWJ59MPRuK0 4cINfrDO9ho6+FKdzHXVmQnRvTDQaXUrZH7Sr1YkQ06Ck2dV7ujZ1w2LQUxf7KNNzSUnvKxCWyo yRWU8kcgwiUq0a2XOjlQCS8ublv6075/EkG6KYDjwfJMjJt0AHgYE1q3QdKnDK24qJZ/YQmKZEI ONlhWcYTSQAWxvPVP2CEIesgX40tuY8PDD1kXIIAl5mfSb5g0EmutEwotZ9i8h2MrGozL0kNG4r EsHWBADp5fmo769npURhDvnyIiPKjujGBF5On3B+Ue91itoExdPDlPGN8016PLygLTapvAAE7TR IAOQzFtFAFzrE8mNe/TTWtcfVXw6j/AxuTHB2sYWjcGO0hqGAiME+FnMfXzOUyMFOJgxiglTN0r auM/HAGCRMnQTJYFx0GDBQ5OT1YkUacFFOg+TCbDWRIT+NiGYf02AXPW7HXyQ1NXsPqK995EbnY M6jFWW5Q8xvWh9oOlTQ3NaqJx8pjDAduc80ZXNFwt5IX8R7bYAxcX6Yukut4c/65w3aUo/oZo6G y6+QQlDLe7bXZvdMrQFDsbYG/SjAUjWDi2cihUezTNDCOrvgB87WDfvGuf3ygcZDbLsxmzqtZCl v/WqS8bcXU859Ew==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename the builtin_lsm_order variable to lsm_order_builtin,
chosen_lsm_order to lsm_order_cmdline, chosen_major_lsm to
lsm_order_legacy, ordered_lsms[] to lsm_order[], and exclusive
to lsm_exclusive.

This patch also renames the associated kernel command line parsing
functions and adds some basic function comment blocks.  The parsing
function choose_major_lsm() was renamed to lsm_choose_security(),
choose_lsm_order() to lsm_choose_lsm(), and enable_debug() to
lsm_debug_enable().

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 86 +++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 628f54790360..2e76cefb1585 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -16,14 +16,14 @@ char *lsm_names;
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 
-/* Boot-time LSM user choice */
-static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
-static __initdata const char *chosen_lsm_order;
-static __initdata const char *chosen_major_lsm;
+/* Build and boot-time LSM ordering. */
+static __initconst const char *const lsm_order_builtin = CONFIG_LSM;
+static __initdata const char *lsm_order_cmdline;
+static __initdata const char *lsm_order_legacy;
 
 /* Ordered list of LSMs to initialize. */
-static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
-static __initdata struct lsm_info *exclusive;
+static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
+static __initdata struct lsm_info *lsm_exclusive;
 
 static __initdata bool debug;
 #define init_debug(...)							\
@@ -33,7 +33,7 @@ static __initdata bool debug;
 	} while (0)
 
 #define lsm_order_for_each(iter)					\
-	for ((iter) = ordered_lsms; *(iter); (iter)++)
+	for ((iter) = lsm_order; *(iter); (iter)++)
 #define lsm_for_each_raw(iter)						\
 	for ((iter) = __start_lsm_info;					\
 	     (iter) < __end_lsm_info; (iter)++)
@@ -41,31 +41,41 @@ static __initdata bool debug;
 	for ((iter) = __start_early_lsm_info;				\
 	     (iter) < __end_early_lsm_info; (iter)++)
 
-static int lsm_append(const char *new, char **result);
-
-/* Save user chosen LSM */
-static int __init choose_major_lsm(char *str)
+/**
+ * lsm_choose_security - Legacy "major" LSM selection
+ * @str: kernel command line parameter
+ */
+static int __init lsm_choose_security(char *str)
 {
-	chosen_major_lsm = str;
+	lsm_order_legacy = str;
 	return 1;
 }
-__setup("security=", choose_major_lsm);
+__setup("security=", lsm_choose_security);
 
-/* Explicitly choose LSM initialization order. */
-static int __init choose_lsm_order(char *str)
+/**
+ * lsm_choose_lsm - Modern LSM selection
+ * @str: kernel command line parameter
+ */
+static int __init lsm_choose_lsm(char *str)
 {
-	chosen_lsm_order = str;
+	lsm_order_cmdline = str;
 	return 1;
 }
-__setup("lsm=", choose_lsm_order);
+__setup("lsm=", lsm_choose_lsm);
 
-/* Enable LSM order debugging. */
-static int __init enable_debug(char *str)
+/**
+ * lsm_debug_enable - Enable LSM framework debugging
+ * @str: kernel command line parameter
+ *
+ * Currently we only provide debug info during LSM initialization, but we may
+ * want to expand this in the future.
+ */
+static int __init lsm_debug_enable(char *str)
 {
 	debug = true;
 	return 1;
 }
-__setup("lsm.debug", enable_debug);
+__setup("lsm.debug", lsm_debug_enable);
 
 /* Mark an LSM's enabled flag. */
 static int lsm_enabled_true __initdata = 1;
@@ -127,7 +137,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	/* Enable this LSM, if it is not already set. */
 	if (!lsm->enabled)
 		lsm->enabled = &lsm_enabled_true;
-	ordered_lsms[last_lsm] = lsm;
+	lsm_order[last_lsm] = lsm;
 	lsm_idlist[last_lsm++] = lsm->id;
 
 	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
@@ -157,7 +167,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 	if (!is_enabled(lsm)) {
 		set_enabled(lsm, false);
 		return;
-	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
 		init_debug("exclusive disabled: %s\n", lsm->id->name);
 		set_enabled(lsm, false);
 		return;
@@ -165,9 +175,9 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 
 	/* Mark the LSM as enabled. */
 	set_enabled(lsm, true);
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
 		init_debug("exclusive chosen:   %s\n", lsm->id->name);
-		exclusive = lsm;
+		lsm_exclusive = lsm;
 	}
 
 	/* Register the LSM blob sizes. */
@@ -226,7 +236,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	}
 
 	/* Process "security=", if given. */
-	if (chosen_major_lsm) {
+	if (lsm_order_legacy) {
 		struct lsm_info *major;
 
 		/*
@@ -237,10 +247,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		 */
 		lsm_for_each_raw(major) {
 			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			    strcmp(major->id->name, chosen_major_lsm) != 0) {
+			    strcmp(major->id->name, lsm_order_legacy) != 0) {
 				set_enabled(major, false);
 				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   chosen_major_lsm, major->id->name);
+					   lsm_order_legacy, major->id->name);
 			}
 		}
 	}
@@ -265,11 +275,11 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	}
 
 	/* Process "security=", if given. */
-	if (chosen_major_lsm) {
+	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
 			if (exists_ordered_lsm(lsm))
 				continue;
-			if (strcmp(lsm->id->name, chosen_major_lsm) == 0)
+			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
 				append_ordered_lsm(lsm, "security=");
 		}
 	}
@@ -301,15 +311,15 @@ static void __init lsm_init_ordered(void)
 	struct lsm_info **lsm;
 	struct lsm_info *early;
 
-	if (chosen_lsm_order) {
-		if (chosen_major_lsm) {
+	if (lsm_order_cmdline) {
+		if (lsm_order_legacy) {
 			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
-				chosen_major_lsm, chosen_lsm_order);
-			chosen_major_lsm = NULL;
+				lsm_order_legacy, lsm_order_cmdline);
+			lsm_order_legacy = NULL;
 		}
-		ordered_lsm_parse(chosen_lsm_order, "cmdline");
+		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
 	} else
-		ordered_lsm_parse(builtin_lsm_order, "builtin");
+		ordered_lsm_parse(lsm_order_builtin, "builtin");
 
 	lsm_order_for_each(lsm) {
 		lsm_prepare(*lsm);
@@ -473,9 +483,9 @@ int __init security_init(void)
 {
 	struct lsm_info *lsm;
 
-	init_debug("legacy security=%s\n", chosen_major_lsm ? : " *unspecified*");
-	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
-	init_debug("boot arg lsm=%s\n", chosen_lsm_order ? : " *unspecified*");
+	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
+	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
+	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
 
 	/*
 	 * Append the names of the early LSM modules now that kmalloc() is
-- 
2.50.1


