Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A602D7828
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Dec 2020 15:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406086AbgLKOpa (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 11 Dec 2020 09:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406373AbgLKOpN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Dec 2020 09:45:13 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D24C061794
        for <linux-security-module@vger.kernel.org>; Fri, 11 Dec 2020 06:44:32 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id x4so4887345vsp.7
        for <linux-security-module@vger.kernel.org>; Fri, 11 Dec 2020 06:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iA2d+rrgQXobuuvVm/MUOiVayGvmYelRBSVm3q6aijM=;
        b=QC+2zzSTtj2h9xb3ytk8TQjtarb/1GIRAvMJFFc+Qxkt/CBt49otfxb7ho4zOPpf4E
         UfBQ3/5zogW1pgkylCK4jy+jNk6SOq2gKmQdOBtYzQUikhcIC23uCLF+/y1pl5y/jKw5
         IOoj16FRlUdrkBotwusINUnIih2vrZpVeKZ/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iA2d+rrgQXobuuvVm/MUOiVayGvmYelRBSVm3q6aijM=;
        b=fiJQOH85ibdRHBUJUKCEeoEUKFhel5DpHAD/XbrlL8/pyoZchnkGyy8E1hSVkz6dDB
         IyWc2mUywJvx7Cwpg1nYyYmG2om6iI43ogmc/r53uTHxQxriw0VcOCgyBLHsHU34/ZTu
         HuyUzISj6BW5u5fLhHZTDyuzOxoMeSzY9n+lSbz1i0q8lo7e7GA51KyqpIO5MfRBZbz/
         b9qtETEd/JMVtWKUS1ClTVqxJaIn1V7R2a1NVI8OLVyiq+UcBLv9pzqbpr7OyOFdS3ve
         37hH22eWYGPSyzxYiWOIbn2c8KgPx9f3tKPaY2sd5d8ei/Mp8rN1s8SaeYtfcP6r+lek
         lQRA==
X-Gm-Message-State: AOAM530QY2yPtZtDTKud2LIuxU0JAnPqecaqZ6L0dp6xC4g8gEmUAUed
        XcjC2v01TpB4nAjKXTj+vXwuymKr3t3qN/L5Y2ehQw==
X-Google-Smtp-Source: ABdhPJw16B1+C37MqnknEmfxoPs/GB/5T0eiuKddU0msdiG+DFkYSfUXcfzDJxaC8LyuizxgKkePC4UHOQt5Q6aVUI4=
X-Received: by 2002:a67:ed57:: with SMTP id m23mr13654785vsp.7.1607697871933;
 Fri, 11 Dec 2020 06:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-9-mszeredi@redhat.com>
 <CAOQ4uxgy23chB-NQcXJ+P3hO0_M3iAkgi_wyhbpfT3wkaU+E7w@mail.gmail.com>
In-Reply-To: <CAOQ4uxgy23chB-NQcXJ+P3hO0_M3iAkgi_wyhbpfT3wkaU+E7w@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Dec 2020 15:44:21 +0100
Message-ID: <CAJfpegvpEkB2HL5THcUsmBVvcru1-DkSTo_DmA4pWNU_TV7ODg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] ovl: do not fail because of O_NOATIME
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 8, 2020 at 12:32 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Dec 7, 2020 at 6:37 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > In case the file cannot be opened with O_NOATIME because of lack of
> > capabilities, then clear O_NOATIME instead of failing.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/overlayfs/file.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index dc767034d37b..d6ac7ac66410 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
> > @@ -53,9 +53,10 @@ static struct file *ovl_open_realfile(const struct file *file,
> >         err = inode_permission(realinode, MAY_OPEN | acc_mode);
> >         if (err) {
> >                 realfile = ERR_PTR(err);
> > -       } else if (!inode_owner_or_capable(realinode)) {
> > -               realfile = ERR_PTR(-EPERM);
> >         } else {
> > +               if (!inode_owner_or_capable(realinode))
> > +                       flags &= ~O_NOATIME;
> > +
>
> Isn't that going to break:
>
>         flags |= OVL_OPEN_FLAGS;
>
>         /* If some flag changed that cannot be changed then something's amiss */
>         if (WARN_ON((file->f_flags ^ flags) & ~OVL_SETFL_MASK))
>
> IOW setting a flag that is allowed to change will fail because of
> missing O_ATIME in file->f_flags.

Well spotted.  I just removed those lines as a fix.   The check never
triggered since its introduction in 4.19, so I guess it isn't worth
adding more complexity for.

>
> I guess we need test coverage for SETFL.

There might be some in ltp, haven't checked.  Would be nice if the fs
related ltp tests could be integrated into xfstests.


Thanks,
Miklos
