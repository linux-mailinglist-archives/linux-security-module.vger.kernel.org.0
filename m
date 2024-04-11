Return-Path: <linux-security-module+bounces-2649-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2948A1FA6
	for <lists+linux-security-module@lfdr.de>; Thu, 11 Apr 2024 21:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6352285DDD
	for <lists+linux-security-module@lfdr.de>; Thu, 11 Apr 2024 19:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872C615E88;
	Thu, 11 Apr 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S/jOi8OE"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF48113FFC
	for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2024 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864729; cv=none; b=Z10dzbJwgosLSu7tcEzEVIZIPzlzzJtwRukc97PDxfnSnjYiK5C7I7deCd++k7TjsLKGBxvV0UtbqcDql7Rjl/GN5cCC6FUG2XEq7R2O66160QcJPaROvm+zwWtcTE+ilTg1t+y+ww7E6ch2Mzji3kClvtbXEdI1ZrKZvPcNc2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864729; c=relaxed/simple;
	bh=V2e+E/LLZbeig+q64KqTId7fTFcd13xAmlywdBcss+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bx8i8irVcAZdlQLdQE+9dgNrr1oeK2rrgvpMFNSL3NJPH1HdPooUSB7Zi3IjQVNKFZlKJ/yHVGVaXRo0thBvcf0pVIbfZVH9HqVLuUpXN+gybIxpTJ0pjT3vc0rNBSaAYfzkDJnmlHOQlUAZaaJ4FgE3YDefIEw4E1T3MAtUqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S/jOi8OE; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6114c9b4d83so1052597b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2024 12:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712864727; x=1713469527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXktc6WJzam4cevSUKYD9XpI0l/fnUAGRreLnuHlLO4=;
        b=S/jOi8OE/MUIabGaqY5B78kDdf0pp0mzLVLM7BUvMuCclyRgbcawe43z59xzATzRM0
         4vU44ylq/2udMP1sif9HhCUvXlFQakyOVF1RYuzjUDPu29FaKY2uMIqkTJ2c0q4jATDo
         eVO9vmlihe615ATE4VXM4byJdS17zNzfewEURXU/Bz7axVaztPgkUmoFsVwVsE5TzwGk
         iVry1DhQZ2Qwpskew2DMcQkLABKsH4c4lHTlTx0qSHLe66SYp1ELwZaqkWiKF98YIEaX
         dxKu/1PqSCwLgkhNAJt/krlCoAdURIF/zDWXmPstSAOdnljCUgI+nYWGgq4FX2o2aaVn
         peYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712864727; x=1713469527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXktc6WJzam4cevSUKYD9XpI0l/fnUAGRreLnuHlLO4=;
        b=uNW7sRrexD2iwlrunXsjeubqeDKVW70jR6ibALwTOQNgxn9Utmrkn3FkNcQmiezxjp
         FAwYvSdm7n7eVsL4caSFxHGBW9RtX2EsYUzHQYzr+M4Q7sxfxMW2S45I2VQ1aNOSIIHG
         STdQ8lOfok1ZB+/qnnEDKkkYJSpL6lJMOkKibY04jMWAtELF2ggDMjymDI9iSmlBXw31
         9k/nsxlxMhqurXLGRk1l3wkhsHZWKEKwB/ozr4q1BPPdKOLzGt40vayJ8TMuU31XZ5xi
         4VjpquP7NnfFJsrMiDQ1eFl0XVgNuqcbMI76I9KdSWoZzOOv2iqAiDBXUMoIK2X35atD
         WMpg==
X-Forwarded-Encrypted: i=1; AJvYcCUsKDlT2kIq8u2vvuRaZ6oebMNxEKqdFkQ3+lYL1KWjp+RCLXrhjJqFYtF682aPHnxBdV/5DkppOPVY4Go2hCnabEDBdX6NiLuaqtegM5LbiiKgtCt/
X-Gm-Message-State: AOJu0Yw9DjekqmtivC7h+ZawC4+WQ2wRPzibUfaSqjd+lenexG7yUnm9
	yH8SidLCvGksj0dlqU1/lZk3IBn1ooGKlvhGVuB7IFpaoT+tJLrlQyjSrTzqdqOD71fXPyBiBxY
	0fFs1HnJICDDxGfYt6g6NygOz6p8acvtyIKV3
X-Google-Smtp-Source: AGHT+IEoZdCZYP9E+KyG/HWKYfqOiqiFM2GeAY9koNxwBfRATFHsj+xdZjZ++in0WsbTMQXClyF/Cn+kl4BX6mFlod4=
X-Received: by 2002:a81:d102:0:b0:618:b08:2ab6 with SMTP id
 w2-20020a81d102000000b006180b082ab6mr447510ywi.47.1712864726708; Thu, 11 Apr
 2024 12:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d1d6a20f5090829629df76809fc5d25d055be49a.1712849802.git.dcaratti@redhat.com>
 <CANn89iLyMv2JjEGRoAWb51TpxuMb5iCPb8dvTAmdJoZvx4=2LA@mail.gmail.com>
In-Reply-To: <CANn89iLyMv2JjEGRoAWb51TpxuMb5iCPb8dvTAmdJoZvx4=2LA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Apr 2024 15:45:15 -0400
Message-ID: <CAHC9VhS8ZcJ=R-2Fytp8_cfn9=pJ5w41swZ9FrxPQmvyvhgJ9Q@mail.gmail.com>
Subject: Re: [PATCH net] netlabel: fix RCU annotation for IPv4 options on
 socket creation
To: Eric Dumazet <edumazet@google.com>
Cc: Davide Caratti <dcaratti@redhat.com>, xmu@redhat.com, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:57=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> On Thu, Apr 11, 2024 at 5:44=E2=80=AFPM Davide Caratti <dcaratti@redhat.c=
om> wrote:
> >
> > Xiumei reports the following splat when netlabel and TCP socket are use=
d:
> >
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >  WARNING: suspicious RCU usage
> >  6.9.0-rc2+ #637 Not tainted
> >  -----------------------------
> >  net/ipv4/cipso_ipv4.c:1880 suspicious rcu_dereference_protected() usag=
e!
> >
> >  other info that might help us debug this:
> >
> >  rcu_scheduler_active =3D 2, debug_locks =3D 1
> >  1 lock held by ncat/23333:
> >   #0: ffffffff906030c0 (rcu_read_lock){....}-{1:2}, at: netlbl_sock_set=
attr+0x25/0x1b0
> >
> >  stack backtrace:
> >  CPU: 11 PID: 23333 Comm: ncat Kdump: loaded Not tainted 6.9.0-rc2+ #63=
7
> >  Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0=
  07/26/2013
> >  Call Trace:
> >   <TASK>
> >   dump_stack_lvl+0xa9/0xc0
> >   lockdep_rcu_suspicious+0x117/0x190
> >   cipso_v4_sock_setattr+0x1ab/0x1b0
> >   netlbl_sock_setattr+0x13e/0x1b0
> >   selinux_netlbl_socket_post_create+0x3f/0x80
> >   selinux_socket_post_create+0x1a0/0x460
> >   security_socket_post_create+0x42/0x60
> >   __sock_create+0x342/0x3a0
> >   __sys_socket_create.part.22+0x42/0x70
> >   __sys_socket+0x37/0xb0
> >   __x64_sys_socket+0x16/0x20
> >   do_syscall_64+0x96/0x180
> >   ? do_user_addr_fault+0x68d/0xa30
> >   ? exc_page_fault+0x171/0x280
> >   ? asm_exc_page_fault+0x22/0x30
> >   entry_SYSCALL_64_after_hwframe+0x71/0x79
> >  RIP: 0033:0x7fbc0ca3fc1b
> >  Code: 73 01 c3 48 8b 0d 05 f2 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2=
e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 29 00 00 00 0f 05 <48> 3d 01 f0=
 ff ff 73 01 c3 48 8b 0d d5 f1 1b 00 f7 d8 64 89 01 48
> >  RSP: 002b:00007fff18635208 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
> >  RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fbc0ca3fc1b
> >  RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
> >  RBP: 000055d24f80f8a0 R08: 0000000000000003 R09: 0000000000000001
> >  R10: 0000000000020000 R11: 0000000000000246 R12: 000055d24f80f8a0
> >  R13: 0000000000000000 R14: 000055d24f80fb88 R15: 0000000000000000
> >   </TASK>
> >
> > The current implementation of cipso_v4_sock_setattr() replaces IP optio=
ns
> > under the assumption that the caller holds the socket lock; however, su=
ch
> > assumption is not true, nor needed, in selinux_socket_post_create() hoo=
k.
> >
> > Using rcu_dereference_check() instead of rcu_dereference_protected() wi=
ll
> > avoid the reported splat for the netlbl_sock_setattr() case, and preser=
ve
> > the legitimate check when the caller is netlbl_conn_setattr().
> >
> > Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> > Reported-by: Xiumei Mu <xmu@redhat.com>
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> > ---
> >  net/ipv4/cipso_ipv4.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> > index 8b17d83e5fde..1d0c2a905078 100644
> > --- a/net/ipv4/cipso_ipv4.c
> > +++ b/net/ipv4/cipso_ipv4.c
> > @@ -1876,8 +1876,10 @@ int cipso_v4_sock_setattr(struct sock *sk,
> >
> >         sk_inet =3D inet_sk(sk);
> >
> > -       old =3D rcu_dereference_protected(sk_inet->inet_opt,
> > -                                       lockdep_sock_is_held(sk));
> > +       /* caller either holds rcu_read_lock() (on socket creation)
> > +        * or socket lock (in all other cases). */
> > +       old =3D rcu_dereference_check(sk_inet->inet_opt,
> > +                                   lockdep_sock_is_held(sk));
> >         if (inet_test_bit(IS_ICSK, sk)) {
> >                 sk_conn =3D inet_csk(sk);
> >                 if (old)
> > --
> > 2.44.0
> >
>
> OK, but rcu_read_lock() being held (incidentally by the caller) here
> is not protecting the write operation,
> so this looks wrong IMO.
>
> Whenever we can not ensure a mutex/spinlock is held, we usually use
> rcu_dereference_protected(XXX, 1),
> and a comment might simply explain the reason we assert it is protected.
>
> (We also could add a new boolean parameter, set to true or false
> depending on the caller)
>
> old =3D rcu_dereference_protected(sk_inet->inet_opt, from_socket_creation=
 ||
>
>             lockdep_sock_is_held(sk));

Agree with everything Eric said.  I'm okay with the
rcu_deref_prot(XXX, 1) + comment approach, but if you wanted to put in
the work to chase the callers and setup the boolean that would be
great too.

--=20
paul-moore.com

