Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B973D77FAD7
	for <lists+linux-security-module@lfdr.de>; Thu, 17 Aug 2023 17:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352315AbjHQPfI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 17 Aug 2023 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352319AbjHQPfD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Aug 2023 11:35:03 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183DC30C5
        for <linux-security-module@vger.kernel.org>; Thu, 17 Aug 2023 08:35:01 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RRTb73Zz5zMpr3S;
        Thu, 17 Aug 2023 15:34:59 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RRTb66b4jzMppB0;
        Thu, 17 Aug 2023 17:34:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692286499;
        bh=fvRUGukBHyQKMBl6VqYrWCcx3q1YcRC+eQ/hePvfF1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIN186T3+DxGN8xEU1KgpaZe73CPnmgwXmdnScDwi8ftc/A1CFMOTxXHitpBscHsN
         jCvEfJp/zZUmgqTPUSwsgfE9JkenRi2OILky17051rhWHP+/ITcJqnGYE52P46yuFh
         4/cRTFMyq5fBpJg52fL50EREhTX1WGR+5P1OjcVI=
Date:   Thu, 17 Aug 2023 17:34:53 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
Cc:     artem.kuzin@huawei.com, gnoack3000@gmail.com,
        willemdebruijn.kernel@gmail.com, yusongping@huawei.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v11.1] selftests/landlock: Add 11 new test suites
 dedicated to network
Message-ID: <20230817.geraipi9teiB@digikod.net>
References: <20230515161339.631577-11-konstantin.meskhidze@huawei.com>
 <20230706145543.1284007-1-mic@digikod.net>
 <3db64cf8-6a45-a361-aa57-9bfbaf866ef8@digikod.net>
 <30e2bacd-2e48-9056-5950-1974b9373ee3@huawei.com>
 <20230817.EiHicha5shei@digikod.net>
 <b0bfa45a-c2bd-545e-ec51-02eeeab0677d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0bfa45a-c2bd-545e-ec51-02eeeab0677d@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 17, 2023 at 05:04:00PM +0300, Konstantin Meskhidze (A) wrote:
> 
> 
> 8/17/2023 4:19 PM, Mickaël Salaün пишет:
> > On Sun, Aug 13, 2023 at 11:09:59PM +0300, Konstantin Meskhidze (A) wrote:
> > > 
> > > 
> > > 7/12/2023 10:02 AM, Mickaël Salaün пишет:
> > > > > On 06/07/2023 16:55, Mickaël Salaün wrote:
> > > > > From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> > > > > > > This patch is a revamp of the v11 tests [1] with new tests
> > > (see the
> > > > > "Changes since v11" description).  I (Mickaël) only added the following
> > > > > todo list and the "Changes since v11" sections in this commit message.
> > > > > I think this patch is good but it would appreciate reviews.
> > > > > You can find the diff of my changes here but it is not really readable:
> > > > > https://git.kernel.org/mic/c/78edf722fba5 (landlock-net-v11 branch)
> > > > > [1] https://lore.kernel.org/all/20230515161339.631577-11-konstantin.meskhidze@huawei.com/
> > > > > TODO:
> > > > > - Rename all "net_service" to "net_port".
> > > > > - Fix the two kernel bugs found with the new tests.
> > > > > - Update this commit message with a small description of all tests.
> > > > > [...]
> > 
> > > > > +FIXTURE(inet)
> > > > > +{
> > > > > +	struct service_fixture srv0, srv1;
> > > > > +};
> > > > > The "inet" variants are useless and should be removed. The
> > > "inet"
> > > > fixture can then be renamed to "ipv4_tcp".
> > > >   Maybe its better to name it "tcp". So we dont need to copy
> > > TEST_F(tcp,
> > > port_endianness) for ipv6 and ipv4.
> > > What do you think?
> > 
> > I don't see any need to test with IPv4 and IPv6, hence the "inet" name
> > (and without variants). You can rename it to "inet_tcp" to highlight the
> > specificities of this fixture.
> > 
> 
>  I think there was some misunderstanding from my side. So I will rename
> inet to inet_tcp and keep all fixture variants:
> 	- no_sandbox_with_ipv4.
> 	- sandbox_with_ipv4.
> 	- no_sandbox_with_ipv6.
> 	- sandbox_with_ipv6.
> Correct?

No, you just need to remove the FIXTURE_VARIANT and the four
FIXTURE_VARIANT_ADD blocks bellow.  And according to another reply,
"ipv4_tcp" seems more appropriate.


> > > > > > +
> > > > > +FIXTURE_VARIANT(inet)
> > > > > +{
> > > > > +	const bool is_sandboxed;
> > > > > +	const struct protocol_variant prot;
> > > > > +};
> > > > > +
> > > > > +/* clang-format off */
> > > > > +FIXTURE_VARIANT_ADD(inet, no_sandbox_with_ipv4) {
> > > > > +	/* clang-format on */
> > > > > +	.is_sandboxed = false,
> > > > > +	.prot = {
> > > > > +		.domain = AF_INET,
> > > > > +		.type = SOCK_STREAM,
> > > > > +	},
> > > > > +};
> > > > > +
> > > > > +/* clang-format off */
> > > > > +FIXTURE_VARIANT_ADD(inet, sandbox_with_ipv4) {
> > > > > +	/* clang-format on */
> > > > > +	.is_sandboxed = true,
> > > > > +	.prot = {
> > > > > +		.domain = AF_INET,
> > > > > +		.type = SOCK_STREAM,
> > > > > +	},
> > > > > +};
> > > > > +
> > > > > +/* clang-format off */
> > > > > +FIXTURE_VARIANT_ADD(inet, no_sandbox_with_ipv6) {
> > > > > +	/* clang-format on */
> > > > > +	.is_sandboxed = false,
> > > > > +	.prot = {
> > > > > +		.domain = AF_INET6,
> > > > > +		.type = SOCK_STREAM,
> > > > > +	},
> > > > > +};
> > > > > +
> > > > > +/* clang-format off */
> > > > > +FIXTURE_VARIANT_ADD(inet, sandbox_with_ipv6) {
> > > > > +	/* clang-format on */
> > > > > +	.is_sandboxed = true,
> > > > > +	.prot = {
> > > > > +		.domain = AF_INET6,
> > > > > +		.type = SOCK_STREAM,
> > > > > +	},
> > > > > +};
> > > > > +
> > > > > +FIXTURE_SETUP(inet)
> > > > > +{
> > > > > +	const struct protocol_variant ipv4_tcp = {
> > > > > +		.domain = AF_INET,
> > > > > +		.type = SOCK_STREAM,
> > > > > +	};
> > > > > +
> > > > > +	disable_caps(_metadata);
> > > > > +
> > > > > +	ASSERT_EQ(0, set_service(&self->srv0, ipv4_tcp, 0));
> > > > > +	ASSERT_EQ(0, set_service(&self->srv1, ipv4_tcp, 1));
> > > > > +
> > > > > +	setup_loopback(_metadata);
> > > > > +};
> > > > > +
> > > > > +FIXTURE_TEARDOWN(inet)
> > > > > +{
> > > > > +}
> > > > > +
> > > > > +TEST_F(inet, port_endianness)
> > > > > +{
> > > > > +	const struct landlock_ruleset_attr ruleset_attr = {
> > > > > +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
> > > > > +				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
> > > > > +	};
> > > > > +	const struct landlock_net_service_attr bind_host_endian_p0 = {
> > > > > +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
> > > > > +		/* Host port format. */
> > > > > +		.port = self->srv0.port,
> > > > > +	};
> > > > > +	const struct landlock_net_service_attr connect_big_endian_p0 = {
> > > > > +		.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
> > > > > +		/* Big endian port format. */
> > > > > +		.port = htons(self->srv0.port),
> > > > > +	};
> > > > > +	const struct landlock_net_service_attr bind_connect_host_endian_p1 = {
> > > > > +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
> > > > > +				  LANDLOCK_ACCESS_NET_CONNECT_TCP,
> > > > > +		/* Host port format. */
> > > > > +		.port = self->srv1.port,
> > > > > +	};
> > > > > +	const unsigned int one = 1;
> > > > > +	const char little_endian = *(const char *)&one;
> > > > > +	int ruleset_fd;
> > > > > +
> > > > > +	ruleset_fd =
> > > > > +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> > > > > +	ASSERT_LE(0, ruleset_fd);
> > > > > +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_SERVICE,
> > > > > +				       &bind_host_endian_p0, 0));
> > > > > +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_SERVICE,
> > > > > +				       &connect_big_endian_p0, 0));
> > > > > +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_SERVICE,
> > > > > +				       &bind_connect_host_endian_p1, 0));
> > > > > +	enforce_ruleset(_metadata, ruleset_fd);
> > > > > +
> > > > > +	/* No restriction for big endinan CPU. */
> > > > > +	test_bind_and_connect(_metadata, &self->srv0, false, little_endian);
> > > > > +
> > > > > +	/* No restriction for any CPU. */
> > > > > +	test_bind_and_connect(_metadata, &self->srv1, false, false);
> > > > > +}
> > > > > +
> > > > > +TEST_HARNESS_MAIN
> > > > .
> > .
