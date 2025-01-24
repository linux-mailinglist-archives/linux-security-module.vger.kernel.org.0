Return-Path: <linux-security-module+bounces-7842-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E513A1ADE7
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Jan 2025 01:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5CF87A4632
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Jan 2025 00:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5288C14B94B;
	Fri, 24 Jan 2025 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PB2gJI/7"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5827314B07E
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737678380; cv=none; b=eGIdPWOrpA/5ZwBC814Uw8fBUv3lL9d002iCXA2lJUMd6YV9+NiGelfOhCnH+KReXn2o08LIsGfWB8RuzgGWFVyyKhUWTbEHSLHG2OrX5cPy+U0VdXQwaVZELFbm+AJFCpasn8C+1YPrV1w5b4/Ghn/KjSv3BV++xl6PwScp+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737678380; c=relaxed/simple;
	bh=dMRIZWkP39mpiDb+XJ71/LB8SzyGukso5aiyi35FLys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foS00nc5+ecWlDUdhgWPVcWEym9J6vqgUj0pR1FLIk+zMinzalkJUSMhC+w8eqx2mMThX9/jpsjLzf7o1mNf8Ki8brSlQs7mqKhQWztrGAq8OMlo5AXN9U/wZaZlrr+PfUMCibpmbpYbIxd+bGUsqlgWFI3lc4HJEyx2XdsJgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PB2gJI/7; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 23 Jan 2025 16:26:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737678369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTU+H9g9S1KRdaeFv8k4QBY+6+IjlyGyewpTM1VwtNY=;
	b=PB2gJI/7j1FYWc5IO92Q3ksRKeQcYUZw3wtN2haAUQuhJz6X8J3DJRlwEt1jV2CRNjmDlC
	lJTMKxToTNsnguEdrD/w/4g2TnAblI1CyPI7hbxX7ednkwhGBas6e0C+4UAT12GvwZzG+t
	W2rwFn0EYB4K+hVSDOOYfq9Y+O1U1W4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kees Cook <kees@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, 
	peterz@infradead.org, mingo@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rppt@kernel.org, liam.howlett@oracle.com, 
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] mm,procfs: allow read-only remote mm access under
 CAP_PERFMON
Message-ID: <u2bbo43kjtn5zstayucq6lqbfc4nbsmf6vcqlo7uac4imsgbx2@tpdcqyotgb34>
References: <20250123214342.4145818-1-andrii@kernel.org>
 <CAJuCfpE9QOo-xmDpk_FF=gs3p=9Zzb-Q5yDaKAEChBCnpogmQg@mail.gmail.com>
 <202501231526.A3C13EC5@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202501231526.A3C13EC5@keescook>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 23, 2025 at 03:47:44PM -0800, Kees Cook wrote:
> On Thu, Jan 23, 2025 at 01:52:52PM -0800, Suren Baghdasaryan wrote:
> > On Thu, Jan 23, 2025 at 1:44 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > It's very common for various tracing and profiling toolis to need to
> > > access /proc/PID/maps contents for stack symbolization needs to learn
> > > which shared libraries are mapped in memory, at which file offset, etc.
> > > Currently, access to /proc/PID/maps requires CAP_SYS_PTRACE (unless we
> > > are looking at data for our own process, which is a trivial case not too
> > > relevant for profilers use cases).
> > >
> > > Unfortunately, CAP_SYS_PTRACE implies way more than just ability to
> > > discover memory layout of another process: it allows to fully control
> > > arbitrary other processes. This is problematic from security POV for
> > > applications that only need read-only /proc/PID/maps (and other similar
> > > read-only data) access, and in large production settings CAP_SYS_PTRACE
> > > is frowned upon even for the system-wide profilers.
> > >
> > > On the other hand, it's already possible to access similar kind of
> > > information (and more) with just CAP_PERFMON capability. E.g., setting
> > > up PERF_RECORD_MMAP collection through perf_event_open() would give one
> > > similar information to what /proc/PID/maps provides.
> > >
> > > CAP_PERFMON, together with CAP_BPF, is already a very common combination
> > > for system-wide profiling and observability application. As such, it's
> > > reasonable and convenient to be able to access /proc/PID/maps with
> > > CAP_PERFMON capabilities instead of CAP_SYS_PTRACE.
> > >
> > > For procfs, these permissions are checked through common mm_access()
> > > helper, and so we augment that with cap_perfmon() check *only* if
> > > requested mode is PTRACE_MODE_READ. I.e., PTRACE_MODE_ATTACH wouldn't be
> > > permitted by CAP_PERFMON.
> > >
> > > Besides procfs itself, mm_access() is used by process_madvise() and
> > > process_vm_{readv,writev}() syscalls. The former one uses
> > > PTRACE_MODE_READ to avoid leaking ASLR metadata, and as such CAP_PERFMON
> > > seems like a meaningful allowable capability as well.
> > >
> > > process_vm_{readv,writev} currently assume PTRACE_MODE_ATTACH level of
> > > permissions (though for readv PTRACE_MODE_READ seems more reasonable,
> > > but that's outside the scope of this change), and as such won't be
> > > affected by this patch.
> > 
> > CC'ing Jann and Kees.
> > 
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/fork.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index ded49f18cd95..c57cb3ad9931 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -1547,6 +1547,15 @@ struct mm_struct *get_task_mm(struct task_struct *task)
> > >  }
> > >  EXPORT_SYMBOL_GPL(get_task_mm);
> > >
> > > +static bool can_access_mm(struct mm_struct *mm, struct task_struct *task, unsigned int mode)
> > > +{
> > > +       if (mm == current->mm)
> > > +               return true;
> > > +       if ((mode & PTRACE_MODE_READ) && perfmon_capable())
> > > +               return true;
> > > +       return ptrace_may_access(task, mode);
> > > +}
> 
> nit: "may" tends to be used more than "can" for access check function naming.
> 
> So, this will bypass security_ptrace_access_check() within
> ptrace_may_access(). CAP_PERFMON may be something LSMs want visibility
> into.
> 
> It also bypasses the dumpability check in __ptrace_may_access(). (Should
> non-dumpability block visibility into "maps" under CAP_PERFMON?)
> 
> This change provides read access for CAP_PERFMON to:
> 
> /proc/$pid/maps
> /proc/$pid/smaps
> /proc/$pid/mem
> /proc/$pid/environ
> /proc/$pid/auxv
> /proc/$pid/attr/*
> /proc/$pid/smaps_rollup
> /proc/$pid/pagemap
> 
> /proc/$pid/mem access seems way out of bounds for CAP_PERFMON. environ
> and auxv maybe too much also. The "attr" files seem iffy. pagemap may be
> reasonable.

From what I understand, PTRACE_MODE_ATTACH is used for /proc/$pid/mem,
so this patch is not changing anything. However for environ and auxv,
PTRACE_MODE_READ is being used, so they will be accessible for
CAP_PERFMON.

What's your reason behind too much for environ and auxv?


