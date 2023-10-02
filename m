Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C357B5C05
	for <lists+linux-security-module@lfdr.de>; Mon,  2 Oct 2023 22:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbjJBU1E (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 2 Oct 2023 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJBU1D (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Oct 2023 16:27:03 -0400
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C6EB8
        for <linux-security-module@vger.kernel.org>; Mon,  2 Oct 2023 13:26:59 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Rzstn6xRTzMpnqQ;
        Mon,  2 Oct 2023 20:26:57 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Rzstn4QlCz1Jm;
        Mon,  2 Oct 2023 22:26:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1696278417;
        bh=RzP6rUMZRwJXcm9nbI9v+6nmC1mwKqcqVRxqX6fvfPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XH0yBUUeoFP6breSuPJWxxybKwF58111DYqF3DcRJ+xUIkSfiwtDIl2cR5Howxwzz
         Mbn9w0t7D3DNF0feXSJyrIFEnW/vtAcwYtJJq9vHWGLo6t6/0l7xw7+oA5SeFAmGs5
         1h0vBXnihXLDBVHuhLMVA+4pZTaDjYW7AZnxLKXs=
Date:   Mon, 2 Oct 2023 22:26:57 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yusongping@huawei.com,
        artem.kuzin@huawei.com
Subject: Re: [PATCH v12 09/12] selftests/landlock: Share enforce_ruleset()
Message-ID: <20231001.Aiv7Chaedei0@digikod.net>
References: <20230920092641.832134-1-konstantin.meskhidze@huawei.com>
 <20230920092641.832134-10-konstantin.meskhidze@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920092641.832134-10-konstantin.meskhidze@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 20, 2023 at 05:26:37PM +0800, Konstantin Meskhidze wrote:
> This commit moves enforce_ruleset() helper function to common.h so that
> it can be used both by filesystem tests and network ones.
> 
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---
> 
> Changes since v11:
> * None.
> 

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 251594306d40..7c94d3933b68 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -677,17 +677,7 @@ static int create_ruleset(struct __test_metadata *const _metadata,
>  	return ruleset_fd;
>  }
> 
> -static void enforce_ruleset(struct __test_metadata *const _metadata,
> -			    const int ruleset_fd)
> -{
> -	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> -	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0))
> -	{
> -		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
> -	}
> -}
> -
> -TEST_F_FORK(layout0, proc_nsfs)
> +TEST_F_FORK(layout1, proc_nsfs)

Why this change?

>  {
>  	const struct rule rules[] = {
>  		{
> --
> 2.25.1
> 
