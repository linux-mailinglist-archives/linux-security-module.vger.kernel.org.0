Return-Path: <linux-security-module+bounces-14237-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ05JriQeGmarAEAu9opvQ
	(envelope-from <linux-security-module+bounces-14237-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Jan 2026 11:17:28 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 279B4929CC
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Jan 2026 11:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F99F30579CE
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Jan 2026 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58536338916;
	Tue, 27 Jan 2026 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="R+Y+q3a/"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119272F2616
	for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508788; cv=pass; b=USgjeT7vwdmwsRxAvxaispuy7OqcRAumYXcqxjHBC9CZOOUvGN42dmfPYSNJhAtjb9DeYIklYHvmkzJ5lpfTbzQEAeuXyvEXfhrJdts+VfrgGjIOHCmxE0xKSje5i4ma9HTjulXf1/pTFAAb5HLATU0Rm9pGlX5TXkOkE3o3y+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508788; c=relaxed/simple;
	bh=BNkNDaRw7wJvmpZ0xqHoUNkLvSMjGh8Igx22lzCei78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzWTOuMNc3SwvdK/AvIjJyknG1Z0GsclZMImnS2KsjuQ4z2wvr3JZRgl14n4rng46dZmriAI0tpBl4a5cvty9ucG6XHgvFY+XKdgqfXeIznBkCw86GGWkrszRyLF1PH2hJdbKm2BSK2Z1r/ms/4l7b6zsJqmy1C9Is7/yT+7OLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=R+Y+q3a/; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c634c20be90so1864346a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 02:13:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769508785; cv=none;
        d=google.com; s=arc-20240605;
        b=XcIjH15xm/+QrwdiGlW5fDeyr7GHK/vg6Ub/hD2Nd4BTfo6fsssjzKAAdzN/qa7zi2
         ngl1UnFrPzWgrgSdpf2wjXZVWuNec9LSUJrBt+mIeM8DJlEVItpG7PCJJAIJW5ymvl9u
         kieY/3IHbdRfxSIXGfB1w5u7LlYM4VPMHNDJHUcyKBRVzLwdjpK0nuXaw3wxxH2VOinC
         +6A9XGWcMo24sQiJhZpx9UdCX7NTpvj1ldESIp7k1N9ELTDsxrFzvYzsWUV0YBwFxQ1A
         oygY+pPe5a0i9sqMmeR7NMxepb/5bK3l2NbXqllQZM4tCzKn8la4Hx+7XmEzK5Ffifh8
         HIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pbeSfjy2R8c8CkBxZ7PyS7O/VnqwWM72yxw330pD0Pk=;
        fh=niylMNbbFOd/aPF5wlz3BIuZSXAEE2bD1ZeqeQ4yT0I=;
        b=Z8T+OE01jv8DJaBVjjR7vymXM7fcpHYClfvjMZIaBs6Nls9xNugI8kowu05/HQOsFz
         RUEBj8Fet0qLDMSPb2VxnOucP3+EU6KtN4m4akSa49RYO91DfvocVMjJyTQdRpe+q2K3
         SE8bEYETpsLRl6nwKPdnsiqlq06Xq6tWijop4XkIsI+WcHsAXlmPEdxHQZ+epYMP/CFL
         W6pnzXI22ROrIMfJsYh+wnOAw4zEeKQqwZAVzRdyi5yNM5VZkrMp4GujltSYghyjD6h0
         emcOZngAqCFU5mhA+xLoY3IfBpSljctVdVmWQTUlS85/voHx1ETDIWnwQI/v7M7oySJu
         X06A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1769508785; x=1770113585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbeSfjy2R8c8CkBxZ7PyS7O/VnqwWM72yxw330pD0Pk=;
        b=R+Y+q3a/aYEchjOzn5HXLDiF0RVAXsftb6tuQUYXc0zlnJz6l5E4JC6dIfV/JsMBg6
         MDugf75hH4Iid1xZPUIFgV7hBSWCHA1S5gPl0vKoKW/cn35Omn27O2hSRHDFLBh27bQs
         kYTj2kMdVeWRY32MZrP8RixIH0GHFF1V9xiOqMvuBwz7tRhOAFOHc8q3R3uXW6Lr8GP4
         ZWpm+Ylth1TggyrMiRy2p/9uZZtFzmrC0qJIdKBdwXei/vF2vtSGvabuhZbCi5x6C6Sd
         i2nPJ/VkosfwtUKabOnEIWjSFtSCmO8PSB+NZTO26PDY5ZhrkDgYtZhzDguylFzBbMN4
         VSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769508785; x=1770113585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pbeSfjy2R8c8CkBxZ7PyS7O/VnqwWM72yxw330pD0Pk=;
        b=TP+0nxD/RUzNpfhMqTSN+jXjhn2WEwozn05+XrvY1XDrBnjrWjclD/Flt/pccu4YN8
         Z2Hg3hplEgPIoyfmM+nFHkG7YoOkFTqWzZoxTGWPfoySEz0dzALjB16TOGI9Xj2I558K
         3680eVY6SEa2jZIXEsAdqhq6gmsedAxnqK86/EsJVcSgMIbCOnLKl7tee0+m2zvRUjxA
         vICSaY8JVu+apKfl1FVVv+u0HVQ2zGFnaddlc8RlhvKvezBwt2yzqS/lOai70O5YpBso
         jPUizZSu7+f1Em8091u3FU6KCWJsIx5KGbceIr6HQ5rClBHqPf9pnk618rcftbfk3+8G
         9bXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVe1sykPKWiYhsncA9IBM8zU7cAbc1q9SLe9qT7VFL8/rDxq6NZrOgJpm8sGj1z1nHhUfOez95/ZQ1c3kWHUKuD6W98gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSG+6fMwQWfvcfLFrNKVPKdqs3xMXllEkn0Jx4OmtYI1TuyCDe
	VdY5NvdLV7EhY9JjrXPZEgYhXdFEcR7r15A7m06nwPNOvHVrwKjBbXxMjg7byFA4Fo3/ssJhuZG
	NlEDvNqtS/BJMbX1JXVIcQ/rIoniez6zalFzHjzTz
X-Gm-Gg: AZuq6aJ1NOfCtgsiAXPdsB2IwO4xVmadB+1kW+3NP5T3i1mbXgDQXWUhJ1gUgM83SER
	TluCoYDQyhxtFk2bgnk8IRNglxUCPKsuChgarF5yLUO8vPbTHS9lxz5uwDgjjzPm06fQAxPMIv6
	hrDHMNPaD914dCBVBSpd7kDa/aqHfGTSXwBRWfrzQlODzQSlQ31oXAynwedM/45NZ1nSHNlOJXQ
	cmqZXrDuClTnSmz93JMv1qxgIsMjL1c/7iwnFei4gUz97087jC2ciiRdFx194r/QABPKfHzcOAg
	kAmcRiVVIQC2dbr7RAuCQOy1H7J8CUuOI8wP1jxXVMf6Cmh67yPKFgR4D7wJD7u/QhDKu8QNyaa
	fSuDUcjcdog==
X-Received: by 2002:a17:90b:1b49:b0:353:5c16:aa7 with SMTP id
 98e67ed59e1d1-353fed876demr1248805a91.25.1769508784958; Tue, 27 Jan 2026
 02:13:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-ima-oob-v1-1-2d42f3418e57@arista.com>
 <b873ba2c8057aa749aa0d058002a30776d0a5248.camel@huaweicloud.com>
 <CAGrbwDRgQShh==Vb_8QWoByKV-HXAwV_CGyAoAzjRrHU9c2KbQ@mail.gmail.com> <caebe20b5f30cb76ba8021443ba50ad06a2ef570.camel@huaweicloud.com>
In-Reply-To: <caebe20b5f30cb76ba8021443ba50ad06a2ef570.camel@huaweicloud.com>
From: Dmitry Safonov <dima@arista.com>
Date: Tue, 27 Jan 2026 10:12:53 +0000
X-Gm-Features: AZwV_QiSBPPfw3H7Mo24J3F156JO1ZCc1yz7--IZjmP_FgJPL6awTCJb_xgRqFc
Message-ID: <CAGrbwDTTPNkogW1WM0goz-JTgV+CQgO4fGng8brox5+wWKGFtA@mail.gmail.com>
Subject: Re: [PATCH] ima_fs: Avoid creating measurement lists for unsupported
 hash algos
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14237-lists,linux-security-module=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima@arista.com,linux-security-module@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-security-module];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arista.com:dkim]
X-Rspamd-Queue-Id: 279B4929CC
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:02=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
[..]
> > I'm not quite sure what you mean. `algo` here is HASH_ALGO__LAST as
> > you see by the check added. As it's initialized by
> > ima_tpm_chip->allocated_banks[i].crypto_id, I presume it's
> > HASH_ALGO__LAST there as well (didn't check this assumption though).
> > Do you mean to print hex value of HASH_ALGO__LAST?
>
> Even if you don't have the crypto ID because the TPM ID is not mapped,
> you can still use the TPM ID (ima_tpm_chip->allocated_banks[i].alg_id).
>
> I wanted to have a file name that includes the TPM ID.

I see, thanks, I'll try this.

Thanks,
           Dmitry

