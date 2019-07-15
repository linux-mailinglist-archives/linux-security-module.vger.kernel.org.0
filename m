Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6CBC69C3B
	for <lists+linux-security-module@lfdr.de>; Mon, 15 Jul 2019 22:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfGOUC1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 15 Jul 2019 16:02:27 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37968 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732326AbfGOUAU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:20 -0400
Received: by mail-pg1-f202.google.com with SMTP id w5so11104869pgs.5
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7Fsa5djs+VQ2BrQJC+FUs9YwCCHQQfjCNM9PGrMIw+A=;
        b=cJ58uU0XE/YKJRyI5Mt8XS66fhl7mlr/5SBCN06rI3kOZahs9sJMcXx2ibpLoUVCaE
         9N1NY7OgxzhRPwe9rAJ9sX1BJ0ihRRRL3eB1ATlWoL9AgojAMGNFU+IEzasvl9Qi8eeC
         ZkFc3LVDfGlr7B4KL2h2Fk7rzQRbQLG0fV2EprbbLhYAb3pInpVl0C4tpIWrC5ke1CaF
         8SpfsbNg0HaA8UNxyOZPyFO9oH7pXi6W4xurmmtxgY7D5fmX5k+NL4JCD8shTiLjN3Q2
         SXoPSH4JASf5Jv9Der3AxoWSuW+W9hMxss6p61KH1/LToqcS5HgvobYgH+qD2KX+O9I0
         NjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7Fsa5djs+VQ2BrQJC+FUs9YwCCHQQfjCNM9PGrMIw+A=;
        b=sSNdyaHB58jcg9m0fGWaJfjnW6s6FEBP2DM+cmgbyRPOlwq/6S0csf8iz4xlYEpeIw
         Pwmad5iJWhr21viqBTXLHDmoziDQ6jCOx3N65nuDwMp9XoMXniF28QUCEuTgkPpIQ8hp
         Eqg/180Pf+n4/AAREOf4b7QFzjGsYP1P0giAsVbKzCby/O+LdIymq6furzFjYAeg3UjN
         3TmPIQvNCeuE9ZNEk2RBVpF2RRylRbfKHxHVz/uxbprUDWVajFIlZbExmtUdeUnckN9b
         XbAwo2VNs1xciSQG/KF/zKkgLx1inD/PqNnE6D2guafhq3I5Oa6V7FN0HwnjGwihMdGW
         V5mA==
X-Gm-Message-State: APjAAAVRBD6Nwnq7NgNQMeQaZSaaSgTTBoUceK5IQTOkxp28aqmTTatX
        nUNBs7EjSZ7b/5SPrSVK6Ka08BSWwTwN3myP/ZhAFA==
X-Google-Smtp-Source: APXvYqwVtJa9IPgk7H5zDUOO19rxBXwa1dInRZDEXWO7Uz1DWQaii5wotdUMuZXkJSevrN+xH8Yzo5reUPeuqmqn92YMUQ==
X-Received: by 2002:a63:f857:: with SMTP id v23mr3963600pgj.228.1563220820065;
 Mon, 15 Jul 2019 13:00:20 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:27 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 10/29] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, rjw@rjwysocki.net,
        pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Josh Boyer <jwboyer@fedoraproject.org>

There is currently no way to verify the resume image when returning
from hibernate.  This might compromise the signed modules trust model,
so until we can work with signed hibernate images we disable it when the
kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: rjw@rjwysocki.net
Cc: pavel@ucw.cz
cc: linux-pm@vger.kernel.org
---
 include/linux/security.h     | 1 +
 kernel/power/hibernate.c     | 3 ++-
 security/lockdown/lockdown.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 69c5de539e9a..304a155a5628 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -106,6 +106,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_KEXEC,
+	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index cd7434e6000d..3c0a5a8170b0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -30,6 +30,7 @@
 #include <linux/ctype.h>
 #include <linux/genhd.h>
 #include <linux/ktime.h>
+#include <linux/security.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -68,7 +69,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
 }
 
 /**
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 6f302c156bc8..a0996f75629f 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -21,6 +21,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
+	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

