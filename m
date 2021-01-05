Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC42F2EA301
	for <lists+linux-security-module@lfdr.de>; Tue,  5 Jan 2021 02:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbhAEBrV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 4 Jan 2021 20:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhAEBrV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Jan 2021 20:47:21 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DF6C061793
        for <linux-security-module@vger.kernel.org>; Mon,  4 Jan 2021 17:46:41 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qw4so39258218ejb.12
        for <linux-security-module@vger.kernel.org>; Mon, 04 Jan 2021 17:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hrL5P+/Wig9xYysoWEcy4T3JLi4US3r4Bv0ZgQacj8=;
        b=QGvNoQsWStPPb6xdOkIN/piMqURakstCS2Mna2aXi8B3BGYb6giQsz1ColpHtxZUER
         mynXiG2MJZbId/8jzmsSH8YuN6tj9h1eb/vUE7CxYcX5fVIsiTQZh3tSiKNeN7gB0+Ks
         AmZahrZ0BixGDjz5D25t+RLbtMGYDUBXNGJp/jGZgHjQypZFT3+shjDR03oPJ7Dza85O
         Wu5TAFPKhfQT3HH9v/6lpHcdRX3vUKeb0GCO+pCjzbhNOrt4gE0coUW7ku2IVuy4RLEK
         3FHlM++UwjIzCHnIUhdhdhJf2D7ln2eKDTTVua5RsKy4eSHt+WJ7QuRoonH8hq815mzj
         R2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hrL5P+/Wig9xYysoWEcy4T3JLi4US3r4Bv0ZgQacj8=;
        b=CcBlQ00iLc5MnTjIAeywlrrPnqk6gxOb+aPzrE4bo578MGvl/weM8Pd+IBD6ZYyqKu
         mzmFnV9f/ez90nZ9FujMdW24c9/SKhXXRdjkYBGpeKv39ggxKP8yD1Sfu96EF8fqatde
         GcyjpAX/TBjy1OdZ49VCvfO+kX/NUIbJEdw6ak5blgy7uLwMNi8Ka4E8StHkZN8f4yK7
         XZzlfwnPHXv9sGZ/d29t23xkVdac8iQn5axRoKNmAqpN14BlwU3tgAF7rFBHdcDazg+k
         biiuwxKuK1kA1N7+YIA7Y1wSLl1mHYJ+i7QFXsRiP9AtZBLpfdn+HAj9e12WUzgbHPWB
         vJVw==
X-Gm-Message-State: AOAM531Yk5iDbsIiKC6MUeuT0kEmshR5yI0fq4uuTQGNFZgNWpAgMVz2
        uPJ7IsfEZV8wgrWYUM+8cyX3D9EaPLrTuymBsnOs
X-Google-Smtp-Source: ABdhPJy2T7Ko01GO47eJ4gxrh0L10Y7nFSvwcvSBg6cA5ykWeWQFAX7CLMZ0Bjj1qsdAsZpVixMHl7CWXW/BWodNnB0=
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr70964123ejc.178.1609811199726;
 Mon, 04 Jan 2021 17:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20201219100527.16060-1-amir73il@gmail.com> <CAFqZXNtcX54bv2xeQ26_i-=9OkdiJQQzPOveY=aaujOWJjGWLA@mail.gmail.com>
In-Reply-To: <CAFqZXNtcX54bv2xeQ26_i-=9OkdiJQQzPOveY=aaujOWJjGWLA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Jan 2021 20:46:28 -0500
Message-ID: <CAHC9VhQfh7BH_brRZqk9OgC+93qXz=M07MZ5NVeLQ==5YQS2Kg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix inconsistency between inode_getxattr and inode_listsecurity
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Michael Labriola <michael.d.labriola@gmail.com>,
        Jonathan Lebon <jlebon@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux Stable maillist <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 4, 2021 at 4:39 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Sat, Dec 19, 2020 at 11:07 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > When inode has no listxattr op of its own (e.g. squashfs) vfs_listxattr
> > calls the LSM inode_listsecurity hooks to list the xattrs that LSMs will
> > intercept in inode_getxattr hooks.
> >
> > When selinux LSM is installed but not initialized, it will list the
> > security.selinux xattr in inode_listsecurity, but will not intercept it
> > in inode_getxattr.  This results in -ENODATA for a getxattr call for an
> > xattr returned by listxattr.
> >
> > This situation was manifested as overlayfs failure to copy up lower
> > files from squashfs when selinux is built-in but not initialized,
> > because ovl_copy_xattr() iterates the lower inode xattrs by
> > vfs_listxattr() and vfs_getxattr().
> >
> > Match the logic of inode_listsecurity to that of inode_getxattr and
> > do not list the security.selinux xattr if selinux is not initialized.
> >
> > Reported-by: Michael Labriola <michael.d.labriola@gmail.com>
> > Tested-by: Michael Labriola <michael.d.labriola@gmail.com>
> > Link: https://lore.kernel.org/linux-unionfs/2nv9d47zt7.fsf@aldarion.sourceruckus.org/
> > Fixes: c8e222616c7e ("selinux: allow reading labels before policy is loaded")
> > Cc: stable@vger.kernel.org#v5.9+
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  security/selinux/hooks.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6b1826fc3658..e132e082a5af 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3406,6 +3406,10 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
> >  static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
> >  {
> >         const int len = sizeof(XATTR_NAME_SELINUX);
> > +
> > +       if (!selinux_initialized(&selinux_state))
> > +               return 0;
> > +
> >         if (buffer && len <= buffer_size)
> >                 memcpy(buffer, XATTR_NAME_SELINUX, len);
> >         return len;
> > --
> > 2.25.1
>
> Looked at the logic in vfs_listxattr() and this looks reasonable.

Agreed, this looks good to me too; I'll merge it into selinux/next.
Thanks everyone!

-- 
paul moore
www.paul-moore.com
