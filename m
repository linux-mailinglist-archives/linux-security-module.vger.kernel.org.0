Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1B6414F7C
	for <lists+linux-security-module@lfdr.de>; Wed, 22 Sep 2021 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhIVR7P (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 22 Sep 2021 13:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhIVR7O (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Sep 2021 13:59:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC644C061574
        for <linux-security-module@vger.kernel.org>; Wed, 22 Sep 2021 10:57:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c22so12829487edn.12
        for <linux-security-module@vger.kernel.org>; Wed, 22 Sep 2021 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rUoAkDJVUB1Jp/ntmfoD0RhFCUd1Ba0OZgr54iuvb4I=;
        b=juXU2At/IQAYZGJaKJGk25EiXTcFd0nSjo06r2qsC+K8RfbmAEZkrgNBPBwUgSzftr
         AJ5SEAtgfCPBZMnxkk6SmEthVuLlDe7pwJ10MiEwYzqUh7JI4l4spD4UDYUC89pd/YIj
         UDokUNjmytAfFr/B2GnT4zmVRg+91UuGCmVGM6UcPo3iOdIhZsrpAmWi9MUMgpyO8j3Z
         27VZ3tC7JwXLomhlfoC4txdPWeGLQkkNfVfBQPaNVZQnO2fDVdBBs4DmPdnPV0ZGkskf
         3qsSTfmEQ9l7shw+NqsCBRjpj0+kWaFPqOkmfuaTuarl/VlpoPIBf4efbwRmQLCBX0Aj
         2D9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rUoAkDJVUB1Jp/ntmfoD0RhFCUd1Ba0OZgr54iuvb4I=;
        b=KVTIPA2qY78g++LbsIbYjt+xWdwofOv+1V/58p4ePbhkpGNAqGwlAKM2nwvDRqUW5n
         09r2niQTpb74CCDGLcMEfJOOMY3LgpicQLFSLBa89crNMIg6Ef2Dway4fGVTN6CpQB2j
         GCefERNK5MuSjotHBMBd2QHX5lTZRMswMtAssl3JGgcw0gvBM+yeF4/5+vFq10KyuXtI
         ajxsmILxHpAIfcJxc5fOaYvJ7yBFGZLXe3MEEc4ywxnwuurmK7IgAn+GLgUk+w54M6wc
         GaobSHUwpZWd2rA3IlUhCy7oBqjLXwl0lqiFzF6dB+O+u3AiMkL45glxIYBR7W2yc9GB
         3iZA==
X-Gm-Message-State: AOAM530kfHbBoVLKIDd1Ia9azTIg5r5JI08S19Mgag16TsS3Q9CHwYZ5
        HcyzG/Ob63AlH1lFlhRupIaVprdonWF62FnS1/I9iYcVCw==
X-Google-Smtp-Source: ABdhPJzBlsbgvP0tiCsHiJk1brrzD1bvd/rhCZ4aJDVGEM+6VZfmkRGngQPZEUhyPUg0WJVr766yxdSXq1zoAfX9AZI=
X-Received: by 2002:a17:906:ecae:: with SMTP id qh14mr505441ejb.195.1632333461903;
 Wed, 22 Sep 2021 10:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Sep 2021 13:57:31 -0400
Message-ID: <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 16, 2021 at 9:14 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Hi Linus,
>
> A single patch to address some issues with the incorrect subject being
> used in some of the SELinux lockdown access controls.  You saw, and
> joined the discussion, earlier versions of this patch that included
> the related BPF changes; the BPF changes have already been merged,
> this patch has all the remainders.  Beyond that, the commit
> description is pretty good so if you are interested in more detail I
> would suggest reading that first.
>
> Please merge for the next v5.15-rcX release, thank you.
> -Paul

I wanted to check in on this PR to see if you were planning on merging
it for v5.15-rcX, kicking it back for -next instead, or simply glaring
at it with quiet disgust?

> --
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
>
>  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
>
> are available in the Git repository at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
>    tags/selinux-pr-20210916
>
> for you to fetch changes up to fdc9cbff7a764513a5e72a03b796087fcadb2fa3:
>
>  lockdown,selinux: fix wrong subject in some SELinux lockdown checks
>    (2021-09-16 21:04:44 -0400)
>
> ----------------------------------------------------------------
> selinux/stable-5.15 PR 20210916
>
> ----------------------------------------------------------------
> Ondrej Mosnacek (1):
>      lockdown,selinux: fix wrong subject in some SELinux lockdown checks
>
> arch/powerpc/xmon/xmon.c             |  4 ++--
> arch/x86/kernel/ioport.c             |  4 ++--
> arch/x86/kernel/msr.c                |  4 ++--
> arch/x86/mm/testmmiotrace.c          |  2 +-
> drivers/acpi/acpi_configfs.c         |  2 +-
> drivers/acpi/custom_method.c         |  2 +-
> drivers/acpi/osl.c                   |  3 ++-
> drivers/acpi/tables.c                |  2 +-
> drivers/char/mem.c                   |  2 +-
> drivers/cxl/pci.c                    |  2 +-
> drivers/firmware/efi/efi.c           |  2 +-
> drivers/firmware/efi/test/efi_test.c |  2 +-
> drivers/pci/pci-sysfs.c              |  6 +++---
> drivers/pci/proc.c                   |  6 +++---
> drivers/pci/syscall.c                |  2 +-
> drivers/pcmcia/cistpl.c              |  2 +-
> drivers/tty/serial/serial_core.c     |  2 +-
> fs/debugfs/file.c                    |  2 +-
> fs/debugfs/inode.c                   |  2 +-
> fs/proc/kcore.c                      |  2 +-
> fs/tracefs/inode.c                   |  2 +-
> include/linux/lsm_hook_defs.h        |  2 +-
> include/linux/lsm_hooks.h            |  1 +
> include/linux/security.h             |  5 +++--
> kernel/bpf/helpers.c                 | 10 ++++++----
> kernel/events/core.c                 |  2 +-
> kernel/kexec.c                       |  2 +-
> kernel/kexec_file.c                  |  2 +-
> kernel/module.c                      |  2 +-
> kernel/params.c                      |  2 +-
> kernel/power/hibernate.c             |  2 +-
> kernel/trace/bpf_trace.c             | 25 +++++++++++++++----------
> kernel/trace/ftrace.c                |  4 ++--
> kernel/trace/ring_buffer.c           |  2 +-
> kernel/trace/trace.c                 | 10 +++++-----
> kernel/trace/trace_events.c          |  2 +-
> kernel/trace/trace_events_hist.c     |  4 ++--
> kernel/trace/trace_events_synth.c    |  2 +-
> kernel/trace/trace_events_trigger.c  |  2 +-
> kernel/trace/trace_kprobe.c          |  6 +++---
> kernel/trace/trace_printk.c          |  2 +-
> kernel/trace/trace_stack.c           |  2 +-
> kernel/trace/trace_stat.c            |  2 +-
> kernel/trace/trace_uprobe.c          |  4 ++--
> net/xfrm/xfrm_user.c                 | 11 +++++++++--
> security/lockdown/lockdown.c         |  3 ++-
> security/security.c                  |  4 ++--
> security/selinux/hooks.c             |  7 +++++--
> 48 files changed, 100 insertions(+), 79 deletions(-)

-- 
paul moore
www.paul-moore.com
