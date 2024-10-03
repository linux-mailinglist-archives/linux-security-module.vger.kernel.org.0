Return-Path: <linux-security-module+bounces-5828-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D4098E96A
	for <lists+linux-security-module@lfdr.de>; Thu,  3 Oct 2024 07:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0DD287EA1
	for <lists+linux-security-module@lfdr.de>; Thu,  3 Oct 2024 05:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741B653370;
	Thu,  3 Oct 2024 05:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="K8maQ7nD"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3659828F7;
	Thu,  3 Oct 2024 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727933738; cv=none; b=qYIBKgmO6a5VtVBwR/BEzaz6WgnkMGIwA2rNKi9TjS+WGyEcHWtVQL0g/w4Xui6otgknfgSLpNIjqL0OLdiDKe2lwqCLFj/OrSkfXaHGYZbgQA+tRUCXHCpE14GKfhPqM53doA0CvmrqRh9LQ1c9INWwY5puXHKgdOmkv5r8KtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727933738; c=relaxed/simple;
	bh=A8NMSn9dsoTl6nr/1aQYq6eREoyvXo5BiZDnAlPQqi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZw6sIwWtFkg08R+Hm/4WH0pBOwkmBIcoc6VURpQP1AUaY3g6bHYWyWWJ0Qige8VtUjIIAB3LFtYqzOD+YcFOZPStrcaAAMDm4TSzviMYse5XK+FVFJJ+8WCOSqBQEXcTlLxAN9gdpxk85nADJMtx3kVk2XFwjxnD5CPBRcnGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=K8maQ7nD; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7C97E3F045;
	Thu,  3 Oct 2024 05:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727933732;
	bh=/BmMQ0pCNtwwMeB+/v06idY0YwWHP6GJhwSJM6fGcNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=K8maQ7nDZi6gapo0Cpu7qzPLPKLKPWoqIPXUcq5Jmv0wiTm0KVmJj7B83cNdkatW+
	 gMc3QkG9R0zQGouuezqxicOf5C5OG2QZj/ImLtm9/U4Lq7SJS2t/HZUhUg4XRL/rSR
	 uzaYpuWUFXb2eFGrj3nyCqv9+8CqoWPsWzKIyRPPtKBQaQBsxNGhZLMhds5Oba41Il
	 wrP/LOM20ywSumwqfTlm7nPhhuaJo2rsR2SUq98T+5Eg76ABFjPD0+FbreIyDKIKXt
	 cL1Wowfk/SqPZutLVNEAfLfdEWv2G2TiWDqS4MuLOOMOAV//nJhty580yx2cs9Y6f+
	 XaNf8LAf2GlTg==
Message-ID: <393a1cd5-a212-4b04-9ff2-744772c21106@canonical.com>
Date: Wed, 2 Oct 2024 22:35:27 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net>
 <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <CAHC9VhS_8JtU0KQyy3rEGt0CQ_XMQFt2Kic-bz-Qd=SMjeWe4Q@mail.gmail.com>
 <19e29693-718c-4667-ab40-948718bcc6f5@I-love.SAKURA.ne.jp>
 <CAHC9VhT3yfahvwSVqGHyQq5SDpf8QRjDoEttoyD0zSau41Sb4Q@mail.gmail.com>
 <9387e6bb-484a-443d-ad87-24cf6e976e61@I-love.SAKURA.ne.jp>
 <2e182814-9317-4de1-ab96-b3b1eeb89733@canonical.com>
 <8114a37e-1306-47ee-b27e-a61c1c7bca94@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <8114a37e-1306-47ee-b27e-a61c1c7bca94@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 21:26, Tetsuo Handa wrote:
> On 2024/10/03 11:45, John Johansen wrote:
>>> But due to above-mentioned realities, your assertion no longer stands.
>>> Kernel source itself might be open, but private keys cannot be open.
>>> The vmlinux cannot be rebuilt without forcing penalties (i.e. having a
>>> negative impact on the user side, which cannot be a viable solution).
>>>
>>>
>> Yes, and this is an intentional choice on the base of the distro about
>> what they support and what is required to meet contractual obligations.
> 
> The reason Fedora cannot enable TOMOYO is lack of bandwidth.

which is sadly a very valid argument. Coming from the distro side of things
it is a very real problem. I tend to advocate for giving the user choice
where we can but there is more than one occasion where Ubuntu has had
to declare bug bankruptcy on outstanding kernel bugs because the backlog
was impossible to handle.

> You've just said "Bandwidth is a very real issue". Thus, I need a solution
> that can solve the bandwidth problem. The question is how we can control
> division of role (share the workload) in a secure manner.
> 
I do understand that. The problem is that out of tree doesn't do that.
 From a distro perspective out of tree is more work, and is very problematic
from a code signing perspective.

Code signing isn't going away, if anything its become a requirement to
support the majority of users. Loading unsigned modules, code, even
bpf is a problem.

Sure individual users can disable secure boot etc but at the distro
level we need to support secure boot out of the box. Out of tree code
really just isn't compatible with this.

>>
>> Users are still free to build their own kernels they just don't get
>> support or certification when using them.
> 
> Nobody can provide bandwidth (or infrastructure) for supporting their
> locally built kernels.
> 
right

>>                                            Stopping the load of out of
>> tree modules that aren't signed is in general good security policy.
> 
> Yes, distributors can prevent load of out-of-tree modules that aren't
> signed. That is good for security. But building kernels locally cannot
> utilize signed modules functionality. Also,
> 
true. that is a limitation of the cryptography that is being used, and
I don't see a way to fix that

>>
>> Let me be explicitly clear. If Tomoyo is by-passing module signing, and
>> exporting the LSM interface to loadable modules Ubuntu will be forced
>> to disable Tomoyo.
> 
> TOMOYO is one of in-tree modules that can be signed together when building
> distribution kernels. Fedora can provide tomoyo.ko as a signed-but-unsupported
> module (i.e. excluded from main kernel package that is supported by
> distributors but provided as a separate package that is not supported by
> distributors).
> 
yes it can, it has chosen not to. As I have said before that is
a choice/political reason, not technical. I wish I had a solution to this
problem for you but I don't. What I can say is Tomoyo adding the ability to
load out of tree code that isn't signed is going to force Ubuntu to do
the same and disable it. I really don't want to do that, I would rather
leave the choice available to our users.

It may be a trade-off worth making for you/Tomoyo if it fixed your
problem with RHEL/Fedora but I don't see it fixing that problem either.



