Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A7F273358
	for <lists+linux-security-module@lfdr.de>; Mon, 21 Sep 2020 21:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgIUT5S (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 21 Sep 2020 15:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727386AbgIUT5S (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Sep 2020 15:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600718237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fanQEa2AmSeiy1ThJk9VdgXGlrdLlRU5FqdpmIG8pxA=;
        b=RdyLK/gXMiqo+Rt7UsHvqeXTpA1VnwCr6E/82h4GZH3RaH/iLZJd/6w6hXmoVWvzlqQEhs
        jrjnG4S/oyFYp8oTRzC7WyHuT9ct9oM533CMxw4uEdFxtNEtmNNb1wDu4a/ZfqLfRrUJsm
        RmIaVawlafNeBJIzc/6S3R/prMqkcbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-8vuLoSeuO6Gt4XIqVY4cjw-1; Mon, 21 Sep 2020 15:57:12 -0400
X-MC-Unique: 8vuLoSeuO6Gt4XIqVY4cjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91BE5909CAD;
        Mon, 21 Sep 2020 19:57:11 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A65855782;
        Mon, 21 Sep 2020 19:56:59 +0000 (UTC)
Date:   Mon, 21 Sep 2020 15:56:55 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [[PATCH V4]] audit: trigger accompanying records when no rules
 present
Message-ID: <20200921195655.GH822320@madcap2.tricolour.ca>
References: <35f2b8c69b4b9abbc076dd55a6f0f52cf20abad7.1599687447.git.rgb@redhat.com>
 <CAHC9VhRN33KcW2dL1KJZZJC_Sg4JEdBJdnecRz6SB+PQ0BSg9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRN33KcW2dL1KJZZJC_Sg4JEdBJdnecRz6SB+PQ0BSg9A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020-09-15 12:18, Paul Moore wrote:
> On Thu, Sep 10, 2020 at 11:03 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > When there are no audit rules registered, mandatory records (config,
> > etc.) are missing their accompanying records (syscall, proctitle, etc.).
> >
> > This is due to audit context dummy set on syscall entry based on absence
> > of rules that signals that no other records are to be printed.
> >
> > Clear the dummy bit if any record is generated.
> >
> > The proctitle context and dummy checks are pointless since the
> > proctitle record will not be printed if no syscall records are printed.
> >
> > The fds array is reset to -1 after the first syscall to indicate it
> > isn't valid any more, but was never set to -1 when the context was
> > allocated to indicate it wasn't yet valid.
> >
> > The audit_inode* functions can be called without going through
> > getname_flags() or getname_kernel() that sets audit_names and cwd, so
> > set the cwd if it has not already been done so due to audit_names being
> > valid.
> >
> > The LSM dump_common_audit_data() LSM_AUDIT_DATA_NET:AF_UNIX case was
> > missed with the ghak96 patch, so add that case here.
> >
> > Thanks to bauen1 <j2468h@googlemail.com> for reporting LSM situations in
> > which context->cwd is not valid, inadvertantly fixed by the ghak96 patch.
> >
> > Please see upstream github issue
> > https://github.com/linux-audit/audit-kernel/issues/120
> > This is also related to upstream github issue
> > https://github.com/linux-audit/audit-kernel/issues/96
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > Passes audit-testsuite.
> >
> > Chagelog:
> > v4:
> > - rebase on audit/next v5.9-rc1
> > - squash v2+v3fix
> > - add pwd NULL check in audit_log_name()
> > - resubmit after revert
> >
> > v3:
> > - initialize fds[0] to -1
> > - init cwd for ghak96 LSM_AUDIT_DATA_NET:AF_UNIX case
> > - init cwd for audit_inode{,_child}
> >
> > v2:
> > - unconditionally clear dummy
> > - create audit_clear_dummy accessor function
> > - remove proctitle context and dummy checks
> >
> >  kernel/audit.c       |  1 +
> >  kernel/audit.h       |  8 ++++++++
> >  kernel/auditsc.c     | 11 +++++++----
> >  security/lsm_audit.c |  1 +
> >  4 files changed, 17 insertions(+), 4 deletions(-)
> 
> Comments below, but can you elaborate on if any testing was done
> beyond the audit-testsuite?

Yes, it was tested with audit-testsuite and bauen1's reproducer

> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index 3b9c0945225a..abcfef58435b 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -290,6 +290,13 @@ extern int audit_signal_info_syscall(struct task_struct *t);
> >  extern void audit_filter_inodes(struct task_struct *tsk,
> >                                 struct audit_context *ctx);
> >  extern struct list_head *audit_killed_trees(void);
> > +
> > +static inline void audit_clear_dummy(struct audit_context *ctx)
> > +{
> > +       if (ctx)
> > +               ctx->dummy = 0;
> > +}
> 
> With the only caller being audit_log_start(), should this be moved to
> kernel/audit.c?  I'm just not sure this is something we would ever
> need (or want) to call from elsewhere, thoughts?

Yes, move it, or better yet just open code it.

> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 8dba8f0983b5..9d2de93f40b3 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -1367,7 +1368,10 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
> >                         /* name was specified as a relative path and the
> >                          * directory component is the cwd
> >                          */
> > -                       audit_log_d_path(ab, " name=", &context->pwd);
> > +                       if (&context->pwd)
> 
> Hmm, I don't think this is going to work the way you are intending; I
> believe this will always evaluate to true regardless of the state of
> context->pwd.  If you look elsewhere in kernel/auditsc.c you will see
> some examples of checking to see if context->pwd is valid (e.g.
> _audit_getcwd() and audit_log_exit()).

Sorry for the ctx->pwd.dentry/mnt brainfart, the compiler *did*
complain.

> > +                               audit_log_d_path(ab, " name=", &context->pwd);
> > +                       else
> > +                               audit_log_format(ab, " name=(null)");
> >                         break;
> >                 default:
> >                         /* log the name's directory component */...
> 
> > @@ -2079,6 +2080,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
> >         }
> >         handle_path(dentry);
> >         audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOEVAL);
> > +       _audit_getcwd(context);
> >  }
> >
> >  void __audit_file(const struct file *file)
> > @@ -2197,6 +2199,7 @@ void __audit_inode_child(struct inode *parent,
> >                 audit_copy_inode(found_child, dentry, inode, 0);
> >         else
> >                 found_child->ino = AUDIT_INO_UNSET;
> > +       _audit_getcwd(context);
> >  }
> >  EXPORT_SYMBOL_GPL(__audit_inode_child);
> >
> > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > index 53d0d183db8f..e93077612246 100644
> > --- a/security/lsm_audit.c
> > +++ b/security/lsm_audit.c
> > @@ -369,6 +369,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
> >                                         audit_log_untrustedstring(ab, p);
> >                                 else
> >                                         audit_log_n_hex(ab, p, len);
> > +                               audit_getcwd();
> >                                 break;
> >                         }
> >                 }
> 
> I'm starting to wonder if audit is doing this wrong (it is audit after
> all) ... why not just fetch the cwd in audit_log_exit() if there are
> entries in the context->names_list?  The only time we care about
> logging the working dir is when we actually have PATH records, right?
> My initial thinking is that we can simplify a lot of code if we just
> add a audit_getcwd() call in audit_log_exit() if the
> context->names_list is not empty.  We should even be safe in the task
> exit case as the fs info appears to get cleaned up *after*
> audit_log_exit() is called.

> Assuming we go this route, we can probably get rid of all the
> audit_getcwd() calls outside of the audit code (e.g. the lsm_audit.c
> code).  I guess we would need to make sure things still behave the
> same for chdir(2), getcwd(2), etc. but even if we have to insert one
> or two audit_getcwd() calls in that case we should still come out on
> top (although I suspect the necessary calls are already being made).

Or just open code audit_getcwd() in audit_alloc_name() and kill all
audit_getcwd() calls since it is audit_names that is populated as the
result of a call to audit_alloc_name().

How does this look?: 4 files changed, 9 insertions(+), 33 deletions(-)

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

