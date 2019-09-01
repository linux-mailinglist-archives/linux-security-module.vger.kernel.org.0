Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4161A4B19
	for <lists+linux-security-module@lfdr.de>; Sun,  1 Sep 2019 20:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfIASXA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 1 Sep 2019 14:23:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38392 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfIASXA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 1 Sep 2019 14:23:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id h3so4013706ljb.5
        for <linux-security-module@vger.kernel.org>; Sun, 01 Sep 2019 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lEyhS2Htsx92SqNLaO9MatDnoJOsZy3L9dUpzG9H1pg=;
        b=nDqOUxTFheiEigYwVggsXll2wUavbnJLdBFUj/qyfJYNOkV9Tqp/nvYAxA8QSSy7gd
         Ps+jLT7/MsQ98P+zG0jsE9Fnn/pIiTNz/GULKJG2u0eheW3sE3gvxyjyeo6UvpkQHzQ9
         8u8Sh/+GdNej96kbAuY1CY0eN+A8afLMqP2AnX92SeDyzo2FpQ/Xu1mlfpUBZaq/PuDR
         HFzCzuA0KeApGV2iyRGaN3VFdIdM6e2qF8vYk9G2EuwlcOLlEJES088xMekuwbCYa4kv
         I0Unh1yLo/+8FuSKaxpC2IlX/JL/5dPgFrj1E8WC26itvgtRDJEPG/oiTlphwbPsXRau
         he1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lEyhS2Htsx92SqNLaO9MatDnoJOsZy3L9dUpzG9H1pg=;
        b=HIs29+EeJZOnWzoYALQyJWtMo3XwTcHHJESPaq8INOh5usuvg2iBAT8/RiZeudekuv
         xHilCU5K+p2lrANZ/6XHYFkqdpLLrnOhqEvE49UdpvbKJptvetcl389idXo+9s2a5scu
         uZEfmj0ziYK1QXKCKZdSari0S1QrXC+vDG2qMbA2JR+VNy/cJc+4GepHyjpVffEWdcUN
         zLM6BUz9wOBYXpKAn2gvQ3NL6pJPW2wBW5w1MS1+UiBpkWBj3HmO5I33TAqzFOYKMDQM
         mv4jrbdTEEzs8pfR2vVAPf+KsKqJ0C5rQIBLOBcJPEdUU0L7jqLIoecVcZW/QCMKecC6
         kbqg==
X-Gm-Message-State: APjAAAUO8XYrxpH8wde4cGRcv3Az67r29o/TrZLK8lbNWj8z5M9b8YcC
        Q8U3O5UvspH0ZrQE/I+sDXOyC2teH2usq6ipqtOd
X-Google-Smtp-Source: APXvYqyHz2GNqXe+RT3Nbiu5zT4YHu7ZJO0ITiqzOu0n5Nf4bwCefMXdsaqYWfxqTVuMMD3RYGXXKbJdybBVNZfpsFk=
X-Received: by 2002:a2e:84c5:: with SMTP id q5mr14155528ljh.158.1567362178439;
 Sun, 01 Sep 2019 11:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190901155205.16877-1-colin.king@canonical.com>
 <CAHC9VhSVKEJ-EBAry5fVN3Ux22occGQ5jxbFBecMsR+q7+UT5A@mail.gmail.com> <de0cd774-8fce-d69a-8ea4-3c7b2ee3a918@wanadoo.fr>
In-Reply-To: <de0cd774-8fce-d69a-8ea4-3c7b2ee3a918@wanadoo.fr>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 1 Sep 2019 14:22:47 -0400
Message-ID: <CAHC9VhRbJWO3rhk=090VAJOHsZer89s6VP_mFcMcoPHf-Zg4Kw@mail.gmail.com>
Subject: Re: [PATCH] netlabel: remove redundant assignment to pointer iter
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Sep 1, 2019 at 1:16 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Le 01/09/2019 =C3=A0 18:04, Paul Moore a =C3=A9crit :
>
> On Sun, Sep 1, 2019 at 11:52 AM Colin King <colin.king@canonical.com> wro=
te:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer iter is being initialized with a value that is never read and
> is being re-assigned a little later on. The assignment is redundant
> and hence can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/netlabel/netlabel_kapi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This patch doesn't seem correct to me, at least not in current form.
> At the top of _netlbl_catmap_getnode() is a check to see if iter is
> NULL (as well as a few other checks on iter after that); this patch
> would break that code.
>
> Perhaps we can get rid of the iter/catmap assignment when we define
> iter, but I don't think this patch is the right way to do it.
>
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 2b0ef55cf89e..409a3ae47ce2 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -607,7 +607,7 @@ static struct netlbl_lsm_catmap *_netlbl_catmap_getno=
de(
>   */
>  int netlbl_catmap_walk(struct netlbl_lsm_catmap *catmap, u32 offset)
>  {
> -       struct netlbl_lsm_catmap *iter =3D catmap;
> +       struct netlbl_lsm_catmap *iter;
>         u32 idx;
>         u32 bit;
>         NETLBL_CATMAP_MAPTYPE bitmap;
> --
> 2.20.1
>
> 'iter' is reassigned a value between the declaration and the NULL test, s=
o removing the fist initialisation looks good to me.

This is what I get when I try to review patches quickly while doing
other things on the weekend <sigh> ... yes, you are correct, I was
looking at _netlbl_catmap_getnode() and not netlbl_catmap_walk(); my
apologies.

--=20
paul moore
www.paul-moore.com
