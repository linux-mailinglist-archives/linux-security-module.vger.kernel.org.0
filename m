Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40E08E2C43
	for <lists+linux-security-module@lfdr.de>; Thu, 24 Oct 2019 10:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438240AbfJXIe0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 24 Oct 2019 04:34:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44875 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfJXIeZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Oct 2019 04:34:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id u22so22647587qkk.11
        for <linux-security-module@vger.kernel.org>; Thu, 24 Oct 2019 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JALv61L0upHT0jVW0my7wTf+vcKwJilcXFy7W8ITK8s=;
        b=rX70UM5HxMXO21QpOjYB03wHl3CFqJ6aZT5SBx2eZdJAYkVp9JXAy9ln3xmoR6j+G6
         bEY1V4jsViaifyjhrxOjyqpCZdIvwJ93MO1DxeBRPrRR7naQIWeeea4DHu9DgZrJt41R
         KO6ovPwnnmKg3pthza9rCguksRrgY3N+YrN29sgh2WOz92I6APZPK/U1N7/p26Ij9IJP
         l517ojZaICPclpgDY/Y/qg6fTkdBGsAoJBgX50frNMWA5jz84ERUpWDLfOPS9LjYsp3A
         entlf1ybEOBokY1me17xJeZOurHDe81KGVMHnq4xM8jupzgu1OjgUC7vJwyBSYYTIuMo
         6urA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JALv61L0upHT0jVW0my7wTf+vcKwJilcXFy7W8ITK8s=;
        b=Sl+YT4a8Zm+ERR3RaeDpdOXfOcaUxMXuUFwhR4d2Uvc8ezQYJlsQfiMhRhXpJxX/5U
         1feJTKAU7kaqDQVeR2zXIl+e+5aeRBblnYfukEY2vwTUjSrKQUw5sgxGnc2Qcdw1iVss
         x4vCsbq0hkEdYlk9Tltg+R2Wrk5gL5VGiMBmL8aR74WHNY4OJ6YMljEtaX8DuFZmHW22
         GHcOCk5iJJzlGPRechRk7Ada66KRBm5lWvmCtHh+uhvD6hyQPKjVoicZNnct4/fkWUQr
         eomLIM3JYBJT2/aFkpvHr3Umy3NMvJdzF2hmDpRv6LMxpon5ZVCD9zSYAqNjr6z1yvHm
         hVGQ==
X-Gm-Message-State: APjAAAVHAQSZeLv1nthSShGg2hgNHEo1ZgILsZ/66CLHGyn2D9oUO0AI
        sDA5VBY3EUVmZijCdv1AR2/zyCigcsX4o6eYiukvXQ==
X-Google-Smtp-Source: APXvYqzEeRoIoUpWbOig3K6uWo3IeR5zojTN2Okyr+AKMP0R/wjRfVKXCmkHiCpubfk6FoUopBoo4eZZuzHuDOUAJ2o=
X-Received: by 2002:a05:620a:6b6:: with SMTP id i22mr9059976qkh.256.1571906063875;
 Thu, 24 Oct 2019 01:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a5727f0595a30026@google.com>
In-Reply-To: <000000000000a5727f0595a30026@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 24 Oct 2019 10:34:12 +0200
Message-ID: <CACT4Y+Y0W9Zm6Re6jC9f59Rm=f7P-dKtE-OUCAOD0ubwPZA_Uw@mail.gmail.com>
Subject: Re: KCSAN: data-race in common_perm_cond / task_dump_owner
To:     syzbot <syzbot+109584edb0b8511d7dad@syzkaller.appspotmail.com>
Cc:     Marco Elver <elver@google.com>, James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 24, 2019 at 9:30 AM syzbot
<syzbot+109584edb0b8511d7dad@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> git tree:       https://github.com/google/ktsan.git kcsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=155db950e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> dashboard link: https://syzkaller.appspot.com/bug?extid=109584edb0b8511d7dad
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+109584edb0b8511d7dad@syzkaller.appspotmail.com

This may be pretty bad if I am not missing something, see:
https://groups.google.com/d/msg/syzkaller-bugs/mzwiXt4ml68/GuAUQrWtBQAJ

> ==================================================================
> BUG: KCSAN: data-race in common_perm_cond / task_dump_owner
>
> read to 0xffff888124ca931c of 4 bytes by task 7605 on cpu 0:
>   common_perm_cond+0x65/0x110 security/apparmor/lsm.c:217
>   apparmor_inode_getattr+0x2b/0x40 security/apparmor/lsm.c:389
>   security_inode_getattr+0x9b/0xd0 security/security.c:1222
>   vfs_getattr+0x2e/0x70 fs/stat.c:115
>   vfs_statx+0x102/0x190 fs/stat.c:191
>   vfs_stat include/linux/fs.h:3242 [inline]
>   __do_sys_newstat+0x51/0xb0 fs/stat.c:341
>   __se_sys_newstat fs/stat.c:337 [inline]
>   __x64_sys_newstat+0x3a/0x50 fs/stat.c:337
>   do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> write to 0xffff888124ca931c of 4 bytes by task 7608 on cpu 1:
>   task_dump_owner+0xd8/0x260 fs/proc/base.c:1742
>   pid_update_inode+0x3c/0x70 fs/proc/base.c:1818
>   pid_revalidate+0x91/0xd0 fs/proc/base.c:1841
>   d_revalidate fs/namei.c:758 [inline]
>   d_revalidate fs/namei.c:755 [inline]
>   lookup_fast+0x6f2/0x700 fs/namei.c:1607
>   walk_component+0x6d/0xe80 fs/namei.c:1796
>   link_path_walk.part.0+0x5d3/0xa90 fs/namei.c:2131
>   link_path_walk fs/namei.c:2062 [inline]
>   path_openat+0x14f/0x36e0 fs/namei.c:3524
>   do_filp_open+0x11e/0x1b0 fs/namei.c:3555
>   do_sys_open+0x3b3/0x4f0 fs/open.c:1097
>   __do_sys_open fs/open.c:1115 [inline]
>   __se_sys_open fs/open.c:1110 [inline]
>   __x64_sys_open+0x55/0x70 fs/open.c:1110
>   do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 7608 Comm: ps Not tainted 5.4.0-rc3+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000a5727f0595a30026%40google.com.
