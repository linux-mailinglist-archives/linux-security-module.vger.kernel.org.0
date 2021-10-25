Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15CD4390C7
	for <lists+linux-security-module@lfdr.de>; Mon, 25 Oct 2021 10:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJYIET (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 25 Oct 2021 04:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbhJYIEQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Oct 2021 04:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635148914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/55QYc9SmLAH1YqdAjq//4PlmEqSr7pH2lLIRYOw0U=;
        b=gr7/9pLzgy4HJjt0JmpSDm3C8EC3J16umN5LTM20VDr5V3+beSWobuQryATUtKx7y4drHu
        GtU01vWvizbD5/Oap1f31T8Mzk8dZjh7DDFtcj5bnfCXFyYv+jl8hDVA5vAmkFQs5BQVMr
        qnSFu2IU6ogK2lUD52Adwi7AQUkm1is=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-_00mbLPYNT-j10YtH7S8cA-1; Mon, 25 Oct 2021 04:01:51 -0400
X-MC-Unique: _00mbLPYNT-j10YtH7S8cA-1
Received: by mail-yb1-f200.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso16420821ybj.1
        for <linux-security-module@vger.kernel.org>; Mon, 25 Oct 2021 01:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/55QYc9SmLAH1YqdAjq//4PlmEqSr7pH2lLIRYOw0U=;
        b=eA2Oqwch4kCTcA4LKE4kvrWWhDbHPPv9PZjDzv7dbWZgM0JB7lkjiTdHSz6UCHCYoM
         ZiwzfXHDQzMUBF3QlNZTi1DhImy6+KN3qZcaGmk7CpEeotOtqFcRk0hFf8jU8mof8sc6
         GUJYM0XjMSp/DATJsIyeN+sNx8xzEXq8Za1zpeHdYUPmK4ILIfO/PQRoLZHlFXxyIsXe
         jUyQ7EYzYC+rOlVPiKQivWsc8OMy7obLyVFzjSWVzIxopb7cbC6Gzv+wh9Qv77b/JcgM
         XqCva+txyg2y+pavkAmAqsDyV3gEknmPAq9pxViec9s3DvNeY8s0ARMlyG/2WmZUxqLA
         eKFw==
X-Gm-Message-State: AOAM5314c/JwXUFjJq28rx4btln6akiCdw3bbbhEO1aOngkPAiD3HJPK
        DifXy3BHavsC0Mpfl5t7vK914w5KMyIfZAh4Bu/dQKCFz7/3EHE7H0KBL+lCtE9o6PPlpOUI65C
        STLbBuibfjUTIwDKNQO9Cu0nEEnY/KXbzNybHqNpEGh/Y2G90ob0A
X-Received: by 2002:a25:7310:: with SMTP id o16mr9223867ybc.513.1635148910301;
        Mon, 25 Oct 2021 01:01:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpnriUf5NaXg+lWb6WoAbqacH/1ek8P0At+48BPb04YWL4EBno1p6M6bdb1k7pIqCQeFnJMfBV9vt7+VYoPmk=
X-Received: by 2002:a25:7310:: with SMTP id o16mr9223852ybc.513.1635148910138;
 Mon, 25 Oct 2021 01:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634884487.git.lucien.xin@gmail.com> <71602ec3cff6bf67d47fef520f64cb6bccba928c.1634884487.git.lucien.xin@gmail.com>
In-Reply-To: <71602ec3cff6bf67d47fef520f64cb6bccba928c.1634884487.git.lucien.xin@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Oct 2021 10:01:39 +0200
Message-ID: <CAFqZXNvsXW7-4iD+ErKWX9c9YJ42WJHwcjQJMupVO+tbyeod1g@mail.gmail.com>
Subject: Re: [PATCH net 3/4] security: add sctp_assoc_established hook
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 22, 2021 at 8:36 AM Xin Long <lucien.xin@gmail.com> wrote:
>
> security_sctp_assoc_established() is added to replace
> security_inet_conn_established() called in
> sctp_sf_do_5_1E_ca(), so that asoc can be accessed in security
> subsystem and save the peer secid to asoc->peer_secid.
>
> Fixes: 72e89f50084c ("security: Add support for SCTP security hooks")
> Reported-by: Prashanth Prahlad <pprahlad@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  Documentation/security/SCTP.rst | 22 ++++++++++------------
>  include/linux/lsm_hook_defs.h   |  2 ++
>  include/linux/lsm_hooks.h       |  5 +++++
>  include/linux/security.h        |  8 ++++++++
>  net/sctp/sm_statefuns.c         |  2 +-
>  security/security.c             |  7 +++++++
>  6 files changed, 33 insertions(+), 13 deletions(-)
[...]
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a16407444871..11cdddf9685c 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1423,6 +1423,8 @@ int security_sctp_bind_connect(struct sock *sk, int optname,
>                                struct sockaddr *address, int addrlen);
>  void security_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk,
>                             struct sock *newsk);
> +void security_sctp_assoc_established(struct sctp_association *asoc,
> +                                    struct sk_buff *skb);
>
>  #else  /* CONFIG_SECURITY_NETWORK */
>  static inline int security_unix_stream_connect(struct sock *sock,
> @@ -1642,6 +1644,12 @@ static inline void security_sctp_sk_clone(struct sctp_association *asoc,
>                                           struct sock *newsk)
>  {
>  }
> +
> +static inline void security_sctp_assoc_established(struct sctp_association *asoc,
> +                                                  struct sk_buff *skb)
> +{
> +       return 0;

It has now been pointed out by the kernel robot as well, but you are
returning a value from a function with return type void here.

> +}
>  #endif /* CONFIG_SECURITY_NETWORK */
>
>  #ifdef CONFIG_SECURITY_INFINIBAND
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index b818532c3fc2..5fabaa54b77d 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -946,7 +946,7 @@ enum sctp_disposition sctp_sf_do_5_1E_ca(struct net *net,
>         sctp_add_cmd_sf(commands, SCTP_CMD_INIT_COUNTER_RESET, SCTP_NULL());
>
>         /* Set peer label for connection. */
> -       security_inet_conn_established(ep->base.sk, chunk->skb);
> +       security_sctp_assoc_established((struct sctp_association *)asoc, chunk->skb);
>
>         /* RFC 2960 5.1 Normal Establishment of an Association
>          *
> diff --git a/security/security.c b/security/security.c
> index b0f1c007aa3b..4b2b4b5beb27 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2387,6 +2387,13 @@ void security_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk,
>  }
>  EXPORT_SYMBOL(security_sctp_sk_clone);
>
> +void security_sctp_assoc_established(struct sctp_association *asoc,
> +                                    struct sk_buff *skb)
> +{
> +       call_void_hook(sctp_assoc_established, asoc, skb);
> +}
> +EXPORT_SYMBOL(security_sctp_assoc_established);
> +
>  #endif /* CONFIG_SECURITY_NETWORK */
>
>  #ifdef CONFIG_SECURITY_INFINIBAND
> --
> 2.27.0
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

