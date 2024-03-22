Return-Path: <linux-security-module+bounces-2252-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518318867AC
	for <lists+linux-security-module@lfdr.de>; Fri, 22 Mar 2024 08:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535C31C23535
	for <lists+linux-security-module@lfdr.de>; Fri, 22 Mar 2024 07:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316A12E72;
	Fri, 22 Mar 2024 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="MYAhz7Zn"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AEC13FFB
	for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094253; cv=none; b=b+ApIij5sdj3iLO6d7M3WpIcLb8c0VQno63a1YrxDySO1fH1C/22h6yKzRWEnwf07KH25mGInLtFROIOwqB3HlRKUV6bp1WKe0gf+J1PPz3/tF8lsD/lBLR2jXu2sVEHuTvkO7nlctrSQNaeqxiZygWlnHFWDeavtWl1N7d5J+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094253; c=relaxed/simple;
	bh=DzamNWl8OA9+DxWsvvpcSHUU7nPz5AouyCUlk1guqzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7J714vqRk8dep69x8ajz92WVxGI/DB73W6oYt7Z3WgsYbWMStL2nHl9xMVcZo0aqSHAa24RjLPyD6BR4sP2kwwYr2h1/+fhaTNUGgNU0JmzqrAAri0LQEtivmFhbO9ifxLIEWXEFwMd6bj+Xpeb/rkSUbJHhXvgN2q+dFgWMdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=MYAhz7Zn; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V1F6R3dD7zXnB;
	Fri, 22 Mar 2024 08:57:19 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V1F6R0DDczZX;
	Fri, 22 Mar 2024 08:57:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711094239;
	bh=DzamNWl8OA9+DxWsvvpcSHUU7nPz5AouyCUlk1guqzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYAhz7ZnubWO2DV03PY9lucvRBiYtf/uYYglE2eQyrdjLKeoA88V5UWK90v9Ibnrv
	 in834ffDvYqmYTd7n0EyfRzCrC/1aZuKOfBfOm8kiEvhOFD+RoxAkUiGjJRDCTEZKR
	 OedmZ6W4Bg4t3ph9ot0Cc8REx521jJmoRMOKk5nA=
Date: Fri, 22 Mar 2024 08:57:18 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10 7/9] selftests/landlock: Check IOCTL restrictions for
 named UNIX domain sockets
Message-ID: <20240322.iZ1seigie0ia@digikod.net>
References: <20240309075320.160128-1-gnoack@google.com>
 <20240309075320.160128-8-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240309075320.160128-8-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Sat, Mar 09, 2024 at 07:53:18AM +0000, Günther Noack wrote:
> Suggested-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index d991f44875bc..941e6f9702b7 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -20,8 +20,10 @@
>  #include <sys/mount.h>
>  #include <sys/prctl.h>
>  #include <sys/sendfile.h>
> +#include <sys/socket.h>
>  #include <sys/stat.h>
>  #include <sys/sysmacros.h>
> +#include <sys/un.h>
>  #include <sys/vfs.h>
>  #include <unistd.h>
>  
> @@ -3976,6 +3978,57 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
>  	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
>  }
>  
> +/* For named UNIX domain sockets, no IOCTL restrictions apply. */
> +TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
> +{
> +	const char *const path = file1_s1d1;
> +	int srv_fd, cli_fd, ruleset_fd;
> +	socklen_t size;
> +	struct sockaddr_un srv_un, cli_un;
> +	const struct landlock_ruleset_attr attr = {
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV,
> +	};
> +
> +	/* Sets up a server */
> +	srv_un.sun_family = AF_UNIX;
> +	strncpy(srv_un.sun_path, path, sizeof(srv_un.sun_path));
> +
> +	ASSERT_EQ(0, unlink(path));
> +	ASSERT_LE(0, (srv_fd = socket(AF_UNIX, SOCK_STREAM, 0)));
> +
> +	size = offsetof(struct sockaddr_un, sun_path) + strlen(srv_un.sun_path);
> +	ASSERT_EQ(0, bind(srv_fd, (struct sockaddr *)&srv_un, size));
> +	ASSERT_EQ(0, listen(srv_fd, 10 /* qlen */));
> +
> +	/* Enables Landlock. */
> +	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Sets up a client connection to it */
> +	cli_un.sun_family = AF_UNIX;
> +	snprintf(cli_un.sun_path, sizeof(cli_un.sun_path), "%s%ld", path,
> +		 (long)getpid());

I don't think it is useful to have a unique sun_path for a named unix
socket, that's the purpose of naming it right?

> +
> +	ASSERT_LE(0, (cli_fd = socket(AF_UNIX, SOCK_STREAM, 0)));
> +
> +	size = offsetof(struct sockaddr_un, sun_path) + strlen(cli_un.sun_path);
> +	ASSERT_EQ(0, bind(cli_fd, (struct sockaddr *)&cli_un, size));
> +
> +	bzero(&cli_un, sizeof(cli_un));
> +	cli_un.sun_family = AF_UNIX;
> +	strncpy(cli_un.sun_path, path, sizeof(cli_un.sun_path));
> +	size = offsetof(struct sockaddr_un, sun_path) + strlen(cli_un.sun_path);
> +
> +	ASSERT_EQ(0, connect(cli_fd, (struct sockaddr *)&cli_un, size));
> +
> +	/* FIONREAD and other IOCTLs should not be forbidden. */
> +	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
> +
> +	ASSERT_EQ(0, close(cli_fd));
> +}
> +
>  /* clang-format off */
>  FIXTURE(ioctl) {};
>  
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 
> 

