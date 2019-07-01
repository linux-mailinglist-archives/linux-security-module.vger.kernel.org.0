Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD262076E
	for <lists+linux-security-module@lfdr.de>; Thu, 16 May 2019 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfEPM6H (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 16 May 2019 08:58:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:38943 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfEPM6G (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 May 2019 08:58:06 -0400
Received: by mail-io1-f72.google.com with SMTP id l19so2596285iob.6
        for <linux-security-module@vger.kernel.org>; Thu, 16 May 2019 05:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MdrEULgmHdt5/2TFOXFQeQY/puqA7jR5xNjMz6LOyvk=;
        b=AE+fLC6KeGczhTTbW1rCCjOu3GmUpX3bujFhEfvj6NXp92VYBwR/vu2oRC95Wn92mA
         54HhqzKRF+HwtGVwCAVwe7n7MG6cPS61a6sABWVqNde2e1OZ2LKoUWYWvowhxj4ISdLu
         9FcrhkI2ksjWLV5bypupLKx376zPDDn2qlXaNLV1MJX1hDIyMKvKXF6GuY29PotwIhRM
         zT/S0rdNKLvQ8NdD1W51VSnaZLZD+S08jwIuHVYz1rHWodrBd+OPhttsa7weQPwH/M7k
         Lkzx0bmsFzN5l1od2xHEjtx8iEsGw23v/Y6GNQOqmrFTz3r7V7ZeC63+YIjoddLnxcKm
         DYRw==
X-Gm-Message-State: APjAAAWxwE4s9tpzUHPSWdfmUhIuA37biTTqUkZBjS7/CHl+wzsdPS2u
        kUpI03D2H1mkxigMUn3PKz8GsDUAANIq8HeDyj75DI3IfmVi
X-Google-Smtp-Source: APXvYqyuRmTOlyRqyVEWDCNz961U9p5PW5aySiOaHjUpeWLFq4qIn/0BleEX42b7buxqyo2Ia438+NNTzHmv7voWHXJL4v9YrfTq
MIME-Version: 1.0
X-Received: by 2002:a05:6638:221:: with SMTP id f1mr30700825jaq.1.1558011486298;
 Thu, 16 May 2019 05:58:06 -0700 (PDT)
Date:   Thu, 16 May 2019 05:58:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032685a058900d170@google.com>
Subject: KMSAN: uninit-value in tomoyo_check_inet_address
From:   syzbot <syzbot+1018d578c410f9f37261@syzkaller.appspotmail.com>
To:     glider@google.com, jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    3b955a40 usb-fuzzer: main usb gadget fuzzer driver
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=1027e608a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=602468164ccdc30a
dashboard link: https://syzkaller.appspot.com/bug?extid=1018d578c410f9f37261
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
06d00afa61eef8f7f501ebdb4e8612ea43ec2d78)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1018d578c410f9f37261@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in tomoyo_check_inet_address+0x143/0xd10  
security/tomoyo/network.c:508
CPU: 0 PID: 22966 Comm: syz-executor.2 Not tainted 5.1.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x130/0x2a0 mm/kmsan/kmsan.c:619
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:310
  tomoyo_check_inet_address+0x143/0xd10 security/tomoyo/network.c:508
  tomoyo_socket_bind_permission+0x343/0x3b0 security/tomoyo/network.c:741
  tomoyo_socket_bind+0x8b/0xa0 security/tomoyo/tomoyo.c:471
  security_socket_bind+0x127/0x200 security/security.c:1943
  __sys_bind+0x536/0x7c0 net/socket.c:1623
  __do_sys_bind net/socket.c:1638 [inline]
  __se_sys_bind+0x8d/0xb0 net/socket.c:1636
  __x64_sys_bind+0x4a/0x70 net/socket.c:1636
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x458da9
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4aeb5bbc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458da9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4aeb5bc6d4
R13: 00000000004bee1f R14: 00000000004cfe68 R15: 00000000ffffffff

Local variable description: ----address@__sys_bind
Variable was created at:
  sockfd_lookup_light net/socket.c:488 [inline]
  __sys_bind+0x8c/0x7c0 net/socket.c:1619
  __do_sys_bind net/socket.c:1638 [inline]
  __se_sys_bind+0x8d/0xb0 net/socket.c:1636
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
