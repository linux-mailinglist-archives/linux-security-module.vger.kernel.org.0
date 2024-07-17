Return-Path: <linux-security-module+bounces-4351-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC83E93421A
	for <lists+linux-security-module@lfdr.de>; Wed, 17 Jul 2024 20:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D70F1F22B58
	for <lists+linux-security-module@lfdr.de>; Wed, 17 Jul 2024 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A7D1DA5E;
	Wed, 17 Jul 2024 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E3o+CiEZ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8CE12E75
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jul 2024 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240238; cv=none; b=G9+Sq7YF+5PfrOFYlli/KLuICxIqLLNwT+0ypQXyrd2ZuSZ86x6ItnxeX3ueTyy7cnq8T00NPygYiHLLynzzaqU+ugn60WRzzOw83hBaz+VmnFf2cwb/CgiaQ8y3UUGJmOTec/hqwgi1aLEcKcFbhAHHaSxneOFbDCBj0GmsY7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240238; c=relaxed/simple;
	bh=plI9VQ8PNkZ0Z7s2DW8Xc/jOMVJgY+/ameGpL8Yn5Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWc19JPUVmdm8/EAbDkkkiYwFCmDZRZpWGif8pvjfjevGn4lfUOHMF6z9SjqMxXQkGVLIPH9IIf2HH+wEeHy0A4qMNg10ByOX9663p+ogfZ/kRs9qGe2LHppxjXjysZXUKwopbM1lsX8jnqa9H+I7nXjhFlJmnB7bWj4tJMTchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E3o+CiEZ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eec7e43229so47811fa.3
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jul 2024 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721240234; x=1721845034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bgdx7vvSTCDmReVymeTt0yzw+JJTtSiE4bn5RhejZQg=;
        b=E3o+CiEZoLi7JCeAKmJQj9uC7Ws40jxFyfUx7SyQY6wBWmT78xoygh+51UEKOqL/fE
         JYA82iJ1Bj+Gp3IG31OVY/Y5TsL6gg550Q5iMckl1oaCYTUNcdjORSFFu60x8XXXb9EC
         TjudTpYazFppQHYH6IbYZD82BPsaa5xaabLFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721240234; x=1721845034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgdx7vvSTCDmReVymeTt0yzw+JJTtSiE4bn5RhejZQg=;
        b=CdpF76s+1exjvnI76Qb93XZKdiUfQAazODwEDRSKkjGy5b2Mqazq+oBxTJ2rMzG1uL
         i8rV5pLM7/T/CPCs8TDo5VQ84l+kvMXf7E0dzpr9Png3ZmJgbk6YpH2Bn3/aVzkcnGfu
         hL1/GBo9Bny2af7ht2cAsA3WjaoMQYIswOMeu3V+WCP+s0AFJ8NNBV5p7yjMMNM79R0Q
         8iKtINbnDqZpS+BqpSYO0eNQEl81euuinKRoOQRh1egZTmSMx0s+KS7/RdNxJFnDARqD
         pCvZOH2EaLews1Dh/8Ngd9X8X0Tgg8XUBN5MZix8K4mjtB9h6+1wuEHPpZeyNRaiGMg7
         5N5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXw8PdOPGTjU90XiJf3C8RWBfwHMBhB+/HJxNLmUwJIZhBWqU0y25alwxMKDNqKepyK82UFt7K8LrfPIaQ9YB4byF2T7NAOdGBL9PEFkyRlREAW8Fr8
X-Gm-Message-State: AOJu0YyEXHGmB4S6bbpmaR9ixG5wA8So0qVc7Bp4PFGX4Jk4RbM0MX0h
	cSxEi5uScBsQS/3CIYBvbzZXzcL+iXGJaqJrEDlat1uwy3TTCI+DMaB7tIXzI77s9+JdQaut0m7
	VKI1Asw==
X-Google-Smtp-Source: AGHT+IGfpFRHt2r1j2y21NAifwhzeO/TScpfWGGdnn6zk2L+t9SP110V5+cRd6oRPOGU1JVlzhj3nw==
X-Received: by 2002:a05:651c:1548:b0:2ec:7300:d02f with SMTP id 38308e7fff4ca-2ef05d452b6mr1365601fa.49.1721240234368;
        Wed, 17 Jul 2024 11:17:14 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef05d6eee0sm155991fa.98.2024.07.17.11.17.13
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 11:17:13 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eec7e43229so47331fa.3
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jul 2024 11:17:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpvmIEtDfIM2p9u34m/TI62oKFvwYCNP6bB+1uuPfeYzmr7iZIQadezaQnk5TBKXz9YUpY2o1rLPpQtjDNadp6sY87IyEbxC0tWjOAsymrWosLsb1i
X-Received: by 2002:a2e:9b12:0:b0:2ee:7b7d:66ed with SMTP id
 38308e7fff4ca-2ef05c52bbamr1815371fa.10.1721240232921; Wed, 17 Jul 2024
 11:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717111358.415712-1-adrian.ratiu@collabora.com> <202407171017.A0930117@keescook>
In-Reply-To: <202407171017.A0930117@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 11:16:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3m98GCv-kXJqRvsjOa+DCFqQux7pcmJW9WR8_n=QPqg@mail.gmail.com>
Message-ID: <CAHk-=wi3m98GCv-kXJqRvsjOa+DCFqQux7pcmJW9WR8_n=QPqg@mail.gmail.com>
Subject: Re: [PATCH] proc: add config to block FOLL_FORCE in mem writes
To: Kees Cook <kees@kernel.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel@collabora.com, gbiv@google.com, 
	inglorion@google.com, ajordanr@google.com, 
	Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a8f0be061d757832"

--000000000000a8f0be061d757832
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 10:23, Kees Cook <kees@kernel.org> wrote:
>
> For this to be available for general distros, I still want to have a
> bootparam to control this, otherwise this mitigation will never see much
> testing as most kernel deployments don't build their own kernels. A
> simple __ro_after_init variable can be used.

Oh, btw, I looked at the FOLL_FORCE back in 2017 when we did this:

    8ee74a91ac30 ("proc: try to remove use of FOLL_FORCE entirely")

and then we had to undo that with

    f511c0b17b08 (""Yes, people use FOLL_FORCE ;)"")

but at the time I also had an experimental patch that worked for me,
but I seem to have only sent that out in private to the people
involved with the original issue.

And then that whole discussion petered out, and nothing happened.

But maybe we can try again.

In particular, while people piped up about other uses (see the quotes
in that commit f511c0b17b08) they were fairly rare and specialized.

The one *common* use was gdb.

But my old diff from years ago mostly still applies, so I resurrected it.

It basically restricts FOLL_FORCE to just ptracers.

That's *not* good for some of the people that piped up back when (eg
Julia JIT), but it might be a more palatable halfway state.

In particular, this patch would make it easy to make that
SECURITY_PROC_MEM_RESTRICT_FOLL_FORCE config option be a "choice"
where you pick "never, ptrace, always" by just changing the rules in
proc_is_ptracing().

I guess that function should be renamed too, I only did a minimal
"forward-port an old patch" thing.

               Linus

--000000000000a8f0be061d757832
Content-Type: text/x-patch; charset="US-ASCII"; name="foll_force.patch"
Content-Disposition: attachment; filename="foll_force.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lyq5yyfz0>
X-Attachment-Id: f_lyq5yyfz0

IGZzL3Byb2MvYmFzZS5jIHwgMTYgKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9wcm9jL2Jhc2Uu
YyBiL2ZzL3Byb2MvYmFzZS5jCmluZGV4IDcyYTFhY2QwMzY3NS4uMWI2NDZjYjk2NTA5IDEwMDY0
NAotLS0gYS9mcy9wcm9jL2Jhc2UuYworKysgYi9mcy9wcm9jL2Jhc2UuYwpAQCAtODM1LDYgKzgz
NSwxOCBAQCBzdGF0aWMgaW50IG1lbV9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBm
aWxlICpmaWxlKQogCXJldHVybiByZXQ7CiB9CiAKK3N0YXRpYyBib29sIHByb2NfaXNfcHRyYWNp
bmcoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQoreworCWJvb2wgcHRy
YWNlX2FjdGl2ZSA9IGZhbHNlOworCXN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzayA9IGdldF9wcm9j
X3Rhc2soZmlsZV9pbm9kZShmaWxlKSk7CisKKwlpZiAodGFzaykgeworCQlwdHJhY2VfYWN0aXZl
ID0gdGFzay0+cHRyYWNlICYmIHRhc2stPm1tID09IG1tICYmIHRhc2stPnBhcmVudCA9PSBjdXJy
ZW50OworCQlwdXRfdGFza19zdHJ1Y3QodGFzayk7CisJfQorCXJldHVybiBwdHJhY2VfYWN0aXZl
OworfQorCiBzdGF0aWMgc3NpemVfdCBtZW1fcncoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191
c2VyICpidWYsCiAJCQlzaXplX3QgY291bnQsIGxvZmZfdCAqcHBvcywgaW50IHdyaXRlKQogewpA
QCAtODU1LDcgKzg2Nyw5IEBAIHN0YXRpYyBzc2l6ZV90IG1lbV9ydyhzdHJ1Y3QgZmlsZSAqZmls
ZSwgY2hhciBfX3VzZXIgKmJ1ZiwKIAlpZiAoIW1tZ2V0X25vdF96ZXJvKG1tKSkKIAkJZ290byBm
cmVlOwogCi0JZmxhZ3MgPSBGT0xMX0ZPUkNFIHwgKHdyaXRlID8gRk9MTF9XUklURSA6IDApOwor
CWZsYWdzID0gd3JpdGUgPyBGT0xMX1dSSVRFIDogMDsKKwlpZiAocHJvY19pc19wdHJhY2luZyhm
aWxlLCBtbSkpCisJCWZsYWdzIHw9IEZPTExfRk9SQ0U7CiAKIAl3aGlsZSAoY291bnQgPiAwKSB7
CiAJCXNpemVfdCB0aGlzX2xlbiA9IG1pbl90KHNpemVfdCwgY291bnQsIFBBR0VfU0laRSk7Cg==
--000000000000a8f0be061d757832--

