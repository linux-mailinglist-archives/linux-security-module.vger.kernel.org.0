Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D096F3A0A1B
	for <lists+linux-security-module@lfdr.de>; Wed,  9 Jun 2021 04:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhFICmd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 8 Jun 2021 22:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhFICmd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Jun 2021 22:42:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE67C061756
        for <linux-security-module@vger.kernel.org>; Tue,  8 Jun 2021 19:40:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t3so26905748edc.7
        for <linux-security-module@vger.kernel.org>; Tue, 08 Jun 2021 19:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+D0KtrR3ySKv9LEuftUeYWRIhXsDsdXtnrq6QYaDHk=;
        b=syy+MK4mAE5Ta3E44ycW61wKy+jm9LP5Fc8EsQgZPGGAsTggdfkkW77kT5EhJwXDKl
         I+XPhfw/dXEghiCZs+YwRrNu+QpDXlaSfO/oKAb3I25xjfc8AB1U4a1ug6DK5nq6fYyd
         z9Ahfz+gjJW/7LpiY87jTM3q+tmyvsVG2oHfqF/LMJWBYmBstCFvwwO3/CP2by6a4IoJ
         sYhO8Ck/O8z3eqgK6CIN/U8YILwblIfkNFy6M7Q/dd80PdTlxn/YDmRgNboQf0VetYHO
         CGv/VWscu7/9Z3LqyQEyL2oBD8RrzzNvbEnOuZ+GEyqpWIc0GYBpGEuy4OTtiwh7w7tj
         FGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+D0KtrR3ySKv9LEuftUeYWRIhXsDsdXtnrq6QYaDHk=;
        b=Oc2DoIz0uz+qbIJZfLXzU7tTtt0uvNvOTlmO8FOX/UNj8OGNAGZWOECZ0WmRUaWnJd
         N1zasR1aico2mKPU5TS8DHcdAvaxHCjVkZzlboU4JoCvuGmKu95UiIBmlwFA/V8C0qpr
         sOBcl8fpD9+0aGA9JyY3FpSvzwhT5Xxx1tR1WQ/z3fYTaPpMYsEU+TON0tEZyZbeS7aK
         cA36nPt6EChV42OjQ3UCq3DGNcWj/bmJYvE7xNcz4t2v6zuxyJCo9NwNLnAl8+GuEcKT
         ChHuT4v519cNgEkx/RskEbvLfG4HuwN3O29bDwvswTPSAz1KRgR258tnQND7JHfGR6Fm
         GrNQ==
X-Gm-Message-State: AOAM530DC5ObcqcNbjDZdfx2RNMmlnPSAqO/zoCnbxiE9+QjHC/tWVjm
        o2jIsH6ItoqFqSWATcrSeyEKc3xxtXhOM7Nd4vqz
X-Google-Smtp-Source: ABdhPJwft6pcgB0QhLBi7pt1iV0pHMufLyRKQEjEH8t6ci5z3HEcu7wmJlWNIAy6UnuWowq/YZCxYIxjO4ZEPjn7Lg0=
X-Received: by 2002:a05:6402:348f:: with SMTP id v15mr16610509edc.135.1623206426948;
 Tue, 08 Jun 2021 19:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092006.803332-1-omosnace@redhat.com> <CAHC9VhTasra0tU=bKwVqAwLRYaC+hYakirRz0Mn5jbVMuDkwrA@mail.gmail.com>
 <CAFqZXNsh9njbFUNBugidbdiNqD3QbKzsw=KgNKSmW5hv-fD6tA@mail.gmail.com>
 <CAHC9VhQj_FvBqSGE+eZtbzvDoRAEbbo-6t_2E6MVuyiGA9N8Hw@mail.gmail.com> <CAFqZXNsVFv2yh5cXwWYXscYTAuoCKk4H-JbPAYzDbwKUzSDP3A@mail.gmail.com>
In-Reply-To: <CAFqZXNsVFv2yh5cXwWYXscYTAuoCKk4H-JbPAYzDbwKUzSDP3A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Jun 2021 22:40:15 -0400
Message-ID: <CAHC9VhSNWK11f+u8v+MN0VHC3_4u+30jom80rwaat8OsJKo5fQ@mail.gmail.com>
Subject: Re: [PATCH v2] lockdown,selinux: avoid bogus SELinux lockdown
 permission checks
To:     Ondrej Mosnacek <omosnace@redhat.com>
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
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 8, 2021 at 7:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Jun 3, 2021 at 7:46 PM Paul Moore <paul@paul-moore.com> wrote:

...

> > It sounds an awful lot like the lockdown hook is in the wrong spot.
> > It sounds like it would be a lot better to relocate the hook than
> > remove it.
>
> I don't see how you would solve this by moving the hook. Where do you
> want to relocate it?

Wherever it makes sense.  Based on your comments it really sounded
like the hook was in a bad spot and since your approach in a lot of
this had been to remove or disable hooks I wanted to make sure that
relocating the hook was something you had considered.  Thankfully it
sounds like you have considered moving the hook - that's good.

> The main obstacle is that the message containing
> the SA dump is sent to consumers via a simple netlink broadcast, which
> doesn't provide a facility to redact the SA secret on a per-consumer
> basis. I can't see any way to make the checks meaningful for SELinux
> without a major overhaul of the broadcast logic.

Fair enough.

-- 
paul moore
www.paul-moore.com
