Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336BB17CAA0
	for <lists+linux-security-module@lfdr.de>; Sat,  7 Mar 2020 03:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCGCHN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 6 Mar 2020 21:07:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34923 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgCGCHN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Mar 2020 21:07:13 -0500
Received: by mail-ed1-f67.google.com with SMTP id cq8so4762011edb.2
        for <linux-security-module@vger.kernel.org>; Fri, 06 Mar 2020 18:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GjY5e+lHhatPDqpG8o3yF+dJMsuR7jKxa+CG4tl8N+Q=;
        b=MYZcLVVt6Fi7b+TC0fhNPZEu9g299cEFzx0BgfZepGviPlvMGgOTwc3tZ9n0srhQwA
         SlDP1WCYwjX7C7BmjqnPApeLay93L7O+EGlDopCtKD1xg/sSqj21MNSowvTQ6SMY+Asb
         IhRjjHso0l4j0Z/WP1k8zGjWbXPrKrxguWjMDWc7gLf8OIbWluYbBX1mvrpnJJCFCWsE
         t96XqjabVWS1b1EdPyEpNa4fLvaqoBgLNuCuCEuAm+yIkjDRk6Il2MZlkPQ/Af1VMiet
         QSaoLqi0mv8YIM6W9ndz2Ww8i/PpL6M7eCt86/wXhYiOTzXjV9qoLMHLL40BNGv16wJ3
         ZCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GjY5e+lHhatPDqpG8o3yF+dJMsuR7jKxa+CG4tl8N+Q=;
        b=G1PeutzHHQlzCBJNJ8PA/BJU5JgixcGHI17gj3YyLDVCaDnXz9qDPpBU3eO8FNI4AF
         Eyy7z9KvoB62AJhsZQcbhLWBnVM7WQMdvu1UPLR8Ig229zlKNmoGHRUl8JLsRC8+YMt4
         oOO9cuAdipliONIrin7NyiHZ+s+Hnujb4Byf3DHbVHsbGApoA5891zmkTRfv2JO56SPj
         zSa4TjSS23kzm1I3A2yZ47pAYVIVCvwuAPbvQl0hS64P0GlcEw+eAVq2uCWLHttyP7mm
         jjHYuwGK681BeO3EZLGInPpfGmZWh2gZlYSoqqWHvnuBp4iqP4doJIm9jJyYt2QsUvVl
         F8bw==
X-Gm-Message-State: ANhLgQ240nQtZOdjL5+JMkdUaLacnF0Fl70ToCClitNmplkuTZ7KUYdi
        XjTf5hERVWauRnV674M2AA1ie+xNOxUmRNdGWCgP
X-Google-Smtp-Source: ADFU+vtJn85mz16eKM0VVcPXhQEEmYDy3egAXAD5Lh4boeDEuekd5TltvTG1x/gd/PW45UCarT2Ei6NwitLXoYdU64g=
X-Received: by 2002:aa7:c1d3:: with SMTP id d19mr6291442edp.12.1583546830295;
 Fri, 06 Mar 2020 18:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20200214234203.7086-1-casey@schaufler-ca.com> <20200214234203.7086-18-casey@schaufler-ca.com>
In-Reply-To: <20200214234203.7086-18-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Mar 2020 21:06:59 -0500
Message-ID: <CAHC9VhR0uQq0npYA6L4DU346Oc_7=wvpjLF5r_WqXZhCk+rnPg@mail.gmail.com>
Subject: Re: [PATCH v15 17/23] LSM: security_secid_to_secctx in netlink netfilter
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 14, 2020 at 6:44 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> Change netlink netfilter interfaces to use lsmcontext
> pointers, and remove scaffolding.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: netdev@vger.kernel.org
> ---
>  net/netfilter/nfnetlink_queue.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index 7e91f3c10b29..e0512e91fed9 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -629,10 +627,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>         }
>
>         nlh->nlmsg_len = skb->len;
> -       if (seclen) {
> -               lsmcontext_init(&scaff, secdata, seclen, 0);
> -               security_release_secctx(&scaff);
> -       }
> +       if (seclen)
> +               security_release_secctx(&context);
>         return skb;
>
>  nla_put_failure:
> @@ -640,10 +636,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>         kfree_skb(skb);
>         net_err_ratelimited("nf_queue: error creating packet message\n");
>  nlmsg_failure:
> -       if (seclen) {
> -               lsmcontext_init(&scaff, secdata, seclen, 0);
> -               security_release_secctx(&scaff);
> -       }
> +       if (seclen)
> +               security_release_secctx(&context);
>         return NULL;
>  }

It feels like we should be converting nfqnl_build_packet_message() and
nfqnl_get_sk_secctx() as well, but perhaps that is coming in a later
patch in the patchset (although there are only six left).

-- 
paul moore
www.paul-moore.com
