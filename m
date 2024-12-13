Return-Path: <linux-security-module+bounces-7047-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3799F012B
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Dec 2024 01:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D5A188E51F
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Dec 2024 00:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98021925A4;
	Fri, 13 Dec 2024 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="02mzqQmK"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04B1917CE
	for <linux-security-module@vger.kernel.org>; Fri, 13 Dec 2024 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050032; cv=none; b=bIJp/yly/Tw54eZNlsWogHKqGtsZFn5MXdVOBJXw7DW9OT7XIuiEF17EV8HJphVkgVBiyKEpTzcuJq/Pyf0hItyNjE2AyhCLROIwKd42OivnytfZ2HYuoDi50zk5oSnyaR/L4YDTBFoQsRZaun5V8N+Sz6POdI676KzN+9S8p0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050032; c=relaxed/simple;
	bh=Zgzl3XVxzAmW8jRrQNJSTtYzkCtc8Muf7dPcDIyBdyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWpZDV+3MDJmgLyRO/gshoM4H3/DXpFq5E41Qiw7Sg3/qmjqGlHlSwHOQGltjR4VeHWf9uIkvi7pxdsRfIqylft/6BQkXmILqL8L2Rr55sZT0kVPH0qTseduNNS4EWMo7a/N9ZFaIoPSo0tD3PbMlr4x7ViGSMFvbdP9zK/ccSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=02mzqQmK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso651275a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 12 Dec 2024 16:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734050029; x=1734654829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RXgVD1sMOEByzIW12GoGJoIzmAElVem9Exw+HJ9s4M=;
        b=02mzqQmKVCL5Hc/1XEI4/svcgAzmK1cp+5ORTxBYb+/r/pHK8D0Iatraj0Rt1sVYO8
         hgaZ5Vu+njTDXOPjD5jC3dQvn5pq0BBJg9v9bbr9ZD05Kb45M+Jm2bgvYgBnxvoWMfGC
         l2ZwrIEStFdgb58/aMHWGXNbR0bhoMRAghhrgLqUlDlE3XHWe+nZU1KFUFFNxUXwEuXV
         bYkqMnlTMnbD3S1e7BXeS9DNy1+4Asd8U/b3iZJeQG6e77P/7B8Mr9hmA82/B3uppcLD
         hIof3H5RMd5TxLebzaFddFIVWYnX+A4kbSRgwDOF1Rz9n0rMQxcnhpDvGGGwCeWKg4OW
         8MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050029; x=1734654829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RXgVD1sMOEByzIW12GoGJoIzmAElVem9Exw+HJ9s4M=;
        b=uogsT7rFZItoI01WhwYdnP2FJzePLQfHGcPxrxax9vTY2sv4pnM2BIHsVVqg1pUVY5
         Duv5C9pnzEmHt5HhJelImIPZKt07cFwgrSRF8yzmrziPEg6baf3CZwq4AkQ9xyQHirJa
         pTiouKoC3v+0ybxO5RfO5b6wObbJ+osiJGMKBieHpLQs4x1NaurdjQbp1ZW4pwlVvW0r
         AOgxpNRn7RU4yFNFa3yiDd92ObWRbfC+5wS8fdJ08ehf5q07hR7qYTk8H7hVsTbBId4i
         WLbhNtdIlZlaIpYPxaLATe6m5swvMxeGjhQMj4KdCSDIrRVAPno4YdOOY07+i1VSHs6X
         vnPw==
X-Forwarded-Encrypted: i=1; AJvYcCW6WH1yaHtomKiXIK/rvMcpLrt5FzyTXmqxJfBOHFwmSG5MQehMtmVKpXq6vLEqg+wnYPvUFbHATa2IoToYvdNdzZDb+K8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2tCNUm5r6uG/bL0BTFppQGrft4OyXv7pQO1PkpBTYCXAcGU7M
	lBRvDzWpQlFxzcf16EA+M5TyI0he57hfsnA4ad9Zan3jnX1ZmAc5pKKDL4eJFH4=
X-Gm-Gg: ASbGnctstRjXzc4HjgB2lniPINj26fm7QKZlhw6w978mEjsSkfFvP6czOlnTv3hWd8h
	iSJjJDUkJMMOHtenRoYHvNp4Q63eRbjcg/+CZ39pdNwlR5bp6sKClB4/m9QbvLeViqvek4/cg/C
	qfvnPF6tL1egdDVEna1aVqCa2AHHMO9Ddi2J+5N7RdiEydzpf5xtO0YN2tShIsPIBr2E+Pu2xA3
	HCkW36sXeyfEdz3N+mWjKym0905idygWcBJ+mubz0zFMYk5Z81Ndvz4RNGH6nJVGkIEd1h+
X-Google-Smtp-Source: AGHT+IFnqqMr5PLSI8GtF+i6M0/uFmU5w1Zg6QUUWZTPMqn5/Gio1RnoUEX7mkk6GPckIUrbakXX6w==
X-Received: by 2002:a17:90b:54c7:b0:2ee:c9b6:c26a with SMTP id 98e67ed59e1d1-2f28fb68ef6mr1016562a91.11.1734050029367;
        Thu, 12 Dec 2024 16:33:49 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e0ce50sm1934462a91.39.2024.12.12.16.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:33:48 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 12 Dec 2024 16:33:06 -0800
Subject: [PATCH v2 16/16] perf tools: Remove dependency on libaudit
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-perf_syscalltbl-v2-16-f8ca984ffe40@rivosinc.com>
References: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
In-Reply-To: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17750; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=Zgzl3XVxzAmW8jRrQNJSTtYzkCtc8Muf7dPcDIyBdyo=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3p0w8H7J1c1KAvwfbDq9Z7oPNX9Rqbbxl1es5mawsJ8p
 fkD9rR2lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMBGzLoZ/ql/lz2uZSMSq7k58
 aZjoKbn+QEb9rZ0f4i7dWqZj8WsNH8M/W5+pmYwzDp02fnXPrnlneF157N9LD/yWNpRmh0X/SHd
 lBwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

All architectures now support HAVE_SYSCALL_TABLE_SUPPORT, so the flag is
no longer needed. With the removal of the flag, the related
GENERIC_SYSCALL_TABLE can also be removed. libaudit was only used as a
fallback for when HAVE_SYSCALL_TABLE_SUPPORT was not defined, so
libaudit is also no longer needed for any architecture.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/admin-guide/workload-tracing.rst |  2 +-
 tools/build/feature/Makefile                   |  4 --
 tools/build/feature/test-libaudit.c            | 11 ------
 tools/perf/Documentation/perf-check.txt        |  1 -
 tools/perf/Makefile.config                     | 31 +--------------
 tools/perf/Makefile.perf                       | 14 -------
 tools/perf/builtin-check.c                     |  1 -
 tools/perf/builtin-help.c                      |  2 -
 tools/perf/builtin-trace.c                     | 30 ---------------
 tools/perf/perf.c                              |  6 +--
 tools/perf/tests/make                          |  7 +---
 tools/perf/util/env.c                          |  4 +-
 tools/perf/util/generate-cmdlist.sh            |  4 +-
 tools/perf/util/syscalltbl.c                   | 53 --------------------------
 14 files changed, 10 insertions(+), 160 deletions(-)

diff --git a/Documentation/admin-guide/workload-tracing.rst b/Documentation/admin-guide/workload-tracing.rst
index b2e254ec8ee846afe78eede74a825b51c6ab119b..6be38c1b9c5bb4be899fd261c6d2911abcf959dc 100644
--- a/Documentation/admin-guide/workload-tracing.rst
+++ b/Documentation/admin-guide/workload-tracing.rst
@@ -83,7 +83,7 @@ scripts/ver_linux is a good way to check if your system already has
 the necessary tools::
 
   sudo apt-get build-essentials flex bison yacc
-  sudo apt install libelf-dev systemtap-sdt-dev libaudit-dev libslang2-dev libperl-dev libdw-dev
+  sudo apt install libelf-dev systemtap-sdt-dev libslang2-dev libperl-dev libdw-dev
 
 cscope is a good tool to browse kernel sources. Let's install it now::
 
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 043dfd00fce72d8f651ccd9b3265a0183f500e5c..e0b63e9d0251abe6d5eafc6d2f26b940918b16ee 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -13,7 +13,6 @@ FILES=                                          \
          test-gtk2.bin                          \
          test-gtk2-infobar.bin                  \
          test-hello.bin                         \
-         test-libaudit.bin                      \
          test-libbfd.bin                        \
          test-libbfd-buildid.bin		\
          test-disassembler-four-args.bin        \
@@ -228,9 +227,6 @@ $(OUTPUT)test-libunwind-debug-frame-arm.bin:
 $(OUTPUT)test-libunwind-debug-frame-aarch64.bin:
 	$(BUILD) -lelf -llzma -lunwind-aarch64
 
-$(OUTPUT)test-libaudit.bin:
-	$(BUILD) -laudit
-
 $(OUTPUT)test-libslang.bin:
 	$(BUILD) -lslang
 
diff --git a/tools/build/feature/test-libaudit.c b/tools/build/feature/test-libaudit.c
deleted file mode 100644
index f5b0863fa1ec240795339428d8deed98a946d405..0000000000000000000000000000000000000000
--- a/tools/build/feature/test-libaudit.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libaudit.h>
-
-extern int printf(const char *format, ...);
-
-int main(void)
-{
-	printf("error message: %s\n", audit_errno_to_name(0));
-
-	return audit_open();
-}
diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index 31741499e7867c9b712227f31a2958fd641d474a..e6d2ceeb2ca7de850f41b1baa0375b6f984bb08f 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -51,7 +51,6 @@ feature::
                 dwarf_getlocations      /  HAVE_LIBDW_SUPPORT
                 dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
                 auxtrace                /  HAVE_AUXTRACE_SUPPORT
-                libaudit                /  HAVE_LIBAUDIT_SUPPORT
                 libbfd                  /  HAVE_LIBBFD_SUPPORT
                 libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
                 libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c62622b4eb3dcbdfbd49ad371f15b92bfa4a6c43..732961687177da414fb250dc1f6815d186a2343f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -28,20 +28,7 @@ include $(srctree)/tools/scripts/Makefile.arch
 
 $(call detected_var,SRCARCH)
 
-ifneq ($(NO_SYSCALL_TABLE),1)
-  NO_SYSCALL_TABLE := 1
-
-  # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc s390))
-    NO_SYSCALL_TABLE := 0
-    CFLAGS += -DGENERIC_SYSCALL_TABLE
-    CFLAGS += -I$(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated
-  endif
-
-  ifneq ($(NO_SYSCALL_TABLE),1)
-    CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
-  endif
-endif
+CFLAGS += -I$(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated
 
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)
@@ -755,21 +742,7 @@ ifndef NO_LIBUNWIND
 endif
 
 ifneq ($(NO_LIBTRACEEVENT),1)
-  ifeq ($(NO_SYSCALL_TABLE),0)
-    $(call detected,CONFIG_TRACE)
-  else
-    ifndef NO_LIBAUDIT
-      $(call feature_check,libaudit)
-      ifneq ($(feature-libaudit), 1)
-        $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev)
-        NO_LIBAUDIT := 1
-      else
-        CFLAGS += -DHAVE_LIBAUDIT_SUPPORT
-        EXTLIBS += -laudit
-        $(call detected,CONFIG_TRACE)
-      endif
-    endif
-  endif
+  $(call detected,CONFIG_TRACE)
 endif
 
 ifndef NO_LIBCRYPTO
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 1f3262c1f9d44261be0315c693837cfdfb3071de..ab2d075ff3a23350a5eea12508cf0376f1d9f4e8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -59,8 +59,6 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBNUMA if you do not want numa perf benchmark
 #
-# Define NO_LIBAUDIT if you do not want libaudit support
-#
 # Define NO_LIBBIONIC if you do not want bionic support
 #
 # Define NO_LIBCRYPTO if you do not want libcrypto (openssl) support
@@ -119,10 +117,6 @@ include ../scripts/utilities.mak
 #
 # Define LIBBPF_DYNAMIC to enable libbpf dynamic linking.
 #
-# Define NO_SYSCALL_TABLE=1 to disable the use of syscall id to/from name tables
-# generated from the kernel .tbl or unistd.h files and use, if available, libaudit
-# for doing the conversions to/from strings/id.
-#
 # Define NO_LIBPFM4 to disable libpfm4 events extension.
 #
 # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
@@ -310,10 +304,7 @@ ifeq ($(filter feature-dump,$(MAKECMDGOALS)),feature-dump)
 FEATURE_TESTS := all
 endif
 endif
-# architectures that use the generic syscall table
-ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc s390))
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
-endif
 include Makefile.config
 endif
 
@@ -1098,11 +1089,6 @@ endif
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 	$(call QUIET_INSTALL, perf-iostat) \
 		$(INSTALL) $(OUTPUT)perf-iostat -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
-ifndef NO_LIBAUDIT
-	$(call QUIET_INSTALL, strace/groups) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'; \
-		$(INSTALL) trace/strace/groups/* -m 644 -t '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'
-endif
 ifndef NO_LIBPERL
 	$(call QUIET_INSTALL, perl-scripts) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 2346536a5ee14f91ecd10bd130a64676e871e1b2..7aed7b9f4f5270527ee1d36327eb6a01f196a46a 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -31,7 +31,6 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("dwarf_getlocations", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
 	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
-	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
 	FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 0854d3cd9f6a304cd9cb50ad430d5706d91df0e9..7be6fb6df595923c15ae51747d5bf17d867ae785 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -447,9 +447,7 @@ int cmd_help(int argc, const char **argv)
 #ifdef HAVE_LIBELF_SUPPORT
 		"probe",
 #endif
-#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
 		"trace",
-#endif
 	NULL };
 	const char *builtin_help_usage[] = {
 		"perf help [--all] [--man|--web|--info] [command]",
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6a1a128fe645014d0347ad4ec3e0c9e77ec59aee..0fddf34458db4fe4896d25f427f2ae29cb3aa15f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2069,30 +2069,11 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	const char *name = syscalltbl__name(trace->sctbl, id);
 	int err;
 
-#ifdef HAVE_SYSCALL_TABLE_SUPPORT
 	if (trace->syscalls.table == NULL) {
 		trace->syscalls.table = calloc(trace->sctbl->syscalls.max_id + 1, sizeof(*sc));
 		if (trace->syscalls.table == NULL)
 			return -ENOMEM;
 	}
-#else
-	if (id > trace->sctbl->syscalls.max_id || (id == 0 && trace->syscalls.table == NULL)) {
-		// When using libaudit we don't know beforehand what is the max syscall id
-		struct syscall *table = realloc(trace->syscalls.table, (id + 1) * sizeof(*sc));
-
-		if (table == NULL)
-			return -ENOMEM;
-
-		// Need to memset from offset 0 and +1 members if brand new
-		if (trace->syscalls.table == NULL)
-			memset(table, 0, (id + 1) * sizeof(*sc));
-		else
-			memset(table + trace->sctbl->syscalls.max_id + 1, 0, (id - trace->sctbl->syscalls.max_id) * sizeof(*sc));
-
-		trace->syscalls.table	      = table;
-		trace->sctbl->syscalls.max_id = id;
-	}
-#endif
 	sc = trace->syscalls.table + id;
 	if (sc->nonexistent)
 		return -EEXIST;
@@ -2439,18 +2420,7 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 
 	err = -EINVAL;
 
-#ifdef HAVE_SYSCALL_TABLE_SUPPORT
 	if (id > trace->sctbl->syscalls.max_id) {
-#else
-	if (id >= trace->sctbl->syscalls.max_id) {
-		/*
-		 * With libaudit we don't know beforehand what is the max_id,
-		 * so we let trace__read_syscall_info() figure that out as we
-		 * go on reading syscalls.
-		 */
-		err = trace__read_syscall_info(trace, id);
-		if (err)
-#endif
 		goto out_cant_read;
 	}
 
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index a2987f2cfe1a3958f53239ed1a4eec3f87d7466a..f0617cc41f5fe638986e5d8316a6b3056c2c4bc5 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -84,7 +84,7 @@ static struct cmd_struct commands[] = {
 #endif
 	{ "kvm",	cmd_kvm,	0 },
 	{ "test",	cmd_test,	0 },
-#if defined(HAVE_LIBTRACEEVENT) && (defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT))
+#if defined(HAVE_LIBTRACEEVENT)
 	{ "trace",	cmd_trace,	0 },
 #endif
 	{ "inject",	cmd_inject,	0 },
@@ -514,10 +514,6 @@ int main(int argc, const char **argv)
 		fprintf(stderr,
 			"trace command not available: missing libtraceevent devel package at build time.\n");
 		goto out;
-#elif !defined(HAVE_LIBAUDIT_SUPPORT) && !defined(HAVE_SYSCALL_TABLE_SUPPORT)
-		fprintf(stderr,
-			"trace command not available: missing audit-libs devel package at build time.\n");
-		goto out;
 #else
 		setup_path();
 		argv[0] = "trace";
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index a7fcbd589752a90459815bd21075528c6dfa4d94..0ee94caf9ec19820a94a87dd46a7ccf1cefb844a 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -86,7 +86,6 @@ make_no_libdw_dwarf_unwind := NO_LIBDW_DWARF_UNWIND=1
 make_no_backtrace   := NO_BACKTRACE=1
 make_no_libcapstone := NO_CAPSTONE=1
 make_no_libnuma     := NO_LIBNUMA=1
-make_no_libaudit    := NO_LIBAUDIT=1
 make_no_libbionic   := NO_LIBBIONIC=1
 make_no_auxtrace    := NO_AUXTRACE=1
 make_no_libbpf	    := NO_LIBBPF=1
@@ -97,7 +96,6 @@ make_no_libllvm     := NO_LIBLLVM=1
 make_with_babeltrace:= LIBBABELTRACE=1
 make_with_coresight := CORESIGHT=1
 make_no_sdt	    := NO_SDT=1
-make_no_syscall_tbl := NO_SYSCALL_TABLE=1
 make_no_libpfm4     := NO_LIBPFM4=1
 make_with_gtk2      := GTK2=1
 make_refcnt_check   := EXTRA_CFLAGS="-DREFCNT_CHECKING=1"
@@ -122,10 +120,10 @@ make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX3
 # all the NO_* variable combined
 make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_GTK2=1
 make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
-make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
+make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
 make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
-make_minimal        += NO_LIBCAP=1 NO_SYSCALL_TABLE=1 NO_CAPSTONE=1
+make_minimal        += NO_LIBCAP=1 NO_CAPSTONE=1
 
 # $(run) contains all available tests
 run := make_pure
@@ -158,7 +156,6 @@ run += make_no_libdw_dwarf_unwind
 run += make_no_backtrace
 run += make_no_libcapstone
 run += make_no_libnuma
-run += make_no_libaudit
 run += make_no_libbionic
 run += make_no_auxtrace
 run += make_no_libbpf
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index e2843ca2edd92ea5fa1c020ae92b183c496e975e..e9a694350671910d537de599071dbe7fcc18ced4 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -474,13 +474,13 @@ const char *perf_env__arch(struct perf_env *env)
 
 const char *perf_env__arch_strerrno(struct perf_env *env __maybe_unused, int err __maybe_unused)
 {
-#if defined(HAVE_SYSCALL_TABLE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+#if defined(HAVE_LIBTRACEEVENT)
 	if (env->arch_strerrno == NULL)
 		env->arch_strerrno = arch_syscalls__strerrno_function(perf_env__arch(env));
 
 	return env->arch_strerrno ? env->arch_strerrno(err) : "no arch specific strerrno function";
 #else
-	return "!(HAVE_SYSCALL_TABLE_SUPPORT && HAVE_LIBTRACEEVENT)";
+	return "!HAVE_LIBTRACEEVENT";
 #endif
 }
 
diff --git a/tools/perf/util/generate-cmdlist.sh b/tools/perf/util/generate-cmdlist.sh
index 1b5140e5ce9975fac87b2674dc694f9d4e439a5f..6a73c903d69050df69267a8aeaeeac1ed170efe1 100755
--- a/tools/perf/util/generate-cmdlist.sh
+++ b/tools/perf/util/generate-cmdlist.sh
@@ -38,7 +38,7 @@ do
 done
 echo "#endif /* HAVE_LIBELF_SUPPORT */"
 
-echo "#if defined(HAVE_LIBTRACEEVENT) && (defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT))"
+echo "#if defined(HAVE_LIBTRACEEVENT)"
 sed -n -e 's/^perf-\([^ 	]*\)[ 	].* audit*/\1/p' command-list.txt |
 sort |
 while read cmd
@@ -51,7 +51,7 @@ do
 	    p
      }' "Documentation/perf-$cmd.txt"
 done
-echo "#endif /* HAVE_LIBTRACEEVENT && (HAVE_LIBAUDIT_SUPPORT || HAVE_SYSCALL_TABLE_SUPPORT) */"
+echo "#endif /* HAVE_LIBTRACEEVENT */"
 
 echo "#ifdef HAVE_LIBTRACEEVENT"
 sed -n -e 's/^perf-\([^ 	]*\)[ 	].* traceevent.*/\1/p' command-list.txt |
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 210f61b0a7a264a427ebb602185d3a9da2f426f4..7e24e4164da9c7d60352b77b5724e6e8dac034f4 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -9,21 +9,12 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
-
-#ifdef HAVE_SYSCALL_TABLE_SUPPORT
 #include <string.h>
 #include "string2.h"
 
-#if defined(GENERIC_SYSCALL_TABLE)
 #include <syscall_table.h>
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl;
-#else
-const int syscalltbl_native_max_id = 0;
-static const char *const syscalltbl_native[] = {
-	[0] = "unknown",
-};
-#endif
 
 struct syscall {
 	int id;
@@ -131,47 +122,3 @@ int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_g
 	*idx = -1;
 	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
 }
-
-#else /* HAVE_SYSCALL_TABLE_SUPPORT */
-
-#include <libaudit.h>
-
-struct syscalltbl *syscalltbl__new(void)
-{
-	struct syscalltbl *tbl = zalloc(sizeof(*tbl));
-	if (tbl)
-		tbl->audit_machine = audit_detect_machine();
-	return tbl;
-}
-
-void syscalltbl__delete(struct syscalltbl *tbl)
-{
-	free(tbl);
-}
-
-const char *syscalltbl__name(const struct syscalltbl *tbl, int id)
-{
-	return audit_syscall_to_name(id, tbl->audit_machine);
-}
-
-int syscalltbl__id(struct syscalltbl *tbl, const char *name)
-{
-	return audit_name_to_syscall(name, tbl->audit_machine);
-}
-
-int syscalltbl__id_at_idx(struct syscalltbl *tbl __maybe_unused, int idx)
-{
-	return idx;
-}
-
-int syscalltbl__strglobmatch_next(struct syscalltbl *tbl __maybe_unused,
-				  const char *syscall_glob __maybe_unused, int *idx __maybe_unused)
-{
-	return -1;
-}
-
-int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
-{
-	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
-}
-#endif /* HAVE_SYSCALL_TABLE_SUPPORT */

-- 
2.34.1


