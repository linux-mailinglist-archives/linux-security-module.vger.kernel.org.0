Return-Path: <linux-security-module+bounces-7243-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE59F75BF
	for <lists+linux-security-module@lfdr.de>; Thu, 19 Dec 2024 08:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06BA188C14F
	for <lists+linux-security-module@lfdr.de>; Thu, 19 Dec 2024 07:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20228218849;
	Thu, 19 Dec 2024 07:32:21 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EE9218840
	for <linux-security-module@vger.kernel.org>; Thu, 19 Dec 2024 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593540; cv=none; b=q1FmPIN0iXnN8Eono6bkfs5CKD9eYcXKeG2j8gJq43n9LvSimCiIOibNgKIMwxoAsDKmCtpXpJDkwMSdFQnKw+rRqjkJrmzQ0Lev5IUqDsP0FRY9QXJI3M/+fkYGqDiv6hcl+AEcJ9qROevu0WCuXV148hkxqmgRAkO5uucPz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593540; c=relaxed/simple;
	bh=HHo8+7k6wjJQsKsAJamXMeH66rzfbDBe1zv14LpyGCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GSKROfyF0OuOeetgpk3B1HsB0OqDkAugg9T8GAEoczA7VF5uaSe81qjUMqs00sCAYJdht1lnH5auaVBox6V2mLOVyWjpUBg7DN8YvMzGJR2wjO5Iv2UmBm8Az2dKHXnm4IWMmwVeg2OLgpKIPbmL8HtlY4Hm2RauQ8evFdkGoAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0O-00088b-1Y; Thu, 19 Dec 2024 08:31:32 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0L-004APt-2B;
	Thu, 19 Dec 2024 08:31:30 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0M-00GkbH-0p;
	Thu, 19 Dec 2024 08:31:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Thu, 19 Dec 2024 08:31:27 +0100
Subject: [PATCH 06/11] reboot: add support for configuring emergency
 hardware protection action
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-hw_protection-reboot-v1-6-263a0c1df802@pengutronix.de>
References: <20241219-hw_protection-reboot-v1-0-263a0c1df802@pengutronix.de>
In-Reply-To: <20241219-hw_protection-reboot-v1-0-263a0c1df802@pengutronix.de>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
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
 kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Matteo Croce <mcroce@microsoft.com>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org

We currently leave the decision of whether to shutdown or reboot to
protect hardware in an emergency situation to the individual drivers.

This works out in some cases, where the driver detecting the critical
failure has inside knowledge: It binds to the system management controller
for example or is guided by hardware description that defines what to do.

In the general case, however, the driver detecting the issue can't know
what the appropriate course of action is and shouldn't be dictating the
policy of dealing with it.

Therefore, add a global hw_protection toggle that allows the user to
specify whether shutdown or reboot should be the default action when the
driver doesn't set policy.

This introduces no functional change yet as hw_protection_trigger() has
no callers, but these will be added in subsequent commits.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 Documentation/ABI/testing/sysfs-kernel-reboot   |  8 +++++
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++
 include/linux/reboot.h                          | 19 +++++++++-
 include/uapi/linux/capability.h                 |  1 +
 kernel/reboot.c                                 | 46 +++++++++++++++++++++++++
 5 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot b/Documentation/ABI/testing/sysfs-kernel-reboot
index 837330fb251134ffdf29cd68f0b2a845b088e5a0..133f54707d533665c68a5946394540ec50b149e5 100644
--- a/Documentation/ABI/testing/sysfs-kernel-reboot
+++ b/Documentation/ABI/testing/sysfs-kernel-reboot
@@ -30,3 +30,11 @@ KernelVersion:	5.11
 Contact:	Matteo Croce <mcroce@microsoft.com>
 Description:	Don't wait for any other CPUs on reboot and
 		avoid anything that could hang.
+
+What:		/sys/kernel/reboot/hw_protection
+Date:		Feb 2025
+KernelVersion:	6.14
+Contact:	Ahmad Fatoum <a.fatoum@pengutronix.de>
+Description:	Hardware protection action taken on critical events like
+		overtemperature or imminent voltage loss.
+		Valid values are: reboot shutdown
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3872bc6ec49d63772755504966ae70113f24a1db..ff244e6a0e04d2c172825818defd5d94448f8518 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1921,6 +1921,12 @@
 			which allow the hypervisor to 'idle' the guest
 			on lock contention.
 
+	hw_protection=	[HW]
+			Format: reboot | shutdown
+
+			Hardware protection action taken on critical events like
+			overtemperature or imminent voltage loss.
+
 	i2c_bus=	[HW]	Override the default board specific I2C bus speed
 				or register an additional I2C bus that is not
 				registered from board initialization code.
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index b1e2c86d29a281abbcfe69bc00321df185c32c91..281696f509932e444eadd453fb0233aa7a07fbce 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -178,11 +178,28 @@ void ctrl_alt_del(void);
 extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
 
-enum hw_protection_action { HWPROT_ACT_SHUTDOWN, HWPROT_ACT_REBOOT };
+enum hw_protection_action { HWPROT_ACT_DEFAULT, HWPROT_ACT_SHUTDOWN, HWPROT_ACT_REBOOT };
 
 void __hw_protection_trigger(const char *reason, int ms_until_forced,
 			     enum hw_protection_action action);
 
+/**
+ * hw_protection_trigger - Trigger default emergency system hardware protection action
+ *
+ * @reason:		Reason of emergency shutdown or reboot to be printed.
+ * @ms_until_forced:	Time to wait for orderly shutdown or reboot before
+ *			triggering it. Negative value disables the forced
+ *			shutdown or reboot.
+ *
+ * Initiate an emergency system shutdown or reboot in order to protect
+ * hardware from further damage. The exact action taken is controllable at
+ * runtime and defaults to shutdown.
+ */
+static inline void hw_protection_trigger(const char *reason, int ms_until_forced)
+{
+	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_DEFAULT);
+}
+
 static inline void hw_protection_reboot(const char *reason, int ms_until_forced)
 {
 	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_REBOOT);
diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 5bb9060986974726025eaabee24a0b720ff94657..2e21b5594f81313e8e17aeeb98a09f098355515f 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -275,6 +275,7 @@ struct vfs_ns_cap_data {
 /* Allow setting encryption key on loopback filesystem */
 /* Allow setting zone reclaim policy */
 /* Allow everything under CAP_BPF and CAP_PERFMON for backward compatibility */
+/* Allow setting hardware protection emergency action */
 
 #define CAP_SYS_ADMIN        21
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index aa6317939af41c9730ec5a74b7faf03f7c0f25a7..08e7e5f00308ae66120688b83771a1b7fc8403cb 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -36,6 +36,8 @@ enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
 EXPORT_SYMBOL_GPL(reboot_mode);
 enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
 
+static enum hw_protection_action hw_protection_action = HWPROT_ACT_SHUTDOWN;
+
 /*
  * This variable is used privately to keep track of whether or not
  * reboot_type is still set to its default value (i.e., reboot= hasn't
@@ -1023,6 +1025,9 @@ void __hw_protection_trigger(const char *reason, int ms_until_forced,
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
 
+	if (action == HWPROT_ACT_DEFAULT)
+		action = hw_protection_action;
+
 	pr_emerg("HARDWARE PROTECTION %s (%s)\n",
 		 hw_protection_action_str(action), reason);
 
@@ -1042,6 +1047,46 @@ void __hw_protection_trigger(const char *reason, int ms_until_forced,
 }
 EXPORT_SYMBOL_GPL(__hw_protection_trigger);
 
+static bool hw_protection_action_parse(const char *str,
+				       enum hw_protection_action *action)
+{
+	if (sysfs_streq(str, "shutdown"))
+		*action = HWPROT_ACT_SHUTDOWN;
+	else if (sysfs_streq(str, "reboot"))
+		*action = HWPROT_ACT_REBOOT;
+	else
+		return false;
+
+	return true;
+}
+
+static int __init hw_protection_setup(char *str)
+{
+	hw_protection_action_parse(str, &hw_protection_action);
+	return 1;
+}
+__setup("hw_protection=", hw_protection_setup);
+
+static ssize_t hw_protection_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			  hw_protection_action_str(hw_protection_action));
+}
+static ssize_t hw_protection_store(struct kobject *kobj,
+				   struct kobj_attribute *attr, const char *buf,
+				   size_t count)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!hw_protection_action_parse(buf, &hw_protection_action))
+		return -EINVAL;
+
+	return count;
+}
+static struct kobj_attribute hw_protection_attr = __ATTR_RW(hw_protection);
+
 static int __init reboot_setup(char *str)
 {
 	for (;;) {
@@ -1301,6 +1346,7 @@ static struct kobj_attribute reboot_cpu_attr = __ATTR_RW(cpu);
 #endif
 
 static struct attribute *reboot_attrs[] = {
+	&hw_protection_attr.attr,
 	&reboot_mode_attr.attr,
 #ifdef CONFIG_X86
 	&reboot_force_attr.attr,

-- 
2.39.5


