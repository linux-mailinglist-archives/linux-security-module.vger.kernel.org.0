Return-Path: <linux-security-module+bounces-4306-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A73932107
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Jul 2024 09:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32869B21F30
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Jul 2024 07:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7A422309;
	Tue, 16 Jul 2024 07:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kT1s73ju"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBE137143
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2024 07:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114039; cv=none; b=o6Qwa0mvcV4PnURbODG8tVfSnQxZphnDoBN4oUIZTOdDsefIsmYKcF7rB1XpKX38vXvg/tUtKujnDEGGW7JKPY5xNdJeARRJqlsxOdIgSedFs5tCL8xwyV0LV2C+o8MjAk3QwhIOG+KZEPd3nZZEpS2AnX/W+lc9UkSq8eyiWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114039; c=relaxed/simple;
	bh=om5UofC4ryHM94Wlsk4/cAWNj8IrCD8xKsDi+0pvYEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGo4BVwiKMc/mF6Vum6416HYWp+LRyq3bXwkuHT71NcffPmJ9exByLrnP6cGQu5JBJLxjCOaz7wyZqaxnqtkAbnsKYDhwfCD/rlg6yRb8jyR3lLLg4Xv5r3r7dD0N8jpUj/wHW1DmL4EmQZvgCnVBrJLzznPG3VHMEAJ736Ysvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kT1s73ju; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WNVfn1WqqzlGb;
	Tue, 16 Jul 2024 09:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721114033;
	bh=Pgvv7MQ5tPNIpIpwnO7JzPSqhpV+bSm8Xa4gUvwKzv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kT1s73ju4LMuNR9iv/HUc1o8CwZJ5xCxOz/+egyw3P7sbZeW2jRv16p+ElhwyUtEA
	 zvYnMjKHWvc/qG6EqgzzBjF8lkQqacaFr+P3FuSQ58elSfbJjsGYZnsmUg1ZWS8FKD
	 1oJ6pWXDMHcM7ab84mB83LrO7VC6Cvd3MjkJ0lkk=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WNVff3KMVzQHl;
	Tue, 16 Jul 2024 09:13:46 +0200 (CEST)
Date: Tue, 16 Jul 2024 09:13:44 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 0/5] Script execution control (was O_MAYEXEC)
Message-ID: <20240716.bebeeX1aequi@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <8734oawguu.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734oawguu.fsf@trenco.lwn.net>
X-Infomaniak-Routing: alpha

On Mon, Jul 15, 2024 at 02:16:41PM -0600, Jonathan Corbet wrote:
> Mickaël Salaün <mic@digikod.net> writes:
> 
> FYI:
> 
> > User space patches can be found here:
> > https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
> 
> That link appears to be broken.

Unfortunately, GitHub's code search links only work with an account.
git grep prints a similar output though.

> 
> Thanks,
> 
> jon

