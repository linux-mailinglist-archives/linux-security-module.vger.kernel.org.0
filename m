Return-Path: <linux-security-module+bounces-12537-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF7DC0811F
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Oct 2025 22:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E4E19A2375
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Oct 2025 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558662F531A;
	Fri, 24 Oct 2025 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hv0CJmW+"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0338E2F5339
	for <linux-security-module@vger.kernel.org>; Fri, 24 Oct 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337893; cv=none; b=AB99uke++fRVhc4XqK2ht55bmO4abBp5A4ypqdmpLsv9+ubxisMrH2/YzFCcUM4HR1gS0RKLA3RQMIpS+bi+/LxDdYc+d+WyUqIV08poSGJvBG8/YTDqqCLxWMDZDWW8Mt8JhajxJpuk1eCHamuBucKPMYLUHcvrnuXBrRxIMEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337893; c=relaxed/simple;
	bh=YLsDVmBRFUzk4uFHLNXj50aYnzyO7d5mx0WZXJ2eLJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMIAPomDZ81+JC/erakP+0aoMyEOe/Sh/0CxNkf3rdELwnjlA1CjGMjnRbwMzmtQ38dR4RkbS6g78pCZrETPeKsAUhdDQ7jvUT/ezv3e67wPGX1hNHJaNSh5zYzJjpin09EVoTIRY2EFwDCnQEp9BbxeL8LnCuHrlbmzfyxp260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hv0CJmW+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e9d633b78so520183066b.1
        for <linux-security-module@vger.kernel.org>; Fri, 24 Oct 2025 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761337889; x=1761942689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BFuzQTMQA5rTZOkoXKW3L8u+HJJavRaRvHnpTIXo3kA=;
        b=hv0CJmW++3eKf3G9Q/2DIKKT9njJRsLOp3vI4RnVQlRXR2IM/VUgTPFH98NCEzaVVD
         pATzOaCw6ZZFoX9esHfYlbLMpA6CXBeYFRn7WHMOlx8yJ5OTj4NMTWMW3bz5viKGX5mV
         KVrelyju+qY2/rlE408i/1niTzoYocyWQev5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761337889; x=1761942689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFuzQTMQA5rTZOkoXKW3L8u+HJJavRaRvHnpTIXo3kA=;
        b=snhy/O6HwwvurbSko9MU600SOxPJEVzv6QkM8iJ8PWknW1UjeyMv/Kamqy4YHwBPyo
         kkUiAdc7H/eY8KhxdDi5l8LtB4EszQvhQP+v9WWwul49042EdreegU8xkUlpEt+VEK9a
         vNQperVcQurSR4W1+g3rcbTRTY8fVzfMTHgp201CpLubFOF7oKhEGtX4CFfzUQN5XHr0
         b0vlfAT5arKLvakR/6MSbS8WZbWbUz8zH3rSTqLOTpWbKTsQARai5TlybLtSA6U5tyoZ
         2tIfpdDYYhb/jaXpAfmDdUBpvbUdV8Rqmc06wlBsDJ6RbtKHRy/rY8RmWgx1rmGEiVxM
         fY0A==
X-Forwarded-Encrypted: i=1; AJvYcCVoqvC3Os94I/cIBCs7qE+pdQSli/bOPxSYC/326ZI2LLJaepVH5q5pp+q0wmSMXKRk8YkrIyx4l+PfahH/0F+u34dWV60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMMCpgZcF8d5yepMHxsGsG4nAOrZ4YfSI0evu2yi9Qz3b+CEP
	q5ynayf/85Pph+DERRZxroE2LhDXqtz0mXj0SR8Gy4kI5v/m3Cc50jb0rO3FdVEM8nsJ2lL0TxU
	ICUpek5M=
X-Gm-Gg: ASbGncut+UUU+q0S8hus+f1tju6a/raI9C7VDgzczlKB46vjgL2XHUN9LBVAm4ZftDF
	RmvHPyjfqWgBbf/L49XLSi/Hn27ircN8KogupT9w3lbt4IELlnEkPCEJSxL8F0gYM5VzXZINOhY
	c1wYITPzbaBGq2K1jv64B7/6GYaaRK7hyi0xfsRfsIBm2aPZnzsRtA8B9lchDykDCFV9f3JNJvi
	/dTG7bZwS4vuLcS/xXQgHAUwupvf6msdhyVGe2j71P5mFttbeSyfcAtDPIReT0tN1SiCilAIVph
	keCT52eSj/IRdbfh4Np09pZXXBHSPGjlcBbUPNJWmV5Gaego5nCTJ2ZZnx1Z9G3/sN/rPZgQhYQ
	mTFOlfBCJmPWaZpCKV3X6qOOC4LGD9hmPSC23/N7D2ieLOV51yo2f35FL0XM3lYw8A+kUxSV7EG
	NE+KcsyJy7aJ9+vTMl9dC9oe67Z8tSZi7H2hnXmaIGe3TiPxt897qx9HLS9MmN
X-Google-Smtp-Source: AGHT+IGH/EN/oIcIHXZ06nLRFlVJx2sjZ6lcbgHt+sm7kE4fjlk5T//pKWgFdrVacbcbypF5COfE5A==
X-Received: by 2002:a17:907:1c85:b0:b6d:263c:22e1 with SMTP id a640c23a62f3a-b6d6be49f8dmr455551866b.31.1761337888900;
        Fri, 24 Oct 2025 13:31:28 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548eda6sm10258166b.75.2025.10.24.13.31.27
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 13:31:27 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso6873887a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 24 Oct 2025 13:31:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7PS8+VdSwlrzPk8Is9/Lj0tE5Qa8oZ7qKhnLtbR8v9v/cVSTaL4OsLqqC8CtgYUL7zmMRV+r2z9lOO0QgIRzevoJtiY4=@vger.kernel.org
X-Received: by 2002:a05:6402:3511:b0:63b:ec3c:ee32 with SMTP id
 4fb4d7f45d1cf-63e5eb18f2dmr3477528a12.11.1761337887233; Fri, 24 Oct 2025
 13:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
In-Reply-To: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Oct 2025 13:31:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com>
X-Gm-Features: AWmQ_bk4uIZgtxqK_hz679cw5uXq-Z_oOrdasW-TDydWDYZqpoDShTeWLYqsq6s
Message-ID: <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.18-rc3
To: Jens Axboe <axboe@kernel.dk>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

[ Adding LSM people. Also Christian, because he did the cred refcount
cleanup with override_creds() and friends last year, and I'm
suggesting taking that one step further ]

On Fri, 24 Oct 2025 at 06:58, Jens Axboe <axboe@kernel.dk> wrote:
>
> Ondrej Mosnacek (1):
>       nbd: override creds to kernel when calling sock_{send,recv}msg()

I've pulled this, but looking at the patch, I note that more than half
the patch - 75% to be exact - is just boilerplate for "I need to
allocate the kernel cred and deal with error handling there".

It literally has three lines of new actual useful code (two statements
and one local variable declaration), and then nine lines of the "setup
dance".

Which isn't wrong, but when the infrastructure boilerplate is three
times more than the actual code, it makes me think we should maybe
just get rid of the

    my_kernel_cred = prepare_kernel_cred(&init_task);

pattern for this use-case, and just let people use "init_cred"
directly for things like this.

Because that's essentially what that prepare_kernel_cred() thing
returns, except it allocates a new copy of said thing, so now you have
error handling and you have to free it after-the-fact.

And I'm not seeing that the extra error handling and freeing dance
actually buys us anything at all.

Now, some *other* users actually go on to change the creds: they want
that prepare_kernel_cred() dance because they then actually do
something else like using their own keyring or whatever (eg the NFS
idmap code or some other filesystem stuff).

So it's not like prepare_kernel_cred() is wrong, but in this kind of
case where people just go "I'm a driver with hardware access, I want
to do something with kernel privileges not user privileges", it
actually seems counterproductive to have extra code just to complicate
things.

Now, my gut feel is that if we just let people use 'init_cred'
directly, we should also make sure that it's always exposed as a
'const struct cred' , but wouldn't that be a whole lot simpler and
more straightforward?

This is *not* the only use case of that.

We now have at least four use-cases of this "raw kernel cred" pattern:
core-dumping over unix domain socket, nbd, firmware loading and SCSI
target all do this exact thing as far as I can tell.

So  they all just want that bare kernel cred, and this interface then
forces it to do extra work instead of just doing

        old_cred = override_creds(&init_cred);
        ...
        revert_creds(old_cred);

and it ends up being extra code for allocating and freeing that copy
of a cred that we already *had* and could just have used directly.

I did just check that making 'init_cred' be const

  --- a/include/linux/init_task.h
  +++ b/include/linux/init_task.h
  @@ -28 +28 @@ extern struct nsproxy init_nsproxy;
  -extern struct cred init_cred;
  +extern const struct cred init_cred;
  --- a/kernel/cred.c
  +++ b/kernel/cred.c
  @@ -44 +44 @@ static struct group_info init_groups = { .usage =
REFCOUNT_INIT(2) };
  -struct cred init_cred = {
  +const struct cred init_cred = {

seems to build just fine and would seem to be the right thing to do
even if we *don't* expect people to use it. And override_creds() is
perfectly happy with a

Maybe there's some reason for that extra work that I'm not seeing and
thinking of? But it all smells like make-believe work to me that
probably has a historical reason for it, but doesn't seem to make a
lot of sense any more.

Hmm?

               Linus

