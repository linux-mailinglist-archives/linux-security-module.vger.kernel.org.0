Return-Path: <linux-security-module+bounces-2455-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8432089348F
	for <lists+linux-security-module@lfdr.de>; Sun, 31 Mar 2024 19:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4CE284B19
	for <lists+linux-security-module@lfdr.de>; Sun, 31 Mar 2024 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB8315F322;
	Sun, 31 Mar 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KATUYlPX"
X-Original-To: linux-security-module@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB515E5DD
	for <linux-security-module@vger.kernel.org>; Sun, 31 Mar 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903428; cv=pass; b=aRYQWwP4FYgRcPGMB13lC9/VcE6DgT5LJlhadd/4c/tTWTvZ+Ru2kPOKwfMUvYVe1mX9UQWOMV5uoJFElxll9l45+ZMDSRw0jgeBPGGQM9RXXULofzmplCe+RYjak1WGpVVZyFTHebbxJ07Q94Y+eREb+79HmlXRVXo32SGOQqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903428; c=relaxed/simple;
	bh=DF/L0+Q5E9+KTQeS14VYcTiSfXzgyZHE5qV4GXYVLVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFI47Ov+1jT7wusocvgscsus9DRd45bw4EeGIyBYNkJfjlCBekrVt33OB5sEprwYKOpLIuuTltqlf+oXIhsYa0h3+1WD2smP96ZOJJZJYu5/lTTDwE/T0lkialnLignbjgLePfSgb2u9R/Pq3j5++GDvzD91WyctNW7xshjSNXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=fail smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KATUYlPX; arc=none smtp.client-ip=209.85.128.175; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=paul-moore.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E5207208D4;
	Sun, 31 Mar 2024 18:43:44 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ub_T_zf_ql53; Sun, 31 Mar 2024 18:43:44 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 55570208CB;
	Sun, 31 Mar 2024 18:43:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 55570208CB
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 498EB800061;
	Sun, 31 Mar 2024 18:43:44 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:44 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:05 +0000
X-sender: <linux-security-module+bounces-2449-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoA0GQFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 11214
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-security-module+bounces-2449-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 9D32F2025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KATUYlPX"
X-Original-To: linux-security-module@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711834783; cv=none; b=nwOgGl7r3yIMuISFv3aqTzdtSUdXkBIc74XqSRTVfCii10Edq5W5rgk2QeCmbBSlmXFZ7ep6zVl+JA/YqPH0Mvym0PdRJvzH1TduNHD6DiRyVB1yJfwZsjNfl2s0YhqJXoX8TZB1O9y4HfPOMbQNUi+XQ80XbUS745O74vYHlbk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711834783; c=relaxed/simple;
	bh=DF/L0+Q5E9+KTQeS14VYcTiSfXzgyZHE5qV4GXYVLVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/bwcNN8GzOR1rmzEOr2oYinsqS3OLDVPY51qt04Mm01B4PhCnuxL8UrCDGjWEjoiTPfCdvWXlxrpyUh2o9ct1MLwJoN9QfSiW2AoB6o+J4JhAgv6K+0ygmtftvTJdHhO3RaLZ/q2tegIODAR5mMLvaPsW4FikCetcQe+7HsUQA=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KATUYlPX; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711834780; x=1712439580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGWA0gwym6PRWQPU3SPN95r2Cy2WmqnySATlGVqX0IQ=;
        b=KATUYlPXmsAlLoU34HLNsLK1fAvQCGHDI9FuVQpNSXqLf+Qwo2akp57rJQ1IxIqZy8
         +LtG6cV750HgC2kYtwNcWMibLRsYo8Dyf1nb5JPtATqqYBvMeK3N+j2uTnbwUnzUOAOx
         196Yzpm97OqTdH4nGmVMRhCpw/qs09FFvd7Abpg93sTUBlsTjHRvs2dwZ9DxTb0xXC+o
         OZuGJ3rRiLewAuDYRs65vAWhuttu8LL9fboHAIJMQIUOyCaJu7DDRJQLjoSF50XnqcaJ
         pI+gk3eWGl2EkipTPZU52kkxpFW8kJ3y+KfnQ4brEgPc4VJnhGCPJF+VE6iCvTn0Jfm6
         9mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711834780; x=1712439580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGWA0gwym6PRWQPU3SPN95r2Cy2WmqnySATlGVqX0IQ=;
        b=dQ/lWSZfBupJrZsV7oFydfo+91w6dlrcvh+gEFc2TpJQBBkngrk8xUOWh8rrjbc7HE
         ZZongwkH+Rs9T78aDrhmCjhZ7WKvYFTaURQVJuyg7+PKAUZ3orQi/si51kd161IOSDj0
         bqYD4a609WzHgEQT0/XV8fpPKaA7gp67LnPWOkKkJPqYp2NyoGbhdvu1zFL1IeCbxsTO
         3x7YQN66YJE0d2mH+lF8UFDdyzZzBUKLC0umEbVCfMUDCJ+bwG304kKL6JO7IccQRIYI
         cq67qofEupdP3okvADPnp2Zz9xsKL4OGBx2tewBAOCReB3UVG4Zybu8JGzEUz/Kri0lr
         fprA==
X-Gm-Message-State: AOJu0YwZsLbkhjb3WyZ3/Tw1jJVNAYWl1tkIX627x7vtyd8dNL+0c6dl
	bAHnUrcH/XkY0APsHkb2tfbeUg82GS5MRH0nu+DL7De3NbUh4XAhQD/dAEsP2uxi2cbNXMix/Ec
	/KtpXX+H1AHHjDAFtluSZT3n9Wv2Lpn2JasuU
X-Google-Smtp-Source: AGHT+IGDR7sSsXYtGe+LeHaAVsSnqHcKvB5dfKxCnr8LKd3YMoaQWtkNixesi6Xsn/zjb3RSYA9G89IhSlmvu1V9vy8=
X-Received: by 2002:a81:4c86:0:b0:614:4f9e:5671 with SMTP id
 z128-20020a814c86000000b006144f9e5671mr4433014ywa.17.1711834779854; Sat, 30
 Mar 2024 14:39:39 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324223231.6249-1-greg@enjellic.com> <CAHC9VhQ22ef_o_OYue93RZfff70LPuOaCuN7Czv7HiEy346Svw@mail.gmail.com>
 <20240326103047.GA19964@wind.enjellic.com> <CAHC9VhQvN43LL-ynV-ZZgR2L8wFfUeq2-SZb5QHh9ZMWtz4C1A@mail.gmail.com>
 <20240327091644.GA32347@wind.enjellic.com> <CAHC9VhSjjeBH2CE5i+PK9Zyg661k-ryDbYkoPLtEe-g52DW0Fw@mail.gmail.com>
 <20240328153800.GA17524@wind.enjellic.com> <CAHC9VhTwZD7OU9v36HOd28a6jULLJeoQTdNSBYZWSrsY+jf7ZA@mail.gmail.com>
 <20240330144604.GA4625@wind.enjellic.com>
In-Reply-To: <20240330144604.GA4625@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 30 Mar 2024 17:39:28 -0400
Message-ID: <CAHC9VhRruSLET+aOhCt7WKucWNBE_qLCYV3won+p10XOjLLiHQ@mail.gmail.com>
Subject: Re: [PATCH] Do not require attributes for security_inode_init_security.
To: "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org, roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sat, Mar 30, 2024 at 10:46=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote=
:
> On Thu, Mar 28, 2024 at 08:26:11PM -0400, Paul Moore wrote:
> > On Thu, Mar 28, 2024 at 11:38???AM Dr. Greg <greg@enjellic.com> wrote:
> > >
> > > BPF provides an implementation and would be affected ...
>
> > Casey pretty much summed up my thoughts fairly well, including the
> > "Bear poking trimmed" comment, which was worth a good laugh :)
>
> Very good, we will take Casey's e-mail as the official position of the
> Linux security maintainers on the functionality under discussion and
> similar issues moving forward.

You're welcome to take whatever lessons you want from this thread,
that is your choice, but please understand that your interpretation of
this thread may not accurately reflect the opinions or policies,
either now or in the future, of the subsystem maintainers.  I
understand that developers/engineers like hard rules, it's reassuring
and comforting; I'm right there with you.  Unfortunately, the Linux
kernel is a bizarrely complex beast with changes happening on a
regular basis and in an often unpredictable way.  While I do attempt
to provide guidelines on certain things, e.g. new LSMs, new LSM hooks,
etc., ultimately decisions still boil down to the
wonderfully/frustratingly vague "maintainer's discretion".

In this thread, especially the last few messages, the only "position"
I would suggest one take as a lesson, is that the LSM developers don't
need to be told about the BPF LSM, or BPF in general, because we have
all be struggling (?) with the challenges it brings for many, many
years already.  That isn't to say the BPF LSM, or eBPF in general, is
a bad technology - you can definitely do some cool things with it -
but integrating it into the kernel, and determining the appropriate
boundaries between BPF code and the kernel internals, has been (and
continues to be) a struggle.  Simply dig through the archives and
you'll see more than a few threads on this subject.

--=20
paul-moore.com


