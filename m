Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A541970E39
	for <lists+linux-security-module@lfdr.de>; Tue, 23 Jul 2019 02:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfGWAgT (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 22 Jul 2019 20:36:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36756 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbfGWAgT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jul 2019 20:36:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id q26so28033494lfc.3
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jul 2019 17:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1qLox/HcKqaARh5nCdyrjblfDl+n5sFe9PDB624/uQ=;
        b=eYCyZD6+ZuS/vB5TpYkBQYdKK5kd/jAesT2uuum+J1rP8+F3tiaJNaHOM+OvjFJDG7
         uyATfkYBrP90hc/NdWXf2hUkpuNxNzNetlz/kRTIFKRObov3+7X5p8wuG52iS8nnvPkR
         YTmISBefoo5i53nN3wMEnKTAOaVfnLWq93v+NfwsCgIzjejDXAxplDvUw25W/orQuqAO
         FGp6wzvEcIMvgx0GkySU0cKoMKt4d6zWjmQ2cm0MUSIzIRT8Jku/LWMDQTWkozOiTlYX
         VRcf1qdMDEESplMOLNSnS2NS6S8uADE6jrv7pW+uFESXyEazFYl/WuFdYQKaEphIibCh
         41jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1qLox/HcKqaARh5nCdyrjblfDl+n5sFe9PDB624/uQ=;
        b=PIwKx/is8OTxdUxyX1FAanwCEaMZ7r2miG0dhvkYb+DjBpQeS1RXDeraPT5v128otz
         HL8/bL6NVpSW8tkgdBD8VdAxwUCf51dYRRtek0XqmpXJe1NIkkRerAzF4+ri9C9Radww
         9ICz0p1XqP8NWNsGHBgQWFUpTZIy5xNGMJdBRqzibxnWQalG8ONLSW6jEhdvg9ZAuFZJ
         0WzQolCzfL+urXeXB4peutFFEtCWxoQabL6ZnEB5AJ8d+3bciPWSfYGV35k78WTY/PWA
         gap10/YjpO4+fsjhCWEAis9TREsupRyb8oie2oJEuaKS7CJ7+stZw9PQ9cweBQE4v9zl
         03MQ==
X-Gm-Message-State: APjAAAXBngSfanYaUB2fbGfgze0k08qH4RDFTLWasNtNgzKCyd9Y9MBR
        TTihga70gSVBGzgoc8g+/nS/qDChDXyUEy/DKg==
X-Google-Smtp-Source: APXvYqzoUjfQZm+IXQbdMcOuDKAltzsj6XLnjHXuqPGc8HA3CrakVkrDK/T3HMwcmv9vyX3yUlvdz45JWRZ28K7TVvw=
X-Received: by 2002:ac2:4c37:: with SMTP id u23mr19426864lfq.119.1563842177418;
 Mon, 22 Jul 2019 17:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190722132111.25743-1-omosnace@redhat.com> <201907220949.AFB5B68@keescook>
In-Reply-To: <201907220949.AFB5B68@keescook>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Jul 2019 20:36:06 -0400
Message-ID: <CAHC9VhSpwafSdcX97VPiy1Earns4UOBjywcM9R=j24KFUtWB8g@mail.gmail.com>
Subject: Re: [PATCH] selinux: check sidtab limit before adding a new entry
To:     Kees Cook <keescook@chromium.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        NitinGote <nitin.r.gote@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 22, 2019 at 12:50 PM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jul 22, 2019 at 03:21:11PM +0200, Ondrej Mosnacek wrote:
> > We need to error out when trying to add an entry above SIDTAB_MAX in
> > sidtab_reverse_lookup() to avoid overflow on the odd chance that this
> > happens.
> >
> > Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Is this reachable from unprivileged userspace?

I believe it's reachable via selinuxfs under /sys/fs/selinux/context,
and the DAC permissions are for the relevant files are 0666, but the
SELinux policy might restrict that.

> > ---
> >  security/selinux/ss/sidtab.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> > index e63a90ff2728..54c1ba1e79ab 100644
> > --- a/security/selinux/ss/sidtab.c
> > +++ b/security/selinux/ss/sidtab.c
> > @@ -286,6 +286,11 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
> >               ++count;
> >       }
> >
> > +     /* bail out if we already reached max entries */
> > +     rc = -ENOMEM;
> > +     if (count == SIDTAB_MAX)
>
> Do you want to use >= here instead?

Yes, definitely.

-- 
paul moore
www.paul-moore.com
