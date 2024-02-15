Return-Path: <linux-security-module+bounces-1507-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D448566D0
	for <lists+linux-security-module@lfdr.de>; Thu, 15 Feb 2024 16:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6208E1F211DB
	for <lists+linux-security-module@lfdr.de>; Thu, 15 Feb 2024 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB8A132C04;
	Thu, 15 Feb 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BvCcjRui"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C02131E25
	for <linux-security-module@vger.kernel.org>; Thu, 15 Feb 2024 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009389; cv=none; b=GgSNqMvbYB2/NZzr0/M85v7HzJqmW/PoFWthG/7gx+6A4FFUMcz+UbdxGAA1N0di/4ahD1NcmPDoBPKMTQcn6WZi3OW0nJ3nycxL3WX5T2XQpBfs1NpUvJo3qfIjLU30aH1MqcmGSNMvAwi7xTWtvhWR2/wqlZy6sxc5Ijiripg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009389; c=relaxed/simple;
	bh=H/soAYrrSeRXs7NdxjAoiXIbfPiwXFyYm3AeSchaEI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSFOBWfJqXjlMHDN/5wUq3UCjkAwMaaKyVj/6sEWaMKRCE4GmJ8XsYj/i6j7oQyvCfXvdQKzxlB4swGI2vPRp5JpxVZAZhvEPrDSUGhjsJ/MwEXkuxXwGAtnAbHf71+FLeA0naZ73Y1sZy1ULOZbYHJ9phPd+/9TeO/p67RDHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BvCcjRui; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so892012276.0
        for <linux-security-module@vger.kernel.org>; Thu, 15 Feb 2024 07:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708009387; x=1708614187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFQm0M3CmcqPtJRvHCagf6VByOoqALYCn6DYTnpLumI=;
        b=BvCcjRuitUc+Jbgo0sp3PCdep+zPiLjHHISuCWRbRj5zlagvp1mRDi5h0MkuTvX0//
         kKFmWQ84wtQUvVFX7M4QQpgxJ8rFy4t+zIfZk3S6KuKig1e9Rv9NFUfX0McHjF0scydJ
         LL1qIK01pmxD2GLJOi+LuF3xy+NJOI3IQ5LUTpb44+zeKcv8z54CH0STHOGFzUXfBAMS
         TAq+ZWy6N164kUht9XRqx+J1c3iTspPw5VqXXl2gajHwj538dfYf0cEmYjWTqLRtOehu
         89KfbYiyM4ZLFNX7XgOMClOoY+pgxGHsk+QeanDljYRohIPxXvnng7wisUlrJlDutl7h
         W1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708009387; x=1708614187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFQm0M3CmcqPtJRvHCagf6VByOoqALYCn6DYTnpLumI=;
        b=iRYa4nWSd5tBXZF010SW5oRnJdXjOvwqg1hhdmsCdIWEJSTTrluu6o4TrSn+0JmkCH
         tuiNro0JRuh5ikQG8TkgN/JHt6LSRWtWnBN1sIcpoA0HyZUhcsBjmQd2cXUTCtUXt0dC
         XPtbXH4RogMBbwa2CPhTdoN+cROVZG/5CosuCQFB0ifaB4WnC4IZOdugACyZhuyS6+99
         QkJm+Bx7FfBxvDcEPAwbD/7x2593cm7L3eL4XBTS4n3P8nWiBjUk5W6zGGE/yHZ7Nhww
         K3wGY1lfpMs0SYtyG3Tew2k0qWCFAo+VxDLzbTW5eg2e/nHHUsTbdvDUEc0N0pGOyWAd
         y8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO6X4x5Oc5xwMuBThxnk8fSr6viSixDhW2tkPJNgmvyPyLk+NbLDwVL+JoshxKATMkwTPm7gL9FhCDUyp4YJAxngtYipD1KvM7AzS5lEU/0rr7frcU
X-Gm-Message-State: AOJu0YwXgUhcupbxF/9/t7qqPT6Ro3CBvrxcIGHGVdqgBbS43/Ycf1j0
	s6TBflTOfXVdR7bh2v9UFNDTDDLUFd1imFLqNMiSKcHDt1GMgkfE+jxaynd7hI3YpspIoea2kVv
	mISPQ+9JItXAEO48csDwaPr90/02OowZJtguj
X-Google-Smtp-Source: AGHT+IFDJqcQ/zvtSSzS7L8oaKPQoNT7OfyWLmtX0/ZWHRG8kJBAwvm75pg5JW6QaleHBtWyvIXsCWPJtgsfjWAGRcM=
X-Received: by 2002:a5b:692:0:b0:dc7:4935:a889 with SMTP id
 j18-20020a5b0692000000b00dc74935a889mr1745565ybq.50.1708009385102; Thu, 15
 Feb 2024 07:03:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-13-roberto.sassu@huaweicloud.com> <305cd1291a73d788c497fe8f78b574d771b8ba41.camel@linux.ibm.com>
 <CAHC9VhQ7DgPJtNTRCYneu_XnpRmuwfPCW+FqVuS=k6U5-F6pJw@mail.gmail.com>
 <05ad625b0f5a0e6c095abee5507801da255b36cd.camel@huaweicloud.com>
 <CAHC9VhR2M_MWHs34kn-WH3Wr0sgT09WKveecy7onkFhUb1-gEg@mail.gmail.com>
 <63afc94126521629bb7656b6e6783d6614ee898a.camel@linux.ibm.com>
 <CAHC9VhQGiSq2LTm7TBvCwDB_NcMe_JjORLbuHVfC4UpJQi_N4g@mail.gmail.com> <6ffcd054ff81d64b92b52baf097ed21f8ea4d870.camel@linux.ibm.com>
In-Reply-To: <6ffcd054ff81d64b92b52baf097ed21f8ea4d870.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Feb 2024 10:02:53 -0500
Message-ID: <CAHC9VhSQCAUDV7_LgvWw-=u2sxixr-=yKkvoOM7LGxmSy0HzYw@mail.gmail.com>
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, 
	serge@hallyn.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, 
	eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, 
	mic@digikod.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 3:18=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Wed, 2024-02-14 at 16:21 -0500, Paul Moore wrote:
> > I'm not a big fan of sharing topic branches across different subsystem
> > trees, I'd much rather just agree that one tree or another takes the
> > patchset and the others plan accordingly.
>
> Just curious why not?

I don't like the idea of cross-tree dependencies, I realize the term
"dependency" isn't a great fit for a shared topic branch - no one
needs to feel the need to explain how pulls and merges work - but it's
the conceptual idea of there being a dependency across different trees
that bothers me.  I also tend to dislike the idea that a new feature
*absolutely* *must* *be* *in* *a* *certain* *release* to the point
that we need to subvert our normal processes to make it happen.

Further, I believe that shared topic branches also discourages
cooperation and collaboration.  With a topic branch, anyone who wants
to build on top of it simply merges the topic branch and off they go;
without a shared topic branch there needs to be a discussion about
which other patches are affected, which trees are involved, who is
going to carry the patches, when are they going up to Linus, etc.  As
someone who feels strongly that we need more collaboration across
kernel subsystems, I'm always going to pick the option that involves
developers talking with other developers outside their immediate
subsystem.

Hopefully that makes sense.

> > Based on our previous
> > discussions I was under the impression that you wanted me to merge
> > this patchset into lsm/dev, but it looks like that is no longer the
> > case - which is okay by me.
>
> Paul, I don't recall saying that.  Please go ahead and upstream it.  Robe=
rto can
> add my acks accordingly.

I believe it was during an off-list chat when we were discussing an
earlier revision of the patchset, however, as I said earlier I'm not
bothered by who merges the patches, as long as they eventually end up
in Linus' tree I'm happy :)  I *really* want to stress that last bit,
if you and Roberto have stuff queued for the IMA/EVM tree that depends
on this patchset, please go ahead and merge it; you've got my ACKs on
the patches that need them, and I believe I've reviewed most of the
other patches that don't require my ACK.  While there are a some LSM
related patches that would sit on top of this patchset, there is
nothing that is so critical that it must go in now.

If I don't hear anything back from you, I'll go ahead and merge these
into lsm/dev later tonight (probably in about ~12 hours from this
email as I have some personal commitments early this evening) just so
we can get them into linux-next as soon as possible.

--=20
paul-moore.com

