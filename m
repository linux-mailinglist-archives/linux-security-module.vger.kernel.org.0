Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9685F1787DB
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Mar 2020 02:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbgCDBzu (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 3 Mar 2020 20:55:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39530 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387636AbgCDBzr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Mar 2020 20:55:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id j1so148634wmi.4
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2020 17:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JH3iKdoX60vBDf5RPVZX6I6Dg2qntJTjRhn9rqqRbkU=;
        b=jScRWgx6NIDkPAYeaC4QqY/IZhA8mvih8Ll0QSkH7y+l1pJCP+vUNNHH+9X/vqAaB9
         uBLAdVHqz/2V8+u031cLaYemYSYOUSPj4ysqSwxEihvRnwNu42jfXQ4S/u2wsDRVu9td
         V4PLYbAKzHo9KUMrY9ADT450K0z+nVRoPST/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JH3iKdoX60vBDf5RPVZX6I6Dg2qntJTjRhn9rqqRbkU=;
        b=mQUEeCAfreIjBtXufc5Xd7pqFMenDk3dX1qsguu/8mtd/CZc8Hj8lNzupFxNy/YIqE
         tNC6Yk3q9fTtAe1VuoOIkLYqWuN2wLoh1K1HIIdEDpfINiwzFn6M0KpH+LSJGjnUadj1
         7iYA5oq8X7XLtsQsaQJuv8DLT7z8XTkbvUA0WnSsrcJnprACM3NoGMg3k4x0/YXU4hqs
         UFSckPOOUWrUndTOelZWvKS88VQLGZN7K2zkrt7dlmZyxcQHbUYv/tmNmvIFy8FbhmOA
         etKISAVFDTkfPRQwpcvB2QAol9PA/uK2T9SwGBgj0d/1iWTYL9qizFBX4bg2GKh221zy
         I1OA==
X-Gm-Message-State: ANhLgQ1MXN1oAotP+6P95AiyUj9DsAx1DrJGXEXBG/fg0DOy4OCRJ1Ln
        S0wt9+M2oviQlo8vCuewMKaQ43adt/8=
X-Google-Smtp-Source: ADFU+vub7zNtIQgku43svY79DCSukH5QoU5kYyhYKcWIT8u9in1GM5lWKmyG2XmzRH4Y9Bgn6v7IkA==
X-Received: by 2002:a1c:a515:: with SMTP id o21mr588522wme.124.1583286945086;
        Tue, 03 Mar 2020 17:55:45 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a184sm1475444wmf.29.2020.03.03.17.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:55:44 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 7/7] bpf: Add selftests for BPF_MODIFY_RETURN
Date:   Wed,  4 Mar 2020 02:55:28 +0100
Message-Id: <20200304015528.29661-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304015528.29661-1-kpsingh@chromium.org>
References: <20200304015528.29661-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

Test for two scenarios:

  * When the fmod_ret program returns 0, the original function should
    be called along with fentry and fexit programs.
  * When the fmod_ret program returns a non-zero value, the original
    function should not be called, no side effect should be observed and
    fentry and fexit programs should be called.

The result from the kernel function call and whether a side-effect is
observed is returned via the retval attr of the BPF_PROG_TEST_RUN (bpf)
syscall.

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 net/bpf/test_run.c                            | 22 ++++++-
 .../selftests/bpf/prog_tests/modify_return.c  | 65 +++++++++++++++++++
 .../selftests/bpf/progs/modify_return.c       | 49 ++++++++++++++
 3 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/modify_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/modify_return.c

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 3600f098e7c6..4c921f5154e0 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -10,6 +10,7 @@
 #include <net/bpf_sk_storage.h>
 #include <net/sock.h>
 #include <net/tcp.h>
+#include <linux/error-injection.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/bpf_test_run.h>
@@ -143,6 +144,14 @@ int noinline bpf_fentry_test6(u64 a, void *b, short c, int d, void *e, u64 f)
 	return a + (long)b + c + d + (long)e + f;
 }
 
+int noinline bpf_modify_return_test(int a, int *b)
+{
+	*b += 1;
+	return a + *b;
+}
+
+ALLOW_ERROR_INJECTION(bpf_modify_return_test, ERRNO);
+
 static void *bpf_test_init(const union bpf_attr *kattr, u32 size,
 			   u32 headroom, u32 tailroom)
 {
@@ -168,7 +177,9 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 			      const union bpf_attr *kattr,
 			      union bpf_attr __user *uattr)
 {
-	int err = -EFAULT;
+	u16 side_effect = 0, ret = 0;
+	int b = 2, err = -EFAULT;
+	u32 retval = 0;
 
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
@@ -181,10 +192,19 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 		    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111)
 			goto out;
 		break;
+	case BPF_MODIFY_RETURN:
+		ret = bpf_modify_return_test(1, &b);
+		if (b != 2)
+			side_effect = 1;
+		break;
 	default:
 		goto out;
 	}
 
+	retval = ((u32)side_effect << 16) | ret;
+	if (copy_to_user(&uattr->test.retval, &retval, sizeof(retval)))
+		goto out;
+
 	err = 0;
 out:
 	trace_bpf_test_finish(&err);
diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
new file mode 100644
index 000000000000..97fec70c600b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2020 Google LLC.
+ */
+
+#include <test_progs.h>
+#include "modify_return.skel.h"
+
+#define LOWER(x) ((x) & 0xffff)
+#define UPPER(x) ((x) >> 16)
+
+
+static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
+{
+	struct modify_return *skel = NULL;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+	__u16 side_effect;
+	__s16 ret;
+
+	skel = modify_return__open_and_load();
+	if (CHECK(!skel, "skel_load", "modify_return skeleton failed\n"))
+		goto cleanup;
+
+	err = modify_return__attach(skel);
+	if (CHECK(err, "modify_return", "attach failed: %d\n", err))
+		goto cleanup;
+
+	skel->bss->input_retval = input_retval;
+	prog_fd = bpf_program__fd(skel->progs.fmod_ret_test);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0, NULL, 0,
+				&retval, &duration);
+
+	CHECK(err, "test_run", "err %d errno %d\n", err, errno);
+
+	side_effect = UPPER(retval);
+	ret  = LOWER(retval);
+
+	CHECK(ret != want_ret, "test_run",
+	      "unexpected ret: %d, expected: %d\n", ret, want_ret);
+	CHECK(side_effect != want_side_effect, "modify_return",
+	      "unexpected side_effect: %d\n", side_effect);
+
+	CHECK(skel->bss->fentry_result != 1, "modify_return",
+	      "fentry failed\n");
+	CHECK(skel->bss->fexit_result != 1, "modify_return",
+	      "fexit failed\n");
+	CHECK(skel->bss->fmod_ret_result != 1, "modify_return",
+	      "fmod_ret failed\n");
+
+cleanup:
+	modify_return__destroy(skel);
+}
+
+void test_modify_return(void)
+{
+	run_test(0 /* input_retval */,
+		 1 /* want_side_effect */,
+		 4 /* want_ret */);
+	run_test(-EINVAL /* input_retval */,
+		 0 /* want_side_effect */,
+		 -EINVAL /* want_ret */);
+}
+
diff --git a/tools/testing/selftests/bpf/progs/modify_return.c b/tools/testing/selftests/bpf/progs/modify_return.c
new file mode 100644
index 000000000000..8b7466a15c6b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/modify_return.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2020 Google LLC.
+ */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+static int sequence = 0;
+__s32 input_retval = 0;
+
+__u64 fentry_result = 0;
+SEC("fentry/bpf_modify_return_test")
+int BPF_PROG(fentry_test, int a, __u64 b)
+{
+	sequence++;
+	fentry_result = (sequence == 1);
+	return 0;
+}
+
+__u64 fmod_ret_result = 0;
+SEC("fmod_ret/bpf_modify_return_test")
+int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
+{
+	sequence++;
+	/* This is the first fmod_ret program, the ret passed should be 0 */
+	fmod_ret_result = (sequence == 2 && ret == 0);
+	return input_retval;
+}
+
+__u64 fexit_result = 0;
+SEC("fexit/bpf_modify_return_test")
+int BPF_PROG(fexit_test, int a, __u64 b, int ret)
+{
+	sequence++;
+	/* If the input_reval is non-zero a successful modification should have
+	 * occurred.
+	 */
+	if (input_retval)
+		fexit_result = (sequence == 3 && ret == input_retval);
+	else
+		fexit_result = (sequence == 3 && ret == 4);
+
+	return 0;
+}
-- 
2.20.1

