Return-Path: <linux-security-module+bounces-2354-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2B288EBCF
	for <lists+linux-security-module@lfdr.de>; Wed, 27 Mar 2024 17:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D5B1C30E79
	for <lists+linux-security-module@lfdr.de>; Wed, 27 Mar 2024 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A1A14D6F3;
	Wed, 27 Mar 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="V28kcOoM"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6D149C57
	for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558702; cv=none; b=ZYNfxuzVO/7HjaBCWS2X/V6mXl48FzIbb5P2iqTPuBhjaVh3ArQ1mNEC0v/QGVB9WHYqWm8FCTVhJsiwQcgAcXI6+54gSaAN2TR158UWqiZfZC0qf+NCx4YuBsSej4CBlf2+dDLYpl7nudKJNnnA+BxsJ+WyFls73JAR5YOYqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558702; c=relaxed/simple;
	bh=O/Be7l5BeHM5nlsWQJCXukPPM1DqwdjKOfuCFTRouVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6TTGbRGhI7pYiPFWC9afOZcYpmY+iCNiD96tWd14aNhqqCE70n995hVm205zjtwDa5UVDBwJ4bologSSfj2oi75EJCg+cZUnxIKGlNSWC7yagmpBze1JS7S6sF5SSFkIHlxokBwc9D5Ja1fiuvpx+abUA/9biHzknQl0QaBCcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=V28kcOoM; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V4XtC1WghzM2s;
	Wed, 27 Mar 2024 17:58:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711558691;
	bh=O/Be7l5BeHM5nlsWQJCXukPPM1DqwdjKOfuCFTRouVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V28kcOoMLbt9pWtCwD0xUsBbyEaAUmqNEYLqvXZUvf9VrEkjVspX6ZeK5TG9RbxlQ
	 Zn6icjNv2ja9w/dTpWfa8B5nQLz3BGwXFoGcheQGW7ZsACYhgdmS/QmNnlkoKJJeDZ
	 xdtCeAT2+I7gkzSGse1N1pSNs0OGJkkHhEqF1abM=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4V4XtB40FmzwwP;
	Wed, 27 Mar 2024 17:58:10 +0100 (CET)
Date: Wed, 27 Mar 2024 17:58:09 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 02/10] selftests/landlock: Test IOCTL support
Message-ID: <20240327.OoYaiV1suk5i@digikod.net>
References: <20240327131040.158777-1-gnoack@google.com>
 <20240327131040.158777-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327131040.158777-3-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Wed, Mar 27, 2024 at 01:10:32PM +0000, Günther Noack wrote:
> Exercises Landlock's IOCTL feature in different combinations of
> handling and permitting the LANDLOCK_ACCESS_FS_IOCTL_DEV right, and in
> different combinations of using files and directories.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 227 ++++++++++++++++++++-
>  1 file changed, 224 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 418ad745a5dd..8a72e26d4977 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #define _GNU_SOURCE
> +#include <asm/termbits.h>
>  #include <fcntl.h>
>  #include <linux/landlock.h>
>  #include <linux/magic.h>
> @@ -15,6 +16,7 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <sys/capability.h>
> +#include <sys/ioctl.h>
>  #include <sys/mount.h>
>  #include <sys/prctl.h>
>  #include <sys/sendfile.h>
> @@ -23,6 +25,12 @@
>  #include <sys/vfs.h>
>  #include <unistd.h>
>  
> +/*
> + * Intentionally included last to work around header conflict.
> + * See https://sourceware.org/glibc/wiki/Synchronizing_Headers.
> + */
> +#include <linux/fs.h>
> +
>  #include "common.h"
>  
>  #ifndef renameat2
> @@ -737,6 +745,9 @@ static int create_ruleset(struct __test_metadata *const _metadata,
>  	}
>  
>  	for (i = 0; rules[i].path; i++) {
> +		if (!rules[i].access)
> +			continue;
> +
>  		add_path_beneath(_metadata, ruleset_fd, rules[i].access,
>  				 rules[i].path);
>  	}
> @@ -3445,7 +3456,7 @@ TEST_F_FORK(layout1, truncate_unhandled)
>  			      LANDLOCK_ACCESS_FS_WRITE_FILE;
>  	int ruleset_fd;
>  
> -	/* Enable Landlock. */
> +	/* Enables Landlock. */
>  	ruleset_fd = create_ruleset(_metadata, handled, rules);
>  
>  	ASSERT_LE(0, ruleset_fd);
> @@ -3528,7 +3539,7 @@ TEST_F_FORK(layout1, truncate)
>  			      LANDLOCK_ACCESS_FS_TRUNCATE;
>  	int ruleset_fd;
>  
> -	/* Enable Landlock. */
> +	/* Enables Landlock. */
>  	ruleset_fd = create_ruleset(_metadata, handled, rules);
>  
>  	ASSERT_LE(0, ruleset_fd);
> @@ -3754,7 +3765,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
>  	};
>  	int fd, ruleset_fd;
>  
> -	/* Enable Landlock. */
> +	/* Enables Landlock. */
>  	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
>  	ASSERT_LE(0, ruleset_fd);
>  	enforce_ruleset(_metadata, ruleset_fd);
> @@ -3831,6 +3842,16 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
>  	ASSERT_EQ(0, close(socket_fds[1]));
>  }
>  
> +/* Invokes the FS_IOC_GETFLAGS IOCTL and returns its errno or 0. */
> +static int test_fs_ioc_getflags_ioctl(int fd)

This function is not used by this patch, only the next one.

You can catch this kind of issues with check-linux.sh from
https://github.com/landlock-lsm/landlock-test-tools

> +{
> +	uint32_t flags;
> +
> +	if (ioctl(fd, FS_IOC_GETFLAGS, &flags) < 0)
> +		return errno;
> +	return 0;
> +}
> +

