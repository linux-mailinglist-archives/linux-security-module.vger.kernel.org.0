Return-Path: <linux-security-module+bounces-13-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE67F3CF3
	for <lists+linux-security-module@lfdr.de>; Wed, 22 Nov 2023 05:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FD9281A89
	for <lists+linux-security-module@lfdr.de>; Wed, 22 Nov 2023 04:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB15BE6C
	for <lists+linux-security-module@lfdr.de>; Wed, 22 Nov 2023 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L1lLuSnN"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1523610C
	for <linux-security-module@vger.kernel.org>; Tue, 21 Nov 2023 20:27:51 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da41acaea52so5944644276.3
        for <linux-security-module@vger.kernel.org>; Tue, 21 Nov 2023 20:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700627270; x=1701232070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3GXc1MR1qci8KFPpbyRpmDJsF9XkUr/64nzsBhBKQE=;
        b=L1lLuSnN/rXgL/xRi7GNMF7e/HxZGDf8cECI2RIwQF1gxWKcS0ecUXVweIwLFoVq9/
         xMBkVu8m2EzanO1aHCg1+CrL1h5MHHuAbQVa6R10KtbT2wErPAx+Vk8cP8XdfjeW13RS
         Oek1cSeXWein5g1CGMzKpKw//pS17iNmPb7GoekPxYbX0fKsnEO2EEOGX7SMhoAPFJ9B
         nQbrNy1/S52QFuD71RfWu+ftK7y8gDRBiYLG53mEK7Pejwx/nMRTUTjlzL/vLtRSHZHz
         YpeBQdZ2Zt3vMiwcb5zt9EAi+zdl/hx7wAQTJvOCUQG0Wla4LQBzzYOXatdWWRGkmmNW
         acdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700627270; x=1701232070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3GXc1MR1qci8KFPpbyRpmDJsF9XkUr/64nzsBhBKQE=;
        b=BLR/+7cPqxpFv7cHvRURveYIb9GMh/nYxTWA1kKMPPWqShyv0dfO2yXsDdhzTYu1GU
         o/8hNUTswibPfzpdDVyDJ32SGPsv0nbGDl2JZLPE26VqrwIH3qvAhsVw8IJ4tw9eDhNW
         /MCGvavGMdzw+WL4KklSzh2kcbQzxC+S6axzwKRrNCjjqL5LB1QOvlRloUeks3WKZkoF
         26BYuZNpjoRePhytnKtBq0wZ/yDOwpJ13xrNmUtGBCXnJXjZNYltWVdUF5NlF4v7lA1U
         dymGybuI2JBbUFLrDlcLnkolR6Jy7jVlhdZi9xXzyPZ1uA0TbWoGEFotQTtfuZO7hM+S
         wEFg==
X-Gm-Message-State: AOJu0Yw/DpwEZn6eGoNkAH2HBDkhduVQLCpWPFsTONFKmJDxtpIloOqN
	UK1C1yUbOmYD0R1x7htlhHiT8ow45trrLgm7bpJjHIuw22cMq5s=
X-Google-Smtp-Source: AGHT+IHbPWhzmoLy5jBVhS69edGTEagGOf5fM/J56JWvF6UM7o6MptsbEEhZw/TOqOjK/u0Zb59RF3IgUo8M8Pa4T3U=
X-Received: by 2002:a25:186:0:b0:db3:5c00:ac28 with SMTP id
 128-20020a250186000000b00db35c00ac28mr1066663ybb.40.1700627270241; Tue, 21
 Nov 2023 20:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com> <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Nov 2023 23:27:39 -0500
Message-ID: <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, 
	Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com, 
	Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org, 
	serge@hallyn.com, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, 
	Tyler Hicks <tyhicks@linux.microsoft.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Sush Shringarputale <sushring@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 5:28=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Oct 31, 2023 at 3:15=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> =
wrote:

...

> > Userspace can already export the IMA measurement list(s) via the
> > securityfs {ascii,binary}_runtime_measurements file(s) and do whatever
> > it wants with it.  All that is missing in the kernel is the ability to
> > trim the measurement list, which doesn't seem all that complicated.
>
> From my perspective what has been presented is basically just trimming
> the in-memory measurement log, the additional complexity (which really
> doesn't look that bad IMO) is there to ensure robustness in the face
> of an unreliable userspace (processes die, get killed, etc.) and to
> establish a new, transitive root of trust in the newly trimmed
> in-memory log.
>
> I suppose one could simplify things greatly by having a design where
> userspace  captures the measurement log and then writes the number of
> measurement records to trim from the start of the measurement log to a
> sysfs file and the kernel acts on that.  You could do this with, or
> without, the snapshot_aggregate entry concept; in fact that could be
> something that was controlled by userspace, e.g. write the number of
> lines and a flag to indicate if a snapshot_aggregate was desired to
> the sysfs file.  I can't say I've thought it all the way through to
> make sure there are no gotchas, but I'm guessing that is about as
> simple as one can get.
>
> If there is something else you had in mind, Mimi, please share the
> details.  This is a very real problem we are facing and we want to
> work to get a solution upstream.

Any thoughts on this Mimi?  We have a real interest in working with
you to solve this problem upstream, but we need more detailed feedback
than "too complicated".  If you don't like the solutions presented
thus far, what type of solution would you like to see?

--=20
paul-moore.com

