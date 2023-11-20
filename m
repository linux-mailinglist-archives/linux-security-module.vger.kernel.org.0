Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99957F1464
	for <lists+linux-security-module@lfdr.de>; Mon, 20 Nov 2023 14:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjKTN2Z (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 20 Nov 2023 08:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTN2Z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Nov 2023 08:28:25 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E628113
        for <linux-security-module@vger.kernel.org>; Mon, 20 Nov 2023 05:28:21 -0800 (PST)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3AKDRagN045739;
        Mon, 20 Nov 2023 22:27:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Mon, 20 Nov 2023 22:27:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3AKDRaAJ045731
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Nov 2023 22:27:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
Date:   Mon, 20 Nov 2023 22:27:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-security-module <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, renauld@google.com,
        Paolo Abeni <pabeni@redhat.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH v2 0/4] LSM: Officially support appending LSM hooks after
 boot.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This functionality will be used by TOMOYO security module.

In order to officially use an LSM module, that LSM module has to be
built into vmlinux. This limitation has been a big barrier for allowing
distribution kernel users to use LSM modules which the organization who
builds that distribution kernel cannot afford supporting [1]. Therefore,
I've been asking for ability to append LSM hooks from LKM-based LSMs so
that distribution kernel users can use LSMs which the organization who
builds that distribution kernel cannot afford supporting.

In order to unofficially use LSMs which are not built into vmlinux,
I've been maintaining AKARI as an LKM-based LSM which can run on kernels
between 2.6.0 and 6.6. But KP Singh's "Reduce overhead of LSMs with static
calls" proposal will make AKARI more difficult to run because it removes
the linked list. Therefore, reviving ability to officially append LSM
hooks from LKM-based LSMs became an urgent matter.

KP Singh suggested me to implement such LSMs as eBPF programs. But the
result is that eBPF is too restricted to emulate such LSMs [2]. Therefore,
I still need ability to append LSM hooks from LKM-based LSMs.

KP Singh commented

  I think what you can do is send patches for an API for LKM based LSMs
  and have it merged before my series, I will work with the code I have
  and make LKM based LSMs work. If this work gets merged, and your
  use-case is accepted (I think I can speak for at least Kees [if not
  others] too here) we will help you if you get stuck with MAX_LSM_COUNT
  or a dual static call and linked list based approach.

at [3] and I posted one at [4] but I didn't get any response.

Anyway, here is an updated version. This version focused on how to
implement an LSM module which calls LSM hooks in the LKM based LSMs
(mod_lsm). Since there are a lot of duplication between
security/security.c and security/mod_lsm.c , I tried to auto-genarate
typical functions using macros.

The result is that, although I succeeded to avoid bloating total lines
of source code, I feel that it might become less readable. Therefore,
I came to think that we don't need to implement an LSM module which calls
LSM hooks in the LKM based LSMs.

 b/include/linux/bpf_lsm.h       |    1
 b/include/linux/lsm_hook_args.h |  250 +++++++++++++++++++++++++
 b/include/linux/lsm_hook_defs.h |    3
 b/include/linux/lsm_hooks.h     |    2
 b/kernel/bpf/bpf_lsm.c          |    3
 b/security/Makefile             |    2
 b/security/bpf/hooks.c          |    1
 b/security/mod_lsm.c            |  321 ++++++++++++++++++++++++++++++++
 b/security/security.c           |    3
 include/linux/lsm_hook_defs.h   |  780 ++++++++++++++++++++++++++++++++++++++++++-------------------------------------
 include/linux/lsm_hooks.h       |    9
 security/security.c             |  752 ++--------------------------------------------------------------------------
 12 files changed, 1035 insertions(+), 1092 deletions(-)

Instead, directly embedding the code to call LSM hooks in the LKM based
LSMs into call_int_hook() and call_void_hook() macros will save a lot of
symbols compared to implementing functions for calling LSM hooks in the
LKM based LSMs. Since LKM-based LSMs was not officially supported as of
introduction of the lsm= parameter, forcing to call LKM-based LSMs after
calling built-in LSMs will not confuse userspace.

Unless someone has objection on not using an LSM module which calls
LSM hooks in the LKM based LSMs, I'd like to try something like below
in the next version.

 #define call_void_hook(FUNC, ...)				\
 	do {							\
 		struct security_hook_list *P;			\
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
 			P->hook.FUNC(__VA_ARGS__);		\
+		if (mod_lsm_enabled) {				\
+			hlist_for_each_entry(P, &mod_lsm_hook_heads.FUNC, list) \
+				P->hook.FUNC(__VA_ARGS__);	\
+		}						\
 	} while (0)
 
 #define call_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
 	do {							\
 		struct security_hook_list *P;			\
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
 			RC = P->hook.FUNC(__VA_ARGS__);		\
 			if (RC != 0)				\
 				break;				\
 		}						\
+		if (mod_lsm_enabled) {				\
+			hlist_for_each_entry(P, &mod_lsm_hook_heads.FUNC, list) { \
+				RC = P->hook.FUNC(__VA_ARGS__);	\
+				if (RC != 0)			\
+					break;			\
+			}					\
+		}						\
 	} while (0);						\
 	RC;							\
 })

Link: https://lkml.kernel.org/r/9b006dfe-450e-4d73-8117-9625d2586dad@I-love.SAKURA.ne.jp [1]
Link: https://lkml.kernel.org/r/c588ca5d-c343-4ea2-a1f1-4efe67ebb8e3@I-love.SAKURA.ne.jp [2]
Link: https://lkml.kernel.org/r/CACYkzJ7ght66802wQFKzokfJKMKDOobYgeaCpu5Gx=iX0EuJVg@mail.gmail.com [3]
Link: https://lkml.kernel.org/r/38b318a5-0a16-4cc2-878e-4efa632236f3@I-love.SAKURA.ne.jp [4]
