Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795867B2688
	for <lists+linux-security-module@lfdr.de>; Thu, 28 Sep 2023 22:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjI1UYs (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 28 Sep 2023 16:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjI1UYp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Sep 2023 16:24:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BED3180
        for <linux-security-module@vger.kernel.org>; Thu, 28 Sep 2023 13:24:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB873C433CA;
        Thu, 28 Sep 2023 20:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695932682;
        bh=ltuZe/rM1BIJNPuH/Wr+n6heDSWfyAYXeMHoQ1Ifq5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezxdkgdXtE+3IlBUWsSig7nppFGaQ6VRviyLHsLrzUgSDD+K2tDQY7DCYaBG7F0C2
         htPqM+KFsnA3ATi1NGAvenIYQUL+t9bJpBKtUdSbxEpMgYGY38bfF6bT2uvOEytGdJ
         qgj/qzVJqL38BPP70l0n8W2ZnJ9348ZdS7rWzT97ZOp1MllcGV15NsL9XUxJhsNMkg
         aPBJ6DczOOTUKD9tGHqBV7V6301kukqzfUnFVPOlKl9v5CvnbcgBepPJsv9SW6beWn
         9pTLKZ6DUl99O3zCWuVbDaMnP2GhK39vq/3GEALE0ffz+AVSSlXYTaP+3PedJizTgb
         q/sPKMtz6ERkg==
From:   KP Singh <kpsingh@kernel.org>
To:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        kpsingh@kernel.org, renauld@google.com
Subject: [PATCH v5 4/5] bpf: Only enable BPF LSM hooks when an LSM program is attached
Date:   Thu, 28 Sep 2023 22:24:09 +0200
Message-ID: <20230928202410.3765062-5-kpsingh@kernel.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20230928202410.3765062-1-kpsingh@kernel.org>
References: <20230928202410.3765062-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

BPF LSM hooks have side-effects (even when a default value is returned),
as some hooks end up behaving differently due to the very presence of
the hook.

The static keys guarding the BPF LSM hooks are disabled by default and
enabled only when a BPF program is attached implementing the hook
logic. This avoids the issue of the side-effects and also the minor
overhead associated with the empty callback.

security_file_ioctl:
   0xffffffff818f0e30 <+0>:	endbr64
   0xffffffff818f0e34 <+4>:	nopl   0x0(%rax,%rax,1)
   0xffffffff818f0e39 <+9>:	push   %rbp
   0xffffffff818f0e3a <+10>:	push   %r14
   0xffffffff818f0e3c <+12>:	push   %rbx
   0xffffffff818f0e3d <+13>:	mov    %rdx,%rbx
   0xffffffff818f0e40 <+16>:	mov    %esi,%ebp
   0xffffffff818f0e42 <+18>:	mov    %rdi,%r14
   0xffffffff818f0e45 <+21>:	jmp    0xffffffff818f0e57 <security_file_ioctl+39>
   				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   Static key enabled for SELinux

   0xffffffff818f0e47 <+23>:	xchg   %ax,%ax
   				^^^^^^^^^^^^^^

   Static key disabled for BPF. This gets patched when a BPF LSM program
   is attached

   0xffffffff818f0e49 <+25>:	xor    %eax,%eax
   0xffffffff818f0e4b <+27>:	xchg   %ax,%ax
   0xffffffff818f0e4d <+29>:	pop    %rbx
   0xffffffff818f0e4e <+30>:	pop    %r14
   0xffffffff818f0e50 <+32>:	pop    %rbp
   0xffffffff818f0e51 <+33>:	cs jmp 0xffffffff82c00000 <__x86_return_thunk>
   0xffffffff818f0e57 <+39>:	endbr64
   0xffffffff818f0e5b <+43>:	mov    %r14,%rdi
   0xffffffff818f0e5e <+46>:	mov    %ebp,%esi
   0xffffffff818f0e60 <+48>:	mov    %rbx,%rdx
   0xffffffff818f0e63 <+51>:	call   0xffffffff819033c0 <selinux_file_ioctl>
   0xffffffff818f0e68 <+56>:	test   %eax,%eax
   0xffffffff818f0e6a <+58>:	jne    0xffffffff818f0e4d <security_file_ioctl+29>
   0xffffffff818f0e6c <+60>:	jmp    0xffffffff818f0e47 <security_file_ioctl+23>
   0xffffffff818f0e6e <+62>:	endbr64
   0xffffffff818f0e72 <+66>:	mov    %r14,%rdi
   0xffffffff818f0e75 <+69>:	mov    %ebp,%esi
   0xffffffff818f0e77 <+71>:	mov    %rbx,%rdx
   0xffffffff818f0e7a <+74>:	call   0xffffffff8141e3b0 <bpf_lsm_file_ioctl>
   0xffffffff818f0e7f <+79>:	test   %eax,%eax
   0xffffffff818f0e81 <+81>:	jne    0xffffffff818f0e4d <security_file_ioctl+29>
   0xffffffff818f0e83 <+83>:	jmp    0xffffffff818f0e49 <security_file_ioctl+25>
   0xffffffff818f0e85 <+85>:	endbr64
   0xffffffff818f0e89 <+89>:	mov    %r14,%rdi
   0xffffffff818f0e8c <+92>:	mov    %ebp,%esi
   0xffffffff818f0e8e <+94>:	mov    %rbx,%rdx
   0xffffffff818f0e91 <+97>:	pop    %rbx
   0xffffffff818f0e92 <+98>:	pop    %r14
   0xffffffff818f0e94 <+100>:	pop    %rbp
   0xffffffff818f0e95 <+101>:	ret

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h       |  1 +
 include/linux/bpf_lsm.h   |  5 +++++
 include/linux/lsm_hooks.h | 13 ++++++++++++-
 kernel/bpf/trampoline.c   | 29 +++++++++++++++++++++++++++--
 security/bpf/hooks.c      | 25 ++++++++++++++++++++++++-
 security/security.c       |  3 ++-
 6 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 08b10a422560..9a81e0396aaa 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1159,6 +1159,7 @@ struct bpf_attach_target_info {
 	struct module *tgt_mod;
 	const char *tgt_name;
 	const struct btf_type *tgt_type;
+	bool is_lsm_target;
 };
 
 #define BPF_DISPATCHER_MAX 48 /* Fits in 2048B */
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 1de7ece5d36d..5bbc31ac948c 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -29,6 +29,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id);
 bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
+void bpf_lsm_toggle_hook(void *addr, bool value);
 
 static inline struct bpf_storage_blob *bpf_inode(
 	const struct inode *inode)
@@ -78,6 +79,10 @@ static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 {
 }
 
+static inline void bpf_lsm_toggle_hook(void *addr, bool value)
+{
+}
+
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c77a1859214d..57ffe4eb6d30 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -97,11 +97,14 @@ struct lsm_static_calls_table {
  * @scalls: The beginning of the array of static calls assigned to this hook.
  * @hook: The callback for the hook.
  * @lsm: The name of the lsm that owns this hook.
+ * @default_state: The state of the LSM hook when initialized. If set to false,
+ * the static key guarding the hook will be set to disabled.
  */
 struct security_hook_list {
 	struct lsm_static_call	*scalls;
 	union security_list_options	hook;
 	const char			*lsm;
+	bool				default_state;
 } __randomize_layout;
 
 /*
@@ -151,7 +154,15 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
 #define LSM_HOOK_INIT(NAME, CALLBACK)			\
 	{						\
 		.scalls = static_calls_table.NAME,	\
-		.hook = { .NAME = CALLBACK }		\
+		.hook = { .NAME = CALLBACK },		\
+		.default_state = true			\
+	}
+
+#define LSM_HOOK_INIT_DISABLED(NAME, CALLBACK)		\
+	{						\
+		.scalls = static_calls_table.NAME,	\
+		.hook = { .NAME = CALLBACK },		\
+		.default_state = false			\
 	}
 
 extern char *lsm_names;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e97aeda3a86b..df9699bce372 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/bpf_lsm.h>
 #include <linux/delay.h>
+#include <linux/bpf_lsm.h>
 
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
@@ -514,7 +515,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
 {
 	enum bpf_tramp_prog_type kind;
 	struct bpf_tramp_link *link_exiting;
-	int err = 0;
+	int err = 0, num_lsm_progs = 0;
 	int cnt = 0, i;
 
 	kind = bpf_attach_type_to_tramp(link->link.prog);
@@ -545,8 +546,14 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
 			continue;
 		/* prog already linked */
 		return -EBUSY;
+
+		if (link_exiting->link.prog->type == BPF_PROG_TYPE_LSM)
+			num_lsm_progs++;
 	}
 
+	if (!num_lsm_progs && link->link.prog->type == BPF_PROG_TYPE_LSM)
+		bpf_lsm_toggle_hook(tr->func.addr, true);
+
 	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
 	tr->progs_cnt[kind]++;
 	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
@@ -569,8 +576,10 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline
 
 static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
 {
+	struct bpf_tramp_link *link_exiting;
 	enum bpf_tramp_prog_type kind;
-	int err;
+	bool lsm_link_found = false;
+	int err, num_lsm_progs = 0;
 
 	kind = bpf_attach_type_to_tramp(link->link.prog);
 	if (kind == BPF_TRAMP_REPLACE) {
@@ -580,8 +589,24 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
 		tr->extension_prog = NULL;
 		return err;
 	}
+
+	if (link->link.prog->type == BPF_PROG_TYPE_LSM) {
+		hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind],
+				     tramp_hlist) {
+			if (link_exiting->link.prog->type == BPF_PROG_TYPE_LSM)
+				num_lsm_progs++;
+
+			if (link_exiting->link.prog == link->link.prog)
+				lsm_link_found = true;
+		}
+	}
+
 	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
+
+	if (lsm_link_found && num_lsm_progs == 1)
+		bpf_lsm_toggle_hook(tr->func.addr, false);
+
 	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 }
 
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index cfaf1d0e6a5f..1957244196d0 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -8,7 +8,7 @@
 
 static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
-	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
+	LSM_HOOK_INIT_DISABLED(NAME, bpf_lsm_##NAME),
 	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
 	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
@@ -32,3 +32,26 @@ DEFINE_LSM(bpf) = {
 	.init = bpf_lsm_init,
 	.blobs = &bpf_lsm_blob_sizes
 };
+
+void bpf_lsm_toggle_hook(void *addr, bool value)
+{
+	struct lsm_static_call *scalls;
+	struct security_hook_list *h;
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(bpf_lsm_hooks); i++) {
+		h = &bpf_lsm_hooks[i];
+		scalls = h->scalls;
+		if (h->hook.lsm_callback == addr)
+			continue;
+
+		for (j = 0; j < MAX_LSM_COUNT; j++) {
+			if (scalls[j].hl != h)
+				continue;
+			if (value)
+				static_branch_enable(scalls[j].active);
+			else
+				static_branch_disable(scalls[j].active);
+		}
+	}
+}
diff --git a/security/security.c b/security/security.c
index c2c2cf6b711f..d1ee72e563cc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -382,7 +382,8 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
 			__static_call_update(scall->key, scall->trampoline,
 					     hl->hook.lsm_callback);
 			scall->hl = hl;
-			static_branch_enable(scall->active);
+			if (hl->default_state)
+				static_branch_enable(scall->active);
 			return;
 		}
 		scall++;
-- 
2.42.0.582.g8ccd20d70d-goog

