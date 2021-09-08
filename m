Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4484A403595
	for <lists+linux-security-module@lfdr.de>; Wed,  8 Sep 2021 09:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350809AbhIHHin (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 8 Sep 2021 03:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350563AbhIHHig (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Sep 2021 03:38:36 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6858AC0613C1
        for <linux-security-module@vger.kernel.org>; Wed,  8 Sep 2021 00:37:29 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id t19so450123vkk.2
        for <linux-security-module@vger.kernel.org>; Wed, 08 Sep 2021 00:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxByYRg2XXqbg48iaJnwshxIX8ARRbQbbWyTDrsMpDg=;
        b=JtC8vxGN7eRYHrK74+0gnNKbyBQ6ygwCoAYMm88H5oYJZgf0QTejxJoGm/EWBYMNI2
         u74hLHaovlTxOuAO53GNWUjTNPZS1gCwm0TDI/ZJUB4HeCswQastk9SHPqMEB61BUjNC
         DierBZIFFkUSg8nBXL8zZskDsijYbJLqKYVig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxByYRg2XXqbg48iaJnwshxIX8ARRbQbbWyTDrsMpDg=;
        b=x8u+JuJT35iOlU8oqE8+1RJYkm+bR2ZaclRmj71e3Fhx1QNLBtp05hhJJ0lBb8nk/b
         XCFNComgWrCeP/nMk3py+Ye50s327VXvcf/FweZRyCeA+xzx8lc1GWrddpzBP46YMeVL
         SK9D1xv/o6mCSKl7oTmXcBf+27oGCMjo74JaiHOzQAe98INVIZYWSgA/8psge+FZDVcB
         maCZ/65qjdXZJE2RiMiPsZUBofzbHlUrAX6hMpu62ng4snQYHnwjb1d73T2DFaH4OM6Y
         oKRQ9nQC0l3urZOXhIsfp6mS6cy51rAGo0AQLehUYIy2dhqiM35IDrwm6JfXZ4HOu6zW
         nmXw==
X-Gm-Message-State: AOAM5328MkRTeb8j+0LG/h28t/Wa+YnVXNnZlicZu3tkMUOaICFeUNGU
        Wwmev9c/rcU9/NTJezsVSpMU8pSP+BvFaqZJXrFvnQ==
X-Google-Smtp-Source: ABdhPJzIbNRikobIOOunmSW5bp+DYjiJjzAzKNlWichoE9SwXSEqDDtjTORr8+/U3/M9/5256zkNoLf4zkFpLQ7XPiI=
X-Received: by 2002:a1f:a348:: with SMTP id m69mr216744vke.10.1631086648497;
 Wed, 08 Sep 2021 00:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <CAHc6FU4foW+9ZwTRis3DXSJSMAvdb4jXcq7EFFArYgX7FQ1QYg@mail.gmail.com>
 <YTYoEDT+YOtCHXW0@work-vm> <CAJfpegvbkmdneMxMjYMuNM4+RmWT8S7gaTiDzaq+TCzb0UrQrw@mail.gmail.com>
 <YTfcT1JUactPhwSA@redhat.com>
In-Reply-To: <YTfcT1JUactPhwSA@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 8 Sep 2021 09:37:17 +0200
Message-ID: <CAJfpegumUMsQ1Zk4MjnSXhrcnX_RJfM5LJ2oL6W3Um_wFNPRFQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        "Fields, Bruce" <bfields@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 7 Sept 2021 at 23:40, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Sep 06, 2021 at 04:56:44PM +0200, Miklos Szeredi wrote:
> > On Mon, 6 Sept 2021 at 16:39, Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> >
> > > IMHO the real problem here is that the user/trusted/system/security
> > > 'namespaces' are arbitrary hacks rather than a proper namespacing
> > > mechanism that allows you to create new (nested) namespaces and associate
> > > permissions with each one.
> >
> > Indeed.
> >
> > This is what Eric Biederman suggested at some point for supporting
> > trusted xattrs within a user namespace:
> >
> > | For trusted xattrs I think it makes sense in principle.   The namespace
> > | would probably become something like "trusted<ns-root-uid>.".
> >
> > Theory sounds simple enough.  Anyone interested in looking at the details?
>
> So this namespaced trusted.* xattr domain will basically avoid the need
> to have CAP_SYS_ADMIN in init_user_ns, IIUC.  I guess this is better
> than giving CAP_SYS_ADMIN in init_user_ns.

That's the objective, yes.  I think the trick is getting filesystems
to store yet another xattr type.

Thanks,
Miklos
