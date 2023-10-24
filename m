Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2E7D4680
	for <lists+linux-security-module@lfdr.de>; Tue, 24 Oct 2023 05:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjJXDya (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 23 Oct 2023 23:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjJXDxn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Oct 2023 23:53:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A34172A
        for <linux-security-module@vger.kernel.org>; Mon, 23 Oct 2023 20:52:38 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77896da2118so263552785a.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Oct 2023 20:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698119558; x=1698724358; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XsaNGjlcimJtQjiAwAEMf2P9+0lBW+WKE/hjZAD7dek=;
        b=ZzJPx0y19ajQdpatRHIV9OeYbUZdaaBZFXCshlqwJCZYO2u3kgFCbgta/xGM2jnj2p
         8+kCX5JTZZ1VehON7byPvfJ5U6/lZGLLV2HrO7ImJwWRGysVUGepVz4oGfXDSxWpS01H
         llWr0/T3mPVztmuSNR7LotGveoiuz5fcXyqySGe9L3uM8KoTajs1X9PyyL0LMbDIr0zz
         wU8i7Zkr8+w0f9km6wDCmpyvw8I6jpaFQ46JySPHx7VHXazCIRGoGTUGtkcUXyKSOFyy
         w/aOFa8b5S0U1O6CjzMwBBUajPeEcD5Cat7S04a9vo3XlUfv/5SiVcqa5keww9C74lKY
         DXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698119558; x=1698724358;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsaNGjlcimJtQjiAwAEMf2P9+0lBW+WKE/hjZAD7dek=;
        b=Y6aEcr6TNht6a/3GSR0JbXxgMuBOAXoIWD/H7BPlHQdajl8ejv1NGdSMFpo+ZgCL53
         qZj3pkhtCPrK9sJklpRV/dTPsFPVpQsozXq26MfHwMfi2hASUbsSC561zLUBvSUphP1H
         7IWkDNRUqeI1LZW9EaIMtJtWjgLS6TvL618cFv7tfIWUpgw6O0+FxJS+FWF2fJVNkFvo
         tlNvQv4v+Pq/AMw7ws73gdNT6o5d1jXN5618Ctt3rgf2TCA6GDKVDdOTFIZKQiX2uBN0
         6TIS9zJ9I+Jpd1dR0Jq/fNx0RTM/FWg53pyLLofyh5hrlBHIzKd9QrsHUyijLFA3dLq1
         Ml4A==
X-Gm-Message-State: AOJu0YxWSr/bRIMMabiormtzornC4aItiVHm7d5VTjSCbbXquA8k7L5Q
        2WkHXvlYgpcHo47vGKk7ztFl
X-Google-Smtp-Source: AGHT+IFgtMi4EqN6N9ZtnfOHbANV4Egy0LBPK5cs6vsX4rIphs5HUZhBFo1nSJ25zSqGEggCASqLKw==
X-Received: by 2002:a05:620a:430d:b0:778:8dc1:bb7b with SMTP id u13-20020a05620a430d00b007788dc1bb7bmr13244374qko.27.1698119557740;
        Mon, 23 Oct 2023 20:52:37 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id s4-20020ad45004000000b0063f88855ef2sm3286811qvo.101.2023.10.23.20.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 20:52:37 -0700 (PDT)
Date:   Mon, 23 Oct 2023 23:52:36 -0400
Message-ID: <88259677752389b350614857e6003b8c.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk,
        agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, audit@vger.kernel.org,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH RFC v11 18/19] ipe: kunit test for parser
References: <1696457386-3010-19-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1696457386-3010-19-git-send-email-wufan@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Oct  4, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> Add various happy/unhappy unit tests for both IPE's parser.

I'm going to suggest: "... for IPE's policy parser."

Also, aside from the policy parser tests, are there any other IPE
functional tests?  We do have a testing guideline for new LSM
submissions:

 "New LSMs must be accompanied by a test suite to verify basic
  functionality and help identify regressions. The test suite
  must be publicly available without download restrictions
  requiring accounts, subscriptions, etc. Test coverage does
  not need to reach a specific percentage, but core functionality
  and any user interfaces should be well covered by the test
  suite. Maintaining the test suite in a public git repository is
  preferable over tarball snapshots. Integrating the test suite
  with existing automated Linux kernel testing services is
  encouraged."

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-guidelines

> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v1-v6:
>   + Not present
> 
> v7:
>   Introduced
> 
> v8:
>   + Remove the kunit tests with respect to the fsverity digest, as these
>     require significant changes to work with the new method of acquiring
>     the digest at runtime.
> 
> v9:
>   + Remove the kunit tests related to ipe_context
> 
> v10:
>   + No changes
> 
> v11:
>   + No changes
> ---
>  security/ipe/Kconfig        |  17 +++
>  security/ipe/Makefile       |   3 +
>  security/ipe/policy_tests.c | 294 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 314 insertions(+)
>  create mode 100644 security/ipe/policy_tests.c

--
paul-moore.com
