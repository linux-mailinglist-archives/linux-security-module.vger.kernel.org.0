Return-Path: <linux-security-module+bounces-6454-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4509BBF41
	for <lists+linux-security-module@lfdr.de>; Mon,  4 Nov 2024 22:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC660B217E8
	for <lists+linux-security-module@lfdr.de>; Mon,  4 Nov 2024 21:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59BA1FAC44;
	Mon,  4 Nov 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KgV12L8W"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47551FA276
	for <linux-security-module@vger.kernel.org>; Mon,  4 Nov 2024 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754408; cv=none; b=EWu5PLXlWM67Mv593G8PI93Dt+63fPqBf0TfI4AsjDawMr3qUn+ekAli8X19yI0+bacJWUG2CYHEmUnnonsrhMYRE0D4s9EbI/x95EIQmpkAMdg+XKQGJx6kGvertx1XrFJtv0J6iMFIN+bdE+n/WRY0xguvkD244+bEmO88WIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754408; c=relaxed/simple;
	bh=PISAQTqUki1/XDwxfviywo0KbS28qJBhJbmHqN3tLmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uu7PcFtaYrhDaKBN2RzqwoU5pnfHmry//07gfJle7PLvYvJaHjOB1raAWW7Q5XUFA/3TgI0zki+F0E8qa2Ko1BkbWGHVQSwLI8R1oF102ShiBCWAUqfVvaCP3GZmJRPevD01RvRYupx6pbmYpfLEMxgXTDz3DYIPUeFV4T1SxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KgV12L8W; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-720e94d36c8so1624175b3a.1
        for <linux-security-module@vger.kernel.org>; Mon, 04 Nov 2024 13:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730754405; x=1731359205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CStevielhPcmY7ji/g5LI7tesLN3hlzjCs6ppC7xqA=;
        b=KgV12L8W/PU3BDg9qFAL9dWN8pCGn/nTSBhBqAqCe+VaklSUrgItRLgTjaNp7Fy5ku
         /eD/9joX7pndInHT73621+9rJNn12lu34rGaFkFCrKrRP7ffAQ/Ak8yoqE8B6851SNMJ
         w33/d6CYSjOTDGHLsJStoHdsgMI0Z9vcjardxWm60Vc6ciOymdNKX9i/fIksOGb2kcFn
         +NYlIQOswPcAdNM11/KbTP2tZmKUN3dhenpv67fZnFwIIIP8XQMCtKsqOE/BIZD2VFGk
         A8t85dcyg7f0gR0ebg2vplWxWKwqV79uoWqRKsaaFKIbi7VD7rY6X+pvgVouOFUVJ1Xh
         BTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754405; x=1731359205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CStevielhPcmY7ji/g5LI7tesLN3hlzjCs6ppC7xqA=;
        b=wbbw20elK9b6Nj1vVhkRUC9Pyx5572GW09pj+h1//g/lllq95Bx7bBohIttY6uFi5V
         kfY4OHwEbvr6jChQY7W01kXpZEte9eEhaDwH65zOt2W1p6MGVA7D2Zpn3auqb8Yta98G
         9jcK1hyy4R1A1nhjnEIfIT0AI3/Bz3nRqN0fZyVJFVBKMbpJVPe+Nw1gdfLRQmJvQfiQ
         5WICPnaID5SOcU0WD77uAIjBWbLf/myuzCJ12W0QGufefdYi11pScN+0l9DPiHy7gWiI
         2FvhCeaAyaHmNzMm5f7hpOXHp/gktoMgNYbeVz1AlFUQod86uOfAi33l9ZFffuoOjNKF
         voHg==
X-Forwarded-Encrypted: i=1; AJvYcCVuw+fFqOVIFU22+/DxtjSYfDUsl0MASjXFy2BsXOSst2nHYcBGcJLnWd/knbNBzmCAZue9UrFu4jj63s/OjTAEBfI3TPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza46O+9lFmjuml6aCHizOPO0/OU1/XxI8l/S/AMnFQIGEe9URs
	BSNd5lnct0xqsVFj1ScwSc97Ml7nk4c71zhvdQTPKUlhumza0b3WgjxrPJJcpk4=
X-Google-Smtp-Source: AGHT+IF8jKapkBA0swwhmdesAjhiJas+ccLfE/v3A5z2wRhVBfuP4qVq+i8umDBbdED+N0XWpA0pog==
X-Received: by 2002:a05:6a21:78a0:b0:1d8:fb32:1cec with SMTP id adf61e73a8af0-1dba40f2695mr22211767637.5.1730754404957;
        Mon, 04 Nov 2024 13:06:44 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee490e08f4sm7248293a12.40.2024.11.04.13.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:06:43 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 04 Nov 2024 13:06:03 -0800
Subject: [PATCH RFT 01/16] perf tools: Create generic syscall table support
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-perf_syscalltbl-v1-1-9adae5c761ef@rivosinc.com>
References: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
In-Reply-To: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=27319; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=PISAQTqUki1/XDwxfviywo0KbS28qJBhJbmHqN3tLmg=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7qmedTfshcXZ3EIT/g0Kc7jwLMZXhc8VlcJLtd+fbSOe
 4lo+abPHaUsDGIcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAExE5R8jwzKGLFNZrpePT7RP
 6/3asXzi0v/xB39pLdS3CpnX9PSd7iOG/7WXJ/FtCVHfV/f3hvihT7qXWZ+dbreeKPravCajU5j
 tFCMA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Currently each architecture in perf independently generates syscall
headers. Adapt the work that has gone into unifying syscall header
implementations in the kernel to work with perf tools. Introduce this
framework with riscv at first. riscv previously relied on libaudit, but
with this change, perf tools for riscv no longer needs this external
dependency.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |   7 +
 tools/perf/Makefile.perf                           |   4 +
 tools/perf/arch/riscv/entry/syscalls/Kbuild        |   2 +
 .../arch/riscv/entry/syscalls/Makefile.syscalls    |   4 +
 tools/perf/arch/riscv/include/syscall_table.h      |   8 +
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/scripts/Makefile.syscalls               |  69 ++++
 tools/perf/scripts/syscalltbl.sh                   |  86 +++++
 tools/perf/util/syscalltbl.c                       |   5 +-
 tools/scripts/syscall.tbl                          | 405 +++++++++++++++++++++
 10 files changed, 590 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d4332675babb..6774b67d4668 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -35,6 +35,13 @@ ifneq ($(NO_SYSCALL_TABLE),1)
     NO_SYSCALL_TABLE := 0
   endif
 
+  # architectures that use the generic syscall table scripts
+  ifeq ($(SRCARCH),riscv)
+    NO_SYSCALL_TABLE := 0
+    CFLAGS += -DGENERIC_SYSCALL_TABLE
+    CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
+  endif
+
   ifneq ($(NO_SYSCALL_TABLE),1)
     CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
   endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9dd2e8d3f3c9..18294b840121 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -310,6 +310,10 @@ ifeq ($(filter feature-dump,$(MAKECMDGOALS)),feature-dump)
 FEATURE_TESTS := all
 endif
 endif
+# architectures that use the generic syscall table
+ifeq ($(SRCARCH),riscv)
+include $(srctree)/tools/perf/scripts/Makefile.syscalls
+endif
 include Makefile.config
 endif
 
diff --git a/tools/perf/arch/riscv/entry/syscalls/Kbuild b/tools/perf/arch/riscv/entry/syscalls/Kbuild
new file mode 100644
index 000000000000..9a41e3572c3a
--- /dev/null
+++ b/tools/perf/arch/riscv/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls b/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
new file mode 100644
index 000000000000..9668fd1faf60
--- /dev/null
+++ b/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += riscv memfd_secret
+syscall_abis_64 += riscv rlimit memfd_secret
diff --git a/tools/perf/arch/riscv/include/syscall_table.h b/tools/perf/arch/riscv/include/syscall_table.h
new file mode 100644
index 000000000000..7ff51b783000
--- /dev/null
+++ b/tools/perf/arch/riscv/include/syscall_table.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/bitsperlong.h>
+
+#if __BITS_PER_LONG == 64
+#include <asm/syscalls_64.h>
+#else
+#include <asm/syscalls_32.h>
+#endif
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index a05c1c105c51..692f48db810c 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -71,6 +71,7 @@ FILES=(
   "include/uapi/asm-generic/ioctls.h"
   "include/uapi/asm-generic/mman-common.h"
   "include/uapi/asm-generic/unistd.h"
+  "scripts/syscall.tbl"
 )
 
 declare -a SYNC_CHECK_FILES
diff --git a/tools/perf/scripts/Makefile.syscalls b/tools/perf/scripts/Makefile.syscalls
new file mode 100644
index 000000000000..41e1e938b1c1
--- /dev/null
+++ b/tools/perf/scripts/Makefile.syscalls
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0
+# include/asm-generic contains a lot of files that are used
+# verbatim by several architectures.
+#
+# This Makefile generates arch/$(SRCARCH)/include/generated/(uapi/)/asm
+# headers from multiple sources:
+#  - a small wrapper to include the corresponding asm-generic/*.h
+#    is generated for each file listed as generic-y
+#  - uapi/asm/unistd_*.h files listed as syscalls-y are generated from
+#    syscall.tbl with the __NR_* macros
+#  - Corresponding asm/syscall_*.h are generated from the same input
+
+PHONY := all
+all:
+
+obj := $(srctree)/tools/perf/arch/$(SRCARCH)/include/generated/asm
+
+src := $(srctree)/$(subst /generated,,$(obj))
+
+syscall_abis_32  += common,32
+syscall_abis_64  += common,64
+syscalltbl := $(srctree)/tools/scripts/syscall.tbl
+
+# let architectures override $(syscall_abis_%) and $(syscalltbl)
+-include $(srctree)/tools/perf/arch/$(SRCARCH)/entry/syscalls/Makefile.syscalls
+include $(srctree)/scripts/Kbuild.include
+-include $(srctree)/tools/perf/arch/$(SRCARCH)/entry/syscalls/Kbuild
+
+systbl := $(srctree)/tools/perf/scripts/syscalltbl.sh
+
+syscall-y   := $(addprefix $(obj)/, $(syscall-y))
+
+# Remove stale wrappers when the corresponding files are removed from generic-y
+old-headers := $(wildcard $(obj)/*.c)
+unwanted    := $(filter-out $(syscall-y),$(old-headers))
+
+quiet_cmd_remove = REMOVE  $(unwanted)
+      cmd_remove = rm -f $(unwanted)
+
+quiet_cmd_systbl = SYSTBL  $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) \
+		   $(if $(systbl-args-$*),$(systbl-args-$*),$(systbl-args)) \
+		   --abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*))) \
+		   $< $@
+
+all: $(syscall-y)
+	$(if $(unwanted),$(call cmd,remove))
+	@:
+
+$(obj)/syscalls_%.h: $(syscalltbl) $(systbl) FORCE
+	$(call if_changed,systbl)
+
+targets := $(syscall-y)
+
+# Create output directory. Skip it if at least one old header exists
+# since we know the output directory already exists.
+ifeq ($(old-headers),)
+$(shell mkdir -p $(obj))
+endif
+
+PHONY += FORCE
+
+FORCE:
+
+existing-targets := $(wildcard $(sort $(targets)))
+
+-include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
+
+.PHONY: $(PHONY)
diff --git a/tools/perf/scripts/syscalltbl.sh b/tools/perf/scripts/syscalltbl.sh
new file mode 100755
index 000000000000..1ce0d5aa8b50
--- /dev/null
+++ b/tools/perf/scripts/syscalltbl.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate a syscall table header.
+#
+# Each line of the syscall table should have the following format:
+#
+# NR ABI NAME [NATIVE] [COMPAT]
+#
+# NR       syscall number
+# ABI      ABI name
+# NAME     syscall name
+# NATIVE   native entry point (optional)
+# COMPAT   compat entry point (optional)
+
+set -e
+
+usage() {
+	echo >&2 "usage: $0 [--abis ABIS] INFILE OUTFILE" >&2
+	echo >&2
+	echo >&2 "  INFILE    input syscall table"
+	echo >&2 "  OUTFILE   output header file"
+	echo >&2
+	echo >&2 "options:"
+	echo >&2 "  --abis ABIS        ABI(s) to handle (By default, all lines are handled)"
+	exit 1
+}
+
+# default unless specified by options
+abis=
+
+while [ $# -gt 0 ]
+do
+	case $1 in
+	--abis)
+		abis=$(echo "($2)" | tr ',' '|')
+		shift 2;;
+	-*)
+		echo "$1: unknown option" >&2
+		usage;;
+	*)
+		break;;
+	esac
+done
+
+if [ $# -ne 2 ]; then
+	usage
+fi
+
+infile="$1"
+outfile="$2"
+
+nxt=0
+
+syscall_macro() {
+    nr="$1"
+    name="$2"
+
+    echo "	[$nr] = \"$name\","
+}
+
+emit() {
+    nr="$1"
+    entry="$2"
+
+    syscall_macro "$nr" "$entry"
+}
+
+echo "static const char *const syscalltbl[] = {" > $outfile
+
+sorted_table=$(mktemp /tmp/syscalltbl.XXXXXX)
+grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | sort -n > $sorted_table
+
+max_nr=0
+# the params are: nr abi name entry compat
+# use _ for intentionally unused variables according to SC2034
+while read nr _ name _ _; do
+    emit "$nr" "$name" >> $outfile
+    max_nr=$nr
+done < $sorted_table
+
+rm -f $sorted_table
+
+echo "};" >> $outfile
+
+echo "#define SYSCALLTBL_MAX_ID ${max_nr}" >> $outfile
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 6c45ded922b6..229183e5c55f 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -9,7 +9,6 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
-
 #ifdef HAVE_SYSCALL_TABLE_SUPPORT
 #include <string.h>
 #include "string2.h"
@@ -46,6 +45,10 @@ static const char *const *syscalltbl_native = syscalltbl_mips_n64;
 #include <asm/syscalls.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_loongarch;
+#elif defined(GENERIC_SYSCALL_TABLE)
+#include <syscall_table.h>
+const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;
+static const char *const *syscalltbl_native = syscalltbl;
 #else
 const int syscalltbl_native_max_id = 0;
 static const char *const syscalltbl_native[] = {
diff --git a/tools/scripts/syscall.tbl b/tools/scripts/syscall.tbl
new file mode 100644
index 000000000000..845e24eb372e
--- /dev/null
+++ b/tools/scripts/syscall.tbl
@@ -0,0 +1,405 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# This file contains the system call numbers for all of the
+# more recently added architectures.
+#
+# As a basic principle, no duplication of functionality
+# should be added, e.g. we don't use lseek when llseek
+# is present. New architectures should use this file
+# and implement the less feature-full calls in user space.
+#
+0	common	io_setup			sys_io_setup			compat_sys_io_setup
+1	common	io_destroy			sys_io_destroy
+2	common	io_submit			sys_io_submit			compat_sys_io_submit
+3	common	io_cancel			sys_io_cancel
+4	time32	io_getevents			sys_io_getevents_time32
+4	64	io_getevents			sys_io_getevents
+5	common	setxattr			sys_setxattr
+6	common	lsetxattr			sys_lsetxattr
+7	common	fsetxattr			sys_fsetxattr
+8	common	getxattr			sys_getxattr
+9	common	lgetxattr			sys_lgetxattr
+10	common	fgetxattr			sys_fgetxattr
+11	common	listxattr			sys_listxattr
+12	common	llistxattr			sys_llistxattr
+13	common	flistxattr			sys_flistxattr
+14	common	removexattr			sys_removexattr
+15	common	lremovexattr			sys_lremovexattr
+16	common	fremovexattr			sys_fremovexattr
+17	common	getcwd				sys_getcwd
+18	common	lookup_dcookie			sys_ni_syscall
+19	common	eventfd2			sys_eventfd2
+20	common	epoll_create1			sys_epoll_create1
+21	common	epoll_ctl			sys_epoll_ctl
+22	common	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
+23	common	dup				sys_dup
+24	common	dup3				sys_dup3
+25	32	fcntl64				sys_fcntl64			compat_sys_fcntl64
+25	64	fcntl				sys_fcntl
+26	common	inotify_init1			sys_inotify_init1
+27	common	inotify_add_watch		sys_inotify_add_watch
+28	common	inotify_rm_watch		sys_inotify_rm_watch
+29	common	ioctl				sys_ioctl			compat_sys_ioctl
+30	common	ioprio_set			sys_ioprio_set
+31	common	ioprio_get			sys_ioprio_get
+32	common	flock				sys_flock
+33	common	mknodat				sys_mknodat
+34	common	mkdirat				sys_mkdirat
+35	common	unlinkat			sys_unlinkat
+36	common	symlinkat			sys_symlinkat
+37	common	linkat				sys_linkat
+# renameat is superseded with flags by renameat2
+38	renameat renameat			sys_renameat
+39	common	umount2				sys_umount
+40	common	mount				sys_mount
+41	common	pivot_root			sys_pivot_root
+42	common	nfsservctl			sys_ni_syscall
+43	32	statfs64			sys_statfs64			compat_sys_statfs64
+43	64	statfs				sys_statfs
+44	32	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
+44	64	fstatfs				sys_fstatfs
+45	32	truncate64			sys_truncate64			compat_sys_truncate64
+45	64	truncate			sys_truncate
+46	32	ftruncate64			sys_ftruncate64			compat_sys_ftruncate64
+46	64	ftruncate			sys_ftruncate
+47	common	fallocate			sys_fallocate			compat_sys_fallocate
+48	common	faccessat			sys_faccessat
+49	common	chdir				sys_chdir
+50	common	fchdir				sys_fchdir
+51	common	chroot				sys_chroot
+52	common	fchmod				sys_fchmod
+53	common	fchmodat			sys_fchmodat
+54	common	fchownat			sys_fchownat
+55	common	fchown				sys_fchown
+56	common	openat				sys_openat
+57	common	close				sys_close
+58	common	vhangup				sys_vhangup
+59	common	pipe2				sys_pipe2
+60	common	quotactl			sys_quotactl
+61	common	getdents64			sys_getdents64
+62	32	llseek				sys_llseek
+62	64	lseek				sys_lseek
+63	common	read				sys_read
+64	common	write				sys_write
+65	common	readv				sys_readv			sys_readv
+66	common	writev				sys_writev			sys_writev
+67	common	pread64				sys_pread64			compat_sys_pread64
+68	common	pwrite64			sys_pwrite64			compat_sys_pwrite64
+69	common	preadv				sys_preadv			compat_sys_preadv
+70	common	pwritev				sys_pwritev			compat_sys_pwritev
+71	32	sendfile64			sys_sendfile64
+71	64	sendfile			sys_sendfile64
+72	time32	pselect6			sys_pselect6_time32		compat_sys_pselect6_time32
+72	64	pselect6			sys_pselect6
+73	time32	ppoll				sys_ppoll_time32		compat_sys_ppoll_time32
+73	64	ppoll				sys_ppoll
+74	common	signalfd4			sys_signalfd4			compat_sys_signalfd4
+75	common	vmsplice			sys_vmsplice
+76	common	splice				sys_splice
+77	common	tee				sys_tee
+78	common	readlinkat			sys_readlinkat
+79	stat64	fstatat64			sys_fstatat64
+79	64	newfstatat			sys_newfstatat
+80	stat64	fstat64				sys_fstat64
+80	64	fstat				sys_newfstat
+81	common	sync				sys_sync
+82	common	fsync				sys_fsync
+83	common	fdatasync			sys_fdatasync
+84	common	sync_file_range			sys_sync_file_range		compat_sys_sync_file_range
+85	common	timerfd_create			sys_timerfd_create
+86	time32	timerfd_settime			sys_timerfd_settime32
+86	64	timerfd_settime			sys_timerfd_settime
+87	time32	timerfd_gettime			sys_timerfd_gettime32
+87	64	timerfd_gettime			sys_timerfd_gettime
+88	time32	utimensat			sys_utimensat_time32
+88	64	utimensat			sys_utimensat
+89	common	acct				sys_acct
+90	common	capget				sys_capget
+91	common	capset				sys_capset
+92	common	personality			sys_personality
+93	common	exit				sys_exit
+94	common	exit_group			sys_exit_group
+95	common	waitid				sys_waitid			compat_sys_waitid
+96	common	set_tid_address			sys_set_tid_address
+97	common	unshare				sys_unshare
+98	time32	futex				sys_futex_time32
+98	64	futex				sys_futex
+99	common	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
+100	common	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
+101	time32	nanosleep			sys_nanosleep_time32
+101	64	nanosleep			sys_nanosleep
+102	common	getitimer			sys_getitimer			compat_sys_getitimer
+103	common	setitimer			sys_setitimer			compat_sys_setitimer
+104	common	kexec_load			sys_kexec_load			compat_sys_kexec_load
+105	common	init_module			sys_init_module
+106	common	delete_module			sys_delete_module
+107	common	timer_create			sys_timer_create		compat_sys_timer_create
+108	time32	timer_gettime			sys_timer_gettime32
+108	64	timer_gettime			sys_timer_gettime
+109	common	timer_getoverrun		sys_timer_getoverrun
+110	time32	timer_settime			sys_timer_settime32
+110	64	timer_settime			sys_timer_settime
+111	common	timer_delete			sys_timer_delete
+112	time32	clock_settime			sys_clock_settime32
+112	64	clock_settime			sys_clock_settime
+113	time32	clock_gettime			sys_clock_gettime32
+113	64	clock_gettime			sys_clock_gettime
+114	time32	clock_getres			sys_clock_getres_time32
+114	64	clock_getres			sys_clock_getres
+115	time32	clock_nanosleep			sys_clock_nanosleep_time32
+115	64	clock_nanosleep			sys_clock_nanosleep
+116	common	syslog				sys_syslog
+117	common	ptrace				sys_ptrace			compat_sys_ptrace
+118	common	sched_setparam			sys_sched_setparam
+119	common	sched_setscheduler		sys_sched_setscheduler
+120	common	sched_getscheduler		sys_sched_getscheduler
+121	common	sched_getparam			sys_sched_getparam
+122	common	sched_setaffinity		sys_sched_setaffinity		compat_sys_sched_setaffinity
+123	common	sched_getaffinity		sys_sched_getaffinity		compat_sys_sched_getaffinity
+124	common	sched_yield			sys_sched_yield
+125	common	sched_get_priority_max		sys_sched_get_priority_max
+126	common	sched_get_priority_min		sys_sched_get_priority_min
+127	time32	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+127	64	sched_rr_get_interval		sys_sched_rr_get_interval
+128	common	restart_syscall			sys_restart_syscall
+129	common	kill				sys_kill
+130	common	tkill				sys_tkill
+131	common	tgkill				sys_tgkill
+132	common	sigaltstack			sys_sigaltstack			compat_sys_sigaltstack
+133	common	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+134	common	rt_sigaction			sys_rt_sigaction		compat_sys_rt_sigaction
+135	common	rt_sigprocmask			sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+136	common	rt_sigpending			sys_rt_sigpending		compat_sys_rt_sigpending
+137	time32	rt_sigtimedwait			sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+137	64	rt_sigtimedwait			sys_rt_sigtimedwait
+138	common	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+139	common	rt_sigreturn			sys_rt_sigreturn		compat_sys_rt_sigreturn
+140	common	setpriority			sys_setpriority
+141	common	getpriority			sys_getpriority
+142	common	reboot				sys_reboot
+143	common	setregid			sys_setregid
+144	common	setgid				sys_setgid
+145	common	setreuid			sys_setreuid
+146	common	setuid				sys_setuid
+147	common	setresuid			sys_setresuid
+148	common	getresuid			sys_getresuid
+149	common	setresgid			sys_setresgid
+150	common	getresgid			sys_getresgid
+151	common	setfsuid			sys_setfsuid
+152	common	setfsgid			sys_setfsgid
+153	common	times				sys_times			compat_sys_times
+154	common	setpgid				sys_setpgid
+155	common	getpgid				sys_getpgid
+156	common	getsid				sys_getsid
+157	common	setsid				sys_setsid
+158	common	getgroups			sys_getgroups
+159	common	setgroups			sys_setgroups
+160	common	uname				sys_newuname
+161	common	sethostname			sys_sethostname
+162	common	setdomainname			sys_setdomainname
+# getrlimit and setrlimit are superseded with prlimit64
+163	rlimit	getrlimit			sys_getrlimit			compat_sys_getrlimit
+164	rlimit	setrlimit			sys_setrlimit			compat_sys_setrlimit
+165	common	getrusage			sys_getrusage			compat_sys_getrusage
+166	common	umask				sys_umask
+167	common	prctl				sys_prctl
+168	common	getcpu				sys_getcpu
+169	time32	gettimeofday			sys_gettimeofday		compat_sys_gettimeofday
+169	64	gettimeofday			sys_gettimeofday
+170	time32	settimeofday			sys_settimeofday		compat_sys_settimeofday
+170	64	settimeofday			sys_settimeofday
+171	time32	adjtimex			sys_adjtimex_time32
+171	64	adjtimex			sys_adjtimex
+172	common	getpid				sys_getpid
+173	common	getppid				sys_getppid
+174	common	getuid				sys_getuid
+175	common	geteuid				sys_geteuid
+176	common	getgid				sys_getgid
+177	common	getegid				sys_getegid
+178	common	gettid				sys_gettid
+179	common	sysinfo				sys_sysinfo			compat_sys_sysinfo
+180	common	mq_open				sys_mq_open			compat_sys_mq_open
+181	common	mq_unlink			sys_mq_unlink
+182	time32	mq_timedsend			sys_mq_timedsend_time32
+182	64	mq_timedsend			sys_mq_timedsend
+183	time32	mq_timedreceive			sys_mq_timedreceive_time32
+183	64	mq_timedreceive			sys_mq_timedreceive
+184	common	mq_notify			sys_mq_notify			compat_sys_mq_notify
+185	common	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
+186	common	msgget				sys_msgget
+187	common	msgctl				sys_msgctl			compat_sys_msgctl
+188	common	msgrcv				sys_msgrcv			compat_sys_msgrcv
+189	common	msgsnd				sys_msgsnd			compat_sys_msgsnd
+190	common	semget				sys_semget
+191	common	semctl				sys_semctl			compat_sys_semctl
+192	time32	semtimedop			sys_semtimedop_time32
+192	64	semtimedop			sys_semtimedop
+193	common	semop				sys_semop
+194	common	shmget				sys_shmget
+195	common	shmctl				sys_shmctl			compat_sys_shmctl
+196	common	shmat				sys_shmat			compat_sys_shmat
+197	common	shmdt				sys_shmdt
+198	common	socket				sys_socket
+199	common	socketpair			sys_socketpair
+200	common	bind				sys_bind
+201	common	listen				sys_listen
+202	common	accept				sys_accept
+203	common	connect				sys_connect
+204	common	getsockname			sys_getsockname
+205	common	getpeername			sys_getpeername
+206	common	sendto				sys_sendto
+207	common	recvfrom			sys_recvfrom			compat_sys_recvfrom
+208	common	setsockopt			sys_setsockopt			sys_setsockopt
+209	common	getsockopt			sys_getsockopt			sys_getsockopt
+210	common	shutdown			sys_shutdown
+211	common	sendmsg				sys_sendmsg			compat_sys_sendmsg
+212	common	recvmsg				sys_recvmsg			compat_sys_recvmsg
+213	common	readahead			sys_readahead			compat_sys_readahead
+214	common	brk				sys_brk
+215	common	munmap				sys_munmap
+216	common	mremap				sys_mremap
+217	common	add_key				sys_add_key
+218	common	request_key			sys_request_key
+219	common	keyctl				sys_keyctl			compat_sys_keyctl
+220	common	clone				sys_clone
+221	common	execve				sys_execve			compat_sys_execve
+222	32	mmap2				sys_mmap2
+222	64	mmap				sys_mmap
+223	32	fadvise64_64			sys_fadvise64_64		compat_sys_fadvise64_64
+223	64	fadvise64			sys_fadvise64_64
+224	common	swapon				sys_swapon
+225	common	swapoff				sys_swapoff
+226	common	mprotect			sys_mprotect
+227	common	msync				sys_msync
+228	common	mlock				sys_mlock
+229	common	munlock				sys_munlock
+230	common	mlockall			sys_mlockall
+231	common	munlockall			sys_munlockall
+232	common	mincore				sys_mincore
+233	common	madvise				sys_madvise
+234	common	remap_file_pages		sys_remap_file_pages
+235	common	mbind				sys_mbind
+236	common	get_mempolicy			sys_get_mempolicy
+237	common	set_mempolicy			sys_set_mempolicy
+238	common	migrate_pages			sys_migrate_pages
+239	common	move_pages			sys_move_pages
+240	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+241	common	perf_event_open			sys_perf_event_open
+242	common	accept4				sys_accept4
+243	time32	recvmmsg			sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+243	64	recvmmsg			sys_recvmmsg
+# Architectures may provide up to 16 syscalls of their own between 244 and 259
+244	arc	cacheflush			sys_cacheflush
+245	arc	arc_settls			sys_arc_settls
+246	arc	arc_gettls			sys_arc_gettls
+247	arc	sysfs				sys_sysfs
+248	arc	arc_usr_cmpxchg			sys_arc_usr_cmpxchg
+
+244	csky	set_thread_area			sys_set_thread_area
+245	csky	cacheflush			sys_cacheflush
+
+244	nios2	cacheflush			sys_cacheflush
+
+244	or1k	or1k_atomic			sys_or1k_atomic
+
+258	riscv	riscv_hwprobe			sys_riscv_hwprobe
+259	riscv	riscv_flush_icache		sys_riscv_flush_icache
+
+260	time32	wait4				sys_wait4			compat_sys_wait4
+260	64	wait4				sys_wait4
+261	common	prlimit64			sys_prlimit64
+262	common	fanotify_init			sys_fanotify_init
+263	common	fanotify_mark			sys_fanotify_mark
+264	common	name_to_handle_at		sys_name_to_handle_at
+265	common	open_by_handle_at		sys_open_by_handle_at
+266	time32	clock_adjtime			sys_clock_adjtime32
+266	64	clock_adjtime			sys_clock_adjtime
+267	common	syncfs				sys_syncfs
+268	common	setns				sys_setns
+269	common	sendmmsg			sys_sendmmsg			compat_sys_sendmmsg
+270	common	process_vm_readv		sys_process_vm_readv
+271	common	process_vm_writev		sys_process_vm_writev
+272	common	kcmp				sys_kcmp
+273	common	finit_module			sys_finit_module
+274	common	sched_setattr			sys_sched_setattr
+275	common	sched_getattr			sys_sched_getattr
+276	common	renameat2			sys_renameat2
+277	common	seccomp				sys_seccomp
+278	common	getrandom			sys_getrandom
+279	common	memfd_create			sys_memfd_create
+280	common	bpf				sys_bpf
+281	common	execveat			sys_execveat			compat_sys_execveat
+282	common	userfaultfd			sys_userfaultfd
+283	common	membarrier			sys_membarrier
+284	common	mlock2				sys_mlock2
+285	common	copy_file_range			sys_copy_file_range
+286	common	preadv2				sys_preadv2			compat_sys_preadv2
+287	common	pwritev2			sys_pwritev2			compat_sys_pwritev2
+288	common	pkey_mprotect			sys_pkey_mprotect
+289	common	pkey_alloc			sys_pkey_alloc
+290	common	pkey_free			sys_pkey_free
+291	common	statx				sys_statx
+292	time32	io_pgetevents			sys_io_pgetevents_time32	compat_sys_io_pgetevents
+292	64	io_pgetevents			sys_io_pgetevents
+293	common	rseq				sys_rseq
+294	common	kexec_file_load			sys_kexec_file_load
+# 295 through 402 are unassigned to sync up with generic numbers don't use
+403	32	clock_gettime64			sys_clock_gettime
+404	32	clock_settime64			sys_clock_settime
+405	32	clock_adjtime64			sys_clock_adjtime
+406	32	clock_getres_time64		sys_clock_getres
+407	32	clock_nanosleep_time64		sys_clock_nanosleep
+408	32	timer_gettime64			sys_timer_gettime
+409	32	timer_settime64			sys_timer_settime
+410	32	timerfd_gettime64		sys_timerfd_gettime
+411	32	timerfd_settime64		sys_timerfd_settime
+412	32	utimensat_time64		sys_utimensat
+413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
+417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64		sys_mq_timedsend
+419	32	mq_timedreceive_time64		sys_mq_timedreceive
+420	32	semtimedop_time64		sys_semtimedop
+421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64			sys_futex
+423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
+435	common	clone3				sys_clone3
+436	common	close_range			sys_close_range
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
+440	common	process_madvise			sys_process_madvise
+441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_fd			sys_quotactl_fd
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
+447	memfd_secret	memfd_secret		sys_memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal

-- 
2.34.1


