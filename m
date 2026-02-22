Return-Path: <linux-security-module+bounces-14799-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCgXHQp4m2mzzwMAu9opvQ
	(envelope-from <linux-security-module+bounces-14799-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Sun, 22 Feb 2026 22:41:30 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE21707DC
	for <lists+linux-security-module@lfdr.de>; Sun, 22 Feb 2026 22:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F072300C928
	for <lists+linux-security-module@lfdr.de>; Sun, 22 Feb 2026 21:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC401DF26E;
	Sun, 22 Feb 2026 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oOMtkEVs"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653A13959D
	for <linux-security-module@vger.kernel.org>; Sun, 22 Feb 2026 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771796486; cv=none; b=mylkSMQJNe4VsbKYo4XxDA0XI3D5w+Ea8Ml8vIJY70M1qMTY2Ae0S0jkz7rTjQPwaCjQ60rJekyhnSNnnrNHAJOeWUUiKfM4IYrmOYL2DbyX9u5Rsw82vqE3np1bLDwu9knoJkZX6VphmWZpLKm1AuxNSGf/YZVt58r3blwEgMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771796486; c=relaxed/simple;
	bh=QsI4XWyfbNPl2TR7zuCFAW8X0hg37Pap+xh0XUV+nhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ItvoYHBvb7cjXjvigOULHiGRw4YlAjvLFJ51ThCheYQyCsGmVGj9iyooYj2h7D93BhqsqdkSusQlnVqFYYUhyZFq+5NRYc18WiHyTc4M4bo5p26EJhvB6rr3qYyyZd1Py8qXZt1DsgkmZ4+AZpsPkoqh7AU16suxA9T27XXurZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oOMtkEVs; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771796482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ftjcldOq8ddwZ7u0CmQgCS1W91p4gLDwJoYZUDG8ITU=;
	b=oOMtkEVs08Z2ME3ibo3IqIHxxpKZzP18QxoQbM/mfGYB2X2JFCb5eCEQD9Wx5sX11FKCvo
	stD66XiktANh0AXmr2Y26SmJ/4hKK6XF7EWrOIcBjN74QbTVDbKGnqjvAI9Y4JfpWxgO56
	yU6AUwQ18Ki5RLG2vcVfBrI0nOVRnWA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Use sysfs_emit in param_get_{audit,mode}
Date: Sun, 22 Feb 2026 22:40:38 +0100
Message-ID: <20260222214038.287814-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14799-lists,linux-security-module=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-security-module@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-security-module];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2AE21707DC
X-Rspamd-Action: no action

Replace sprintf() with sysfs_emit() in param_get_audit() and
param_get_mode(). sysfs_emit() is preferred for formatting sysfs output
because it provides safer bounds checking.  Add terminating newlines as
suggested by checkpatch.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/lsm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index a87cd60ed206..1250192f7b12 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -17,6 +17,7 @@
 #include <linux/ptrace.h>
 #include <linux/ctype.h>
 #include <linux/sysctl.h>
+#include <linux/sysfs.h>
 #include <linux/audit.h>
 #include <linux/user_namespace.h>
 #include <linux/netfilter_ipv4.h>
@@ -2081,7 +2082,7 @@ static int param_get_audit(char *buffer, const struct kernel_param *kp)
 		return -EINVAL;
 	if (apparmor_initialized && !aa_current_policy_view_capable(NULL))
 		return -EPERM;
-	return sprintf(buffer, "%s", audit_mode_names[aa_g_audit]);
+	return sysfs_emit(buffer, "%s\n", audit_mode_names[aa_g_audit]);
 }
 
 static int param_set_audit(const char *val, const struct kernel_param *kp)
@@ -2109,8 +2110,7 @@ static int param_get_mode(char *buffer, const struct kernel_param *kp)
 		return -EINVAL;
 	if (apparmor_initialized && !aa_current_policy_view_capable(NULL))
 		return -EPERM;
-
-	return sprintf(buffer, "%s", aa_profile_mode_names[aa_g_profile_mode]);
+	return sysfs_emit(buffer, "%s\n", aa_profile_mode_names[aa_g_profile_mode]);
 }
 
 static int param_set_mode(const char *val, const struct kernel_param *kp)
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


