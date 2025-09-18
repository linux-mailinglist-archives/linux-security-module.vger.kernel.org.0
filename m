Return-Path: <linux-security-module+bounces-11578-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED45AB35F2B
	for <lists+linux-security-module@lfdr.de>; Tue, 26 Aug 2025 14:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533CE462A41
	for <lists+linux-security-module@lfdr.de>; Tue, 26 Aug 2025 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58389334379;
	Tue, 26 Aug 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="b8GII4CJ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FD2C0267
	for <linux-security-module@vger.kernel.org>; Tue, 26 Aug 2025 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211689; cv=none; b=Kwy93bFRVSX1mvF2YPy7P/00Z83h1ibWm7xmNNP6OxbY/AVw/JSIZ5Z8Dr2qPtT2wcLt+KMcc3Bm+U8tfzCKL7BnlB+zSSHzND2KX9/usGAwJ5iwnLLVHA1OyDaYdjK8H5TC0SyuOf4m24JAgVNWQFjyAmIaNvXWsdhmHiYjjYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211689; c=relaxed/simple;
	bh=g+z3yZRdrZRLtObGahP3SKkF1sXUGzV9b4ohegycO9k=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=Iuzx0CpEE5SQ1U+oE1hUjMaHaXYiYp7hYP852D0dsYpPJk+gDk9HT+y0t6dYbN4zTFnQWj8FJmmy64+9aH2eGcK+i+pv5avel1zQErl4cgLx7rsTFYxXPVh0bKZ7dWe8ZiSIxPnfAGcp6CInzVpGpTUma1Ni1WmpvnqxB1xARiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=b8GII4CJ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-119-77.bstnma.fios.verizon.net [173.48.119.77])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57QCUf2V005662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 08:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1756211450; bh=gfBKabosxEFtok1jhLkwvxbr40tlm8siH8D4p2Cx5vc=;
	h=Date:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=b8GII4CJJPfrDPxvB9Xkdi0sqO33xqyhjhyC9qdBJqJW/dCH804qFrwyFAxn2OZBY
	 Hx/Gz6dSA7W9aVjxxpye9lOfRVq+7gssepbPckc+6tJjKM5KeOZQzwY+wTIqX10xlT
	 zPaBEdKd/kyFu0yacX3gXr8Gitguh87mEfx6yREqi0uWNtZGKzQMYh0JQvKO0hhDTi
	 vSyM573nYo5yqDMnBnY8yy6iD+vznX9EIEcSlWJZcS91rCIV6aSvMj0QmEAvxhPg7b
	 qtKT3t8q4RGh99UggPBiE028v3jpn+rrQCTJPH9tGBzx+zJqqJpXlHQg1DdLH2fI+D
	 IG3e2BChNa9AQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 73FBB2E00D6; Tue, 26 Aug 2025 08:30:41 -0400 (EDT)
Date: Tue, 26 Aug 2025 08:30:41 -0400
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
        Serge Hallyn <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Heimes <christian@python.org>,
        Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>,
        Fan Wu <wufan@linux.microsoft.com>,
        Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>,
        Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Jordan R Abrahams <ajordanr@google.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Luca Boccassi <bluca@debian.org>,
        Matt Bobrowski <mattbobrowski@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Robert Waite <rowait@microsoft.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Scott Shell <scottsh@microsoft.com>,
        Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
Message-ID: <20250826123041.GB1603531@mit.edu>
References: <20250822170800.2116980-1-mic@digikod.net>
 <20250826-skorpion-magma-141496988fdc@brauner>
 <20250826.aig5aiShunga@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826.aig5aiShunga@digikod.net>
bFrom: Theodore Ts'o <tytso@mit.edu>
From: "Theodore Ts'o" <tytso@mit.edu>

Is there a single, unified design and requirements document that
describes the threat model, and what you are trying to achieve with
AT_EXECVE_CHECK and O_DENY_WRITE?  I've been looking at the cover
letters for AT_EXECVE_CHECK and O_DENY_WRITE, and the documentation
that has landed for AT_EXECVE_CHECK and it really doesn't describe
what *are* the checks that AT_EXECVE_CHECK is trying to achieve:

   "The AT_EXECVE_CHECK execveat(2) flag, and the
   SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE
   securebits are intended for script interpreters and dynamic linkers
   to enforce a consistent execution security policy handled by the
   kernel."

Um, what security policy?  What checks?  What is a sample exploit
which is blocked by AT_EXECVE_CHECK?

And then on top of it, why can't you do these checks by modifying the
script interpreters?

Confused,

						- Ted

