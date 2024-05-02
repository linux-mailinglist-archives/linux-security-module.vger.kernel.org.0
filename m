Return-Path: <linux-security-module+bounces-2877-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4398B9DAA
	for <lists+linux-security-module@lfdr.de>; Thu,  2 May 2024 17:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E851C2308E
	for <lists+linux-security-module@lfdr.de>; Thu,  2 May 2024 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D6E15B566;
	Thu,  2 May 2024 15:42:29 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E5A15B551
	for <linux-security-module@vger.kernel.org>; Thu,  2 May 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664549; cv=none; b=AYNOJs8TrvjtUhtQhupHjqLP6ilq3JLY2autLXkumffKfOkBV0y9gEokLk75m8YKY3P21qpPDSWWMKDtnZHOrXr/xU9nnPtObxio2uTJHHzsam3mBO3W4HdxC8IMkcQJqPrQ4ubrS2ZkKtTfTj90skulV2KH87KcIqsYhKLGdtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664549; c=relaxed/simple;
	bh=SlEz3XjKzROMvi3l4BzF2CGRUkGfSg3FEbjb94Ym+lI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rwkJmlVd8dcNh9cD0MRCizkIeYzuFbdHQR1uvFoEyTUM7RCu4FJKN3VXtKer2HiaNcIJhvXQo1rgipzAJ/e/u5SVxwKYC8qoTKIl+w9sRBqbRU6l523VIFNVM7iVev7FX+p+zr3IVf4AqNyNOqC5L+1oiNk/eGxprfmhYFbdI8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ddf08e17e4so159422439f.0
        for <linux-security-module@vger.kernel.org>; Thu, 02 May 2024 08:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714664547; x=1715269347;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5fUISXd7Zqy3cTRarK7NciYHklQ9WyhHFcj68u208k=;
        b=Hn7AtocmqqAoq0SwVcxHWspZMMYdyztBfzurwugpeHUTox8NMl+MkMKKfSRTsWoz+v
         LOOESO3AMj7k0vUouopTpAnH+rkyMP2XxK67Z3GN3yjEXT/eWSnlRbIfalx5ZShKfqZc
         Ii1XGCto19lm0Feph/YmaVatho/6DB0XCuTdsLEH5WKKaUDZsOOAeVDEpljn7cR/WeKo
         qQA+9NLZEEInCejfnpjRdcaiBTIOObo4asrzl0BFVqKrkio8m5QkSMyP/eSfUu7TBlZL
         0YnlCeDF4qWNmtVW9BhnsLl9JhYvYpGsXXJibn4KcI09GyBG+ZqIGJXuhgOeXE1yrJ5E
         /GYg==
X-Forwarded-Encrypted: i=1; AJvYcCWEqm1DMqP+G4MRJlt+jY4SRHl+/SbEMEc1rlZ7w+F43dLedytPKBfXx6d1zwKDynYMvlzE7hi/W7/VXo73Riok87in3SQ1ner81DtWW18qCWX0upMw
X-Gm-Message-State: AOJu0Yzopc2ZJWuQaM4P62qsC4zELNvAMexprVAizfAo9XHob6A6RNY1
	g20YVO5gCHzxaiMuvXCeDaPjbzTL2XfTvyRpA6xUxusAD+p5MZQj1MVm47O42kniSbdDBnZAK6e
	pgU11/WPHAq9wz0tfUYKC9sN1qtSdpqSDeC28vzNV50dLBSQW5Rj1h04=
X-Google-Smtp-Source: AGHT+IFiLWfYFFqZNjO3yvW/yptU+aEV0DV+7Fo0Fd/GyVoYQsmRkFC21NAjZc08BDjIS5BrNHKedxRcxvNorw6bmPb0Ht380lvN
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:830c:b0:484:802a:a787 with SMTP id
 io12-20020a056638830c00b00484802aa787mr129624jab.3.1714664546853; Thu, 02 May
 2024 08:42:26 -0700 (PDT)
Date: Thu, 02 May 2024 08:42:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039727706177a7395@google.com>
Subject: [syzbot] [keyrings?] [lsm?] possible deadlock in keyring_clear
From: syzbot <syzbot+7e7ae1ea0744f1adce1a@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c8159388952 Merge tag 'rust-fixes-6.9' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1682a8a7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d46aa9d7a44f40d
dashboard link: https://syzkaller.appspot.com/bug?extid=7e7ae1ea0744f1adce1a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4173768ac07/disk-2c815938.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/060f21ef407d/vmlinux-2c815938.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a38eae39bb35/bzImage-2c815938.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e7ae1ea0744f1adce1a@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00355-g2c8159388952 #0 Not tainted
------------------------------------------------------
kswapd0/87 is trying to acquire lock:
ffff88802cd46e98 (&type->lock_class){+.+.}-{3:3}, at: keyring_clear+0xb2/0x350 security/keys/keyring.c:1655

but task is already holding lock:
ffffffff8e428cc0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6782 [inline]
ffffffff8e428cc0 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb20/0x30c0 mm/vmscan.c:7164

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       slab_pre_alloc_hook mm/slub.c:3746 [inline]
       slab_alloc_node mm/slub.c:3827 [inline]
       kmalloc_trace+0x47/0x360 mm/slub.c:3992
       kmalloc include/linux/slab.h:628 [inline]
       kzalloc include/linux/slab.h:749 [inline]
       assoc_array_insert+0xfe/0x3390 lib/assoc_array.c:980
       __key_link_begin+0xe5/0x1f0 security/keys/keyring.c:1314
       __key_create_or_update+0x570/0xc70 security/keys/key.c:861
       key_create_or_update+0x42/0x60 security/keys/key.c:1005
       x509_load_certificate_list+0x149/0x270 crypto/asymmetric_keys/x509_loader.c:31
       do_one_initcall+0x248/0x880 init/main.c:1245
       do_initcall_level+0x157/0x210 init/main.c:1307
       do_initcalls+0x3f/0x80 init/main.c:1323
       kernel_init_freeable+0x435/0x5d0 init/main.c:1555
       kernel_init+0x1d/0x2b0 init/main.c:1444
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&type->lock_class){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       keyring_clear+0xb2/0x350 security/keys/keyring.c:1655
       fscrypt_put_master_key+0xc8/0x180 fs/crypto/keyring.c:79
       put_crypt_info+0x275/0x320 fs/crypto/keysetup.c:548
       fscrypt_put_encryption_info+0x40/0x60 fs/crypto/keysetup.c:753
       ext4_clear_inode+0x15b/0x1c0 fs/ext4/super.c:1536
       ext4_evict_inode+0xabc/0xf50 fs/ext4/inode.c:318
       evict+0x2a8/0x630 fs/inode.c:667
       __dentry_kill+0x20d/0x630 fs/dcache.c:603
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
       shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
       prune_dcache_sb+0x10f/0x180 fs/dcache.c:1156
       super_cache_scan+0x34f/0x4b0 fs/super.c:221
       do_shrink_slab+0x705/0x1160 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0x883/0x14d0 mm/shrinker.c:626
       shrink_node_memcgs mm/vmscan.c:5875 [inline]
       shrink_node+0x11f5/0x2d60 mm/vmscan.c:5908
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat mm/vmscan.c:6895 [inline]
       kswapd+0x1a25/0x30c0 mm/vmscan.c:7164
       kthread+0x2f0/0x390 kernel/kthread.c:388
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&type->lock_class);
                               lock(fs_reclaim);
  lock(&type->lock_class);

 *** DEADLOCK ***

2 locks held by kswapd0/87:
 #0: ffffffff8e428cc0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6782 [inline]
 #0: ffffffff8e428cc0 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb20/0x30c0 mm/vmscan.c:7164
 #1: ffff88818bb7e0e0 (&type->s_umount_key#31){++++}-{3:3}, at: super_trylock_shared fs/super.c:561 [inline]
 #1: ffff88818bb7e0e0 (&type->s_umount_key#31){++++}-{3:3}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196

stack backtrace:
CPU: 0 PID: 87 Comm: kswapd0 Not tainted 6.9.0-rc5-syzkaller-00355-g2c8159388952 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
 keyring_clear+0xb2/0x350 security/keys/keyring.c:1655
 fscrypt_put_master_key+0xc8/0x180 fs/crypto/keyring.c:79
 put_crypt_info+0x275/0x320 fs/crypto/keysetup.c:548
 fscrypt_put_encryption_info+0x40/0x60 fs/crypto/keysetup.c:753
 ext4_clear_inode+0x15b/0x1c0 fs/ext4/super.c:1536
 ext4_evict_inode+0xabc/0xf50 fs/ext4/inode.c:318
 evict+0x2a8/0x630 fs/inode.c:667
 __dentry_kill+0x20d/0x630 fs/dcache.c:603
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
 prune_dcache_sb+0x10f/0x180 fs/dcache.c:1156
 super_cache_scan+0x34f/0x4b0 fs/super.c:221
 do_shrink_slab+0x705/0x1160 mm/shrinker.c:435
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0x883/0x14d0 mm/shrinker.c:626
 shrink_node_memcgs mm/vmscan.c:5875 [inline]
 shrink_node+0x11f5/0x2d60 mm/vmscan.c:5908
 kswapd_shrink_node mm/vmscan.c:6704 [inline]
 balance_pgdat mm/vmscan.c:6895 [inline]
 kswapd+0x1a25/0x30c0 mm/vmscan.c:7164
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

