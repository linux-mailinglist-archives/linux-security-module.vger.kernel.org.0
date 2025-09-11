Return-Path: <linux-security-module+bounces-11827-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F7EB53E9D
	for <lists+linux-security-module@lfdr.de>; Fri, 12 Sep 2025 00:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696E2A07749
	for <lists+linux-security-module@lfdr.de>; Thu, 11 Sep 2025 22:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE252ED86D;
	Thu, 11 Sep 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZHz9Uczx"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913502ED855
	for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757629458; cv=none; b=F8ozVXydythqqvgwcffUiy9PF99FiTqu18mwRr3kmDdgOPNEt4N8MxUsB03vxgIvcCZhdMrMnrRkQKA6TclGASIlniflODmNxnJ0GASvxnsmtypnOmicd9mAa5FbGkZWsbyM4rSpsu1LbO0YgJojsDsvMZTnVt7wQNPn0dc1hGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757629458; c=relaxed/simple;
	bh=TOxHreosBJoREHUrSH/7ROAH34Ey9FkDleUQJ3zjuXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOUyTNPIARRBHW+jnTTkYhgVJhdCUQsWTzYez8hi/tUk3tGACz3QBEQy3f0kCx3jSsUMlCi83MS/APrMnLLKKxxaoObSoRv4TVNEVMIcJE5CfNcob7H8vPvA4BTYGFxSY0sI+E1IJh4pnyPHcRBZjjHPrQtStS5YJfXyfwdlGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZHz9Uczx; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so797862a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 15:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757629456; x=1758234256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOxHreosBJoREHUrSH/7ROAH34Ey9FkDleUQJ3zjuXo=;
        b=ZHz9Uczxsowl9SabhL2InyavZ32WiFjBKVQPDfuF7ns3735rqGF3gkyciwuXWq9vNa
         U8IyRTE7jeMKHiW1L2xsFnJOiFhiKO4GNpyYXw6EynDuY929/HF7UK36hGFX04nu+iBY
         qkNWJzoHqly90C5rI9LVdf/gQfWDjWUWBsImkaY94QHK4iHWNeEv/+4TaBb0YWHsDcNI
         r2zDKP71OPspCBVUPJX1YVdMDzjRfA1+TpccM0v4dorya8MiTHBqYOlS+m6VGzPXsHI6
         L7qf1bymIOCgyn4OHTGrgsoVsPAvr7jryqLz7c5MFs9pR+TA1eaEh80Jxay7B3z8e1UF
         OqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757629456; x=1758234256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOxHreosBJoREHUrSH/7ROAH34Ey9FkDleUQJ3zjuXo=;
        b=uNwD3ZojpzpTsM0T6fw3mQgQoNBtnkdoNOibp5cQVzP14aIYmWRlh/NjRz7Y9Z5Frw
         DSrDd7WLYnJFQaITPLpfzpmwZMXwe/iM5dNIWlbn0HGy2OSiBZRqrbzRcAGuPebZ3FIX
         /3VSxmwlhzFc1FZ8BEhysKbI7vhTtLNFdY4qFxkW99dmyt64gBfIo0L3LnAxAG+3uGPH
         IvrdDmS13WKghuwPz8x1BZqVX3JlHyZ3hw7GlpUVnAy6ReZ2jKpqKHWU7XsgSV55OLV6
         aLTkJXBN1jx1ySJdh13nAEPhZM7D0gSp8GMBg1Mqq/WPfKQFdYvPJLQEW88AEapzytO0
         xF1A==
X-Forwarded-Encrypted: i=1; AJvYcCVyIprXwXmxWys2Ims/XGkS0Y839aErf5ct+Z+KABAGAbmoSIkaKHWzZ1QsXbnwGLiRw6uS8H6ExS0+FdC5eUFc2SQUu74=@vger.kernel.org
X-Gm-Message-State: AOJu0YybSdjhyuKHxiPMf2uBPhO/1Rlef4smY3Q8t1ePjDVbsRpgxuac
	Pszw73R+RWypS7HuC2CL8lW8m9Q6joXMU3NFl7EOUNXzp8XcyciRKJBRXEg3oKFsTX25iSEqgqe
	YcZkqJDOVzZjTk+cvnCu16HxC4sglTmNRUwOPiIoS
X-Gm-Gg: ASbGncuio2E6+eWX71Lx5EN1T1c2SMkxlYDHKDalxyq05eXfNr64IsI5KOOaPQUODy9
	h2jXu6nfYDR/4N1oDkH1roJia32En04hfdQQ9pwbulumhlpdbOqx5u/uu9WqEonMMQvFvDN+Xtm
	ioq0NQIUzN1R3D2WvsxQ4azv5pBVYSZBh1WqHiZQBs29eopgsehe/g53q7T8UipZgTCsuXS3HUt
	hDeT2UpsG713Rpc3Q==
X-Google-Smtp-Source: AGHT+IFwAAU8D9+qMEnnOqzN+PqllufMoDEh+StKDbwMsV21cf2HN9BAvkgaeC+TDiDMKA9ufKYoxn/esG1aoNHXsZw=
X-Received: by 2002:a17:90b:56cb:b0:327:fd85:6cd2 with SMTP id
 98e67ed59e1d1-32de4f87920mr708852a91.24.1757629455898; Thu, 11 Sep 2025
 15:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903192426.215857-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ4ctFLY=_AUaNso_a4XJ8AziRoebR2ExFss_s3qNnYhJA@mail.gmail.com> <CAEjxPJ695zmnpiLLOHkLxt5HVPhFNRZ9Bu+o4khvFwFX3TLpVQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ695zmnpiLLOHkLxt5HVPhFNRZ9Bu+o4khvFwFX3TLpVQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Sep 2025 18:24:04 -0400
X-Gm-Features: Ac12FXwV7w6xqK--CqU45N_j2zE09QKW8-h7v_y52jV-oYM1_3xbDyMuphzE_CU
Message-ID: <CAHC9VhThEdr1F+8+FiMwMZkYROT9Lyox5Pyvf8mkBPYYRX6WKw@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire it
 up for SELinux
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	omosnace@redhat.com, john.johansen@canonical.com, serge@hallyn.com, 
	casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:01=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Sep 4, 2025 at 10:41=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Sep 3, 2025 at 3:28=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > In the hopes of nudging the conversation in [1] in a more focused
> > > direction with a goal of getting SELinux namespaces upstreamed, this
> > > RFC provides a starting point for a concrete discussion. This is RFC
> > > only and has only been build-tested thus far ...
>
> Gentle ping on this RFC, happy to update and re-submit whenever.

It's in my queue at least, but so are many other things at the moment.

--=20
paul-moore.com

