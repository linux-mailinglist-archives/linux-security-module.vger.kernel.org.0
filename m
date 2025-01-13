Return-Path: <linux-security-module+bounces-7661-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EEEA0BD65
	for <lists+linux-security-module@lfdr.de>; Mon, 13 Jan 2025 17:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCEA16B051
	for <lists+linux-security-module@lfdr.de>; Mon, 13 Jan 2025 16:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2258C20F072;
	Mon, 13 Jan 2025 16:26:12 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30022DF9A
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785572; cv=none; b=T4TNWy859q7yEMZeGWMDi3I8xKZUrB0EAxYhXC+45khluEcNNs3RAp0rRbl8UnthkzOgkqpEwk3y3vc5z9wkBCwbvgr76gpDIgoZbxycT0IddxJBRtY8Rbg1ARNsdaTrhvj/vW8t1YliLfzhlSQmwnrYwJoQ50b7zD2aKuTfD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785572; c=relaxed/simple;
	bh=EuoB+euzgKq+AAXeLe3xU+V6jWQoQHPUoS6V+MJxjNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5t6xbtFhElQKAAUu0PRo3CvBk/U93We+G3xnRgFAeYmNY/gAfMmhgTHpcxzNLTdwrpR4wOm8lcUvOB8t263gZLmro0Ut/5X7KRKiDSE/nGJKfmzWnzKScXy9n+OQ4O8iuxbtzwyG7ifRYpWHzL6Rn/oY5O48GMBoDVXY3lbneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNFs-0000JG-8B; Mon, 13 Jan 2025 17:25:32 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNFp-000HzF-2d;
	Mon, 13 Jan 2025 17:25:30 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNFq-007FQL-2u;
	Mon, 13 Jan 2025 17:25:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 13 Jan 2025 17:25:26 +0100
Subject: [PATCH v2 01/12] reboot: replace __hw_protection_shutdown bool
 action parameter with an enum
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-hw_protection-reboot-v2-1-161d3fc734f0@pengutronix.de>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
In-Reply-To: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
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

Currently __hw_protection_shutdown() either reboots or shuts down the
system according to its shutdown argument.

To make the logic easier to follow, both inside __hw_protection_shutdown
and at caller sites, lets replace the bool parameter with an enum.

This will be extra useful, when in a later commit, a third action is
added to the enumeration.

No functional change.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 include/linux/reboot.h | 18 +++++++++++++++---
 kernel/reboot.c        | 14 ++++++--------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index abcdde4df697969a8027bcb052efc00daabbbf6a..e97f6b8e858685b4b527daa8920a31eabcf91622 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -177,16 +177,28 @@ void ctrl_alt_del(void);
 
 extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
-void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown);
+
+/**
+ * enum hw_protection_action - Hardware protection action
+ *
+ * @HWPROT_ACT_SHUTDOWN:
+ *	The system should be shut down (powered off) for HW protection.
+ * @HWPROT_ACT_REBOOT:
+ *	The system should be rebooted for HW protection.
+ */
+enum hw_protection_action { HWPROT_ACT_SHUTDOWN, HWPROT_ACT_REBOOT };
+
+void __hw_protection_shutdown(const char *reason, int ms_until_forced,
+			      enum hw_protection_action action);
 
 static inline void hw_protection_reboot(const char *reason, int ms_until_forced)
 {
-	__hw_protection_shutdown(reason, ms_until_forced, false);
+	__hw_protection_shutdown(reason, ms_until_forced, HWPROT_ACT_REBOOT);
 }
 
 static inline void hw_protection_shutdown(const char *reason, int ms_until_forced)
 {
-	__hw_protection_shutdown(reason, ms_until_forced, true);
+	__hw_protection_shutdown(reason, ms_until_forced, HWPROT_ACT_SHUTDOWN);
 }
 
 /*
diff --git a/kernel/reboot.c b/kernel/reboot.c
index a701000bab3470df28665e8c9591cd82a033c6c2..847ac5d17a659981c6765699eac323f5e87f48c1 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -983,10 +983,7 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
  * @ms_until_forced:	Time to wait for orderly shutdown or reboot before
  *			triggering it. Negative value disables the forced
  *			shutdown or reboot.
- * @shutdown:		If true, indicates that a shutdown will happen
- *			after the critical tempeature is reached.
- *			If false, indicates that a reboot will happen
- *			after the critical tempeature is reached.
+ * @action:		The hardware protection action to be taken.
  *
  * Initiate an emergency system shutdown or reboot in order to protect
  * hardware from further damage. Usage examples include a thermal protection.
@@ -994,7 +991,8 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
  * pending even if the previous request has given a large timeout for forced
  * shutdown/reboot.
  */
-void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown)
+void __hw_protection_shutdown(const char *reason, int ms_until_forced,
+			      enum hw_protection_action action)
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
 
@@ -1009,10 +1007,10 @@ void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shut
 	 * orderly_poweroff failure
 	 */
 	hw_failure_emergency_poweroff(ms_until_forced);
-	if (shutdown)
-		orderly_poweroff(true);
-	else
+	if (action == HWPROT_ACT_REBOOT)
 		orderly_reboot();
+	else
+		orderly_poweroff(true);
 }
 EXPORT_SYMBOL_GPL(__hw_protection_shutdown);
 

-- 
2.39.5


