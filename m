Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60BA261015
	for <lists+linux-security-module@lfdr.de>; Sat,  6 Jul 2019 12:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfGFKzZ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 6 Jul 2019 06:55:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36152 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfGFKzY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Jul 2019 06:55:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so5769648wme.1;
        Sat, 06 Jul 2019 03:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GuxALAFQ/TNai2yWaUBZYrBAIJmgHr1PeMz07TcuHEk=;
        b=nXuWwFeaFB10NA4V6lB4djfCG4L03Q6YVTn+kObhLt+JnC9zkbzXGcCXqxJ+khdjo0
         uwJBElmo7sJB/OZhWNONnRz0FNfsGlRBcU13eybEa3in1yWNnQhM2ZVWqPKflMf8G9q8
         yJqcXaTPODZ09JeyF2MJJbCLKwcqRKf9n0m5xpF62VdZNkdS7DTRXY1KsNuFyyu6eWg+
         lTH/lyd0NHCcCvuVNS69Bl8/tPzx//CMr/uVPkJbMAvW2/fasALxnJQ69pGmUAuxZX9M
         Iso4mDoYZ17y8anniEhUvdE3SAAb8m0iakYlkfo5QCYApCOkWwUB3c3re0pm1oEW0nq7
         Q8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GuxALAFQ/TNai2yWaUBZYrBAIJmgHr1PeMz07TcuHEk=;
        b=Cj4l14YMKEtEZcw1ewx6eH1Mh0eZwL4tPuAcZ5Yi5mX4K1p59ncAq0Zau8oSBTXPml
         NHZJTWuvo9sRZ5+J4pVp5w3h9uvlucLBMb/yodcJL6ZrB8jlKxsy/L0gitI9mvmmyC/7
         +Estc3+tRcNQJwKUFYlpH3nc6TdQ+urDXGJ54qmpMossRtZiTmu9VK+AjKOEpPx/tvEc
         4HTVxHhP2l7d9DBtzIbbWW1sinjwNfwo1Du4Am4jENru1jQZuNB+kPHknbuJPBGsgUBT
         sEvL1FW/9Dko+gGRW8bSvuqqsko/zG/QsWDe6O3gW2JWSH0hMK5jkqo5f56/3pEpXkTk
         l+Sg==
X-Gm-Message-State: APjAAAXmsM2VxY25XSTNZ6oTo6Crt3LssJ1qs99u4Mp/aoo0PH33Ehce
        vFR+Mw67qSV1c87SXuVElDarMFewv9iDAw==
X-Google-Smtp-Source: APXvYqy1+ynai1OSOQkeLSv5Es/MREYsXma7ZlHF4OC5iwOUmuCSj70NPI+2aNwlq+0KMTWYYdT8cw==
X-Received: by 2002:a1c:c5c2:: with SMTP id v185mr4017391wmf.161.1562410520881;
        Sat, 06 Jul 2019 03:55:20 -0700 (PDT)
Received: from localhost (net-93-71-3-102.cust.vodafonedsl.it. [93.71.3.102])
        by smtp.gmail.com with ESMTPSA id h11sm12578794wrx.93.2019.07.06.03.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jul 2019 03:55:20 -0700 (PDT)
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
Subject: [PATCH v5 08/12] S.A.R.A.: trampoline emulation
Date:   Sat,  6 Jul 2019 12:54:49 +0200
Message-Id: <1562410493-8661-9-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Some programs need to generate part of their code at runtime. Luckily
enough, in some cases they only generate well-known code sequences (the
"trampolines") that can be easily recognized and emulated by the kernel.
This way WX Protection can still be active, so a potential attacker won't
be able to generate arbitrary sequences of code, but just those that are
explicitly allowed. This is not ideal, but it's still better than having WX
Protection completely disabled.
In particular S.A.R.A. is able to recognize trampolines used by GCC for
nested C functions and libffi's trampolines.
This feature is implemented only on x86_32 and x86_64.
Trampoline emulation is modified from Brad Spengler/PaX Team's code in the
last public patch of grsecurity/PaX based on my understanding of the code.
Changes or omissions from the original code are mine and don't reflect the
original grsecurity/PaX code.

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 arch/x86/Kbuild                        |   2 +
 arch/x86/security/Makefile             |   2 +
 arch/x86/security/sara/Makefile        |   1 +
 arch/x86/security/sara/emutramp.c      |  57 ++++++++++++
 arch/x86/security/sara/trampolines32.h | 137 +++++++++++++++++++++++++++
 arch/x86/security/sara/trampolines64.h | 164 +++++++++++++++++++++++++++++++++
 security/sara/Kconfig                  |  18 ++++
 security/sara/include/emutramp.h       |  35 +++++++
 security/sara/wxprot.c                 |  29 ++++++
 9 files changed, 445 insertions(+)
 create mode 100644 arch/x86/security/Makefile
 create mode 100644 arch/x86/security/sara/Makefile
 create mode 100644 arch/x86/security/sara/emutramp.c
 create mode 100644 arch/x86/security/sara/trampolines32.h
 create mode 100644 arch/x86/security/sara/trampolines64.h
 create mode 100644 security/sara/include/emutramp.h

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index 30dec01..4fea778 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -25,3 +25,5 @@ obj-y += platform/
 obj-y += net/
 
 obj-$(CONFIG_KEXEC_FILE) += purgatory/
+
+obj-y += security/
diff --git a/arch/x86/security/Makefile b/arch/x86/security/Makefile
new file mode 100644
index 0000000..ba4be4c
--- /dev/null
+++ b/arch/x86/security/Makefile
@@ -0,0 +1,2 @@
+subdir-$(CONFIG_SECURITY_SARA)		+= sara
+obj-$(CONFIG_SECURITY_SARA)		+= sara/
diff --git a/arch/x86/security/sara/Makefile b/arch/x86/security/sara/Makefile
new file mode 100644
index 0000000..a4a76217
--- /dev/null
+++ b/arch/x86/security/sara/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SECURITY_SARA_WXPROT_EMUTRAMP) := emutramp.o
diff --git a/arch/x86/security/sara/emutramp.c b/arch/x86/security/sara/emutramp.c
new file mode 100644
index 0000000..45122e5
--- /dev/null
+++ b/arch/x86/security/sara/emutramp.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * S.A.R.A. Linux Security Module
+ *
+ * Copyright (C) 2017 Salvatore Mesoraca <s.mesoraca16@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ * Assembly sequences used here were copied from
+ * PaX patch by PaX Team <pageexec@freemail.hu>
+ * Being just hexadecimal constants, they are not subject to
+ * any copyright.
+ *
+ */
+
+#define PF_PROT		(1 << 0)
+#define PF_USER		(1 << 2)
+#define PF_INSTR	(1 << 4)
+
+#ifdef CONFIG_X86_32
+
+#include "trampolines32.h"
+static inline int trampoline_emulator(struct pt_regs *regs,
+				      unsigned long address)
+{
+	return sara_trampoline_emulator_x86_32(regs);
+}
+
+#else /* CONFIG_X86_32 */
+
+#include "trampolines64.h"
+static inline int trampoline_emulator(struct pt_regs *regs,
+				      unsigned long address)
+{
+	return sara_trampoline_emulator_x86_64(regs, address);
+}
+
+#endif /* CONFIG_X86_32 */
+
+
+int sara_trampoline_emulator(struct pt_regs *regs,
+			     unsigned long error_code,
+			     unsigned long address)
+{
+	if (!(error_code & PF_USER) ||
+	    !(error_code & PF_INSTR) ||
+	    !(error_code & PF_PROT))
+		return 0;
+
+	local_irq_enable();
+	might_sleep();
+	might_fault();
+	return trampoline_emulator(regs, address);
+}
diff --git a/arch/x86/security/sara/trampolines32.h b/arch/x86/security/sara/trampolines32.h
new file mode 100644
index 0000000..b3622d0
--- /dev/null
+++ b/arch/x86/security/sara/trampolines32.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * S.A.R.A. Linux Security Module
+ *
+ * Copyright (C) 2017 Salvatore Mesoraca <s.mesoraca16@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ * Assembly sequences used here were copied from
+ * PaX patch by PaX Team <pageexec@freemail.hu>
+ * Being just hexadecimal constants, they are not subject to
+ * any copyright.
+ *
+ */
+
+#ifndef __SARA_TRAMPOLINES32_H
+#define __SARA_TRAMPOLINES32_H
+
+#include <linux/printk.h>
+#include <linux/uaccess.h>
+
+struct libffi_trampoline_x86_32 {
+	unsigned char mov;
+	unsigned int addr1;
+	unsigned char jmp;
+	unsigned int addr2;
+} __packed;
+
+struct gcc_trampoline_x86_32_t1 {
+	unsigned char mov1;
+	unsigned int addr1;
+	unsigned char mov2;
+	unsigned int addr2;
+	unsigned short jmp;
+} __packed;
+
+struct gcc_trampoline_x86_32_t2 {
+	unsigned char mov;
+	unsigned int addr1;
+	unsigned char jmp;
+	unsigned int addr2;
+} __packed;
+
+union trampolines_x86_32 {
+	struct libffi_trampoline_x86_32 lf;
+	struct gcc_trampoline_x86_32_t1 g1;
+	struct gcc_trampoline_x86_32_t2 g2;
+};
+
+static inline int is_libffi_tramp_x86_32(const union trampolines_x86_32 *u)
+{
+	return (u->lf.mov == 0xB8 && u->lf.jmp == 0xE9);
+}
+
+static inline void emu_libffi_tramp_x86_32(const union trampolines_x86_32 *u,
+					   struct pt_regs *regs)
+{
+	regs->ax = u->lf.addr1;
+	regs->ip = (unsigned int) (regs->ip +
+				   u->lf.addr2 +
+				   sizeof(u->lf));
+}
+
+static inline int is_gcc_tramp_x86_32_t1(const union trampolines_x86_32 *u,
+					 const struct pt_regs *regs)
+{
+	return (u->g1.mov1 == 0xB9 &&
+		u->g1.mov2 == 0xB8 &&
+		u->g1.jmp == 0xE0FF &&
+		regs->ip > regs->sp);
+}
+
+static inline void emu_gcc_tramp_x86_32_t1(const union trampolines_x86_32 *u,
+					   struct pt_regs *regs)
+{
+	regs->cx = u->g1.addr1;
+	regs->ax = u->g1.addr2;
+	regs->ip = u->g1.addr2;
+}
+
+static inline int is_gcc_tramp_x86_32_t2(const union trampolines_x86_32 *u,
+					 const struct pt_regs *regs)
+{
+	return (u->g2.mov == 0xB9 &&
+		u->g2.jmp == 0xE9 &&
+		regs->ip > regs->sp);
+}
+
+static inline void emu_gcc_tramp_x86_32_t2(const union trampolines_x86_32 *u,
+					   struct pt_regs *regs)
+{
+	regs->cx = u->g2.addr1;
+	regs->ip = (unsigned int) (regs->ip +
+				   u->g2.addr2 +
+				   sizeof(u->g2));
+}
+
+static inline int sara_trampoline_emulator_x86_32(struct pt_regs *regs)
+{
+	int ret;
+	void __user *ip = (void __user *) regs->ip;
+	union trampolines_x86_32 t; //zero init
+
+	BUILD_BUG_ON(sizeof(t.lf) > sizeof(t.g1));
+	BUILD_BUG_ON(sizeof(t.g2) > sizeof(t.lf));
+
+	ret = copy_from_user(&t, ip, sizeof(t.g1));
+	if (ret)
+		ret = copy_from_user(&t, ip, sizeof(t.lf));
+	if (ret)
+		ret = copy_from_user(&t, ip, sizeof(t.g2));
+	if (ret)
+		return 0;
+
+	if (is_gcc_tramp_x86_32_t1(&t, regs)) {
+		pr_debug("Trampoline: gcc1 x86_32.\n");
+		emu_gcc_tramp_x86_32_t1(&t, regs);
+		return 1;
+	} else if (is_libffi_tramp_x86_32(&t)) {
+		pr_debug("Trampoline: libffi x86_32.\n");
+		emu_libffi_tramp_x86_32(&t, regs);
+		return 1;
+	} else if (is_gcc_tramp_x86_32_t2(&t, regs)) {
+		pr_debug("Trampoline: gcc2 x86_32.\n");
+		emu_gcc_tramp_x86_32_t2(&t, regs);
+		return 1;
+	}
+
+	pr_debug("Not a trampoline (x86_32).\n");
+
+	return 0;
+}
+
+#endif /* __SARA_TRAMPOLINES32_H */
diff --git a/arch/x86/security/sara/trampolines64.h b/arch/x86/security/sara/trampolines64.h
new file mode 100644
index 0000000..c9aaa03
--- /dev/null
+++ b/arch/x86/security/sara/trampolines64.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * S.A.R.A. Linux Security Module
+ *
+ * Copyright (C) 2017 Salvatore Mesoraca <s.mesoraca16@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ * Assembly sequences used here were copied from
+ * PaX patch by PaX Team <pageexec@freemail.hu>
+ * Being just hexadecimal constants, they are not subject to
+ * any copyright.
+ *
+ */
+
+#ifndef __SARA_TRAMPOLINES64_H
+#define __SARA_TRAMPOLINES64_H
+
+#include <linux/printk.h>
+#include <linux/uaccess.h>
+
+#include "trampolines32.h"
+
+struct libffi_trampoline_x86_64 {
+	unsigned short mov1;
+	unsigned long addr1;
+	unsigned short mov2;
+	unsigned long addr2;
+	unsigned char stcclc;
+	unsigned short jmp1;
+	unsigned char jmp2;
+} __packed;
+
+struct gcc_trampoline_x86_64_type1 {
+	unsigned short mov1;
+	unsigned long addr1;
+	unsigned short mov2;
+	unsigned long addr2;
+	unsigned short jmp1;
+	unsigned char jmp2;
+} __packed;
+
+struct gcc_trampoline_x86_64_type2 {
+	unsigned short mov1;
+	unsigned int addr1;
+	unsigned short mov2;
+	unsigned long addr2;
+	unsigned short jmp1;
+	unsigned char jmp2;
+} __packed;
+
+union trampolines_x86_64 {
+	struct libffi_trampoline_x86_64 lf;
+	struct gcc_trampoline_x86_64_type1 g1;
+	struct gcc_trampoline_x86_64_type2 g2;
+};
+
+static inline int is_libffi_tramp_x86_64(const union trampolines_x86_64 *u)
+{
+	return (u->lf.mov1 == 0xBB49 &&
+		u->lf.mov2 == 0xBA49 &&
+		(u->lf.stcclc == 0xF8 ||
+		 u->lf.stcclc == 0xF9) &&
+		u->lf.jmp1 == 0xFF49 &&
+		u->lf.jmp2 == 0xE3);
+}
+
+static inline void emu_libffi_tramp_x86_64(const union trampolines_x86_64 *u,
+					   struct pt_regs *regs)
+{
+	regs->r11 = u->lf.addr1;
+	regs->r10 = u->lf.addr2;
+	regs->ip = u->lf.addr1;
+	if (u->lf.stcclc == 0xF8)
+		regs->flags &= ~X86_EFLAGS_CF;
+	else
+		regs->flags |= X86_EFLAGS_CF;
+}
+
+static inline int is_gcc_tramp_x86_64_t1(const union trampolines_x86_64 *u,
+					 const struct pt_regs *regs)
+{
+	return (u->g1.mov1 == 0xBB49 &&
+		u->g1.mov2 == 0xBA49 &&
+		u->g1.jmp1 == 0xFF49 &&
+		u->g1.jmp2 == 0xE3 &&
+		regs->ip > regs->sp);
+}
+
+static inline void emu_gcc_tramp_x86_64_t1(const union trampolines_x86_64 *u,
+					   struct pt_regs *regs)
+{
+	regs->r11 = u->g1.addr1;
+	regs->r10 = u->g1.addr2;
+	regs->ip = u->g1.addr1;
+}
+
+static inline int is_gcc_tramp_x86_64_t2(const union trampolines_x86_64 *u,
+					 const struct pt_regs *regs)
+{
+	return (u->g2.mov1 == 0xBB41 &&
+		u->g2.mov2 == 0xBA49 &&
+		u->g2.jmp1 == 0xFF49 &&
+		u->g2.jmp2 == 0xE3 &&
+		regs->ip > regs->sp);
+}
+
+static inline void emu_gcc_tramp_x86_64_t2(const union trampolines_x86_64 *u,
+					   struct pt_regs *regs)
+{
+	regs->r11 = u->g2.addr1;
+	regs->r10 = u->g2.addr2;
+	regs->ip = u->g2.addr1;
+}
+
+static inline int sara_trampoline_emulator_x86_64(struct pt_regs *regs,
+						  unsigned long address)
+{
+	int ret;
+	void __user *ip = (void __user *) regs->ip;
+	union trampolines_x86_64 t;
+
+	BUILD_BUG_ON(sizeof(t.g1) > sizeof(t.lf));
+	BUILD_BUG_ON(sizeof(t.g2) > sizeof(t.g1));
+
+	if (regs->cs == __USER32_CS ||
+	    regs->cs & (1<<2)) {
+		if (address >> 32)	/* K8 erratum #100 */
+			return 0;
+		return sara_trampoline_emulator_x86_32(regs);
+	}
+
+	ret = copy_from_user(&t, ip, sizeof(t.lf));
+	if (ret)
+		ret = copy_from_user(&t, ip, sizeof(t.g1));
+	if (ret)
+		ret = copy_from_user(&t, ip, sizeof(t.g2));
+	if (ret)
+		return 0;
+
+	if (is_libffi_tramp_x86_64(&t)) {
+		pr_debug("Trampoline: libffi x86_64.\n");
+		emu_libffi_tramp_x86_64(&t, regs);
+		return 1;
+	} else if (is_gcc_tramp_x86_64_t1(&t, regs)) {
+		pr_debug("Trampoline: gcc1 x86_64.\n");
+		emu_gcc_tramp_x86_64_t1(&t, regs);
+		return 1;
+	} else if (is_gcc_tramp_x86_64_t2(&t, regs)) {
+		pr_debug("Trampoline: gcc2 x86_64.\n");
+		emu_gcc_tramp_x86_64_t2(&t, regs);
+		return 1;
+	}
+
+	pr_debug("Not a trampoline (x86_64).\n");
+
+	return 0;
+
+}
+
+#endif /* __SARA_TRAMPOLINES64_H */
diff --git a/security/sara/Kconfig b/security/sara/Kconfig
index 54a96e0..458e0e8 100644
--- a/security/sara/Kconfig
+++ b/security/sara/Kconfig
@@ -117,6 +117,24 @@ choice
 		  Documentation/admin-guide/LSM/SARA.rst.
 endchoice
 
+config SECURITY_SARA_WXPROT_EMUTRAMP
+	bool "Enable emulation for some types of trampolines"
+	depends on SECURITY_SARA_WXPROT
+	depends on ARCH_HAS_LSM_PAGEFAULT
+	depends on X86
+	default y
+	help
+	  Some programs and libraries need to execute special small code
+	  snippets from non-executable memory pages.
+	  Most notable examples are the GCC and libffi trampolines.
+	  This features make it possible to execute those trampolines even
+	  if they reside in non-executable memory pages.
+	  This features need to be enabled on a per-executable basis
+	  via user-space utilities.
+	  See Documentation/admin-guide/LSM/SARA.rst. for further information.
+
+	  If unsure, answer y.
+
 config SECURITY_SARA_WXPROT_DISABLED
 	bool "WX protection will be disabled at boot."
 	depends on SECURITY_SARA_WXPROT
diff --git a/security/sara/include/emutramp.h b/security/sara/include/emutramp.h
new file mode 100644
index 0000000..d82f92d
--- /dev/null
+++ b/security/sara/include/emutramp.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * S.A.R.A. Linux Security Module
+ *
+ * Copyright (C) 2017 Salvatore Mesoraca <s.mesoraca16@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ * Assembly sequences used here were copied from
+ * PaX patch by PaX Team <pageexec@freemail.hu>
+ * Being just hexadecimal constants, they are not subject to
+ * any copyright.
+ *
+ */
+
+#ifndef __SARA_EMUTRAMP_H
+#define __SARA_EMUTRAMP_H
+
+#ifdef CONFIG_SECURITY_SARA_WXPROT_EMUTRAMP
+int sara_trampoline_emulator(struct pt_regs *regs,
+			     unsigned long error_code,
+			     unsigned long address);
+#else
+inline int sara_trampoline_emulator(struct pt_regs *regs,
+				    unsigned long error_code,
+				    unsigned long address)
+{
+	return 0;
+}
+#endif /* CONFIG_SECURITY_SARA_WXPROT_EMUTRAMP */
+
+#endif /* __SARA_EMUTRAMP_H */
diff --git a/security/sara/wxprot.c b/security/sara/wxprot.c
index 8a3d002..9c42bfc 100644
--- a/security/sara/wxprot.c
+++ b/security/sara/wxprot.c
@@ -31,6 +31,7 @@
 #include "include/utils.h"
 #include "include/securityfs.h"
 #include "include/wxprot.h"
+#include "include/emutramp.h"
 
 #define SARA_WXPROT_CONFIG_VERSION 0
 
@@ -41,6 +42,7 @@
 #define SARA_WXP_COMPLAIN	0x0010
 #define SARA_WXP_VERBOSE	0x0020
 #define SARA_WXP_MMAP		0x0040
+#define SARA_WXP_EMUTRAMP	0x0100
 #define SARA_WXP_TRANSFER	0x0200
 #define SARA_WXP_NONE		0x0000
 #define SARA_WXP_MPROTECT	(SARA_WXP_HEAP	| \
@@ -51,7 +53,12 @@
 				 SARA_WXP_WXORX		| \
 				 SARA_WXP_COMPLAIN	| \
 				 SARA_WXP_VERBOSE)
+#ifdef CONFIG_SECURITY_SARA_WXPROT_EMUTRAMP
+#define SARA_WXP_ALL		(__SARA_WXP_ALL		| \
+				 SARA_WXP_EMUTRAMP)
+#else /* CONFIG_SECURITY_SARA_WXPROT_EMUTRAMP */
 #define SARA_WXP_ALL		__SARA_WXP_ALL
+#endif /* CONFIG_SECURITY_SARA_WXPROT_EMUTRAMP */
 
 struct wxprot_config_container {
 	struct sara_dfa_tables *dfa;
@@ -67,7 +74,11 @@ struct wxprot_config_container {
 static u16 default_flags __lsm_ro_after_init =
 				CONFIG_SECURITY_SARA_WXPROT_DEFAULT_FLAGS;
 
+#ifdef CONFIG_SECURITY_SARA_WXPROT_EMUTRAMP
+static const bool wxprot_emutramp = true;
+#else
 static const bool wxprot_emutramp;
+#endif
 
 static void pr_wxp(char *msg)
 {
@@ -110,6 +121,9 @@ static bool are_flags_valid(u16 flags)
 	if (unlikely(flags & SARA_WXP_MMAP &&
 		     !(flags & SARA_WXP_OTHER)))
 		return false;
+	if (unlikely(flags & SARA_WXP_EMUTRAMP &&
+		     ((flags & SARA_WXP_MPROTECT) != SARA_WXP_MPROTECT)))
+		return false;
 	return true;
 }
 
@@ -514,11 +528,26 @@ static int sara_file_mprotect(struct vm_area_struct *vma,
 	return 0;
 }
 
+#ifdef CONFIG_SECURITY_SARA_WXPROT_EMUTRAMP
+static int sara_pagefault_handler(struct pt_regs *regs,
+				  unsigned long error_code,
+				  unsigned long address)
+{
+	if (!sara_enabled || !wxprot_enabled ||
+	    likely(!(get_current_sara_wxp_flags() & SARA_WXP_EMUTRAMP)))
+		return 0;
+	return sara_trampoline_emulator(regs, error_code, address);
+}
+#endif
+
 static struct security_hook_list wxprot_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bprm_set_creds, sara_bprm_set_creds),
 	LSM_HOOK_INIT(check_vmflags, sara_check_vmflags),
 	LSM_HOOK_INIT(shm_shmat, sara_shm_shmat),
 	LSM_HOOK_INIT(file_mprotect, sara_file_mprotect),
+#ifdef CONFIG_SECURITY_SARA_WXPROT_EMUTRAMP
+	LSM_HOOK_INIT(pagefault_handler, sara_pagefault_handler),
+#endif
 };
 
 static void config_free(struct wxprot_config_container *data)
-- 
1.9.1

