Return-Path: <linux-security-module+bounces-8939-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6F7A6C553
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Mar 2025 22:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA3D3B1D9E
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Mar 2025 21:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D9823237F;
	Fri, 21 Mar 2025 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bh3t4CnB"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D5231A2B
	for <linux-security-module@vger.kernel.org>; Fri, 21 Mar 2025 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742593435; cv=none; b=DEaudg0ZuIAQDgNO/pKzE+RREGhzMKcceM9kMN/clAmPZmrZ4tFZDdU3VGO1HX75qM2Y4ifN5Z7RojvEoAMxwjxuxTPFrh6FEm8rYBt7/0E7KQrzDCtJW80xNWpPItrHmT+x1FipKddl92732fCh6FuOsvumBYKywMkm4a4q6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742593435; c=relaxed/simple;
	bh=L6SJzLz3ZHsbGmHxGldjAhRkD/PLoIDEr7kwiukuZW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekcNwB2h0qX0fk70tH/4veq3xEKcQESW/eub0VLC6DH/9cEx6FXUf0U/+DNFL/EuC6QLliRioam8h3nmwB5MZ5PQL1CHwfD6xRsCL7W+t6MUdRx/l4+kOkaDjlTlhKoECr6BXEh1/QUDi9mVnWMgEbDkxOR2uuYVc4eMbZcOoZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bh3t4CnB; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e60ad903382so1749772276.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Mar 2025 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742593432; x=1743198232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REyftnO4MpLMzJPBIeESA3ysE+wlnss+4em0CBGNgTQ=;
        b=bh3t4CnBP2VNXErbGwiRVhGGSOEV+rP70zCM47KNXfttNoQzAG7FUQRm2QmU/M500w
         YHSq+eYo/8K5s8atR/snLk6SGpyxSf3vb1/qirzicwO77+GOU1JbYfupEMAeWb4x7etA
         tmkhFV9mncMui6zdQ5cejpLJWVMbLgjTNG/8dEMyivqTRGdkfO6Y+Y7uUfEIzfnksXXG
         LlQP5eogVdCMX536R3G1Awqw6DplRqgfnvj8mosiFjHLMpG2q2X0VxN+Gcmpelv2G/Cz
         dE4FR7ZfjtAWtJf4Qadam+iAJx0rU8pvytlwk9cWBfsEsRDW/NkteY23TOOf0vSGLlXS
         HNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742593432; x=1743198232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REyftnO4MpLMzJPBIeESA3ysE+wlnss+4em0CBGNgTQ=;
        b=FXJJDMSOTMJ357J7I4axWXSdt6p2jWdaoo56hhDlGf69Nwz1hKRiOAEgKMGEJAqf/6
         93lVtJtANdsf3ZCdXojMC2uAcEZbtje0/xtPnUWvKte+ptoLvVgXeDS/FLwuMJKlM8dA
         JXL1qtqPfDn/7sOk5kRDnm4qJGhPrsdRytkVfjqoTIwwZwYBcneVav0hN0sC8hrlANym
         XgHoGwLutMM2NaYtypEcxq5i+8tOtjrh4Kx6eOH7Vcj8SEHScSFmJIm+XvqTMQHmHWIC
         UsLL6PUnKS71sVzxXXWfqLZmooMLcmYCVjnlxq2/PEvyNnjjXb9wm1xXrpRVszaPM4TI
         Zr/w==
X-Forwarded-Encrypted: i=1; AJvYcCWzqKuMxY46T9nOyVnryFVQAHcSnKNJjwZQez2ErzAbMV79Fr57IwNUUxWKbKn0mvFM/chGx+w65uhP3QMuICunsIbjjFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdsrcbpMcVeGxtMfdAPqbzft352+ngZYdlAXnlxAb5eFzalFwi
	peZ7xmaIssJ5mZtzFK7telT8dNVO+//+EdEeEUcqG7QfKCQRwVV9jBdT/k+07cbUXSDBf1jtlRu
	pYFdvzjTot+ey6i2YbNaenXDpKzJeeSiLIQZT
X-Gm-Gg: ASbGncsTXmXuWlpEZmR9//S4X6mNzu1Oh90PAY5X4tweqTCcmCLTeu7LooYFUMRQsf5
	LFQYyHNaTt4wKaX0t3N62r6qzjb7pmOUKapoVFiWE3IG4Hq0xMzFAhXre+D2M9oM7mw+IaVQvus
	H7RokJnjNIykAsbH8mtgVoiy1P0A==
X-Google-Smtp-Source: AGHT+IFhgDBVmWXOeUx6TUA58CI2V05fBEx4cashmyHcm9tr6dKV8HHQqh2yAD735f9jloo77ntcLNZlqEMFIu5HtQU=
X-Received: by 2002:a05:6902:1584:b0:e65:c4be:6faf with SMTP id
 3f1490d57ef6-e66a4debdb7mr6842789276.21.1742593432251; Fri, 21 Mar 2025
 14:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Mar 2025 17:43:41 -0400
X-Gm-Features: AQ5f1JpI85RWt_bAx7UPP82VU95uOW2DFn-bKsLOFnqGS9WmBCQebXEYShkzoyw
Message-ID: <CAHC9VhTb90OxDKUGPYKmQV6faPjdzkuqE5COnWzuub8Q4otZaw@mail.gmail.com>
Subject: Re: [RFC PATCH security-next 0/4] Introducing Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, nkapron@google.com, 
	teknoraver@meta.com, roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 12:45=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> This patch series introduces the Hornet LSM.
>
> Hornet takes a simple approach to light-skeleton-based eBPF signature
> verification. Signature data can be easily generated for the binary
> data that is generated via bpftool gen -L. This signature can be
> appended to a skeleton executable via scripts/sign-ebpf. Hornet checks
> the signature against a binary buffer containing the lskel
> instructions that the loader maps use. Maps are frozen to prevent
> TOCTOU bugs where a sufficiently privileged user could rewrite map
> data between the calls to BPF_PROG_LOAD and
> BPF_PROG_RUN. Additionally, both sparse-array-based and
> fd_array_cnt-based map fd arrays are supported for signature
> verification.
>
> Blaise Boscaccy (4):
>   security: Hornet LSM
>   hornet: Introduce sign-ebpf
>   hornet: Add an example lskel data extactor script
>   selftests/hornet: Add a selftest for the hornet LSM

Thanks Blaise, I noticed a few minor things, but nothing critical.  As
I understand it, you'll be presenting Hornet at LSFMMBPF next week?
Assuming that's the case, I'm going to hold off on reviewing this
until we hear how that went next week; please report back after the
conference.

However, to be clear, the Hornet LSM proposed here seems very
reasonable to me and I would have no conceptual objections to merging
it upstream.  Based on off-list discussions I believe there is a lot
of demand for something like this, and I believe many people will be
happy to have BPF signature verification in-tree.

--=20
paul-moore.com

