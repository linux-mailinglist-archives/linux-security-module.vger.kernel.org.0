Return-Path: <linux-security-module+bounces-5319-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB60D96C817
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Sep 2024 22:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82878282A2E
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Sep 2024 20:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4241E6DE7;
	Wed,  4 Sep 2024 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DSUaYCWr"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA11F19A
	for <linux-security-module@vger.kernel.org>; Wed,  4 Sep 2024 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480070; cv=none; b=bDGXrkKu6k7vmMv9HQ/xpRlyXLBQsCQJBxbXw/puyyVK9LSWC7EyrFg0i5cmPr0DrM5BOg1v9c15RRn8zTUNJlMTBx1DZsgu4ue3XJx73yd6NI9xgbbi/K0ST8pVNX6fRP6Kr8f7LDxmFguPifUnuPhHfgRYpN/NX6YgmuBD2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480070; c=relaxed/simple;
	bh=4ZW9uYBRy1l5v3eg2vwYnWmQtnxuduXzhYgb0NI7pac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYavvGsDzaK9gOqpXWj1noO4hoCSMBVSprx99Ufba+7PbxuQUQwwwHWshh0Whn7Dg4qnp41m9gyGNXe5TKpz7RnqMQGdY4qjjZuxKx09z3+EBokXGae+WyzPXboOY+inGMaSCDQCIlgEhFTv6xzVjJIogXH98LxU9jMOpJLBM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DSUaYCWr; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-699ac6dbf24so61725177b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Sep 2024 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725480068; x=1726084868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj31Cc7yUKdv/FGIF8ZxPGEVE5FVuiVNrp+0ISWDt4c=;
        b=DSUaYCWr/prACtzyg/rPSUvm30yKQ0V+ubT7ZcPSXOQZrWHKdL2v6lCjM/hTEPDtE0
         sqVlA/wLifJgfoU7GeeLALd/fPen2C7kHUFzlntnDXlarJSTTI/UX0v1hEXUIrrcSIfV
         4c2upEGc4WamL5D1Vt300uOrSwbx8ytzKILJLwR0yIjXCON37wB110LKDv1j2j/JehXn
         bzAe/gcx6lzajTXH0V24JE5VH6x92U4rberLWfedRvfS9ghSQv0j6VPPrx3LqtEnQooD
         uFLi2BHXKgpBFmJ8uMgI54nUdksi1sl+l/ZJ6NMD2mHs59cLJo3dzmJW8CRwpeeC1nZb
         rUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725480068; x=1726084868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj31Cc7yUKdv/FGIF8ZxPGEVE5FVuiVNrp+0ISWDt4c=;
        b=VfIfUiN0OytWAFJ1fqu0OkTDtZN0Ufex6VjPZcBOtATm8+yf8NsoFVVtlvxVEDrA3H
         bOrVC9/wezlnwJ0hUSMwv0vYMumJKECBZX4dFFzwbGY2Oqfq3hXPhp3qmGlcSL3Lu5/V
         dOhP8+njB01m1KmhGx49f4fwB93A01mD5fD3vImCeqKyzr+cQRj073nZpLwopojAbYl7
         qxSuFqVRVqEivCCl7GORiSj5tPJJqnstod6U0/WwAOT4HnMRkNyxoknx/X1VOv+jTnRV
         fBDKgOQJL5SD6MbXfop8RG5B53Vgu7FdcN/iI5oTIoupwasNhxRrKYnnr+DW48SbRj+K
         F1CQ==
X-Gm-Message-State: AOJu0YzVhyk3E0Jqth69JC3bAPb1R+BqlmIyuj6v/7nyP3oDu/RDejjj
	OlcKldCl84ko8S44yHA/WPEm1ymLxucdrUWt+sl/3ZLm9kc30YvbIh7l4p6p+iikZQ6P+n/yy3+
	wTHbYJpbON6J3zjJNi5LKBXhNdkHje4QX6Gbb
X-Google-Smtp-Source: AGHT+IHwvQ13BznmsQbX7s8QKh0hPJ3ZlsV9dmecF5yPb9RpjrIRg7UHuPNLul3M/O4Vy1wrYN7rj/2T9vkcOmYq8W8=
X-Received: by 2002:a05:690c:3693:b0:6b1:135:4d84 with SMTP id
 00721157ae682-6d40df8a252mr200806537b3.16.1725480068164; Wed, 04 Sep 2024
 13:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830003411.16818-2-casey@schaufler-ca.com>
 <0a6ba6a6dbd423b56801b84b01fa8c41@paul-moore.com> <b444ffb9-3ea3-4ef4-b53c-954ea66f7037@schaufler-ca.com>
In-Reply-To: <b444ffb9-3ea3-4ef4-b53c-954ea66f7037@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Sep 2024 16:00:57 -0400
Message-ID: <CAHC9VhQ8QDAGc9BsxvPMi6=okwj+euLC+QXL1sgMsr8eHOcx2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/13] LSM: Add the lsmblob data structure.
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 8:53=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 9/3/2024 5:18 PM, Paul Moore wrote:
> > On Aug 29, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:

...

> >> +/*
> >> + * Data exported by the security modules
> >> + */
> >> +struct lsmblob {
> >> +    struct lsmblob_selinux selinux;
> >> +    struct lsmblob_smack smack;
> >> +    struct lsmblob_apparmor apparmor;
> >> +    struct lsmblob_bpf bpf;
> >> +    struct lsmblob_scaffold scaffold;
> >> +};
> >
> > Warning, top shelf bikeshedding follows ...
>
> Not unexpected. :)
>
> > I believe that historically when we've talked about the "LSM blob" we'v=
e
> > usually been referring to the opaque buffers used to store LSM state th=
at
> > we attach to a number of kernel structs using the `void *security` fiel=
d.
> >
> > At least that is what I think of when I read "struct lsmblob", and I'd
> > like to get ahead of the potential confusion while we still can.
> >
> > Casey, I'm sure you're priority is simply getting this merged and you
> > likely care very little about the name (as long as it isn't too horribl=
e),
>
> I would reject lsmlatefordinner out of hand.

Fair enough :)

> > but what about "lsm_ref"?  Other ideas are most definitely welcome.
>
> I'm not a fan of the underscore, and ref seems to imply memory management=
.
> How about "struct lsmsecid", which is a nod to the past "u32 secid"?
> Or, "struct lsmdata", "struct lsmid", "struct lsmattr".
> I could live with "struct lsmref", I suppose, although it pulls me toward
> "struct lsmreference", which is a bit long.

For what it's worth, I do agree that "ref" is annoyingly similar to a
reference counter, I don't love it here, but I'm having a hard time
coming up with something appropriate.

I also tend to like the underscore, at least in the struct name, as it
matches well with the "lsm_ctx" struct we have as part of the UAPI.
When we use the struct name in function names, feel free to drop the
underscore, for example: "lsm_foo" -> "security_get_lsmfoo()".

My first thought was for something like "lsmid" (ignoring the
underscore debate), but we already have the LSM_ID_XXX defines which
are something entirely different and I felt like we would be trading
one source of confusion for another.  There is a similar problem with
the LSM_ATTR_XXX defines.

We also already have a "lsm_ctx" struct which sort of rules out
"lsmctx" for what are hopefully obvious reasons.

I'd also like to avoid anything involving "secid" or "secctx" simply
because the whole point of this struct is to move past the idea of a
single integer or string representing all of the LSM properties for an
entity.

I can understand "lsm_data", but that is more ambiguous than I would like.

What about "lsm_prop" or "lsm_cred"?

--=20
paul-moore.com

