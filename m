Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCEB04F287
	for <lists+linux-security-module@lfdr.de>; Sat, 22 Jun 2019 02:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfFVAGS (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Jun 2019 20:06:18 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37971 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfFVAEu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:50 -0400
Received: by mail-pg1-f201.google.com with SMTP id 21so4999344pgl.5
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 17:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DcYA884YGcGGdCYTloo9C5D9P2JdZYIZcuEODFPPdyE=;
        b=FpAHE5nRtiq8twPnU2FiA6jLImIS9YqBG0kkzIsrD6OMZiYkZhbmyWygj1lEcLXZZ+
         yhPzB8BSVUrcxee0v1jTxwyQ+nDZsbbYuryXRtruDeoXjlY+p0iYOpq7nKjz9aZ0qq/p
         /O2JfwU8M+jWw2Z9YuevmCs/eS4sN2vfFq0jaX0aCGRgjNzl5lcYsGj/jofyaP4CDRBt
         0bN/jvJwoS9wJWP3S5dhVrX0L2iP0Ds82S3TrvG0hfHn3FJuvD905D7I/fQBcx2+B0Aa
         273VlHuxdXiojhQkEa6oLg1y3gOOQCYo8Ldrh1xgfRjUEcXzF02eN6AaKuUrFSY255is
         9IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DcYA884YGcGGdCYTloo9C5D9P2JdZYIZcuEODFPPdyE=;
        b=fS0zQFGTn/fVFrCuEmah9cG/OZ7SbMyEVJMtXkf0y4lGqRhC6qfEmeaRORIOAwoPFb
         TURj7MuxZeWm33mJNhUbYbOijDgeFJqy44ZLVaGKiPWeAfx9rCNxrsWxay4xLpiDXDGu
         hURs48L4yi8ng7egwgg/WTkaC5piSP4HAdndZ10/l8X/yRlyesXLwsri7AJ/zq4uM27i
         +Mq01JyrMzIh7hycTEpPsCjD+jPEHPIpoGh0qLfVqHddiQUbM1vQirBkGffLu+0Br+xF
         YKqzV8BzPWDSsf0hfvpYSlGl1blQpKmvH9LQgTQ+EyUwYKL0+W6vXp6PduN9p5Alczox
         Cz7w==
X-Gm-Message-State: APjAAAWftiPCvbT1Ky1Z1t4/0XZVoEaeawbQtKpsiah//dNnl767jhAl
        8hyVLnI1zSPloR4eFoSSoanIuXa1zLkcdxnHSetm2Q==
X-Google-Smtp-Source: APXvYqwnynpKqdK3Eq/xy1g7CilbIDHxC9Vh45kR566G/Sw5s9erByxy4tBBT/h8oYqEIaaSCkzkuhqgBVwmIC7LYGatZg==
X-Received: by 2002:a63:5152:: with SMTP id r18mr20149468pgl.94.1561161889779;
 Fri, 21 Jun 2019 17:04:49 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:48 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-20-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Provided an annotation for module parameters that specify hardware
parameters (such as io ports, iomem addresses, irqs, dma channels, fixed
dma buffers and other types).

Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/linux/security.h     |  1 +
 kernel/params.c              | 27 ++++++++++++++++++++++-----
 security/lockdown/lockdown.c |  1 +
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 61e3f4a62d16..88064d7f6827 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -92,6 +92,7 @@ enum lockdown_reason {
 	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
+	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/params.c b/kernel/params.c
index ce89f757e6da..f94fe79e331d 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
+#include <linux/security.h>
 
 #ifdef CONFIG_SYSFS
 /* Protects all built-in parameters, modules use their own param_lock */
@@ -108,13 +109,19 @@ bool parameq(const char *a, const char *b)
 	return parameqn(a, b, strlen(a)+1);
 }
 
-static void param_check_unsafe(const struct kernel_param *kp)
+static bool param_check_unsafe(const struct kernel_param *kp,
+			       const char *doing)
 {
 	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
 		pr_notice("Setting dangerous option %s - tainting kernel\n",
 			  kp->name);
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 	}
+
+	if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
+	    security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
+		return false;
+	return true;
 }
 
 static int parse_one(char *param,
@@ -144,8 +151,10 @@ static int parse_one(char *param,
 			pr_debug("handling %s with %p\n", param,
 				params[i].ops->set);
 			kernel_param_lock(params[i].mod);
-			param_check_unsafe(&params[i]);
-			err = params[i].ops->set(val, &params[i]);
+			if (param_check_unsafe(&params[i], doing))
+				err = params[i].ops->set(val, &params[i]);
+			else
+				err = -EPERM;
 			kernel_param_unlock(params[i].mod);
 			return err;
 		}
@@ -553,6 +562,12 @@ static ssize_t param_attr_show(struct module_attribute *mattr,
 	return count;
 }
 
+#ifdef CONFIG_MODULES
+#define mod_name(mod) (mod)->name
+#else
+#define mod_name(mod) "unknown"
+#endif
+
 /* sysfs always hands a nul-terminated string in buf.  We rely on that. */
 static ssize_t param_attr_store(struct module_attribute *mattr,
 				struct module_kobject *mk,
@@ -565,8 +580,10 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
 		return -EPERM;
 
 	kernel_param_lock(mk->mod);
-	param_check_unsafe(attribute->param);
-	err = attribute->param->ops->set(buf, attribute->param);
+	if (param_check_unsafe(attribute->param, mod_name(mk->mod)))
+		err = attribute->param->ops->set(buf, attribute->param);
+	else
+		err = -EPERM;
 	kernel_param_unlock(mk->mod);
 	if (!err)
 		return len;
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index c89046dc2155..d03c4c296af7 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -28,6 +28,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
+	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

