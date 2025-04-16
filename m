Return-Path: <linux-security-module+bounces-9338-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B6A88819
	for <lists+linux-security-module@lfdr.de>; Mon, 14 Apr 2025 18:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C33418993A5
	for <lists+linux-security-module@lfdr.de>; Mon, 14 Apr 2025 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF2288C89;
	Mon, 14 Apr 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mumwvm/8"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00428B4E9
	for <linux-security-module@vger.kernel.org>; Mon, 14 Apr 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646903; cv=none; b=PaB/vBniUwRpvojrtqYj9E9sCKHpxCXutLeBMcGpDhkX9AgHu1Mx4oWOsYKFtvjM9HzVXNmgwDwQfPGsInFmC8SEh5ifiQWqKBi3KLcFQ3sJ4geHjb5LovMg2v974AphQ5DwHc+9k7x3R6x/HPc1ctN/tvkxCIhSsxlCBNqSvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646903; c=relaxed/simple;
	bh=UM2X1MMDXZM7fTOBoaVl4irheKjkJEoFW6yGloSDkIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HToY/QT4S/KL7rGsX45glm0yWLxSWA78saduVrrfBpSdfGMb/BsQ3aB090fVMuFUff7umhxsBE7+xzaAES0w8MrKI8QHQmDpQkkx9czX9xSR0qzfxOZB/ErgywA2vDha67pWSxuGdzFbukbDqBL0TsyKkE9WSUO01FvssW+cOhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Mumwvm/8; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e637edaa652so3393492276.1
        for <linux-security-module@vger.kernel.org>; Mon, 14 Apr 2025 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744646900; x=1745251700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL3vhJ/AOwi9smEiZpaLEqVlOaMdXAZ9MQuarYjoWe8=;
        b=Mumwvm/8Y5rtsz0IvKUFkpE8ruDsmgBOjoUBw6i35+BbgBlhTboR4WV1z9gUU1ywLH
         If2Yai0i6Q6qV8vm/ZQQZL0v9dYK03JXD0IhGFtp9mbK19ZLCDLnhXw/Uf/vH2kQ+taV
         z3gj/9kyjkXNnsJWvBnbscoWFRL03Ll5QTZUTC2l+vzaVamEWnHzXlRUPZ/Nr5Bu7ppt
         P307C8L/eQjyp29jdZkkMH6TcWCd6a8kcUjlFLyfvoFFuv0+9y0c+K0ho2d945G7mDRV
         TST1aqnUXcHWpERl3ZCxsaVHdRAEe7WupgH9tpJDTMG1CJbCaOFvsU20YqAQ3wwsSnh1
         TXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744646900; x=1745251700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CL3vhJ/AOwi9smEiZpaLEqVlOaMdXAZ9MQuarYjoWe8=;
        b=cv3cz1fciy446GkMe277az629mLnJJVkvC2bCmA162AtuPluoIOxoxk3e8PP5Libxq
         WiBSTNY2XLNJ8ZO74rvAs7Ey2MEggT7LdFV98Npe4WK51qXmiuUa7b2F70C0K890g2Uz
         O+ItH0cx8hBf+XI/1P9m/MDAjXQ2yk+t0XFnNKElyW4NTYR9yNyE9p+ujc8KyPSW5JWH
         baoaleIcULS/CEELw7gdOtpN5KUV6o/cH+7ZkdNjCbDc4qywTJBQt9GNc3rrc6YbvK09
         4JV/7izv9Zmw/cIewONMwje/4qfH16kBt4B6ASzFymizyAPOoTQAjKw+YvsGfh7t1qY9
         VSvw==
X-Forwarded-Encrypted: i=1; AJvYcCXSOpK6rhg13FW7MNWkge2gLfKqexA5Qi5h5HoPMuBEumE74PDKv0Ylu71orMHsRs2XZsOzRyXcBe805wv82Y4fyPfF3OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1w9J5x0x+xwdSPoKoHKvmXokppMtNeV+9dXgphureP5DM5/KE
	tHHnqd8+D4LOpSTp0dm567hruyEwQqVSoRKlDI5QUlvH59ICdN0+ZorEt6w/DWHFSU2FzshYUuf
	TvJTa8OY863SjxbVRV4zMxvKngqLkMwnzy4Tt
X-Gm-Gg: ASbGnct398+ElDdfocLf9F1ujIEmB/qirpZ/zc6pRI60/A3LyE2d0bXQcVy84eoaFRu
	EUmpcNDX2qqRsXHKiowVAeeK81qzjqfihTXIh4GqL4X9OjdcN42wdfKfL378r1CXg7ooVX50OH5
	+BP8pRA3lCIdJXN2OhucliaQ==
X-Google-Smtp-Source: AGHT+IEIR0Yjon2HOlR6cN2sFBuht845hyAi0y0g8G/WBIBmJsXWf+CNllSW2DnKB64zYskb2VqpvQmI+s8gSsNUMNs=
X-Received: by 2002:a05:6902:2086:b0:e6d:e3f8:5167 with SMTP id
 3f1490d57ef6-e704e00541cmr21022948276.39.1744646899625; Mon, 14 Apr 2025
 09:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com> <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <87semdjxcp.fsf@microsoft.com>
In-Reply-To: <87semdjxcp.fsf@microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Apr 2025 12:08:08 -0400
X-Gm-Features: ATxdqUE4xsXRFht60hSZa09A9jxdssSnYGr-dDs5eKOQiFPM4gPTEA6FMREhjdE
Message-ID: <CAHC9VhQ-Zs56LG9D-9Xs14Au-ub8aR4W+THDJfEsza_54CJf-Q@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, nkapron@google.com, 
	Matteo Croce <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 9:58=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> > On Fri, Apr 4, 2025 at 2:56=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:

...

> > Above are serious layering violations.
> > LSMs should not be looking that deep into bpf instructions.
>
> These aren't BPF internals; this is data passed in from
> userspace. Inspecting userspace function inputs is definitely within the
> purview of an LSM.
>
> Lskel signature verification doesn't actually need a full disassembly,
> but it does need all the maps used by the lskel. Due to API design
> choices, this unfortunately requires disassembling the program to see
> which array indexes are being used.
>
> > Calling into sys_bpf from LSM is plain nack.
> >
>
> kern_sys_bpf is an EXPORT_SYMBOL, which means that it should be callable
> from a module. Lskels without frozen maps are vulnerable to a TOCTOU
> attack from a sufficiently privileged user. Lskels currently pass
> unfrozen maps into the kernel, and there is nothing stopping someone
> from modifying them between BPF_PROG_LOAD and BPF_PROG_RUN.

I agree with Blaise on both the issue of iterating through the eBPF
program as well as calling into EXPORT_SYMBOL'd functions; I see no
reason why these things couldn't be used in a LSM.  These are both
"public" interfaces; reading/iterating through the eBPF instructions
falls under a "don't break userspace" API, and EXPORT_SYMBOL is
essentially public by definition.

It is a bit odd that the eBPF code is creating an exported symbol and
not providing a declaration in a kernel wide header file, but that's a
different issue.

> > The verification of module signatures is a job of the module loading pr=
ocess.
> > The same thing should be done by the bpf system.
> > The signature needs to be passed into sys_bpf syscall
> > as a part of BPF_PROG_LOAD command.
> > It probably should be two new fields in union bpf_attr
> > (signature and length),
> > and the whole thing should be processed as part of the loading
> > with human readable error reported back through the verifier log
> > in case of signature mismatch, etc.
> >
>
> I don't necessarily disagree, but my main concern with this is that
> previous code signing patchsets seem to get gaslit or have the goalposts
> moved until they die or are abandoned.

My understanding from the previous threads is that the recommendation
from the BPF devs was that anyone wanting to implement BPF program
signature validation at load time should implement a LSM that
leverages a light skeleton based loading mechanism and implement a
gatekeeper which would authorize BPF program loading based on
signatures.  From what I can see that is exactly what Blaise has done
with Hornet.  While Hornet is implemented in C, that alone should not
be reason for rejection; from the perspective of the overall LSM
framework, we don't accept or reject individual LSMs based on their
source language, we have both BPF and C based LSMs today, and we've
been working with the Rust folks to ensure we have the right things in
place to support Rust in the future.  If your response to Hornet is
that it isn't acceptable because it is written in C and not BPF, you
need to know that such a response isn't an acceptable objection.

> Are you saying that at this point, you would be amenable to an in-tree
> set of patches that enforce signature verification of lskels during
> BPF_PROG_LOAD that live in syscall.c, without adding extra non-code
> signing requirements like attachment point verification, completely
> eBPF-based solutions, or rich eBPF-based program run-time policy
> enforcement?

I worry that we are now circling back to the original idea of doing
BPF program signature validation in the BPF subsystem itself.  To be
clear, I think that would be okay, if not ultimately preferable, but I
think we've all seen this attempted numerous times in the past and it
has been delayed, dismissed in favor of alternatives, or simply
rejected for one reason or another.  If there is a clearly defined
path forward for validation of signatures on BPF programs within the
context of the BPF subsystem that doesn't require a trusted userspace
loader/library/etc. that is one thing, but I don't believe we
currently have that, despite user/dev requests for such a feature
stretching out over several years.

I believe there are a few questions/issues that have been identified
in Hornet's latest round of reviews which may take Blaise a few days
(week?) to address; if the BPF devs haven't provided a proposal in
which one could acceptably implement in-kernel BPF signature
validation by that time, I see no reason why development and review of
Hornet shouldn't continue into a v3 revision.

--=20
paul-moore.com

