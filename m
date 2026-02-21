Return-Path: <linux-security-module+bounces-14786-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /ndYGa2xmWnlWAMAu9opvQ
	(envelope-from <linux-security-module+bounces-14786-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Sat, 21 Feb 2026 14:22:53 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEED16CE46
	for <lists+linux-security-module@lfdr.de>; Sat, 21 Feb 2026 14:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 231D83011841
	for <lists+linux-security-module@lfdr.de>; Sat, 21 Feb 2026 13:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8807517A2FA;
	Sat, 21 Feb 2026 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIz4qWhW"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC013BB40
	for <linux-security-module@vger.kernel.org>; Sat, 21 Feb 2026 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771680170; cv=none; b=eyPgMwue3sc9mE/Afu1zitMcRR2KtnzOZiQS/w5fXpfUpeuRyS3h9YYQFndamy6m9EdjejB4FztIq/sibp2g1/vM1Kby/VCFHQanJvS7/srdP5shcesxVrjf5TSMLDFrGsmYsVeDEhYbpvkLIW6CTJxhnOTP9y6/y/jh+QLx52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771680170; c=relaxed/simple;
	bh=kkD64j1Ze9TLb9mL9k7K+jgJKoeDRZli3oOug/OCQAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzkeVG0Bhm7lg8tZyK8jxfF4y4sTvWd/zLvB1/DN/aiGvBc6P2r/GXMq8I5FFKTxjbjQyPHxjuTbafKXzB/0kDNt540ADzRf0nqrzVDvcQB5+duh45BYOgXlEvSWbXpSKvVZFoxk/PWgk7jUXrRZIb26aOb6S7i9WsQqk5z0iK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIz4qWhW; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64a28af2f4cso4030861d50.1
        for <linux-security-module@vger.kernel.org>; Sat, 21 Feb 2026 05:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771680168; x=1772284968; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JBYOI2hLxGyTLDTkFkEs+Byq38GU994GDh4zrO+b5no=;
        b=QIz4qWhWfmROriPaHjVPQRmQi6DNK1kb9V50ctfID3j7wEurvcWUPj/hdd3b+XKLF4
         h+PRUfGBccuQjBD0eUGelFBIQxg9eWecElmaa4sEwbtFxZktTx0+4a8yxuw+gMbmEOxd
         /mHRF4ws9pHaDd7u61tJl9YQHerCDPeIgpWDYGdo3HCehsbjnCt5wf+ebcaNSOK7IDwH
         WlKL6n0QsjOB4gUZayUj8Cgm7Ny7FQnD3a4kN8p+6MuKoQf/Nd+HWRTU3vzt49LPAa15
         i/mVW/i75Kh3kIdFqikpllZOOhbJF9QMWh1eeNRHgag7Y3HGFR03hgTLFiHKuOwDUCgC
         SwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771680168; x=1772284968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBYOI2hLxGyTLDTkFkEs+Byq38GU994GDh4zrO+b5no=;
        b=CWdo+9rx82hvc6FY3tz6zH+Xiz5PEgsOwcUxAWLsb8Pf1c04lOIwH6UiQHYpWhi0HG
         pt/qyiACj+DyrPHFhNsvmY+8QAk1kfM8RU90Bfn7x0nk/SVWpRZDD10PJkhM66UIj8DK
         mo7tFqdnWHaHgyYyh6P3lzgW4f5eecbRi9Qjd3Q9HHbr9fCi/iO+x75UN9T8wHIx1MiC
         FhELjNGRcMC+uU8vs+mITsBpXJMUpVlkkNOsMFsSIbvYezJ40oKSlqChLmTcRQj9OGTc
         D78TbLar0+JJDqAiMaTnbOhA47JbQEcEqV7cy0uUevgLAQENum9au9zU3URuIroV8CBh
         Lc5Q==
X-Forwarded-Encrypted: i=1; AJvYcCULnAUPYtNiFlktIY4/ypBMVcHagobUe6ojGGOsqMX3erhiWRznWbdKkE1zVnwKk++lH9FUhC6wZVapw0rx87GYgtVMk6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG9RrO9bJbpG5VnnNDbZY0buQ2VuU8ZwcdE1v0DTUDbYY/dmEu
	WfCO3DQXHHkgiMQx4H+ozruw9/p49c1mz/wGfQkiSUWod3e0Q8OdhZOf
X-Gm-Gg: AZuq6aJT1dpHCn3WG+2ClZ9vNL2J/yBmeyq2isOz2ZQydmehHSYVMCSMU9IKFndgOYR
	wud34tYl83vB0gW7t85egXdxZXYwClfD21MS9dLsBEUNxDe15xFvzdn6D69bdgAAHBzFp5DeuHL
	bZE3832N0GM7RqENpWRWSPFb1j3Y/VPBCsiIFZENCWljQLzBXHUHYAwGuX8YRBzfZc827rZAnhR
	ZztSFnUNHZ2+kIqBnna42IR2pjbM8ujtGnr5pqAN2nTlNj5IJaQUbSlIR2cskGxmERN1BKVYniE
	mW3vUiHrekdzuPIzmNSnshTdega1Kd5N3Qu++zSiOq74g2t7S/dX/1cxhlwrjVxokEkBmzf2Xie
	NHuo0CNlQF2aVqPkV5/M4TVang1/Hi2HUL/+xHGoHP5qN0fjNmJxP/lmwOu97DaKbHAl/P0BPRe
	4LBtvlmC8OkSgo2ITDYqaGnrY0Q3reug==
X-Received: by 2002:a05:690e:b8d:b0:644:59ed:dba3 with SMTP id 956f58d0204a3-64c64191808mr6545217d50.30.1771680168233;
        Sat, 21 Feb 2026 05:22:48 -0800 (PST)
Received: from suesslenovo ([129.222.254.139])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a279421sm999192d50.6.2026.02.21.05.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 05:22:47 -0800 (PST)
Date: Sat, 21 Feb 2026 08:22:46 -0500
From: Justin Suess <utilityemal77@gmail.com>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
Cc: brauner@kernel.org, demiobenour@gmail.com, fahimitahera@gmail.com,
	hi@alyssa.is, horms@kernel.org, ivanov.mikhail1@huawei-partners.com,
	jannh@google.com, jmorris@namei.org, john.johansen@canonical.com,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org, m@maowtm.org,
	matthieu@buffet.re, mic@digikod.net, netdev@vger.kernel.org,
	paul@paul-moore.com, samasth.norway.ananda@oracle.com,
	serge@hallyn.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v6] lsm: Add LSM hook security_unix_find
Message-ID: <aZmxpoy1oxSl5yGq@suesslenovo>
References: <aZcPd3OKqxwCZV-5@suesslenovo>
 <20260219200459.1474232-1-utilityemal77@gmail.com>
 <20260220.70d0460d1309@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220.70d0460d1309@gnoack.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14786-lists,linux-security-module=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,alyssa.is,huawei-partners.com,google.com,namei.org,canonical.com,huawei.com,vger.kernel.org,maowtm.org,buffet.re,digikod.net,paul-moore.com,oracle.com,hallyn.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[utilityemal77@gmail.com,linux-security-module@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEEED16CE46
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 04:49:34PM +0100, Günther Noack wrote:
> Hello!
> 
> On Thu, Feb 19, 2026 at 03:04:59PM -0500, Justin Suess wrote:
> > diff --git a/security/security.c b/security/security.c
> > index 67af9228c4e9..c73196b8db4b 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
> >  
> >  #endif	/* CONFIG_SECURITY_NETWORK */
> >  
> > +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> > +/**
> > + * security_unix_find() - Check if a named AF_UNIX socket can connect
> > + * @path: path of the socket being connected to
> > + * @other: peer sock
> > + * @flags: flags associated with the socket
> > + *
> > + * This hook is called to check permissions before connecting to a named
> > + * AF_UNIX socket.
> 
> Nit: Could we please insert a sentence about locking here?
> 
> Something like:
> 
>   The caller holds no locks on @other.
> 
> (Originally brought up by Mickaël in
> https://lore.kernel.org/all/20260217.lievaS8eeng8@digikod.net/)
> 
> Thanks,
> –Günther
Sounds good. Would a "Link:" to the mentioned thread be appropriate in the commit
message?

I feel like the reasoning for this is subtle but important for hook
consumers.

Justin

