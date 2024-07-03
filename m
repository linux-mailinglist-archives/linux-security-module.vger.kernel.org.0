Return-Path: <linux-security-module+bounces-4050-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE966926C0C
	for <lists+linux-security-module@lfdr.de>; Thu,  4 Jul 2024 00:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B091F22A5B
	for <lists+linux-security-module@lfdr.de>; Wed,  3 Jul 2024 22:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED5C191F69;
	Wed,  3 Jul 2024 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gBLe93nF"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181C1422B7
	for <linux-security-module@vger.kernel.org>; Wed,  3 Jul 2024 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047157; cv=none; b=n/Cl/UeIP4sIj51mthBKEY1oPKBFqL3mWJEcZymGZn07YX5tH+ivasK7MrTi/buASfqkiPKnCX9EdGHaAjIzBHxTlg+9aeBMIAdPn1l0mb0anhwuGxT6ZcGoemEpehDnonHCgHLSkb6IE9F5LlKPAFAkCJQlBO6VOM3zuF2wkHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047157; c=relaxed/simple;
	bh=mtWPGJGeiWf/tAxoHzmhHATh+2IoA1BZXr9uc2kjDUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqxP6njdnnF2PAU5L9ZqoKHxUP7lQTxvfgon1Je5u3heo/DBIJvS/l/HArk7UsKPd9hpQWsZyweNN2ZRXu3Nqy+djKOAnR0wEsovFkPj7cSG72G9cJ+dfu2onHmokYsKIjJvN2FdeIXDNGF6SFp5UFMmWBQQHOpGZ2PTEST0m4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gBLe93nF; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e035f4e3473so22299276.3
        for <linux-security-module@vger.kernel.org>; Wed, 03 Jul 2024 15:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720047154; x=1720651954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vdQ0vPpG4sIKdzwEgyVLyOrW9Me84LP7+thtHb2Smk=;
        b=gBLe93nFGy4U7lZQFoVcq5ecZM/PXfdcwHVqRsgtURlsyEMW2FxBvi85yNhj26AQAp
         j4incymM3gvvjFwx4gq8XwE624fIQqQ50QGeAXUY+iq3jNw9Q9IPggzi5VbslGdOdCSh
         oNmMqB1q3/D1q5noHJjPEshF+CmfJsUByOnlSGI7maGeALbcBXL9S4V1h6jFHYlqoRML
         GBZO7IHB/e456DyLlO9AohjwCxOXNf62uzM2orPS1twl2UkqIjVzMH3EbBbe3kO6B/1D
         nM6O1ob5QScayyk3Cxb5PPEN1sgIa7laLALiIS81AMqEU5ETbkT8RW6UmEj5/lbp6Pvc
         SgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047154; x=1720651954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vdQ0vPpG4sIKdzwEgyVLyOrW9Me84LP7+thtHb2Smk=;
        b=nEoW4tOyoPRZzEWWkI5RziVbpVf7rMjMS1mPeim5eygFzAJovmmR4WPHT2O5V3JYBy
         dV3lU4gCwqafS4Dpu3sEb88A8tuRXxFhU8xlheIUBSrhaWIZxr7WPMDgGDQOpdJSQJOq
         gZx9MByV4+VL4MTZ+D5T6C16TnXukgDGTHvOstHzOUhm5ruGsNbAfFOgflgF9NySdJyv
         v1yWUcolWsG0+A06EBSRDVNkr5LnWeMIBwrZrzIGxXQHFkcklOOSRq+ijWBxQuWOZhpV
         i0sAlQkrCf47QtytgktEIUc5FfiAp+Y6ugNNXTTixkmbi/T7gpjmndkF/L334M/CVVaS
         FoKw==
X-Gm-Message-State: AOJu0Yxu2a73yq1V0NyIymN4+CAFrDzInSOnLKPHjdqGWmisHPv/UbSN
	9bTQnxaV/trAd5dGoyscrWW1IAUwzvUjTtus9RyBMF5Cq5TRetDZKlhgdsLnrBI52yPTny37BvZ
	LkZ9EWXxaymGGLOI6ouQM7jlr7SgnQF4x7on/sk5OtabBRNw=
X-Google-Smtp-Source: AGHT+IHcq0mFcAGyKsCA+hJoXpry7FL2sJzR6ohVdhArGyVCdUU3VAL6wEMFoNnEMvJuPaB+UhbExfKqcdqF1LFhBbc=
X-Received: by 2002:a25:d045:0:b0:dfb:aee:1d3c with SMTP id
 3f1490d57ef6-e036ec4ba63mr16925529276.46.1720047154451; Wed, 03 Jul 2024
 15:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-4-kpsingh@kernel.org> <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
 <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com>
 <CAHC9VhQ4qH-rtTpvCTpO5aNbFV4epJr5Xaj=TJ86_Y_Z3v-uyw@mail.gmail.com> <CACYkzJ4kwrsDwD2k5ywn78j7CcvufgJJuZQ4Wpz8upL9pAsuZw@mail.gmail.com>
In-Reply-To: <CACYkzJ4kwrsDwD2k5ywn78j7CcvufgJJuZQ4Wpz8upL9pAsuZw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Jul 2024 18:52:23 -0400
Message-ID: <CAHC9VhRoMpmHEVi5K+BmKLLEkcAd6Qvf+CdSdBdLOx4LUSsgKQ@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 6:22=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
> On Wed, Jul 3, 2024 at 10:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Jul 3, 2024 at 12:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> w=
rote:
> > > On Wed, Jul 3, 2024 at 2:07=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > >
> > > > On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> > > > >
> > > > > LSM hooks are currently invoked from a linked list as indirect ca=
lls
> > > > > which are invoked using retpolines as a mitigation for speculativ=
e
> > > > > attacks (Branch History / Target injection) and add extra overhea=
d which
> > > > > is especially bad in kernel hot paths:
> > >
> > > [...]
> > >
> > > > should fix the more obvious problems.  I'd like to know if you are
> > > > aware of any others?  If not, the text above should be adjusted and
> > > > we should reconsider patch 5/5.  If there are other problems I'd
> > > > like to better understand them as there may be an independent
> > > > solution for those particular problems.
> > >
> > > We did have problems with some other hooks but I was unable to dig up
> > > specific examples though, it's been a while. More broadly speaking, a
> > > default decision is still a decision. Whereas the intent from the BPF
> > > LSM is not to make a default decision unless a BPF program is loaded.
> > > I am quite worried about the holes this leaves open, subtle bugs
> > > (security or crashes) we have not caught yet and PATCH 5/5 engineers =
away
> > >  the problem of the "default decision".
> >
> > The inode/xattr problem you originally mentioned wasn't really rooted
> > in a "bad" default return value, it was really an issue with how the
> > LSM hook was structured due to some legacy design assumptions made
> > well before the initial stacking patches were merged.  That should be
> > fixed now[1] and given that the inode/xattr set/remove hooks were
> > unique in this regard (individual LSMs were responsible for performing
> > the capabilities checks) I don't expect this to be a general problem.
> >
> > There were also some issues caused by the fact that we were defining
> > the default return value in multiple places and these values had gone
> > out of sync in a number of hooks.  We've also fixed this problem by
> > only defining the default return value once for each hook, solving all
> > of those problems.
>
> I don't see how this solves problems or prevents any future problems
> with side-effects. I have always been uncomfortable with an extraneous
> function being called with a side effect ever since we merged BPF LSM
> with default callback. We have found one bug due to this, not all the
> bugs.

You've got to give me something more concrete than that.  If you can't
provide any concrete examples, start with providing a basic concept
with far more detail than just "side-effects".

> > I'm not aware of any other existing problems relating to the LSM hook
> > default values, if there are any, we need to fix them independent of
> > this patchset.  The LSM framework should function properly if the
> > "default" values are used.
>
> Patch 5 eliminates the possibilities of errors and subtle bugs all
> together. The problem with subtle bugs is, well, they are subtle, if
> you and I knew of the bugs, we would fix all of them, but we don't. I
> really feel we ought to eliminate the class of issues and not just
> whack-a-mole when we see the bugs.

Here's the thing, I don't really like patch 5/5.  To be honest, I
don't really like a lot of this patchset.  From my perspective, the
complexity of the code is likely going to mean more maintenance
headaches down the road, but Linus hath spoken so we're doing this
(although "this" is still a bit undefined as far as I'm concerned).
If you want me to merge patch 5/5 you've got to give me something real
and convincing that can't be fixed by any other means.  My current
opinion is that you're trying to use a previously fixed bug to scare
and/or coerce the merging of some changes I don't really want to
merge.  If you want me to take patch 5/5, you've got to give me a
reason that is far more compelling that what you've written thus far.

--=20
paul-moore.com

