Return-Path: <linux-security-module+bounces-12493-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86251BEBBD1
	for <lists+linux-security-module@lfdr.de>; Fri, 17 Oct 2025 22:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFB819C710F
	for <lists+linux-security-module@lfdr.de>; Fri, 17 Oct 2025 20:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E99271441;
	Fri, 17 Oct 2025 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Wjxmixrb"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33807253956
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734152; cv=none; b=sGGuMepU2f7Gjs1Gb3cf+whmLji/f+0tq0soP0wZP8S+mMwWQ3xXpUKhp+hlNemurv8yQAlPGbBpdxsDciHrykmryw47Y20xMUfl0oXSLBP51qSmYsjHav2u3aT9sLwKp94pH4Sd5XgcKTffUQsXoByji0OvWpRFFh1t22S9CPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734152; c=relaxed/simple;
	bh=1c4n6HtJDdqC2fKKtAAQ4HuGj3ytXevRhgSdgXsKw9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD7P1tDBRoCH3Ep3xJJmQBcLsC6DRQ7xDa8UZOzbwIQ7oz0EtRcUpot8eYsKFRg25WUvSeIbFrwz24aXvjtXku+drWLLbQYg87r9/DCVHZumHIAFWcruPh9xHb+h63RXygYu2eOGLiYFf5KC8KOU2jwbZPXc4Ow5KjUwEqjwEBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Wjxmixrb; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-88f8e855b4eso201989685a.3
        for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734148; x=1761338948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljMZa0GwDl82RYjdEHNE/O8/cKSjuAH/npQsD2B0C1k=;
        b=Wjxmixrb277PgO07uS4O8Ncyy/IyQytPXahJrhcDUW/GsCCimm4+LUbTbJ21+uGOLB
         f39a+jIkP6hfxR4ud9Jg2BVX9Vi2YgYtAagD/d7VEG3oUCIElZqJYSNY4zP5KOrOVUZK
         k4BMqh+UmsvRkP0afXAHcbN++/Kbprm2rk29f4YDGUrf6dCMuLyzw/OLR/5fxwRGE7Gh
         gET/Da1ee0G9t2t2ibjVGF5RrWu+pfCSBQ6zkAJjVBJhhnaKENsCVAFFPcjCxjE91841
         UpBMCrtzEDY2KpYj1CtrKSp7sF+E3wxHuMvA/Q8E3PtqvyE/5CKKr255oNUbU8J30Ge1
         aA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734148; x=1761338948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljMZa0GwDl82RYjdEHNE/O8/cKSjuAH/npQsD2B0C1k=;
        b=UNo+OL+ABY9c/xxhswdoXN+mjRtbG5Hg8pe/6EnTOR3Dm5k5ybj0sA/MkWz5rmiCVQ
         YHI0qytyC6b6lBdvsbMRnjYRTXzpmPnO5x1JQgnk6l9ER8cIHSEgDp2cvqntOl8FuIew
         gcT65N5tBFXgA3mPFmLoOfhxXxbIAFbGy18AcvT9lboQeNNiNeZvs0Uu3D6q5a6DGUQd
         qonEzcmWJ0ZuUicQWB4QGzHVSbo1Mvgt2AAFM7ZkWqfFVHbsBVq4TO9MCwYC6rqXnlXA
         1eirQI0/NSkHfI7+784NNo7pCLUWxZ66cDWK8TxtjFq+hciDabxKbeyMyGTyY5C8EIKG
         Oi3Q==
X-Gm-Message-State: AOJu0YzeocmPstGGfX37GFojHBXOr+pwZKAslIizBMIqfYLaDEWL7eoV
	bTQhvPCMi3fQVAbmAJghqFDOULtnazICAaMLajV27U8T7NWybslRALBJMpTf2Y/G+EyKuot2l2b
	//Pb1ZQ==
X-Gm-Gg: ASbGncuEOCUUZikyjv71dsWUqPO5zeieiMyry9vYy1j7ZbWY3LYs6eefzRwViPvUDQp
	ABOV12MOvTMAZ7e02gAbjYZNJb4k+W6gpWH+8+z0sYmLFcW1PFiylT364U8jU0DVSApsPdoX+ZC
	q+whPV/df5U0reHIe9xK8sD/Ld2e9Hz/7uDczsS5dmcTmeSTR05/5gdOa3wVZBq1WMpi5czEq6i
	ab5BFwMC5Dxsih9T5/CL+rlOoqqHUH+1R8EshK38a10b0IfcWNzSF0HteBKN0QyMI5t5FaJBfxt
	nNty/z+gvwND9Txa6Dw5L2yIP2P7HO0MkKvVXDx+Eq0DASRhr7nZva1/IxKyamRzPoqfXI4QwnG
	N/w1twCzAvikvIR+WKghmCl//MVhUyaya9FeBZnSh2Gc3WLjGT2N6M2sJykYOynbVnTTVgdCBdL
	Mp7tDuXAvryhFFI7+BWLSVRm4nmND8yPCjyWq1AyXJTTP3UdtQuWm8vXYR
X-Google-Smtp-Source: AGHT+IHhzWyNHwMpoeOG9JHmS//B0vnVOftEBR8ayv9SBrvTL89azet5ERhRw45Rx+d1h+3BfIfn/g==
X-Received: by 2002:a05:620a:19a0:b0:85e:d345:a088 with SMTP id af79cd13be357-8906e8aff78mr659912585a.11.1760734147999;
        Fri, 17 Oct 2025 13:49:07 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf0af4aasm42716085a.39.2025.10.17.13.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:49:07 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 09/11] selinux: move initcalls to the LSM framework
Date: Fri, 17 Oct 2025 16:48:23 -0400
Message-ID: <20251017204815.505363-20-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10966; i=paul@paul-moore.com; h=from:subject; bh=1c4n6HtJDdqC2fKKtAAQ4HuGj3ytXevRhgSdgXsKw9c=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qupaUixE5dTbcqBiXZOom2ZJffz16u23bnXq lCQxktUgG2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrqQAKCRDqIPLalzeJ c0KlEADT3pKXLZoGNzEnmjZBlzuAs+3bNRtg1MZITasejMktmD8aNi0nvTFU84oBMA/dm0CfMyg tkoPC3b9HCxPjPIsg6MhSIpOceIJBlQMBh4ecpRkYhuDkDKXkwfWpAIyhSiHlDlLAEqJ6emSrVW Z7NKK98JvHPIHfkkBOIikmqsDy6KgYW63Di9jQ8/thWhdnRnfvxq4X5VWSqsME4Sw0yiZERjbnc GVHZ9Cg7AoDiYjkRoCCjzyKHrMuooGPS5i2Y500UDiL+zyHn7QEe3eWDLkYyrNlomuwuAktZ2KG HPYMWQgILcQ30elHsQ3RtH9UQ3qhdGsFa09y2H/QVth/6zN8ESCEaR6xRJNB3TtxdRYZCP8mdZS 6QlakfPi8y/1uRUjRNDFs8XtJAZAQ2A7oxo6RNu221YhmaxZeSCEp6DB8OPaoLpc40+oka+8nhb MDzr/lmdklawPiZau7SPeXRcnpi+U8IHcbv7K7PfEdoBQTJEieLQETW6gNiHZ1S8XUKzkZuYd2/ Hy0J2VJI0uQCmXJzpIN4xy6ooMNoJDXn3aq+RhGGSvpdpN9LmE8HyIrzI8r41jW8w3I8hkZuPed JMOh3q7REaoET/CQu6/D1K2nuJXFhMdI7YF6dctgqvEDctSTnEJH2wZmNjeK0PD+1g6bRVsm58c VnnPZgYLSYWqnvQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

SELinux currently has a number of initcalls so we've created a new
function, selinux_initcall(), which wraps all of these initcalls so
that we have a single initcall function that can be registered with the
LSM framework.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/Makefile            |  2 +-
 security/selinux/hooks.c             |  9 +++--
 security/selinux/ibpkey.c            |  5 ++-
 security/selinux/include/audit.h     |  9 +++++
 security/selinux/include/initcalls.h | 19 ++++++++++
 security/selinux/initcalls.c         | 52 ++++++++++++++++++++++++++++
 security/selinux/netif.c             |  5 ++-
 security/selinux/netlink.c           |  5 ++-
 security/selinux/netnode.c           |  5 ++-
 security/selinux/netport.c           |  5 ++-
 security/selinux/selinuxfs.c         |  5 ++-
 security/selinux/ss/services.c       | 26 ++++----------
 12 files changed, 107 insertions(+), 40 deletions(-)
 create mode 100644 security/selinux/include/initcalls.h
 create mode 100644 security/selinux/initcalls.c

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 66e56e9011df..72d3baf7900c 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -15,7 +15,7 @@ ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
 ccflags-$(CONFIG_SECURITY_SELINUX_DEBUG) += -DDEBUG
 
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-	     netnode.o netport.o status.o \
+	     netnode.o netport.o status.o initcalls.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
 	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/context.o
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 299b656ac007..cd5f6974f9e6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -94,6 +94,7 @@
 #include <linux/io_uring/cmd.h>
 #include <uapi/linux/lsm.h>
 
+#include "initcalls.h"
 #include "avc.h"
 #include "objsec.h"
 #include "netif.h"
@@ -7612,6 +7613,10 @@ static __init int selinux_init(void)
 	if (avc_add_callback(selinux_lsm_notifier_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC LSM notifier callback\n");
 
+	if (avc_add_callback(selinux_audit_rule_avc_callback,
+			     AVC_CALLBACK_RESET))
+		panic("SELinux: Unable to register AVC audit callback\n");
+
 	if (selinux_enforcing_boot)
 		pr_debug("SELinux:  Starting in enforcing mode\n");
 	else
@@ -7644,6 +7649,7 @@ DEFINE_LSM(selinux) = {
 	.enabled = &selinux_enabled_boot,
 	.blobs = &selinux_blob_sizes,
 	.init = selinux_init,
+	.initcall_device = selinux_initcall,
 };
 
 #if defined(CONFIG_NETFILTER)
@@ -7705,7 +7711,7 @@ static struct pernet_operations selinux_net_ops = {
 	.exit = selinux_nf_unregister,
 };
 
-static int __init selinux_nf_ip_init(void)
+int __init selinux_nf_ip_init(void)
 {
 	int err;
 
@@ -7720,5 +7726,4 @@ static int __init selinux_nf_ip_init(void)
 
 	return 0;
 }
-__initcall(selinux_nf_ip_init);
 #endif /* CONFIG_NETFILTER */
diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index 470481cfe0e8..ea1d9b2c7d2b 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -23,6 +23,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 
+#include "initcalls.h"
 #include "ibpkey.h"
 #include "objsec.h"
 
@@ -218,7 +219,7 @@ void sel_ib_pkey_flush(void)
 	spin_unlock_irqrestore(&sel_ib_pkey_lock, flags);
 }
 
-static __init int sel_ib_pkey_init(void)
+int __init sel_ib_pkey_init(void)
 {
 	int iter;
 
@@ -232,5 +233,3 @@ static __init int sel_ib_pkey_init(void)
 
 	return 0;
 }
-
-subsys_initcall(sel_ib_pkey_init);
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index d5b0425055e4..85a531ac737b 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -15,6 +15,15 @@
 #include <linux/audit.h>
 #include <linux/types.h>
 
+/**
+ * selinux_audit_rule_avc_callback - update the audit LSM rules on AVC events.
+ * @event: the AVC event
+ *
+ * Update any audit LSM rules based on the AVC event specified in @event.
+ * Returns 0 on success, negative values otherwise.
+ */
+int selinux_audit_rule_avc_callback(u32 event);
+
 /**
  * selinux_audit_rule_init - alloc/init an selinux audit rule structure.
  * @field: the field this rule refers to
diff --git a/security/selinux/include/initcalls.h b/security/selinux/include/initcalls.h
new file mode 100644
index 000000000000..6674cf489473
--- /dev/null
+++ b/security/selinux/include/initcalls.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SELinux initcalls
+ */
+
+#ifndef _SELINUX_INITCALLS_H
+#define _SELINUX_INITCALLS_H
+
+int init_sel_fs(void);
+int sel_netport_init(void);
+int sel_netnode_init(void);
+int sel_netif_init(void);
+int sel_netlink_init(void);
+int sel_ib_pkey_init(void);
+int selinux_nf_ip_init(void);
+
+int selinux_initcall(void);
+
+#endif
diff --git a/security/selinux/initcalls.c b/security/selinux/initcalls.c
new file mode 100644
index 000000000000..f6716a1d38c1
--- /dev/null
+++ b/security/selinux/initcalls.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SELinux initcalls
+ */
+
+#include <linux/init.h>
+
+#include "initcalls.h"
+
+/**
+ * selinux_initcall - Perform the SELinux initcalls
+ *
+ * Used as a device initcall in the SELinux LSM definition.
+ */
+int __init selinux_initcall(void)
+{
+	int rc = 0, rc_tmp = 0;
+
+	rc_tmp = init_sel_fs();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = sel_netport_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = sel_netnode_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = sel_netif_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = sel_netlink_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+#if defined(CONFIG_SECURITY_INFINIBAND)
+	rc_tmp = sel_ib_pkey_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+#endif
+
+#if defined(CONFIG_NETFILTER)
+	rc_tmp = selinux_nf_ip_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+#endif
+
+	return rc;
+}
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 78afbecdbe57..e24b2cba28ea 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -22,6 +22,7 @@
 #include <linux/rcupdate.h>
 #include <net/net_namespace.h>
 
+#include "initcalls.h"
 #include "security.h"
 #include "objsec.h"
 #include "netif.h"
@@ -265,7 +266,7 @@ static struct notifier_block sel_netif_netdev_notifier = {
 	.notifier_call = sel_netif_netdev_notifier_handler,
 };
 
-static __init int sel_netif_init(void)
+int __init sel_netif_init(void)
 {
 	int i;
 
@@ -280,5 +281,3 @@ static __init int sel_netif_init(void)
 	return 0;
 }
 
-__initcall(sel_netif_init);
-
diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 1760aee712fd..eb40e4603475 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -17,6 +17,7 @@
 #include <net/net_namespace.h>
 #include <net/netlink.h>
 
+#include "initcalls.h"
 #include "security.h"
 
 static struct sock *selnl __ro_after_init;
@@ -105,7 +106,7 @@ void selnl_notify_policyload(u32 seqno)
 	selnl_notify(SELNL_MSG_POLICYLOAD, &seqno);
 }
 
-static int __init selnl_init(void)
+int __init sel_netlink_init(void)
 {
 	struct netlink_kernel_cfg cfg = {
 		.groups	= SELNLGRP_MAX,
@@ -117,5 +118,3 @@ static int __init selnl_init(void)
 		panic("SELinux:  Cannot create netlink socket.");
 	return 0;
 }
-
-__initcall(selnl_init);
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 5d0ed08d46e5..9b3da5ce8d39 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -30,6 +30,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 
+#include "initcalls.h"
 #include "netnode.h"
 #include "objsec.h"
 
@@ -290,7 +291,7 @@ void sel_netnode_flush(void)
 	spin_unlock_bh(&sel_netnode_lock);
 }
 
-static __init int sel_netnode_init(void)
+int __init sel_netnode_init(void)
 {
 	int iter;
 
@@ -304,5 +305,3 @@ static __init int sel_netnode_init(void)
 
 	return 0;
 }
-
-__initcall(sel_netnode_init);
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 6fd7da4b3576..9e62f7285e81 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -29,6 +29,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 
+#include "initcalls.h"
 #include "netport.h"
 #include "objsec.h"
 
@@ -218,7 +219,7 @@ void sel_netport_flush(void)
 	spin_unlock_bh(&sel_netport_lock);
 }
 
-static __init int sel_netport_init(void)
+int __init sel_netport_init(void)
 {
 	int iter;
 
@@ -232,5 +233,3 @@ static __init int sel_netport_init(void)
 
 	return 0;
 }
-
-__initcall(sel_netport_init);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 232e087bce3e..93ea27acbfef 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -35,6 +35,7 @@
 /* selinuxfs pseudo filesystem for exporting the security policy API.
    Based on the proc code and the fs/nfsd/nfsctl.c code. */
 
+#include "initcalls.h"
 #include "flask.h"
 #include "avc.h"
 #include "avc_ss.h"
@@ -2122,7 +2123,7 @@ static struct file_system_type sel_fs_type = {
 
 struct path selinux_null __ro_after_init;
 
-static int __init init_sel_fs(void)
+int __init init_sel_fs(void)
 {
 	struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
 					  sizeof(NULL_FILE_NAME)-1);
@@ -2166,5 +2167,3 @@ static int __init init_sel_fs(void)
 
 	return err;
 }
-
-__initcall(init_sel_fs);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 713130bd43c4..13fc712d5923 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3570,6 +3570,13 @@ struct selinux_audit_rule {
 	struct context au_ctxt;
 };
 
+int selinux_audit_rule_avc_callback(u32 event)
+{
+	if (event == AVC_CALLBACK_RESET)
+		return audit_update_lsm_rules();
+	return 0;
+}
+
 void selinux_audit_rule_free(void *vrule)
 {
 	struct selinux_audit_rule *rule = vrule;
@@ -3820,25 +3827,6 @@ int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vru
 	return match;
 }
 
-static int aurule_avc_callback(u32 event)
-{
-	if (event == AVC_CALLBACK_RESET)
-		return audit_update_lsm_rules();
-	return 0;
-}
-
-static int __init aurule_init(void)
-{
-	int err;
-
-	err = avc_add_callback(aurule_avc_callback, AVC_CALLBACK_RESET);
-	if (err)
-		panic("avc_add_callback() failed, error %d\n", err);
-
-	return err;
-}
-__initcall(aurule_init);
-
 #ifdef CONFIG_NETLABEL
 /**
  * security_netlbl_cache_add - Add an entry to the NetLabel cache
-- 
2.51.1.dirty


