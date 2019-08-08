Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA7885700
	for <lists+linux-security-module@lfdr.de>; Thu,  8 Aug 2019 02:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbfHHAIW (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 7 Aug 2019 20:08:22 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:40202 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389718AbfHHAIW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Aug 2019 20:08:22 -0400
Received: by mail-pf1-f201.google.com with SMTP id z1so57778437pfb.7
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2019 17:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XvMhL8IcfVDNreN9SwFKf8wrtWYtjyv1vRVRyj1buwk=;
        b=HhBc/gmEGq9rH8H9Yq7YuOCen9MVhHMdBqBOMWU3Q65ZmLrnOZ9UKrPBXABdy6tda3
         NnNwaUOFThXg5oOVcQzkAJ/xxxjcN5JMq9CqDUPO2sDMZ8FNR1Q1zkXCBDWpSOUeod0Q
         vATHT/TvRKsVkPNVnc6tV69fAaYgmR2kBe4v+mgabDqLFDyev2sCdM0qP3NMPu5hYstI
         MmokyePTXsDro7+ZAfnN/vLnRCReaAzHb3v5fNkdWC9ZqE7L3PblQMPpeQV2oPud/IT1
         RtBEAbEWkJG+qXkhdjneV/Jl/vt+s8JsI6FhaqvASmoF0EWkkx+5i/rt8vS60Yx9qLkr
         igwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XvMhL8IcfVDNreN9SwFKf8wrtWYtjyv1vRVRyj1buwk=;
        b=PP7xJz4x05yEXXZLyjY5IsOW0hXY41vLEoa6KEDHgRXFG9Xji5defvqDT+VuR80AiU
         T4qe3sMwxo/jYNfzs3ghs9yxZzB4KcGdT93IMU4jjT6DYa08QVlhRdXDb6DBXUxDkQwI
         pARp0Tp39ehBVsKw0ccN+PgBwVhsfjU9DmA9fmuqGPh7JdndVJc8xj3Tu+7nANngIKXr
         5DTah2W3XPuQXR9t16MmtJWlePJcqqAez+FjcIcA2v0HU5d9tHtRWkmhWumFRSMDmNpp
         yjkMJ5kdBrD9rFijc2ruBvLG19rsLQvrJmaqnBhdIcxH4TC6kstzzMia596VjIoV0us9
         dQKw==
X-Gm-Message-State: APjAAAUREQNDjI3Ak5VninuK4zVjGSR/e8eg/MwbbpqoGnsqK9VYdKXz
        Tpa5HsPvEAMXTksDgVEWORvmjIHXcOZUTMWP6UzCuQ==
X-Google-Smtp-Source: APXvYqx+qmAKcKk0a1rigy0mGW/jFtJKbTr+As6X1fGIkQFzfR2B2pknokZ+peJUrAuDgc6I1TJXkyGlPPd7Xo42Pmd4tA==
X-Received: by 2002:a63:c0d:: with SMTP id b13mr9962668pgl.420.1565222901118;
 Wed, 07 Aug 2019 17:08:21 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:14 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 22/29] Lock down tracing and perf kprobes when in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Disallow the creation of perf and ftrace kprobes when the kernel is
locked down in confidentiality mode by preventing their registration.
This prevents kprobes from being used to access kernel memory to steal
crypto data, but continues to allow the use of kprobes from signed
modules.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: davem@davemloft.net
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/security.h     | 1 +
 kernel/trace/trace_kprobe.c  | 5 +++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index f0cffd0977d3..987d8427f091 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -117,6 +117,7 @@ enum lockdown_reason {
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
+	LOCKDOWN_KPROBES,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9d483ad9bb6c..d5fbade68b33 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -11,6 +11,7 @@
 #include <linux/uaccess.h>
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
+#include <linux/security.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 
@@ -389,6 +390,10 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
 	int i, ret;
 
+	ret = security_locked_down(LOCKDOWN_KPROBES);
+	if (ret)
+		return ret;
+
 	if (trace_kprobe_is_registered(tk))
 		return -EINVAL;
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index c050b82c7f9f..6b123cbf3748 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -32,6 +32,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
+	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.770.g0f2c4a37fd-goog

