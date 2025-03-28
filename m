Return-Path: <linux-security-module+bounces-9070-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4315CA74D61
	for <lists+linux-security-module@lfdr.de>; Fri, 28 Mar 2025 16:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101BF189A1B9
	for <lists+linux-security-module@lfdr.de>; Fri, 28 Mar 2025 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742471C84B4;
	Fri, 28 Mar 2025 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HSo+YrXj"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7711C5F29
	for <linux-security-module@vger.kernel.org>; Fri, 28 Mar 2025 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174414; cv=none; b=DzRss2URp+i7tmStw2F5QvhwdXxlKN3NeaSsBxY7KG9flElPuLMm7SBcI356GNZ5A+ysR7mk6qHQkNtCk03GCSFK7riauySOpfLFk+CK8ssJHB8FQ7AW+NTycvPZnjsdovdPHp5P3T0NRnH+Om9c0dPCiADQnZ7phwt/3DN3aMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174414; c=relaxed/simple;
	bh=FxRwoIaRhHOWAtABieGIFYWFvwY2CLGMTi9i57XVP4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCSc0q8tPWANcPvlW1MAiJcHuiSzicGfqCeKREH/etvBmJ4/cPo/miDrXfjecnTmaeBWg+NNJgpJgugunp1LmeN56+qboLYcJVK8531fMZQFwszb030PsqQKWQzHrnWxkjecy2h+dpEW6XiuNGNWaXTTaQTDADrrRdGv188WUVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HSo+YrXj; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e64165ae78cso1678815276.0
        for <linux-security-module@vger.kernel.org>; Fri, 28 Mar 2025 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743174411; x=1743779211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH8Qh2WxuZKl3SUB4Qk+dn0g0gZz1ge9pCJmoUUxBTU=;
        b=HSo+YrXjzp2xftqYGjyrIMQHp4ebYNCLmHZpjyO7iPgRmgnoDUdVCzpK0LEkJAY1IF
         ULHaDtyXNXzBi26Tc9Fy82Ql/R//qU4cCfCdLnnCkGUwMFWuJ/YbsSiclRWktjzqfZ94
         qzeQ69JjoQGtShJ+h34aWBksvFKAmmS9PA45uMuikJInHnC+5xtmlQxS03KtbmRMlp1J
         6p2zgsPTAuaBuY4tm0JHYLrgu0eI8aZfeuMaMXORqWahov7Q8fxml+WA0opPNbcX4bCO
         Kri6ImpJRZqCOflJYmWyCMuy7j3PQ5EwgUwPwkB6zJk7TuGxDKpWiyQUsLQiWeLsPcDV
         ktzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743174411; x=1743779211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HH8Qh2WxuZKl3SUB4Qk+dn0g0gZz1ge9pCJmoUUxBTU=;
        b=sps4ff0038vwNOVrQpNqvCOLhp+H0yOQZ0s1bRHbs2EEH2+O6UPKEjyHk8AMSj5FLh
         aReJtjlmRZoemhREuKH3swVQmO/U7pIqnc0STQzacCJRASDfL7y6hWLlZfC0trwy1MV7
         EZGlyjGAKPywQyXjb4wdUhy6ohWpcQYQ6j8Hclrqp8Dx8+THShZTayd37J8rRr+OR5FY
         IAJbgQBhF0zInS7VQjwxySJIpFbYXxCk8jKNf/BQ5k2QXhocpwPAealW+AgQ87NhiLEy
         xOUR4NUHkKft3DAm8iKJNLP3Ib3i+dj+OcOjQ6Uh94Bi5RwzELIwIjU7KVc0LKjVMlg5
         d6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXLWTzg9q/nlhm4PhZwaQoHodwv9sixA9rDXEXK3Np+BDwgIUc6NjRg0tYeC2J0f9pt2ymvJ1OYQDr7jndFboM3mqAIO/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpp7WjRytc7Q3kP7FqmXZDCTTTguAe6Wa+xceQ8vQYejkrnDj4
	asEnegQBlfdrMILtSKsE8wcKd2v+3rQJD076vMWKgVcTyWARdVjeP02+JntSWE8mAYydrykYg7y
	aRKZozRF6sdGKxAjGehLHn3QcYD6MPhXWlZMf
X-Gm-Gg: ASbGncuE5pVo/Y7d3oM0bpocI0BDFbvGBjeyFpvK0CQHLE5/YN073UEmUBTk7uWEKHl
	dkCaBWVP+YuJ8v3ajalZ+PKmLs+bkmwXozGYllVMqF1n4DQxZFDmzJEVKMCRwWbuPw1T2jNA/2e
	1cY1v4bh06FTurnKmtEm4f2O5P1g==
X-Google-Smtp-Source: AGHT+IHMw63BWStsGWC6XtBakdaJKBp5F0XF/WQXLeBeVCGw/7vjI2CUy7E2vvIjt7xIJuafaZ2suH9QogxDHXv+SGc=
X-Received: by 2002:a05:6902:6c17:b0:e6b:7158:3772 with SMTP id
 3f1490d57ef6-e6b71583be3mr4393588276.39.1743174411267; Fri, 28 Mar 2025
 08:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
 <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
 <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
 <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com>
 <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
 <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
 <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
 <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
 <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
 <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
 <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com>
 <CAEjxPJ6XnBmbzH44YVQxxv8WOyPN7N81fpj7OYonEOTB=rn6wg@mail.gmail.com>
 <CAHk-=wguzgJu4p_khuEXKHmh-6abSN7xLJdCTuyVEfjsopY7iQ@mail.gmail.com>
 <CAHk-=wh4H3j3TYWn6KSgznUsOXz8vfHMOfTNmFvjGr=hwULWsw@mail.gmail.com>
 <CAEjxPJ4fzoONpiy3z8QOZ55w35=WfWQ+hiTg24LMEHPpnaC87Q@mail.gmail.com>
 <CAHk-=wjbSRL7LM7CvckB+goQdUokMa_6G-iirdbtxrFSFe3mfA@mail.gmail.com> <CAEjxPJ4Np-_LeSQOPxRQggZjWxpJRhZm++XuEwNbMyUkZCvYjw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Np-_LeSQOPxRQggZjWxpJRhZm++XuEwNbMyUkZCvYjw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Mar 2025 11:06:40 -0400
X-Gm-Features: AQ5f1JpzIC4lZ-S-cK1A8GDPAgnrYWOFQvTvxXVIrri50BN34GjJB_uXefif8BE
Message-ID: <CAHC9VhS9xYg5_EaX83hyNX4EMr=c4EaDZ7N=+opv6BA6iZo+mg@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeffrey Vander Stoep <jeffv@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	"Cameron K. Williams" <ckwilliams.work@gmail.com>, "Kipp N. Davis" <kippndavis.work@gmx.com>, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Kralevich <nnk@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 9:23=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Mar 27, 2025 at 3:40=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 27 Mar 2025 at 12:16, Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > Where could/would we cache that information so that it was accessible
> > > directly by the VFS layer?
> >
> > So the VFS layer already does this for various other things. For this
> > case, the natural thing to do would be to add another IOP_xyzzy flag
> > in inode->i_opflags.
> >
> > That's how we already say things like "this inode has no
> > filesystem-specific i_op->permission function" (IOP_FASTPERM), so that
> > we don't even have to follow the "inode->i_op->permission" pointer
> > chain to see a NULL pointer.
> >
> > Yes, the VFS layer is *heavily* optimized like that. It literally does
> > that IOP_FASTPERM to avoid chasing two pointers - not even the call,
> > just the "don't even bother to follow pointers to see if it's NULL".
> > See do_inode_permission().
> >
> > And we have 16 bits in that inode->i_opflags, and currently only use 7
> > of those bits. Adding one bit for a IOP_NO_SECURITY_LOOKUP kind of
> > logic (feel free to rename that - just throwing a random name out as a
> > suggestion) would be a complete no-brainer.
> >
> > NOTE! The rule for the i_opflags accesses is that *reading* them is
> > done with no locking at all, but changing them takes the inode
> > spinlock (and we should technically probably use WRITE_ONCE() and
> > READ_ONCE(), but we don't).
> >
> > And notice that the "no locking at all for reading" means that if you
> > *change* the bit - even though that involves locking - there may be
> > concurrent lookups in process that won't see the change, and would go
> > on as if the lookup still does not need any security layer call. No
> > serialization to readers at all (although you could wait for an RCU
> > period after changing if you really need to, and only use the bit in
> > the RCU lookup).
> >
> > That should be perfectly fine - I really don't think serialization is
> > even needed. If somebody is changing the policy rules, any file
> > lookups *concurrent* to that change might not see the new rules, but
> > that's the same as if it happened before the change.
> >
> > I just wanted to point out that the serialization is unbalanced: the
> > spinlock for changing the flag is literally just to make sure that two
> > bits being changed at the same time don't stomp on each other (because
> > it's a 16-bit non-atomic field, and we didn't want to use a "unsigned
> > long" and atomic bitops because the cache layout of the inode is also
> > a big issue).
> >
> > And you can take the IOP_FASTPERM thing as an example of how to do
> > this: it is left clear initially, and what happens is that during the
> > permission lookup, if it *isn't* set, we'll follow those
> > inode->i_io->permission pointers, and notice that we should set it:
> >
> >         if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
> >                 if (likely(inode->i_op->permission))
> >                         return inode->i_op->permission(idmap, inode, ma=
sk);
> >
> >                 /* This gets set once for the inode lifetime */
> >                 spin_lock(&inode->i_lock);
> >                 inode->i_opflags |=3D IOP_FASTPERM;
> >                 spin_unlock(&inode->i_lock);
> >         }
> >
> > and I think the security layer could take a very similar approach: not
> > setting that IOP_NO_SECURITY_LOOKUP initially, but *when* a
> > security_inode_permission() call is made with just MAY_NOT_BLOCK |
> > MAY_LOOKUP, and the security layer notices that "this inode has no
> > reason to care", it could set the bit so that *next* time around the
> > VFS layer won't bother to call into security_inode_permission()
> > unnecessarily.
> >
> > Does that clarify?
>
> Yes, thank you. I think it would be easy enough to make that change to
> selinux_inode_permission() and to clear that inode flag on file
> relabels (e.g. in selinux_inode_post_setxattr() and
> inode_invalidate_secctx()). Not as sure about handling policy reloads
> / boolean changes at runtime without also caching the policy sequence
> number in the inode too so that can be compared. Further, I'm unclear
> on how to implement this in a manner that works with the LSM stacking
> support, since some other module might disagree about whether we can
> skip these lookups. Normally I'd just add an extra boolean or flag
> argument to the underlying ->inode_permission() hook so each module
> can indicate its decision and
> security/security.c:security_inode_permission() could compose the
> result, but I guess that would require switching
> security_inode_permission() from using call_int_hook() to manually
> doing the lsm_for_each_hook() loop itself which may have an adverse
> impact on those calls in general.

I'm not sure the VFS flag approach is going to end up being practical
due to various constraints, but I do have some other ideas that should
allow us to drop the bulk of the SELinux AVC calls while doing path
walks that I'm going to try today/soon.  I'll obviously report back if
it works out.

--=20
paul-moore.com

