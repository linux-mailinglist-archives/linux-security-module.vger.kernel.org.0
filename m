Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFA17B3773
	for <lists+linux-security-module@lfdr.de>; Fri, 29 Sep 2023 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjI2QEH (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 29 Sep 2023 12:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjI2QEH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Sep 2023 12:04:07 -0400
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA0A1B4
        for <linux-security-module@vger.kernel.org>; Fri, 29 Sep 2023 09:04:04 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RxwBq0Mp2zMqF4w;
        Fri, 29 Sep 2023 16:04:03 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RxwBn61fdzr1;
        Fri, 29 Sep 2023 18:04:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1696003442;
        bh=CMlikyU4Judx0co7OWrQWMzjDIrDxc++8ElpfXH0CmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wkh0xDBBphMQb0NXKRnQh+8C7tCsaUGDFofPzCkUBaHES8bldLo2PGZs38Nx+SjOA
         HnhNFgszNsOp4QDWoRcHTVykilOLYvZW1VXa0nXy6m03i/I8qLomRLuQ1YxFSQES8T
         x7Vjm+7bub9l81NIXLEdxyiXBhnZDM4LY7Qw+T6o=
Date:   Fri, 29 Sep 2023 18:04:00 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Jeff Xu <jeffxu@google.com>
Cc:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Ben Scarlato <akhna@google.com>,
        =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 5/7] landlock: Log file-related requests
Message-ID: <20230929.Zausiachi5Eu@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
 <20230921061641.273654-6-mic@digikod.net>
 <CALmYWFubLv+yd9NWMMwt4FUdYnbghMC=GHeZm4oaSOctqnwbVA@mail.gmail.com>
 <20230926.di9Esee2xahi@digikod.net>
 <CALmYWFuerqvZ3HoUnc9xXYhR8vBgg9qAyA-ncHai4ksN-c-gGQ@mail.gmail.com>
 <20230928.Haewoh8Aishe@digikod.net>
 <CALmYWFvT8EBh+DwW0gw8yU36FKQxtsmO2s5sU6DD8_pfA9yxYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFvT8EBh+DwW0gw8yU36FKQxtsmO2s5sU6DD8_pfA9yxYg@mail.gmail.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 28, 2023 at 01:04:01PM -0700, Jeff Xu wrote:
> On Thu, Sep 28, 2023 at 8:16 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Tue, Sep 26, 2023 at 02:19:51PM -0700, Jeff Xu wrote:
> > > On Tue, Sep 26, 2023 at 6:35 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > >
> > > > On Mon, Sep 25, 2023 at 06:26:28PM -0700, Jeff Xu wrote:
> > > > > On Wed, Sep 20, 2023 at 11:17 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > >
> > > > > > Add audit support for mkdir, mknod, symlink, unlink, rmdir, truncate,
> > > > > > and open requests.
> > > > > >
> > > > > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > > > > ---
> > > > > >  security/landlock/audit.c | 114 ++++++++++++++++++++++++++++++++++++++
> > > > > >  security/landlock/audit.h |  32 +++++++++++
> > > > > >  security/landlock/fs.c    |  62 ++++++++++++++++++---
> > > > > >  3 files changed, 199 insertions(+), 9 deletions(-)
> > > > > >
> > > >
> > > > > > +static void
> > > > > > +log_request(const int error, struct landlock_request *const request,
> > > > > > +           const struct landlock_ruleset *const domain,
> > > > > > +           const access_mask_t access_request,
> > > > > > +           const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
> > > > > > +{
> > > > > > +       struct audit_buffer *ab;
> > > > > > +
> > > > > > +       if (WARN_ON_ONCE(!error))
> > > > > > +               return;
> > > > > > +       if (WARN_ON_ONCE(!request))
> > > > > > +               return;
> > > > > > +       if (WARN_ON_ONCE(!domain || !domain->hierarchy))
> > > > > > +               return;
> > > > > > +
> > > > > > +       /* Uses GFP_ATOMIC to not sleep. */
> > > > > > +       ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
> > > > > > +                            AUDIT_LANDLOCK);
> > > > > > +       if (!ab)
> > > > > > +               return;
> > > > > > +
> > > > > > +       update_request(request, domain, access_request, layer_masks);
> > > > > > +
> > > > > > +       log_task(ab);
> > > > > > +       audit_log_format(ab, " domain=%llu op=%s errno=%d missing-fs-accesses=",
> > > > > > +                        request->youngest_domain,
> > > > > > +                        op_to_string(request->operation), -error);
> > > > > > +       log_accesses(ab, request->missing_access);
> > > > > > +       audit_log_lsm_data(ab, &request->audit);
> > > > > > +       audit_log_end(ab);
> > > > > > +}
> > > > > > +
> > > > > > +// TODO: Make it generic, not FS-centric.
> > > > > > +int landlock_log_request(
> > > > > > +       const int error, struct landlock_request *const request,
> > > > > > +       const struct landlock_ruleset *const domain,
> > > > > > +       const access_mask_t access_request,
> > > > > > +       const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
> > > > > > +{
> > > > > > +       /* No need to log the access request, only the missing accesses. */
> > > > > > +       log_request(error, request, domain, access_request, layer_masks);
> > > > > > +       return error;
> > > > > > +}
> > > >
> > > > > > @@ -636,7 +638,8 @@ static bool is_access_to_paths_allowed(
> > > > > >  }
> > > > > >
> > > > > >  static int current_check_access_path(const struct path *const path,
> > > > > > -                                    access_mask_t access_request)
> > > > > > +                                    access_mask_t access_request,
> > > > > > +                                    struct landlock_request *const request)
> > > > > >  {
> > > > > >         const struct landlock_ruleset *const dom =
> > > > > >                 landlock_get_current_domain();
> > > > > > @@ -650,7 +653,10 @@ static int current_check_access_path(const struct path *const path,
> > > > > >                                        NULL, 0, NULL, NULL))
> > > > > >                 return 0;
> > > > > >
> > > > > > -       return -EACCES;
> > > > > > +       request->audit.type = LSM_AUDIT_DATA_PATH;
> > > > > > +       request->audit.u.path = *path;
> > > > > > +       return landlock_log_request(-EACCES, request, dom, access_request,
> > > > > > +                                   &layer_masks);
> > > > >
> > > > > It might be more readable to let landlock_log_request return void.
> > > > > Then the code will look like below.
> > > > >
> > > > > landlock_log_request(-EACCES, request, dom, access_request,  &layer_masks);
> > > > > return -EACCES;
> > > > >
> > > > > The allow/deny logic will be in this function, i.e. reader
> > > > > doesn't need to check landlock_log_request's implementation to find
> > > > > out it never returns 0.
> > > >
> > > > I did that in an early version of this patch, but I finally choose to write
> > > > 'return lanlock_log_request();` for mainly two reasons:
> > > > * to help not forget to call this function at any non-zero return values
> > > >   (which can easily be checked with grep),
> > >
> > > "grep -A 2 landlock_log_request" would serve the same purpose though.
> >
> > Yes, there is always a way to find a pattern, and the best tool might be
> > Coccinelle, but I think it's harder to miss with such tail calls.
> >
> > >
> > > > * to do tail calls.
> > > >
> > > > I guess compiler should be smart enough to do tail calls with a variable
> > > > set indirection, but I'd like to check that.
> > > >
> > >
> > > What are tail calls and what is the benefit of this code pattern ?
> > > i.e. pass the return value into landlock_log_request() and make it a
> > > single point of setting return value for all landlock hooks.
> >
> > landlock_log_request() should only be called at the end of LSM hooks.
> > Tail calls is basically when you call a function at the end of the
> > caller. This enables replacing "call" with "jmp" and save stack space.
> > landlock_log_request() can fit with this pattern (if not using the
> > caller's stack, which is not currently the case). See this tail call
> > optimization example: https://godbolt.org/z/r88ofcW6x
> >
> Thanks for giving the context of the tail call.
> Compile options are controlled by makefile, and can be customized. In
> the past, I have had different projects setting different O levels for
> various reasons, including disable optimization completely. Individual
> Compiler implementation  also matters, gcc vs clang, etc. I think the
> tail call is probably not essential to the discussion.
> 
> > I find it less error prone to not duplicate the error code (once for
> > landlock_log_request and another for the caller's returned value). I
> > also don't really see the pro of using a variable only to share this
> > value. In ptrace.c, an "err" variable is used to check if the error is 0
> > or not, but that is handled differently for most hooks.
> >
> > Makeing landlock_log_request() return a value also encourages us (thanks
> > to compiler warnings) to use this value and keep the error handling
> > consistent (especially for future code).
> >
> One general assumption about logging function is that it is not part
> of the main business logic, i.e. if the logging statement is
> removed/commented out, it doesn't have side effects to the main
> business logic. This is probably why most log functions return void.

I get it. We need to be careful not to add blind spots though. If audit
is not compiled, the inline function call will just be removed.
Otherwise, logging or not depends on the audit framework and the runtime
configuration.

Another thing to keep in mind is that for now, if the log failed somehow
(e.g. because of not enough memory), it will not impact the decision
(either accept or deny). However, I guess we may want to be able to
control this behavior is some cases one day, and in this case the log
function needs to return an error.

> 
> > Another feature that I'd like to add is to support a "permissive mode",
> > that would enable to quickly see the impact of a sandbox without
> > applying it for real. This might change some landlock_log_request()
> > calls, so we'll see what fits best.
> >
> It is an excellent feature to have.
> To implement that, I guess there will be a common function as a switch
> to allow/deny, and logging the decision, depending on the permissive
> setting.

Permissive mode will be per domain/sandbox, so it will add complexity to
the current logging mechanism, but that is worth it.

> From that point, preparing the code towards that goal makes sense.
> 
> > >
> > > > To make it easier to read (and to not forget returning the error), the
> > > > landlock_log_request() calls a void log_request() helper, and returns
> > > > the error itself. It is then easy to review and know what's happening
> > > > without reading log_request().
> > > >
> > > > I'd like the compiler to check itself that every LSM hook returned
> > > > values are either 0 or comming from landlock_log_request() but I think
> > > > it's not possible right now. Coccinelle might help here though.
> > > >
> > > > BTW, in a next version, we might have landlock_log_request() called even
> > > > for allowed requests (i.e. returned value of 0).
> When there is more business logic to landlock_log_request, it is
> probably better to rename the function. Most devs might assume the log
> function does nothing but logging.  Having some meaningful name, e.g.
> check_permissive_and_audit_log,  will help with readability.

As for the permissive mode, this would be per domain.

I'd like to keep the audit.h functions with the same prefix.
What about landlock_log_result()?

> 
> Thanks!
> -Jeff
