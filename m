Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88F57A54F9
	for <lists+linux-security-module@lfdr.de>; Mon, 18 Sep 2023 23:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjIRVZj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 18 Sep 2023 17:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjIRVZc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Sep 2023 17:25:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489B310F
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 14:25:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188C3C4339A;
        Mon, 18 Sep 2023 21:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695072324;
        bh=o+Qnr9EsgdOQWCkgHDNsBAdiCeKyZeGW1epphAhaKKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVFufaqqMLmX8/XgIzp7ExQO5RK4b0B7c2Fbhqyvhg+xa/hqENUK3vE5stltN5PLC
         keFMC+UTVQhhsFCrvbRQWI7kQPIObL+6GK7CVoknmsVOyk8qGYWmklHnYN4UDj2A8J
         LNNlx5PA6aLkP8RM2zIGdCx7BUVENJZxXe8jHlxjxCyxQvWtkYQv7F/XgxpCWAgEAP
         KomRH6acTE7oV9WeZymmf1ev+bd/iqP7e71imfqfnDfjY9ARH89ZHcy8u5lMIftMsq
         UUYHme79gn/LnDXZVKHYrbB2gQJVLM3PdDr3NeUMF+LEGnHomX+lfp0DMymig1hoNC
         9AQlIg18Y/ljQ==
From:   KP Singh <kpsingh@kernel.org>
To:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        kpsingh@kernel.org
Subject: [PATCH v3 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Date:   Mon, 18 Sep 2023 23:24:59 +0200
Message-ID: <20230918212459.1937798-6-kpsingh@kernel.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230918212459.1937798-1-kpsingh@kernel.org>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This config influences the nature of the static key that guards the
static call for LSM hooks.

When enabled, it indicates that an LSM static call slot is more likely
to be initialized. When disabled, it optimizes for the case when static
call slot is more likely to be not initialized.

When a major LSM like (SELinux, AppArmor, Smack etc) is active on a
system the system would benefit from enabling the config. However there
are other cases which would benefit from the config being disabled
(e.g. a system with a BPF LSM with no hooks enabled by default, or an
LSM like loadpin / yama). Ultimately, there is no one-size fits all
solution.

with CONFIG_SECURITY_HOOK_LIKELY enabled, the inactive /
uninitialized case is penalized with a direct jmp (still better than
an indirect jmp):

function security_file_ioctl:
   0xffffffff818f0c80 <+0>:	endbr64
   0xffffffff818f0c84 <+4>:	nopl   0x0(%rax,%rax,1)
   0xffffffff818f0c89 <+9>:	push   %rbp
   0xffffffff818f0c8a <+10>:	push   %r14
   0xffffffff818f0c8c <+12>:	push   %rbx
   0xffffffff818f0c8d <+13>:	mov    %rdx,%rbx
   0xffffffff818f0c90 <+16>:	mov    %esi,%ebp
   0xffffffff818f0c92 <+18>:	mov    %rdi,%r14
   0xffffffff818f0c95 <+21>:	jmp    0xffffffff818f0ca8 <security_file_ioctl+40>

   jump to skip the inactive BPF LSM hook.

   0xffffffff818f0c97 <+23>:	mov    %r14,%rdi
   0xffffffff818f0c9a <+26>:	mov    %ebp,%esi
   0xffffffff818f0c9c <+28>:	mov    %rbx,%rdx
   0xffffffff818f0c9f <+31>:	call   0xffffffff8141e3b0 <bpf_lsm_file_ioctl>
   0xffffffff818f0ca4 <+36>:	test   %eax,%eax
   0xffffffff818f0ca6 <+38>:	jne    0xffffffff818f0cbf <security_file_ioctl+63>
   0xffffffff818f0ca8 <+40>:	endbr64
   0xffffffff818f0cac <+44>:	jmp    0xffffffff818f0ccd <security_file_ioctl+77>

   jump to skip the empty slot.

   0xffffffff818f0cae <+46>:	mov    %r14,%rdi
   0xffffffff818f0cb1 <+49>:	mov    %ebp,%esi
   0xffffffff818f0cb3 <+51>:	mov    %rbx,%rdx
   0xffffffff818f0cb6 <+54>:	nopl   0x0(%rax,%rax,1)
  				^^^^^^^^^^^^^^^^^^^^^^^
				Empty slot

   0xffffffff818f0cbb <+59>:	test   %eax,%eax
   0xffffffff818f0cbd <+61>:	je     0xffffffff818f0ccd <security_file_ioctl+77>
   0xffffffff818f0cbf <+63>:	endbr64
   0xffffffff818f0cc3 <+67>:	pop    %rbx
   0xffffffff818f0cc4 <+68>:	pop    %r14
   0xffffffff818f0cc6 <+70>:	pop    %rbp
   0xffffffff818f0cc7 <+71>:	cs jmp 0xffffffff82c00000 <__x86_return_thunk>
   0xffffffff818f0ccd <+77>:	endbr64
   0xffffffff818f0cd1 <+81>:	xor    %eax,%eax
   0xffffffff818f0cd3 <+83>:	jmp    0xffffffff818f0cbf <security_file_ioctl+63>
   0xffffffff818f0cd5 <+85>:	mov    %r14,%rdi
   0xffffffff818f0cd8 <+88>:	mov    %ebp,%esi
   0xffffffff818f0cda <+90>:	mov    %rbx,%rdx
   0xffffffff818f0cdd <+93>:	pop    %rbx
   0xffffffff818f0cde <+94>:	pop    %r14
   0xffffffff818f0ce0 <+96>:	pop    %rbp
   0xffffffff818f0ce1 <+97>:	ret

When the config is disabled, the case optimizes the scenario above.

security_file_ioctl:
   0xffffffff818f0e30 <+0>:	endbr64
   0xffffffff818f0e34 <+4>:	nopl   0x0(%rax,%rax,1)
   0xffffffff818f0e39 <+9>:	push   %rbp
   0xffffffff818f0e3a <+10>:	push   %r14
   0xffffffff818f0e3c <+12>:	push   %rbx
   0xffffffff818f0e3d <+13>:	mov    %rdx,%rbx
   0xffffffff818f0e40 <+16>:	mov    %esi,%ebp
   0xffffffff818f0e42 <+18>:	mov    %rdi,%r14
   0xffffffff818f0e45 <+21>:	xchg   %ax,%ax
   0xffffffff818f0e47 <+23>:	xchg   %ax,%ax

   The static keys in their disabled state do not create jumps leading
   to faster code.

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
   0xffffffff818f0e63 <+51>:	call   0xffffffff8141e3b0 <bpf_lsm_file_ioctl>
   0xffffffff818f0e68 <+56>:	test   %eax,%eax
   0xffffffff818f0e6a <+58>:	jne    0xffffffff818f0e4d <security_file_ioctl+29>
   0xffffffff818f0e6c <+60>:	jmp    0xffffffff818f0e47 <security_file_ioctl+23>
   0xffffffff818f0e6e <+62>:	endbr64
   0xffffffff818f0e72 <+66>:	mov    %r14,%rdi
   0xffffffff818f0e75 <+69>:	mov    %ebp,%esi
   0xffffffff818f0e77 <+71>:	mov    %rbx,%rdx
   0xffffffff818f0e7a <+74>:	nopl   0x0(%rax,%rax,1)
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

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 security/Kconfig    | 11 +++++++++++
 security/security.c | 12 +++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 52c9af08ad35..bd2a0dff991a 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -32,6 +32,17 @@ config SECURITY
 
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_HOOK_LIKELY
+	bool "LSM hooks are likely to be initialized"
+	depends on SECURITY
+	default y
+	help
+	  This controls the behaviour of the static keys that guard LSM hooks.
+	  If LSM hooks are likely to be initialized by LSMs, then one gets
+	  better performance by enabling this option. However, if the system is
+	  using an LSM where hooks are much likely to be disabled, one gets
+	  better performance by disabling this config.
+
 config SECURITYFS
 	bool "Enable the securityfs filesystem"
 	help
diff --git a/security/security.c b/security/security.c
index d1ee72e563cc..7ab0e044f83d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -105,9 +105,9 @@ static __initdata struct lsm_info *exclusive;
  * Define static calls and static keys for each LSM hook.
  */
 
-#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)			\
-	DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),		\
-				*((RET(*)(__VA_ARGS__))NULL));		\
+#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)               \
+	DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),       \
+				*((RET(*)(__VA_ARGS__))NULL));    \
 	DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ACTIVE_KEY(NAME, NUM));
 
 #define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
@@ -825,7 +825,8 @@ static int lsm_superblock_alloc(struct super_block *sb)
  */
 #define __CALL_STATIC_VOID(NUM, HOOK, ...)				     \
 do {									     \
-	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {    \
+	if (static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY,		     \
+				&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {     \
 		static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);	     \
 	}								     \
 } while (0);
@@ -837,7 +838,8 @@ do {									     \
 
 #define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)			     \
 do {									     \
-	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
+	if (static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY,		     \
+				&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {     \
 		R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
 		if (R != 0)						     \
 			goto LABEL;					     \
-- 
2.42.0.459.ge4e396fd5e-goog

