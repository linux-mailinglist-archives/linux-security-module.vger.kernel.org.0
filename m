Return-Path: <linux-security-module+bounces-3233-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE88C720E
	for <lists+linux-security-module@lfdr.de>; Thu, 16 May 2024 09:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662911F23099
	for <lists+linux-security-module@lfdr.de>; Thu, 16 May 2024 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF0C8C0;
	Thu, 16 May 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="B5JTPmYD"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1633FBA7
	for <linux-security-module@vger.kernel.org>; Thu, 16 May 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715844693; cv=none; b=fJ2ubtidZxLHmN1S9XBiuZpLkN3yAJDjvd0XxY0NdRToBObfUdSC2RCLtL42CqK6eabHQfMr9kCy2tcl4/04uZomJDBU0EdmEWL9DjMdBsxYC9MOnWzffA6220NFWq8yBdUxEQ4t/t8z1qWCy4Ud4vaNxPVhR+RoP2F7+XvWXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715844693; c=relaxed/simple;
	bh=9MX6D9IimpJEieWy+a37mRcw4wRyMKCNdxMccONZOQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhaDjJ4qW7GmwVW/YIKYmvBCIEUSPTF6DKEwXKjRsvhyD/8kk1m90/2wnpdCAoTm6eDu8DWWHiDM7wBVepBM+PDuS+mMNHWkUMwaPOlcGB0vhB+o2g8FH66i96X9BPbxv6T0q3u6uh8hahzQ865cxkeiy6EuoUFr5ue1YBhUvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=B5JTPmYD; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vg1x372gXzpYl;
	Thu, 16 May 2024 09:31:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715844679;
	bh=x9B4v71FSOB+lN5lTjfx2Ss5JuMCQaPevVVCYis5sJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5JTPmYDKDwqWT+JiXH4f2GatEcocJ1C8JDnJeJ9gqsn/yfFly9tcNzg2QJKG3DQ9
	 Gw7NsOMqiFucb2I5qBqnE6X9zG4CrXZBliDiSC6vNAUbYqYX6UJb9RRM+kSziJm8vS
	 RfP6PaTCVrAemYjkl4JoQlWctAe5AnSC2EFvED/0=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vg1x25SDhzXZs;
	Thu, 16 May 2024 09:31:18 +0200 (CEST)
Date: Thu, 16 May 2024 09:31:20 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, 
	jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [syzbot] [lsm?] general protection fault in
 hook_inode_free_security
Message-ID: <20240516.doyox6Iengou@digikod.net>
References: <00000000000076ba3b0617f65cc8@google.com>
 <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240515.Yoo5chaiNai9@digikod.net>
X-Infomaniak-Routing: alpha

Adding membarrier experts.

On Wed, May 15, 2024 at 05:12:58PM +0200, Mickaël Salaün wrote:
> On Thu, May 09, 2024 at 08:01:49PM -0400, Paul Moore wrote:
> > On Wed, May 8, 2024 at 3:32 PM syzbot
> > <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14a46760980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=5446fbf332b0602ede0b
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/39d66018d8ad/disk-dccb07f2.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/c160b651d1bc/vmlinux-dccb07f2.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/3662a33ac713/bzImage-dccb07f2.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com
> > >
> > > general protection fault, probably for non-canonical address 0xdffffc018f62f515: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > KASAN: probably user-memory-access in range [0x0000000c7b17a8a8-0x0000000c7b17a8af]
> > > CPU: 1 PID: 5102 Comm: syz-executor.1 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> > > RIP: 0010:hook_inode_free_security+0x5b/0xb0 security/landlock/fs.c:1047
> > 
> > Possibly a Landlock issue, Mickaël?
> 
> It looks like security_inode_free() is called two times on the same
> inode.  This could happen if an inode labeled by Landlock is put
> concurrently with release_inode() for a closed ruleset or with
> hook_sb_delete().  I didn't find any race condition that could lead to
> two calls to iput() though.  Could WRITE_ONCE(object->underobj, NULL)
> change anything even if object->lock is locked?
> 
> A bit unrelated but looking at the SELinux code, I see that selinux_inode()
> checks `!inode->i_security`.  In which case could this happen?
> 
> > 
> > > Code: 8a fd 48 8b 1b 48 c7 c0 c4 4e d5 8d 48 c1 e8 03 42 0f b6 04 30 84 c0 75 3e 48 63 05 33 59 65 09 48 01 c3 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 66 be 8a fd 48 83 3b 00 75 0d e8
> > > RSP: 0018:ffffc9000307f9a8 EFLAGS: 00010212
> > > RAX: 000000018f62f515 RBX: 0000000c7b17a8a8 RCX: ffff888027668000
> > > RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff88805c0bb270
> > > RBP: ffffffff8c01fb00 R08: ffffffff82132a15 R09: 1ffff1100b81765f
> > > R10: dffffc0000000000 R11: ffffffff846ff540 R12: dffffc0000000000
> > > R13: 1ffff1100b817683 R14: dffffc0000000000 R15: dffffc0000000000
> > > FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f43c42de000 CR3: 00000000635f8000 CR4: 0000000000350ef0
> > > Call Trace:
> > >  <TASK>
> > >  security_inode_free+0x4a/0xd0 security/security.c:1613
> > >  __destroy_inode+0x2d9/0x650 fs/inode.c:286
> > >  destroy_inode fs/inode.c:309 [inline]
> > >  evict+0x521/0x630 fs/inode.c:682
> > >  dispose_list fs/inode.c:700 [inline]
> > >  evict_inodes+0x5f9/0x690 fs/inode.c:750
> > >  generic_shutdown_super+0x9d/0x2d0 fs/super.c:626
> > >  kill_block_super+0x44/0x90 fs/super.c:1675
> > >  deactivate_locked_super+0xc6/0x130 fs/super.c:472
> > >  cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
> > >  task_work_run+0x251/0x310 kernel/task_work.c:180
> > >  exit_task_work include/linux/task_work.h:38 [inline]
> > >  do_exit+0xa1b/0x27e0 kernel/exit.c:878
> > >  do_group_exit+0x207/0x2c0 kernel/exit.c:1027
> > >  __do_sys_exit_group kernel/exit.c:1038 [inline]
> > >  __se_sys_exit_group kernel/exit.c:1036 [inline]
> > >  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7f731567dd69
> > > Code: Unable to access opcode bytes at 0x7f731567dd3f.
> > > RSP: 002b:00007fff4f0804d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> > > RAX: ffffffffffffffda RBX: 00007f73156c93a3 RCX: 00007f731567dd69
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > RBP: 0000000000000002 R08: 00007fff4f07e277 R09: 00007fff4f081790
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff4f081790
> > > R13: 00007f73156c937e R14: 00000000000154d0 R15: 000000000000001e
> > >  </TASK>
> > > Modules linked in:
> > > ---[ end trace 0000000000000000 ]---
> > 
> > -- 
> > paul-moore.com
> > 

