Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3EC7C7996
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Oct 2023 00:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443017AbjJLWcX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 12 Oct 2023 18:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442975AbjJLWcW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 Oct 2023 18:32:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C834CF
        for <linux-security-module@vger.kernel.org>; Thu, 12 Oct 2023 15:32:20 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CLu3dv019290
        for <linux-security-module@vger.kernel.org>; Thu, 12 Oct 2023 15:32:20 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tpjtjj53c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 12 Oct 2023 15:32:20 -0700
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 12 Oct 2023 15:32:19 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 619B439A3A52D; Thu, 12 Oct 2023 15:29:21 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v7 bpf-next 09/18] bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM hooks
Date:   Thu, 12 Oct 2023 15:28:01 -0700
Message-ID: <20231012222810.4120312-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012222810.4120312-1-andrii@kernel.org>
References: <20231012222810.4120312-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RtH88aQTdSxd0Y942XfyaZvve_B_d1hH
X-Proofpoint-GUID: RtH88aQTdSxd0Y942XfyaZvve_B_d1hH
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Based on upstream discussion ([0]), rework existing
bpf_prog_alloc_security LSM hook. Rename it to bpf_prog_load and instead
of passing bpf_prog_aux, pass proper bpf_prog pointer for a full BPF
program struct. Also, we pass bpf_attr union with all the user-provided
arguments for BPF_PROG_LOAD command.  This will give LSMs as much
information as we can basically provide.

The hook is also BPF token-aware now, and optional bpf_token struct is
passed as a third argument. bpf_prog_load LSM hook is called after
a bunch of sanity checks were performed, bpf_prog and bpf_prog_aux were
allocated and filled out, but right before performing full-fledged BPF
verification step.

bpf_prog_free LSM hook is now accepting struct bpf_prog argument, for
consistency. SELinux code is adjusted to all new names, types, and
signatures.

Note, given that bpf_prog_load (previously bpf_prog_alloc) hook can be
used by some LSMs to allocate extra security blob, but also by other
LSMs to reject BPF program loading, we need to make sure that
bpf_prog_free LSM hook is called after bpf_prog_load/bpf_prog_alloc one
*even* if the hook itself returned error. If we don't do that, we run
the risk of leaking memory. This seems to be possible today when
combining SELinux and BPF LSM, as one example, depending on their
relative ordering.

Also, for BPF LSM setup, add bpf_prog_load and bpf_prog_free to
sleepable LSM hooks list, as they are both executed in sleepable
context. Also drop bpf_prog_load hook from untrusted, as there is no
issue with refcount or anything else anymore, that originally forced us
to add it to untrusted list in c0c852dd1876 ("bpf: Do not mark certain LSM
hook arguments as trusted"). We now trigger this hook much later and it
should not be an issue anymore.

  [0] https://lore.kernel.org/bpf/9fe88aef7deabbe87d3fc38c4aea3c69.paul@paul-moore.com/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/lsm_hook_defs.h |  5 +++--
 include/linux/security.h      | 12 +++++++-----
 kernel/bpf/bpf_lsm.c          |  5 +++--
 kernel/bpf/syscall.c          | 25 +++++++++++++------------
 security/security.c           | 25 +++++++++++++++----------
 security/selinux/hooks.c      | 15 ++++++++-------
 6 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ac962c4cb44b..f7088a06c593 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -400,8 +400,9 @@ LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
 LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
 LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
 LSM_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *map)
-LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
-LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free_security, struct bpf_prog_aux *aux)
+LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *attr,
+	 struct bpf_token *token)
+LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
 #endif /* CONFIG_BPF_SYSCALL */
 
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f16eecde00b..b9fb101561b6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2020,15 +2020,16 @@ static inline void securityfs_remove(struct dentry *dentry)
 union bpf_attr;
 struct bpf_map;
 struct bpf_prog;
-struct bpf_prog_aux;
+struct bpf_token;
 #ifdef CONFIG_SECURITY
 extern int security_bpf(int cmd, union bpf_attr *attr, unsigned int size);
 extern int security_bpf_map(struct bpf_map *map, fmode_t fmode);
 extern int security_bpf_prog(struct bpf_prog *prog);
 extern int security_bpf_map_alloc(struct bpf_map *map);
 extern void security_bpf_map_free(struct bpf_map *map);
-extern int security_bpf_prog_alloc(struct bpf_prog_aux *aux);
-extern void security_bpf_prog_free(struct bpf_prog_aux *aux);
+extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
+				  struct bpf_token *token);
+extern void security_bpf_prog_free(struct bpf_prog *prog);
 #else
 static inline int security_bpf(int cmd, union bpf_attr *attr,
 					     unsigned int size)
@@ -2054,12 +2055,13 @@ static inline int security_bpf_map_alloc(struct bpf_map *map)
 static inline void security_bpf_map_free(struct bpf_map *map)
 { }
 
-static inline int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
+static inline int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
+					 struct bpf_token *token)
 {
 	return 0;
 }
 
-static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
+static inline void security_bpf_prog_free(struct bpf_prog *prog)
 { }
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index e14c822f8911..3e956f6302f3 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -263,6 +263,8 @@ BTF_ID(func, bpf_lsm_bpf_map)
 BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
 BTF_ID(func, bpf_lsm_bpf_map_free_security)
 BTF_ID(func, bpf_lsm_bpf_prog)
+BTF_ID(func, bpf_lsm_bpf_prog_load)
+BTF_ID(func, bpf_lsm_bpf_prog_free)
 BTF_ID(func, bpf_lsm_bprm_check_security)
 BTF_ID(func, bpf_lsm_bprm_committed_creds)
 BTF_ID(func, bpf_lsm_bprm_committing_creds)
@@ -346,8 +348,7 @@ BTF_SET_END(sleepable_lsm_hooks)
 
 BTF_SET_START(untrusted_lsm_hooks)
 BTF_ID(func, bpf_lsm_bpf_map_free_security)
-BTF_ID(func, bpf_lsm_bpf_prog_alloc_security)
-BTF_ID(func, bpf_lsm_bpf_prog_free_security)
+BTF_ID(func, bpf_lsm_bpf_prog_free)
 BTF_ID(func, bpf_lsm_file_alloc_security)
 BTF_ID(func, bpf_lsm_file_free_security)
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f0e22d116041..ee0fea87b17b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2138,7 +2138,7 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 	kvfree(aux->func_info);
 	kfree(aux->func_info_aux);
 	free_uid(aux->user);
-	security_bpf_prog_free(aux);
+	security_bpf_prog_free(aux->prog);
 	bpf_prog_free(aux->prog);
 }
 
@@ -2728,10 +2728,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	prog->aux->token = token;
 	token = NULL;
 
-	err = security_bpf_prog_alloc(prog->aux);
-	if (err)
-		goto free_prog;
-
 	prog->aux->user = get_current_user();
 	prog->len = attr->insn_cnt;
 
@@ -2739,12 +2735,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (copy_from_bpfptr(prog->insns,
 			     make_bpfptr(attr->insns, uattr.is_kernel),
 			     bpf_prog_insn_size(prog)) != 0)
-		goto free_prog_sec;
+		goto free_prog;
 	/* copy eBPF program license from user space */
 	if (strncpy_from_bpfptr(license,
 				make_bpfptr(attr->license, uattr.is_kernel),
 				sizeof(license) - 1) < 0)
-		goto free_prog_sec;
+		goto free_prog;
 	license[sizeof(license) - 1] = 0;
 
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
@@ -2758,25 +2754,29 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (bpf_prog_is_dev_bound(prog->aux)) {
 		err = bpf_prog_dev_bound_init(prog, attr);
 		if (err)
-			goto free_prog_sec;
+			goto free_prog;
 	}
 
 	if (type == BPF_PROG_TYPE_EXT && dst_prog &&
 	    bpf_prog_is_dev_bound(dst_prog->aux)) {
 		err = bpf_prog_dev_bound_inherit(prog, dst_prog);
 		if (err)
-			goto free_prog_sec;
+			goto free_prog;
 	}
 
 	/* find program type: socket_filter vs tracing_filter */
 	err = find_prog_type(type, prog);
 	if (err < 0)
-		goto free_prog_sec;
+		goto free_prog;
 
 	prog->aux->load_time = ktime_get_boottime_ns();
 	err = bpf_obj_name_cpy(prog->aux->name, attr->prog_name,
 			       sizeof(attr->prog_name));
 	if (err < 0)
+		goto free_prog;
+
+	err = security_bpf_prog_load(prog, attr, token);
+	if (err)
 		goto free_prog_sec;
 
 	/* run eBPF verifier */
@@ -2822,10 +2822,11 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	 */
 	__bpf_prog_put_noref(prog, prog->aux->real_func_cnt);
 	return err;
+
 free_prog_sec:
-	free_uid(prog->aux->user);
-	security_bpf_prog_free(prog->aux);
+	security_bpf_prog_free(prog);
 free_prog:
+	free_uid(prog->aux->user);
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 	bpf_prog_free(prog);
diff --git a/security/security.c b/security/security.c
index 23b129d482a7..bc8b72325c3b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5180,16 +5180,21 @@ int security_bpf_map_alloc(struct bpf_map *map)
 }
 
 /**
- * security_bpf_prog_alloc() - Allocate a bpf program LSM blob
- * @aux: bpf program aux info struct
+ * security_bpf_prog_load() - Check if loading of BPF program is allowed
+ * @prog BPF program object
+ * @attr: BPF syscall attributes used to create BPF program
+ * @token: BPF token used to grant user access to BPF subsystem
  *
- * Initialize the security field inside bpf program.
+ * Do a check when the kernel allocates BPF program object and is about to
+ * pass it to BPF verifier for additional correctness checks. This is also the
+ * point where LSM blob is allocated for LSMs that need them.
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
+int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
+			   struct bpf_token *token)
 {
-	return call_int_hook(bpf_prog_alloc_security, 0, aux);
+	return call_int_hook(bpf_prog_load, 0, prog, attr, token);
 }
 
 /**
@@ -5204,14 +5209,14 @@ void security_bpf_map_free(struct bpf_map *map)
 }
 
 /**
- * security_bpf_prog_free() - Free a bpf program's LSM blob
- * @aux: bpf program aux info struct
+ * security_bpf_prog_free() - Free a BPF program's LSM blob
+ * @prog: BPF program struct
  *
- * Clean up the security information stored inside bpf prog.
+ * Clean up the security information stored inside BPF program.
  */
-void security_bpf_prog_free(struct bpf_prog_aux *aux)
+void security_bpf_prog_free(struct bpf_prog *prog)
 {
-	call_void_hook(bpf_prog_free_security, aux);
+	call_void_hook(bpf_prog_free, prog);
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2aa0e219d721..f386adb0f27d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6805,7 +6805,8 @@ static void selinux_bpf_map_free(struct bpf_map *map)
 	kfree(bpfsec);
 }
 
-static int selinux_bpf_prog_alloc(struct bpf_prog_aux *aux)
+static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
+				 struct bpf_token *token)
 {
 	struct bpf_security_struct *bpfsec;
 
@@ -6814,16 +6815,16 @@ static int selinux_bpf_prog_alloc(struct bpf_prog_aux *aux)
 		return -ENOMEM;
 
 	bpfsec->sid = current_sid();
-	aux->security = bpfsec;
+	prog->aux->security = bpfsec;
 
 	return 0;
 }
 
-static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
+static void selinux_bpf_prog_free(struct bpf_prog *prog)
 {
-	struct bpf_security_struct *bpfsec = aux->security;
+	struct bpf_security_struct *bpfsec = prog->aux->security;
 
-	aux->security = NULL;
+	prog->aux->security = NULL;
 	kfree(bpfsec);
 }
 #endif
@@ -7180,7 +7181,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
 	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
 	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
-	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
+	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
@@ -7238,7 +7239,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 #endif
 #ifdef CONFIG_BPF_SYSCALL
 	LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
-	LSM_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
+	LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
 #endif
 #ifdef CONFIG_PERF_EVENTS
 	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
-- 
2.34.1

