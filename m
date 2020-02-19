Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D471651F6
	for <lists+linux-security-module@lfdr.de>; Wed, 19 Feb 2020 22:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgBSV4d (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 19 Feb 2020 16:56:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46506 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgBSV4d (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Feb 2020 16:56:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so625168pll.13
        for <linux-security-module@vger.kernel.org>; Wed, 19 Feb 2020 13:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Azu2hLv1JxMDvmUxRW44SGEWy8s3ld4pghrW56XCt6M=;
        b=c7TWOHvdXbs8XVMlR8ak2j2dOVotN58THB1IoCFTfPwhfZYSyCThOf4Uwt/h/YiwTP
         C4f4cNiGmf3g+/JTB/nmySLtHFkNcbsTdphZ/X3OO5zOvQh31wXuIUh6Td8HLEdp4YOv
         fslV+YGcPP6RMcuohrbQMoofsTra+Jk2AU22gjMavwfOBgJ74L81QUv6AEgDr5xRGvkA
         3Ki/uS5ldmhYscfAaN0autLmj3+AAsssZVj4lH2DjcGS/hNAljyhttLK9TX0XHRtl4TP
         LsjsfAVYCa9xD1tl6Wb8kuejT/AlU9opB8F2FNk7IVwCJO3Dc5E+cFU9JrwID4No3Pkr
         ATjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Azu2hLv1JxMDvmUxRW44SGEWy8s3ld4pghrW56XCt6M=;
        b=LY88p2bT9YcqMx1IqhfAP9eKE3ZFcDA+/pCDrvOSxo9o7Bh4OfSYz0Kgo5ydw23/CA
         I39RDas9i+KK2M0LQGgiz6sWdwJqPfd+3Jye5Lch0zsl9me81NR8Pzk6mf4enJiCnWPA
         CypkgWxeFVl4QaNW420L6zdMt9fvRwqZZ8o3W6SePAI6py44UFqmXYwBia5bdVjN6iLA
         BbXzE2+Kjzv695SYEL76bRmm6LwYj5NAEja5tqLXOkmuccZy13kp7uq5DmUOQK9Mz8O7
         S0eQZztCNaNbNyX3a2qgoD01D0W+fpHSePKSB5bmazar28iIfYd2cfg4tk1Qp+l8Gfct
         ywtg==
X-Gm-Message-State: APjAAAVkbvQ9dCSrytuKks1NxtZH8Vt+I2psyhNLeAY3UusF+Ii0llPo
        dA1N4AJRL7e4pT3Qs4r60lHJeA==
X-Google-Smtp-Source: APXvYqymQ0qEvxoVB2HEtnEL4mIJWhCSks7TQ64jqXAFKrZw2Hqz77cp9KHgLn9ttxGpF6k20Rhu0Q==
X-Received: by 2002:a17:90a:3841:: with SMTP id l1mr11289750pjf.108.1582149392531;
        Wed, 19 Feb 2020 13:56:32 -0800 (PST)
Received: from cisco ([2001:420:c0c8:1007::7a1])
        by smtp.gmail.com with ESMTPSA id f8sm608035pfn.2.2020.02.19.13.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 13:56:31 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:56:23 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 00/25] user_namespace: introduce fsid mappings
Message-ID: <20200219215623.GA11724@cisco>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <20200219193558.GA27641@mail.hallyn.com>
 <20200219214837.GA29159@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219214837.GA29159@mail.hallyn.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 19, 2020 at 03:48:37PM -0600, Serge E. Hallyn wrote:
> On Wed, Feb 19, 2020 at 01:35:58PM -0600, Serge E. Hallyn wrote:
> > On Tue, Feb 18, 2020 at 03:33:46PM +0100, Christian Brauner wrote:
> > > With fsid mappings we can solve this by writing an id mapping of 0
> > > 100000 100000 and an fsid mapping of 0 300000 100000. On filesystem
> > > access the kernel will now lookup the mapping for 300000 in the fsid
> > > mapping tables of the user namespace. And since such a mapping exists,
> > > the corresponding files will have correct ownership.
> > 
> > So if I have
> > 
> > /proc/self/uid_map: 0 100000 100000
> > /proc/self/fsid_map: 1000 1000 1
> 
> Oh, sorry.  Your explanation in 20/25 i think set me straight, though I need
> to think through a few more examples.
> 
> ...
> 
> > 3. If I create a new file, as nsuid 1000, what will be the inode owning kuid?
> 
> (Note - I edited the quoted txt above to be more precise)
> 
> I'm still not quite clear on this.  I believe the fsid mapping will take
> precedence so it'll be uid 1000 ?  Per mount behavior would be nice there,
> but perhaps unwieldy.

The is_userns_visible() bits seems to be an attempt at understanding
what people would want per-mount, with a policy hard coded in the
kernel.

But maybe per-mount behavior can be solved more elegantly with shifted
bind mounts, so we can drop all that from this series, and ignore
per-mount settings here?

Tycho
