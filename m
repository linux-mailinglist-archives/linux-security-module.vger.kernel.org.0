Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C064C1BB16F
	for <lists+linux-security-module@lfdr.de>; Tue, 28 Apr 2020 00:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgD0WSB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 27 Apr 2020 18:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726328AbgD0WSA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Apr 2020 18:18:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DCEC0610D5
        for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2020 15:17:59 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s9so15587826eju.1
        for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2020 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UL/KOG9jWEcCXLI+hyOZaTUXJMue/WeQvcbigSn5Ae8=;
        b=oo3D+/91hLZqWrB4onHqCW6rJJEyOlyHLO7bvwoLVFRudtP0fAigCrjLn7Z9f9n+nm
         hEj3u9hPHsKPnEOAK5Tuw7pSoz/aW6wlUwqvWWuKQicUWWuwIcCJLqvP581ltLbjJwXq
         OZCg+m65Ct4APQ+nG0JRjkiyAdNiBxEySxSDLi2sQBCxdRozmkvueShw0fcCe6b+l4on
         ME874FzMO6JJiq/29jNwepCF8CUFQ/0oH++U2iexahGpYeFxeF5ESFrEC7zY1Y/k6FJS
         35UXfU5LyfP/zCORQLzV1NRM36Verhzjd0JYwN0SKQ+mzdTKei/rMyoGin1IsrPTnGn5
         VDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UL/KOG9jWEcCXLI+hyOZaTUXJMue/WeQvcbigSn5Ae8=;
        b=dmuDexemy/agI8dyRJtpwSnruyChd/tfz3G3HkkrLUpSO/qYrQLRlF0fIcITBszJhI
         r2oKswAH6TQnDIzE08WSklrzJBC5BSKng/fzSoYpuFFe8rXbz2LguHXHt/CtCJjQgXoP
         mJYdXe68wBmjS9FXGJ8fpWfoRE1kPxjkgBk84tQx0faEJhxPGYUm27QfRVbODnZPvokM
         jEyxgbhLv5qPMeeGMuFLJ0nqmxclvmeDnQzIqTiuruM07w2Fa6vHTpyJt9nWtXvgXvsD
         t0rpMkHKWXRjyCnbfV1jvhcZ30fQkeUvfvWg1w6UvgZNEbTDHtAwJowgKMARDKLLg+TF
         JGjQ==
X-Gm-Message-State: AGi0PuaFG3QgsMsCL7+iD3iRylNhZdmMTH7KHC4lKGZQo60yhfciMAkr
        6bK01qTaQU1yBEivX6lI1WTafTb2j2O2SJNtgKj+
X-Google-Smtp-Source: APiQypKcaWzr+dqSzZiHdrMq3hOsjQyRzRtPnEHn5+cEMPnQPkQJKf6XD2ptG29hXT9B03+/SChoZBwUAP+jLwKJmYI=
X-Received: by 2002:a17:906:31da:: with SMTP id f26mr21210369ejf.308.1588025877826;
 Mon, 27 Apr 2020 15:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
 <2136640.1587472186@warthog.procyon.org.uk> <CAHC9VhQnORRaRapbb1wrUsxweJCRJ+X+RdvKw8_U0pT0fuxZ6A@mail.gmail.com>
 <3834193.1587771802@warthog.procyon.org.uk> <CAHC9VhQbhG8-ZABtkZr1FXo9cuH4_nsbB=HP_fGvW+FNQ7iAXg@mail.gmail.com>
 <355576.1587996734@warthog.procyon.org.uk> <CAEjxPJ4S0wpAtXoD1f-54qrriRC8y_hj9T5-vKOGDmf1XhOLrQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4S0wpAtXoD1f-54qrriRC8y_hj9T5-vKOGDmf1XhOLrQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Apr 2020 18:17:46 -0400
Message-ID: <CAHC9VhTSuWLheaQDXwEyELGXEJOAXoFr2--FYhiviQbDHQKhkw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix use of KEY_NEED_* instead of KEY__* perms
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 27, 2020 at 1:02 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Apr 27, 2020 at 10:13 AM David Howells <dhowells@redhat.com> wrote:

...

> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 0b4e32161b77..6087955b49d8 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6539,20 +6539,38 @@ static void selinux_key_free(struct key *k)
> >         kfree(ksec);
> >  }
> >
> > +static unsigned int selinux_keyperm_to_av(unsigned int need_perm)
> > +{
> > +       switch (need_perm) {
> > +       case KEY_NEED_VIEW:     return KEY__VIEW;
> > +       case KEY_NEED_READ:     return KEY__READ;
> > +       case KEY_NEED_WRITE:    return KEY__WRITE;
> > +       case KEY_NEED_SEARCH:   return KEY__SEARCH;
> > +       case KEY_NEED_LINK:     return KEY__LINK;
> > +       case KEY_NEED_SETATTR:  return KEY__SETATTR;
> > +       default:
>
> Possibly WARN() or BUG() here?  Or BUILD_BUG_ON(KEY_NEED_ALL != 0x3f)
> to force an update here
> whenever a new key permission is defined?

My vote is for a build time check via BUILD_BUG_ON() or similar
mechanism.  It's worked really well in other places, I'm thinking
specifically of the SELinux netlink mapping.

> > +               return 0;
> > +       }
> > +}
> > +
> >  static int selinux_key_permission(key_ref_t key_ref,
> >                                   const struct cred *cred,
> > -                                 unsigned perm)
> > +                                 unsigned need_perm)
> >  {
> >         struct key *key;
> >         struct key_security_struct *ksec;
> > +       unsigned int perm;
> >         u32 sid;
> >
> >         /* if no specific permissions are requested, we skip the
> >            permission check. No serious, additional covert channels
> >            appear to be created. */
> > -       if (perm == 0)
> > +       if (need_perm == 0)
> >                 return 0;
> >
> > +       perm = selinux_keyperm_to_av(need_perm);
> > +       if (perm == 0)
> > +               return -EACCES;
>
> We should log or audit some kind of message here, whether via WARN(),
> audit_log(), or something, to avoid silent denials.

Assuming we add a build time check (see above), I think a WARN here is okay.

-- 
paul moore
www.paul-moore.com
