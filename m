Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6B56194171
	for <lists+linux-security-module@lfdr.de>; Thu, 26 Mar 2020 15:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgCZO3O (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 26 Mar 2020 10:29:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35108 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgCZO2k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Mar 2020 10:28:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so7247510wmi.0
        for <linux-security-module@vger.kernel.org>; Thu, 26 Mar 2020 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g+P8lZ6OJ37Cz6QTX90YD4MphDb0p/ZqkQZVSQHi/WM=;
        b=R49Qo0knARyjW15YWuqSKNZGUYgAsP9eLZKciOfcRvjPxME9bW7sC2TNTvJHXsIVqs
         uvzGbxXj1Qsv3NjXhwoYMihcvftYdoF6hwRE3KelPjNYN+WZwVhqq0A9O18IYXerEz+f
         OktFhGKKHNloJupFVplGNdxI0hHLGhRHTPEqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+P8lZ6OJ37Cz6QTX90YD4MphDb0p/ZqkQZVSQHi/WM=;
        b=Xym5AUsnFRoV8DoiWmsGcl8RKDRoa4Qs4zXL7lscGL2qW3nCKKyuUZKeUE/LZw2pZe
         +y6oAQbZLRCKkVv3eO9O5yIlS3Qpw4JvEizy6nModX0jR+rRPwAHUIkT9HMFYNJYl/ST
         U7VdPvVbFMCw7jmcXwhhx35u2rNfs94q73FUFgF2NnDQ20T0VBu4Lu3lABtM0S/vYwxG
         lCzhpS1C5X6qO18nlY0LuUXz/bubOJoTGLM43fonmNeohuwZ1HqWRxEjvEiBv6N9wWe/
         lG7c8jwe2+uC0Eqi38bGy6wDEv0UsRLVIgfx9Z/mDfFDIuOfjwbIrdzNDfun/uCCLzCy
         SxRg==
X-Gm-Message-State: ANhLgQ2MTwFvkTrNE8XMIoR4vh5xC8X5+UimTPrZ8oYxNlr4/QOnduT/
        BZGGqkeleX3El/PFCBq1ZBSbgQ==
X-Google-Smtp-Source: ADFU+vtXFNpL1ZCV4ewrbrEUKninD6UjljlORXK9wevj9uvSwp2kW96numBMj5u20EQ6Fp84SGvRfg==
X-Received: by 2002:a1c:63c4:: with SMTP id x187mr234707wmb.124.1585232918119;
        Thu, 26 Mar 2020 07:28:38 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id q3sm3643971wru.87.2020.03.26.07.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:28:37 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and execution
Date:   Thu, 26 Mar 2020 15:28:19 +0100
Message-Id: <20200326142823.26277-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326142823.26277-1-kpsingh@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

JITed BPF programs are dynamically attached to the LSM hooks
using BPF trampolines. The trampoline prologue generates code to handle
conversion of the signature of the hook to the appropriate BPF context.

The allocated trampoline programs are attached to the nop functions
initialized as LSM hooks.

BPF_PROG_TYPE_LSM programs must have a GPL compatible license and
and need CAP_SYS_ADMIN (required for loading eBPF programs).

Upon attachment:

* A BPF fexit trampoline is used for LSM hooks with a void return type.
* A BPF fmod_ret trampoline is used for LSM hooks which return an
  int. The attached programs can override the return value of the
  bpf LSM hook to indicate a MAC Policy decision.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
---
 include/linux/bpf_lsm.h | 11 ++++++++
 kernel/bpf/bpf_lsm.c    | 28 ++++++++++++++++++++
 kernel/bpf/btf.c        |  9 ++++++-
 kernel/bpf/syscall.c    | 57 ++++++++++++++++++++++++++++-------------
 kernel/bpf/trampoline.c | 17 +++++++++---
 kernel/bpf/verifier.c   | 19 +++++++++++---
 6 files changed, 114 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 83b96895829f..af74712af585 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -17,6 +17,17 @@
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
+int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
+			const struct bpf_prog *prog);
+
+#else /* !CONFIG_BPF_LSM */
+
+static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
+				      const struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index e43e29690f22..e6160f0df3f1 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -9,6 +9,8 @@
 #include <linux/btf.h>
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
+#include <linux/kallsyms.h>
+#include <linux/bpf_verifier.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
@@ -22,6 +24,32 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
+#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
+
+int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
+			const struct bpf_prog *prog)
+{
+	/* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
+	 */
+	if (!capable(CAP_MAC_ADMIN))
+		return -EPERM;
+
+	if (!prog->gpl_compatible) {
+		bpf_log(vlog,
+			"LSM programs must have a GPL compatible license\n");
+		return -EINVAL;
+	}
+
+	if (strncmp(BPF_LSM_SYM_PREFX, prog->aux->attach_func_name,
+		    sizeof(BPF_LSM_SYM_PREFX) - 1)) {
+		bpf_log(vlog, "attach_btf_id %u points to wrong type name %s\n",
+			prog->aux->attach_btf_id, prog->aux->attach_func_name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 const struct bpf_prog_ops lsm_prog_ops = {
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6f397c4da05e..67466dd59a35 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3710,7 +3710,14 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	}
 
 	if (arg == nr_args) {
-		if (prog->expected_attach_type == BPF_TRACE_FEXIT) {
+		/* BPF_LSM_MAC programs only have int and void functions they
+		 * can be attached to. When they are attached to a void function
+		 * they result in the creation of an FEXIT trampoline and when
+		 * to a function that returns an int, a MODIFY_RETURN
+		 * trampoline.
+		 */
+		if (prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		    prog->expected_attach_type == BPF_LSM_MAC) {
 			if (!t)
 				return true;
 			t = btf_type_by_id(btf, t->type);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 85567a6ea5f9..cea69244c713 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -25,6 +25,7 @@
 #include <linux/nospec.h>
 #include <linux/audit.h>
 #include <uapi/linux/btf.h>
+#include <linux/bpf_lsm.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
@@ -1935,6 +1936,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 
 		switch (prog_type) {
 		case BPF_PROG_TYPE_TRACING:
+		case BPF_PROG_TYPE_LSM:
 		case BPF_PROG_TYPE_STRUCT_OPS:
 		case BPF_PROG_TYPE_EXT:
 			break;
@@ -2367,10 +2369,28 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
 	struct file *link_file;
 	int link_fd, err;
 
-	if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
-	    prog->expected_attach_type != BPF_TRACE_FEXIT &&
-	    prog->expected_attach_type != BPF_MODIFY_RETURN &&
-	    prog->type != BPF_PROG_TYPE_EXT) {
+	switch (prog->type) {
+	case BPF_PROG_TYPE_TRACING:
+		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
+		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
+			err = -EINVAL;
+			goto out_put_prog;
+		}
+		break;
+	case BPF_PROG_TYPE_EXT:
+		if (prog->expected_attach_type != 0) {
+			err = -EINVAL;
+			goto out_put_prog;
+		}
+		break;
+	case BPF_PROG_TYPE_LSM:
+		if (prog->expected_attach_type != BPF_LSM_MAC) {
+			err = -EINVAL;
+			goto out_put_prog;
+		}
+		break;
+	default:
 		err = -EINVAL;
 		goto out_put_prog;
 	}
@@ -2449,16 +2469,10 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
-	if (prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT &&
-	    prog->type != BPF_PROG_TYPE_TRACING &&
-	    prog->type != BPF_PROG_TYPE_EXT &&
-	    prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE) {
-		err = -EINVAL;
-		goto out_put_prog;
-	}
-
-	if (prog->type == BPF_PROG_TYPE_TRACING ||
-	    prog->type == BPF_PROG_TYPE_EXT) {
+	switch (prog->type) {
+	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_LSM:
 		if (attr->raw_tracepoint.name) {
 			/* The attach point for this category of programs
 			 * should be specified via btf_id during program load.
@@ -2466,11 +2480,14 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 			err = -EINVAL;
 			goto out_put_prog;
 		}
-		if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
+		if (prog->type == BPF_PROG_TYPE_TRACING &&
+		    prog->expected_attach_type == BPF_TRACE_RAW_TP) {
 			tp_name = prog->aux->attach_func_name;
-		else
-			return bpf_tracing_prog_attach(prog);
-	} else {
+			break;
+		}
+		return bpf_tracing_prog_attach(prog);
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 		if (strncpy_from_user(buf,
 				      u64_to_user_ptr(attr->raw_tracepoint.name),
 				      sizeof(buf) - 1) < 0) {
@@ -2479,6 +2496,10 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 		}
 		buf[sizeof(buf) - 1] = 0;
 		tp_name = buf;
+		break;
+	default:
+			err = -EINVAL;
+			goto out_put_prog;
 	}
 
 	btp = bpf_get_raw_tracepoint(tp_name);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f30bca2a4d01..9be85aa4ec5f 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -6,6 +6,7 @@
 #include <linux/ftrace.h>
 #include <linux/rbtree_latch.h>
 #include <linux/perf_event.h>
+#include <linux/btf.h>
 
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
@@ -233,15 +234,23 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 	return err;
 }
 
-static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(enum bpf_attach_type t)
+static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 {
-	switch (t) {
+	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
 		return BPF_TRAMP_FENTRY;
 	case BPF_MODIFY_RETURN:
 		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
 		return BPF_TRAMP_FEXIT;
+	case BPF_LSM_MAC:
+		if (!prog->aux->attach_func_proto->type)
+			/* The function returns void, we cannot modify its
+			 * return value.
+			 */
+			return BPF_TRAMP_FEXIT;
+		else
+			return BPF_TRAMP_MODIFY_RETURN;
 	default:
 		return BPF_TRAMP_REPLACE;
 	}
@@ -255,7 +264,7 @@ int bpf_trampoline_link_prog(struct bpf_prog *prog)
 	int cnt;
 
 	tr = prog->aux->trampoline;
-	kind = bpf_attach_type_to_tramp(prog->expected_attach_type);
+	kind = bpf_attach_type_to_tramp(prog);
 	mutex_lock(&tr->mutex);
 	if (tr->extension_prog) {
 		/* cannot attach fentry/fexit if extension prog is attached.
@@ -305,7 +314,7 @@ int bpf_trampoline_unlink_prog(struct bpf_prog *prog)
 	int err;
 
 	tr = prog->aux->trampoline;
-	kind = bpf_attach_type_to_tramp(prog->expected_attach_type);
+	kind = bpf_attach_type_to_tramp(prog);
 	mutex_lock(&tr->mutex);
 	if (kind == BPF_TRAMP_REPLACE) {
 		WARN_ON_ONCE(!tr->extension_prog);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2ea2a868324e..8808c06f2571 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20,6 +20,7 @@
 #include <linux/perf_event.h>
 #include <linux/ctype.h>
 #include <linux/error-injection.h>
+#include <linux/bpf_lsm.h>
 
 #include "disasm.h"
 
@@ -6488,8 +6489,9 @@ static int check_return_code(struct bpf_verifier_env *env)
 	struct tnum range = tnum_range(0, 1);
 	int err;
 
-	/* The struct_ops func-ptr's return type could be "void" */
-	if (env->prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+	/* LSM and struct_ops func-ptr's return type could be "void" */
+	if ((env->prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	     env->prog->type == BPF_PROG_TYPE_LSM) &&
 	    !prog->aux->attach_func_proto->type)
 		return 0;
 
@@ -9919,7 +9921,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
 		return check_struct_ops_btf_id(env);
 
-	if (prog->type != BPF_PROG_TYPE_TRACING && !prog_extension)
+	if (prog->type != BPF_PROG_TYPE_TRACING &&
+	    prog->type != BPF_PROG_TYPE_LSM &&
+	    !prog_extension)
 		return 0;
 
 	if (!btf_id) {
@@ -10050,8 +10054,16 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 			return -EINVAL;
 		/* fallthrough */
 	case BPF_MODIFY_RETURN:
+	case BPF_LSM_MAC:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+		prog->aux->attach_func_name = tname;
+		if (prog->type == BPF_PROG_TYPE_LSM) {
+			ret = bpf_lsm_verify_prog(&env->log, prog);
+			if (ret < 0)
+				return ret;
+		}
+
 		if (!btf_type_is_func(t)) {
 			verbose(env, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -10066,7 +10078,6 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		tr = bpf_trampoline_lookup(key);
 		if (!tr)
 			return -ENOMEM;
-		prog->aux->attach_func_name = tname;
 		/* t is either vmlinux type or another program's type */
 		prog->aux->attach_func_proto = t;
 		mutex_lock(&tr->mutex);
-- 
2.20.1

