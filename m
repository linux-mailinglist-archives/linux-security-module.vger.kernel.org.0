Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351045F634F
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Oct 2022 11:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiJFJIU (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 6 Oct 2022 05:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiJFJIQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Oct 2022 05:08:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ECC97EDB
        for <linux-security-module@vger.kernel.org>; Thu,  6 Oct 2022 02:08:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b2so3126723eja.6
        for <linux-security-module@vger.kernel.org>; Thu, 06 Oct 2022 02:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LOmauc4/I+JOFn6hd++WyIkQgMu2EEj3PH+I8MZLpXs=;
        b=gLSt9SBU3vDLigUT7CXmfVcRPqBbvuk1NIjKx2WYizeVaspg1ngnkGVg30OZzHD2Uq
         BkJ3OavLluXln54nRyQp4pbSUDJCt50b8+qD39kx76U6HgK6Ng5/30qkdq+EoyQYMCLO
         wvURxS/wd5nVUMS3mCeBDb6ZhmpBMeeZMJu34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LOmauc4/I+JOFn6hd++WyIkQgMu2EEj3PH+I8MZLpXs=;
        b=T0eDNCWOAIiMPrs/zIR08K3tVAG7T8S66HRo077lohYbb0UjZD9GhiUzbtZJeAe6tC
         dV6wo6KDR7XugnbuTfZqQX38RiClAaiv+cQUmhQvar2N5ihd+wGPpWDxXK073oBJ9NcY
         f9T1W6pjDNhrzQ9JMw4EfD3y9Zazbrr6G6ewG5lR4vVJpPLGLgQt+tL2C/0PZY6t6gZ7
         JUAzrjubnVAjsy81nI94ux6M+Nyfx8kTo9rgbLzgXoSKSAaUsOeD3XHXCD+wXZvFNtth
         gaqZqGXkGpeud0ZjlC3qiBfAjYt7CGWWXyiJff6BgcCp5iJK6jLFey6UvgMHbr9P2zO8
         Wd0g==
X-Gm-Message-State: ACrzQf1nTailoxIEDdACmqJlf4mZSJV7vCkv2KJkqLw+L6Z6Co2mH80N
        AKar3+GyK+qjHiVnrzJpMj/WJQbmF3ynJH1k9v/ERg==
X-Google-Smtp-Source: AMsMyM4YkhkFXQT12yDXIwQTtnqe00pW77bh19zMOLn7DBOoQvKQZ4lv3YU0rgzeOINUl4plxi6NYMWwealeLbFD9CE=
X-Received: by 2002:a17:906:7315:b0:782:66dc:4b76 with SMTP id
 di21-20020a170906731500b0078266dc4b76mr2988551ejc.751.1665047290545; Thu, 06
 Oct 2022 02:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
 <20220930090949.cl3ajz7r4ub6jrae@wittgenstein> <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
 <CAH2r5muRDdy1s4xS7bHePEF3t84qGaX3rDXUgGLY1k_XG4vuAg@mail.gmail.com>
 <20221005071508.lc7qg6cffqrhbc4d@wittgenstein> <CAJfpegviBdPx25oLTNHCg661GfMa92NKOadSr=QnaFAhzkkN2Q@mail.gmail.com>
 <20221006074054.sif5cjou4edas2mz@wittgenstein>
In-Reply-To: <20221006074054.sif5cjou4edas2mz@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 6 Oct 2022 11:07:59 +0200
Message-ID: <CAJfpegtu3u3_mAz4rHwVqPO0GyD=7m+Gt+iF0=ZrYr5kLtUPJQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
To:     Christian Brauner <brauner@kernel.org>
Cc:     Steve French <smfrench@gmail.com>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 6 Oct 2022 at 09:41, Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Oct 06, 2022 at 08:31:47AM +0200, Miklos Szeredi wrote:
> > On Wed, 5 Oct 2022 at 09:15, Christian Brauner <brauner@kernel.org> wrote:
> >
> > > We're just talking about thet fact that
> > > {g,s}etxattr(system.posix_acl_{access,default}) work on cifs but
> > > getting acls based on inode operations isn't supported. Consequently you
> > > can't use the acls for permission checking in the vfs for cifs. If as
> > > you say below that's intentional because the client doesn't perform
> > > access checks then that's probably fine.
> >
> > Now I just need to wrap my head around how this interacts with all the
> > uid/gid transformations.
>
> Currently it doesn't because cifs doesn't support idmapped mounts.
>
> >
> > Do these (userns, mnt_userns) even make sense for the case of remotely
> > checked permissions?
>
> Namespaces are local concepts. They are relevant for permission checking
> and are e.g., used to generate a {g,u}id that may be sent to a server. A
> concrete example would be a network filesystems that would change the
> ownership of a file and the client calls it's ->setattr() inode
> operation. The fs_userns and/or mnt_userns is used to generate a raw
> {g,u}id value to be sent to the server (So all netns call from_kuid()
> ultimately to send a raw {g,u}id over the wire. The server can then do
> whatever additional permission checking it wants based on that {g,u}id.
>
> For acls it's the same. We use the namespaces to generate the raw values
> and send them to the server that stores them. Either in the acl uapi
> format or if the netfs has a custom format for acls or translate them
> into it's own acl format. The server can then use them for permission
> checking however it wants. But if the server allows the client to
> retrieve them during permission checking in the vfs then we need to
> translate that raw format from the server into the proper local format
> again at which point the namespaces are relevant again.
> I hope that helped.

Yes, I got it now.

Thanks,
Miklos
