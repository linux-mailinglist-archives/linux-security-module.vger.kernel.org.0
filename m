Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE252655E7
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Sep 2020 02:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgIKACb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 10 Sep 2020 20:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgIKACZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Sep 2020 20:02:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657B7C061757
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2020 17:02:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e23so11324101eja.3
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2020 17:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JhzWeBi98uxge5Nl6JBsweyqdcSVY7AXtn8+FM0wSrE=;
        b=rnRu5BQ39GIwkamlytlKQmPZIKMfKBaWA1lS6u7txSlp88YIhkgh4Ikh/BkD2VooC0
         Aqx2tV227t/q0hU7LxaBwj94TDuh22rSbw4vLxkEbDFXzYBT7LefF2I/axBOnrs01F42
         X/swFpSTGtknqcSv/1DR81oljlbK606giguTiYPcnfiSe5mxUg9id6uwA1iFWJ02pbfo
         kkwSgpD5Zir6FPSfU4ffjsb5kVWDJ2siaXrOY3Zx4u8daVswlC6DFIAft9zLt98Y8r5e
         XlfvSX71WcoF1DP0i71dEov2Rm7pZ3uhwGvDhxfneGMGVF22rb6/TE0FT31kA4mLg0Y9
         7FFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JhzWeBi98uxge5Nl6JBsweyqdcSVY7AXtn8+FM0wSrE=;
        b=CrDPiIF2uF2P2m6FtlOushQQGm/lAMDhQ2lWY1fKR7Y1B7c13K9EaRMdgwK6/fgitK
         wOlRnwnWOoEUPdMIF7kk5tq42G4BkaB0gSXiw9IT2U+ZpLPv7d3rYQb2KT8pBqYBHApc
         vYauhZLQQdFBxEg/JduWkwai3aW8bC1RGFKpAOOfeEqdivjUwOyuPLVV28b4Cg8HcPUb
         IKbF53ZdjZ/gJnm/m2Msqx3L5ty77awV8oQ3meFjEUSYSTS6MeCBGrglA7rmiLpZkDxe
         imIxMG1w6DfbF41v+zxjOGi7o+pdsfJwxFlZLU4Y02+uZEFM0fwOY+MkE/RDPxLDiiBf
         R7Bw==
X-Gm-Message-State: AOAM53017gdrBhfjUlkR1m2La5cUnEdlRj/Y4QBa6/wtiK92U6koqn30
        exHdn2RYM9ZxVLIwk6q2ax8ZJus1lBJMddr1qyE96w==
X-Google-Smtp-Source: ABdhPJzqjd13RuBCERWCNKaIjZBQ1L7nXsBk6lxn6abKKBWrWwwFaxOFeoAHNmmQyEOac8m4z/LctrardqgtakRoM9k=
X-Received: by 2002:a17:906:a0c2:: with SMTP id bh2mr11828231ejb.493.1599782542769;
 Thu, 10 Sep 2020 17:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-6-keescook@chromium.org> <202009101634.52ED6751AD@keescook>
In-Reply-To: <202009101634.52ED6751AD@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 11 Sep 2020 02:01:56 +0200
Message-ID: <CAG48ez2fP7yupg6Th+Hg0tL3o06p2PR1HtQcvy4Ro+Q5T2Nfkw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] security/fbfam: Detect a fork brute force attack
To:     Kees Cook <keescook@chromium.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 11, 2020 at 1:49 AM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 10, 2020 at 01:21:06PM -0700, Kees Cook wrote:
> > From: John Wood <john.wood@gmx.com>
> >
> > To detect a fork brute force attack it is necessary to compute the
> > crashing rate of the application. This calculation is performed in each
> > fatal fail of a task, or in other words, when a core dump is triggered.
> > If this rate shows that the application is crashing quickly, there is a
> > clear signal that an attack is happening.
> >
> > Since the crashing rate is computed in milliseconds per fault, if this
> > rate goes under a certain threshold a warning is triggered.
> >
> > Signed-off-by: John Wood <john.wood@gmx.com>
> > ---
> >  fs/coredump.c          |  2 ++
> >  include/fbfam/fbfam.h  |  2 ++
> >  security/fbfam/fbfam.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 43 insertions(+)
> >
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index 76e7c10edfc0..d4ba4e1828d5 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -51,6 +51,7 @@
> >  #include "internal.h"
> >
> >  #include <trace/events/sched.h>
> > +#include <fbfam/fbfam.h>
> >
> >  int core_uses_pid;
> >  unsigned int core_pipe_limit;
> > @@ -825,6 +826,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> >  fail_creds:
> >       put_cred(cred);
> >  fail:
> > +     fbfam_handle_attack(siginfo->si_signo);
>
> I don't think this is the right place for detecting a crash -- isn't
> this only for the "dumping core" condition? In other words, don't you
> want to do this in get_signal()'s "fatal" block? (i.e. very close to the
> do_coredump, but without the "should I dump?" check?)
>
> Hmm, but maybe I'm wrong? It looks like you're looking at noticing the
> process taking a signal from SIG_KERNEL_COREDUMP_MASK ?
>
> (Better yet: what are fatal conditions that do NOT match
> SIG_KERNEL_COREDUMP_MASK, and should those be covered?)
>
> Regardless, *this* looks like the only place without an LSM hook. And it
> doesn't seem unreasonable to add one here. I assume it would probably
> just take the siginfo pointer, which is also what you're checking.

Good point, making this an LSM might be a good idea.

> e.g. for include/linux/lsm_hook_defs.h:
>
> LSM_HOOK(int, 0, task_coredump, const kernel_siginfo_t *siginfo);

I guess it should probably be an LSM_RET_VOID hook? And since, as you
said, it's not really semantically about core dumping, maybe it should
be named task_fatal_signal or something like that.
