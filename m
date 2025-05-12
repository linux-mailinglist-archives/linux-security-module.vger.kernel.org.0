Return-Path: <linux-security-module+bounces-9826-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F1AB2FAC
	for <lists+linux-security-module@lfdr.de>; Mon, 12 May 2025 08:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793A8189A594
	for <lists+linux-security-module@lfdr.de>; Mon, 12 May 2025 06:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95372255F23;
	Mon, 12 May 2025 06:34:23 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1A24A07B
	for <linux-security-module@vger.kernel.org>; Mon, 12 May 2025 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747031663; cv=none; b=cbrtLQkdjn2QyPXzyur79qILtECc8kCc+e4tq84Yygz3TPN12N1WKzXzjzqu4QvQAyk49rJ4s9SWcOZ2DkxBkr3sbf4B2YXoi3Ap8NdOGv7IK+FvpaJYm9gQkWFrr5d9Aa3i7qRHhKZ6uCUEIcbAh+YHam4eEKUYoPgTpS5siXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747031663; c=relaxed/simple;
	bh=gpNdlN3Cb0qhrWVkl2uMw2MfCUiMelfl829BiTyR+Ys=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GfPW4AB43BMo7hG9ccqN5CIJAZVM///RR/HmXVrrlPuP3cRp4OmN5HnVzwht/8k7PZ5mGp6xPG353mWuO/OyNNzZ1UvKHkIxZ1uuoml9n8gkk4elaJ9CW8KvX/Lg2f3coF7TuZwGKfAn/K9bmZVYpva0zC+p9a08xKs87iIXq5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86176e300fdso364362939f.1
        for <linux-security-module@vger.kernel.org>; Sun, 11 May 2025 23:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747031661; x=1747636461;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bk73waboJRsstF4X6ogODT970jaH6YsHHYw5z1KWGVg=;
        b=mej/GBfUbP3vSvYWf+pNT8SWKY74FcNcGuntfBJBj/1B0qC/G5GplpTmj7DSoBoIbG
         C4dT6UJgDkJbIFSR3K1WPSyDeIC2SfElqrXsKmiHBSJxOb7joitXiTJESudXQtf+mZxY
         cmb2xCbLVerXpLCZx7qiPvfwp16QbFb0h1WvE+GPBgABUNoGGnVKD3o2ucw4MrqXL/fm
         s1bnYmXg5700Sxxx5jtXfTt/sChmUEN77+AV1Q45BOp6fpod5oAfS7tjIRstDMi9BFhv
         3P/tDZQCNFKPckB+jSJMqF2bzUYVNTHWllT7agmRlTV9RdmTiRZL3VreABJ9PrecfsVN
         HzpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMUXkksDGTF+W6LdyvRaoIVJbflArO9VxbWxy685RAiFrCb6ivqvy8LzVhv0KgB9tFMFKrua9wGknYcP86R43s0ADWhpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytVerDl4Wj8Mer/3jkn+SsayfnyHSLjB/EXGpvK91kFoSLIJJs
	Le3KdmXIe/uRNWC6hJ8tkPa6G7R3zc1BbHbhAkpFMAUutQFiFbWxEwJVtKNGmKwpZcQ3BBF9wVh
	A4GRzb2ciLEhIT8SPUoPYsZHFIHvgTMyK3pYTH9JPuubUvsI5bXEgr54=
X-Google-Smtp-Source: AGHT+IHnDX7gvaVDvWhoZmEs2BZOqUYzRCiyjD940H3qvyh4OlFngYAmesq+Gs/DUKA3V3EGe+m3fckqy4A24G+r2866OWsULKtg
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640f:b0:861:c759:61fa with SMTP id
 ca18e2360f4ac-8676356c200mr1535456539f.4.1747031660879; Sun, 11 May 2025
 23:34:20 -0700 (PDT)
Date: Sun, 11 May 2025 23:34:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6821966c.050a0220.f2294.0050.GAE@google.com>
Subject: [syzbot] [lsm?] [keyrings?] KCSAN: data-race in key_garbage_collector
 / key_set_expiry
From: syzbot <syzbot+9defcbc1dc2f34e5b867@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cd802e7e5f1e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1583b768580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6154604431d9aaf9
dashboard link: https://syzkaller.appspot.com/bug?extid=9defcbc1dc2f34e5b867
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fdb14cb5e78f/disk-cd802e7e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c8b91b8b365f/vmlinux-cd802e7e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69520a7040dd/bzImage-cd802e7e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9defcbc1dc2f34e5b867@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in key_garbage_collector / key_set_expiry

write to 0xffffffff869eb168 of 8 bytes by task 3395 on cpu 1:
 key_schedule_gc security/keys/gc.c:63 [inline]
 key_garbage_collector+0x6d6/0x8f0 security/keys/gc.c:286
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0x4cb/0x9d0 kernel/workqueue.c:3319
 worker_thread+0x582/0x770 kernel/workqueue.c:3400
 kthread+0x486/0x510 kernel/kthread.c:464
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

read to 0xffffffff869eb168 of 8 bytes by task 4277 on cpu 0:
 key_schedule_gc security/keys/gc.c:61 [inline]
 key_set_expiry+0xea/0x190 security/keys/gc.c:78
 key_reject_and_link+0x18b/0x310 security/keys/key.c:609
 key_negate_and_link include/linux/key-type.h:188 [inline]
 complete_request_key security/keys/request_key.c:67 [inline]
 call_sbin_request_key+0x656/0x6b0 security/keys/request_key.c:216
 construct_key security/keys/request_key.c:247 [inline]
 construct_key_and_link security/keys/request_key.c:519 [inline]
 request_key_and_link+0x8bc/0xd70 security/keys/request_key.c:653
 __do_sys_request_key security/keys/keyctl.c:222 [inline]
 __se_sys_request_key+0x1df/0x290 security/keys/keyctl.c:167
 __x64_sys_request_key+0x55/0x70 security/keys/keyctl.c:167
 x64_sys_call+0x2f19/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:250
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd0/0x1a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x7fffffffffffffff -> 0x000000006821354a

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 4277 Comm: syz.0.242 Not tainted 6.15.0-rc5-syzkaller-00353-gcd802e7e5f1e #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
==================================================================
iwpm_register_pid: Unable to send a nlmsg (client = 2)
infiniband syz1: RDMA CMA: cma_listen_on_dev, error -98


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

