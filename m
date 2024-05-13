Return-Path: <linux-security-module+bounces-3199-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CDD8C450F
	for <lists+linux-security-module@lfdr.de>; Mon, 13 May 2024 18:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D605A282528
	for <lists+linux-security-module@lfdr.de>; Mon, 13 May 2024 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50F923CB;
	Mon, 13 May 2024 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EtLJxLqi"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59BE155386
	for <linux-security-module@vger.kernel.org>; Mon, 13 May 2024 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617653; cv=none; b=qSu8hwte3y9mNuZknKtrWjG2W/x+Tm7mJezMGb6MC9I2c/0iTHBwcxtChwDYqgvaGvK04DQEqg8M7CaYknuSrjp3viLyyKr0FNRvKQgT55koAZCxj4KbcHw0xGfJTH7IsuN3z6SDBryhfuWfFFAuUyNecO12qeav3PI0GrXiR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617653; c=relaxed/simple;
	bh=qLT4uwVVob5AkmWCScwVksGNuuWgGHV65B2AVyETctw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfOebwPphTPBPlyTSMx9ASac4xMTJRiukLh+Jd+sULI6AcCvSx+c/ZLYmY9iBmW10Lmjq+oPIgMPtgXyKQiTmHsQTnz6aOvAyHOGpXgFmEXuRtkxmsYY2+JJD685tiYQ5Mfo0tPneQ3UTE0+rXKlqCDR/OLra0mKM6B2LPo9VUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EtLJxLqi; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de45dba15feso4442876276.3
        for <linux-security-module@vger.kernel.org>; Mon, 13 May 2024 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715617651; x=1716222451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItbWsDmlfW8ru/6uKfBUbAiq+b9kQ7JUZehCR4zTOiY=;
        b=EtLJxLqifaYI8M9w4HedvvjjNyjVpJgJKwHyY9/KdDk2LuuMmcEpRwak2W23Gg5tKg
         H/yzL7+l3Jg8wHnQ9jIWG0UITznceZ9pWKNYaj+WWW8SRhTsgds7Zm7XTJDOq75Hdfry
         v9YhJPd53M0mp4viWdM8eCF9Vxnnttv8Bqj6Tw/aFine8TqyH6SWV5835mG6Fqsq26KV
         DoE6jFkJ7Fs/iGYdg+AQe1ruKOmkMT6OJRuY/2aaByHukRlsiuDg4yHyTYkGaH+pcVPc
         Xa9K9xa9d1K++V2/GgVj39b/WO76n4DrKApmIpCuc4wuZK2fWbXfzHrya3l5mLwFAhC3
         vhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715617651; x=1716222451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItbWsDmlfW8ru/6uKfBUbAiq+b9kQ7JUZehCR4zTOiY=;
        b=jK6Dt7lfFbyj2nfv43QglH/icWjh2KCtrWqntVHQQ4emGvaE8zLiwKUQkNUMj+NsaS
         jss8sSrwI8IHv+DsolPcjdGlQEszfGehZ36B5RdwjLeXxqrSTbZ2hYyill0U0SyGq87l
         jnUxoFs/uRCZHzlr+eeAGGP8oJWhqeqzWl1XRkA+g78Ks7528HyhNKPni3Rf9iyVJ3BO
         W4LzI6O9Lg48zZaqZ8TI1yFj1ynnG5U99V5OO6o01xCAWv6i8neaJdWQe8tifezCIJvi
         u5LGoTYz0RQCEhHdATB2IIf1Y7JjlwGi1i0xFm7BkjZqGQPvhiMl3xLYHDg4DshNYJ71
         jcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUltHwE8ep5ovmfug76+nath/2Wtb79EUhgWDBA2V0ha/VLuqOwf3VW4jiXF+NCsFrQmdKsbvEH03404TKgZ0EVYceHu1lHgCXqaBGB99smKjw5OH5x
X-Gm-Message-State: AOJu0YxuMZzO/fqmidOzIRgEeT8Cz2XiaC4AsswZIjrC2yUTb4CIiiqd
	ckFznJ2mnCF5YmkrWWetNs+mMVBbsQNVr/GC9jXIdGMBJr7qovdLfRBRVFun2AJ/u8vkAkVLN6f
	OCOQWudWxnRge4pViowdUXFuqn1K39py8sVQH
X-Google-Smtp-Source: AGHT+IERvBVcwh5CfAI+o7tfZ3iHNyHpMBO+lpa8+hSaKNfFMg7LUrHPWT9j+dS24Q4jZzQEVByPRq4AXSxgaGusRuM=
X-Received: by 2002:a25:9f84:0:b0:dd0:bb34:1e77 with SMTP id
 3f1490d57ef6-dee4f332e5bmr7647100276.53.1715617650895; Mon, 13 May 2024
 09:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f4260d000a3a55b9e8b6a3b4e3fffc7da9f82d41.1715359817.git.dcaratti@redhat.com>
In-Reply-To: <f4260d000a3a55b9e8b6a3b4e3fffc7da9f82d41.1715359817.git.dcaratti@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 May 2024 12:27:20 -0400
Message-ID: <CAHC9VhTH2zgA8tYMr4d6o3SicDAGDpE+3NwN9vP=6DpEFLObxg@mail.gmail.com>
Subject: Re: [PATCH net v5] netlabel: fix RCU annotation for IPv4 options on
 socket creation
To: Davide Caratti <dcaratti@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, Xiumei Mu <xmu@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 1:19=E2=80=AFPM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
> Xiumei reports the following splat when netlabel and TCP socket are used:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: suspicious RCU usage
>  6.9.0-rc2+ #637 Not tainted
>  -----------------------------
>  net/ipv4/cipso_ipv4.c:1880 suspicious rcu_dereference_protected() usage!
>
>  other info that might help us debug this:
>
>  rcu_scheduler_active =3D 2, debug_locks =3D 1
>  1 lock held by ncat/23333:
>   #0: ffffffff906030c0 (rcu_read_lock){....}-{1:2}, at: netlbl_sock_setat=
tr+0x25/0x1b0
>
>  stack backtrace:
>  CPU: 11 PID: 23333 Comm: ncat Kdump: loaded Not tainted 6.9.0-rc2+ #637
>  Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  =
07/26/2013
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0xa9/0xc0
>   lockdep_rcu_suspicious+0x117/0x190
>   cipso_v4_sock_setattr+0x1ab/0x1b0
>   netlbl_sock_setattr+0x13e/0x1b0
>   selinux_netlbl_socket_post_create+0x3f/0x80
>   selinux_socket_post_create+0x1a0/0x460
>   security_socket_post_create+0x42/0x60
>   __sock_create+0x342/0x3a0
>   __sys_socket_create.part.22+0x42/0x70
>   __sys_socket+0x37/0xb0
>   __x64_sys_socket+0x16/0x20
>   do_syscall_64+0x96/0x180
>   ? do_user_addr_fault+0x68d/0xa30
>   ? exc_page_fault+0x171/0x280
>   ? asm_exc_page_fault+0x22/0x30
>   entry_SYSCALL_64_after_hwframe+0x71/0x79
>  RIP: 0033:0x7fbc0ca3fc1b
>  Code: 73 01 c3 48 8b 0d 05 f2 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e =
0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 29 00 00 00 0f 05 <48> 3d 01 f0 f=
f ff 73 01 c3 48 8b 0d d5 f1 1b 00 f7 d8 64 89 01 48
>  RSP: 002b:00007fff18635208 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
>  RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fbc0ca3fc1b
>  RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
>  RBP: 000055d24f80f8a0 R08: 0000000000000003 R09: 0000000000000001
>
> R10: 0000000000020000 R11: 0000000000000246 R12: 000055d24f80f8a0
>  R13: 0000000000000000 R14: 000055d24f80fb88 R15: 0000000000000000
>   </TASK>
>
> The current implementation of cipso_v4_sock_setattr() replaces IP options
> under the assumption that the caller holds the socket lock; however, such
> assumption is not true, nor needed, in selinux_socket_post_create() hook.
>
> Let all callers of cipso_v4_sock_setattr() specify the "socket lock held"
> condition, except selinux_socket_post_create() _ where such condition can
> safely be set as true even without holding the socket lock.
>
> v5:
>  - fix kernel-doc
>  - adjust #idfefs around prototype of netlbl_sk_lock_check() (thanks Paul=
 Moore)
>
> v4:
>  - fix build when CONFIG_LOCKDEP is unset (thanks kernel test robot)
>
> v3:
>  - rename variable to 'sk_locked' (thanks Paul Moore)
>  - keep rcu_replace_pointer() open-coded and re-add NULL check of 'old',
>    these two changes will be posted in another patch (thanks Paul Moore)
>
> v2:
>  - pass lockdep_sock_is_held() through a boolean variable in the stack
>    (thanks Eric Dumazet, Paul Moore, Casey Schaufler)
>  - use rcu_replace_pointer() instead of rcu_dereference_protected() +
>    rcu_assign_pointer()
>  - remove NULL check of 'old' before kfree_rcu()
>
> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  include/net/cipso_ipv4.h     |  6 ++++--
>  include/net/netlabel.h       | 12 ++++++++++--
>  net/ipv4/cipso_ipv4.c        |  7 ++++---
>  net/netlabel/netlabel_kapi.c | 31 ++++++++++++++++++++++++++++---
>  security/selinux/netlabel.c  |  5 ++++-
>  security/smack/smack_lsm.c   |  3 ++-
>  6 files changed, 52 insertions(+), 12 deletions(-)

Thanks Davide.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

