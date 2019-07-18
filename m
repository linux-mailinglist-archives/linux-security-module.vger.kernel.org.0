Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029316D548
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Jul 2019 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404211AbfGRTqD (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 18 Jul 2019 15:46:03 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:50839 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404034AbfGRTpT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jul 2019 15:45:19 -0400
Received: by mail-pl1-f201.google.com with SMTP id d6so14430651pls.17
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jul 2019 12:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+kj/i0peoh/v65WgevbFUm6xG2Y2qR8kjesuSzHy2lw=;
        b=fUk+ZTcoldUn+2TCtr1PoKSI+zovfN9gKmXjF4DrrDJ2mSIEUWLiWeWLX372f4p7D7
         XH47RYmM1fDnYZrXQezARD7Bq4u3XiB7YfGYIBP2lw2CaDaI5pLwSZpqdZVUvMMDZ4a3
         Ui6jNsTXZVHxNPcmbFg1EEz62Z2B0DEvIv8WosO1SgJE9k2GlfUb3uP9EEak5G4+pbZU
         pML3LBLqQq3brER9SrLoE55UgsBTAAID2fkHr3thzYM+waRIXUXdGVRDnkk+LTv0nnt1
         R+Zo0PRnopkj51Suj0kOGDZoLZd8t2G0hpiwyTBSuZ6qXwF3WpC3oqf9DSXYLKtkhkIG
         6JmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+kj/i0peoh/v65WgevbFUm6xG2Y2qR8kjesuSzHy2lw=;
        b=pvSGoqktt/AnR7aarOZJmRBMLkz5GPPlUURgNZtx6LumG8BBHuCbv7fOVJn28eVIZY
         Ju8MXUTJ3f/BdRxnqYG5y0mwbGRrdcwmhQdfzi7RVyLtywHtl/9kCtLhaNKND1pNsBhM
         SDtbKnu6E+fq80I6SRAvtR8bm5aBao9JDwsdwLAKajRej4sLFo7mbT2Q4dHgiqsHZV8M
         Ed6f14kVfCMSyqOQVcgVcRS39NEH5PWPC+k0AXQLMEMnEoN6JVBI6POvX+ELIQworNRs
         b03f2vaufZ3XSdx4dzjZq5ox3KWeTNglMxZQhRqdvsZFIjhmWZZ8tKvx+T8XGh2ldSU7
         nZ8A==
X-Gm-Message-State: APjAAAUi9yYNd5KeJNIKa9tgBhwlkdld8FksFSmSSMjtAyhsWkavU23Q
        hMZsaW25o4+rGUQgWtM2CCAK6x3FZ1uBz8PG8uMfLw==
X-Google-Smtp-Source: APXvYqw2sxTZK/+Pp57R6A0PaZfCVXeZ1BWP5no8glAKxdRukIof4kMsddZqmrhFlykd+PpgRIKXIGQ6acGXoyjx5NaKtg==
X-Received: by 2002:a63:24c1:: with SMTP id k184mr50552564pgk.120.1563479118172;
 Thu, 18 Jul 2019 12:45:18 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:09 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 23/29] bpf: Restrict bpf when kernel lockdown is in
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

bpf_read() and bpf_read_str() could potentially be abused to (eg) allow
private keys in kernel memory to be leaked. Disable them if the kernel
has been locked down in confidentiality mode.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
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
2.22.0.510.g264f2c817a-goog

