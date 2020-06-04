Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506EB1ED989
	for <lists+linux-security-module@lfdr.de>; Thu,  4 Jun 2020 01:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgFCXfQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 3 Jun 2020 19:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgFCXfP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Jun 2020 19:35:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3C5C08C5C0
        for <linux-security-module@vger.kernel.org>; Wed,  3 Jun 2020 16:35:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z5so4045023ejb.3
        for <linux-security-module@vger.kernel.org>; Wed, 03 Jun 2020 16:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4W+pwBV/mV37XypbafarSnoIpb157MO7R0Lt+xMM2XY=;
        b=IrVDJRYBvShwaz9jFI1Vg8hoNLNLP8LAt3BGU3N4cSS1dFwNh596fdNHNruj/106sE
         KaI75eZ69dRttV4MoxtGRt5SIEoAgrvFosoCHmeMOj0MSop1p32uWtrURygHuy8Ale7L
         uefIOZAFLT+aeyv9zWUcFHlYSTpdUDMeJYE0v9dDPPZQaCaFuFqltHL3laGRipjMLOaV
         VhV7aDpO9DsZypYp3owSl8jm1L4H1HlwtD76StMd+H4sbmj8NEpH8Pl5A6mDVk26qrdr
         KOuS4CE29fM87rjTLr0H3LAZAEewxRL5Qk2yc33IMUrhKHQMrmMhg8suhNHcg/D48OTI
         taIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4W+pwBV/mV37XypbafarSnoIpb157MO7R0Lt+xMM2XY=;
        b=ep6WrrRQUeBU17oemuDZhgVdILtWIOWfR2VkrRXNdueC3tyUXe8RXxmocgnnSv/pe0
         g1ZsDUMKl1ewN883Kk4oWLm55dLDgDRwQydW0WvMInkdTB5e+4QayrGKwKdigsnuUXww
         p9XCECZRgR11ruzoaNaESajLPoUT0Jn46W68W6Vn6Sq8n1lgCrn7XZi6Nqn+QeQFigI7
         +gXMJRnGfSGkqzUv22vep34mJa+FIqM40DPyJGMpGabg3T1oriRVqH/XvLU+LeIakIzo
         ug1oHIkT8N/GrR4j6AtnbTUL1faYQTR9GvrOelxOnzOOZeBabl1NAAZht9q1kJl3n+5L
         m43A==
X-Gm-Message-State: AOAM533tMJhdrfSh8eul1i6t+WHorntZ3mUQcwyE03CDpSkyHVoWddX5
        uofUEIv9eB4/uYGeN1io7q09B5xo0+BCNysZmI+b13A=
X-Google-Smtp-Source: ABdhPJwbAgFPcW4CnxOHA+T2vCRxymvldOOhJdNZSzkxO/F/g4D4h2BhGj5/BGVl+Eao8KqaCdecIrkORsqYCgYHREQ=
X-Received: by 2002:a17:906:19d3:: with SMTP id h19mr1534177ejd.106.1591227313295;
 Wed, 03 Jun 2020 16:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
 <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
In-Reply-To: <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 3 Jun 2020 19:35:02 -0400
Message-ID: <CAHC9VhQN3TvY5ZTnPu76La89tkdnLXhrrbxWocv5F4ygVyG+-Q@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 2, 2020 at 8:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Side note since you mention performance work: in the past when I've
> looked at SELinux performance (generally as part of pathname lookup
> etc VFS loads), the biggest cost by far was that all the SELinux data
> structures take a ton of cache misses.
>
> Yes, some of the hashing shows up in the profiles, but _most_ of it
> was loading the data from inode->i_security etc.
>
> And the reason seemed to be that every single inode ends up having a
> separately allocated "struct inode_security_struct" (aka "isec"). Even
> if the contents are often all exactly the same for a large set of
> inodes that thus _could_ conceptually share the data.
>
> Now, it used to be - before being able to stack security layers -
> SElinux would control that pointer, and it could have done some kind
> of sharing scheme with copy-on-write behavior (the way we do 'struct
> cred' for processes), and it would have caused a much smaller cache
> footprint (and thus likely much fewer cache misses).

I believe right about the time that Eric Paris was stepping away from
SELinux he was working on a patchset that basically did what you
describe: copy-on-write for the SELinux inode blobs (aka
inode_security_struct, aka isec, etc.).  Unfortunately I don't believe
that work was ever finished and the idea was lost many years ago in
the maintainer shuffle; I was trying to figure out this whole
"maintainer thing" and perhaps didn't push Eric to post those patches
as much as I should have.  Although it's a big academic now with the
LSM stacking work.

Most of my SELinux thoughts these days are around the correctness and
robustness of the code, making sure we are testing as much as possible
(related to the first point), and trying to catch changes in other
subsystems which cause us breakage.  Not the most glamorous stuff, but
it's important.  SELinux is lucky enough to have a few active kernel
developers, and thankfully a couple of them appear to be looking at
some of the performance issues.

> These days, that sharing of the i_security pointer across different
> security layers makes that sound really really painful.

Yeah.  It's pretty much impossible now to do copy-on-write with the
main security blobs due to the differing nature of the LSMs and the
single, shared allocation for each blob.  I suppose if you wanted to
attempt copy-on-write inside a LSM you could introduce another layer
of pointers/allocation, but I'm not sure how much of an improvement
that might be.

Perhaps a bit more thought will produce a "eureka!" moment, but I'm
not overly optimistic.

> But I do wonder if anybody in selinux land (or general security
> subsystem land) has been thinking of maybe at least having a "this
> inode has no special labeling" marker that could possibly avoid having
> all those extra allocations.

I don't want to get into the "security people can't agree on anything"
discussion, but I think for that to work all of the loaded LSMs would
need to agree that they don't need to stash anything in the inode (or
other object); which I think is pretty much impossible most of the
time.  At least in the SELinux case, even if we were doing some sort
of copy-on-write, we would need to keep a reference back to the inode
security blob that does contain our needed info.

-- 
paul moore
www.paul-moore.com
