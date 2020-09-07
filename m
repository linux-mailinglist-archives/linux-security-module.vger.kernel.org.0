Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4551325F445
	for <lists+linux-security-module@lfdr.de>; Mon,  7 Sep 2020 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgIGHqM (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 7 Sep 2020 03:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgIGHqI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Sep 2020 03:46:08 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51192C061573
        for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2020 00:46:08 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w8so11713439ilj.8
        for <linux-security-module@vger.kernel.org>; Mon, 07 Sep 2020 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOcu8D5wTw2HeDSoosOfCg4t0DhAHSO+wPplJiiP8zs=;
        b=kQgmoMefVTk+IjUZ91VOxE5uOnj6dN3OhFswHjPA8Sohyz/hprwyvf/fQn6Qoci4Jn
         +QAj/8ckPZAQfT/hBgM6aPTrkQSyXVpGrDiRLjaZY14xaKKjo0wiD7ecNm1TgEJRaABC
         vdH6n3ctU+AsvpY/VVWtT6KEOOFZJ44rlwDnYO9E1niHmbd3YWirTDC+aF7X//AzhGdJ
         OvAXENpZMHKtvIaHfLrCEL4c1vDSyqIbLf70DiGnPXLWmUXx0/eVXIK/5pe/APtq6toh
         c2/eaIZmh1uCL+bJd+1HrEKfAUazohnDWZbQUoWRz1c0K33JNlTT0fHRyZL2L42pERMP
         ynZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOcu8D5wTw2HeDSoosOfCg4t0DhAHSO+wPplJiiP8zs=;
        b=SDo0g7pfrDlP9/ND/1rBks7pD8IT5g2MeC5noJuex6JcMMOnt3f/OlZkCZwU37ju1k
         0I+YNMLdUAsGmKZ2iJxfQWne7XHzKyLrb9FQzj2CPfQ+1Ta6rfT/GuwJFCXA8+N1oxr9
         2FteY7iikJ1ZavChRPVpglJXaaklxWXA/PXY1IdQ+rChFXozQn7uClrTEiOpfomH7kDZ
         sIz9PC2bM02e+0fw0svVphn/Jn9hZuGqeSyTm2RqsjB2ID6fHMHARC0qzHjXPDBR1HYM
         vtH7EL5JY2UA+ApTRXzNJL9/xUQTWZ0Olm7ZNv1ctC9cvK243HXxSrr/9mjyb6kCFt0r
         0YgA==
X-Gm-Message-State: AOAM530Q39sherBpEr4i7v0CClyrT5gWbu3RgJdlxa7on4SM5P2HfsBT
        U619dYOk0CVGR6JaYwD0PuHtelCmz29EGyhIBY46WA==
X-Google-Smtp-Source: ABdhPJziDuXiwGvW9UM22wNMoxrqrL0azfO21D5OHGUhZejQeMz0dhIUigYLyuSuoA9rIgKn3f2lHV90i9Kjf0GwjC8=
X-Received: by 2002:a92:c5ac:: with SMTP id r12mr17119968ilt.274.1599464767126;
 Mon, 07 Sep 2020 00:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200827063522.2563293-1-lokeshgidra@google.com>
 <20200827063522.2563293-2-lokeshgidra@google.com> <20200901124136.r3krb2p23343licq@wittgenstein>
In-Reply-To: <20200901124136.r3krb2p23343licq@wittgenstein>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 7 Sep 2020 00:45:56 -0700
Message-ID: <CA+EESO5T9PSR8eATCrKtFXdR=x8T_McZDJ5wPtvFqcvBS=Qp2w@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] Add a new LSM-supporting anonymous inode interface
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        kernel-team@android.com, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 1, 2020 at 5:41 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Aug 26, 2020 at 11:35:20PM -0700, Lokesh Gidra wrote:
> > From: Daniel Colascione <dancol@google.com>
> >
> > This change adds a new function, anon_inode_getfd_secure, that creates
> > anonymous-node file with individual non-S_PRIVATE inode to which security
> > modules can apply policy. Existing callers continue using the original
> > singleton-inode kind of anonymous-inode file. We can transition anonymous
> > inode users to the new kind of anonymous inode in individual patches for
> > the sake of bisection and review.
> >
> > The new function accepts an optional context_inode parameter that
> > callers can use to provide additional contextual information to
> > security modules for granting/denying permission to create an anon inode
> > of the same type.
> >
> > For example, in case of userfaultfd, the created inode is a
> > 'logical child' of the context_inode (userfaultfd inode of the
> > parent process) in the sense that it provides the security context
> > required during creation of the child process' userfaultfd inode.
> >
> > Signed-off-by: Daniel Colascione <dancol@google.com>
> >
> > [Fix comment documenting return values of inode_init_security_anon()]
> > [Add context_inode description in comments to anon_inode_getfd_secure()]
> > [Remove definition of anon_inode_getfile_secure() as there are no callers]
> > [Make _anon_inode_getfile() static]
> > [Use correct error cast in _anon_inode_getfile()]
> > [Fix error handling in _anon_inode_getfile()]
> >
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > ---
> >  fs/anon_inodes.c              | 147 +++++++++++++++++++++++++---------
> >  include/linux/anon_inodes.h   |   8 ++
> >  include/linux/lsm_hook_defs.h |   2 +
> >  include/linux/lsm_hooks.h     |   9 +++
> >  include/linux/security.h      |  10 +++
> >  security/security.c           |   8 ++
> >  6 files changed, 144 insertions(+), 40 deletions(-)
> >
> > diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> > index 89714308c25b..c3f16deda211 100644
> > --- a/fs/anon_inodes.c
> > +++ b/fs/anon_inodes.c
> > @@ -55,61 +55,79 @@ static struct file_system_type anon_inode_fs_type = {
> >       .kill_sb        = kill_anon_super,
> >  };
> >
> > -/**
> > - * anon_inode_getfile - creates a new file instance by hooking it up to an
> > - *                      anonymous inode, and a dentry that describe the "class"
> > - *                      of the file
> > - *
> > - * @name:    [in]    name of the "class" of the new file
> > - * @fops:    [in]    file operations for the new file
> > - * @priv:    [in]    private data for the new file (will be file's private_data)
> > - * @flags:   [in]    flags
> > - *
> > - * Creates a new file by hooking it on a single inode. This is useful for files
> > - * that do not need to have a full-fledged inode in order to operate correctly.
> > - * All the files created with anon_inode_getfile() will share a single inode,
> > - * hence saving memory and avoiding code duplication for the file/inode/dentry
> > - * setup.  Returns the newly created file* or an error pointer.
> > - */
> > -struct file *anon_inode_getfile(const char *name,
> > -                             const struct file_operations *fops,
> > -                             void *priv, int flags)
> > +static struct inode *anon_inode_make_secure_inode(
> > +     const char *name,
> > +     const struct inode *context_inode)
> >  {
> > -     struct file *file;
> > +     struct inode *inode;
> > +     const struct qstr qname = QSTR_INIT(name, strlen(name));
> > +     int error;
> > +
> > +     inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> > +     if (IS_ERR(inode))
> > +             return inode;
> > +     inode->i_flags &= ~S_PRIVATE;
> > +     error = security_inode_init_security_anon(inode, &qname, context_inode);
> > +     if (error) {
> > +             iput(inode);
> > +             return ERR_PTR(error);
> > +     }
> > +     return inode;
> > +}
>
> Hey,
>
> Iiuc, this makes each newly created anon inode fd correspond to a unique
> file and to a unique inode:
>
> fd1 -> file1 -> inode1
> fd2 -> file2 -> inode2
>
Not every anon inode. Just the ones created through
anon_inode_getfd_secure() API.

> Whereas before we had every anon inode fd correspond to a unique file
> but all files map to the _same_ inode:
>
> fd1 -> file1 -> inode
> fd2 -> file2 -> inode
>
Thils is still the case if anon_inode_getfile() and/or
anon_inode_getfd() APIs are used.

> The old behavior of hooking up a each anon inode fd to the same inode
> prevented having an evict method attached to the inode. Because it was
> shared that wasn't possible but also simply because that inode never got
> evicted anyway. That surely was intended but it's a bummer to some
> extent.
> With the new model you also can't have an evict method because now you
> have a separate inode for each file.
>
> I'm probably going to get killed for suggesting this but:
> If we're going to expand the anonymous inode infrastructure anyway is
> there a way we can make it so that we have a way to allocate a single
> inode for multiple anonymous inode fds and have callers opt-in to this
> behavior. We'd need a way to find this inode again, obviously.
>
> This would allow for some features on top of anonymous inode fds that
> can refer to the same object, i.e. anonymous inode fds that currently
> stash away the same object in f->private_data.
> In such a model we could allow such anonymous inode fds to stash away
> objects in inode->i_private instead of f->private_data and attach an
> evict method to it. This would e.g. allow a process to be killed when
> the last pidfd to it is closed or a seccomp notifier fd to notify when
> the filter is released without having to do separate reference counting.
>
I didn't fully understand the example you gave and the role that evict
method will play in it. Can you please elaborate a bit more.

But, I'd like to point you to a previous discussion between Daniel
Colascione (the original contributor of this patch series) and Stephan
Smalley on the topic of inodes
https://lore.kernel.org/lkml/CAKOZuesUVSYJ6EjHFL3QyiWKVmyhm1fLp5Bm_SHjB3_s1gn08A@mail.gmail.com/

I agree with Daniel (see his replies in the thread link above) that a
separate inode per anon inode fd keeps the design simple, particularly
from the security context perspective.

> This would need a way to lookup that inode by the object that is stashed
> away in it of course which could probably be done by an idr or an
> xarray or something cleverer. It would obviously only affect a subset of
> anonymous inode fds so any other anonymous inode fds wouldn't be
> impacted since they can still use the single-anon-inode interface.
>
> Christian
