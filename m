Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1542F38D2E5
	for <lists+linux-security-module@lfdr.de>; Sat, 22 May 2021 04:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhEVCIT (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 May 2021 22:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhEVCIT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 May 2021 22:08:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E05C0613ED
        for <linux-security-module@vger.kernel.org>; Fri, 21 May 2021 19:06:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so33011722ejo.13
        for <linux-security-module@vger.kernel.org>; Fri, 21 May 2021 19:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enh1CO1fRJ/3s4nFuYfV9slAcR71xCie3kXiqBTbpWg=;
        b=DCGJ5Nilo9/AGG1ArRxCjRgl6Ds9yTKWnR6U59uXzOZmtwiUQ5494CMZyReO55uwFC
         bWQGlDqLRp/uFHm5zG6la0tMj+mGyzU7/vMvuDBbNIXjksEXwzlAE5G1hmTvER3/Jo1R
         YevoCUqNHBiF6AzfOPz9cWHKzkxXERNFSCqZX0G2NyH1AsaUTr7VCU16+FNGRhBapnhO
         z+Vlj89N0pKTqThOiXfuC8DqDIO7oFc89t651Zng0mhBQGHlIVNyJva1qSub9eoR34fF
         Qv0FYzdvvK38zcP1XpSvJfH+a4AowNlrh2wC6JfqExuFDqBBSuwRE2Hl+MMhteqYRHq9
         VYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enh1CO1fRJ/3s4nFuYfV9slAcR71xCie3kXiqBTbpWg=;
        b=Ip2Yq9bhDtpWuDbFb1aaBXzASE4NUQFw4nWtIuPUUhJIFLuv2DZi2lMyAZ8s5M7Zdn
         u1lOsT5sgI1nY1DoZJcPXCBky5GjHmUapCXzuhSG92h//4TfZn7F9lCmfTUd+jFOS5QD
         BWHYplWV86uuHUrfurabYQluBhJlrfta565KSbrvdAFllG+pTYlCcbosFyF19X0FT56f
         kVLwzqZAipk6d67siUO0NIi4XJ3f70Y6iLI8YCcawIN/tQVBHY9Xa+lwEx13o8Q8Pxct
         gaHTVIW2zK5t0LydXm4ydFxo243ECXEMdcEzDh0wCxZA/Wgh90vJ+gjm+KpsFZQfYumu
         ZMRw==
X-Gm-Message-State: AOAM531Yo1fgsPtyuKOIEeCS/orqXd3fJy8qtQf8cSLdOnXniCW/U8dq
        C8E3VpvGN+Ipf87dF8ysmF7P2tSgPwiZ6X7Mwc/0
X-Google-Smtp-Source: ABdhPJwAdi1Bw98L2/qGMo17Mi+Nh8QFY/8nuxWxu+5qFeaSxXKZgxnhJ2PPUK/Xid00W60zEIsVCCAHK9qd/G6j0x4=
X-Received: by 2002:a17:907:1749:: with SMTP id lf9mr13285225ejc.178.1621649212774;
 Fri, 21 May 2021 19:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <162163367115.8379.8459012634106035341.stgit@sifl> <f67213bf-8f41-ce06-b3b2-adf1ab2a3c5c@i-love.sakura.ne.jp>
In-Reply-To: <f67213bf-8f41-ce06-b3b2-adf1ab2a3c5c@i-love.sakura.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 May 2021 22:06:41 -0400
Message-ID: <CAHC9VhRG9jD3JPbf==Bo0B+cyMG8mrQnM=RyoxenqxqePdRdsw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add LSM access controls and auditing to io_uring
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        io-uring@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 21, 2021 at 8:53 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2021/05/22 6:49, Paul Moore wrote:
> > I've provided the SELinux
> > implementation, Casey has been nice enough to provide a Smack patch,
> > and John is working on an AppArmor patch as I write this.  I've
> > mentioned this work to the other LSM maintainers that I believe might
> > be affected but I have not heard back from anyone else at this point.
>
> I don't think any change is required for TOMOYO, for TOMOYO does not
> use "struct cred"->security where [RFC PATCH 8/9] and [RFC PATCH 9/9]
> are addressing, and TOMOYO does not call kernel/audit*.c functions.

Good to know, thank you for checking.

-- 
paul moore
www.paul-moore.com
