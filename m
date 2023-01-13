Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D2F66A1D7
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Jan 2023 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjAMSTh (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 13 Jan 2023 13:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjAMSTE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Jan 2023 13:19:04 -0500
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5D96ADA2
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jan 2023 10:12:12 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NtqJC0BNtzMr2j4;
        Fri, 13 Jan 2023 19:12:11 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NtqJB1mfjzMq1Vh;
        Fri, 13 Jan 2023 19:12:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1673633530;
        bh=78h8J/XWCqm4EH36UJggpjKH/WjLswvynrY/lrlSxBw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j4PFZJaeRm5mab6izHvuQLqf404G+Da82YltwHaiPAJ/S7l2bEVDUfzVga080rPgk
         lDMwEh/ZLxCVizJgrjtxfqcQ9nhseiR4hAKJ2L1AswQDMPzWwIAS/e3kdN3IjWKjNA
         Wchm8JuTgzgUkg9SnkWaWuH02b7Onxpx3ikT3uKM=
Message-ID: <2985dea2-e9ac-2416-3065-0713723f6280@digikod.net>
Date:   Fri, 13 Jan 2023 19:12:09 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH] selftests/landlock: Improve ptrace_test with Yama
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>
Cc:     gnoack@google.com, groeck@chromium.org, jorgelo@chromium.org,
        keescook@chromium.org, linux-security-module@vger.kernel.org
References: <20230113050755.1277736-2-jeffxu@google.com>
 <20230113175308.50900-1-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230113175308.50900-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 13/01/2023 18:53, Mickaël Salaün wrote:
> I found some issues running this new ptrace_test. Indeed, Yama doesn't
> restrict PTRACE_MODE_READ whereas Landlock does. I also changed some
> comments and socpe conditions. In fact, the final SKIP() wasn't a good
> idea because it masks such potential errors; let's only use a log
> message instead. I also removed the first SKIP() because we want
> everything to be tested, and the MODE_READ does still matter anyway.
> 
> Please review this patch and squash it in yours.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20230113175308.50900-1-mic@digikod.net
> ---
>   .../testing/selftests/landlock/ptrace_test.c  | 106 ++++++++++--------
>   1 file changed, 57 insertions(+), 49 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index c9d9f3001d0f..3c3ba37bf8ec 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -19,7 +19,7 @@
>   
>   #include "common.h"
>   
> -/* copy from yama_lsm.c */
> +/* Copied from security/yama/yama_lsm.c */
>   #define YAMA_SCOPE_DISABLED 0
>   #define YAMA_SCOPE_RELATIONAL 1
>   #define YAMA_SCOPE_CAPABILITY 2
> @@ -70,7 +70,7 @@ static int get_yama_ptrace_scope(void)
>   {
>   	int ret;
>   	char buf[2] = {};
> -	int fd = open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
> +	const int fd = open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
>   
>   	if (fd < 0)
>   		return 0;
> @@ -260,46 +260,48 @@ TEST_F(hierarchy, trace)
>   	int yama_ptrace_scope;
>   	char buf_parent;
>   	long ret;
> -	bool can_trace_child, can_trace_parent;
> +	bool can_read_child, can_trace_child, can_read_parent, can_trace_parent;
>   
>   	yama_ptrace_scope = get_yama_ptrace_scope();
>   	ASSERT_LE(0, yama_ptrace_scope);
>   
> -	if (yama_ptrace_scope >= YAMA_SCOPE_NO_ATTACH)
> -		SKIP(return, "Yama forbids any ptrace use (scope %d)",
> -			   yama_ptrace_scope);
> +	if (yama_ptrace_scope > YAMA_SCOPE_DISABLED)
> +		TH_LOG("Incomplete tests due to Yama restrictions (scope %d)",
> +		       yama_ptrace_scope);
>   
>   	/*
> -	 * can_trace_child: if a parent process can trace its child process.
> -	 *
> -	 * There are two conditions concerning landlock:
> -	 * 1> the parent and child processes are in the same landlock domain or
> -	 *	one beneath it (case: domain_both = true).
> -	 * 2> yama allows tracing children (up to YAMA_SCOPE_RELATIONAL).
> -	 * Both 1 and 2 need to be met for can_trace_child to be true.
> -	 *
> -	 * If a parent process has its own domain not shared with the child
> -	 * process (case:domain_parent = true), then the parent can't trace the
> -	 * child.
> +	 * can_read_child is true if a parent process can read its child
> +	 * process, which is only the case when the parent process is not
> +	 * isolated from the child with a dedicated Landlock domain.
>   	 */
> -	can_trace_child = !variant->domain_parent &&
> -			  yama_ptrace_scope < YAMA_SCOPE_CAPABILITY;
> +	can_read_child = !variant->domain_parent;
>   
>   	/*
> -	 * can_trace_parent: if a child process can trace its parent process.
> -	 *
> -	 * There are two conditions concerning landlock:
> -	 * 1> the parent and child process are in the same landlock domain or
> -	 *	one beneath it.(case: domain_both = true).
> -	 * 2> yama is disabled (YAMA_SCOPE_DISABLED).
> -	 * Both 1 and 2 need to be met for can_trace_parent to be true.
> -	 *
> -	 * If a child process has its own domain not shared with the parent
> -	 * process (case:domain_child = true, then the child can't trace the
> -	 * parent.
> +	 * can_trace_child is true if a parent process can trace its child
> +	 * process.  This depends on two conditions:
> +	 * - The parent process is not isolated from the child with a dedicated
> +	 *   Landlock domain.
> +	 * - Yama allows tracing children (up to YAMA_SCOPE_RELATIONAL).
>   	 */
> -	can_trace_parent = !variant->domain_child &&
> -			   yama_ptrace_scope < YAMA_SCOPE_RELATIONAL;
> +	can_trace_child = can_read_child &&
> +			  yama_ptrace_scope <= YAMA_SCOPE_RELATIONAL;
> +
> +	/*
> +	 * can_read_parent is true if a child process can read its parent
> +	 * process, which is only the case when the child process is not
> +	 * isolated from the parent with a dedicated Landlock domain.
> +	 */
> +	can_read_parent = !variant->domain_child;
> +
> +	/*
> +	 * can_trace_parent is true if a child process can trace its parent
> +	 * process.  This depends on two conditions:
> +	 * - The child process is not isolated from the parent with a dedicated
> +	 *   Landlock domain.
> +	 * - Yama is disabled (YAMA_SCOPE_DISABLED).
> +	 */
> +	can_trace_parent = can_read_parent &&
> +			   yama_ptrace_scope <= YAMA_SCOPE_DISABLED;
>   
>   	/*
>   	 * Removes all effective and permitted capabilities to not interfere
> @@ -330,16 +332,21 @@ TEST_F(hierarchy, trace)
>   		/* Waits for the parent to be in a domain, if any. */
>   		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
>   
> -		/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
> +		/* Tests PTRACE_MODE_READ on the parent. */
>   		err_proc_read = test_ptrace_read(parent);
> +		if (can_read_parent) {
> +			EXPECT_EQ(0, err_proc_read);
> +		} else {
> +			EXPECT_EQ(EACCES, err_proc_read);
> +		}
> +
> +		/* Tests PTRACE_ATTACH on the parent. */
>   		ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
> -		if (!can_trace_parent) {
> +		if (can_trace_parent) {
> +			EXPECT_EQ(0, ret);
> +		} else {
>   			EXPECT_EQ(-1, ret);
>   			EXPECT_EQ(EPERM, errno);
> -			EXPECT_EQ(EACCES, err_proc_read);
> -		} else {
> -			EXPECT_EQ(0, ret);
> -			EXPECT_EQ(0, err_proc_read);
>   		}
>   		if (ret == 0) {
>   			ASSERT_EQ(parent, waitpid(parent, &status, 0));
> @@ -349,11 +356,11 @@ TEST_F(hierarchy, trace)
>   
>   		/* Tests child PTRACE_TRACEME. */
>   		ret = ptrace(PTRACE_TRACEME);
> -		if (!can_trace_child) {
> +		if (can_trace_child) {
> +			EXPECT_EQ(0, ret);
> +		} else {
>   			EXPECT_EQ(-1, ret);
>   			EXPECT_EQ(EPERM, errno);
> -		} else {
> -			EXPECT_EQ(0, ret);
>   		}
>   
>   		/*
> @@ -396,17 +403,23 @@ TEST_F(hierarchy, trace)
>   		EXPECT_EQ(ESRCH, errno);
>   	}
>   
> -	/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. */
> +	/* Tests PTRACE_MODE_READ on the child. */
>   	err_proc_read = test_ptrace_read(child);
> +	if (can_read_child) {
> +		EXPECT_EQ(0, err_proc_read);
> +	} else {
> +		EXPECT_EQ(EACCES, err_proc_read);
> +	}
> +
> +	/* Tests PTRACE_ATTACH on the child. */
>   	ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
>   	if (!can_trace_child) {

I forgot to inverse the !can_trace_child condition to make it more 
consistent with the rest. Please update it for your next patch.


>   		EXPECT_EQ(-1, ret);
>   		EXPECT_EQ(EPERM, errno);
> -		EXPECT_EQ(EACCES, err_proc_read);
>   	} else {
>   		EXPECT_EQ(0, ret);
> -		EXPECT_EQ(0, err_proc_read);
>   	}
> +
>   	if (ret == 0) {
>   		ASSERT_EQ(child, waitpid(child, &status, 0));
>   		ASSERT_EQ(1, WIFSTOPPED(status));
> @@ -419,11 +432,6 @@ TEST_F(hierarchy, trace)
>   	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
>   	    WEXITSTATUS(status) != EXIT_SUCCESS)
>   		_metadata->passed = 0;
> -
> -	if (yama_ptrace_scope > 0)
> -		SKIP(return,
> -			   "Incomplete tests due to Yama restrictions (scope %d)",
> -			   yama_ptrace_scope);
>   }
>   
>   TEST_HARNESS_MAIN
