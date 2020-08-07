Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901D423F289
	for <lists+linux-security-module@lfdr.de>; Fri,  7 Aug 2020 20:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgHGSKK (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 7 Aug 2020 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGSKJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Aug 2020 14:10:09 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17DBC061756
        for <linux-security-module@vger.kernel.org>; Fri,  7 Aug 2020 11:10:08 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q4so1870319edv.13
        for <linux-security-module@vger.kernel.org>; Fri, 07 Aug 2020 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1STpBYwfz2s2WvBbqzcmi5iVPWegrSjSTiq6diCLE0=;
        b=adiHvInBWjgTG7ebG6Nb7+yfwAmRWTX0Gu4VAA0C7dmQ5tmWJ72b391yWTw74tuIxn
         wAWSKl7+zGI9g88Sr8DbaNomX6664PPAgPIsl79IxDYXRY4kSJOlj0lcGlo5gru5tM0o
         ifRoW0m1BO2ksF/n5/LDlJwDq9DUGYbcgsrM4AeWLJUoCGxC2zWGJiWI22ol2J2jrIjK
         3H1neTwB4+KEZYqSHyvAjYKgYR4eUUXJYz1TThLXKZbOaq9urhKA8T4VYJ3eyCsZSQbw
         /btfeKxDK4J/LPqhrRg9ROeObqN0cPj7PZ2Q7PPZQ4apZaH2jEB0AvGxCZpd2AqvwM3U
         g9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1STpBYwfz2s2WvBbqzcmi5iVPWegrSjSTiq6diCLE0=;
        b=a2KlJNqR0gXca4PL9FsS6aD8dHSgK3GcPPBoCG0Z+fPIAp/j4ej92Es1LzgqweysJq
         1gbU9JafvFJSqag3aQ6ITgSI+G0H4SzXk301/4MnTrLMo5y1GFaCBhTM6uWlYG2RuCYh
         cp4IVY5MxVpiX42qHLppef567BLPtPPemeM0LuMmAmVZmxaKpPF1fO3Aq6rmDLNMnpcX
         6sARLqBFLWbq0eWgjjI1WzSHaW88qHn9KaigbV5d+DFc4Qr67Hy8x/1vKgVAmXoRUoAx
         qx3/Sz7dlhY1WpO58kDt/JHYWc3sNLnI/KXV2g3N6Jm7iS96DuMH4PSf/bdRxwgE/iW3
         GrjA==
X-Gm-Message-State: AOAM533fvGg+7zjuKx4VKkcEp/rFvzWR65PoAfxnzEE/bhnm4P0tWcoh
        hb4bRj6d+QIVkoIJthYgOTn0OGJLP68OIyu58W2h
X-Google-Smtp-Source: ABdhPJysL55Ns6Iw5owOS+YKPOXkwqm66Dgs9N0+aS8afD0Z1MBv6J2wu3k8CLxKxBx0ZlKlEvxZeZykbP0lN5ns06M=
X-Received: by 2002:aa7:c383:: with SMTP id k3mr9747989edq.164.1596823807375;
 Fri, 07 Aug 2020 11:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200807165134.3913-1-rdunlap@infradead.org>
In-Reply-To: <20200807165134.3913-1-rdunlap@infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 7 Aug 2020 14:09:56 -0400
Message-ID: <CAHC9VhQW-8pem59QHQctx9UNhMNLEAjNwDiOU1ODz9wX5B_tdQ@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: delete repeated words in comments
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 7, 2020 at 12:51 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Drop a repeated word in comments.
> {open, is, then}
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: selinux@vger.kernel.org
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> ---
>  security/selinux/hooks.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

This obviously looks fine, but it will need to wait until after the
merge window closes.  I'll send another reply once it is merged.

> --- linux-next-20200731.orig/security/selinux/hooks.c
> +++ linux-next-20200731/security/selinux/hooks.c
> @@ -1978,7 +1978,7 @@ static inline u32 file_to_av(struct file
>  }
>
>  /*
> - * Convert a file to an access vector and include the correct open
> + * Convert a file to an access vector and include the correct
>   * open permission.
>   */
>  static inline u32 open_file_to_av(struct file *file)
> @@ -4444,7 +4444,7 @@ static int selinux_skb_peerlbl_sid(struc
>   *
>   * If @skb_sid is valid then the user:role:type information from @sk_sid is
>   * combined with the MLS information from @skb_sid in order to create
> - * @conn_sid.  If @skb_sid is not valid then then @conn_sid is simply a copy
> + * @conn_sid.  If @skb_sid is not valid then @conn_sid is simply a copy
>   * of @sk_sid.  Returns zero on success, negative values on failure.
>   *
>   */
> @@ -5314,7 +5314,7 @@ static int selinux_sctp_bind_connect(str
>
>                         /* As selinux_sctp_bind_connect() is called by the
>                          * SCTP protocol layer, the socket is already locked,
> -                        * therefore selinux_netlbl_socket_connect_locked() is
> +                        * therefore selinux_netlbl_socket_connect_locked()
>                          * is called here. The situations handled are:
>                          * sctp_connectx(3), sctp_sendmsg(3), sendmsg(2),
>                          * whenever a new IP address is added or when a new



-- 
paul moore
www.paul-moore.com
