Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2E1122F2
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Dec 2019 07:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfLDGd7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 4 Dec 2019 01:33:59 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36073 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfLDGd7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Dec 2019 01:33:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id v19so6142085qkv.3
        for <linux-security-module@vger.kernel.org>; Tue, 03 Dec 2019 22:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cRSRnUjyOWj8W68zyd7mIujpzqYQeBmGrBj93EFUXY=;
        b=dHJn7DD/GzIvmxGi3WJtTxnr7lobK2J/Oi4Bn7PkUXqBKdM8XiuuMSwVwxSELSeNa6
         IUh7RJ9hE279eVOvMIAtkV44u17LvJyd4BaCtSFwELWQbKZ1S+lyqLTma4AxsSRqs8i7
         oqklpct9RqWtH5GjF75DxujkhqEBZ5bzQelJUyVJuh7xIxT0yJXS87kSLU01V2OopuPT
         VzKxXdlhiY6l46M7g1r1HtJCNh140NrdpopLWPGrKSxquSLdnKmA5+gr5EJPe3sHp4CB
         GZDSc43vmbGPdnUf7u0W+O5TeBBWOs8Mm8D2D4Ss6qcbpfJ+xu5KuzDQLzTFUDYa9sIk
         5S5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cRSRnUjyOWj8W68zyd7mIujpzqYQeBmGrBj93EFUXY=;
        b=P/Kl4hSmRayLbGmVDmefpy9MDsbfezsvw4BnYOrqasCqIZyeIriXeFO0rWaZn3cx1k
         L7qCdQT2R/m0jMTeMM5nPdZxnxHrr776eTKrX9fpTVHP2i8hQVI50BAcmwBOZ7PigImA
         VkEnQpkdX5TVpkEE03wL2sEtRKVSa9rm0Je+PGh7z4KFJwh6t1C3BcrAueaY6tZgTV8q
         DYlSs56exG+wOCMU5L5ulR3CEguLl1brUGLletT/9z11FvyOtCOf1V1B6/Pu+gjnOoqD
         K51cnFGRYEvrMITXEQhitDgHTkrBdhOCgvgFuhw76tjbelOkb9LjG2OjPDklnx2GMFV9
         doHQ==
X-Gm-Message-State: APjAAAWV1eDEIi2mg0zxtP1GyNQZWJY53EQuAoqyF2el7WB8S23B7G5T
        g5jUlNfVVOxxtUIl8DWnTRNsh8p0vvc1X+Z6828AUQ==
X-Google-Smtp-Source: APXvYqwhBE4d0rB8gmQY7oLs/uQktcvJLrM1vE+q4Z7mwp3vUUtAhx3SF7wctd9w99E49ofDhRG92p9+ezHmbwCxdDo=
X-Received: by 2002:a37:4782:: with SMTP id u124mr1427511qka.8.1575441237260;
 Tue, 03 Dec 2019 22:33:57 -0800 (PST)
MIME-Version: 1.0
References: <0000000000002cfc3a0598d42b70@google.com> <CAKMK7uFAfw4M6B8WaHx6FBkYDmUBTQ6t3D8RE5BbMt=_5vyp9A@mail.gmail.com>
In-Reply-To: <CAKMK7uFAfw4M6B8WaHx6FBkYDmUBTQ6t3D8RE5BbMt=_5vyp9A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 4 Dec 2019 07:33:45 +0100
Message-ID: <CACT4Y+aV9vzJ6gs9r2RAQP+dQ_vkOc5H6hWu-prF1ECruAE_5w@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, ghalat@redhat.com,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 3, 2019 at 11:37 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Tue, Dec 3, 2019 at 11:25 PM syzbot
> <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.org/p..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10bfe282e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4455ca3b3291de891abc
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11181edae00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105cbb7ae00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:380 [inline]
> > BUG: KASAN: slab-out-of-bounds in fbcon_get_font+0x2b2/0x5e0
> > drivers/video/fbdev/core/fbcon.c:2465
> > Read of size 16 at addr ffff888094b0aa10 by task syz-executor414/9999
>
> So fbcon allocates some memory, security/tomoyo goes around and frees
> it, fbcon goes boom because the memory is gone. I'm kinda leaning
> towards "not an fbcon bug". Adding relevant security folks and mailing
> lists.
>
> But from a very quick look in tomoyo it loosk more like "machine on
> fire, random corruption all over". No idea what's going on here.

Hi Daniel,

This is an out-of-bounds access, not use-after-free.
I don't know why we print the free stack at all (maybe +Andrey knows),
but that's what KASAN did from day one. I filed
https://bugzilla.kernel.org/show_bug.cgi?id=198425 which I think is a
good idea, I will add your confusion as a data point :)
Re this bug, free stack is irrelevant, I guess it's when the heap
block was freed before it was reallocated by console. So it's plain
out-of-bounds in fbcon_get_font, which looks sane and consistent to me
and reproducible on top.


> > CPU: 0 PID: 9999 Comm: syz-executor414 Not tainted 5.4.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x197/0x210 lib/dump_stack.c:118
> >   print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
> >   __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
> >   kasan_report+0x12/0x20 mm/kasan/common.c:638
> >   check_memory_region_inline mm/kasan/generic.c:185 [inline]
> >   check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
> >   memcpy+0x24/0x50 mm/kasan/common.c:124
> >   memcpy include/linux/string.h:380 [inline]
> >   fbcon_get_font+0x2b2/0x5e0 drivers/video/fbdev/core/fbcon.c:2465
> >   con_font_get drivers/tty/vt/vt.c:4446 [inline]
> >   con_font_op+0x20b/0x1250 drivers/tty/vt/vt.c:4605
> >   vt_ioctl+0x181a/0x26d0 drivers/tty/vt/vt_ioctl.c:965
> >   tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2658
> >   vfs_ioctl fs/ioctl.c:47 [inline]
> >   file_ioctl fs/ioctl.c:545 [inline]
> >   do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
> >   ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
> >   __do_sys_ioctl fs/ioctl.c:756 [inline]
> >   __se_sys_ioctl fs/ioctl.c:754 [inline]
> >   __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
> >   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x4444d9
> > Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> > ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007fff6f4393b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007fff6f4393c0 RCX: 00000000004444d9
> > RDX: 0000000020000440 RSI: 0000000000004b72 RDI: 0000000000000005
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000400da0
> > R10: 00007fff6f438f00 R11: 0000000000000246 R12: 00000000004021e0
> > R13: 0000000000402270 R14: 0000000000000000 R15: 0000000000000000
> >
> > Allocated by task 9999:
> >   save_stack+0x23/0x90 mm/kasan/common.c:71
> >   set_track mm/kasan/common.c:79 [inline]
> >   __kasan_kmalloc mm/kasan/common.c:512 [inline]
> >   __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:485
> >   kasan_kmalloc+0x9/0x10 mm/kasan/common.c:526
> >   __do_kmalloc mm/slab.c:3656 [inline]
> >   __kmalloc+0x163/0x770 mm/slab.c:3665
> >   kmalloc include/linux/slab.h:561 [inline]
> >   fbcon_set_font+0x32d/0x860 drivers/video/fbdev/core/fbcon.c:2663
> >   con_font_set drivers/tty/vt/vt.c:4538 [inline]
> >   con_font_op+0xe18/0x1250 drivers/tty/vt/vt.c:4603
> >   vt_ioctl+0xd2e/0x26d0 drivers/tty/vt/vt_ioctl.c:913
> >   tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2658
> >   vfs_ioctl fs/ioctl.c:47 [inline]
> >   file_ioctl fs/ioctl.c:545 [inline]
> >   do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
> >   ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
> >   __do_sys_ioctl fs/ioctl.c:756 [inline]
> >   __se_sys_ioctl fs/ioctl.c:754 [inline]
> >   __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
> >   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > Freed by task 9771:
> >   save_stack+0x23/0x90 mm/kasan/common.c:71
> >   set_track mm/kasan/common.c:79 [inline]
> >   kasan_set_free_info mm/kasan/common.c:334 [inline]
> >   __kasan_slab_free+0x102/0x150 mm/kasan/common.c:473
> >   kasan_slab_free+0xe/0x10 mm/kasan/common.c:482
> >   __cache_free mm/slab.c:3426 [inline]
> >   kfree+0x10a/0x2c0 mm/slab.c:3757
> >   tomoyo_init_log+0x15c1/0x2070 security/tomoyo/audit.c:294
> >   tomoyo_supervisor+0x33f/0xef0 security/tomoyo/common.c:2095
> >   tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
> >   tomoyo_env_perm+0x18e/0x210 security/tomoyo/environ.c:63
> >   tomoyo_environ security/tomoyo/domain.c:670 [inline]
> >   tomoyo_find_next_domain+0x1354/0x1f6c security/tomoyo/domain.c:876
> >   tomoyo_bprm_check_security security/tomoyo/tomoyo.c:107 [inline]
> >   tomoyo_bprm_check_security+0x124/0x1a0 security/tomoyo/tomoyo.c:97
> >   security_bprm_check+0x63/0xb0 security/security.c:784
> >   search_binary_handler+0x71/0x570 fs/exec.c:1645
> >   exec_binprm fs/exec.c:1701 [inline]
> >   __do_execve_file.isra.0+0x1329/0x22b0 fs/exec.c:1821
> >   do_execveat_common fs/exec.c:1867 [inline]
> >   do_execve fs/exec.c:1884 [inline]
> >   __do_sys_execve fs/exec.c:1960 [inline]
> >   __se_sys_execve fs/exec.c:1955 [inline]
> >   __x64_sys_execve+0x8f/0xc0 fs/exec.c:1955
> >   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > The buggy address belongs to the object at ffff888094b0a000
> >   which belongs to the cache kmalloc-4k of size 4096
> > The buggy address is located 2576 bytes inside of
> >   4096-byte region [ffff888094b0a000, ffff888094b0b000)
> > The buggy address belongs to the page:
> > page:ffffea000252c280 refcount:1 mapcount:0 mapping:ffff8880aa402000
> > index:0x0 compound_mapcount: 0
> > raw: 00fffe0000010200 ffffea0002a3ae08 ffffea0002a6aa88 ffff8880aa402000
> > raw: 0000000000000000 ffff888094b0a000 0000000100000001 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >   ffff888094b0a900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >   ffff888094b0a980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > ffff888094b0aa00: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >                           ^
> >   ffff888094b0aa80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >   ffff888094b0ab00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ==================================================================
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
