Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D307A015C
	for <lists+linux-security-module@lfdr.de>; Thu, 14 Sep 2023 12:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbjINKOQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 14 Sep 2023 06:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbjINKOO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Sep 2023 06:14:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91131BE9
        for <linux-security-module@vger.kernel.org>; Thu, 14 Sep 2023 03:14:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c93638322so174158766b.1
        for <linux-security-module@vger.kernel.org>; Thu, 14 Sep 2023 03:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1694686448; x=1695291248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TPuDwD4ZrkyAZ/NBOLS8VaQLWjoMvPUnZLd4ZQdk17o=;
        b=QLPVbta0mIgsVHxTB342Kfkc6P5mkwpvc8LRZIviHrsloFuQwMwZ0sM6jGWy9nCBOT
         uTUyoG8ex9Jy1lIJaB8zz4u0JxQthyFIW0HmvV7XCC5pkgb/0nUKcjHwgc4G15a6EL2C
         eVC25wejuY9fv1OJMSV8kXuBjt6XPECvgOaMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694686448; x=1695291248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPuDwD4ZrkyAZ/NBOLS8VaQLWjoMvPUnZLd4ZQdk17o=;
        b=O0jvB0mWbOUBcDmLuHPYik8w9ClFC0oBs5CXmSnEQCOP47Tg+V56slSDcb3pGeKSmU
         jWwm43svsgZPJCe0bPF6hCL+3ijWjPAy2kur+D7zffQ/3wR7mkzoOEko++6U5Xc9kMk4
         g+uaUoay9O3kQBA6Gvl4chEyPeJWCHNanKQ9rVfnFI1FxmZWiVVnRGDlcvHYMqyNyZUY
         vYrupJs8zWzXYi78zmODz64tFutT3LzV4Sc4fVMDIV/1m6ojFLe3vjHs1ZJF/PMXZwXY
         Runds6Q7cXFShSFcaFIK8xgf64nn8264WIIDxSfHrccfJC6ICLgHtO/odp1Fe7sx2oTU
         J3Vg==
X-Gm-Message-State: AOJu0YzVrNJQVWDBUVZNweip7ubXCs2VSG6n0IyroIHYrEtLhce39+uZ
        hbywTRn6K2UK7ceQEA/vbm0t5iKfZbaiVha8QpmgqQ5q34eib55faUg=
X-Google-Smtp-Source: AGHT+IGWbiyTK876nyDnSZchKAdndIJh+WgEikVLilcv45driRsG8+782uLgZQcb00o4mLm3qnrfRcUzbWyYeD/tVxI=
X-Received: by 2002:a17:906:51c5:b0:9ad:a46c:66a2 with SMTP id
 v5-20020a17090651c500b009ada46c66a2mr2033508ejk.11.1694686448127; Thu, 14 Sep
 2023 03:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
In-Reply-To: <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Sep 2023 12:13:54 +0200
Message-ID: <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 14 Sept 2023 at 11:28, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Sep 13, 2023 at 05:22:35PM +0200, Miklos Szeredi wrote:
> > Add a way to query attributes of a single mount instead of having to parse
> > the complete /proc/$PID/mountinfo, which might be huge.
> >
> > Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a mount
> > needs to be queried based on path, then statx(2) can be used to first query
> > the mount ID belonging to the path.
> >
> > Design is based on a suggestion by Linus:
> >
> >   "So I'd suggest something that is very much like "statfsat()", which gets
> >    a buffer and a length, and returns an extended "struct statfs" *AND*
> >    just a string description at the end."
>
> So what we agreed to at LSFMM was that we split filesystem option
> retrieval into a separate system call and just have a very focused
> statx() for mounts with just binary and non-variable sized information.
> We even gave David a hard time about this. :) I would really love if we
> could stick to that.
>
> Linus, I realize this was your suggestion a long time ago but I would
> really like us to avoid structs with variable sized fields at the end of
> a struct. That's just so painful for userspace and universally disliked.
> If you care I can even find the LSFMM video where we have users of that
> api requesting that we please don't do this. So it'd be great if you
> wouldn't insist on it.

I completely missed that.

What I'm thinking is making it even simpler for userspace:

struct statmnt {
  ...
  char *mnt_root;
  char *mountpoint;
  char *fs_type;
  u32 num_opts;
  char *opts;
};

I'd still just keep options nul delimited.

Is there a good reason not to return pointers (pointing to within the
supplied buffer obviously) to userspace?

>
> This will also allow us to turn statmnt() into an extensible argument
> system call versioned by size just like we do any new system calls with
> struct arguments (e.g., mount_setattr(), clone3(), openat2() and so on).
> Which is how we should do things like that.

The mask mechanism also allow versioning of the struct.

>
> Other than that I really think this is on track for what we ultimately
> want.
>
> > +struct stmt_str {
> > +     __u32 off;
> > +     __u32 len;
> > +};
> > +
> > +struct statmnt {
> > +     __u64 mask;             /* What results were written [uncond] */
> > +     __u32 sb_dev_major;     /* Device ID */
> > +     __u32 sb_dev_minor;
> > +     __u64 sb_magic;         /* ..._SUPER_MAGIC */
> > +     __u32 sb_flags;         /* MS_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
> > +     __u32 __spare1;
> > +     __u64 mnt_id;           /* Unique ID of mount */
> > +     __u64 mnt_parent_id;    /* Unique ID of parent (for root == mnt_id) */
> > +     __u32 mnt_id_old;       /* Reused IDs used in proc/.../mountinfo */
> > +     __u32 mnt_parent_id_old;
> > +     __u64 mnt_attr;         /* MOUNT_ATTR_... */
> > +     __u64 mnt_propagation;  /* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
> > +     __u64 mnt_peer_group;   /* ID of shared peer group */
> > +     __u64 mnt_master;       /* Mount receives propagation from this ID */
> > +     __u64 propagate_from;   /* Propagation from in current namespace */
> > +     __u64 __spare[20];
> > +     struct stmt_str mnt_root;       /* Root of mount relative to root of fs */
> > +     struct stmt_str mountpoint;     /* Mountpoint relative to root of process */
> > +     struct stmt_str fs_type;        /* Filesystem type[.subtype] */
>
> I think if we want to do this here we should add:
>
> __u64 fs_type
> __u64 fs_subtype
>
> fs_type can just be our filesystem magic number and we introduce magic

It's already there: sb_magic.

However it's not a 1:1 mapping (ext* only has one magic).

> numbers for sub types as well. So we don't need to use strings here.

Ugh.

Thanks,
Miklos
