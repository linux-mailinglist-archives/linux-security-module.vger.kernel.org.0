Return-Path: <linux-security-module+bounces-10281-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF014ACA014
	for <lists+linux-security-module@lfdr.de>; Sun,  1 Jun 2025 20:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6622E189168B
	for <lists+linux-security-module@lfdr.de>; Sun,  1 Jun 2025 18:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2CE23815B;
	Sun,  1 Jun 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jB03YYaL"
X-Original-To: linux-security-module@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BB6238142
	for <linux-security-module@vger.kernel.org>; Sun,  1 Jun 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748801934; cv=none; b=kEgkeoAoBsqfzIKLhVL0STJwaXkqQ/+Zpfi0vx7AGf8i4/1qrazLEPexL+Zo041QoPjRZk8eHu0RRCCCs6JTZkbvEc1KnScOl1m9fTB/Pov+x2Y5C/EefIWkct7a8h4CT4ARZH0bTaDdPItRa+BRCZChAtfd6Xn/gu/wh0naTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748801934; c=relaxed/simple;
	bh=WuDY0OySF7BdBM49NzP+uPZV19MDCVmPPhZFaoDLJYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxJ+imtaQlsAWuBUh3at9koknStgTHki7Pm3AwTBBI4R6nJSwLWtWyGQnWau3zajF2zEpLR439zzZ5AvFtMZ0GwL0DYQ2xsMh81sWirw2F5zfqxb/UD7vGcUM6cSQLi/2WzDuYCDNjfGjjX8kW+jwlqrmDd0SCEAWFV7zjKuO84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jB03YYaL; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1748801923; bh=XEdFOAxo7Ix9ZlscuZG5EZR04Xlxo/Q1+44saHO6Rtg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jB03YYaLSFS9OovlwzG43z1x1wvRaSiBDYdP9iwpRoq5KnOlogsmHldbctbZYGKRhnZFs/g9D62avCXvKJiuROfXBLTNnUM+eq/kdBefFHxunr0/oQZY868YhREAk0zrVWM/mtKuhIHPF0KB4C/Sfyfy0oj1QqvKT4Z8vAOpZDCwzznr72yaSKIxtix4M/ygwMCPSkzEBKr033gEOYV+cgCh5wTAByXmeiCH5L3zwmge+XdceeSvnldAg2j4eA8MIqi7M3Qv+Mb2XoLgg2L12+cUwr0fhGPisrtCqad3pQZkgmwhYF/9DpdyjCQ2tfbkWZEUsvJTbQW6mndGnHSlWw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1748801923; bh=91pvgFJp51JFBPsrYfK5aUzkNWNovBWg11D6lKb1xxg=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SfldityPIX0rK3MOH4s59ZdRt8L+/sDca5x6o39HHPUD90bUe1l+d5n+p50REQvTB48iCSYi20Bl17mGDLvgqpSgtf/dCPQVXYLNL5sYQgBpSC79DR5e+jXvJAf6zycI4Y4/phG2i6vMVf3CTrZbULKMakuAhOBKQPcWJiIl7zuEL2sZQ8cxbTGhMe02nOEmf6jnAL/67NQVCkkR3qwlrJZUJXSFGpzApoD0INQF5G00AzBnrVIGJZYS6XrMGrb7A4+bBP6sPMwx73d+0AksFRJUwJQdmUVwJzUdK9jZPj+slCzUySvjLwvCpUWgN+0Kg9i9lH+PSG78aK58f7sfng==
X-YMail-OSG: 7qQl.NwVM1l26dp1.vAvxooeya08.UtbQ1F4BNpZrAWSKqTrclTSyNqVSsno2jL
 R7n0vdIYaBc8NFbjyUTLG1PTuKuOfGBQLhDiFdPQyqfh5NFLQGPpG32rbiV9Sg_GUtO20KDWpXag
 5m39c2fx8v7gmjG7GCjO3jW29u5uafMe_PiOFzQ8wyXjjxA66xRHvJziiR_h4mUQNbzVHuyLhoth
 CyLSxNUmRX_5nuKW5qxCTHUnNh3U0ci0tFi5fEb891uYicidWzBxWmCDXIP3c3oOX6kn4Qpgy_cd
 xxl7DXdQettrx.7X.VZpPYYe9z_Mr52L2IJR8_XsrvgvqMSLHVC5Miv3s3PRX97IBp9c3_mfzrZm
 DNqyH9ksiZm4jOR3ugAV_IB3KAKuuc0aaKBkEtxYi3rfhd67aL2p3x32qYIcRSodFaN04aeL2vc4
 llnN59HY_Jn1Qs473Y.NICCeUbaSThpz_V72OO2YpHnX.2KkWF97Vq1wCdAW2nzPsU7b_wp8RBXo
 kLSlFdp.kJ7FT.pUDz7e6dmeJv3a..dWwKHJBGi0LdQw.Z6.euowZ.9oHLtsbhOPusnfJE5TCk.N
 gp6.Xt51QNQMFqUdKy8onhoNjy_0ZzTmXo3SzeakYk7dfjPwcpiN0jIRmxoCBGC2SXtDHhNLTGcJ
 UemtLX64R9JHYSZcfnTH9hFmgKK_P0fTKCju5_LzFvTwUUpzfmTiODbijIgSv_A1XxARxodZZQ0X
 lWxc.L3E.A8C5NoA.Mf5x8CqVX7vOnoRxaZAWYMcu7mcEClNmjZrrhxYSOF5OZn.Z3JVxITscZza
 ocCtSP4vvLQGOvI2LnybvYnak2HXGijUEKuEqvtI4mIO1q.L_BNGD59G2dikH_HM87gJfjwuABbJ
 7FPtr.VQZP1UiTUvOMfxqEmq_7kK2CWRqVz5q5ujTrCoW.h7SGv1Lga6eGdY4rOFjg1.ryKEyIVc
 RlY_cWI6LZkR49B8zT1RGdlhV15w1M26wr8.jkpUfiE91RaPgn8nZf1Gy5AjBcD0k36eahmUyfUM
 O9t6t0oq_Q2wjqtwG9slhdKui6c_5utzswi0dgbFShR5euLVQv8bOdS.O.XrBz3NvHAYDemMw2Wn
 DfO0uJ77AFTEQGQz_W3.BQCTUpRGSXwf987ks2FgKbItLnROvs4A6GHIqeuu72sdFbYoTvyrsYXz
 Q8_VQb9vVT1SGkp5nXrOIAlPpws6B_b1jWAzVFREgTNzLrlaIHo6eJTte6Mkw1IH9JumbxdJjDn_
 KowrAlkj5RUaXcnBSoY6jmqLHVf5G5Y58vi4SmBKJmMwNJnPXs2jhs8ej5TAIm2Eck_wnyJjCZky
 6rpwv4fHzbH8rCXXH22kdlPjAgyyDOECQNz3C3e0s1hhIWFtEpc.nhM9IYP5pJD8hoE81.qhnWES
 hOM4jZopkj3eLvdh_6BKwmjGc8shv3uUJMkCJ4oZVjOUZPF2E7V77SwxIPt9F2f7B9GV.GoTwveJ
 dali2U8fGZShKUrqUArhgzyTfYJ5h03RFYLZDZEfGT9AT8lcUvhmO9ePxGLXIoNhg4F.KNPXLJuH
 WIvTfigIhhphLmRcI5sAnrd_KnIdsACxP5jdrVN3Ae.5PXu7LCFL2YlU4A.6pf3FGBLJnfIEP1g0
 VqF8k6YL3S_vL23wDcTNZ8E1D6NMC7hWQMxfVG5yFySViRTfl84HYlW00IsFLVrKRkdPqv92lfpT
 RUypFh62o0PE0i.e.nOoapa0nXFMuaLahdhUSjXmL45eDjy2I.W.6V4Nxr375yv8F6Y1jqCXD9sF
 b97m7M3KQossWfnIYyfwJ.JIBUy8LlBaOjxZ8M6TC7ZY1.awKcORLruC_BUK3_4OJp4EVFN9MQfT
 _RshdmyiBEjTdg_EO3gNU81.JMCHqkwVqFHUjWyzYpz2csrrp2MKsrW7RhUDyE4S_hHLWgSKOw7D
 BuInu.wq5936qitB2f_oJ3MhFzwR0rPCK616IMlz8HMDjjXzB8G6BZ4pbaFCU1x1eQumSO7Zmut7
 1TdFyqr2n7poWnzIJtgxySf90KwXjVrc45m7Lhgjk_o4Nopw2F8Cu8laueuOmf6jrAqbnFaLzQq0
 UmanO67AbUCAg_JtxyvYKhULh_dphMeySMTzWNpvfCNSq0VCvSDBckMnaqb_8b94pg2TgUWOoOV4
 odlrovDuhTWlIJ.8Qx4rRN5sANBRA4QjB534ATrBj7SgDSYRYOl.iSMefesyncKgWyUmvwixD7Nl
 mtNg7Xzj9KAHL9ogsJBoHHUE6ZK6Ih6wy1Mv3mx4CKVWhTy1yRFjVDmQbT8DNO20sSFz79JlYvwx
 _SugRDJgeLY2tLPEc4kNwpqVinRmoaW7u8VfcgQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9712f74f-be1b-4525-b3f4-7f57a9300175
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sun, 1 Jun 2025 18:18:43 +0000
Received: by hermes--production-gq1-74d64bb7d7-rstz2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7c5ad7edf4b620b53d443be3a880f0a8;
          Sun, 01 Jun 2025 18:18:40 +0000 (UTC)
Message-ID: <e07cf640-ecf9-4cc6-9cd5-cc06fb6c818a@schaufler-ca.com>
Date: Sun, 1 Jun 2025 11:18:39 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] security: add Lilium - Linux Integrity Lock-In User
 Module
To: =?UTF-8?B?4oSw8J2Tg/Cdk4/ihLQg4oSx8J2TivCdk4DihK8=?=
 <milesonerd@outlook.com>, "serge@hallyn.com" <serge@hallyn.com>
Cc: "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <SCYP152MB62611CB2B296124E47CB1C7CB063A@SCYP152MB6261.LAMP152.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <SCYP152MB62611CB2B296124E47CB1C7CB063A@SCYP152MB6261.LAMP152.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23884 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/31/2025 6:04 PM, ℰ𝓃𝓏ℴ ℱ𝓊𝓀ℯ wrote:
> From f34a53c7e615fb6e60b21bdcb5b1979edaf52088 Mon Sep 17 00:00:00 2001
> From: Enzo Fuke <milesonerd@outlook.com>
> Date: Sun, 1 Jun 2025 00:26:43 +0000
> Subject: [PATCH] Lilium LSM

You need a patch description here. Please run scripts/checkpatch.pl
on all your patches. If they do not pass they will not be accepted,
regardless of any value there may be in the code.

> ---
>  security/lilium/Kconfig         |  82 ++++++
>  security/lilium/Makefile        |  10 +
>  security/lilium/lilium_config.h |  24 ++
>  security/lilium/lilium_lsm.c    | 468 ++++++++++++++++++++++++++++++++
>  security/lilium/lilium_rust.rs  |  83 ++++++
>  5 files changed, 667 insertions(+)
>  create mode 100644 security/lilium/Kconfig
>  create mode 100644 security/lilium/Makefile
>  create mode 100644 security/lilium/lilium_config.h
>  create mode 100644 security/lilium/lilium_lsm.c
>  create mode 100644 security/lilium/lilium_rust.rs
>
> diff --git a/security/lilium/Kconfig b/security/lilium/Kconfig
> new file mode 100644
> index 0000000..3072964
> --- /dev/null
> +++ b/security/lilium/Kconfig
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Lilium (Linux Integrity Lock-In User Module)
> +# Copyright (C) 2025 Enzo Fuke
> +#
> +config SECURITY_LILIUM
> +   bool "Lilium (Linux Integrity Lock-In User Module) Support"
> +   depends on SECURITY
> +   help
> +     This enables the Lilium Linux Security Module, which provides
> +     modular security mechanisms for restricting various system
> +     operations including ptrace, mmap/mprotect with PROT_EXEC,
> +     kexec_load, clone/unshare, module management, and file operations.
> +    
> +     All security mechanisms are disabled by default and can be
> +     enabled individually through sysctl.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_LILIUM_PTRACE
> +   bool "Lilium ptrace restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables ptrace access restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_LILIUM_MPROTECT
> +   bool "Lilium mmap/mprotect restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables mmap/mprotect with PROT_EXEC restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_LILIUM_KEXEC
> +   bool "Lilium kexec_load restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables kexec_load restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_LILIUM_CLONE
> +   bool "Lilium clone/unshare restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables clone and unshare restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_LILIUM_MODULE
> +   bool "Lilium module management restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables module loading/unloading restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_LILIUM_OPEN
> +   bool "Lilium file open restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables open/openat restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_LILIUM_IOCTL
> +   bool "Lilium ioctl restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables ioctl restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> diff --git a/security/lilium/Makefile b/security/lilium/Makefile
> new file mode 100644
> index 0000000..17aeb04
> --- /dev/null
> +++ b/security/lilium/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Lilium (Linux Integrity Lock-In User Module)
> +# Copyright (C) 2025 Enzo Fuke
> +#
> +obj-$(CONFIG_SECURITY_LILIUM) += lilium.o
> +
> +lilium-y := lilium_lsm.o
> +lilium-$(CONFIG_RUST) += lilium_rust.o
> +
> diff --git a/security/lilium/lilium_config.h b/security/lilium/lilium_config.h
> new file mode 100644
> index 0000000..1633c7e
> --- /dev/null
> +++ b/security/lilium/lilium_config.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Lilium (Linux Integrity Lock-In User Module)
> + * Copyright (C) 2025 Enzo Fuke
> + */
> +
> +#ifndef _SECURITY_LILIUM_CONFIG_H
> +#define _SECURITY_LILIUM_CONFIG_H
> +
> +/* Default disabled state for all Lilium features */
> +#define LILIUM_FEATURE_DISABLED 0
> +#define LILIUM_FEATURE_ENABLED  1
> +
> +/* Feature control flags - all disabled by default */
> +#define LILIUM_DEFAULT_PTRACE   LILIUM_FEATURE_DISABLED
> +#define LILIUM_DEFAULT_MPROTECT LILIUM_FEATURE_DISABLED
> +#define LILIUM_DEFAULT_KEXEC    LILIUM_FEATURE_DISABLED
> +#define LILIUM_DEFAULT_CLONE    LILIUM_FEATURE_DISABLED
> +#define LILIUM_DEFAULT_MODULE   LILIUM_FEATURE_DISABLED
> +#define LILIUM_DEFAULT_OPEN     LILIUM_FEATURE_DISABLED
> +#define LILIUM_DEFAULT_IOCTL    LILIUM_FEATURE_DISABLED

This is an unconventional way to achieve this end.

> +
> +#endif /* _SECURITY_LILIUM_CONFIG_H */
> +
> diff --git a/security/lilium/lilium_lsm.c b/security/lilium/lilium_lsm.c
> new file mode 100644
> index 0000000..82bac41
> --- /dev/null
> +++ b/security/lilium/lilium_lsm.c
> @@ -0,0 +1,468 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Lilium (Linux Integrity Lock-In User Module)
> + * Copyright (C) 2025 Enzo Fuke
> + */
> +
> +#include <linux/lsm_hooks.h>
> +#include <linux/ptrace.h>
> +#include <linux/prctl.h>
> +#include <linux/ratelimit.h>
> +#include <linux/workqueue.h>
> +#include <linux/string_helpers.h>
> +#include <linux/task_work.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/uaccess.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/mman.h>
> +#include <linux/kexec.h>
> +#include <linux/slab.h>
> +#include <linux/nsproxy.h>
> +#include <linux/security.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <uapi/linux/lsm.h>
> +
> +#include "lilium_config.h"
> +
> +/* Feature control variables - all disabled by default */
> +static int lilium_ptrace_enabled = LILIUM_DEFAULT_PTRACE;
> +static int lilium_mprotect_enabled = LILIUM_DEFAULT_MPROTECT;
> +static int lilium_kexec_enabled = LILIUM_DEFAULT_KEXEC;
> +static int lilium_clone_enabled = LILIUM_DEFAULT_CLONE;
> +static int lilium_module_enabled = LILIUM_DEFAULT_MODULE;
> +static int lilium_open_enabled = LILIUM_DEFAULT_OPEN;
> +static int lilium_ioctl_enabled = LILIUM_DEFAULT_IOCTL;
> +
> +/* Kobject for Lilium sysfs interface */
> +static struct kobject *lilium_kobj;
> +
> +/* Sysfs attribute show/store functions */
> +static ssize_t ptrace_enabled_show(struct kobject *kobj,
> +                 struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_ptrace_enabled);

Kernel coding style uses tab8. Please review the kernel coding
guidelines before your next submission.

> +}
> +
> +static ssize_t ptrace_enabled_store(struct kobject *kobj,
> +                  struct kobj_attribute *attr,
> +                  const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_ptrace_enabled = val;
> +   return count;
> +}
> +
> +static ssize_t mprotect_enabled_show(struct kobject *kobj,
> +                   struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_mprotect_enabled);
> +}
> +
> +static ssize_t mprotect_enabled_store(struct kobject *kobj,
> +                    struct kobj_attribute *attr,
> +                    const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_mprotect_enabled = val;
> +   return count;
> +}
> +
> +static ssize_t kexec_enabled_show(struct kobject *kobj,
> +                struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_kexec_enabled);
> +}
> +
> +static ssize_t kexec_enabled_store(struct kobject *kobj,
> +                 struct kobj_attribute *attr,
> +                 const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_kexec_enabled = val;
> +   return count;
> +}
> +
> +static ssize_t clone_enabled_show(struct kobject *kobj,
> +                struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_clone_enabled);
> +}
> +
> +static ssize_t clone_enabled_store(struct kobject *kobj,
> +                 struct kobj_attribute *attr,
> +                 const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_clone_enabled = val;
> +   return count;
> +}
> +
> +static ssize_t module_enabled_show(struct kobject *kobj,
> +                 struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_module_enabled);
> +}
> +
> +static ssize_t module_enabled_store(struct kobject *kobj,
> +                  struct kobj_attribute *attr,
> +                  const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_module_enabled = val;
> +   return count;
> +}
> +
> +static ssize_t open_enabled_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_open_enabled);
> +}
> +
> +static ssize_t open_enabled_store(struct kobject *kobj,
> +                struct kobj_attribute *attr,
> +                const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_open_enabled = val;
> +   return count;
> +}
> +
> +static ssize_t ioctl_enabled_show(struct kobject *kobj,
> +                struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_ioctl_enabled);
> +}
> +
> +static ssize_t ioctl_enabled_store(struct kobject *kobj,
> +                 struct kobj_attribute *attr,
> +                 const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_ioctl_enabled = val;
> +   return count;
> +}
> +
> +/* Define sysfs attributes */
> +static struct kobj_attribute ptrace_attr =
> +   __ATTR(ptrace_enabled, 0644, ptrace_enabled_show, ptrace_enabled_store);
> +static struct kobj_attribute mprotect_attr =
> +   __ATTR(mprotect_enabled, 0644, mprotect_enabled_show, mprotect_enabled_store);
> +static struct kobj_attribute kexec_attr =
> +   __ATTR(kexec_enabled, 0644, kexec_enabled_show, kexec_enabled_store);
> +static struct kobj_attribute clone_attr =
> +   __ATTR(clone_enabled, 0644, clone_enabled_show, clone_enabled_store);
> +static struct kobj_attribute module_attr =
> +   __ATTR(module_enabled, 0644, module_enabled_show, module_enabled_store);
> +static struct kobj_attribute open_attr =
> +   __ATTR(open_enabled, 0644, open_enabled_show, open_enabled_store);
> +static struct kobj_attribute ioctl_attr =
> +   __ATTR(ioctl_enabled, 0644, ioctl_enabled_show, ioctl_enabled_store);
> +
> +/* Attribute group */
> +static struct attribute *lilium_attrs[] = {
> +   &ptrace_attr.attr,
> +   &mprotect_attr.attr,
> +   &kexec_attr.attr,
> +   &clone_attr.attr,
> +   &module_attr.attr,
> +   &open_attr.attr,
> +   &ioctl_attr.attr,
> +   NULL,
> +};
> +
> +static struct attribute_group lilium_attr_group = {
> +   .attrs = lilium_attrs,
> +};
> +
> +/* LSM Hook Implementations */
> +
> +static int lilium_ptrace_access_check(struct task_struct *child,
> +                    unsigned int mode)
> +{
> +   if (!lilium_ptrace_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for ptrace restrictions */
> +   if (mode & PTRACE_MODE_ATTACH) {
> +       /* Allow if caller has CAP_SYS_PTRACE */
> +       if (capable(CAP_SYS_PTRACE))
> +           return 0;
> +      
> +       /* Deny ptrace access */
> +       return -EPERM;
> +   }

	if ((mode & PTRACE_MODE_ATTACH) && !capable(CAP_SYS_PTRACE))
		return -EPERM;

> +
> +   return 0;
> +}
> +
> +static int lilium_file_mprotect(struct vm_area_struct *vma,
> +                  unsigned long reqprot,
> +                  unsigned long prot)
> +{
> +   if (!lilium_mprotect_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for mprotect restrictions */
> +   if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
> +       /* Allow if caller has CAP_SYS_ADMIN */
> +       if (capable(CAP_SYS_ADMIN))
> +           return 0;
> +      
> +       /* Deny making non-executable memory executable */
> +       return -EPERM;
> +   }
> +
> +   return 0;
> +}
> +
> +static int lilium_mmap_file(struct file *file, unsigned long reqprot,
> +              unsigned long prot, unsigned long flags)
> +{
> +   if (!lilium_mprotect_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for mmap restrictions */
> +   if ((prot & PROT_EXEC) && (flags & MAP_ANONYMOUS)) {
> +       /* Allow if caller has CAP_SYS_ADMIN */
> +       if (capable(CAP_SYS_ADMIN))
> +           return 0;
> +      
> +       /* Deny executable anonymous mappings */
> +       return -EPERM;
> +   }
> +
> +   return 0;
> +}
> +
> +static int lilium_task_create(struct task_struct *task,
> +                struct task_struct *child)
> +{
> +   if (!lilium_clone_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for clone restrictions */
> +   /* This is a placeholder - actual implementation would check
> +    * specific clone flags or namespace creation
> +    */
> +  
> +   return 0;
> +}
> +
> +static int lilium_task_fix_setuid(struct task_struct *task,
> +                struct cred *new,
> +                const struct cred *old,
> +                int flags)
> +{
> +   if (!lilium_clone_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for unshare restrictions */
> +   /* This is a placeholder - actual implementation would check
> +    * specific unshare flags or namespace creation
> +    */
> +  
> +   return 0;
> +}
> +
> +static int lilium_kernel_module_request(char *kmod_name)
> +{
> +   if (!lilium_module_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for module loading restrictions */
> +   /* Allow if caller has CAP_SYS_MODULE */
> +   if (capable(CAP_SYS_MODULE))
> +       return 0;
> +  
> +   /* Deny module loading */
> +   return -EPERM;
> +}
> +
> +static int lilium_kernel_module_from_file(struct file *file)
> +{
> +   if (!lilium_module_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for module loading restrictions */
> +   /* Allow if caller has CAP_SYS_MODULE */
> +   if (capable(CAP_SYS_MODULE))
> +       return 0;
> +  
> +   /* Deny module loading */
> +   return -EPERM;
> +}
> +
> +static int lilium_file_open(struct file *file)
> +{
> +   if (!lilium_open_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for file open restrictions */
> +   /* This is a placeholder - actual implementation would check
> +    * specific file paths or attributes
> +    */
> +  
> +   return 0;
> +}
> +
> +static int lilium_file_ioctl(struct file *file, unsigned int cmd,
> +               unsigned long arg)
> +{
> +   if (!lilium_ioctl_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for ioctl restrictions */
> +   /* This is a placeholder - actual implementation would check
> +    * specific ioctl commands
> +    */
> +  
> +   return 0;
> +}
> +
> +static int lilium_sb_mount(const char *dev_name, const struct path *path,
> +             const char *type, unsigned long flags, void *data)
> +{
> +   if (!lilium_open_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for mount restrictions */
> +   /* This is a placeholder - actual implementation would check
> +    * specific mount flags or filesystem types
> +    */
> +  
> +   return 0;
> +}
> +
> +static int lilium_kexec_kernel_load(struct kimage *image)
> +{
> +   if (!lilium_kexec_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for kexec_load restrictions */
> +   /* Allow if caller has CAP_SYS_BOOT */
> +   if (capable(CAP_SYS_BOOT))
> +       return 0;
> +  
> +   /* Deny kexec_load */
> +   return -EPERM;
> +}
> +
> +/* LSM Hook Definitions */
> +static struct security_hook_list lilium_hooks[] = {
> +   LSM_HOOK_INIT(ptrace_access_check, lilium_ptrace_access_check),
> +   LSM_HOOK_INIT(file_mprotect, lilium_file_mprotect),
> +   LSM_HOOK_INIT(mmap_file, lilium_mmap_file),
> +   LSM_HOOK_INIT(task_create, lilium_task_create),
> +   LSM_HOOK_INIT(task_fix_setuid, lilium_task_fix_setuid),
> +   LSM_HOOK_INIT(kernel_module_request, lilium_kernel_module_request),
> +   LSM_HOOK_INIT(kernel_module_from_file, lilium_kernel_module_from_file),
> +   LSM_HOOK_INIT(file_open, lilium_file_open),
> +   LSM_HOOK_INIT(file_ioctl, lilium_file_ioctl),
> +   LSM_HOOK_INIT(sb_mount, lilium_sb_mount),
> +   LSM_HOOK_INIT(kexec_kernel_load, lilium_kexec_kernel_load),
> +};
> +
> +static const struct lsm_id lilium_lsmid = {
> +   .name = "lilium",
> +   .id = LSM_ID_MAJOR_MAX,
> +};
> +
> +static void lilium_exit(void)
> +{
> +   if (lilium_kobj) {
> +       sysfs_remove_group(lilium_kobj, &lilium_attr_group);
> +       kobject_put(lilium_kobj);
> +   }
> +}
> +
> +static int __init lilium_init(void)
> +{
> +   int ret;
> +
> +   /* Create sysfs interface */
> +   lilium_kobj = kobject_create_and_add("lilium", kernel_kobj);
> +   if (!lilium_kobj)
> +       return -ENOMEM;
> +
> +   ret = sysfs_create_group(lilium_kobj, &lilium_attr_group);
> +   if (ret) {
> +       kobject_put(lilium_kobj);
> +       return ret;
> +   }
> +
> +   /* Register LSM hooks */
> +   security_add_hooks(lilium_hooks, ARRAY_SIZE(lilium_hooks), &lilium_lsmid);
> +
> +   pr_info("Lilium: Linux Integrity Lock-In User Module initialized\n");
> +   return 0;
> +}
> +
> +security_initcall(lilium_init);
> +module_exit(lilium_exit);
> +
> +MODULE_DESCRIPTION("Lilium (Linux Integrity Lock-In User Module)");
> +MODULE_AUTHOR("Enzo Fuke");
> +MODULE_LICENSE("GPL v2");
> +
> diff --git a/security/lilium/lilium_rust.rs b/security/lilium/lilium_rust.rs
> new file mode 100644
> index 0000000..7901d9d
> --- /dev/null
> +++ b/security/lilium/lilium_rust.rs
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Lilium (Linux Integrity Lock-In User Module)
> + * Copyright (C) 2025 Enzo Fuke
> + */
> +
> +
> +use kernel::prelude::*;
> +use kernel::security;
> +use kernel::file::File;
> +use kernel::task::Task;
> +use kernel::cred::Credential;
> +
> +const LILIUM_FEATURE_DISABLED: i32 = 0;
> +const LILIUM_FEATURE_ENABLED: i32 = 1;
> +
> +extern "C" {
> +    static lilium_ptrace_enabled: i32;
> +    static lilium_mprotect_enabled: i32;
> +    static lilium_kexec_enabled: i32;
> +    static lilium_clone_enabled: i32;
> +    static lilium_module_enabled: i32;
> +    static lilium_open_enabled: i32;
> +    static lilium_ioctl_enabled: i32;
> +}
> +
> +pub struct LiliumOps;
> +
> +impl security::SecurityHooks for LiliumOps {
> +    fn ptrace_access_check(
> +        &self,
> +        child: &Task,
> +        mode: u32,
> +    ) -> Result<security::SecurityHookResult> {
> +        if unsafe { lilium_ptrace_enabled } == LILIUM_FEATURE_DISABLED {
> +            return Ok(security::SecurityHookResult::Default);
> +        }
> +
> +        if mode & security::PTRACE_MODE_ATTACH != 0 {
> +            if kernel::current_cred().has_capability(kernel::CAP_SYS_PTRACE) {
> +                return Ok(security::SecurityHookResult::Default);
> +            }
> +            
> +            return Ok(security::SecurityHookResult::Reject);
> +        }
> +
> +        Ok(security::SecurityHookResult::Default)
> +    }
> +
> +    fn file_mprotect(
> +        &self,
> +        vma: &kernel::mm::VirtualMemoryArea,
> +        reqprot: u64,
> +        prot: u64,
> +    ) -> Result<security::SecurityHookResult> {
> +        if unsafe { lilium_mprotect_enabled } == LILIUM_FEATURE_DISABLED {
> +            return Ok(security::SecurityHookResult::Default);
> +        }
> +
> +        if (prot & kernel::mm::PROT_EXEC) != 0 && (vma.flags() & kernel::mm::VM_EXEC) == 0 {
> +            if kernel::current_cred().has_capability(kernel::CAP_SYS_ADMIN) {
> +                return Ok(security::SecurityHookResult::Default);
> +            }
> +            
> +            return Ok(security::SecurityHookResult::Reject);
> +        }
> +
> +        Ok(security::SecurityHookResult::Default)
> +    }
> +
> +    fn file_open(
> +        &self,
> +        file: &File,
> +    ) -> Result<security::SecurityHookResult> {
> +        if unsafe { lilium_open_enabled } == LILIUM_FEATURE_DISABLED {
> +            return Ok(security::SecurityHookResult::Default);
> +        }
> +
> +
> +        Ok(security::SecurityHookResult::Default)
> +    }
> +}
> +
> --
> 2.49.0

