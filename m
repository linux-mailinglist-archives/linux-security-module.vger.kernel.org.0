Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3387B36372
	for <lists+linux-security-module@lfdr.de>; Wed,  5 Jun 2019 20:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFESmI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 5 Jun 2019 14:42:08 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:56864 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFESmH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jun 2019 14:42:07 -0400
Received: by mail-it1-f199.google.com with SMTP id l124so2502674itg.6
        for <linux-security-module@vger.kernel.org>; Wed, 05 Jun 2019 11:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jdwl+UwFCZV2OrnAKGCMsl5ycS2kpI7HLqbSCRD7//o=;
        b=Dh1+SaTJI+Qcyd1OZ2KU3J/yj5vd4ZKGi+s2C0qBzPC2fAUWudUsvFy9g0R9fu427N
         VAziMK5Ys3gcXIaB8u2gRlfUReYfpl7OcmYfjDAboF3I295oCXH/fxmrOey/zGDtOSl1
         s/LGM9msz5YD0D9UPq/32OyPWAKL4jpSFpNXDetOrJ7TWJwAdL9XecGpPWEwjyot4oAl
         xQ/SEVdoM3nofodKlisZx+T92wwslNGfVZAcX+2WTdNuzmXjdlEqx5ykDKVcT2OMKNHw
         D7c/PDfpETJQ1FZ70+tj2r49XjJmt7/pVY62vEmPZBkG6dFAJeYBxoS2JkPNZZWIqdO3
         wI3g==
X-Gm-Message-State: APjAAAUaESR53qfrq42CPVSGMYqYxKCDLJc4Q5Wfbmlbreju1CggDfqS
        FH4Ay2CHbKmj5T5Gv3mJhxhH48FFyr7/bUUip6onZjxdkK23
X-Google-Smtp-Source: APXvYqwOwJUx+g1ciJ7X80xWHVAOptDe5KxCc67c+kFgrFYrJOby5FgtNLwe2Iko5aZQ6A4LpbfuUQlY2xele8gJDrNeYd4aNghN
MIME-Version: 1.0
X-Received: by 2002:a02:c80d:: with SMTP id p13mr1552204jao.59.1559760127080;
 Wed, 05 Jun 2019 11:42:07 -0700 (PDT)
Date:   Wed, 05 Jun 2019 11:42:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f43fa058a97f4d3@google.com>
Subject: KASAN: use-after-free Read in tomoyo_realpath_from_path
From:   syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    788a0249 Merge tag 'arc-5.2-rc4' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179848d4a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60564cb52ab29d5b
dashboard link: https://syzkaller.appspot.com/bug?extid=0341f6a4d729d4e0acf1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ac35baa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in tomoyo_get_socket_name  
security/tomoyo/realpath.c:238 [inline]
BUG: KASAN: use-after-free in tomoyo_realpath_from_path+0x722/0x7a0  
security/tomoyo/realpath.c:284
Read of size 2 at addr ffff8880a91276d0 by task syz-executor.3/17397

CPU: 0 PID: 17397 Comm: syz-executor.3 Not tainted 5.2.0-rc3+ #12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:188
  __kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  kasan_report+0x12/0x20 mm/kasan/common.c:614
  __asan_report_load2_noabort+0x14/0x20 mm/kasan/generic_report.c:130
  tomoyo_get_socket_name security/tomoyo/realpath.c:238 [inline]
  tomoyo_realpath_from_path+0x722/0x7a0 security/tomoyo/realpath.c:284
  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
  tomoyo_check_open_permission+0x2a8/0x3f0 security/tomoyo/file.c:771
  tomoyo_file_open security/tomoyo/tomoyo.c:319 [inline]
  tomoyo_file_open+0xa9/0xd0 security/tomoyo/tomoyo.c:314
  security_file_open+0x71/0x300 security/security.c:1454
  do_dentry_open+0x373/0x1250 fs/open.c:765
  vfs_open+0xa0/0xd0 fs/open.c:887
  do_last fs/namei.c:3416 [inline]
  path_openat+0x10e9/0x46d0 fs/namei.c:3533
  do_filp_open+0x1a1/0x280 fs/namei.c:3563
  do_sys_open+0x3fe/0x5d0 fs/open.c:1070
  __do_sys_open fs/open.c:1088 [inline]
  __se_sys_open fs/open.c:1083 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1083
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x413161
Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48  
83 ec 08 e8 0a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f65230f8bb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000000000413161
RDX: fffffffffffffffa RSI: 0000000000000000 RDI: 00007f65230f8bd0
RBP: 000000000075c060 R08: 0000000000000050 R09: 000000000000000f
R10: 0000000000000004 R11: 0000000000000293 R12: 00007f65230f96d4
R13: 00000000004c83f6 R14: 00000000004dea40 R15: 00000000ffffffff

Allocated by task 17373:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:489 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:462
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:503
  __do_kmalloc mm/slab.c:3660 [inline]
  __kmalloc+0x15c/0x740 mm/slab.c:3669
  kmalloc include/linux/slab.h:552 [inline]
  sk_prot_alloc+0x19c/0x2e0 net/core/sock.c:1602
  sk_alloc+0x39/0xf70 net/core/sock.c:1656
  base_sock_create drivers/isdn/mISDN/socket.c:758 [inline]
  mISDN_sock_create+0xb4/0x3a0 drivers/isdn/mISDN/socket.c:780
  __sock_create+0x3d8/0x730 net/socket.c:1424
  sock_create net/socket.c:1475 [inline]
  __sys_socket+0x103/0x220 net/socket.c:1517
  __do_sys_socket net/socket.c:1526 [inline]
  __se_sys_socket net/socket.c:1524 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1524
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 17371:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:451
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:459
  __cache_free mm/slab.c:3432 [inline]
  kfree+0xcf/0x220 mm/slab.c:3755
  sk_prot_free net/core/sock.c:1639 [inline]
  __sk_destruct+0x4f7/0x6e0 net/core/sock.c:1725
  sk_destruct+0x7b/0x90 net/core/sock.c:1733
  __sk_free+0xce/0x300 net/core/sock.c:1744
  sk_free+0x42/0x50 net/core/sock.c:1755
  sock_put include/net/sock.h:1723 [inline]
  base_sock_release+0x269/0x279 drivers/isdn/mISDN/socket.c:628
  __sock_release+0xce/0x2a0 net/socket.c:601
  sock_close+0x1b/0x30 net/socket.c:1273
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:185 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:168
  prepare_exit_to_usermode arch/x86/entry/common.c:199 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
  do_syscall_64+0x58e/0x680 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a91276c0
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 16 bytes inside of
  2048-byte region [ffff8880a91276c0, ffff8880a9127ec0)
The buggy address belongs to the page:
page:ffffea0002a44980 refcount:1 mapcount:0 mapping:ffff8880aa400c40  
index:0x0 compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00022c9f88 ffffea0002234408 ffff8880aa400c40
raw: 0000000000000000 ffff8880a91265c0 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a9127580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a9127600: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8880a9127680: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                  ^
  ffff8880a9127700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a9127780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
