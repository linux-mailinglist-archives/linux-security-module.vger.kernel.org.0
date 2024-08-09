Return-Path: <linux-security-module+bounces-4751-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44C794D07A
	for <lists+linux-security-module@lfdr.de>; Fri,  9 Aug 2024 14:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C9E282768
	for <lists+linux-security-module@lfdr.de>; Fri,  9 Aug 2024 12:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932711946B8;
	Fri,  9 Aug 2024 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="mlFAfdfh"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776E197A69
	for <linux-security-module@vger.kernel.org>; Fri,  9 Aug 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207553; cv=none; b=DavEwMgGbz/bAesZUuP7u7WF+NlqfZRqDY02/2XjxrxPV+AwJhH5gJw+a0wzJY9nQ/qdHVOIR/cjvUmDeCj9GRj9in6/6yRqpgBLVTnx+2e7waRSosSbn8HcjaqE6upoGcPl50IXwed7Olv7mhD2craN2g8mP9BYKHGw28CwmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207553; c=relaxed/simple;
	bh=Trcqj4P9tk1i1V9qr1YFG4yl53DMu6W2JO1hq+qEC5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKAsMBot+kknxmANfFCH4D8EZaYDjRQXCp2cSWIvzbgoFMstBdyWgdLKGAA/JStEim9MiWeerAjTdEjCgfv+G1qiKaBEU3iiPTJKHs9210vLzcW1J9b5wEmLzeXxfVeDfcHHk0hLHNpu5ZRpJtfbc86CgJoZuhGu/zfAAXp0L2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=mlFAfdfh; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WgNtX5XJxzT3d;
	Fri,  9 Aug 2024 14:45:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723207540;
	bh=20glFXAeQ4aDIox+dfGLIPtIyZEgMytK3bDO6kau5xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlFAfdfhxjNPQIMbRpN7tgGvUM+YZM/d15b2H9+8dQFYr5nZp5QMm/iPwkird+NxJ
	 Xj37u98f2wumczOBFZTw+UAfESl5iWFiVwc6PUJ4lrGA9iYfxUchZFm10xUmcxESwB
	 Jy1ehp3U82//kDQmZfTpi9y6iYDY1xrjtzGZ1whE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WgNtX0rjKzd3G;
	Fri,  9 Aug 2024 14:45:40 +0200 (CEST)
Date: Fri, 9 Aug 2024 14:45:35 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, outreachy@lists.linux.dev, 
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
Message-ID: <20240809.Ieng6cheumo9@digikod.net>
References: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net>
 <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net>
 <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net>
 <20240809.soh6aeCeeRiu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240809.soh6aeCeeRiu@digikod.net>
X-Infomaniak-Routing: alpha

On Fri, Aug 09, 2024 at 02:40:17PM +0200, Mickaël Salaün wrote:
> On Fri, Aug 09, 2024 at 12:59:48PM +0200, Mickaël Salaün wrote:
> > On Thu, Aug 08, 2024 at 04:42:23PM +0200, Jann Horn wrote:
> > > On Thu, Aug 8, 2024 at 4:09 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > > On Thu, Aug 08, 2024 at 03:10:54AM +0200, Jann Horn wrote:
> > > > > On Thu, Aug 8, 2024 at 1:36 AM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> > > > > > On Wed, Aug 07, 2024 at 08:16:47PM +0200, Mickaël Salaün wrote:
> > > > > > > On Tue, Aug 06, 2024 at 11:55:27PM +0200, Jann Horn wrote:
> > > > > > > > On Tue, Aug 6, 2024 at 8:56 PM Jann Horn <jannh@google.com> wrote:
> > > > > > > > > On Tue, Aug 6, 2024 at 8:11 PM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> > > > > > > > > > Currently, a sandbox process is not restricted to send a signal
> > > > > > > > > > (e.g. SIGKILL) to a process outside of the sandbox environment.
> > > > > > > > > > Ability to sending a signal for a sandboxed process should be
> > > > > > > > > > scoped the same way abstract unix sockets are scoped. Therefore,
> > > > > > > > > > we extend "scoped" field in a ruleset with
> > > > > > > > > > "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will deny
> > > > > > > > > > sending any signal from within a sandbox process to its
> > > > > > > > > > parent(i.e. any parent sandbox or non-sandboxed procsses).
> > > > > > > > [...]
> > > > > > > > > > +       if (is_scoped)
> > > > > > > > > > +               return 0;
> > > > > > > > > > +
> > > > > > > > > > +       return -EPERM;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static int hook_file_send_sigiotask(struct task_struct *tsk,
> > > > > > > > > > +                                   struct fown_struct *fown, int signum)
> > > > > > >
> > > > > > > I was wondering if we should handle this case, but I guess it makes
> > > > > > > sense to have a consistent policy for all kind of user-triggerable
> > > > > > > signals.
> > > > > > >
> > > > > > > > > > +{
> > > > > > > > > > +       bool is_scoped;
> > > > > > > > > > +       const struct landlock_ruleset *dom, *target_dom;
> > > > > > > > > > +       struct task_struct *result = get_pid_task(fown->pid, fown->pid_type);
> > > > > > > > >
> > > > > > > > > I'm not an expert on how the fowner stuff works, but I think this will
> > > > > > > > > probably give you "result = NULL" if the file owner PID has already
> > > > > > > > > exited, and then the following landlock_get_task_domain() would
> > > > > > > > > probably crash? But I'm not entirely sure about how this works.
> > > > > > > > >
> > > > > > > > > I think the intended way to use this hook would be to instead use the
> > > > > > > > > "file_set_fowner" hook to record the owning domain (though the setup
> > > > > > > > > for that is going to be kind of a pain...), see the Smack and SELinux
> > > > > > > > > definitions of that hook. Or alternatively maybe it would be even
> > > > > > > > > nicer to change the fown_struct to record a cred* instead of a uid and
> > > > > > > > > euid and then use the domain from those credentials for this hook...
> > > > > > > > > I'm not sure which of those would be easier.
> > > > > > > >
> > > > > > > > (For what it's worth, I think the first option would probably be
> > > > > > > > easier to implement and ship for now, since you can basically copy
> > > > > > > > what Smack and SELinux are already doing in their implementations of
> > > > > > > > these hooks. I think the second option would theoretically result in
> > > > > > > > nicer code, but it might require a bit more work, and you'd have to
> > > > > > > > include the maintainers of the file locking code in the review of such
> > > > > > > > refactoring and have them approve those changes. So if you want to get
> > > > > > > > this patchset into the kernel quickly, the first option might be
> > > > > > > > better for now?)
> > > > > > > >
> > > > > > >
> > > > > > > I agree, let's extend landlock_file_security with a new "fown" pointer
> > > > > > > to a Landlock domain. We'll need to call landlock_get_ruleset() in
> > > > > > > hook_file_send_sigiotask(), and landlock_put_ruleset() in a new
> > > > > > > hook_file_free_security().
> > > > > > I think we should add a new hook (hook_file_set_owner()) to initialize
> > > > > > the "fown" pointer and call landlock_get_ruleset() in that?
> > > > >
> > > > > Yeah. Initialize the pointer in the file_set_fowner hook, and read the
> > > > > pointer in the file_send_sigiotask hook.
> > > > >
> > > > > Note that in the file_set_fowner hook, you'll probably need to use
> > > > > both landlock_get_ruleset() (to take a reference on the ruleset you're
> > > > > storing in the fown pointer) and landlock_put_ruleset() (to drop the
> > > > > reference to the ruleset that the fown pointer was pointing to
> > > > > before). And you'll need to use some kind of lock to protect the fown
> > > > > pointer - either by adding an appropriate lock next to your fown
> > > > > pointer or by using some appropriate existing lock in "struct file".
> > > > > Probably it's cleanest to have your own lock for this? (This lock will
> > > > > have to be something like a spinlock, not a mutex, since you need to
> > > > > be able to acquire it in the file_set_fowner hook, which runs inside
> > > > > an RCU read-side critical section, where sleeping is forbidden -
> > > > > acquiring a mutex can sleep and therefore is forbidden in this
> > > > > context, acquiring a spinlock can't sleep.)
> > > >
> > > > Yes, I think this should work for file_set_fowner:
> > > >
> > > > struct landlock_ruleset *prev_dom, *new_dom;
> > > >
> > > > new_dom = landlock_get_current_domain();
> > > > landlock_get_ruleset(new_dom);
> > > >
> > > > /* Cf. f_modown() */
> > > > write_lock_irq(&filp->f_owner.lock);
> > > > prev_dom = rcu_replace_pointer(&landlock_file(file)->fown_domain,
> > > >         new_dom, lockdep_is_held(&filp->f_owner.lock));
> > > > write_unlock_irq(&filp->f_owner.lock);
> > > >
> > > > landlock_put_ruleset_rcu(prev_dom);
> > > >
> > > >
> > > > With landlock_put_ruleset_rcu() define with this:
> > > >
> > > > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> > > > index a93bdbf52fff..897116205520 100644
> > > > --- a/security/landlock/ruleset.c
> > > > +++ b/security/landlock/ruleset.c
> > > > @@ -524,6 +524,20 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
> > > >         }
> > > >  }
> > > >
> > > > +static void free_ruleset_rcu(struct rcu_head *const head)
> > > > +{
> > > > +       struct landlock_ruleset *ruleset;
> > > > +
> > > > +       ruleset = container_of(head, struct landlock_ruleset, rcu);
> > > > +       free_ruleset(ruleset);
> > > > +}
> > > 
> > > free_ruleset() can block but RCU callbacks aren't allowed to block,
> > > that's why landlock_put_ruleset_deferred() exists.
> > 
> > Yes, but landlock_put_ruleset_deferred() doesn't wait for RCU read-side
> > critical sections.
> > 
> > > 
> > > > +
> > > > +void landlock_put_ruleset_rcu(struct landlock_ruleset *const ruleset)
> > > > +{
> > > > +       if (ruleset && refcount_dec_and_test(&ruleset->usage))
> > > > +               call_rcu(&ruleset->rcu, free_ruleset_rcu);
> > > > +}
> > > 
> > > No, this pattern of combining refcounting and RCU doesn't work.
> > > 
> > > One legal pattern is:
> > > *The entire object* is subject to RCU; any refcount decrement that
> > > drops the refcount to 0 does call_rcu().
> > > (This is the usual RCU refcounting pattern in the kernel.)
> > > 
> > > Another legal pattern is:
> > > One particular *reference* is subject to RCU; when dropping this
> > > reference, *the refcount decrement is delayed with call_rcu()*.
> > > (This is basically the RCU pattern used for stuff like the reference
> > > from "struct pid" to "struct task_struct".)
> > > 
> > > But you can't use call_rcu() depending on whether the last dropped
> > > reference happened to be a reference that required RCU; what if the
> > > refcount is 2, then you first call landlock_put_ruleset_rcu() which
> > > decrements the refcount to 1, and immediately afterwards you call
> > > landlock_put_ruleset() which drops the refcount to 0 and frees the
> > > object without waiting for an RCU grace period? Like so:
> > > 
> > > thread A         thread B
> > > ========         ========
> > > rcu_read_lock()
> > > ruleset = rcu_dereference(...->fown_domain)
> > >                  ruleset = rcu_replace_pointer(...->fown_domain, new_dom, ...)
> > >                  landlock_put_ruleset_rcu(ruleset)
> > >                  landlock_put_ruleset(ruleset)
> > >                    free_ruleset(ruleset)
> > >                      kfree(ruleset)
> > > access ruleset [UAF]
> > > rcu_read_unlock()
> > 
> > Indeed
> > 
> > > 
> > > So if you want to use RCU lifetime for this, I think you'll have to
> > > turn landlock_put_ruleset() and landlock_put_ruleset_deferred() into
> > > one common function that always, when reaching refcount 0, schedules
> > > an RCU callback which then schedules a work_struct which then does
> > > free_ruleset().
> > > 
> > > I think that would be a little ugly, and it would look nicer to just
> > > use normal locking in the file_send_sigiotask hook?
> > 
> > I don't see how we can do that without delaying the free_ruleset() call
> > to after the RCU read-side critical section in f_setown().
> > 
> > What about calling refcount_dec_and_test() in free_ruleset_rcu()?  That
> > would almost always queue this call but it looks safe.
> 
> That's the second pattern you pointed out just above.  Because we should
> only use the related struct rcu_head for this call site (which is
> protected with f_owner.lock), we should make that explicit with a
> "_fown" suffix for the function (landlock_put_ruleset_rcu_fown) and the
> ruleset's field (rcu_fown).

Hmm, this is not enough because this function site could still be called
with the same ruleset several time, which could lead to memory leak and
potential rcu_head pointers inconsistencies...

> 
> > 
> > An alternative might be to call synchronize_rcu() in free_ruleset(), but
> > it's a big ugly too.
> > 
> > BTW, I don't understand why neither SELinux nor Smack use (explicit)
> > atomic operations nor lock.  And it looks weird that
> > security_file_set_fowner() isn't called by f_modown() with the same
> > locking to avoid races.

