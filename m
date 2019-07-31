Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115F07D0E2
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Aug 2019 00:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfGaWSs (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 31 Jul 2019 18:18:48 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38669 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731369AbfGaWRZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:25 -0400
Received: by mail-qk1-f202.google.com with SMTP id n190so59404248qkd.5
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2019 15:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8yt0J0pt8aHuQPT7nXOB+XR/9vHKjGA14LTvJs583ko=;
        b=qaM4FD9hTiJEd2YW/5LgkZdUqi2/uuM8SnVUWfcL6vnIqCHEq9Taa7iUdxqe18Wcrv
         Dn5SENlGYiQb0xgBozezRWkkgmae8+cqjo4xKs+XBU5VuB4o2O4mEJYQN2SMj5IHuPRQ
         8EsLmPOLnfbYXxE7Ti3pwPdUjYl3YcH6psOQ0YEk/eHV/9MfDH4OCRrZWN7oH+tXz54z
         voYa91Ir+BPbk87GQE4+ZorXx+Ti3PMkr5HzwhFEcTN7Y9r+zUuqu5nA+tfF94JVAuoS
         BqVZgERJ2tAMvDEkAQ1ixhEEXkVZePif6MlzDRDj7Qs/9/iaAfY2jlUrvPyPKYtpgf9E
         kloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8yt0J0pt8aHuQPT7nXOB+XR/9vHKjGA14LTvJs583ko=;
        b=jff28E9qSs/qAvxv1Xnj+avaRfN0CRqOqYMT7SgW1qa0sP6iibDyoRJ3DV/t7EDE7d
         9jGY9YYn2eympN7OYW3nC/ldxHRHP6FKMA6p9moS/vB9f/THwANYrgX9zaolKFRY7+4s
         CV7AxWPnl4HdfCu01gGD3K/+JOx+H4U5e2uUZ+R3f7nu+KGpLaV/ClL3X29KhGdRWTgA
         i/4+r2spJ/CSY+KpPRhtkhvvJWWxuY9TxuHudSKdYp1RoyBB0UCBoYSiQiM7Lb+PXwj9
         BKSgl7lT8oKXob6Ybslfm6p4Y1PZsa7tTF07dLraG3FStkI+65ZYsoWvRfkhbd1UxCvB
         w3zw==
X-Gm-Message-State: APjAAAU33umwS3JRQ4DMX/RC9hjiy0aD03XGsHU+P39SzOdPv8w/sjAY
        VCXbhaNcEFGTGj+Wq6+Yta3IghxPFOl5opbgz9GbfQ==
X-Google-Smtp-Source: APXvYqwLPyN9ICwBuxsioIaCMSDc+sjgw+9DOmPZDaLdUXEdwglGnut4x/i0sqM0yeNXyF3d3VIqg/ebEP/4bEpy/PTuPg==
X-Received: by 2002:a37:b0c6:: with SMTP id z189mr81991658qke.208.1564611444988;
 Wed, 31 Jul 2019 15:17:24 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:11 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

bpf_read() and bpf_read_str() could potentially be abused to (eg) allow
private keys in kernel memory to be leaked. Disable them if the kernel
has been locked down in confidentiality mode.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: netdev@vger.kernel.org
cc: Chun-Yi Lee <jlee@suse.com>
cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/security.h     |  1 +
 kernel/trace/bpf_trace.c     | 10 ++++++++++
 security/lockdown/lockdown.c |  1 +
 3 files changed, 12 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 987d8427f091..8dd1741a52cd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -118,6 +118,7 @@ enum lockdown_reason {
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
+	LOCKDOWN_BPF_READ,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ca1255d14576..492a8bfaae98 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -142,8 +142,13 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret < 0)
+		goto out;
+
 	ret = probe_kernel_read(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
+out:
 		memset(dst, 0, size);
 
 	return ret;
@@ -569,6 +574,10 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret < 0)
+		goto out;
+
 	/*
 	 * The strncpy_from_unsafe() call will likely not fill the entire
 	 * buffer, but that's okay in this circumstance as we're probing
@@ -580,6 +589,7 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
 	 */
 	ret = strncpy_from_unsafe(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
+out:
 		memset(dst, 0, size);
 
 	return ret;
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 6b123cbf3748..1b89d3e8e54d 100644
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
2.22.0.770.g0f2c4a37fd-goog

