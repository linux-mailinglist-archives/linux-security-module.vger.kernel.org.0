Return-Path: <linux-security-module+bounces-11999-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7037B8545C
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Sep 2025 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB090B6190E
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Sep 2025 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882561F12E0;
	Thu, 18 Sep 2025 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YJF5GnDm"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E912A1D63E4
	for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206116; cv=none; b=EG5g1Em9oedVCsZtZ2WNq5BxD4sQotyP055gbEPqHL8JgF4OL7+8Db8J+sBPMeK5MUlOcz2J+hLDVLWVGXOW8TosiYt1UQLDqpyDegwzI44DwVoCU+38rcZVF7BUGns+XP7WCsBAiIutQSNC2EMvq9B11HjYqrMYGm/jqua+P7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206116; c=relaxed/simple;
	bh=FCRVB1wlDI3dW1Z/iaYUprsVnwoOfpMuJlnofm2OPPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N15R8+tj4i4GDyNerwQ9K6GXEn1CbBHhRO7k2eG46usoGgTvqYAO5J3x8XgfBsJ7xgnEiYv/aYIWGW9yOGcHjY/s396mcmN9xOkz6zzaEm2jAkoYls/Gjq3hz7FP18C7Gt3/u8IY3Z5DhS3bOe8NDz2RePk+UOfQzZavXLKH1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YJF5GnDm; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cSHyH5DTNzX1Q;
	Thu, 18 Sep 2025 16:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1758205607;
	bh=OcUeUPn/Mw5NRnx4pirX6KM43pffa0yy++ANqSF11xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJF5GnDmn9rBcXXUHxSUV/y/+dyz2V0fnVeyDCkFZ05C+W6XbVU7vkuX2FYjaF7eH
	 orN8PCnVznJPHqcu/v+VjcC0R6cFpeiEMeRaInTZfWdOapw9YERaBZVCKy9dPV5rLF
	 V/t0zN2YYLw3ZMpUi6oGCx5CIEWpmIbxbxj8wpwc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cSHyD6mzgzbVh;
	Thu, 18 Sep 2025 16:26:44 +0200 (CEST)
Date: Thu, 18 Sep 2025 16:26:38 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Abhinav Saxena <xandfury@gmail.com>, Paul Moore <paul@paul-moore.com>
Cc: Fan Wu <wufan@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	llvm@lists.linux.dev, Daniel Verkamp <dverkamp@chromium.org>, 
	Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH RFC 2/4] landlock: implement memfd detection
Message-ID: <20250918.eXaiF5Ejoing@digikod.net>
References: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
 <20250719-memfd-exec-v1-2-0ef7feba5821@gmail.com>
 <CAKtyLkEJKLgO1GvpTNmW=DnRhrsiPXGgz9=F7oJXVQPLSocSeA@mail.gmail.com>
 <87v7nj7p1d.fsf@gmail.com>
 <20250918.kieghied1ahS@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918.kieghied1ahS@digikod.net>
X-Infomaniak-Routing: alpha

On Thu, Sep 18, 2025 at 04:07:48PM +0200, Mickaël Salaün wrote:
> On Tue, Jul 22, 2025 at 03:56:38PM -0600, Abhinav Saxena wrote:
> > Fan Wu <wufan@kernel.org> writes:
> > 
> > > On Sat, Jul 19, 2025 at 4:13 AM Abhinav Saxena <xandfury@gmail.com> wrote:
> > >>
> > >> Add is_memfd_file() function to reliably detect memfd files by checking
> > >> for “memfd:” prefix in dentry names on shmem-backed files. This
> > >> distinguishes true memfd files from regular shmem files.
> > >>
> > >> Move domain_is_scoped() to domain.c for reuse across subsystems.
> > >> Add comprehensive kunit tests for memfd detection edge cases.
> > >>
> > >> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> > >> —
> > >>  security/landlock/domain.c |  67 +++++++++++++++
> > >>  security/landlock/domain.h |   4 +
> > >>  security/landlock/fs.c     | 210 +++++++++++++++++++++++++++++++++++++++++++++
> > >>  security/landlock/task.c   |  67 —————
> > >>  4 files changed, 281 insertions(+), 67 deletions(-)
> > >
> > > …
> > >
> > >>
> > >> +/**
> > >> + * is_memfd_file - Check if file was created via memfd_create()
> > >> + * @file: File to check
> > >> + *
> > >> + * Returns true if @file was created via memfd_create(), false otherwise.
> > >> + *
> > >> + * memfd files are shmem-backed files with “memfd:” prefix in their dentry name.
> > >> + * This is the definitive way to distinguish memfd files from regular shmem
> > >> + * files.
> > >> + */
> > >> +static bool is_memfd_file(struct file *file)
> > >> +{
> > >> +       const struct dentry *dentry;
> > >> +       const unsigned char *name;
> > >> +       size_t name_len;
> > >> +
> > >> +       /* Fast path: basic validation */
> > >> +       if (unlikely(!file))
> > >> +               return false;
> > >> +
> > >> +       /* Must be shmem-backed first - this is the cheapest definitive check */
> > >> +       if (!shmem_file(file))
> > >> +               return false;
> 
> In which case a memfd would not be detected by this function?
> shmem_file_operations or hugetlbfs_file_operations are always set for
> memfd right?
> 
> We could export memfd_get_seals() to stay consistent over time.
> 
> > >> +
> > >> +#ifdef CONFIG_MEMFD_CREATE
> > >> +
> > >> +       /* Validate dentry and get name info */
> > >> +       dentry = file->f_path.dentry;
> > >> +       if (unlikely(!dentry))
> > >> +               return false;
> > >> +
> > >> +       name_len = dentry->d_name.len;
> > >> +       name = dentry->d_name.name;
> > >> +
> > >> +       /* memfd files always have “memfd:” prefix (6 characters) */
> > >> +       if (name_len < 6 || unlikely(!name))
> > >> +               return false;
> > >> +
> > >> +       /* Check for exact “memfd:” prefix */
> > >> +       return memcmp(name, “memfd:”, 6) == 0;
> > >> +#else
> > >> +       return false;
> > >> +#endif
> > >
> > > I was trying to do something similar early this year but didn’t hear
> > > feedback from the linux-mm folks.
> > > <https://lore.kernel.org/linux-security-module/20250129203932.22165-1-wufan@kernel.org/>
> > >
> > > I have considered this approach but didn’t use it. My concern is,
> > > potentially a malicious user can create a file in a shmem fs, e.g.
> > > tmpfs , with the “memfd:” prefix, which can be used to bypass security
> > > policy.
> 
> In the case of Landlock that should not be a security issue but a
> compatibility issue, which is not better.
> 
> > > (Resending this message due to a misconfiguration with my email
> > > client. Apologies for any inconvenience.)
> > >
> > > -Fan
> > 
> > Hi Fan,
> > 
> > Thanks for your comments.
> > 
> > I agree that an LSM hook into memfd_create() would be a much better
> > solution. In the absence of such a function, do you think adding a

Hmm, we cannot use hook_file_alloc_security() to enforce restriction on
memfd creation because the inode mode is set after this call by
memfd.c:alloc_file().  So we should indeed add a new LSM hook.  That
would also improve security checks on file creation for other file
types.

> > `d_unlinked(dentry)` check could serve as an additional verification?
> > 
> > I say things since I *think* that legitimate memfd files are always
> > unlinked while spoofed tmpfs files remain linked. I could be wrong
> > though.
> 
> We should just use the same checks used by the memfd-related
> syscalls/operations to detect such file.
> 
> > 
> > In any case, we can test this approach using kprobes to validate
> > the behavior.
> > 
> > -Abhinav
> 

