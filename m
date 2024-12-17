Return-Path: <linux-security-module+bounces-7134-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A64B9F4433
	for <lists+linux-security-module@lfdr.de>; Tue, 17 Dec 2024 07:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12575188CA3A
	for <lists+linux-security-module@lfdr.de>; Tue, 17 Dec 2024 06:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE74A1F1917;
	Tue, 17 Dec 2024 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Gb5AFGiC"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07B1F03F1
	for <linux-security-module@vger.kernel.org>; Tue, 17 Dec 2024 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417597; cv=none; b=gQLlXTE49JW9rZbndo9gzf92HcDHw0FHsJNlrzesFje8IRToWZJ0Mj6zB7tC2i95P3ILTFHGUbjvwjX5lvWj63fHO7m4DL/ip+sGPkpYVs0QXJGea75GFOdYAgqWgOiaZn5nqxRAnbQgtg0ijqt3JsZIGE15qylb0KtOH8PoUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417597; c=relaxed/simple;
	bh=TnnZd5SCCPCHQNsuSYVO2k9/ZD5FlCiOStCtnlFJLqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nH/RXfDtge+TrWw7ovRgp9QENmAAMQSxBp6nonk+RmN2ESbpKjYkqILDSqeS1ZZBppVKaIdRfCrXZkNKhGyn3+wcyMk95zgqOjFQFKf4Dedvu0nocFziY+pApg0tusXlPHGqHBFQ/u+gw1vs/hdHiPA/lq7pxO8+j/RdStxNV3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Gb5AFGiC; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fbbe0fb0b8so3258202a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 22:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734417594; x=1735022394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHyl1g0+sRT3I8Hteex+5Qbsh7vI83GUNuysWmoDrBQ=;
        b=Gb5AFGiCUJvNGlXIy1BiDPuI6aj2wsJYoxPJYAuwr4/mhZwB/lUCzMASY2/OGlQSM5
         N2HXbExfn87DwXAgusLfggiZe2Un3r30vnW0AduLOoa+TEty6DNBvMhSsVsyBrq9aQU1
         sWi5QKwyMkJxlhpbNFkzgGWfDy2Iotk0jgMiKmp/JzBBQXXmX7H75qjL7bd4gxVstIfA
         NZPDHYGYNW+ankBaFh3pRiM9s6n/JiofvksOjuK/Xy6BZtiLdjqQ/OD/bJdiCtMfkp+b
         FYtUhFM8bthx6VsnM/0f/73jYJS2fHkymtQ2j85H6J4EpvHV3M96ogyUCnuItV1JkTGE
         qGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734417594; x=1735022394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHyl1g0+sRT3I8Hteex+5Qbsh7vI83GUNuysWmoDrBQ=;
        b=Vl1gGseOai4FQWYQTeId+8BDJTuYCT5pfCUcKSNxfIH3IPPrTyuM5pYjPyPr8VIYGe
         g6+mmiU9mtKOE6yPXnCS/s5rBR0TMm0NWbvSNqtN2Rx0yeWmXSeJBZDnRaMatgCyIOD3
         1rvDECG8LHZeG60Pqsv2AXCw60mT0vpeixXKBFErHPZv7PwmlY6qxrcYka6MRQbiwnAb
         TIDNK/nvcU4ioWjQnAoxuVmG3+6DEPzLQ7Ow0ou7tBFlWAStKjja8tZrTC03WDoJeHuE
         dmlOeOSgHZl/FSiKHnQjYqRjtQY+hlo0OorJBby0Z8juIpc1h9BHOT+/SZ+Uprede9IB
         jstA==
X-Forwarded-Encrypted: i=1; AJvYcCW8WUkjLydJG6sXk47Ytwroz2DA5d87TcNFzBFkcoQx9A7qmeA3i40GkWlOUIQuLLvOcuqaJg1c+/9qvU+wEKsjqZF3j4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcDzLt3MSH7ReQWlxFuZRPzPOHYxMzHCKgJj4jo61ePmPVmQK
	6jg/E33U2C2Z4joI2GTfhXbXyE0c8eSic0aFLLgQkCMLpGNmIIdC1F45XKxeUnc=
X-Gm-Gg: ASbGncsYFEQqTG/wzQW0BQ476ngvkxSqZUUBJNF0J1EO2k1si+J45fXWEieKPU1quQM
	QVFrVVsuPCz7dz/J2VtKBlwg2l/TbGMv3jVJI8coVJdUiL4SSEx815X3lcCThwCgyYQWI4/Ler1
	5ToXxl+Qvc33g31LYB9Ye18xEwCmRK+ebZk+U43q0nuLRMmvdxRaGJEs8elUYrAitV2gZ1GXpqy
	Pp51GYQXEgjbUaiPinMFzSiP7UHQEZkaAhIyxlWeK92v7MFGBEElGDa+ph5+mId80fVdGrd
X-Google-Smtp-Source: AGHT+IFoaipwC2179ze8wQOpvHmHMFx6ymf7ESylLaD3Rm2XmAXWZ/V8V9e7vcr7pOC2tvAcEDAQBg==
X-Received: by 2002:a17:90b:3512:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-2f290dbcbddmr19458064a91.31.1734417593752;
        Mon, 16 Dec 2024 22:39:53 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90d6bsm9179551a91.2.2024.12.16.22.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:39:52 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 16 Dec 2024 22:32:58 -0800
Subject: [PATCH v3 13/16] perf tools: mips: Use generic syscall scripts
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-perf_syscalltbl-v3-13-239f032481d5@rivosinc.com>
References: <20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com>
In-Reply-To: <20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5118; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=TnnZd5SCCPCHQNsuSYVO2k9/ZD5FlCiOStCtnlFJLqM=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qizASWQyaSkWbvJq7mPple35XLHy9yNvzQlulZS22se
 mK2Gfp2lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMJFXGYwMfbP32fHf/VZ80CXh
 mvWJH3PtOPYGp8aoP1zX/LHeY+2qSYwMuy0my3r4i7OkT7631fO/eUa9wu/zG8MjIjQWGk3MdQx
 iAwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Use the generic scripts to generate headers from the syscall table for
mips.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  3 +-
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/mips/entry/syscalls/Kbuild         |  2 ++
 .../arch/mips/entry/syscalls/Makefile.syscalls     |  5 ++++
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl   | 32 ----------------------
 tools/perf/arch/mips/include/syscall_table.h       |  2 ++
 tools/perf/util/syscalltbl.c                       |  4 ---
 7 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d5e1bd03ae0f9d10df2da25a75eab50eb7334b45..ec2902e8f5f9baf6bed9946a9c7315527b23b8fb 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,7 +31,7 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390))
     NO_SYSCALL_TABLE := 0
   endif
 
@@ -83,7 +83,6 @@ ifeq ($(ARCH),s390)
 endif
 
 ifeq ($(ARCH),mips)
-  CFLAGS += -I$(OUTPUT)arch/mips/include/generated
   LIBUNWIND_LIBS = -lunwind -lunwind-mips
 endif
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c85262db770d18828fc3d9dc65eca00733645d41..74c1097f790cba5abfd1f2fbdaf4e7540c553482 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch
+generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/mips/entry/syscalls/Kbuild b/tools/perf/arch/mips/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..9a41e3572c3afd4f202321fd9e492714540e8fd3
--- /dev/null
+++ b/tools/perf/arch/mips/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls b/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..9ee914bdfb05860fdd37a49f1ced03fcf2c9ed78
--- /dev/null
+++ b/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_64 += n64
+
+syscalltbl = $(srctree)/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
diff --git a/tools/perf/arch/mips/entry/syscalls/mksyscalltbl b/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
deleted file mode 100644
index c0d93f959c4e1b8c12edcb5624bbc131231df7e3..0000000000000000000000000000000000000000
--- a/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate system call table for perf. Derived from
-# s390 script.
-#
-# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
-# Changed by: Tiezhu Yang <yangtiezhu@loongson.cn>
-
-SYSCALL_TBL=$1
-
-if ! test -r $SYSCALL_TBL; then
-	echo "Could not read input file" >&2
-	exit 1
-fi
-
-create_table()
-{
-	local max_nr nr abi sc discard
-
-	echo 'static const char *const syscalltbl_mips_n64[] = {'
-	while read nr abi sc discard; do
-		printf '\t[%d] = "%s",\n' $nr $sc
-		max_nr=$nr
-	done
-	echo '};'
-	echo "#define SYSCALLTBL_MIPS_N64_MAX_ID $max_nr"
-}
-
-grep -E "^[[:digit:]]+[[:space:]]+(n64)" $SYSCALL_TBL	\
-	|sort -k1 -n					\
-	|create_table
diff --git a/tools/perf/arch/mips/include/syscall_table.h b/tools/perf/arch/mips/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..b53e31c15805319a01719c22d489c4037378b02b
--- /dev/null
+++ b/tools/perf/arch/mips/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_64.h>
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 3001386e13a502be5279aa6e4742af0b96202b35..675702d686d0d1b53dd3ee2017cc9695686b9c63 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -26,10 +26,6 @@ static const char *const *syscalltbl_native = syscalltbl_powerpc_64;
 #include <asm/syscalls_32.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_32_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_powerpc_32;
-#elif defined(__mips__)
-#include <asm/syscalls_n64.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_MIPS_N64_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_mips_n64;
 #elif defined(GENERIC_SYSCALL_TABLE)
 #include <syscall_table.h>
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;

-- 
2.34.1


