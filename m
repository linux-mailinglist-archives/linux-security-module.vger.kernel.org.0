Return-Path: <linux-security-module+bounces-15262-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id V+BOHacgp2mMegAAu9opvQ
	(envelope-from <linux-security-module+bounces-15262-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Tue, 03 Mar 2026 18:55:51 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E144F1F4D80
	for <lists+linux-security-module@lfdr.de>; Tue, 03 Mar 2026 18:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B37D301CC64
	for <lists+linux-security-module@lfdr.de>; Tue,  3 Mar 2026 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86D2370D4C;
	Tue,  3 Mar 2026 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="TGTsyx50"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1409936C0CD
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560514; cv=none; b=XEoXD8zsTQUnvVaYM5Qw/52ekU/UdnoOOaCEGqpXnH3cUywlhrJ+/VP+dlkjtuoU6IGCA4Vt2G4J5PyY8Jdq9fbfknPCaBkMzYvscxmrXk41iWIxjRGUZFOmHqU87ii2dtRhWbmQT8F13WTe83YjjGkJtZ4JYY5WrYlV1DOaxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560514; c=relaxed/simple;
	bh=d06imGXvKqvIA4TjoliwJDQQ+2Sl+7P0xAN3I6Wupxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLfWMPhSaoLleD+6j4X7pcK8lD0Rk/2jLdlUxzqWLqelIV0K6uB73p89L6kqLx0nueArtQCqycISMAC9To99gYtDqWGQftua8wQtwnCiunCFXkp6aULMdX4ZrSU4v0Y+yxmQrthgPRccBR9ThIPd1s5/DnmL24XkTaVD0sMjlFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=TGTsyx50; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fQNYJ1D4hztR2;
	Tue,  3 Mar 2026 18:47:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1772560052;
	bh=31kjE+bsq+2VMwfiEeAKWKrSMMRajvQBW3r7ezHwg+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGTsyx50uuWqV+ETt52oDl6wBjmAIi2kmooK+/BB/O31tcEVKPgFNcQ/HNUuY722D
	 zf8PFsud+NbnQ54neLM+O04zItbytm7o1+BoU0tq4Xf/RfoJymCTX3iDnIuFC4zES/
	 frBKvUKWJsBQ9mlvt9C8SJ3Kj0E3JE6pxET6sUZQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fQNYH29cbz5Vt;
	Tue,  3 Mar 2026 18:47:31 +0100 (CET)
Date: Tue, 3 Mar 2026 18:47:30 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Yihan Ding <dingyihan@uniontech.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <20260303.kuSho2nooFie@digikod.net>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
 <20260226015903.3158620-2-dingyihan@uniontech.com>
 <aacKOr1wywSSOAVv@suesslenovo>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aacKOr1wywSSOAVv@suesslenovo>
X-Infomaniak-Routing: alpha
X-Rspamd-Queue-Id: E144F1F4D80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.61 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.77)[subject];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15262-lists,linux-security-module=lfdr.de];
	FREEMAIL_CC(0.00)[uniontech.com,gmail.com,paul-moore.com,google.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[digikod.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,linux-security-module@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module,7ea2f5e9dfd468201817];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,digikod.net:dkim,digikod.net:mid,uniontech.com:email,appspotmail.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:20:10AM -0500, Justin Suess wrote:
> On Thu, Feb 26, 2026 at 09:59:02AM +0800, Yihan Ding wrote:
> > syzbot found a deadlock in landlock_restrict_sibling_threads().
> > When multiple threads concurrently call landlock_restrict_self() with
> > sibling thread restriction enabled, they can deadlock by mutually
> > queueing task_works on each other and then blocking in kernel space
> > (waiting for the other to finish).
> > 
> > Fix this by serializing the TSYNC operations within the same process
> > using the exec_update_lock. This prevents concurrent invocations
> > from deadlocking. 
> > 
> > We use down_write_trylock() and return -ERESTARTNOINTR if the lock
> > cannot be acquired immediately. This ensures that if a thread fails
> > to get the lock, it will return to userspace, allowing it to process
> > any pending TSYNC task_works from the lock holder, and then
> > transparently restart the syscall.
> > 
> > Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
> > Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
> > Suggested-by: Günther Noack <gnoack3000@gmail.com>
> > Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> > ---
> > Changes in v3:
> > - Replaced down_write_killable() with down_write_trylock() and 
> >   returned -ERESTARTNOINTR to avoid a secondary deadlock caused by 
> >   blocking the execution of task_works. (Caught by Günther Noack).
> > 
> > Changes in v2:
> > - Use down_write_killable() instead of down_write().
> > - Split the interrupt path cleanup into a separate patch.
> > ---
> >  security/landlock/tsync.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> > index de01aa899751..xxxxxxxxxxxx 100644
> > --- a/security/landlock/tsync.c
> > +++ b/security/landlock/tsync.c
> > @@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  	shared_ctx.new_cred = new_cred;
> >  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
> >  
> > +	/*
> > +	 * Serialize concurrent TSYNC operations to prevent deadlocks
> > +	 * when multiple threads call landlock_restrict_self() simultaneously.
> > +	 */
> > +	if (!down_write_trylock(&current->signal->exec_update_lock))
> > +		return -ERESTARTNOINTR;
> These two lines above introduced a test failure in tsync_test
> completing_enablement.
> 
> The commit that introduced the bug is 3d6327c306b3e1356ab868bf27a0854669295a4f
> (this patch) and is currently in the mic/next branch.
> 
> I noticed the test failure while testing an unrelated patch.
> 
> The bug is because this code never actually yields or restarts the syscall.
> 
> This is the test output I observed:
> 
>   [+] Running tsync_test:
>   TAP version 13
>   1..4
>   # Starting 4 tests from 1 test cases.
>   #  RUN           global.single_threaded_success ...
>   #            OK  global.single_threaded_success
>   ok 1 global.single_threaded_success
>   #  RUN           global.multi_threaded_success ...
>   #            OK  global.multi_threaded_success
>   ok 2 global.multi_threaded_success
>   #  RUN           global.multi_threaded_success_despite_diverging_domains ...
>   #            OK  global.multi_threaded_success_despite_diverging_domains
>   ok 3 global.multi_threaded_success_despite_diverging_domains
>   #  RUN           global.competing_enablement ...
>   # tsync_test.c:156:competing_enablement:Expected 0 (0) == d[1].result (-1)
>   # competing_enablement: Test failed
>   #          FAIL  global.competing_enablement
>   not ok 4 global.competing_enablement
>   # FAILED: 3 / 4 tests passed.
> 
> 
> Brief investigation and the additions of these pr_warn lines:
> 
> 
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 0d66a68677b7..84909232b220 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -574,6 +574,9 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
>  		const int err = landlock_restrict_sibling_threads(
>  			current_cred(), new_cred);
>  		if (err) {
> +			pr_warn("landlock: restrict_self tsync err pid=%d tgid=%d err=%d flags=0x%x ruleset_fd=%d\n",
> +				task_pid_nr(current), task_tgid_nr(current), err,
> +				flags, ruleset_fd);
>  			abort_creds(new_cred);
>  			return err;
>  		}
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index 5afc5d639b8f..deb0f0b1f081 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -489,8 +489,11 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  	 * Serialize concurrent TSYNC operations to prevent deadlocks when multiple
>  	 * threads call landlock_restrict_self() simultaneously.
>  	 */
> -	if (!down_write_trylock(&current->signal->exec_update_lock))
> +	if (!down_write_trylock(&current->signal->exec_update_lock)) {
> +		pr_warn("landlock: tsync trylock busy pid=%d tgid=%d\n",
> +			task_pid_nr(current), task_tgid_nr(current));
>  		return -ERESTARTNOINTR;
> +	}
>  
>  	/*
>  	 * We schedule a pseudo-signal task_work for each of the calling task's
> @@ -602,6 +605,10 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  
>  	tsync_works_release(&works);
>  	up_write(&current->signal->exec_update_lock);
> +	if (atomic_read(&shared_ctx.preparation_error))
> +		pr_warn("landlock: tsync preparation_error pid=%d tgid=%d err=%d\n",
> +			task_pid_nr(current), task_tgid_nr(current),
> +			atomic_read(&shared_ctx.preparation_error));
>  
>  	return atomic_read(&shared_ctx.preparation_error);
>  }
> 
> Resulted in the following output:
> 
>   landlock: tsync trylock busy pid=1263 tgid=1261
>   landlock: landlock: restrict_self tsync err pid=1263 tgid=1261 err=-513 flags=0x8 ruleset_fd=6
>   # tsync_test.c:156:competing_enablement:Expected 0 (0) == d[1].result (-1)
>   # competing_enablement: Test failed
>   #          FAIL  global.competing_enablement
>   not ok 4 global.competing_enablement

You're right, I have the same issue, not sure how I missed it last time.

> 
> I have a fix that I will send as a patch.

I'll need to squash your fix to this fix to only have one non-buggy
patch.  So, either you send a new patch and I'll squash it with
Co-developed-by, or Yihan takes your patch and send a new version with
your contribution (I'll prefer the later to make it easier to follow
this series).

> 
> Kind Regards,
> Justin Suess
> 

