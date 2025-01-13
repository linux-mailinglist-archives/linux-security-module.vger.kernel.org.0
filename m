Return-Path: <linux-security-module+bounces-7656-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4139FA0BD4A
	for <lists+linux-security-module@lfdr.de>; Mon, 13 Jan 2025 17:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08513AAD98
	for <lists+linux-security-module@lfdr.de>; Mon, 13 Jan 2025 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4392297EA;
	Mon, 13 Jan 2025 16:26:02 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400420459B
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785562; cv=none; b=jXbspJ6xbmOZ2feVQ0R8xnsMagdvaTXWnN+ip0LQH4lxZQQR0RNmRKtK+k6kI5RuTUgYlAQjzFbPqgQmH8Q74XWIIXIAUI/VP4yx4zfl6Jjuw31hOs2z/GTsB1APB3EATLU8ZhQ2fk9/4r2f/+J3FPkeDZ/U15TukMWxXcvCd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785562; c=relaxed/simple;
	bh=Rd12b/OfYLsFT9Z0L+47eIYuJ58fKJa/sUCAw8DVwzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KWdaYWYRflEjHGiuKKqbnD0gO66K0KcRVgtpcLLUfDbemG249aUuKBBX0PaVqxX+87GaU1BGovcsJ1x2HXkl5C2YxtKGGaIVsB52bQsZIR+ylpoM6qquMT3MpsEVmolcm/e1VHQq1FWBcLgHMY3jgtasfECDiBEV++zeCj4aZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNFs-0000JF-8B; Mon, 13 Jan 2025 17:25:32 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNFp-000HzG-2c;
	Mon, 13 Jan 2025 17:25:30 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNFq-007FQL-2v;
	Mon, 13 Jan 2025 17:25:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 13 Jan 2025 17:25:27 +0100
Subject: [PATCH v2 02/12] reboot: reboot, not shutdown, on
 hw_protection_reboot timeout
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-hw_protection-reboot-v2-2-161d3fc734f0@pengutronix.de>
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

hw_protection_shutdown() will kick off an orderly shutdown and if that
takes longer than a configurable amount of time, an emergency shutdown
will occur.

Recently, hw_protection_reboot() was added for those systems that don't
implement a proper shutdown and are better served by rebooting and
having the boot firmware worry about doing something about the critical
condition.

On timeout of the orderly reboot of hw_protection_reboot(), the system
would go into shutdown, instead of reboot. This is not a good idea, as
going into shutdown was explicitly not asked for.

Fix this by always doing an emergency reboot if hw_protection_reboot()
is called and the orderly reboot takes too long.

Fixes: 79fa723ba84c ("reboot: Introduce thermal_zone_device_critical_reboot()")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 kernel/reboot.c | 70 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 847ac5d17a659981c6765699eac323f5e87f48c1..222b63dfd31020d0e2bc1b1402dbfa82adc71990 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -932,48 +932,76 @@ void orderly_reboot(void)
 }
 EXPORT_SYMBOL_GPL(orderly_reboot);
 
+static const char *hw_protection_action_str(enum hw_protection_action action)
+{
+	switch (action) {
+	case HWPROT_ACT_SHUTDOWN:
+		return "shutdown";
+	case HWPROT_ACT_REBOOT:
+		return "reboot";
+	default:
+		return "undefined";
+	}
+}
+
+static enum hw_protection_action hw_failure_emergency_action;
+
 /**
- * hw_failure_emergency_poweroff_func - emergency poweroff work after a known delay
- * @work: work_struct associated with the emergency poweroff function
+ * hw_failure_emergency_action_func - emergency action work after a known delay
+ * @work: work_struct associated with the emergency action function
  *
  * This function is called in very critical situations to force
- * a kernel poweroff after a configurable timeout value.
+ * a kernel poweroff or reboot after a configurable timeout value.
  */
-static void hw_failure_emergency_poweroff_func(struct work_struct *work)
+static void hw_failure_emergency_action_func(struct work_struct *work)
 {
+	const char *action_str = hw_protection_action_str(hw_failure_emergency_action);
+
+	pr_emerg("Hardware protection timed-out. Trying forced %s\n",
+		 action_str);
+
 	/*
-	 * We have reached here after the emergency shutdown waiting period has
-	 * expired. This means orderly_poweroff has not been able to shut off
-	 * the system for some reason.
+	 * We have reached here after the emergency action waiting period has
+	 * expired. This means orderly_poweroff/reboot has not been able to
+	 * shut off the system for some reason.
 	 *
-	 * Try to shut down the system immediately using kernel_power_off
-	 * if populated
+	 * Try to shut off the system immediately if possible
 	 */
-	pr_emerg("Hardware protection timed-out. Trying forced poweroff\n");
-	kernel_power_off();
+
+	if (hw_failure_emergency_action == HWPROT_ACT_REBOOT)
+		kernel_restart(NULL);
+	else
+		kernel_power_off();
 
 	/*
 	 * Worst of the worst case trigger emergency restart
 	 */
-	pr_emerg("Hardware protection shutdown failed. Trying emergency restart\n");
+	pr_emerg("Hardware protection %s failed. Trying emergency restart\n",
+		 action_str);
 	emergency_restart();
 }
 
-static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
-			    hw_failure_emergency_poweroff_func);
+static DECLARE_DELAYED_WORK(hw_failure_emergency_action_work,
+			    hw_failure_emergency_action_func);
 
 /**
- * hw_failure_emergency_poweroff - Trigger an emergency system poweroff
+ * hw_failure_emergency_schedule - Schedule an emergency system shutdown or reboot
+ *
+ * @action:		The hardware protection action to be taken
+ * @action_delay_ms:	Time in milliseconds to elapse before triggering action
  *
  * This may be called from any critical situation to trigger a system shutdown
- * after a given period of time. If time is negative this is not scheduled.
+ * or reboot after a given period of time.
+ * If time is negative this is not scheduled.
  */
-static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
+static void hw_failure_emergency_schedule(enum hw_protection_action action,
+					  int action_delay_ms)
 {
-	if (poweroff_delay_ms <= 0)
+	if (action_delay_ms <= 0)
 		return;
-	schedule_delayed_work(&hw_failure_emergency_poweroff_work,
-			      msecs_to_jiffies(poweroff_delay_ms));
+	hw_failure_emergency_action = action;
+	schedule_delayed_work(&hw_failure_emergency_action_work,
+			      msecs_to_jiffies(action_delay_ms));
 }
 
 /**
@@ -1006,7 +1034,7 @@ void __hw_protection_shutdown(const char *reason, int ms_until_forced,
 	 * Queue a backup emergency shutdown in the event of
 	 * orderly_poweroff failure
 	 */
-	hw_failure_emergency_poweroff(ms_until_forced);
+	hw_failure_emergency_schedule(action, ms_until_forced);
 	if (action == HWPROT_ACT_REBOOT)
 		orderly_reboot();
 	else

-- 
2.39.5


