Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6FFC4F272
	for <lists+linux-security-module@lfdr.de>; Sat, 22 Jun 2019 02:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfFVAFB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Jun 2019 20:05:01 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:39950 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfFVAFA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 20:05:00 -0400
Received: by mail-pf1-f201.google.com with SMTP id z1so5319332pfb.7
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 17:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lADF/69hujBGq/iJl0D88rT6I3VHPhuR9iVW3LJP1Jc=;
        b=K2FFJ1aP76BMQ/E5sjviwmlSMKVguU8Jr9csKRbGwRxxh3nWMY6MyYVqtdU1Y5Tfnz
         kOF1/pHQYbqBdNndYLAjlR/a1h6lC7UO9m1imOdoyh0ZmiimhMR9K+KXByKIbOyAYuTL
         8P7pZ5SMACUx1f1dLXQ5MhV4J1xa5/HWxsAb2KzcrRWt0/RWhNIX9vFd+Mfg968LkruV
         +n7aJru5R/ypJAmgB+dlauue8cjhksN0Q8pYBeX3j2pKv0GmQ3ZP/gXy2miLx12cmXzm
         YVB7owkrEhwP1oKB7hJyXRS4DC8M71NStLEFOUKFEXIuK9cuRslA5UAuX3LoTN67HRfM
         1O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lADF/69hujBGq/iJl0D88rT6I3VHPhuR9iVW3LJP1Jc=;
        b=nA6VCDVr12XkwMdh0STuQAoqI918THva/TV8bMtRAySiesqrYrlD07F2zTgdsby1ts
         9bxzGkIqo0abHyrBK8ApMWStfP3u34crG3IucctqM/SoEcYVTxr74XJJZTtC0ZAdFV4X
         MGEJ5A2K1QLU2t0PRQ30GMDCamIkGf1NryXld+m2y7gyvydSRoOS4rKiIRrqWB0hMzF8
         wX7AbGr7vQDi3l4O/OY5VFFv8lCvNgwsBDvLtjPd3YLPForiw1Ya+Pj0yhRemSH1nnuZ
         wUWGOMAtOaFABJhZhbCaTpKBXw0no1cGoEOIllcy0+RFn8t8HzUH3zkEGnxOoCzl450u
         QXIQ==
X-Gm-Message-State: APjAAAXPCHRI4FCQKpPbZ6L8C9twe8CSCd/coyPykdjgQlADPL9CK+W3
        KSPrVaBIc4AEb85IDv1LwsYh9ciPD7FSWnmiC6NBEg==
X-Google-Smtp-Source: APXvYqx26XubluRiPF2yLoG9HE9+5mboNjL4ADSV+ZJwFXoINToQgWAE+0lEy7Bqd5a/KReOfJnU7lPdOVbv1JFC0/yfZQ==
X-Received: by 2002:a63:545c:: with SMTP id e28mr4246306pgm.374.1561161899618;
 Fri, 21 Jun 2019 17:04:59 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:52 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>, netdev@vger.kernel.org,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

There are some bpf functions can be used to read kernel memory:
bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
private keys in kernel memory (e.g. the hibernation image signing key) to
be read by an eBPF program and kernel memory to be altered without
restriction. Disable them if the kernel has been locked down in
confidentiality mode.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: netdev@vger.kernel.org
cc: Chun-Yi Lee <jlee@suse.com>
cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/security.h     |  1 +
 kernel/trace/bpf_trace.c     | 20 +++++++++++++++++++-
 security/lockdown/lockdown.c |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index e6e3e2403474..de0d37b1fe79 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -97,6 +97,7 @@ enum lockdown_reason {
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
+	LOCKDOWN_BPF_READ,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d64c00afceb5..638f9b00a8df 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -137,6 +137,10 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret)
+		return ret;
+
 	ret = probe_kernel_read(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
 		memset(dst, 0, size);
@@ -156,6 +160,12 @@ static const struct bpf_func_proto bpf_probe_read_proto = {
 BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
 	   u32, size)
 {
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret)
+		return ret;
+
 	/*
 	 * Ensure we're in user context which is safe for the helper to
 	 * run. This helper has no business in a kthread.
@@ -205,7 +215,11 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	int fmt_cnt = 0;
 	u64 unsafe_addr;
 	char buf[64];
-	int i;
+	int i, ret;
+
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret)
+		return ret;
 
 	/*
 	 * bpf_check()->check_func_arg()->check_stack_boundary()
@@ -534,6 +548,10 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret)
+		return ret;
+
 	/*
 	 * The strncpy_from_unsafe() call will likely not fill the entire
 	 * buffer, but that's okay in this circumstance as we're probing
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 5a08c17f224d..2eea2cc13117 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -33,6 +33,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
+	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.410.gd8fdbe21b5-goog

