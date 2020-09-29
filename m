Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7693F27DCE0
	for <lists+linux-security-module@lfdr.de>; Wed, 30 Sep 2020 01:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgI2XrR (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 29 Sep 2020 19:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgI2XrQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Sep 2020 19:47:16 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17E7206DC;
        Tue, 29 Sep 2020 23:47:13 +0000 (UTC)
Date:   Tue, 29 Sep 2020 19:47:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] security/fbfam: Use the api to manage
 statistics
Message-ID: <20200929194712.541c860c@oasis.local.home>
In-Reply-To: <202009101625.0E3B6242@keescook>
References: <20200910202107.3799376-1-keescook@chromium.org>
        <20200910202107.3799376-4-keescook@chromium.org>
        <202009101625.0E3B6242@keescook>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 10 Sep 2020 16:33:38 -0700
Kees Cook <keescook@chromium.org> wrote:

> > @@ -1940,6 +1941,7 @@ static int bprm_execve(struct linux_binprm *bprm,
> >  	task_numa_free(current, false);
> >  	if (displaced)
> >  		put_files_struct(displaced);
> > +	fbfam_execve();  
> 
> As mentioned in the other emails, I think this could trivially be
> converted into an LSM: all the hooks are available AFAICT. If you only
> want to introspect execve _happening_, you can use bprm_creds_for_exec
> which is called a few lines above. Otherwise, my prior suggestion ("the
> exec has happened" hook via brpm_cred_committing, etc).

And if its information only, you could just register a callback to the
trace_sched_process_exec() tracepoint and do whatever you want then.

The tracepoints are available for anyone to attach to. Not just tracing.

-- Steve
