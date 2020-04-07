Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C121A12C0
	for <lists+linux-security-module@lfdr.de>; Tue,  7 Apr 2020 19:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDGRc4 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 7 Apr 2020 13:32:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:37436 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgDGRcz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Apr 2020 13:32:55 -0400
IronPort-SDR: SiEaPv8kCtD9RrYOm4JVh9RojFbBfpGr29qJTW9qDSpR+fyfrsMxuoNnAua+K4Lj2i28snGAjo
 mlpJaiPt8hbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 10:32:06 -0700
IronPort-SDR: 0dN2uk5PE2UgARM11tbMKg7mcMpR7+n/WA5Rh9SUwkMp2YjAgenijHApg1r0OQUVlhgA3i7Uf+
 CL6T7AxCQMpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="250310948"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 07 Apr 2020 10:32:06 -0700
Received: from [10.249.224.62] (abudanko-mobl.ccr.corp.intel.com [10.249.224.62])
        by linux.intel.com (Postfix) with ESMTP id AED7858048A;
        Tue,  7 Apr 2020 10:32:01 -0700 (PDT)
Subject: Re: [PATCH v8 00/12] Introduce CAP_PERFMON to secure system
 performance monitoring and observability
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Serge Hallyn <serge@hallyn.com>, Jiri Olsa <jolsa@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-man@vger.kernel.org
References: <f96f8f8a-e65c-3f36-dc85-fc3f5191e8c5@linux.intel.com>
 <20200407143014.GD11186@kernel.org> <20200407143551.GF11186@kernel.org>
 <10cc74ee-8587-8cdb-f85f-5724b370a2ce@linux.intel.com>
 <20200407163654.GB12003@kernel.org>
 <85da1e42-2cf2-98ca-1e0c-2cf3469b7d30@linux.intel.com>
 <20200407170251.GE12003@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <369aaea6-3532-859e-7f1a-4df7806351c5@linux.intel.com>
Date:   Tue, 7 Apr 2020 20:32:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407170251.GE12003@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 07.04.2020 20:02, Arnaldo Carvalho de Melo wrote:
> Em Tue, Apr 07, 2020 at 07:52:56PM +0300, Alexey Budankov escreveu:
>>
>> On 07.04.2020 19:36, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Apr 07, 2020 at 05:54:27PM +0300, Alexey Budankov escreveu:
>>>> Could makes sense adding cap_ipc_lock to the binary to isolate from this:
> 
>>>> kernel/events/core.c: 6101
>>>> 	if ((locked > lock_limit) && perf_is_paranoid() &&
>>>> 		!capable(CAP_IPC_LOCK)) {
>>>> 		ret = -EPERM;
>>>> 		goto unlock;
>>>> 	}
> 
>>> That did the trick, I'll update the documentation and include in my
>>> "Committer testing" section:
>  
>> Looks like top mode somehow reaches perf mmap limit described here [1].
>> Using -m option solves the issue avoiding cap_ipc_lock on my 8 cores machine:
>> perf top -e cycles -m 1
> 
> So this would read better?
> 
> diff --git a/Documentation/admin-guide/perf-security.rst b/Documentation/admin-guide/perf-security.rst
> index ed33682e26b0..d44dd24b0244 100644
> --- a/Documentation/admin-guide/perf-security.rst
> +++ b/Documentation/admin-guide/perf-security.rst
> @@ -127,8 +127,8 @@ taken to create such groups of privileged Perf users.
>  
>  ::
>  
> -   # setcap "cap_perfmon,cap_ipc_lock,cap_sys_ptrace,cap_syslog=ep" perf
> -   # setcap -v "cap_perfmon,cap_ipc_lock,cap_sys_ptrace,cap_syslog=ep" perf
> +   # setcap "cap_perfmon,cap_sys_ptrace,cap_syslog=ep" perf
> +   # setcap -v "cap_perfmon,cap_sys_ptrace,cap_syslog=ep" perf
>     perf: OK
>     # getcap perf
>     perf = cap_sys_ptrace,cap_syslog,cap_perfmon+ep
> @@ -140,6 +140,10 @@ i.e.:
>  
>     # setcap "38,cap_ipc_lock,cap_sys_ptrace,cap_syslog=ep" perf
>  
> +Note that you may need to have 'cap_ipc_lock' in the mix for tools such as
> +'perf top', alternatively use 'perf top -m N', to reduce the memory that
> +it uses for the perf ring buffer, see the memory allocation section below.
> +

Let's stay with the first variant of you addition to this patch and also 
extend the paragraph below as suggested in other mail in the thread.

>  As a result, members of perf_users group are capable of conducting
>  performance monitoring and observability by using functionality of the
>  configured Perf tool executable that, when executes, passes perf_events
> 

Thanks,
Alexey

