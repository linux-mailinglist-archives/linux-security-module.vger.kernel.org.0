Return-Path: <linux-security-module+bounces-1177-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1B08419CB
	for <lists+linux-security-module@lfdr.de>; Tue, 30 Jan 2024 04:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA0E1F241BD
	for <lists+linux-security-module@lfdr.de>; Tue, 30 Jan 2024 03:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7B22421D;
	Tue, 30 Jan 2024 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dDy1LIBl"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25826AC7
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jan 2024 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583709; cv=none; b=dL1xT5eHuuGE+5GkYYdXuo5v4jAj3KzKlgoUTMXUuvrJ4QTFea/5YUO79RhB+7zQkT2scGbG9qLVcuVhFZrKRArB5adERg7f6T+vZC1E5Ey1b0DN6KeyCN7Vk6c7gPGk9TTPknlMD8T9t0wSxLdTSFXsT9HVPSmlFqg0F7eJqgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583709; c=relaxed/simple;
	bh=wcuvHtioncD67f/M0R3CcFy9nMIOeXFUxuHu4+mW+/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEXWjz6QqIcqXmKrlNxx6rQXs3neneMVBxNMVy/wPiNXjj7o8wn8E8j4nAydtUB50K+WOTEqcx31DY4pX5/P/bdOKyl1v50wrfYEqA660XJAYsPBKAAaZvLFB6T3VOA97k1FDlIxWo80tJhoM+41u8bPA67yi+3b4w/JmyPooiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dDy1LIBl; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6432ee799so3686777276.0
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jan 2024 19:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706583706; x=1707188506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFBXJkYEuR0HGyt1NUsx3r83N7+FqQNXrS1C/eFQu+8=;
        b=dDy1LIBl6sPyml9lk9MVLUdEqbkzJIOofzURa+Dd/zlR9hek0jG0RHvAQguSa21i/l
         z2S2qGBd3ahxvOw2os+e8Rh/FrN/brgr2Wne5H4M5cQ3NkHiT5VSdSB2cFfV5xwIKnwe
         gRv220QhuI/HeFcAEulk+IBDi9gP9Y6ptqfWWGVcVJEdDikc5c1L0FRzR7dqRTZLL2iL
         B6U4gfctDVgzZelDafqcLoI8o69DQe3X6fjDcRFksERa7XzH7c9IQgJBcALNfAwnQf/g
         0NMfYyo3EEjCcE350WeS1U40ruUaNSI6EMvNSSYs/KwGP1NX6VeOcGv6KlPuEOMSEJyx
         9ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706583706; x=1707188506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFBXJkYEuR0HGyt1NUsx3r83N7+FqQNXrS1C/eFQu+8=;
        b=jRohJYuiQSPrXdPzgpA9f0GXrlPif9PEBqBNljwFbVx0Sx6WIjkQvSAhiNVpqKkO0F
         9oYMxfHl3DHAS/Urb+ajN8qwM/OrAfZ+wv9TQ6AHIJZtRS0JGRJt6HaFgkgAgiMeuHzx
         JYiIfn1FUIbLxhhOnAC1aq0kcj9j/AIAMk8d/uOZlxBGPeZ6hDV91ysi4hs++vw5y+zk
         gsCsPqZdvRHmUkLngw0oich+y+aTnM71ipGZ8vkVqiEI73joT8mWhbHqzkXp39aVtVCW
         pfKypH30IqhZvY4J3BWLDUJ3nxhGRl4aL10umcEGTJjo3F6RjVrG9UPjv3KkEFdl0zWX
         6h5Q==
X-Gm-Message-State: AOJu0Yy639pvUBiQMZh+mCurVyOLfIxZQOrKoBu7y0NF2E5C39P4vv8D
	freG/F74mlzFOTeVvyYXHTwtUParI02ULaD5yHzjiL+6eUh8HWGg9BSejrUwm6ftt43uvY+EQ3L
	r8WUR57UtX1F5t3LxbwPjJ+jKVsBkUb/UlzYk
X-Google-Smtp-Source: AGHT+IFVpxnoCE2yTWMGT8g75Z4ZdPAb4Zw3OcjQM/RPv/PT/veZ0zlcFm594ypfOSF+wF55xLu72+Rtq6V+aY92Y/c=
X-Received: by 2002:a25:9703:0:b0:dc2:1f56:11e4 with SMTP id
 d3-20020a259703000000b00dc21f5611e4mr5192935ybo.24.1706583705879; Mon, 29 Jan
 2024 19:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126184531.1167999-1-omosnace@redhat.com> <CAHC9VhRy2uYmfoWYx57P6dRcZsJHmgCmdixi56hUoO=YvOqa5A@mail.gmail.com>
 <6e98ef30-ba98-4e99-bb03-9878c50e957b@schaufler-ca.com>
In-Reply-To: <6e98ef30-ba98-4e99-bb03-9878c50e957b@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jan 2024 22:01:34 -0500
Message-ID: <CAHC9VhRv260QHLe4RWYCD62DRv5-b7o-Davn_A9J_ZHJhMiJag@mail.gmail.com>
Subject: Re: [PATCH] lsm: fix default return value of the socket_getpeersec_* hooks
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 6:25=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 1/29/2024 3:02 PM, Paul Moore wrote:
> > On Fri, Jan 26, 2024 at 1:45=E2=80=AFPM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> >> For these hooks the true "neutral" value is -EOPNOTSUPP, which is
> >> currently what is returned when no LSM provides this hook and what LSM=
s
> >> return when there is no security context set on the socket. Correct th=
e
> >> value in <linux/lsm_hooks.h> and adjust the dispatch functions in
> >> security/security.c to avoid issues when the BPF LSM is enabled.
> >>
> >> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> >> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >> ---
> >>  include/linux/lsm_hook_defs.h |  4 ++--
> >>  security/security.c           | 31 +++++++++++++++++++++++++++----
> >>  2 files changed, 29 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_de=
fs.h
> >> index 185924c56378..76458b6d53da 100644
> >> --- a/include/linux/lsm_hook_defs.h
> >> +++ b/include/linux/lsm_hook_defs.h
> >> @@ -315,9 +315,9 @@ LSM_HOOK(int, 0, socket_getsockopt, struct socket =
*sock, int level, int optname)
> >>  LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, i=
nt optname)
> >>  LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
> >>  LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff=
 *skb)
> >> -LSM_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
> >> +LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_stream, struct socket *=
sock,
> >>          sockptr_t optval, sockptr_t optlen, unsigned int len)
> >> -LSM_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
> >> +LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_dgram, struct socket *s=
ock,
> >>          struct sk_buff *skb, u32 *secid)
> >>  LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_=
t priority)
> >>  LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
> >> diff --git a/security/security.c b/security/security.c
> >> index 6196ccaba433..3aaad75c9ce8 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -4624,8 +4624,20 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
> >>  int security_socket_getpeersec_stream(struct socket *sock, sockptr_t =
optval,
> >>                                       sockptr_t optlen, unsigned int l=
en)
> >>  {
> >> -       return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, s=
ock,
> >> -                            optval, optlen, len);
> >> +       struct security_hook_list *hp;
> >> +       int rc;
> >> +
> >> +       /*
> >> +        * Only one module will provide a security context.
> >> +        */
> >> +       hlist_for_each_entry(hp, &security_hook_heads.socket_getpeerse=
c_stream,
> >> +                            list) {
> >> +               rc =3D hp->hook.socket_getpeersec_stream(sock, optval,=
 optlen,
> >> +                                                      len);
> >> +               if (rc !=3D LSM_RET_DEFAULT(socket_getpeersec_stream))
> >> +                       return rc;
> >> +       }
> >> +       return LSM_RET_DEFAULT(socket_getpeersec_stream);
> >>  }
> >
> > I'm beginning to wonder if we shouldn't update call_int_hook() so that
> > it works for LSM_RET_DEFAULT() instead of assuming a zero/0 return
> > value.  Thoughts?
>
> call_int_hook() was intended to address the "normal" case, where all
> hooks registered would be called and the first error, if any, would
> result in an immediate failure return. Hooks that behaved in any other
> manner were expected to be open coded. The point of using the macros
> was to reduce so much code duplication. I really don't want to see
> call_int_hook() evolve into something hard to work with, or that has
> non-obvious side effects. I think we could probably integrate
> LSM_RET_DEFAULT() safely, but I'm wary of hiding these abnormal cases
> in the macro.

Yes, I'm not talking about modifying call_int_hook() to handle
something like security_vm_enough_memory_mm(), I'm just talking about
updating it use LSM_RET_DEFAULT() instead of zero.

While we are at it, we should probably get rid of the second parameter
too, @IRC, and just use the assigned LSM_RET_DEFAULT().  That always
struck me as a bug waiting to happen if/when those two fell out of
sync.

--
paul-moore.com

