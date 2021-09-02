Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605D23FF2DC
	for <lists+linux-security-module@lfdr.de>; Thu,  2 Sep 2021 19:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346748AbhIBRxz (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 2 Sep 2021 13:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346726AbhIBRxy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Sep 2021 13:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630605175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGgz/DAvR7xRFawq5YYv7/qKBT6IhTR9s5xg+w37MzM=;
        b=CiQaEVtFmf2ZzRCQF08sk+lu1KXCD5C4wlnGekPPbU87KELbaXVrmOTyGbHG31tYZvjmlp
        Sc2wxSVHeRt+RFmvRhTtEQK61d291DiMD0Z0RHudfJvqO1rio0w62OxqJhcnVkmHsf+gu+
        DSgSp87a6kGQ2/59nbqTcKoKyTQYv/k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-FwXUZIK3NASfdi-ps6uHVQ-1; Thu, 02 Sep 2021 13:52:54 -0400
X-MC-Unique: FwXUZIK3NASfdi-ps6uHVQ-1
Received: by mail-wr1-f70.google.com with SMTP id h6-20020a5d4fc6000000b00157503046afso816459wrw.3
        for <linux-security-module@vger.kernel.org>; Thu, 02 Sep 2021 10:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGgz/DAvR7xRFawq5YYv7/qKBT6IhTR9s5xg+w37MzM=;
        b=OF52h0rG3T4EFivD9rhVjtXbVeKVP0hW+M2yylAk3ek7SBNzBb+lC0yWu3ZPovn8Rk
         dxQ+8gOHEKdCZtRk0WuF1mjlZtvBAAaP60+B9zHYVKqYkKChp3hlgdk7VcToc5JwGEBB
         qqWlnkhDF8FoWUHlIQv9f9jNoaM42k0fy0Njg+bCfoUU6U6PGtNqSsrzg+oC1t6ysbuv
         Juviow3zPwQkkFhy2abtvIaLxNT0BlJYbIAl7uOHr+Y+XtNdapit/JdtvlFQ719Ep7bG
         TmK0uD/5codZ/F0kPEjNe5oCwi/QhkZsVpQpDlW6l2fP677XSJg8D1jqTbuq3svWEvh7
         BS4Q==
X-Gm-Message-State: AOAM530aV6UXmJ5rw0t4y25OnnQrjcO9HrZ5PUboMq8of2riJavgyDYK
        cRWCO6ug7joJTCn2oJXHztgzGYPpPIn0ANxfdgYEgy3aXGdsS112SLJ1uofvYa4PzHowMieykRE
        NDq+K6Hxjlo7FNGgVtJ8X/AsnyxFBxwem5WqfcMByt0pNjaBeG6Rn
X-Received: by 2002:a05:6000:1150:: with SMTP id d16mr4393836wrx.357.1630605173423;
        Thu, 02 Sep 2021 10:52:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh60vnYnPsananb52FqQ9yBDe+vklZykFx/lhJt9v1VzExu90P4TAUbNHWr44MGvno31emeutULtDXbJmfXOo=
X-Received: by 2002:a05:6000:1150:: with SMTP id d16mr4393813wrx.357.1630605173219;
 Thu, 02 Sep 2021 10:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com>
In-Reply-To: <20210902152228.665959-1-vgoyal@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 Sep 2021 19:52:41 +0200
Message-ID: <CAHc6FU4foW+9ZwTRis3DXSJSMAvdb4jXcq7EFFArYgX7FQ1QYg@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>, gscrivan@redhat.com,
        "Fields, Bruce" <bfields@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=agruenba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

On Thu, Sep 2, 2021 at 5:22 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> This is V3 of the patch. Previous versions were posted here.
>
> v2: https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoyal@redhat.com/
> v1: https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.com/
>
> Changes since v2
> ----------------
> - Do not call inode_permission() for special files as file mode bits
>   on these files represent permissions to read/write from/to device
>   and not necessarily permission to read/write xattrs. In this case
>   now user.* extended xattrs can be read/written on special files
>   as long as caller is owner of file or has CAP_FOWNER.
>
> - Fixed "man xattr". Will post a patch in same thread little later. (J.
>   Bruce Fields)
>
> - Fixed xfstest 062. Changed it to run only on older kernels where
>   user extended xattrs are not allowed on symlinks/special files. Added
>   a new replacement test 648 which does exactly what 062. Just that
>   it is supposed to run on newer kernels where user extended xattrs
>   are allowed on symlinks and special files. Will post patch in
>   same thread (Ted Ts'o).
>
> Testing
> -------
> - Ran xfstest "./check -g auto" with and without patches and did not
>   notice any new failures.
>
> - Tested setting "user.*" xattr with ext4/xfs/btrfs/overlay/nfs
>   filesystems and it works.
>
> Description
> ===========
>
> Right now we don't allow setting user.* xattrs on symlinks and special
> files at all. Initially I thought that real reason behind this
> restriction is quota limitations but from last conversation it seemed
> that real reason is that permission bits on symlink and special files
> are special and different from regular files and directories, hence
> this restriction is in place. (I tested with xfs user quota enabled and
> quota restrictions kicked in on symlink).
>
> This version of patch allows reading/writing user.* xattr on symlink and
> special files if caller is owner or priviliged (has CAP_FOWNER) w.r.t inode.

the idea behind user.* xattrs is that they behave similar to file
contents as far as permissions go. It follows from that that symlinks
and special files cannot have user.* xattrs. This has been the model
for many years now and applications may be expecting these semantics,
so we cannot simply change the behavior. So NACK from me.

> Who wants to set user.* xattr on symlink/special files
> -----------------------------------------------------
> I have primarily two users at this point of time.
>
> - virtiofs daemon.
>
> - fuse-overlay. Giuseppe, seems to set user.* xattr attrs on unpriviliged
>   fuse-overlay as well and he ran into similar issue. So fuse-overlay
>   should benefit from this change as well.
>
> Why virtiofsd wants to set user.* xattr on symlink/special files
> ----------------------------------------------------------------
> In virtiofs, actual file server is virtiosd daemon running on host.
> There we have a mode where xattrs can be remapped to something else.
> For example security.selinux can be remapped to
> user.virtiofsd.securit.selinux on the host.
>
> This remapping is useful when SELinux is enabled in guest and virtiofs
> as being used as rootfs. Guest and host SELinux policy might not match
> and host policy might deny security.selinux xattr setting by guest
> onto host. Or host might have SELinux disabled and in that case to
> be able to set security.selinux xattr, virtiofsd will need to have
> CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
> guest security.selinux (or other xattrs) on host to something else
> is also better from security point of view.
>
> But when we try this, we noticed that SELinux relabeling in guest
> is failing on some symlinks. When I debugged a little more, I
> came to know that "user.*" xattrs are not allowed on symlinks
> or special files.
>
> So if we allow owner (or CAP_FOWNER) to set user.* xattr, it will
> allow virtiofs to arbitrarily remap guests's xattrs to something
> else on host and that solves this SELinux issue nicely and provides
> two SELinux policies (host and guest) to co-exist nicely without
> interfering with each other.

The fact that user.* xattrs don't work in this remapping scenario
should have told you that you're doing things wrong; the user.*
namespace seriously was never meant to be abused in this way.

You may be able to get away with using trusted.* xattrs which support
roughly the kind of daemon use I think you're talking about here, but
I'm not sure selinux will be happy with labels that aren't fully under
its own control. I really wonder why this wasn't obvious enough.

Thanks,
Andreas

> Thanks
> Vivek
>
> Vivek Goyal (1):
>   xattr: Allow user.* xattr on symlink and special files
>
>  fs/xattr.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> --
> 2.31.1
>

