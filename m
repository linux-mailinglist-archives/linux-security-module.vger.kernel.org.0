Return-Path: <linux-security-module+bounces-7561-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CD4A08324
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Jan 2025 00:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B4C16814E
	for <lists+linux-security-module@lfdr.de>; Thu,  9 Jan 2025 23:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D8E18F2D8;
	Thu,  9 Jan 2025 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="g9q/3Cy+"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE439202F87
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jan 2025 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736463665; cv=none; b=uoC16c83dVhnEpWcOslly2KbKG/epsZqqfx9IBpx3u8y8AV5ZupVLEJ10VIMIMZpJyKtUkc+zoNDrfxP56ROOMONkZqdX3+jCYFJm4zHEPK0wzQEofPGimLGHBgN2Q1z4NHPXp1dWuhz8ODWiWp98jBWpeDxMENtJYLBYRrjTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736463665; c=relaxed/simple;
	bh=ouylJ8vaww+BvN5+CjToW8mtqfVEhB1cWP2LujyiEy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxHTx92xyQ5vAASHUOF1ISu5hiZ1kGXnmVaO1/0xOh1Cbl5dXQe39wgSL+Nzb6dJzPNhd03w3qF4g+X60RcN7AMVEBxYzO5onKbpm/PGlFAXZ53hyIP20O9xHE1gUdfzKMBejz9vLy3E//vIAPKGdwmF/TfxhSbf1Zww6gRRAn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=g9q/3Cy+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21634338cfdso32807295ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 Jan 2025 15:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736463663; x=1737068463; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u1Rto3tQvT3jFN5xuxXHqKLZjGHCEokZTCe6xmBnORw=;
        b=g9q/3Cy+xguC9G42bmdnj9vz+2rGfGWYXgAwg5B1Rg2XFJC1hXiKZU2zYLau/Ev6A2
         Tyq6HzkDRpTRRH6QykuTg6/ShavOglCcBg3VYKE6k7nz2yVuUU5GGcN10YDJLu01rwba
         BA7ooUB0gpQeVu4ty+/znHHp4gbXwQHGqEv6US2cOMBuCaG0UQSL0WuhnTvN0BKvMCuL
         5fzqBajiFdLf8ckDvozIxC3rxNgOLgy/wUhbmqiNkAtIFc9cnKLgjmYJh7xN6RemRxfi
         gZv+QTtljlvsUH7OwwMbSGhs+u/5uWl8Yck9mkAYSdZwCZbu+IK3fN6Y85OkY40+sGDS
         0tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736463663; x=1737068463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1Rto3tQvT3jFN5xuxXHqKLZjGHCEokZTCe6xmBnORw=;
        b=mW9GK7hyiOK8+mzx9Gk8dZw4MOKmx8np2DPvXwScn/ZDv6mm9wltP6BWETAyC70SbL
         W4dIDwiG2JA9RhqA9V0P/qCPK5mkUpqygB7ZRl61yiGzH9+x+A4TfDNMwoIvprsHziDZ
         cBvkM1qzbKGQM7gDNcE6k/w4CODUxlFUpBV27pgZF01T2ZjbiPUN4pyLRqGmn07k+3dp
         E9j9Z+U/6FlaAw8+6XYK5+fHhmsTZflq4DaHzBkQB4PWfjfQKhnZNIeCUeHMU0sGoaqM
         cAzd+p2MKVfMD61EiOU0i1zwDufYk+bOqgGbFtU3zuA4aHQrufmCKL4GS20dhScO1l4b
         /Zyw==
X-Forwarded-Encrypted: i=1; AJvYcCV29+jNezl4du3KEwtCLz08jGdM9M3Y7GLSN+uxyGtgsoLF5tqYoIIpHiIAqtH36GB/mf0dZCOCGFG/JKSY5U+s+iqPYmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJBcHNqCCVJY4YVXqjLIoZzKnBgkhE+5+k5+AXiI1WJBkVWsO5
	usZTcbI6q3SXRCWEre1G5M/UC3DQjH05vok1EL3B2X+Ap1W5o8yFIIxsHU60BC0=
X-Gm-Gg: ASbGncu5Qu4gOKNDXExhfD9tJImOvQabsa2UY9pTdSZ5nIFGXU18yfm4IlcKhgyPqit
	ZHakKM8uaOoa3KKpF+2bCwRM/Q3r+ACi52k4sCYnzgQL3/qjYBRiq/ysqPI4AuaVQSSCTNDWgZV
	Lxh/E8gVGuA9gwSbBMEJB5JgCX85bh/QCl/jwAJ9fl0QfwD4wByds8hoExHd1hfUk2TqQ+liKQb
	MRVqKkENlVI7shmto9VMdVCfXfPK01bf6rNCP2TP199X3CWIzdU
X-Google-Smtp-Source: AGHT+IHHLbAhu86VzYd6LBFp5j+Q2QinJd1yN68qZ09Yns1ZwY4dgQCRzdIJeqQ19rPDtpnqmFcSKA==
X-Received: by 2002:a17:902:f70f:b0:216:32ea:c84b with SMTP id d9443c01a7336-21a83fc3652mr135133105ad.37.1736463663201;
        Thu, 09 Jan 2025 15:01:03 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:691c:638a:ff10:3765])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f234984sm2890475ad.205.2025.01.09.15.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 15:01:02 -0800 (PST)
Date: Thu, 9 Jan 2025 15:00:59 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 00/16] perf tools: Use generic syscall scripts for all
 archs
Message-ID: <Z4BVK3D7sN-XYg2o@ghost>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
 <Z3_ybwWW3QZvJ4V6@x1>
 <Z4AoFA974kauIJ9T@ghost>
 <Z4A2Y269Ffo0ERkS@x1>
 <Z4BEygdXmofWBr0-@x1>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4BEygdXmofWBr0-@x1>

On Thu, Jan 09, 2025 at 06:51:06PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jan 09, 2025 at 05:49:42PM -0300, Arnaldo Carvalho de Melo wrote:
> > BTW this series is already pushed out to perf-tools-next:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next
> 
> Hey, now I noticed that with this latest version we see:
> 
> ⬢ [acme@toolbox perf-tools-next]$ m
> make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
>   BUILD:   Doing 'make -j28' parallel build
> Warning: Kernel ABI header differences:
>   diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h
> 
> Auto-detecting system features:
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libbfd: [ on  ]
> ...                          libbfd-buildid: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                                 libperl: [ on  ]
> ...                               libpython: [ on  ]
> ...                               libcrypto: [ on  ]
> ...                               libunwind: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                               llvm-perf: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
> 
>    /home/acme/git/perf-tools-next/tools/perf/scripts/syscalltbl.sh  --abis common,32,i386 /home/acme/git/perf-tools-next/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_32.h
>    /home/acme/git/perf-tools-next/tools/perf/scripts/syscalltbl.sh  --abis common,64 /home/acme/git/perf-tools-next/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_64.h
>   GEN     /tmp/build/perf-tools-next/common-cmds.h
>   GEN     /tmp/build/perf-tools-next/arch/arm64/include/generated/asm/sysreg-defs.h
>   PERF_VERSION = 6.13.rc2.gd73982c39183
>   GEN     perf-archive
>   GEN     perf-iostat
>   MKDIR   /tmp/build/perf-tools-next/jvmti/
>   MKDIR   /tmp/build/perf-tools-next/jvmti/
>   MKDIR   /tmp/build/perf-tools-next/jvmti/
>   MKDIR   /tmp/build/perf-tools-next/jvmti/
> 
> 
> While with the previous one we would see something like SYSCALLTBL as
> the step name, like we have GEN, MKDIR, etc, can you take a look?

Ooh okay I see, the quiet commands were being ignored as-is. We could
add the lines to handle this to Makefile.syscalls, but I think the
better solution is to move the lines from Makefile.build to
Makefile.perf to be more generically available. Here is a patch for
that. I also added the comment from the kernel Makefile describing what
this does.

From 8dcec7f5d937ede3d33c687573dc2f1654ddc59e Mon Sep 17 00:00:00 2001
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 9 Jan 2025 14:36:40 -0800
Subject: [PATCH] perf tools: Expose quiet/verbose variables in Makefile.perf

The variables to make builds silent/verbose live inside
tools/build/Makefile.build. Move those variables to the top-level
Makefile.perf to be generally available.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/build/Makefile.build | 20 --------------------
 tools/perf/Makefile.perf   | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 5fb3fb3d97e0..e710ed67a1b4 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -12,26 +12,6 @@
 PHONY := __build
 __build:
 
-ifeq ($(V),1)
-  quiet =
-  Q =
-else
-  quiet=quiet_
-  Q=@
-endif
-
-# If the user is running make -s (silent mode), suppress echoing of commands
-# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
-ifeq ($(filter 3.%,$(MAKE_VERSION)),)
-short-opts := $(firstword -$(MAKEFLAGS))
-else
-short-opts := $(filter-out --%,$(MAKEFLAGS))
-endif
-
-ifneq ($(findstring s,$(short-opts)),)
-  quiet=silent_
-endif
-
 build-dir := $(srctree)/tools/build
 
 # Define $(fixdep) for dep-cmd function
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a449d0015536..55d6ce9ea52f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -161,12 +161,47 @@ export VPATH
 SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
 endif
 
+# Beautify output
+# ---------------------------------------------------------------------------
+#
+# Most of build commands in Kbuild start with "cmd_". You can optionally define
+# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
+# that command is printed by default.
+#
+# e.g.)
+#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
+#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
+#
+# A simple variant is to prefix commands with $(Q) - that's useful
+# for commands that shall be hidden in non-verbose mode.
+#
+#    $(Q)$(MAKE) $(build)=scripts/basic
+#
+# To put more focus on warnings, be less verbose as default
+# Use 'make V=1' to see the full commands
+
 ifeq ($(V),1)
+  quiet =
   Q =
 else
-  Q = @
+  quiet=quiet_
+  Q=@
 endif
 
+# If the user is running make -s (silent mode), suppress echoing of commands
+# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
+ifeq ($(filter 3.%,$(MAKE_VERSION)),)
+short-opts := $(firstword -$(MAKEFLAGS))
+else
+short-opts := $(filter-out --%,$(MAKEFLAGS))
+endif
+
+ifneq ($(findstring s,$(short-opts)),)
+  quiet=silent_
+endif
+
+export quiet Q
+
 # Do not use make's built-in rules
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
-- 
2.34.1


- Charlie

> 
> All is out there in perf-tools-next.
> 
> - Arnaldo

