Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB192C1832
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Nov 2020 23:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbgKWWHB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 23 Nov 2020 17:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732290AbgKWWHB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Nov 2020 17:07:01 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CDBC0613CF
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2020 14:06:59 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id k1so5801066eds.13
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2020 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArDHvUzfUiZzh94W960BgkUJZn/5DnacTXHC4Nbv9kI=;
        b=Ihm9gWe+6m2iCUrCqSrzj2hxvAUOkkHpCGtwhE41f3Rdh8c80xsJegtLMifcQSq7l4
         MQxmEg8qFYnoifRMupAHJLQd5lYZm+n6GzQdGqoyCuHFxDt3fXMsW4siDYXty7uFQyR+
         ZiLBHsJEHGtWXoprHv+EbMvUbaSfI62VdYDnQ6kSau+U/tc34IQsesxRL2sYZY1EAFs1
         LsTOG7yiGz9YGo+XzQObpUnu50coOcAWET1QWObW0HN2FliSyDT2/hew7cMEOL8j6Rt4
         CkHD0bLpWTrv0L4vHLaw7qmLF7A/4zumynmI5rzULQJ1fukCf4JWCo9n/ipboGbcKUNv
         ClRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArDHvUzfUiZzh94W960BgkUJZn/5DnacTXHC4Nbv9kI=;
        b=mV8HFYegLHPaMP1mOQBjBZYX3eTAswQ7vw5EGWo10m+DLlBefjaxalMhze+hdg7FSZ
         92Y0PxN8nPmXCmtck+ki37H+zsxq8avmqilUjzl+uL90x8e2rGAVgGEGw0e6fkNjCVHj
         yE0DkXkie21FVLrzcrnlzqOIjtAkvjvwiEYredTqIg9OxtOjn9z/3nPfzvUoZKEWRllN
         y6dadm4iOarCDb9wMTK494FZzsebmJF6c3JlVrqidQaBtKqDmW4HyYD9jhxmoenwivm1
         I8J57N0/VOW2ldW4y5yM/5OJts7c5nq3dTQ10pP6MuUl4YCOsgo/CeK/7xG3ONo3OVim
         W+gw==
X-Gm-Message-State: AOAM533ubV57frFRP4/2FELKDQgJbSHdtPmiJ/EfGV8lIZ8Rv29Zl6LX
        kgTNiRD9jyleHjHoaDeg7qJHy5aEvMdCcZN2BLs0
X-Google-Smtp-Source: ABdhPJyCGu6X9xaHoLXWBbQARSvPVPAoR3jFBNgP4UppEnyulyojvZlb/ppHqsSx8lMhDFxNpQsOSthLAo4GmR/YyTM=
X-Received: by 2002:a50:a6d0:: with SMTP id f16mr1171069edc.135.1606169217904;
 Mon, 23 Nov 2020 14:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
 <20201115103718.298186-32-christian.brauner@ubuntu.com> <CAHC9VhQ5gcOa0+KKDtKEgg_v4SZV2hPdaKUbPGJAQrVB8mn0jA@mail.gmail.com>
 <20201123074157.fqus6fgtcytydp2c@wittgenstein>
In-Reply-To: <20201123074157.fqus6fgtcytydp2c@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Nov 2020 17:06:46 -0500
Message-ID: <CAHC9VhTrYDEAkaLbwtF7hQS=8HpM4wx7A_fN4=9pL6EAM-KPGw@mail.gmail.com>
Subject: Re: [PATCH v2 31/39] audit: handle idmapped mounts
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 23, 2020 at 2:42 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Sun, Nov 22, 2020 at 05:17:39PM -0500, Paul Moore wrote:
> > On Sun, Nov 15, 2020 at 5:43 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > Audit will sometimes log the inode's i_uid and i_gid. Enable audit to log the
> > > mapped inode when it is accessed from an idmapped mount.
> >
> > I mentioned this in an earlier patch in this patchset, but it is worth
>
> I did not receive that message.

I'm guessing just a slow mail relay somewhere as you responded to both
of my emails on this patchset, I think we're all set for now :)

Thanks.

-- 
paul moore
www.paul-moore.com
