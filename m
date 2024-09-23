Return-Path: <linux-security-module+bounces-5600-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40E697CE92
	for <lists+linux-security-module@lfdr.de>; Thu, 19 Sep 2024 22:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25F5B20D0A
	for <lists+linux-security-module@lfdr.de>; Thu, 19 Sep 2024 20:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39554658;
	Thu, 19 Sep 2024 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BUNJWpNS"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ADD24B29
	for <linux-security-module@vger.kernel.org>; Thu, 19 Sep 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778459; cv=none; b=X/Il2kmkWOrv84a2Q35iseaKDoIu74sQU3G2Y9WiLPh+5iIf8rReoCbfuZ4KTPL/2y9Eb5XTM26wlvq57bOUTS/XG8ObmQbBQIOOWrbhUUF0s3N8tj/L69M/QY5/E0gV+tBIdMVVccHlr7oLOixLRh7DLBuUC4YHXPJDSvTgxKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778459; c=relaxed/simple;
	bh=LLYF4HCt7wGpOmsf8gBZNr6B3FbRhbhRANn6W9z0PMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmPP5VISKw/et2szhw0foqItZfJNgX0OEq8lTwMwt0IR1D+3Na0nMUxigHOadOF1N5nc0CN9oI6EJJWefRiAGfEd/Lsxh2jyMr2P5QkvAa06EVse/JcYxVnEYRAo8nly3Nukoank0TqC0SSis6Uw3J5hhul7CQEllXu2HckEih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BUNJWpNS; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6db67400db4so13732727b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Sep 2024 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726778457; x=1727383257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNSalT2dJe/sVHCZY4JIrPde/S2tv3TfgE18cTWAoX0=;
        b=BUNJWpNSjhCRP06xzaNajVGU2J0GuJVRWobbkqNpHa+mrHQwBjgbaMoBzbosHfbr+1
         UAquV3isUU49PH8B/ZRyYJf5SeaJAlzU0VbdeYodVU+Yg0US6FI4UTZ7rNDkOplQpGyF
         4FNrZCqbvanw6PUJ37OYrtAqdL4qvhyl/mS9/ltou/wK2ATZQ9kC42+1IIi6fJ8E7c/t
         An/kcu1IvaIEJtuolAzVbxun0iKsqzIDwF44/NfetsFWJXT+waL7UunQMdad41y8N4Gr
         Zooup+eKwqGGUSukhgC0HQujEzo7t4pSVWs25r4XgmmF5K4rmEEUzjZhsQgs1YOlFegM
         wlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726778457; x=1727383257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNSalT2dJe/sVHCZY4JIrPde/S2tv3TfgE18cTWAoX0=;
        b=ZVxVSKmgzDoN+vq/SjjCeN7q9npS68gQ5EakJtXmHV9aA1Q7uB7M/hdvV17vkm9jf2
         QAdXFashfYmADEbhVR8AWFfmf1lNMwx1L+5LM7SjI9bJOss0UHoNdFSImbaO1EvIaE1E
         8bKOTSyUozm9PRCZr2M/2lQY05iu4TrB0u2WJUOJd7YLCJpRPRLnS3MwsmEAzPDryDd6
         2luWPb8hPgitS/rsk7wkjfyvCv4rnuN8n6u2eUqWkSB5AsNu1NZ72/fKhrn+x+9KITlG
         uniE56J675peKj1CTGqQRUo3xlW646It9rrr1Xzogq7Mb5dojHj+YAisodgY8v0I4A5N
         JDeQ==
X-Gm-Message-State: AOJu0YxD31lossnXsVd6sZVgZmbge20YAf+I/0QFnlWa2BYKwflnvo4i
	H0RpLSJJFFrqJ7SxkQ3SO52YW5TqeGR7A4OdN9GzAZBh+fsK2BehAySr4j45qWFQ+O+QQ0EwORt
	1c7am4I8RgBSNmUqGZUFy4bB742J9N89pcyEZ
X-Google-Smtp-Source: AGHT+IG3NYcoIMq/6C5DjJRp3iiyYZFZhIAqjCV5eZ6PayC1+cE8btMaITffcm8uxjDoU34IrnAGWilz8n3KhJjjdtY=
X-Received: by 2002:a05:690c:6189:b0:6d4:b774:e503 with SMTP id
 00721157ae682-6dff2b291a6mr1939757b3.41.1726778456834; Thu, 19 Sep 2024
 13:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919155740.29539-2-paul@paul-moore.com> <45b4a802-6f4a-42fb-85f3-ee2b97c64c07@schaufler-ca.com>
In-Reply-To: <45b4a802-6f4a-42fb-85f3-ee2b97c64c07@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Sep 2024 16:40:46 -0400
Message-ID: <CAHC9VhQtig43rD=iiPLjrYk=fXEGN-ZuC3=UN63az_FE91YFVw@mail.gmail.com>
Subject: Re: [PATCH] selinux,smack: properly reference the LSM blob in security_watch_key()
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 12:34=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 9/19/2024 8:57 AM, Paul Moore wrote:
> > Unfortunately when we migrated the lifecycle management of the key LSM
> > blob to the LSM framework we forgot to convert the security_watch_key()
> > callbacks for SELinux and Smack.  This patch corrects this by making us=
e
> > of the selinux_key() and smack_key() helper functions respectively.
> >
> > This patch also removes some input checking in the Smack callback as it
> > is no longer needed.
> >
> > Reported-by: syzbot+044fdf24e96093584232@syzkaller.appspotmail.com
> > Fixes: 5f8d28f6d7d5 ("lsm: infrastructure management of the key securit=
y blob")
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks for the quick review, it looks like syzbot was happy with the
patch too so I've merged this into lsm/stable-6.12 and I'll send it up
to Linus soon.

--=20
paul-moore.com

