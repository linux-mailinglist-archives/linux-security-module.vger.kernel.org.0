Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC10529CED
	for <lists+linux-security-module@lfdr.de>; Tue, 17 May 2022 10:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243810AbiEQIvk (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 17 May 2022 04:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243005AbiEQIvh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 May 2022 04:51:37 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A803D48D;
        Tue, 17 May 2022 01:51:33 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4L2VGX1R4JzMpvYj;
        Tue, 17 May 2022 10:51:32 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4L2VGW3tVZzlhZvy;
        Tue, 17 May 2022 10:51:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1652777492;
        bh=9JG58trKwXnKwziviTg27xcSomRKUWM9kwqYIWjbft0=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=eCHTWRwuklxL9xwCH3pz8tAXQwhSxLBas419eNvS4WcjqNnGWcVJs01Wrr8iYsCX5
         wlESg9rTWJYpTLxQ/9dlVOc1OMs/BagNV33ufeB1+0biKkyKtvXPsk1CIFiLyPHj/r
         7QvXfezD3OHOmJXAi250ZSZhzHN8XUebZ8RL0/7k=
Message-ID: <bf30769f-22fd-59bd-27db-e44d21f5ad9c@digikod.net>
Date:   Tue, 17 May 2022 10:51:30 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     willemdebruijn.kernel@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yusongping@huawei.com,
        anton.sirazetdinov@huawei.com
References: <20220516152038.39594-1-konstantin.meskhidze@huawei.com>
 <20220516152038.39594-9-konstantin.meskhidze@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v5 08/15] landlock: TCP network hooks implementation
In-Reply-To: <20220516152038.39594-9-konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 16/05/2022 17:20, Konstantin Meskhidze wrote:
> Support of socket_bind() and socket_connect() hooks.
> Its possible to restrict binding and connecting of TCP
> types of sockets to particular ports. Its just basic idea
> how Landlock could support network confinement.
> 
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---
> 
> Changes since v3:
> * Split commit.
> * Add SECURITY_NETWORK in config.
> * Add IS_ENABLED(CONFIG_INET) if a kernel has no INET configuration.
> * Add hook_socket_bind and hook_socket_connect hooks.
> 
> Changes since v4:
> * Factors out CONFIG_INET into make file.
> * Refactoring check_socket_access().
> * Adds helper get_port().
> * Adds CONFIG_IPV6 in  get_port(), hook_socket_bind/connect
> functions to support AF_INET6 family.
> * Adds AF_UNSPEC family support in hook_socket_bind/connect
> functions.
> * Refactoring add_rule_net_service() and landlock_add_rule
> syscall to support network rule inserting.
> * Refactoring init_layer_masks() to support network rules.
> 
> ---
>   security/landlock/Kconfig    |   1 +
>   security/landlock/Makefile   |   2 +
>   security/landlock/net.c      | 159 +++++++++++++++++++++++++++++++++++
>   security/landlock/net.h      |  25 ++++++
>   security/landlock/ruleset.c  |  15 +++-
>   security/landlock/setup.c    |   2 +
>   security/landlock/syscalls.c |  63 ++++++++++++--
>   7 files changed, 261 insertions(+), 6 deletions(-)
>   create mode 100644 security/landlock/net.c
>   create mode 100644 security/landlock/net.h
> 
> diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
> index 8e33c4e8ffb8..10c099097533 100644
> --- a/security/landlock/Kconfig
> +++ b/security/landlock/Kconfig
> @@ -3,6 +3,7 @@
>   config SECURITY_LANDLOCK
>   	bool "Landlock support"
>   	depends on SECURITY && !ARCH_EPHEMERAL_INODES
> +	select SECURITY_NETWORK
>   	select SECURITY_PATH
>   	help
>   	  Landlock is a sandboxing mechanism that enables processes to restrict
> diff --git a/security/landlock/Makefile b/security/landlock/Makefile
> index 7bbd2f413b3e..53d3c92ae22e 100644
> --- a/security/landlock/Makefile
> +++ b/security/landlock/Makefile
> @@ -2,3 +2,5 @@ obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
> 
>   landlock-y := setup.o syscalls.o object.o ruleset.o \
>   	cred.o ptrace.o fs.o
> +
> +landlock-$(CONFIG_INET) += net.o
> \ No newline at end of file
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> new file mode 100644
> index 000000000000..9302e5891991
> --- /dev/null
> +++ b/security/landlock/net.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Landlock LSM - Network management and hooks
> + *
> + * Copyright (C) 2022 Huawei Tech. Co., Ltd.
> + */
> +
> +#include <linux/in.h>
> +#include <linux/net.h>
> +#include <linux/socket.h>
> +#include <net/ipv6.h>
> +
> +#include "cred.h"
> +#include "limits.h"
> +#include "net.h"
> +
> +int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
> +			     u16 port, u32 access_rights)
> +{
> +	int err;
> +
> +	/* Transforms relative access rights to absolute ones. */
> +	access_rights |= LANDLOCK_MASK_ACCESS_NET &
> +			 ~landlock_get_net_access_mask(ruleset, 0);
> +
> +	BUILD_BUG_ON(sizeof(port) > sizeof(uintptr_t));
> +	mutex_lock(&ruleset->lock);
> +	err = landlock_insert_rule(ruleset, NULL, port,
> +				access_rights, LANDLOCK_RULE_NET_SERVICE);
> +	mutex_unlock(&ruleset->lock);
> +
> +	return err;
> +}
> +
> +static int check_socket_access(const struct landlock_ruleset *const domain,
> +			       u16 port, access_mask_t access_request)
> +{
> +	bool allowed = false;
> +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] = {};
> +	const struct landlock_rule *rule;
> +	access_mask_t handled_access;
> +
> +	if (WARN_ON_ONCE(!domain))
> +		return 0;
> +	if (WARN_ON_ONCE(domain->num_layers < 1))
> +		return -EACCES;
> +
> +	rule = landlock_find_rule(domain, port,
> +					LANDLOCK_RULE_NET_SERVICE);
> +
> +	handled_access = init_layer_masks(domain, access_request,
> +			&layer_masks, sizeof(layer_masks),
> +			LANDLOCK_RULE_NET_SERVICE);
> +	allowed = unmask_layers(rule, handled_access,
> +			&layer_masks, ARRAY_SIZE(layer_masks));
> +
> +	return allowed ? 0 : -EACCES;
> +}
> +
> +static u16 get_port(const struct sockaddr *const address)
> +{
> +	/* Gets port value in host byte order. */
> +	switch (address->sa_family) {
> +	case AF_UNSPEC:

Are you sure about that?

Please write a test for this case.


> +	case AF_INET:
> +	{

You don't need these braces (except if it is required by checkpatch.pl).


> +		const struct sockaddr_in *const sockaddr =
> +					(struct sockaddr_in *)address;
> +		return ntohs(sockaddr->sin_port);
> +	}
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +	{
> +		const struct sockaddr_in6 *const sockaddr_ip6 =
> +					(struct sockaddr_in6 *)address;
> +		return ntohs(sockaddr_ip6->sin6_port);
> +	}
> +#endif
> +	}

You missed some part of my patch… We should not get the port for a 
protocol we don't know, hence the WARN_ON_ONCE.


> +	return 0;
> +}
> +
> +static int hook_socket_bind(struct socket *sock, struct sockaddr *address,
> +			    int addrlen)
> +{
> +	const struct landlock_ruleset *const dom =
> +						landlock_get_current_domain();
> +
> +	if (!dom)
> +		return 0;
> +
> +	/* Check if it's a TCP socket */
> +	if (sock->type != SOCK_STREAM)
> +		return 0;
> +
> +	/* Get port value in host byte order */

I moved/removed this in my patch against v4 for a reason. Please, ask if 
you don't understand or if you don't agree with something I said.


> +	switch (address->sa_family) {
> +	case AF_UNSPEC:

Is this correct?

Please write a test for this case.

> +	case AF_INET:
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +#endif
> +		return check_socket_access(dom, get_port(address),
> +					LANDLOCK_ACCESS_NET_BIND_TCP);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int hook_socket_connect(struct socket *sock, struct sockaddr *address,
> +				int addrlen)
> +{
> +	const struct landlock_ruleset *const dom =
> +						landlock_get_current_domain();
> +
> +	if (!dom)
> +		return 0;
> +
> +	/* Check if it's a TCP socket */
> +	if (sock->type != SOCK_STREAM)
> +		return 0;
> +
> +	/* Get port value in host byte order */
> +	switch (address->sa_family) {
> +	case AF_INET:
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +#endif
> +		return check_socket_access(dom, get_port(address),
> +					   LANDLOCK_ACCESS_NET_CONNECT_TCP);
> +	case AF_UNSPEC:
> +	{
> +		u16 i;
> +		/*
> +		 * If just in a layer a mask supports connect access,
> +		 * the socket_connect() hook with AF_UNSPEC family flag
> +		 * must be banned. This prevents from disconnecting already
> +		 * connected sockets.
> +		 */
> +		for (i = 0; i < dom->num_layers; i++) {
> +			if (landlock_get_net_access_mask(dom, i) &
> +				LANDLOCK_ACCESS_NET_CONNECT_TCP)
> +				return -EACCES;
> +		}
> +	}
> +	}
> +	return 0;
> +}
> +
> +static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
> +	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
> +	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
> +};
> +
> +__init void landlock_add_net_hooks(void)
> +{
> +	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
> +			LANDLOCK_NAME);
> +}
> diff --git a/security/landlock/net.h b/security/landlock/net.h
> new file mode 100644
> index 000000000000..da5ce8fa04cc
> --- /dev/null
> +++ b/security/landlock/net.h
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Landlock LSM - Network management and hooks
> + *
> + * Copyright (C) 2022 Huawei Tech. Co., Ltd.
> + */
> +
> +#ifndef _SECURITY_LANDLOCK_NET_H
> +#define _SECURITY_LANDLOCK_NET_H
> +
> +#include "common.h"
> +#include "ruleset.h"
> +#include "setup.h"
> +
> +#if IS_ENABLED(CONFIG_INET)
> +__init void landlock_add_net_hooks(void);
> +
> +int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
> +				u16 port, u32 access_hierarchy);
> +#else /* IS_ENABLED(CONFIG_INET) */
> +static inline void landlock_add_net_hooks(void)
> +{}
> +#endif /* IS_ENABLED(CONFIG_INET) */
> +
> +#endif /* _SECURITY_LANDLOCK_NET_H */
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index ea9ecb3f471a..317cf98890f6 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -671,7 +671,7 @@ access_mask_t get_handled_accesses(
>   		}
>   		break;
>   	default:
> -		break;
> +		return 0;

Why?


>   	}
>   	return access_dom;
>   }
> @@ -763,6 +763,19 @@ access_mask_t init_layer_masks(const struct landlock_ruleset *const domain,
>   				}
>   			}
>   			break;
> +		case LANDLOCK_RULE_NET_SERVICE:
> +			for_each_set_bit(access_bit, &access_req,
> +					LANDLOCK_NUM_ACCESS_NET) {
> +				if (landlock_get_net_access_mask(domain,
> +								 layer_level) &
> +						BIT_ULL(access_bit)) {
> +					(*layer_masks)[access_bit] |=
> +						BIT_ULL(layer_level);
> +					handled_accesses |=
> +							   BIT_ULL(access_bit);
> +				}
> +			}
> +			break;
>   		default:
>   			return 0;
>   		}
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index f8e8e980454c..8059dc0b47d3 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -14,6 +14,7 @@
>   #include "fs.h"
>   #include "ptrace.h"
>   #include "setup.h"
> +#include "net.h"
> 
>   bool landlock_initialized __lsm_ro_after_init = false;
> 
> @@ -28,6 +29,7 @@ static int __init landlock_init(void)
>   	landlock_add_cred_hooks();
>   	landlock_add_ptrace_hooks();
>   	landlock_add_fs_hooks();
> +	landlock_add_net_hooks();
>   	landlock_initialized = true;
>   	pr_info("Up and running.\n");
>   	return 0;
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 812541f4e155..9454c6361011 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -29,6 +29,7 @@
>   #include "cred.h"
>   #include "fs.h"
>   #include "limits.h"
> +#include "net.h"
>   #include "ruleset.h"
>   #include "setup.h"
> 
> @@ -74,7 +75,8 @@ static void build_check_abi(void)
>   {
>   	struct landlock_ruleset_attr ruleset_attr;
>   	struct landlock_path_beneath_attr path_beneath_attr;
> -	size_t ruleset_size, path_beneath_size;
> +	struct landlock_net_service_attr net_service_attr;
> +	size_t ruleset_size, path_beneath_size, net_service_size;
> 
>   	/*
>   	 * For each user space ABI structures, first checks that there is no
> @@ -90,6 +92,11 @@ static void build_check_abi(void)
>   	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
>   	BUILD_BUG_ON(sizeof(path_beneath_attr) != path_beneath_size);
>   	BUILD_BUG_ON(sizeof(path_beneath_attr) != 12);
> +
> +	net_service_size = sizeof(net_service_attr.allowed_access);
> +	net_service_size += sizeof(net_service_attr.port);
> +	BUILD_BUG_ON(sizeof(net_service_attr) != net_service_size);
> +	BUILD_BUG_ON(sizeof(net_service_attr) != 10);
>   }
> 
>   /* Ruleset handling */
> @@ -299,9 +306,9 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>   	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
>   	 * are ignored in path walks.
>   	 */
> -	if (!path_beneath_attr.allowed_access) {
> +	if (!path_beneath_attr.allowed_access)

Why?


>   		return -ENOMSG;
> -	}
> +
>   	/*
>   	 * Checks that allowed_access matches the @ruleset constraints
>   	 * (ruleset->access_masks[0] is automatically upgraded to 64-bits).
> @@ -323,13 +330,54 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>   	return err;
>   }
> 
> +static int add_rule_net_service(struct landlock_ruleset *ruleset,
> +				const void *const rule_attr)
> +{
> +#if IS_ENABLED(CONFIG_INET)
> +	struct landlock_net_service_attr net_service_attr;
> +	int res;
> +	u32 mask;
> +
> +	/* Copies raw user space buffer, only one type for now. */
> +	res = copy_from_user(&net_service_attr, rule_attr,
> +			sizeof(net_service_attr));
> +	if (res)
> +		return -EFAULT;
> +
> +	/*
> +	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
> +	 * are ignored by network actions
> +	 */
> +	if (!net_service_attr.allowed_access)
> +		return -ENOMSG;
> +
> +	/*
> +	 * Checks that allowed_access matches the @ruleset constraints
> +	 * (ruleset->access_masks[0] is automatically upgraded to 64-bits).
> +	 */
> +	mask = landlock_get_net_access_mask(ruleset, 0);
> +	if ((net_service_attr.allowed_access | mask) != mask)
> +		return -EINVAL;
> +
> +	/* Denies inserting a rule with port 0 */
> +	if (net_service_attr.port == 0)
> +		return -EINVAL;
> +
> +	/* Imports the new rule. */
> +	return landlock_append_net_rule(ruleset, net_service_attr.port,
> +				       net_service_attr.allowed_access);
> +#else /* IS_ENABLED(CONFIG_INET) */
> +	return -EAFNOSUPPORT;
> +#endif /* IS_ENABLED(CONFIG_INET) */
> +}
> +
>   /**
>    * sys_landlock_add_rule - Add a new rule to a ruleset
>    *
>    * @ruleset_fd: File descriptor tied to the ruleset that should be extended
>    *		with the new rule.
> - * @rule_type: Identify the structure type pointed to by @rule_attr (only
> - *             LANDLOCK_RULE_PATH_BENEATH for now).
> + * @rule_type: Identify the structure type pointed to by @rule_attr:
> + *             LANDLOCK_RULE_PATH_BENEATH or LANDLOCK_RULE_NET_SERVICE.
>    * @rule_attr: Pointer to a rule (only of type &struct
>    *             landlock_path_beneath_attr for now).
>    * @flags: Must be 0.
> @@ -340,6 +388,8 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>    * Possible returned errors are:
>    *
>    * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
> + * - EAFNOSUPPORT: @rule_type is LANDLOCK_RULE_NET_SERVICE but TCP/IP is not
> + *   supported by the running kernel;
>    * - EINVAL: @flags is not 0, or inconsistent access in the rule (i.e.
>    *   &landlock_path_beneath_attr.allowed_access is not a subset of the rule's
>    *   accesses);
> @@ -375,6 +425,9 @@ SYSCALL_DEFINE4(landlock_add_rule,
>   	case LANDLOCK_RULE_PATH_BENEATH:
>   		err = add_rule_path_beneath(ruleset, rule_attr);
>   		break;
> +	case LANDLOCK_RULE_NET_SERVICE:
> +		err = add_rule_net_service(ruleset, rule_attr);
> +		break;
>   	default:
>   		err = -EINVAL;
>   		break;
> --
> 2.25.1
> 
