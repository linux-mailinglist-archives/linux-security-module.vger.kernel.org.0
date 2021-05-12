Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B7437CF08
	for <lists+linux-security-module@lfdr.de>; Wed, 12 May 2021 19:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhELRIE (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 12 May 2021 13:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244348AbhELQpp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 May 2021 12:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620837874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1wT9y/+CUxpw2t+GrCY0Qp+nfyUTGHKVjJx14ixlaYw=;
        b=Ef0LUMNJ+2iDUklUtfj2fdV2HB1I/+d678yNRRsNH0CmZj2p6+sv+xWuwkLgMvaclkBbe9
        baMOvRkm/NTiCSawZeWMKdHs7NMcV0vHrjipIl5adLaZjYulxItr4wnA8KimvrvJHa7rfU
        iGSsuBwZJhcEV4PMOmsBy7npFV2cWyA=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-7yKNwMCZMICZqMi8Mrl8HA-1; Wed, 12 May 2021 12:44:33 -0400
X-MC-Unique: 7yKNwMCZMICZqMi8Mrl8HA-1
Received: by mail-yb1-f199.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so28675829ybo.11
        for <linux-security-module@vger.kernel.org>; Wed, 12 May 2021 09:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wT9y/+CUxpw2t+GrCY0Qp+nfyUTGHKVjJx14ixlaYw=;
        b=Tba/GX376ZziqeLy+AGvevO/nz6NGdfHB+orIrXFQ1+fE41MppTpItTy9A50xX9bIc
         2EpFDZQtN1DwiBXcd9cN2GAJw2QLE9PKUp3aFH7beN6nW2y0fGlir8OBN4yXQNE4SQwq
         2PCv7s/s7CsvMVm6KQWZHpXSS3S9+B9hwlxaiIHf0XUgBhymAwsl0Hi4u1y/FWf/L9d8
         mCB8aPMS3rfr+z5HnePO5UrbyUI0nSxIJJg/cKgmQhB54YpMX8EJCLF+l24GitqKvUhM
         baZB9rGyXUwAqc+aqlO7P7agrGbXgUwtbfxj9cCNZBz4x1QuJezZOYr1Ta6Tncz8zQmu
         VC4Q==
X-Gm-Message-State: AOAM5338Hx25xeD8jNkL12CzJok1/rc9PKlcdbRVsnNSfIE2bFq5khM0
        ZAijLMxfgBLHbGsfvZg//oPNVNs48ooEvDELTb9dcweyk90jqk94nV9B+aproG2bJw759sTHmQv
        KinfJX/7ru/B8F1DpoiItrrENWUUd4UgEhrAAPafxr4uGISON23dA
X-Received: by 2002:a25:6886:: with SMTP id d128mr49884189ybc.227.1620837872715;
        Wed, 12 May 2021 09:44:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziai7GI5a1DWeJt0YlXK6570k2N9+Sy1G9tLOxLGUvPGU+rPfrJ8aFA1k+I7x/KZgli19pSgP+PzUsymRQT9M=
X-Received: by 2002:a25:6886:: with SMTP id d128mr49884143ybc.227.1620837872433;
 Wed, 12 May 2021 09:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210507114048.138933-1-omosnace@redhat.com> <a8d138a6-1d34-1457-9266-4abeddb6fdba@schaufler-ca.com>
 <CAFqZXNtr1YjzRg7fTm+j=0oZF+7C5xEu5J0mCZynP-dgEzvyUg@mail.gmail.com> <24a61ff1-e415-adf8-17e8-d212364d4b97@schaufler-ca.com>
In-Reply-To: <24a61ff1-e415-adf8-17e8-d212364d4b97@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 12 May 2021 18:44:21 +0200
Message-ID: <CAFqZXNvB-EyPz1Qz3cCRTr1u1+D+xT-dp7cUxFocYM1AOYSuxw@mail.gmail.com>
Subject: Re: [PATCH] lockdown,selinux: fix bogus SELinux lockdown permission checks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, network dev <netdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 12, 2021 at 6:18 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/12/2021 6:21 AM, Ondrej Mosnacek wrote:
> > On Sat, May 8, 2021 at 12:17 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 5/7/2021 4:40 AM, Ondrej Mosnacek wrote:
> >>> Commit 59438b46471a ("security,lockdown,selinux: implement SELinux
> >>> lockdown") added an implementation of the locked_down LSM hook to
> >>> SELinux, with the aim to restrict which domains are allowed to perform
> >>> operations that would breach lockdown.
> >>>
> >>> However, in several places the security_locked_down() hook is called in
> >>> situations where the current task isn't doing any action that would
> >>> directly breach lockdown, leading to SELinux checks that are basically
> >>> bogus.
> >>>
> >>> Since in most of these situations converting the callers such that
> >>> security_locked_down() is called in a context where the current task
> >>> would be meaningful for SELinux is impossible or very non-trivial (and
> >>> could lead to TOCTOU issues for the classic Lockdown LSM
> >>> implementation), fix this by adding a separate hook
> >>> security_locked_down_globally()
> >> This is a poor solution to the stated problem. Rather than adding
> >> a new hook you should add the task as a parameter to the existing hook
> >> and let the security modules do as they will based on its value.
> >> If the caller does not have an appropriate task it should pass NULL.
> >> The lockdown LSM can ignore the task value and SELinux can make its
> >> own decision based on the task value passed.
> > The problem with that approach is that all callers would then need to
> > be updated and I intended to keep the patch small as I'd like it to go
> > to stable kernels as well.
> >
> > But it does seem to be a better long-term solution - would it work for
> > you (and whichever maintainer would be taking the patch(es)) if I just
> > added another patch that refactors it to use the task parameter?
>
> I can't figure out what you're suggesting. Are you saying that you
> want to add a new hook *and* add the task parameter?

No, just to keep this patch as-is (and let it go to stable in this
form) and post another (non-stable) patch on top of it that undoes the
new hook and re-implements the fix using your suggestion. (Yeah, it'll
look weird, but I'm not sure how better to handle such situation - I'm
open to doing it whatever different way the maintainers prefer.)

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

