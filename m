Return-Path: <linux-security-module+bounces-9675-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD8AAAAD84
	for <lists+linux-security-module@lfdr.de>; Tue,  6 May 2025 04:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444D916BB17
	for <lists+linux-security-module@lfdr.de>; Tue,  6 May 2025 02:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8F23F3261;
	Mon,  5 May 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IPdAXIgp"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70313B7A93
	for <linux-security-module@vger.kernel.org>; Mon,  5 May 2025 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487300; cv=none; b=bkEBM87aDeQTTRP/vo+o3Xlfzt2LjGdugxmecNSzKEAaGyrmdy15yGIGYvmbF1UIFnFQT5EVSU5AjvvszB22Wn+a7A3RY1Ub1E5l3m8+BumSkZ/YzQJGFk9kg/VtU/H6SN65vDLBSTj87Y4okPfWSH/v73vZ1ZOoQbs4rnhboh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487300; c=relaxed/simple;
	bh=M1rNvi5IBqtAIocwGPm1o4C7y6mmduk4IFovIptv03Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmtCPC+yulWb5hb3+E9LeheUvP2Y2Ko1snB9CGORuGscz/JnnYMcUlE0e3YeW6JYhHuMEkO5uYPY3/Rt6OeuD8o1NdYr6U4EFQVHAQnf75vIrHpgwgMI+B6tRQ4gPQCbxrZv6ebM0SZN4XThXTcwvtaI4tHtTFDH/zcmYeZ9Dnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IPdAXIgp; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ff1e375a47so46631337b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 05 May 2025 16:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746487297; x=1747092097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G1FbKrQzDvE2zFQ4OGF86gQA4uigjBt52shV4GCsH4=;
        b=IPdAXIgpIXOjwIi3qpyJiZvobbi/B5lZPls4T3SyZ349IT5rBlGbgLYfIyNKAQOIbB
         dpPvH6aFkaFpqvI8V+oEZF1JHKytlcg5Jz6KlStGpOc5O27vhH24y/ie/DxO131N/MPs
         zjeQ/YajlNY6R8WDHsuyZ3tfgNTVh99MYqbgROy/P486E3UcrK7/wW0dwp6vG0jCmoRR
         zzR6j+4G8WY/Wju41FpOn16XoVqGBZ31w6fEf/SDhZkbRXHDCXI6X+RRGIL0W2VR5WPo
         ob3GTLJ9l0jJbvz52FSGM6/0DCfm17YasWvsr4ykhHZF3J0+G3Wx0uwoejjFExnLCLYQ
         y4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746487297; x=1747092097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G1FbKrQzDvE2zFQ4OGF86gQA4uigjBt52shV4GCsH4=;
        b=ZkmZI1HGTTOOe16IAGSyIFNurCPGxoChZMvYo80bgGbci/ejahNWqvR3oNrpbjQN2q
         nDTapfCsyfbfPk2fxbGhfKkaMXY9DY2MEbKkZrjHMvysucLi1Y9JocZy2tuHjbLae7UY
         5HyFuneNtWPU45DGyHakJRlSLwM3g49GYngJ3IytlbCMd1rC7XsEKpMY1vACSducb7hk
         LxjYwqgJSSRviuqSThh8h4AszPpqq2byjWmhBtyYk3ibp9/SHuNwBUXlX8FLE0B1B33O
         LDL1VM3lO43JtCvOGwYNvWMg9su2B23RDS0YadX4ssrFSX0zmNcgrUUfrME/peF9uzJs
         0dfw==
X-Forwarded-Encrypted: i=1; AJvYcCU1W5dZJWMS75cpwNzZB/FG9ghckDNPICpKqM48YkiCCqox9BE6+70yrBPCq48oH+15qZkIzPTL6T0+EO/xm+TY3xnI9ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDAsEWfWoUj+nxmGXel8CUkr4NBXu7ScAV8lNWFNrLMIl++LE3
	F2p47UhjEW7iFXK5MoAYdAg+wfn9deIHfgsYlSlud6p2hVsOuiIBAyZnOU248M+Vmp5SmVYG3F7
	c7ZbtFK/q0mIO66YrKBfWgAI4MfVFBssMVCyl
X-Gm-Gg: ASbGncuYCOUJehBs88HVp9LOJSObdFu6OB+aUY2xBAuytAnoXJ59HuYB9Fdkzq23pjB
	GiHCJFUT7CE9nFhmxF/Hb10ZzSw6P+8qXHbaUOqN9Knh+YJ3GxOGwR4je5gc1eWzToMn3vwDK3x
	y8M/z3U79cwlJ8V3xa3lmlZw==
X-Google-Smtp-Source: AGHT+IHLXLx91/FbEJt5yJ1gpflouu1LHjSpq+W5xEkf3fbXAPgGT1qcMH0TY3xngEgXpN4NAVmxqiTFxj/qTbkAJSQ=
X-Received: by 2002:a05:690c:600b:b0:708:cc77:8c31 with SMTP id
 00721157ae682-709197c6e00mr17569947b3.10.1746487296655; Mon, 05 May 2025
 16:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505215802.48449-1-kuniyu@amazon.com>
In-Reply-To: <20250505215802.48449-1-kuniyu@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 May 2025 19:21:25 -0400
X-Gm-Features: ATxdqUHN1aQ5sN5xgMfe_tU3NdrBy8rWAl_E8NdG3Ln9Hdp4hd4BbKVFegZ9Jhs
Message-ID: <CAHC9VhSWS2L3qwu_r_1Fr3eLp-9KRz3_20EPwy=FFu7_eSiN7g@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 0/5] af_unix: Allow BPF LSM to scrub
 SCM_RIGHTS at sendmsg().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 5:58=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> As long as recvmsg() or recvmmsg() is used with cmsg, it is not
> possible to avoid receiving file descriptors via SCM_RIGHTS.
>
> This behaviour has occasionally been flagged as problematic.
>
> For instance, as noted on the uAPI Group page [0], an untrusted peer
> could send a file descriptor pointing to a hung NFS mount and then
> close it.  Once the receiver calls recvmsg() with msg_control, the
> descriptor is automatically installed, and then the responsibility
> for the final close() now falls on the receiver, which may result
> in blocking the process for a long time.
>
> systemd calls cmsg_close_all() [1] after each recvmsg() to close()
> unwanted file descriptors sent via SCM_RIGHTS.
>
> However, this cannot work around the issue because the last fput()
> could occur on the receiver side once sendmsg() with SCM_RIGHTS
> succeeds.  Also, even filtering by LSM at recvmsg() does not work
> for the same reason.
>
> Thus, we need a better way to filter SCM_RIGHTS on the sender side.
>
> This series allows BPF LSM to inspect skb at sendmsg() and scrub
> SCM_RIGHTS fds by kfunc.

I'll take a closer look later this week, but generally speaking LSM
hooks are intended for observability and access control, not data
modification, which means what you are trying to accomplish may not be
a good fit for a LSM hook.  Have you considered simply inspecting the
skb at sendmsg() and rejecting the send in the LSM hook if a
SCM_RIGHTS cmsg is present that doesn't fit within the security policy
implemented in your BPF program?

> Link: https://uapi-group.org/kernel-features/#disabling-reception-of-scm_=
rights-for-af_unix-sockets #[0]
> Link: https://github.com/systemd/systemd/blob/v257.5/src/basic/fd-util.c#=
L612-L628 #[1]
>
>
> Kuniyuki Iwashima (5):
>   af_unix: Call security_unix_may_send() in sendmsg() for all socket
>     types
>   af_unix: Pass skb to security_unix_may_send().
>   af_unix: Remove redundant scm->fp check in __scm_destroy().
>   bpf: Add kfunc to scrub SCM_RIGHTS at security_unix_may_send().
>   selftest: bpf: Add test for bpf_unix_scrub_fds().
>
>  include/linux/lsm_hook_defs.h                 |   3 +-
>  include/linux/security.h                      |   5 +-
>  include/net/af_unix.h                         |   1 +
>  include/net/scm.h                             |   5 +-
>  net/compat.c                                  |   2 +-
>  net/core/filter.c                             |  19 ++-
>  net/core/scm.c                                |  19 +--
>  net/unix/af_unix.c                            |  48 ++++--
>  security/landlock/task.c                      |   6 +-
>  security/security.c                           |   5 +-
>  security/selinux/hooks.c                      |   6 +-
>  security/smack/smack_lsm.c                    |   6 +-
>  .../bpf/prog_tests/lsm_unix_may_send.c        | 160 ++++++++++++++++++
>  .../selftests/bpf/progs/lsm_unix_may_send.c   |  30 ++++
>  14 files changed, 282 insertions(+), 33 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_unix_may_s=
end.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lsm_unix_may_send.c
>
> --
> 2.49.0

--
paul-moore.com

