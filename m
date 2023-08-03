Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062F076F625
	for <lists+linux-security-module@lfdr.de>; Fri,  4 Aug 2023 01:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjHCX1k (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 3 Aug 2023 19:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjHCX1i (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Aug 2023 19:27:38 -0400
Received: from out-68.mta0.migadu.com (out-68.mta0.migadu.com [IPv6:2001:41d0:1004:224b::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6528F1FF3
        for <linux-security-module@vger.kernel.org>; Thu,  3 Aug 2023 16:27:36 -0700 (PDT)
Message-ID: <f102f07f-63c3-bca0-47ea-e3ea4357cf1c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691105254; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBhJZPJqRLXX01E/GzXAnYcqSPb3bajdDFf4J1LeRdc=;
        b=oHoEDIxHyqkl0uC8DGaj/6q6TFEL6qT4+NB9Z63CtnWSp9hoxiXjB99juUj+LExQ69L3TW
        T1gAdbrpUJeXci4aC2qe3alqLVwqdT8AgTRcpKPEUGTKH8d9ZnLa1HmhiBOC4ovtaNpD4U
        5Lt9t5qegtuhhz8l7MXwnEeuCoaA7Hs=
Date:   Thu, 3 Aug 2023 16:27:18 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v9 3/4] selftests/bpf: Add two mptcp netns
 helpers
Content-Language: en-US
To:     Geliang Tang <geliang.tang@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Simon Horman <horms@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1691069778.git.geliang.tang@suse.com>
 <27d3ccd2d762023b4829ba54e16a3e11925ad75d.1691069778.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <27d3ccd2d762023b4829ba54e16a3e11925ad75d.1691069778.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 8/3/23 6:41 AM, Geliang Tang wrote:
> Add two netns helpers for mptcp tests: create_netns() and
> cleanup_netns(). Use them in test_base().
> 
> These new helpers will be re-used in the following commits introducing
> new tests.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Acked-by: Yonghong Song <yonghong.song@linux.dev>
