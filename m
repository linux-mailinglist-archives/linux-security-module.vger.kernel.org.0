Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF422A8801
	for <lists+linux-security-module@lfdr.de>; Thu,  5 Nov 2020 21:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgKEUYT (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 5 Nov 2020 15:24:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727017AbgKEUYS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Nov 2020 15:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604607857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zao2fgkmVfWywh+3BoD6j5/y/D7ZjRD6vgCyL4k6gi4=;
        b=U5VXCrrlSxurg9Sl7+1xbUA3p09aqJV/RaogOYZ/rahNVzNWRqeKjbwcCHdSDl0qvk5OwS
        CIOQI9/Zd8wnM6Lm3pk4sMolApfkH+6I/q4YGHVf4DgYGwniA6W8eO88TTMlIaftCkbJ1V
        jPUF56EKm/LrpQxImTriJ6BZfbOlhnw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-YljkZA5FNxu-tzcYkhzviQ-1; Thu, 05 Nov 2020 15:24:12 -0500
X-MC-Unique: YljkZA5FNxu-tzcYkhzviQ-1
Received: by mail-lj1-f198.google.com with SMTP id a10so550052ljj.14
        for <linux-security-module@vger.kernel.org>; Thu, 05 Nov 2020 12:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zao2fgkmVfWywh+3BoD6j5/y/D7ZjRD6vgCyL4k6gi4=;
        b=UpV3T6zYzhvTqIkPCSpxuGIfdkmQuPafujHZRHJmg8k7kVCZk4VlPc4bYigH/U9ird
         MPNYvmbZLWW/BFw52dm8ZU2S6aVcy7pHXQgb137CuPYSilAOX/q2KBXGr2l571MtRuTE
         aHAW+iFOVjqwmRk7QWeVZHEVk7goxG1AzT8CMRpEZjQ7UXPid+9sRXX2w7BsmvJ4Zgjb
         MjJfdg0v9ekoKzIrVL6v+vm/lO6ZLt7RK54yJdqK/RFuKAmqR/YnwN1Gp/28/eV+MUVZ
         c5MJhXJXKvc12yFnbc0u07bgva1ZCC80Km7bnZDAdzQ3zBFgdfg7SsSRb4pz2qsQ2EqK
         Z7Ng==
X-Gm-Message-State: AOAM530hXVdIPAJaRoCepE4mkmqhpVZhHUkYkmoJHwt737CCVeuX1d8v
        SOXV/KyOKetoLXN/0m1lGY3VtRKQo8eA5f69tBqC1Nm1K1wO3DqDBzKFeFQMQokfa2chVJfvWIB
        SCX/jlhXWtvLqPyM0QQkRbLD++ObTf5eKUqxl65l2DhlJYxWc3bP6
X-Received: by 2002:a19:8605:: with SMTP id i5mr1844951lfd.15.1604607851244;
        Thu, 05 Nov 2020 12:24:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoYup98LfFVnlbntXZy9GY37DJHH7ztKfAHvpeIkPhfj05tnbRgrVxL4dC9J94R0ClB6e+FMwly8vudKtdpww=
X-Received: by 2002:a19:8605:: with SMTP id i5mr1844946lfd.15.1604607851017;
 Thu, 05 Nov 2020 12:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20201105173328.2539-1-olga.kornievskaia@gmail.com>
 <20201105173328.2539-2-olga.kornievskaia@gmail.com> <CAFqZXNtjMEF0LO4vtEmcgwydbWfUS36d8g24J6C-NDXORYbEJg@mail.gmail.com>
 <CAN-5tyF+cLpmT=rwAYvQQ445tjFKZtGq+Qzf6rDGg8COPpFRwA@mail.gmail.com>
In-Reply-To: <CAN-5tyF+cLpmT=rwAYvQQ445tjFKZtGq+Qzf6rDGg8COPpFRwA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 5 Nov 2020 21:24:00 +0100
Message-ID: <CAFqZXNusby0F6Azkf0U_tV-1KCQT0Z1NZH6v0GXxt9RBQrR07g@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFSv4.2: condition READDIR's mask for security label
 based on LSM state
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 5, 2020 at 8:51 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Thu, Nov 5, 2020 at 1:55 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Thu, Nov 5, 2020 at 6:33 PM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > Currently, the client will always ask for security_labels if the server
> > > returns that it supports that feature regardless of any LSM modules
> > > (such as Selinux) enforcing security policy. This adds performance
> > > penalty to the READDIR operation.
> > >
> > > Instead, query the LSM module to find if anything is enabled and
> > > if not, then remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.
> >
> > Having spent some time staring at some of the NFS code very recently,
> > I can't help but suggest: Would it perhaps be enough to decide whether
> > to ask for labels based on (NFS_SB(dentry->d_sb)->caps &
> > NFS_CAP_SECURITY_LABEL)? It is set when mounting the FS iff some LSM
> > confirms via the security_sb_*_mnt_opts() hook that it wants the
> > filesystem to give it labels (or at least that's how I interpret the
> > cryptic name) [1]. It's just a shot in the dark, but it seems to fit
> > this use case.
> >
> > [1] https://elixir.bootlin.com/linux/v5.10-rc2/source/fs/nfs/getroot.c#L148
>
> Very interesting. I was not aware of something like that nor was it
> mentioned when I asked on the selinux mailing list. I wonder if this
> is a supported feature that will always stay? In that case, NFS
> wouldn't need the extra hook that was added for this series. I will
> try this out and report back.

I wish I could have suggested it sooner, but I only learned about it
in recent days while investigating a bug that involves SELinux and NFS
:) And when I saw your patch, it immediately reminded me of that flag.

I don't think it's going away, at least as long as NFS depends on it.
If someone were to remove it, they would have to provide something
equivalent to make sure no existing users get broken, as with any
in-kernel change.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

