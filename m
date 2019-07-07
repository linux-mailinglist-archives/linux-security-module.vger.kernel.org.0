Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985706101A
	for <lists+linux-security-module@lfdr.de>; Sat,  6 Jul 2019 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfGFKzt (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 6 Jul 2019 06:55:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50411 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfGFKzW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Jul 2019 06:55:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so1040441wml.0;
        Sat, 06 Jul 2019 03:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HSNnsoi40sXC9a5NBIzV0J+z/SUw5gqWPuXVFawRMYc=;
        b=V7AvK11reWJTiJ1DMourV1U4KNoutKJGDoiTGDXXM3R+PR5LpFynIPMuHGWbUmIT6N
         62QOnfL7Spg5I7UppXlkG9bH566FlMkdYX2c5mITv+X49REEJ7TzTRD5C+iQfoN/4rPl
         UgKMTPNUamuI84pgZfGnM+KdecKNvQnLCdW9YiA5ieNyU+3CJjFBApwua+MKXWYTWR3W
         cDjDfWnzPiKTGrdUhnTZwNc+HFKvMUxWxCZ7CxTIxdI37rHw++WBf8TzZNY7DbiPJbPx
         Vi4i+Oh39vDEODfCMLRruFPTteb2P7fgj4MRU+BMXpmRVkxdZYPg4w23p2aEvnIp8KBu
         br5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HSNnsoi40sXC9a5NBIzV0J+z/SUw5gqWPuXVFawRMYc=;
        b=alHoR7aS+a2OjMWB1mlH8/CwwhHX+kw8FGpma7M+jkEbLTPHfpq9FtuWOhreRVRwld
         19z5cesZDMsKeYcWZO+HS8DQodGEaX0IvOmeVhESHxcizaVYjpM6rSOdZJQkghAbcHZB
         Nz1m3HqIeVTEs+h4/ZWOpgq57bTO1KvZ5toDCHoPY1M1hpv7TNgTkR2D2koVjzFAj5Ty
         s1OjPu/rfLN2KurWDFokrSZUmae9OJS1CLDaUsZPBAjLgONqaIp/7TBh/fWUvwwijiqg
         VdW5kNDGzwNwA0fvkadwDOoo5qI1c2bU+GDT1Ux84kihPyHwOqMspJeQm49GMG5P6nvG
         Zh4g==
X-Gm-Message-State: APjAAAXs6SyAPCat3RxKXA+ObWfivpGPVGDL263AG6+FXQ9wG/BkC/cu
        sMv7Cs8aJxS8OxJEl9bzQbwQEL79o6RcmQ==
X-Google-Smtp-Source: APXvYqxTOz8ZdoRBiRrROUWhnI6SyewPlaUzoSCGW9GiCDm2WtNdoe4eOEEH3/a8B3ek3jvZ4FdMSg==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr8125351wmi.14.1562410519789;
        Sat, 06 Jul 2019 03:55:19 -0700 (PDT)
Received: from localhost (net-93-71-3-102.cust.vodafonedsl.it. [93.71.3.102])
        by smtp.gmail.com with ESMTPSA id h11sm12578794wrx.93.2019.07.06.03.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jul 2019 03:55:18 -0700 (PDT)
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 07/12] LSM: creation of "pagefault_handler" LSM hook
Date:   Sat,  6 Jul 2019 12:54:48 +0200
Message-Id: <1562410493-8661-8-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Creation of a new hook to let LSM modules handle user-space pagefaults on
x86.
It can be used to avoid segfaulting the originating process.
If it's the case it can modify process registers before returning.
This is not a security feature by itself, it's a way to soften some
unwanted side-effects of restrictive security features.
In particular this is used by S.A.R.A. to implement what PaX call
"trampoline emulation" that, in practice, allows for some specific
code sequences to be executed even if they are in non executable memory.
This may look like a bad thing at first, but you have to consider
that:
- This allows for strict memory restrictions (e.g. W^X) to stay on even
  when they should be turned off. And, even if this emulation
  makes those features less effective, it's still better than having
  them turned off completely.
- The only code sequences emulated are trampolines used to make
  function calls. In many cases, when you have the chance to
  make arbitrary memory writes, you can already manipulate the
  control flow of the program by overwriting function pointers or
  return values. So, in many cases, "trampoline emulation"
  doesn't introduce new exploit vectors.
- It's a feature that can be turned on only if needed, on a per
  executable file basis.

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 arch/Kconfig              |  6 ++++++
 arch/x86/Kconfig          |  1 +
 arch/x86/mm/fault.c       |  6 ++++++
 include/linux/lsm_hooks.h | 12 ++++++++++++
 include/linux/security.h  | 11 +++++++++++
 security/security.c       | 11 +++++++++++
 6 files changed, 47 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index c47b328..16997c3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -252,6 +252,12 @@ config ARCH_HAS_FORTIFY_SOURCE
 config ARCH_HAS_KEEPINITRD
 	bool
 
+config ARCH_HAS_LSM_PAGEFAULT
+	bool
+	help
+	  An architecture should select this if it supports
+	  "pagefault_handler" LSM hook.
+
 # Select if arch has all set_memory_ro/rw/x/nx() functions in asm/cacheflush.h
 config ARCH_HAS_SET_MEMORY
 	bool
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d..a3c7660 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -67,6 +67,7 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_LSM_PAGEFAULT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 46df4c6..7fe36f1 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
 #include <linux/efi.h>			/* efi_recover_from_page_fault()*/
 #include <linux/mm_types.h>
+#include <linux/security.h>		/* security_pagefault_handler	*/
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1360,6 +1361,11 @@ void do_user_addr_fault(struct pt_regs *regs,
 			local_irq_enable();
 	}
 
+	if (unlikely(security_pagefault_handler(regs,
+						hw_error_code,
+						address)))
+		return;
+
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
 	if (hw_error_code & X86_PF_WRITE)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 12ce609..478a187 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -518,6 +518,14 @@
  *	@vmflags contains the requested vmflags.
  *	Return 0 if the operation is allowed to continue otherwise return
  *	the appropriate error code.
+ * @pagefault_handler:
+ *	Handle pagefaults on supported architectures, that is any architecture
+ *	which defines CONFIG_ARCH_HAS_LSM_PAGEFAULT.
+ *	@regs contains process' registers.
+ *	@error_code contains error code for the pagefault.
+ *	@address contains the address that caused the pagefault.
+ *	Return 0 to let the kernel handle the pagefault as usually, any other
+ *	value to let the process continue its execution.
  * @file_lock:
  *	Check permission before performing file locking operations.
  *	Note the hook mediates both flock and fcntl style locks.
@@ -1603,6 +1611,9 @@
 	int (*file_mprotect)(struct vm_area_struct *vma, unsigned long reqprot,
 				unsigned long prot);
 	int (*check_vmflags)(vm_flags_t vmflags);
+	int (*pagefault_handler)(struct pt_regs *regs,
+				 unsigned long error_code,
+				 unsigned long address);
 	int (*file_lock)(struct file *file, unsigned int cmd);
 	int (*file_fcntl)(struct file *file, unsigned int cmd,
 				unsigned long arg);
@@ -1904,6 +1915,7 @@ struct security_hook_heads {
 	struct hlist_head mmap_file;
 	struct hlist_head file_mprotect;
 	struct hlist_head check_vmflags;
+	struct hlist_head pagefault_handler;
 	struct hlist_head file_lock;
 	struct hlist_head file_fcntl;
 	struct hlist_head file_set_fowner;
diff --git a/include/linux/security.h b/include/linux/security.h
index aed78eb..c287eb2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -313,6 +313,9 @@ int security_mmap_file(struct file *file, unsigned long prot,
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			   unsigned long prot);
 int security_check_vmflags(vm_flags_t vmflags);
+int __maybe_unused security_pagefault_handler(struct pt_regs *regs,
+					      unsigned long error_code,
+					      unsigned long address);
 int security_file_lock(struct file *file, unsigned int cmd);
 int security_file_fcntl(struct file *file, unsigned int cmd, unsigned long arg);
 void security_file_set_fowner(struct file *file);
@@ -865,6 +868,14 @@ static inline int security_check_vmflags(vm_flags_t vmflags)
 	return 0;
 }
 
+static inline int __maybe_unused security_pagefault_handler(
+						struct pt_regs *regs,
+						unsigned long error_code,
+						unsigned long address)
+{
+	return 0;
+}
+
 static inline int security_file_lock(struct file *file, unsigned int cmd)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 3308e89..a8bdcf3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1426,6 +1426,17 @@ int security_check_vmflags(vm_flags_t vmflags)
 	return call_int_hook(check_vmflags, 0, vmflags);
 }
 
+int __maybe_unused security_pagefault_handler(struct pt_regs *regs,
+					      unsigned long error_code,
+					      unsigned long address)
+{
+	return call_int_hook(pagefault_handler,
+			     0,
+			     regs,
+			     error_code,
+			     address);
+}
+
 int security_file_lock(struct file *file, unsigned int cmd)
 {
 	return call_int_hook(file_lock, 0, file, cmd);
-- 
1.9.1

