Return-Path: <linux-security-module+bounces-1327-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A44B84BF93
	for <lists+linux-security-module@lfdr.de>; Tue,  6 Feb 2024 22:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A354B21D6E
	for <lists+linux-security-module@lfdr.de>; Tue,  6 Feb 2024 21:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665921B951;
	Tue,  6 Feb 2024 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YOrekqBm"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E91BC30
	for <linux-security-module@vger.kernel.org>; Tue,  6 Feb 2024 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256417; cv=none; b=ngqpU2ThYJF+qcn7mBDAamo1bFLvSfgrJK02/xiE1g72hcC7Qu+AsINe2NMlsR14QIeIsUl3UySHyI2hLmTBHYUlVqVjsnADVt9TsvaOH5NHu//kaWFe6pMOJb3Wt3MEAjKVwF0sqtjVYEHiyYkdqjTZXpmY/N9DhYnUubd+ITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256417; c=relaxed/simple;
	bh=lEXEftvc8USQ5Sq5o5lp81iZXZA1RVqdMSS6fDyVwYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROBFvAT3NDm5rxsa5BIrkp2E2LXYwsjf1o3F2LIBEW9BLgwgJ8qO0813o8OZPdQ5OGp8HJMPnV3e4u00RAGmr/eM551fZ+/jyR5Jo0yFdBS1fma+o3eTejvENZSRtxJ7aTcKed1q29DF/HfL9hPDwqMOeuSnUFSY0G5fzobKddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YOrekqBm; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6dcd91364so1382011276.2
        for <linux-security-module@vger.kernel.org>; Tue, 06 Feb 2024 13:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707256414; x=1707861214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8VjUURyKl+tDea7fU1YfuA8k7lBdd08O4dfl2Z6+qs=;
        b=YOrekqBm7lRAevzM7cbTxu7osqs2uDDeEc+pFoXzn6QV6lAHr5CJaplibVG95IRdb6
         Oy9lnWMptMvSAPHlgft41NfLh1N82vAIq0NALTLUtBy+mH/pLPUyJ0U2FnG319MVRWn4
         FQs0pFRzTBvCfvvQdWiL9On/vfy2VzY98dpCMKZah75NKlhcmjTcQdeipJhjQyb2fKPG
         wUSsoubF8VN0j9ABnsWTbKrzE5Bakh5l/wlknLPQaCqqBrD1SYJhyh0gArJWIsw5gQZa
         FygjWFOUMrPno6A4Uxw79yjVj7MdmSVerDZUXxGqz7dVMvQ63vyTAz7N5ROtznAzhNLO
         l8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256414; x=1707861214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8VjUURyKl+tDea7fU1YfuA8k7lBdd08O4dfl2Z6+qs=;
        b=g3aWUsKK5in/ABe6dWcnGAExFADStnwx7DHXZ+09TUzqoyFk6ORth5xx+rKRxf7S22
         LWyuevTN9UmVVG58FrKlBGipP01A/qXZ+MSFGxxZxdIwL5+tRD5igNGgvQPQm4siqwb7
         M6LxemeYi6OQ79UWM2R8IORMqTuPOf0FARu4TRio2ws6c7Swmdx36NZHtocTwlI95grH
         Adg+GVcRiBZBavprgjPbD5m4ZnC6bV0GBKFEE5UguNFJIudZpYx7q/3uho0Ed9EK+cTf
         DzQ/y2lQX/0diimiQpvD6/X9eLy3BD6JSLigFKo38rjl+vLJT9rtXWhek9RYk21zHYkL
         97Ww==
X-Gm-Message-State: AOJu0YwUeqSMYupe/kpGB+B0WZeH8QkX0DBWCk24icnNYlpQ5/pdxfUc
	CnMcyEJr9/GF9TBMntbitUhpdS9TR960xCLRKxWPm36/4Ir1P7Lc1RqGDWYUOlBxyAw3CmeSvn9
	BTC/OijCxOu3pBsGt0CQUdu1XOz62HmqHEYUK
X-Google-Smtp-Source: AGHT+IEO4hTUbTAAn40GVh6bVY5MjCMuUK0Go+sNf1Zs+luw8FRTbTUb/aYdCk/1t8fccmSNm68UjpBMUgzFkT5lF5I=
X-Received: by 2002:a25:84d2:0:b0:dc2:32e6:d1b1 with SMTP id
 x18-20020a2584d2000000b00dc232e6d1b1mr2686889ybm.18.1707256414268; Tue, 06
 Feb 2024 13:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706654228-17180-16-git-send-email-wufan@linux.microsoft.com>
 <6ac3cca9d1d3505f3ed9c7196512f2db@paul-moore.com> <05cb5f03-9236-47b7-8dd4-1741c289efdc@linux.microsoft.com>
In-Reply-To: <05cb5f03-9236-47b7-8dd4-1741c289efdc@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Feb 2024 16:53:23 -0500
Message-ID: <CAHC9VhS3Yb9QE3spJjFn2Mef-6m5Jxk6Yr80O1VkLp-yudp62w@mail.gmail.com>
Subject: Re: [PATCH RFC v12 15/20] ipe: add support for dm-verity as a trust provider
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
	snitzer@kernel.org, eparis@redhat.com, linux-doc@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org, 
	dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 6:11=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
> On 2/3/2024 2:25 PM, Paul Moore wrote:
> > On Jan 30, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> >>
> >> Allows author of IPE policy to indicate trust for a singular dm-verity
> >> volume, identified by roothash, through "dmverity_roothash" and all
> >> signed dm-verity volumes, through "dmverity_signature".
> >>
> >> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> >> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> >> ---
> >> v2:
> >>    + No Changes
> >>
> >> v3:
> >>    + No changes
> >>
> >> v4:
> >>    + No changes
> >>
> >> v5:
> >>    + No changes
> >>
> >> v6:
> >>    + Fix an improper cleanup that can result in
> >>      a leak
> >>
> >> v7:
> >>    + Squash patch 08/12, 10/12 to [11/16]
> >>
> >> v8:
> >>    + Undo squash of 08/12, 10/12 - separating drivers/md/ from securit=
y/
> >>      & block/
> >>    + Use common-audit function for dmverity_signature.
> >>    + Change implementation for storing the dm-verity digest to use the
> >>      newly introduced dm_verity_digest structure introduced in patch
> >>      14/20.
> >>
> >> v9:
> >>    + Adapt to the new parser
> >>
> >> v10:
> >>    + Select the Kconfig when all dependencies are enabled
> >>
> >> v11:
> >>    + No changes
> >>
> >> v12:
> >>    + Refactor to use struct digest_info* instead of void*
> >>    + Correct audit format
> >> ---
> >>   security/ipe/Kconfig         |  18 ++++++
> >>   security/ipe/Makefile        |   1 +
> >>   security/ipe/audit.c         |  37 ++++++++++-
> >>   security/ipe/digest.c        | 120 +++++++++++++++++++++++++++++++++=
++
> >>   security/ipe/digest.h        |  26 ++++++++
> >>   security/ipe/eval.c          |  90 +++++++++++++++++++++++++-
> >>   security/ipe/eval.h          |  10 +++
> >>   security/ipe/hooks.c         |  67 +++++++++++++++++++
> >>   security/ipe/hooks.h         |   8 +++
> >>   security/ipe/ipe.c           |  15 +++++
> >>   security/ipe/ipe.h           |   4 ++
> >>   security/ipe/policy.h        |   3 +
> >>   security/ipe/policy_parser.c |  26 +++++++-
> >>   13 files changed, 421 insertions(+), 4 deletions(-)
> >>   create mode 100644 security/ipe/digest.c
> >>   create mode 100644 security/ipe/digest.h
> >>
> >> diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
> >> index ac4d558e69d5..7afb1ce0cb99 100644
> >> --- a/security/ipe/Kconfig
> >> +++ b/security/ipe/Kconfig
> >> @@ -8,6 +8,7 @@ menuconfig SECURITY_IPE
> >>      depends on SECURITY && SECURITYFS && AUDIT && AUDITSYSCALL
> >>      select PKCS7_MESSAGE_PARSER
> >>      select SYSTEM_DATA_VERIFICATION
> >> +    select IPE_PROP_DM_VERITY if DM_VERITY && DM_VERITY_VERIFY_ROOTHA=
SH_SIG
> >>      help
> >>        This option enables the Integrity Policy Enforcement LSM
> >>        allowing users to define a policy to enforce a trust-based acce=
ss
> >> @@ -15,3 +16,20 @@ menuconfig SECURITY_IPE
> >>        admins to reconfigure trust requirements on the fly.
> >>
> >>        If unsure, answer N.
> >> +
> >> +if SECURITY_IPE
> >> +menu "IPE Trust Providers"
> >> +
> >> +config IPE_PROP_DM_VERITY
> >> +    bool "Enable support for dm-verity volumes"
> >> +    depends on DM_VERITY && DM_VERITY_VERIFY_ROOTHASH_SIG
> >> +    help
> >> +      This option enables the properties 'dmverity_signature' and
> >> +      'dmverity_roothash' in IPE policy. These properties evaluates
> >> +      to TRUE when a file is evaluated against a dm-verity volume
> >> +      that was mounted with a signed root-hash or the volume's
> >> +      root hash matches the supplied value in the policy.
> >> +
> >> +endmenu
> >> +
> >> +endif
> >> diff --git a/security/ipe/Makefile b/security/ipe/Makefile
> >> index 2279eaa3cea3..66de53687d11 100644
> >> --- a/security/ipe/Makefile
> >> +++ b/security/ipe/Makefile
> >> @@ -6,6 +6,7 @@
> >>   #
> >>
> >>   obj-$(CONFIG_SECURITY_IPE) +=3D \
> >> +    digest.o \
> >>      eval.o \
> >>      hooks.o \
> >>      fs.o \
> >> diff --git a/security/ipe/audit.c b/security/ipe/audit.c
> >> index ed390d32c641..a4ad8e888df0 100644
> >> --- a/security/ipe/audit.c
> >> +++ b/security/ipe/audit.c
> >> @@ -13,6 +13,7 @@
> >>   #include "hooks.h"
> >>   #include "policy.h"
> >>   #include "audit.h"
> >> +#include "digest.h"
> >>
> >>   #define ACTSTR(x) ((x) =3D=3D IPE_ACTION_ALLOW ? "ALLOW" : "DENY")
> >>
> >> @@ -54,8 +55,30 @@ static const char *const audit_prop_names[__IPE_PRO=
P_MAX] =3D {
> >>      "boot_verified=3DFALSE",
> >>      "boot_verified=3DTRUE",
> >>   #endif /* CONFIG_BLK_DEV_INITRD */
> >> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> >> +    "dmverity_roothash=3D",
> >> +    "dmverity_signature=3DFALSE",
> >> +    "dmverity_signature=3DTRUE",
> >> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> >>   };
> >>
> >> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> >> +/**
> >> + * audit_dmv_roothash - audit a roothash of a dmverity volume.
> >> + * @ab: Supplies a pointer to the audit_buffer to append to.
> >> + * @rh: Supplies a pointer to the digest structure.
> >> + */
> >> +static void audit_dmv_roothash(struct audit_buffer *ab, const void *r=
h)
> >> +{
> >> +    audit_log_format(ab, "%s", audit_prop_names[IPE_PROP_DMV_ROOTHASH=
]);
> >> +    ipe_digest_audit(ab, rh);
> >> +}
> >> +#else
> >> +static void audit_dmv_roothash(struct audit_buffer *ab, const void *r=
h)
> >> +{
> >> +}
> >> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> >
> > I talked about this back in my review of the v11 patchset and I'm
> > guessing you may have missed it ... the problem with the above code is
> > that the fields in an audit record should remain constant, even if
> > there is no data for that particular field.  In cases where there is no
> > data to record for a given field, a "?" should be used as the field's
> > value, for example:
> >
> >    dmverify_roothash=3D?
> >
> > My guess is that you would want to do something like this:
> >
> >    #else  /* !CONFIG_IPE_PROP_DM_VERITY */
> >    static void audit_dmv_roothash(...)
> >    {
> >      audit_log_format(ab, "%s=3D?", audit_prop_names[...]);
> >    }
> >    #endif /* CONFIG_IPE_PROP_DM_VERITY */
> >
> > --
> > paul-moore.com
>
> These code are used for auditing a policy rule, which the parser will
> guarantee the property will always have a valid value. The comments
> might be misleading which sounds like it's auditing a file's state. I
> will correct them.
>
> Also as we previously discussed, the policy grammar shouldn't depend on
> any kernel switch so these preprocessor statement will be removed.
>
> However, as an audit record should remain constant, I guess we should do
> some special treatment to anonymous files? Like audit record for them
> should include "path=3D? dev=3D? ino=3D?"

Yes, if the record type includes those fields just once, the record
type should *always* include those fields.

--=20
paul-moore.com

