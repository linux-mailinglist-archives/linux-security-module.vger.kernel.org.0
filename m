Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 837354F282
	for <lists+linux-security-module@lfdr.de>; Sat, 22 Jun 2019 02:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfFVAGH (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Jun 2019 20:06:07 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:51659 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfFVAE5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:57 -0400
Received: by mail-pg1-f201.google.com with SMTP id i35so3815541pgi.18
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 17:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vG+Ky1xMciAt56WQw2EjTPdmD541F+3aHNW5aR09cZM=;
        b=UL4Qk25hc3SNUo5XrSqPPvfC8ObTMPlrZFg4JcxukENDqlnfup3f9RtnrkiwHcxOQy
         +CX3ihK97Qg38Ne2dRLsC03qRKG63yC8UfLws2djrH8nyLWGoz9EnjOIu7rh8v1Wzyu2
         /m5932Iq9XT+iN6P0dpcU6tlmMNrWuQEgFtEdAXz36MufIe2TmZfNtd1Ly1f3GhlLVIF
         OSk80xD/ELnXzf7ZMFPRQUyPJDpkxWOTnQrNocZhtWH043t2QGiQVvXzAGZB0uyzSd7l
         nVv1uzBdGuaWozCwN4byv7d/DDbzNdPbmHEM5gcxtro0RsRDzsCA1ioy64MXtW42aBMa
         GGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vG+Ky1xMciAt56WQw2EjTPdmD541F+3aHNW5aR09cZM=;
        b=RLrf57OjLNzQ83iSjQj534Ev6iEuHKDTn5vfuApQEJYmn5BwLWZRCx6rBJUev/TdGn
         pzMO82AXQMrtOVLg86+JAJ7aZmMHnSUPkCHNjqmag6RbTVoJrGzSVaWWVMLx+In7DYMS
         nEu9Pi8n1Hpn/CGx+0tOSQTE/WtxaZHlPL/DLXjVI9SRA4AVUZhfau1sRcVhlS18odhC
         wBmS+0x6ykD29Tf0gkX0uMPTtnI9XvmvhPXaWIIBTg5r6wWGCKM5CUZWOc9ovnLrQbMP
         Y+E6T/Yfze7/YnFph3FXd9Q2BgiRPMvxCz4fqm//jBFoaryBw6y0IQ8WBP8j0F0riz3B
         h/MQ==
X-Gm-Message-State: APjAAAVYTInaqKXcY7QyKLds8Y11WhH8d2S3fkgD/4puUV4OoxbkETMe
        biEzRK99gplyegkvwN+AxnxcSHuAowddXWpGOFWRNQ==
X-Google-Smtp-Source: APXvYqw9j0ee4KLPs7be3t2v3Y+G+7aChaH5PGSdJ0kCmluEfWlXs0wvCI8+XwhzwD3dbhB6c+Ee3GhBlLOvdYQe+AiRuA==
X-Received: by 2002:a65:50c3:: with SMTP id s3mr20935624pgp.177.1561161897008;
 Fri, 21 Jun 2019 17:04:57 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:51 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 22/29] Lock down tracing and perf kprobes when in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net, Masami Hiramatsu <mhiramat@kernel.org>
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
index 3875f6df2ecc..e6e3e2403474 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -96,6 +96,7 @@ enum lockdown_reason {
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
+	LOCKDOWN_KPROBES,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5d5129b05df7..5a76a0f79d48 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -11,6 +11,7 @@
 #include <linux/uaccess.h>
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
+#include <linux/security.h>
 
 #include "trace_dynevent.h"
 #include "trace_kprobe_selftest.h"
@@ -415,6 +416,10 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
 	int i, ret;
 
+	ret = security_locked_down(LOCKDOWN_KPROBES);
+	if (ret)
+		return ret;
+
 	if (trace_probe_is_registered(&tk->tp))
 		return -EINVAL;
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 4c9b324dfc55..5a08c17f224d 100644
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
2.22.0.410.gd8fdbe21b5-goog

