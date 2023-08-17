Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C9A77F870
	for <lists+linux-security-module@lfdr.de>; Thu, 17 Aug 2023 16:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351685AbjHQONu (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 17 Aug 2023 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351588AbjHQONd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Aug 2023 10:13:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00794E55;
        Thu, 17 Aug 2023 07:13:31 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RRRhT2tnNz6J7VM;
        Thu, 17 Aug 2023 22:09:29 +0800 (CST)
Received: from [10.123.123.126] (10.123.123.126) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 15:13:29 +0100
Message-ID: <110dc71f-ff83-b87f-10ae-7f6f9bd7c1df@huawei.com>
Date:   Thu, 17 Aug 2023 17:13:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] landlock: Fix and test network AF inconsistencies
Content-Language: ru
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
CC:     <artem.kuzin@huawei.com>, <gnoack3000@gmail.com>,
        <willemdebruijn.kernel@gmail.com>, <yusongping@huawei.com>,
        <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>
References: <20230817.theivaoThia9@digikod.net>
 <20230817130001.1493321-1-mic@digikod.net>
From:   "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <20230817130001.1493321-1-mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.123.126]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



8/17/2023 4:00 PM, Mickaël Salaün пишет:
> Check af_family consistency while handling AF_UNSPEC specifically.
> 
> This patch should be squashed into the "Network support for Landlock"
> v11 patch series.

Thank you so much.
Can I find this patch in 
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux ???
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>   security/landlock/net.c                     |  29 ++++-
>   tools/testing/selftests/landlock/net_test.c | 124 +++++++++++++-------
>   2 files changed, 108 insertions(+), 45 deletions(-)
> 
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index f8d2be53ac0d..ea5373f774f9 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -80,11 +80,11 @@ static int check_socket_access(struct socket *const sock,
>   	if (WARN_ON_ONCE(domain->num_layers < 1))
>   		return -EACCES;
>   
> -	/* Checks if it's a TCP socket. */
> +	/* Checks if it's a (potential) TCP socket. */
>   	if (sock->type != SOCK_STREAM)
>   		return 0;
>   
> -	/* Checks for minimal header length. */
> +	/* Checks for minimal header length to safely read sa_family. */
>   	if (addrlen < offsetofend(struct sockaddr, sa_family))
>   		return -EINVAL;
>   
> @@ -106,7 +106,6 @@ static int check_socket_access(struct socket *const sock,
>   		return 0;
>   	}
>   
> -	/* Specific AF_UNSPEC handling. */
>   	if (address->sa_family == AF_UNSPEC) {
>   		/*
>   		 * Connecting to an address with AF_UNSPEC dissolves the TCP
> @@ -114,6 +113,10 @@ static int check_socket_access(struct socket *const sock,
>   		 * connection while retaining the socket object (i.e., the file
>   		 * descriptor).  As for dropping privileges, closing
>   		 * connections is always allowed.
> +		 *
> +		 * For a TCP access control system, this request is legitimate.
> +		 * Let the network stack handle potential inconsistencies and
> +		 * return -EINVAL if needed.
>   		 */
>   		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP)
>   			return 0;
> @@ -124,14 +127,34 @@ static int check_socket_access(struct socket *const sock,
>   		 * INADDR_ANY (cf. __inet_bind).  Checking the address is
>   		 * required to not wrongfully return -EACCES instead of
>   		 * -EAFNOSUPPORT.
> +		 *
> +		 *  We could return 0 and let the network stack handle these
> +		 *  checks, but it is safer to return a proper error and test
> +		 *  consistency thanks to kselftest.
>   		 */
>   		if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
> +			/* addrlen has already been checked for AF_UNSPEC. */
>   			const struct sockaddr_in *const sockaddr =
>   				(struct sockaddr_in *)address;
>   
> +			if (sock->sk->__sk_common.skc_family != AF_INET)
> +				return -EINVAL;
> +
>   			if (sockaddr->sin_addr.s_addr != htonl(INADDR_ANY))
>   				return -EAFNOSUPPORT;
>   		}
> +	} else {
> +		/*
> +		 * Checks sa_family consistency to not wrongfully return
> +		 * -EACCES instead of -EINVAL.  Valid sa_family changes are
> +		 *  only (from AF_INET or AF_INET6) to AF_UNSPEC.
> +		 *
> +		 *  We could return 0 and let the network stack handle this
> +		 *  check, but it is safer to return a proper error and test
> +		 *  consistency thanks to kselftest.
> +		 */
> +		if (address->sa_family != sock->sk->__sk_common.skc_family)
> +			return -EINVAL;
>   	}
>   
>   	id.key.data = (__force uintptr_t)port;
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index 12dc127ea7d1..504a26c63fd9 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -233,7 +233,7 @@ static int connect_variant(const int sock_fd,
>   
>   FIXTURE(protocol)
>   {
> -	struct service_fixture srv0, srv1, srv2, unspec_any, unspec_srv0;
> +	struct service_fixture srv0, srv1, srv2, unspec_any0, unspec_srv0;
>   };
>   
>   FIXTURE_VARIANT(protocol)
> @@ -257,8 +257,8 @@ FIXTURE_SETUP(protocol)
>   
>   	ASSERT_EQ(0, set_service(&self->unspec_srv0, prot_unspec, 0));
>   
> -	ASSERT_EQ(0, set_service(&self->unspec_any, prot_unspec, 0));
> -	self->unspec_any.ipv4_addr.sin_addr.s_addr = htonl(INADDR_ANY);
> +	ASSERT_EQ(0, set_service(&self->unspec_any0, prot_unspec, 0));
> +	self->unspec_any0.ipv4_addr.sin_addr.s_addr = htonl(INADDR_ANY);
>   
>   	setup_loopback(_metadata);
>   };
> @@ -615,20 +615,18 @@ TEST_F(protocol, connect)
>   // Kernel FIXME: tcp_sandbox_with_ipv6_tcp and tcp_sandbox_with_unix_stream
>   TEST_F(protocol, bind_unspec)
>   {
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
> +	};
> +	const struct landlock_net_service_attr tcp_bind = {
> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
> +		.port = self->srv0.port,
> +	};
>   	int bind_fd, ret;
>   
>   	if (variant->sandbox == TCP_SANDBOX) {
> -		const struct landlock_ruleset_attr ruleset_attr = {
> -			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
> -		};
> -		const struct landlock_net_service_attr tcp_bind = {
> -			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
> -			.port = self->srv0.port,
> -		};
> -		int ruleset_fd;
> -
> -		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
> -						     sizeof(ruleset_attr), 0);
> +		const int ruleset_fd = landlock_create_ruleset(
> +			&ruleset_attr, sizeof(ruleset_attr), 0);
>   		ASSERT_LE(0, ruleset_fd);
>   
>   		/* Allows bind. */
> @@ -642,8 +640,8 @@ TEST_F(protocol, bind_unspec)
>   	bind_fd = socket_variant(&self->srv0);
>   	ASSERT_LE(0, bind_fd);
>   
> -	/* Binds on AF_UNSPEC/INADDR_ANY. */
> -	ret = bind_variant(bind_fd, &self->unspec_any);
> +	/* Allowed bind on AF_UNSPEC/INADDR_ANY. */
> +	ret = bind_variant(bind_fd, &self->unspec_any0);
>   	if (variant->prot.domain == AF_INET) {
>   		EXPECT_EQ(0, ret)
>   		{
> @@ -655,6 +653,33 @@ TEST_F(protocol, bind_unspec)
>   	}
>   	EXPECT_EQ(0, close(bind_fd));
>   
> +	if (variant->sandbox == TCP_SANDBOX) {
> +		const int ruleset_fd = landlock_create_ruleset(
> +			&ruleset_attr, sizeof(ruleset_attr), 0);
> +		ASSERT_LE(0, ruleset_fd);
> +
> +		/* Denies bind. */
> +		enforce_ruleset(_metadata, ruleset_fd);
> +		EXPECT_EQ(0, close(ruleset_fd));
> +	}
> +
> +	bind_fd = socket_variant(&self->srv0);
> +	ASSERT_LE(0, bind_fd);
> +
> +	/* Denied bind on AF_UNSPEC/INADDR_ANY. */
> +	ret = bind_variant(bind_fd, &self->unspec_any0);
> +	if (variant->prot.domain == AF_INET) {
> +		if (is_restricted(&variant->prot, variant->sandbox)) {
> +			EXPECT_EQ(-EACCES, ret);
> +		} else {
> +			EXPECT_EQ(0, ret);
> +		}
> +	} else {
> +		EXPECT_EQ(-EINVAL, ret);
> +	}
> +	EXPECT_EQ(0, close(bind_fd));
> +
> +	/* Checks bind with AF_UNSPEC and the loopback address. */
>   	bind_fd = socket_variant(&self->srv0);
>   	ASSERT_LE(0, bind_fd);
>   	ret = bind_variant(bind_fd, &self->unspec_srv0);
> @@ -671,34 +696,16 @@ TEST_F(protocol, bind_unspec)
>   
>   TEST_F(protocol, connect_unspec)
>   {
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +	};
> +	const struct landlock_net_service_attr tcp_connect = {
> +		.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +		.port = self->srv0.port,
> +	};
>   	int bind_fd, client_fd, status;
>   	pid_t child;
>   
> -	if (variant->sandbox == TCP_SANDBOX) {
> -		const struct landlock_ruleset_attr ruleset_attr = {
> -			.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
> -		};
> -		const struct landlock_net_service_attr tcp_connect = {
> -			.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
> -			.port = self->srv0.port,
> -		};
> -		int ruleset_fd;
> -
> -		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
> -						     sizeof(ruleset_attr), 0);
> -		ASSERT_LE(0, ruleset_fd);
> -
> -		/* Allows connect. */
> -		ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
> -					       LANDLOCK_RULE_NET_SERVICE,
> -					       &tcp_connect, 0));
> -		enforce_ruleset(_metadata, ruleset_fd);
> -		EXPECT_EQ(0, close(ruleset_fd));
> -	}
> -
> -	/* Generic connection tests. */
> -	test_bind_and_connect(_metadata, &self->srv0, false, false);
> -
>   	/* Specific connection tests. */
>   	bind_fd = socket_variant(&self->srv0);
>   	ASSERT_LE(0, bind_fd);
> @@ -726,8 +733,22 @@ TEST_F(protocol, connect_unspec)
>   			EXPECT_EQ(0, ret);
>   		}
>   
> +		if (variant->sandbox == TCP_SANDBOX) {
> +			const int ruleset_fd = landlock_create_ruleset(
> +				&ruleset_attr, sizeof(ruleset_attr), 0);
> +			ASSERT_LE(0, ruleset_fd);
> +
> +			/* Allows connect. */
> +			ASSERT_EQ(0,
> +				  landlock_add_rule(ruleset_fd,
> +						    LANDLOCK_RULE_NET_SERVICE,
> +						    &tcp_connect, 0));
> +			enforce_ruleset(_metadata, ruleset_fd);
> +			EXPECT_EQ(0, close(ruleset_fd));
> +		}
> +
>   		/* Disconnects already connected socket, or set peer. */
> -		ret = connect_variant(connect_fd, &self->unspec_any);
> +		ret = connect_variant(connect_fd, &self->unspec_any0);
>   		if (self->srv0.protocol.domain == AF_UNIX &&
>   		    self->srv0.protocol.type == SOCK_STREAM) {
>   			EXPECT_EQ(-EINVAL, ret);
> @@ -744,6 +765,25 @@ TEST_F(protocol, connect_unspec)
>   			EXPECT_EQ(0, ret);
>   		}
>   
> +		if (variant->sandbox == TCP_SANDBOX) {
> +			const int ruleset_fd = landlock_create_ruleset(
> +				&ruleset_attr, sizeof(ruleset_attr), 0);
> +			ASSERT_LE(0, ruleset_fd);
> +
> +			/* Denies connect. */
> +			enforce_ruleset(_metadata, ruleset_fd);
> +			EXPECT_EQ(0, close(ruleset_fd));
> +		}
> +
> +		ret = connect_variant(connect_fd, &self->unspec_any0);
> +		if (self->srv0.protocol.domain == AF_UNIX &&
> +		    self->srv0.protocol.type == SOCK_STREAM) {
> +			EXPECT_EQ(-EINVAL, ret);
> +		} else {
> +			/* Always allowed to disconnect. */
> +			EXPECT_EQ(0, ret);
> +		}
> +
>   		EXPECT_EQ(0, close(connect_fd));
>   		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
>   		return;
