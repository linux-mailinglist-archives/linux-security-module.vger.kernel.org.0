Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7257E8A22
	for <lists+linux-security-module@lfdr.de>; Sat, 11 Nov 2023 11:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjKKKIj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 11 Nov 2023 05:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjKKKIi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 11 Nov 2023 05:08:38 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C0B3AA6
        for <linux-security-module@vger.kernel.org>; Sat, 11 Nov 2023 02:08:34 -0800 (PST)
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3ABA7no7035784;
        Sat, 11 Nov 2023 19:07:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Sat, 11 Nov 2023 19:07:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3ABA7mvX035781
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 11 Nov 2023 19:07:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <38b318a5-0a16-4cc2-878e-4efa632236f3@I-love.SAKURA.ne.jp>
Date:   Sat, 11 Nov 2023 19:07:48 +0900
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
Subject: [RFC PATCH 0/5] LSM: Officially support appending LSM hooks after
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

at [3] but I made this series on top of "[PATCH v7 0/5] Reduce overhead
of LSMs with static calls", for I wanted to know how to use static_calls()
and how does appending LSM hooks after boot will look like, with a hope
that LSM hooks that are appended after boot can also use static calls
so that the same structures/macros can be used for both built-in and
loadable LSM modules.

The result seems to be that linked list and static_call() are not
compatible, for a unique symbol name has to be assigned to each static
call. But I felt that we could avoid loop unrolling if we change the
direction from "call all individual callbacks from security/security.c"
to "call next callback at end of current callback if current callback
succeeded and next callback is defined, and security/security.c calls
only the first callback".

Link: https://lkml.kernel.org/r/9b006dfe-450e-4d73-8117-9625d2586dad@I-love.SAKURA.ne.jp [1]
Link: https://lkml.kernel.org/r/c588ca5d-c343-4ea2-a1f1-4efe67ebb8e3@I-love.SAKURA.ne.jp [2]
Link: https://lkml.kernel.org/r/CACYkzJ7ght66802wQFKzokfJKMKDOobYgeaCpu5Gx=iX0EuJVg@mail.gmail.com [3]
