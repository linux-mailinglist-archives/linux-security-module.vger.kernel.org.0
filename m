Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9C220770
	for <lists+linux-security-module@lfdr.de>; Thu, 16 May 2019 14:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfEPM6L (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 16 May 2019 08:58:11 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:36787 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfEPM6H (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 May 2019 08:58:07 -0400
Received: by mail-it1-f199.google.com with SMTP id u131so3216883itc.1
        for <linux-security-module@vger.kernel.org>; Thu, 16 May 2019 05:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QrnszPDU3yxNLe2DVRQI/pEmO3ZdX0JPjpwSh5YyPIE=;
        b=D+VvGKOUtqTClpSAGkW+ObTI5rNPTmCJE+PDx/hcg2QO0C18wobMU6neV1PoKDRD7R
         H05pfZcUQafIGkuIFXb7hDLK1P2aydBP6Lb63rQBOiTQ7EkCF5ZMCnc/rL/rBkCujRXW
         ka1/ppW00AvzzvJnC5UNKD5RgRQiWwVqueX2GW+h1tLBcxt55XPURQ7PQJF/VbNBHNTc
         MdGTbLTcJgM3D5FGLhybCOGHvLdhIn06YEKmRklPxNx/h0pvDPBMk6I6oIvEqeNtW/JD
         lo2YTUApS6EnV6cakjyt/XQoOjqkk7mM9aTNm+zAONDi/1xihOBoNrhLrkkmKQSoblDO
         EN8Q==
X-Gm-Message-State: APjAAAWK0uE+LRui578HfzI4RIRWlExpy9fLLTvSRWkjOJYP38o0/iNm
        Gq45iDaXqDhIIkvLVcP49wAI0p61pNS2UF2Be6oY8opAlhx/
X-Google-Smtp-Source: APXvYqwojGgc+W/W/JhFKzKop4P4kpB0lNtV5LPoj4eV3Hu55LHgcbrblzklvEH7U3R949VAgYzz9B06uPE71r3VqHbW1rzg4AUA
MIME-Version: 1.0
X-Received: by 2002:a24:8c:: with SMTP id 134mr12523083ita.24.1558011486534;
 Thu, 16 May 2019 05:58:06 -0700 (PDT)
Date:   Thu, 16 May 2019 05:58:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000360994058900d17f@google.com>
Subject: KMSAN: uninit-value in tomoyo_check_unix_address
From:   syzbot <syzbot+e9687dbb0b6b2057d0ed@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15014d44a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=602468164ccdc30a
dashboard link: https://syzkaller.appspot.com/bug?extid=e9687dbb0b6b2057d0ed
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
06d00afa61eef8f7f501ebdb4e8612ea43ec2d78)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e9687dbb0b6b2057d0ed@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in tomoyo_check_unix_address+0x36a/0xa30  
security/tomoyo/network.c:597
CPU: 1 PID: 30810 Comm: syz-executor.4 Not tainted 5.1.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x130/0x2a0 mm/kmsan/kmsan.c:619
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:310
  tomoyo_check_unix_address+0x36a/0xa30 security/tomoyo/network.c:597
  tomoyo_socket_connect_permission+0x315/0x400 security/tomoyo/network.c:705
  tomoyo_socket_connect+0x8b/0xa0 security/tomoyo/tomoyo.c:456
  security_socket_connect+0x127/0x200 security/security.c:1948
  __sys_connect+0x536/0x820 net/socket.c:1804
  __do_sys_connect net/socket.c:1819 [inline]
  __se_sys_connect+0x8d/0xb0 net/socket.c:1816
  __x64_sys_connect+0x4a/0x70 net/socket.c:1816
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x458da9
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f825eeb8c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458da9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f825eeb96d4
R13: 00000000004bf2cf R14: 00000000004d0660 R15: 00000000ffffffff

Local variable description: ----address@__sys_connect
Variable was created at:
  sockfd_lookup_light net/socket.c:488 [inline]
  __sys_connect+0x8c/0x820 net/socket.c:1796
  __do_sys_connect net/socket.c:1819 [inline]
  __se_sys_connect+0x8d/0xb0 net/socket.c:1816
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
