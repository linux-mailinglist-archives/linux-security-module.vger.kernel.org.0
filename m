Return-Path: <linux-security-module+bounces-6014-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059BF997826
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Oct 2024 00:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B483E283A10
	for <lists+linux-security-module@lfdr.de>; Wed,  9 Oct 2024 22:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8051E230C;
	Wed,  9 Oct 2024 22:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G9kM3YPp"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06871E0489
	for <linux-security-module@vger.kernel.org>; Wed,  9 Oct 2024 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728511377; cv=none; b=CrVeUnO8GOJXZoHXmRBUY/SODgDanmgxkgTZhOxYuRJVl8FBjqOFrD54ITVGILNHHDVAWT7O18MODlddDkhQTeKTKeUV3vx/2/0JtTKcKouTEAt/noQVN08TPeP/xQI72fNRCkwA/Ua1C01jI1w6+nz4UHPmQbkKJglwEfq0xho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728511377; c=relaxed/simple;
	bh=uZxY76m36ydLtto+ybFprLgpvUQq3up5tcHkr6TI6eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bl0bA3sFa071R1wS2UiJdhfveyI1n3RVAAsZ+A5QxuZtRFJrL0UFEhu3Seq0l4b1Wuws2zkEfjbe0Kj8fNgMAr80w8r7i6DWtnUUm5JIn4VmENzXo5U9u666/IPHHYzAmCy1+REnWDX2nGCM5VLAJH0BHFLJx1yi8Y0ObGdN124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G9kM3YPp; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso266261276.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Oct 2024 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728511375; x=1729116175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qALeGv0lrJMi11SU4W4SJLWzuz/xtDH2PNt93jl4Qu0=;
        b=G9kM3YPp9bL6B52kT7rJeGOWinOt1yjMDHhQRztJguXcw0jHVefIgME54gtjrc5ye6
         OA6b+ty0PnLoAQvOQmk4DzQqKI+jPadjfU8Jhb9YrCAtc9mX9gahlAN9nf0hW/PFlDzH
         tFkXluKxDDm2ssCoiKUfUKMz1kFb6j5S6zBwviRsZQ1Cqi5B6E6s9B0F1YOSeKUZgHol
         QRxiNjP5i2L4CA3NsiOuXSm3T4fDbNlL/tD1Q9GkclUbV2DyfOM+JPO/ikR1NqKUimK6
         ggllE1I/v6dRZk8GFZFU6TOunreyTJEla7i3jTfU7cd9WqSUUN0K6UY8j25Za7Va9veB
         Z6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728511375; x=1729116175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qALeGv0lrJMi11SU4W4SJLWzuz/xtDH2PNt93jl4Qu0=;
        b=J5+zBHnJ7P7X3mCQe8SS+cKt+j0v/pUuJQqcQHwAMcRxZlkW3xYEjJ+bBtg3w/ZMfQ
         6GwxX5qDvsJRdBIBSGK3ZYTpF/JcUZvRmYeNthqBSQJRaav94+9CJ8hmqJuTY/XsfmfJ
         wcwdSr7ws2vUZSLtnY5OBYdTD2xmtTW7dfkE6bDcoeaZCOnMyUUd9DDFNxe9y4luuL0X
         hGfTa81p0TldqM7FTVbytfwvjlEkXcc/8DErGr7gqS2pbfjSrjz7PVM4Zn6DxtuXvJ3A
         hMpENv+E/VmS6hPRWjlxB/zwSTF55nZHKT/QwdNib0+qDke0UeAIJB9Hj48/HcouLCZO
         JyKw==
X-Forwarded-Encrypted: i=1; AJvYcCUYqtTSRZ6bmkiJ6DXlnyt/bz9z5T+YWaxipQCqRHPpXz8pFjLtRP4csprxy4XLU1cHeBOoKtgFgzWUBnTjxKu32ovvwEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdqpEAl4yG8K08shcdG/lhEIgC+2UAdFWAjVq4HE6wVEOkST6X
	Hq43MG+gPeAJYOWYEqavFP6TnJ0FAeGGCmU8HCNdoHKiAPg4fOMaGSnlvV55M6puPuG4YK4pxKF
	e3sXGvqttXY5scmm8CJj9lri5mXY0pqnu4YDL
X-Google-Smtp-Source: AGHT+IG1hXmGzW6t4TPA1Xvx/ba3I0vLTALPaDTo/4Z8b9Pf7FLaaDUI4r/rqTzCQTCNGBbiARVnORqzWvm00b3PHNQ=
X-Received: by 2002:a05:690c:5083:b0:6e3:3227:ec64 with SMTP id
 00721157ae682-6e33227eff0mr792437b3.35.1728511374654; Wed, 09 Oct 2024
 15:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009203218.26329-1-richard@nod.at>
In-Reply-To: <20241009203218.26329-1-richard@nod.at>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Oct 2024 18:02:44 -0400
Message-ID: <CAHC9VhSbAM3iWxhO+rgJ0d0qOtrSouw0McrjstuP5xQw3=A35Q@mail.gmail.com>
Subject: Re: [PATCH] netfilter: Record uid and gid in xt_AUDIT
To: Richard Weinberger <richard@nod.at>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, 
	kadlec@netfilter.org, pablo@netfilter.org, rgb@redhat.com, 
	upstream+net@sigma-star.at, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 4:33=E2=80=AFPM Richard Weinberger <richard@nod.at> =
wrote:
>
> When recording audit events for new outgoing connections,
> it is helpful to log the user info of the associated socket,
> if available.
> Therefore, check if the skb has a socket, and if it does,
> log the owning fsuid/fsgid.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  net/netfilter/xt_AUDIT.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
> index b6a015aee0cec..d88b5442beaa6 100644
> --- a/net/netfilter/xt_AUDIT.c
> +++ b/net/netfilter/xt_AUDIT.c
> @@ -9,16 +9,19 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>  #include <linux/audit.h>
> +#include <linux/cred.h>
> +#include <linux/file.h>
> +#include <linux/if_arp.h>
>  #include <linux/module.h>
>  #include <linux/skbuff.h>
>  #include <linux/tcp.h>
>  #include <linux/udp.h>
> -#include <linux/if_arp.h>
>  #include <linux/netfilter/x_tables.h>
>  #include <linux/netfilter/xt_AUDIT.h>
>  #include <linux/netfilter_bridge/ebtables.h>
> -#include <net/ipv6.h>
>  #include <net/ip.h>
> +#include <net/ipv6.h>
> +#include <net/sock.h>
>
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Thomas Graf <tgraf@redhat.com>");
> @@ -66,7 +69,9 @@ static bool audit_ip6(struct audit_buffer *ab, struct s=
k_buff *skb)
>  static unsigned int
>  audit_tg(struct sk_buff *skb, const struct xt_action_param *par)
>  {
> +       struct sock *sk =3D skb->sk;
>         struct audit_buffer *ab;
> +       bool got_uidgid =3D false;
>         int fam =3D -1;
>
>         if (audit_enabled =3D=3D AUDIT_OFF)
> @@ -99,6 +104,24 @@ audit_tg(struct sk_buff *skb, const struct xt_action_=
param *par)
>         if (fam =3D=3D -1)
>                 audit_log_format(ab, " saddr=3D? daddr=3D? proto=3D-1");
>
> +       if (sk && sk_fullsock(sk)) {
> +               read_lock_bh(&sk->sk_callback_lock);
> +               if (sk->sk_socket && sk->sk_socket->file) {
> +                       const struct file *file =3D sk->sk_socket->file;
> +                       const struct cred *cred =3D file->f_cred;
> +
> +                       audit_log_format(ab, " uid=3D%u gid=3D%u",
> +                                        from_kuid(&init_user_ns, cred->f=
suid),
> +                                        from_kgid(&init_user_ns, cred->f=
sgid));

[CC'ing the audit and LSM lists for obvious reasons]

If we're logging the subjective credentials of the skb's associated
socket, we really should also log the socket's LSM secctx similar to
what we do with audit_log_task() and audit_log_task_context().
Unfortunately, I don't believe we currently have a LSM interface that
return the secctx from a sock/socket, although we do have
security_inode_getsecctx() which *should* yield the same result using
SOCK_INODE(sk->sk_socket).

I should also mention that I'm currently reviewing a patchset which is
going to add proper support for multiple LSMs in audit which will
likely impact this work.

https://lore.kernel.org/linux-security-module/20241009173222.12219-1-casey@=
schaufler-ca.com/

> +                       got_uidgid =3D true;
> +               }
> +               read_unlock_bh(&sk->sk_callback_lock);
> +       }
> +
> +       if (!got_uidgid)
> +               audit_log_format(ab, " uid=3D? gid=3D?");
> +
>         audit_log_end(ab);
>
>  errout:
> --
> 2.35.3

--=20
paul-moore.com

