Return-Path: <linux-security-module+bounces-4756-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B9694D1E2
	for <lists+linux-security-module@lfdr.de>; Fri,  9 Aug 2024 16:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF951F2565B
	for <lists+linux-security-module@lfdr.de>; Fri,  9 Aug 2024 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DD6195FFA;
	Fri,  9 Aug 2024 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="sc5OSfc5"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98E5174EE4
	for <linux-security-module@vger.kernel.org>; Fri,  9 Aug 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212720; cv=none; b=fPtRM03W6XwoPs09uDig4UNDR7Be85SFItnknwGvyagAXe+J/mnnC4PR0UeboRcPT0bkBQXdvXtfLYKNhVOeXelEyKn4wvF7EHaWuxMqdkeTdes7O4DiN70CYI2WpoHh2H+/ma0rhw25BxQ/Q8fihUQzgdDKpznZPnAG+X5O0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212720; c=relaxed/simple;
	bh=d2qpUjqP+5ygwVuOs3eMSo1YBavpbn1nxLoDr7z9oQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAnFKRgGxPExZ9/BWTIN82hNnRQ9UNOMnairU/Pd8bwVtjmTNyF4Q+bQMYy5Q26p/VeWRr1yoPcZggfNGgM9ZqYM9nZM7AItb1WSGH2E4NafhnSaLDIi7jcHcNR+A/rtHcmYuR3aB6V90zwI5S6HV7WR9XrIcKhEroBdvT0c980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=sc5OSfc5; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WgQp1604fz6mf;
	Fri,  9 Aug 2024 16:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723212713;
	bh=alrcssf8lb4SOpOwA57ksV7R442dpGsapRV5pmoJxog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sc5OSfc5KsTDO1QTM/8FIt51I2Z/1wYzmExzou+RihNNlqeUQTXutqdLOS+ddmfaM
	 +GRwOTBFHjSV75JIBcPY2A+YiHII82jaUvTTJ5sd4PVaiToV60143MSlkbRdMAuS6f
	 8J+cd4wWBauEEYAtULmiIbZ5ea/jOrdnQWmDGquk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WgQp03lQBzqHV;
	Fri,  9 Aug 2024 16:11:52 +0200 (CEST)
Date: Fri, 9 Aug 2024 16:11:47 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 3/4] sample/Landlock: Support abstract unix socket
 restriction
Message-ID: <20240809.uupaip5Iepho@digikod.net>
References: <cover.1722570749.git.fahimitahera@gmail.com>
 <2b1ac6822d852ea70dd2dcdf41065076d9ee8028.1722570749.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b1ac6822d852ea70dd2dcdf41065076d9ee8028.1722570749.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Aug 01, 2024 at 10:02:35PM -0600, Tahera Fahimi wrote:
> A sandboxer can receive the character "a" as input from the environment
> variable LL_SCOPE to restrict the abstract unix sockets from connecting
> to a process outside its scoped domain.
> 
> Example
> =======
> Create an abstract unix socket to listen with socat(1):
> socat abstract-listen:mysocket -
> Create a sandboxed shell and pass the character "a" to LL_SCOPED:
> LL_FS_RO=/ LL_FS_RW=. LL_SCOPED="a" ./sandboxer /bin/bash
> If the sandboxed process tries to connect to the listening socket
> with command "socat - abstract-connect:mysocket", the connection
> will fail.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> 
> ---
> v8:
> - Adding check_ruleset_scope function to parse the scope environment
>   variable and update the landlock attribute based on the restriction
>   provided by the user.
> - Adding Mickaël Salaün reviews on version 7.
> 
> v7:
> - Adding IPC scoping to the sandbox demo by defining a new "LL_SCOPED"
>   environment variable. "LL_SCOPED" gets value "a" to restrict abstract
>   unix sockets.
> - Change LANDLOCK_ABI_LAST to 6.
> ---
>  samples/landlock/sandboxer.c | 56 +++++++++++++++++++++++++++++++++---
>  1 file changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index e8223c3e781a..98132fd823ad 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -14,6 +14,7 @@
>  #include <fcntl.h>
>  #include <linux/landlock.h>
>  #include <linux/prctl.h>
> +#include <linux/socket.h>
>  #include <stddef.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -22,6 +23,7 @@
>  #include <sys/stat.h>
>  #include <sys/syscall.h>
>  #include <unistd.h>
> +#include <stdbool.h>
>  
>  #ifndef landlock_create_ruleset
>  static inline int
> @@ -55,6 +57,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
>  #define ENV_FS_RW_NAME "LL_FS_RW"
>  #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
>  #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
> +#define ENV_SCOPED_NAME "LL_SCOPED"
>  #define ENV_DELIMITER ":"
>  
>  static int parse_path(char *env_path, const char ***const path_list)
> @@ -184,6 +187,38 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  	return ret;
>  }
>  
> +static bool check_ruleset_scope(const char *const env_var,
> +				struct landlock_ruleset_attr *ruleset_attr)
> +{
> +	bool ret = true;
> +	char *env_type_scope, *env_type_scope_next, *ipc_scoping_name;
> +
> +	ruleset_attr->scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;

Why always removing the suported scope?
What happen if ABI < 6 ?

> +	env_type_scope = getenv(env_var);
> +	/* scoping is not supported by the user */
> +	if (!env_type_scope)
> +		return true;
> +	env_type_scope = strdup(env_type_scope);
> +	unsetenv(env_var);
> +
> +	env_type_scope_next = env_type_scope;
> +	while ((ipc_scoping_name =
> +			strsep(&env_type_scope_next, ENV_DELIMITER))) {
> +		if (strcmp("a", ipc_scoping_name) == 0) {
> +			ruleset_attr->scoped |=
> +				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;

There are two issues here:
1. this would not work for ABI < 6
2. "a" can be repeated several times, which should probably not be
   allowed because we don't want to support this
   unspecified/undocumented behavior.


> +		} else {
> +			fprintf(stderr, "Unsupported scoping \"%s\"\n",
> +				ipc_scoping_name);
> +			ret = false;
> +			goto out_free_name;
> +		}
> +	}
> +out_free_name:
> +	free(env_type_scope);
> +	return ret;
> +}
> +
>  /* clang-format off */
>  
>  #define ACCESS_FS_ROUGHLY_READ ( \
> @@ -208,7 +243,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  
>  /* clang-format on */
>  
> -#define LANDLOCK_ABI_LAST 5
> +#define LANDLOCK_ABI_LAST 6
>  
>  int main(const int argc, char *const argv[], char *const *const envp)
>  {
> @@ -223,14 +258,15 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		.handled_access_fs = access_fs_rw,
>  		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>  				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
>  	};
>  
>  	if (argc < 2) {
>  		fprintf(stderr,
> -			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\"%s "
> +			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s "
>  			"<cmd> [args]...\n\n",
>  			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> -			ENV_TCP_CONNECT_NAME, argv[0]);
> +			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
>  		fprintf(stderr,
>  			"Execute a command in a restricted environment.\n\n");
>  		fprintf(stderr,
> @@ -251,15 +287,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		fprintf(stderr,
>  			"* %s: list of ports allowed to connect (client).\n",
>  			ENV_TCP_CONNECT_NAME);
> +		fprintf(stderr, "* %s: list of restrictions on IPCs.\n",
> +			ENV_SCOPED_NAME);
>  		fprintf(stderr,
>  			"\nexample:\n"
>  			"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
>  			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
>  			"%s=\"9418\" "
>  			"%s=\"80:443\" "
> +			"%s=\"a\" "
>  			"%s bash -i\n\n",
>  			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> -			ENV_TCP_CONNECT_NAME, argv[0]);
> +			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
>  		fprintf(stderr,
>  			"This sandboxer can use Landlock features "
>  			"up to ABI version %d.\n",
> @@ -327,6 +366,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		/* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
>  		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
>  
> +		__attribute__((fallthrough));
> +	case 5:
> +		/* Removes LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET for ABI < 6 */
> +		ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
>  		fprintf(stderr,
>  			"Hint: You should update the running kernel "
>  			"to leverage Landlock features "
> @@ -358,6 +401,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
>  	}
>  
> +	if (!check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr)) {

You should use the same pattern as for TCP access rigths: if the
environment variable is not set then remove the ruleset's scopes.

> +		perror("Unsupported IPC scoping requested");
> +		return 1;
> +	}
> +
>  	ruleset_fd =
>  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>  	if (ruleset_fd < 0) {
> -- 
> 2.34.1
> 
> 

