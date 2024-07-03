Return-Path: <linux-security-module+bounces-4047-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518D4926A12
	for <lists+linux-security-module@lfdr.de>; Wed,  3 Jul 2024 23:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC8E2813F2
	for <lists+linux-security-module@lfdr.de>; Wed,  3 Jul 2024 21:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4732E191F61;
	Wed,  3 Jul 2024 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CD4wMs3y"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9018C35D
	for <linux-security-module@vger.kernel.org>; Wed,  3 Jul 2024 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720041277; cv=none; b=ZpHb6nQ6Jm6GxT0N+0TbbpRakSOSymSgAJ9Y4FDxNHD/zIlw4TWIBOkK6OIUsrg+IB7x7qf0ohXRenZC4+aD7EhxDjMxixWMjZCyj43PtlybQM3YdKZDyqutAjfIlRK7j08g9h+n78qiPYrHKkL1D2fh2mX6mMCrX1A4VP2WJHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720041277; c=relaxed/simple;
	bh=cskfApFNSUaCrjJIA0qePKSTib+4zP5ggDOMc07BnqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpkgTMQKVi95tdG4IPZ9z3Rs67jYF3WnI9W55cRsdXyYmuXaxvCuTBOsQVHJGHUvmtwDx7E+Hhxj1tX8/I/NLt6RyWsadEHo78jsWh9UD+otMqWNoz4DVp4DBy1hapBo0z4zaJs4qtzZihJtqcx5EAHBgfGnJBgZpaZQGEAKuBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CD4wMs3y; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6510c0c8e29so14482457b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 03 Jul 2024 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720041275; x=1720646075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUaoO7N2GAuQnT2k1rXeKu1l0hF+h2kO+5W0dSVH7BQ=;
        b=CD4wMs3y/QfihCUeTeaYoqTOksqPOEquarCfvGxKc17RrlYDJ6p/MC1iHvQTPawCUC
         L5L4R3+grc8WP2X0UwbJudGNk0COYZ5X/KpTQrsIIclNlDIMWAPuTvXvI1NJj4IZKDpv
         BdZVmNpV0YrR3Mgir4nMXRkUanerOFtAC1WBbDqbZyzExcViNZnQ6rUDpmtbjEgPah7F
         2cKtMsGTG53VO+Og9D4Qqam7wXu2e7Cu6khyZsB5kgfTcJn2QlgeeQ3CCCYcLDcutMd+
         LMy4a1s3MC/TS3K2LGCbstv5j7ywt9c2IEHBA4bKkTBFnhCb6qedmC/sRJJVhvnEi3cv
         W7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720041275; x=1720646075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUaoO7N2GAuQnT2k1rXeKu1l0hF+h2kO+5W0dSVH7BQ=;
        b=bOA77WjzhrHS9glUNnzcibegMwVp9gS65vImcVFVKDRB83GRxQN/ilvAPKCW4CZF90
         BUPnlG3gBF4Ypw0QFUheKSBlDvMUpAiZ053v+KkpNS22V0HQV1p0dcXKXwxJau2JTJYf
         GfRnKCIow9Be4/HZyQG035P5X/w0kXD96rz6ExG7HJamZvcKHs9/rDb3II984f0gO+e+
         E2lah5ajbOLPCiaTuzVw7uHOiHP0mmIOxla+QIweQfXxfnbCbvgivaRgruNFaVGIuxXx
         QJTO00Kqeft4dvKz0BV00rNXmB6b/t9tTnJbtz8bT77rqDt34e+STnB8Rq/MuN5fgWC7
         qNcg==
X-Gm-Message-State: AOJu0YxGOevAhvF1BE70q80A3J4djWWe/B9lEwxqCQfL5LjZxiTogEy6
	y8VUuT6hAs4qU4+dLTjeKF8JZIfxxbhYRwQauHMzu5DvNq8Oxvk71+XH22gkPFcrrsJ3fk+wLEA
	ocqLIMcgCQ5aPA5OijtzuZWMd46Hy6KF8rKktZ009kBCGm1k=
X-Google-Smtp-Source: AGHT+IGhol8452o97yDFCbRe/iruMptqEs8IYB13hiDwT+PJaxa2TDB9/usnaUvLI7bE5WHM7vtZTiZX2YR/vMWdIlY=
X-Received: by 2002:a05:690c:360b:b0:650:a5cf:eea0 with SMTP id
 00721157ae682-650a5cfef86mr70503377b3.20.1720041274746; Wed, 03 Jul 2024
 14:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703211134.349950-2-paul@paul-moore.com>
In-Reply-To: <20240703211134.349950-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Jul 2024 17:14:24 -0400
Message-ID: <CAHC9VhTA5tUUH7DAYx9k6X2L4eTzJ1a-ETaJ5+sMZrxKqjKOKA@mail.gmail.com>
Subject: Re: [PATCH] selinux,smack: remove the capability checks in the
 removexattr hooks
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc: Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 5:11=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Commit 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> moved the responsibility of doing the inode xattr capability checking
> out of the individual LSMs and into the LSM framework itself.
> Unfortunately, while the original commit added the capability checks
> to both the setxattr and removexattr code in the LSM framework, it
> only removed the setxattr capability checks from the individual LSMs,
> leaving duplicated removexattr capability checks in both the SELinux
> and Smack code.
>
> This patch removes the duplicated code from SELinux and Smack.
>
> Fixes: 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c   | 10 ++--------
>  security/smack/smack_lsm.c |  3 +--
>  2 files changed, 3 insertions(+), 10 deletions(-)

FYI, this is still untested as my test kernel is compiling now, but I
wanted to get this out onto the list before the holiday in the US for
folks (/me looks at Casey for the Smack bits) to look at and
potentially review.

--=20
paul-moore.com

