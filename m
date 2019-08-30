Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25357A3E8D
	for <lists+linux-security-module@lfdr.de>; Fri, 30 Aug 2019 21:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfH3TkI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 30 Aug 2019 15:40:08 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:46451 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbfH3TkI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Aug 2019 15:40:08 -0400
Received: by mail-io1-f71.google.com with SMTP id e17so9736471ioh.13
        for <linux-security-module@vger.kernel.org>; Fri, 30 Aug 2019 12:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LDURaq94pIzQxK22mYkgcKgSQclgsRJtddjOgIvUBiU=;
        b=d58td9CmGn8xYA4Ez5JoyVqOr/eGuYcnURG2Z/Z42asgNq+7dvSLZBNJB+OVW1Ezcb
         QCsjhzkj8304YzeTwKSJlDfTc9ZIGRZl5AZGJrOcLQSjNrEu98oWo04pikd9SeIOeC6m
         XyCeHeVHdxdGGzXvEjK/FdcPeO2vGyISxHHS20MQveEt0a5rm+jLDTDMCrmqviBrWza0
         Q65emENWed1xI/hmMxpUx7Y5QTR8ctDEYUmzhqcnWZnFjgRswyqSjXCvp55mHAymWjY2
         F8fo7RliKEgqHyn2Nak77oEOgjqr6+ajHF8pqZ3zDBlj+LFH9jAIHEWNLTFTBvqdBBAF
         9VuA==
X-Gm-Message-State: APjAAAVHkgk74QM7/NPQvcPoqyYMHe84AO+thUmniytGJgyuo/EsHy5K
        9bQIsiR6H6jZ6HSYQQ2emxCiENG69VDJmGkPM5RtQNrW4lPw
X-Google-Smtp-Source: APXvYqwQBhVQ4p9xmtE+5ZuFOt/A/n9KlsYNZYRM1fRWGlnrU8ZEvVVe+aHHk3wo8k8L9toxirSnqJPOaa198A4NzQwHofsKt7ar
MIME-Version: 1.0
X-Received: by 2002:a5e:c914:: with SMTP id z20mr19531323iol.272.1567194007240;
 Fri, 30 Aug 2019 12:40:07 -0700 (PDT)
Date:   Fri, 30 Aug 2019 12:40:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018875105915aca1d@google.com>
Subject: general protection fault in smack_socket_sendmsg
From:   syzbot <syzbot+5fd781d646d4fcbdfeb0@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    6525771f Merge tag 'arc-5.3-rc7' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11486cea600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58485246ad14eafe
dashboard link: https://syzkaller.appspot.com/bug?extid=5fd781d646d4fcbdfeb0
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5fd781d646d4fcbdfeb0@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 11983 Comm: kworker/0:0 Not tainted 5.3.0-rc6+ #94
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: krxrpcd rxrpc_peer_keepalive_worker
RIP: 0010:smack_socket_sendmsg+0x5b/0x480 security/smack/smack_lsm.c:3677
Code: e8 6a 07 71 fe 4c 89 e8 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 ef e8  
b4 ff a9 fe 4d 8b 65 00 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00  
74 08 48 89 df e8 96 ff a9 fe 4c 8b 33 49 8d 9e 08
RSP: 0018:ffff8881daa1f9c8 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff888048882500
RDX: 0000000000000000 RSI: ffff8881daa1fb18 RDI: 0000000000000000
RBP: ffff8881daa1fa80 R08: ffffffff8350cc90 R09: ffff8881daa1fb86
R10: ffffed103b543f72 R11: 0000000000000000 R12: ffff88803704c594
R13: ffff8881daa1fb18 R14: dffffc0000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7d4f2b5028 CR3: 000000005e835000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  security_socket_sendmsg+0x6c/0xd0 security/security.c:1973
  sock_sendmsg net/socket.c:654 [inline]
  kernel_sendmsg+0x77/0x140 net/socket.c:677
  rxrpc_send_keepalive+0x254/0x3c0 net/rxrpc/output.c:655
  rxrpc_peer_keepalive_dispatch net/rxrpc/peer_event.c:369 [inline]
  rxrpc_peer_keepalive_worker+0x76e/0xb40 net/rxrpc/peer_event.c:430
  process_one_work+0x7ef/0x10e0 kernel/workqueue.c:2269
  worker_thread+0xc01/0x1630 kernel/workqueue.c:2415
  kthread+0x332/0x350 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 61235a384085b26a ]---
RIP: 0010:smack_socket_sendmsg+0x5b/0x480 security/smack/smack_lsm.c:3677
Code: e8 6a 07 71 fe 4c 89 e8 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 ef e8  
b4 ff a9 fe 4d 8b 65 00 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00  
74 08 48 89 df e8 96 ff a9 fe 4c 8b 33 49 8d 9e 08
RSP: 0018:ffff8881daa1f9c8 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff888048882500
RDX: 0000000000000000 RSI: ffff8881daa1fb18 RDI: 0000000000000000
RBP: ffff8881daa1fa80 R08: ffffffff8350cc90 R09: ffff8881daa1fb86
R10: ffffed103b543f72 R11: 0000000000000000 R12: ffff88803704c594
R13: ffff8881daa1fb18 R14: dffffc0000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000960004 CR3: 0000000022fd0000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
