Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C361D242158
	for <lists+linux-security-module@lfdr.de>; Tue, 11 Aug 2020 22:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgHKUhb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 11 Aug 2020 16:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgHKUh3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Aug 2020 16:37:29 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E74CC061787
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 13:37:27 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d2so7398959lfj.1
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 13:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNIIinuBTqCk7Uyg12I/DJkvJepLgql9JVktVfR2K2A=;
        b=TvjRTcDcWhFga3496uupFKfaQEab1JUXC3X2mygG5evPWDsHJM8BrTMddXc5oYGmei
         1wST7jx1bZB4LpQdhag6vuROaebx1dHSlbhK7Jsk+Kq5hurtCuMzgTjCZvhCAXLCTzbs
         VlCVAClX/OSRetpkCUZBTXxquF9wdzJkNeKhkqCMm7XNIiSOhIWPpWTsGKsarjmOUm+Y
         hRN+52jZ3nDUIdDMG4dDstB1i8cv13C2Fh71ZGEpLcwoYmE03bHXZclX19FI7Z+krk0/
         h7gc1a/wLJ5uRO1iFrPnojPvib2e0iVobckNo2WfnMWffLUCc6vj+Ds4bHe3SYaNN84k
         Wdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNIIinuBTqCk7Uyg12I/DJkvJepLgql9JVktVfR2K2A=;
        b=YCcJV/9OBggObJveaJHmyoma1AGAefTsfZzGCEbnPD/G8drJr3MUsPPyP9JpJtIkQk
         Ya9efpAoS1GMtaeinZkAgXR7+4reF7BpX/A5IQCubZ5QfmzG+b/69HUg/k5cZ5YtSrbV
         TcGwGMw7uGyRA0/8DfF+2cg7J4vJUqvpoC1W6a4ZDImu9Mdu/Sjj7ALo4jLfBjmKyOtp
         Bl+8FbKb7MxvDvL5dqgVj6MwXri6mAudyTr/Rqut5rflxpPxHSzeVd9k9MjHYUIvpJ0R
         RFuMuaQnkGRrTODL6Z2Zy9G9NdSbrF0haizPgdfFdx1rjV3P3UnisfQYbSmvweje3Vji
         XMsQ==
X-Gm-Message-State: AOAM530IyhzzOgamqKW5poFdKozRpsn4YvygTwchAnV9J9JzJXzJ3jHI
        Hj5WZqE/ZGzxfB55jMSGfAbdRwqRzFeizyHulDmZ6w==
X-Google-Smtp-Source: ABdhPJzQ68rpZOC4z0avN1W2jP03Yw2GLQVHhFEaCukIqgGgqC7POMrPQgByw3dBnGXeTs4dAzm/UFtcZMEHfBtyHkQ=
X-Received: by 2002:a19:4844:: with SMTP id v65mr4098353lfa.184.1597178246059;
 Tue, 11 Aug 2020 13:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
In-Reply-To: <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 11 Aug 2020 22:36:58 +0200
Message-ID: <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 11, 2020 at 10:29 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Tue, Aug 11, 2020 at 6:17 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > Since a////////b has known meaning, and lots of applications
> > play loose with '/', its really dangerous to treat the string as
> > special. We only get away with '.' and '..' because their behavior
> > was defined before many of y'all were born.
>
> So the founding fathers have set things in stone and now we can't
> change it.   Right?
>
> Well that's how it looks... but let's think a little; we have '/' and
> '\0' that can't be used in filenames.  Also '.' and '..' are
> prohibited names. It's not a trivial limitation, so applications are
> probably not used to dumping binary data into file names.  And that
> means it's probably possible to find a fairly short combination that
> is never used in practice (probably containing the "/." sequence).
> Why couldn't we reserve such a combination now?

This isn't just about finding a string that "is never used in
practice". There is userspace software that performs security checks
based on the precise semantics that paths have nowadays, and those
security checks will sometimes happily let you use arbitrary binary
garbage in path components as long as there's no '\0' or '/' in there
and the name isn't "." or "..", because that's just how paths work on
Linux.

If you change the semantics of path strings, you'd have to be
confident that the new semantics fit nicely with all the path
validation routines that exist scattered across userspace, and don't
expose new interfaces through file server software and setuid binaries
and so on.

I really don't like this idea.
