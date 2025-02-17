Return-Path: <linux-security-module+bounces-8212-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44331A38D82
	for <lists+linux-security-module@lfdr.de>; Mon, 17 Feb 2025 21:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8EC173BA2
	for <lists+linux-security-module@lfdr.de>; Mon, 17 Feb 2025 20:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE65A23F28F;
	Mon, 17 Feb 2025 20:40:50 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BC323F262
	for <linux-security-module@vger.kernel.org>; Mon, 17 Feb 2025 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824850; cv=none; b=BkQznqFMT+eyO7xwSIu/VzRt+qdOZG4UDduJs3BNyvjlBSm4xuc0we077lqCFvI8UgyANMr3EvCwf6/uh7+ynLgFTsyGTbziCzJKsfxX5r7XD/1oge1tJZT6ZTjn/QUCEKhl1/iwGslY0cWtViTfMIE0qzp414eLP4J7J5AiLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824850; c=relaxed/simple;
	bh=jLe5imhlTfSQ9SJacpu+JrReHBHI3E83Cv9BqUFVZfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l28yAJUH9pl8J1rWxktWNesA8v2xmWytlI4LdjY+gVZD5RTUrAX5BNDExf1G9GzWl1mXqY/ScUcMWuynSqpMAY/92YdVxRhScpzknU78Tu/npOCyghKQI+X/zhTiK4z5OJOKpqGwdy/90NP1zogkHfrmLDSccUEkjtf2S3OoOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uZ-0007oJ-CW; Mon, 17 Feb 2025 21:40:15 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uX-001TFy-30;
	Mon, 17 Feb 2025 21:40:13 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uX-000W9t-2S;
	Mon, 17 Feb 2025 21:40:13 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 17 Feb 2025 21:39:45 +0100
Subject: [PATCH v3 05/12] reboot: rename now misleading
 __hw_protection_shutdown symbols
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-hw_protection-reboot-v3-5-e1c09b090c0c@pengutronix.de>
References: <20250217-hw_protection-reboot-v3-0-e1c09b090c0c@pengutronix.de>
In-Reply-To: <20250217-hw_protection-reboot-v3-0-e1c09b090c0c@pengutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Fabio Estevam <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org, 
 chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
 kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org

The __hw_protection_shutdown function name has become misleading
since it can cause either a shutdown (poweroff) or a reboot
depending on its argument.

To avoid further confusion, let's rename it, so it doesn't suggest
that a poweroff is all it can do.

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 include/linux/reboot.h | 8 ++++----
 kernel/reboot.c        | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index e97f6b8e858685b4b527daa8920a31eabcf91622..53c64e31b3cfdcb6b6dfe4def45fbb40c29f5144 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -188,17 +188,17 @@ extern void orderly_reboot(void);
  */
 enum hw_protection_action { HWPROT_ACT_SHUTDOWN, HWPROT_ACT_REBOOT };
 
-void __hw_protection_shutdown(const char *reason, int ms_until_forced,
-			      enum hw_protection_action action);
+void __hw_protection_trigger(const char *reason, int ms_until_forced,
+			     enum hw_protection_action action);
 
 static inline void hw_protection_reboot(const char *reason, int ms_until_forced)
 {
-	__hw_protection_shutdown(reason, ms_until_forced, HWPROT_ACT_REBOOT);
+	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_REBOOT);
 }
 
 static inline void hw_protection_shutdown(const char *reason, int ms_until_forced)
 {
-	__hw_protection_shutdown(reason, ms_until_forced, HWPROT_ACT_SHUTDOWN);
+	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_SHUTDOWN);
 }
 
 /*
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 6185cfe5d4ee910daf057884a7ff8dcf1e80df28..c1f11d5e085e4d2fffc841a624c8b650aba276b8 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1008,7 +1008,7 @@ static void hw_failure_emergency_schedule(enum hw_protection_action action,
 }
 
 /**
- * __hw_protection_shutdown - Trigger an emergency system shutdown or reboot
+ * __hw_protection_trigger - Trigger an emergency system shutdown or reboot
  *
  * @reason:		Reason of emergency shutdown or reboot to be printed.
  * @ms_until_forced:	Time to wait for orderly shutdown or reboot before
@@ -1022,8 +1022,8 @@ static void hw_failure_emergency_schedule(enum hw_protection_action action,
  * pending even if the previous request has given a large timeout for forced
  * shutdown/reboot.
  */
-void __hw_protection_shutdown(const char *reason, int ms_until_forced,
-			      enum hw_protection_action action)
+void __hw_protection_trigger(const char *reason, int ms_until_forced,
+			     enum hw_protection_action action)
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
 
@@ -1043,7 +1043,7 @@ void __hw_protection_shutdown(const char *reason, int ms_until_forced,
 	else
 		orderly_poweroff(true);
 }
-EXPORT_SYMBOL_GPL(__hw_protection_shutdown);
+EXPORT_SYMBOL_GPL(__hw_protection_trigger);
 
 static int __init reboot_setup(char *str)
 {

-- 
2.39.5


