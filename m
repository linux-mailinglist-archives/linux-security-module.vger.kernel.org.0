Return-Path: <linux-security-module+bounces-7239-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE89F7593
	for <lists+linux-security-module@lfdr.de>; Thu, 19 Dec 2024 08:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7081707EE
	for <lists+linux-security-module@lfdr.de>; Thu, 19 Dec 2024 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04D614A630;
	Thu, 19 Dec 2024 07:31:56 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17439216E3D
	for <linux-security-module@vger.kernel.org>; Thu, 19 Dec 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593516; cv=none; b=fAeEwqFeS80I4GDJiWiEeXaKFxPjz6ab6IUxeuH1GPG6qaTJT5ftZ2Va16smR1v9+8H84Ln4+JrYJ6MdGiWOThKHNZ250Iqk03O1+LWMIMToAfybylUeC97TCJncPArn9aTni8CdYhjoJP1hB3WxU4aChv3RzKzJ/85mvGROT4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593516; c=relaxed/simple;
	bh=kv7H/2Fmdq5NzjHdH9WlL1ylasJJ18efPHXVIQWM2Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e8teMNomYuBALtdJ4WpjaFtPbFfV3O5VD9uWEWZ2kxsDfXcJ01nYpaCoLzFET5zC/7iC6+cLyxvxw4K+jEGErMIjHM1uTCZOfc9tfi9DqgWIlmRlBNVvCuYZ4xLMvAx7p42twvRXRjYaWfdxzaGZF6jK6tGVPgf6bAUNDDf+CoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0O-00088a-1R; Thu, 19 Dec 2024 08:31:32 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0L-004APv-2A;
	Thu, 19 Dec 2024 08:31:30 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0M-00GkbH-0r;
	Thu, 19 Dec 2024 08:31:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Thu, 19 Dec 2024 08:31:29 +0100
Subject: [PATCH 08/11] platform/chrome: cros_ec_lpc: prepare for
 hw_protection_shutdown removal
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-hw_protection-reboot-v1-8-263a0c1df802@pengutronix.de>
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
 kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org

In the general case, a driver doesn't know which of system shutdown or
reboot is the better action to take to protect hardware in an emergency
situation. For this reason, hw_protection_shutdown is going to be
removed in favor of hw_protection_trigger, which defaults to shutdown,
but may be configured at kernel runtime to be a reboot instead.

The ChromeOS EC situation is different as we do know that shutdown is
the correct action as the EC is programmed to force reset after the
short period, thus replace hw_protection_shutdown with
__hw_protection_trigger with HWPROT_ACT_SHUTDOWN as argument to
maintain the same behavior.

No functional change.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/platform/chrome/cros_ec_lpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 924bf4d3cc77b9f27d415a10c61ae06886fa7f80..068781b75529d80b51b3773845bcf457fa958710 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -414,7 +414,7 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 		blocking_notifier_call_chain(&ec_dev->panic_notifier, 0, ec_dev);
 		kobject_uevent_env(&ec_dev->dev->kobj, KOBJ_CHANGE, (char **)env);
 		/* Begin orderly shutdown. EC will force reset after a short period. */
-		hw_protection_shutdown("CrOS EC Panic", -1);
+		__hw_protection_trigger("CrOS EC Panic", -1, HWPROT_ACT_SHUTDOWN);
 		/* Do not query for other events after a panic is reported */
 		return;
 	}

-- 
2.39.5


