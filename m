Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D81FF98F5
	for <lists+linux-security-module@lfdr.de>; Tue, 12 Nov 2019 19:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKLSkO (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 12 Nov 2019 13:40:14 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:55152 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKLSkN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Nov 2019 13:40:13 -0500
Received: by mail-il1-f199.google.com with SMTP id t67so20694924ill.21
        for <linux-security-module@vger.kernel.org>; Tue, 12 Nov 2019 10:40:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=71kVpgTR6WVhVliHWkFE/QB/m1atQ1vryoeja6RcvFc=;
        b=Ly69eYhS70rcDIMEEJHyKTebtj7AKcLL6kWLiPvuTz+s1rb639aIrOTksQdaniCWe1
         xOzJIx3Yf0weg9qsDxwUPpV6UQ7LDwTRadA+sWecbGlhElqFmayMkZGrR3SUaeof78oP
         MiChH1tPNsntZQ0VD0ATtyItkeZL2dGhgww+l3ERgrjG6dAIrsqJAJPJWwQUTmnaakrJ
         ERWj68xKZXE7Qcsnl4se7LSVPxkq2+xVMLbl2UOE+B6eimKFYRbzw98EQM+uvsz3rzoz
         xukmSFGWMlFg8Tp/XtNiRgBAIDMRP+le8/+OwhraF3ZpeRY84kVQb8CiPQ49rxJoMuZI
         jq/w==
X-Gm-Message-State: APjAAAWpYtf61ZPZvvfShD4+SWCLLHAvYr0TOQGR7ETctvwPDGzh5laZ
        WPy4L5udmX0fyjjgB0ZVOKSSUFluktHl4GhKj3TjS/xLsTRY
X-Google-Smtp-Source: APXvYqy/gJew53dJxbhfA6YHD2edNQn0csOfsR6FbmRM3+R8fDllklCqbjxJ6M9wWyhhmi9UI+RKuSxXFqwZ04g9S0nRlWPP55uQ
MIME-Version: 1.0
X-Received: by 2002:a6b:b987:: with SMTP id j129mr32077476iof.105.1573584011279;
 Tue, 12 Nov 2019 10:40:11 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:40:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004471505972a9432@google.com>
Subject: WARNING in aa_sock_msg_perm (2)
From:   syzbot <syzbot+e3b328542d4adc02a975@syzkaller.appspotmail.com>
To:     jmorris@namei.org, john.johansen@canonical.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    31f4f5b4 Linux 5.4-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12887074e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83de638b2a862933
dashboard link: https://syzkaller.appspot.com/bug?extid=e3b328542d4adc02a975
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e3b328542d4adc02a975@syzkaller.appspotmail.com

------------[ cut here ]------------
AppArmor WARN aa_sock_msg_perm: ((!sock)):
WARNING: CPU: 0 PID: 12781 at security/apparmor/lsm.c:920  
aa_sock_msg_perm.isra.0+0xdd/0x170 security/apparmor/lsm.c:920
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12781 Comm: kworker/0:1 Not tainted 5.4.0-rc7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: krxrpcd rxrpc_peer_keepalive_worker
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x35 kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:aa_sock_msg_perm.isra.0+0xdd/0x170 security/apparmor/lsm.c:920
Code: 89 ef e8 26 e4 02 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 16 3a 60 fe  
48 c7 c6 e0 39 e1 87 48 c7 c7 e0 24 e1 87 e8 4b 6c 31 fe <0f> 0b e9 43 ff  
ff ff e8 f7 39 60 fe 48 c7 c6 e0 39 e1 87 48 c7 c7
RSP: 0018:ffff88809c3d79b0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815cc846 RDI: ffffed101387af28
RBP: ffff88809c3d79d8 R08: ffff88805b02c600 R09: fffffbfff14efd54
R10: fffffbfff14efd53 R11: ffffffff8a77ea9f R12: ffff88809c3d7b20
R13: ffffffff87e12920 R14: 0000000000000002 R15: 000000000000001d
  apparmor_socket_sendmsg+0x2a/0x30 security/apparmor/lsm.c:936
  security_socket_sendmsg+0x77/0xc0 security/security.c:2013
  sock_sendmsg+0x45/0x130 net/socket.c:654
  kernel_sendmsg+0x44/0x50 net/socket.c:677
  rxrpc_send_keepalive+0x1ff/0x940 net/rxrpc/output.c:655
  rxrpc_peer_keepalive_dispatch net/rxrpc/peer_event.c:376 [inline]
  rxrpc_peer_keepalive_worker+0x7be/0xd02 net/rxrpc/peer_event.c:437
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
