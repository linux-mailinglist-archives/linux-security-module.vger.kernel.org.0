Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C5121F870
	for <lists+linux-security-module@lfdr.de>; Tue, 14 Jul 2020 19:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgGNRoN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 14 Jul 2020 13:44:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55900 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725951AbgGNRoN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 13:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594748651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fRu/5iacxmutQ7kMDS7dLLg3NGipwsCDb2mhidsZLDQ=;
        b=SdLC+hRjGbawbjMWTFzuTQ/PqMmZ0MyUKz0BM3SA7Ly50U7OP/acWB5LquJhv/HwR/aVYi
        Ch+ldf8ziGWJdcDoEXDw1H84Q6rFEXjQcoxyhQO34LXZdpztKHsJq21RLKZkpUOB/PRWiu
        qleJFYHRzRW1mCaREC317+4B1PT/N9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164--oAd_irlPMmMGcwJY665gQ-1; Tue, 14 Jul 2020 13:44:05 -0400
X-MC-Unique: -oAd_irlPMmMGcwJY665gQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741CF100CCC4;
        Tue, 14 Jul 2020 17:44:04 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9E786FEDF;
        Tue, 14 Jul 2020 17:43:56 +0000 (UTC)
Date:   Tue, 14 Jul 2020 13:43:53 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, john.johansen@canonical.com
Subject: Re: [PATCH ghak84 v4] audit: purge audit_log_string from the
 intra-kernel audit API
Message-ID: <20200714174353.ds7lj3iisy67t2zu@madcap2.tricolour.ca>
References: <6effbbd4574407d6af21162e57d9102d5f8b02ed.1594664015.git.rgb@redhat.com>
 <CAHC9VhSyq7yKQqwvHL5syU9+TFki6-__WfCrvqewbnU3xpND4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSyq7yKQqwvHL5syU9+TFki6-__WfCrvqewbnU3xpND4Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020-07-14 12:21, Paul Moore wrote:
> On Mon, Jul 13, 2020 at 3:52 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > audit_log_string() was inteded to be an internal audit function and
> > since there are only two internal uses, remove them.  Purge all external
> > uses of it by restructuring code to use an existing audit_log_format()
> > or using audit_log_format().
> >
> > Please see the upstream issue
> > https://github.com/linux-audit/audit-kernel/issues/84
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > Passes audit-testsuite.
> >
> > Changelog:
> > v4
> > - use double quotes in all replaced audit_log_string() calls
> >
> > v3
> > - fix two warning: non-void function does not return a value in all control paths
> >         Reported-by: kernel test robot <lkp@intel.com>
> >
> > v2
> > - restructure to piggyback on existing audit_log_format() calls, checking quoting needs for each.
> >
> > v1 Vlad Dronov
> > - https://github.com/nefigtut/audit-kernel/commit/dbbcba46335a002f44b05874153a85b9cc18aebf
> >
> >  include/linux/audit.h     |  5 -----
> >  kernel/audit.c            |  4 ++--
> >  security/apparmor/audit.c | 10 ++++------
> >  security/apparmor/file.c  | 25 +++++++------------------
> >  security/apparmor/ipc.c   | 46 +++++++++++++++++++++++-----------------------
> >  security/apparmor/net.c   | 14 ++++++++------
> >  security/lsm_audit.c      |  4 ++--
> >  7 files changed, 46 insertions(+), 62 deletions(-)
> 
> Thanks for restoring the quotes, just one question below ...
> 
> > diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
> > index 4ecedffbdd33..fe36d112aad9 100644
> > --- a/security/apparmor/ipc.c
> > +++ b/security/apparmor/ipc.c
> > @@ -20,25 +20,23 @@
> >
> >  /**
> >   * audit_ptrace_mask - convert mask to permission string
> > - * @buffer: buffer to write string to (NOT NULL)
> >   * @mask: permission mask to convert
> > + *
> > + * Returns: pointer to static string
> >   */
> > -static void audit_ptrace_mask(struct audit_buffer *ab, u32 mask)
> > +static const char *audit_ptrace_mask(u32 mask)
> >  {
> >         switch (mask) {
> >         case MAY_READ:
> > -               audit_log_string(ab, "read");
> > -               break;
> > +               return "read";
> >         case MAY_WRITE:
> > -               audit_log_string(ab, "trace");
> > -               break;
> > +               return "trace";
> >         case AA_MAY_BE_READ:
> > -               audit_log_string(ab, "readby");
> > -               break;
> > +               return "readby";
> >         case AA_MAY_BE_TRACED:
> > -               audit_log_string(ab, "tracedby");
> > -               break;
> > +               return "tracedby";
> >         }
> > +       return "";
> 
> Are we okay with this returning an empty string ("") in this case?
> Should it be a question mark ("?")?
> 
> My guess is that userspace parsing should be okay since it still has
> quotes, I'm just not sure if we wanted to use a question mark as we do
> in other cases where the field value is empty/unknown.

Previously, it would have been an empty value, not even double quotes.
"?" might be an improvement.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

