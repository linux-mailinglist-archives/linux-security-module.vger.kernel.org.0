Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F93D2FCBDE
	for <lists+linux-security-module@lfdr.de>; Wed, 20 Jan 2021 08:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbhATHlB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 20 Jan 2021 02:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbhATHkk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Jan 2021 02:40:40 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A03EC0613D6
        for <linux-security-module@vger.kernel.org>; Tue, 19 Jan 2021 23:39:51 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id u22so1203405vke.9
        for <linux-security-module@vger.kernel.org>; Tue, 19 Jan 2021 23:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUaAld+7PlVuBg6y2NQxllJPdU7rN5fhUZHbRArJm2Y=;
        b=ahvlTktyt5QECQ7ao3XTiHPAajLjWlC1X23RksKxj9quUyIyi6ILEaGj+Zez2VgIEk
         FxQFC+jSl1dmJmwQSp8sO/qEnB5YwxKwK5rAJQL7HsFgpP3rkvOEM6/pDSzuVwyo1f1y
         N27jXlR6oEBpfbksqHzmNNRDHk2ZprG03G5b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUaAld+7PlVuBg6y2NQxllJPdU7rN5fhUZHbRArJm2Y=;
        b=dSHst0rUQIUfuCPECdhp6Kfp/z7u21c3YdZbIeq2Je7/SqzVUbc9PJLLj4ZZ0PkQlv
         qiobddwk9O+KRI1fT+oxh6GlqUKMWOsuafHrYrGiDJid/1i7FXslybVTO//kScZY00M9
         H5in/9wpUHB4OjE/OnmsKnZUQo4hhNb8xmAUxhvxzBmWVkAUCarL13npKa30mwkO2gd0
         Q0M/QgT4GzfJsGADr5xLyqzQrn75cUDz0W9rYvTW//vjaOPZxqCxLdq0D3/1mlHHYqQZ
         MhRg/Pl0UxpYduklHXUefvHv+Jt0JvV/V9Qww9oQhzDTq92iLU6UFqPEcq1lcv3n50mP
         sTlQ==
X-Gm-Message-State: AOAM533Qq5I7JQPaU6aowis33Cziz/AWDJ10QGOzFAHtl1cGDE9/6amt
        OQIg0HMEuO98gj3SLDzPBun0ybq/i+MvgDJnf8OyrQ==
X-Google-Smtp-Source: ABdhPJxShMDCebz+BhaZwQUtaF/FMwTNyrAirvhIZqreLahBtuMVI+fIoCzbuAkc9Jh3F6ZuZLnKT+5lMhMhECOWtS8=
X-Received: by 2002:a1f:410c:: with SMTP id o12mr5750549vka.19.1611128390259;
 Tue, 19 Jan 2021 23:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20210119162204.2081137-1-mszeredi@redhat.com> <87y2go8wg9.fsf@x220.int.ebiederm.org>
In-Reply-To: <87y2go8wg9.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Jan 2021 08:39:39 +0100
Message-ID: <CAJfpegvY1ckAfR0c-RtzeBSaR8_dM2CV1MD_xJr=A6+MkSXi9A@mail.gmail.com>
Subject: Re: [PATCH 0/2] capability conversion fixes
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <code@tyhicks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 19, 2021 at 10:15 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Miklos Szeredi <mszeredi@redhat.com> writes:
>
> > It turns out overlayfs is actually okay wrt. mutliple conversions, because
> > it uses the right context for lower operations.  I.e. before calling
> > vfs_{set,get}xattr() on underlying fs, it overrides creds with that of the
> > mounter, so the current user ns will now match that of
> > overlay_sb->s_user_ns, meaning that the caps will be converted to just the
> > right format for the next layer
> >
> > OTOH ecryptfs, which is the only other one affected by commit 7c03e2cda4a5
> > ("vfs: move cap_convert_nscap() call into vfs_setxattr()") needs to be
> > fixed up, since it doesn't do the cap override thing that overlayfs does.
> >
> > I don't have an ecryptfs setup, so untested, but it's a fairly trivial
> > change.
> >
> > My other observation was that cap_inode_getsecurity() messes up conversion
> > of caps in more than one case.  This is independent of the overlayfs user
> > ns enablement but affects it as well.
> >
> > Maybe we can revisit the infrastructure improvements we discussed, but I
> > think these fixes are more appropriate for the current cycle.
>
> I mostly agree.  Fixing the bugs in a back-portable way is important.
>
> However we need to sort out the infrastructure, and implementation.
>
> As far as I can tell it is only the fact that overlayfs does not support
> the new mount api aka fs_context that allows this fix to work and be
> correct.
>
> I believe the new mount api would allow specifying a different userns
> thatn curent_user_ns for the overlay filesystem and that would break
> this.

This is a valid concern.   I'll add a WARN_ON() to make sure that
whenever this changes it doesn't go unnoticed.

Fixing it would also be easy:  just update creds->user_ns field to
that of sb->s_user_ns in ovl_fill_super().   For now I'll go with the
WARNING though, since this cannot be tested.

Thanks,
Miklos
