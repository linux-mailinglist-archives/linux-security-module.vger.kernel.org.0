Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E21B4C28AE
	for <lists+linux-security-module@lfdr.de>; Thu, 24 Feb 2022 10:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiBXJzo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 24 Feb 2022 04:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiBXJzm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Feb 2022 04:55:42 -0500
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2960285714
        for <linux-security-module@vger.kernel.org>; Thu, 24 Feb 2022 01:55:11 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K47Yn3hh5zMpylM;
        Thu, 24 Feb 2022 10:55:09 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4K47Yn0VmvzlhMCG;
        Thu, 24 Feb 2022 10:55:08 +0100 (CET)
Message-ID: <b29b2049-a61b-31a0-c4b5-fc0e55ad7bf1@digikod.net>
Date:   Thu, 24 Feb 2022 10:55:09 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter@vger.kernel.org, yusongping@huawei.com,
        artem.kuzin@huawei.com
References: <20220124080215.265538-1-konstantin.meskhidze@huawei.com>
 <20220124080215.265538-3-konstantin.meskhidze@huawei.com>
 <4d54e3a9-8a26-d393-3c81-b01389f76f09@digikod.net>
 <a95b208c-5377-cf5c-0b4d-ce6b4e4b1b05@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [RFC PATCH 2/2] landlock: selftests for bind and connect hooks
In-Reply-To: <a95b208c-5377-cf5c-0b4d-ce6b4e4b1b05@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 24/02/2022 04:18, Konstantin Meskhidze wrote:
> 
> 
> 2/1/2022 9:31 PM, Mickaël Salaün пишет:
>>
>> On 24/01/2022 09:02, Konstantin Meskhidze wrote:
>>> Support 4 tests for bind and connect networks actions:
>>
>> Good to see such tests!
>>
>>
>>> 1. bind() a socket with no landlock restrictions.
>>> 2. bind() sockets with landllock restrictions.
>>
>> You can leverage the FIXTURE_VARIANT helpers to factor out this kind 
>> of tests (see ptrace_test.c).
>>
>>
>>> 3. connect() a socket to listening one with no landlock restricitons.
>>> 4. connect() sockets with landlock restrictions.
>>
>> Same here, you can factor out code. I guess you could create helpers 
>> for client and server parts.
>>
>> We also need to test with IPv4, IPv6 and the AF_UNSPEC tricks.
>>
>> Please provide the kernel test coverage and explain why the uncovered 
>> code cannot be covered: 
>> https://www.kernel.org/doc/html/latest/dev-tools/gcov.html
> 
>   Hi Mickaёl!
>   Could you please provide the example of your test coverage build
>   process? Cause as I undersatand there is no need to get coverage data
>   for the entire kernel, just for landlock files.

You just need to follow the documentation:
- start the VM with the kernel appropriately configured for coverage;
- run all the Landlock tests;
- gather the coverage and shutdown the VM;
- use lcov and genhtml to create the web pages;
- look at the coverage for security/landlock/

>>
>> You'll probably see that there are a multiple parts of the kernel that 
>> are not covered. For instance, it is important to test different 
>> combinations of layered network rules (see layout1/ruleset_overlap, 
>> layer_rule_unions, non_overlapping_accesses, 
>> interleaved_masked_accesses… in fs_test.c). Tests in fs_test.c are 
>> more complex because handling file system rules is more complex, but 
>> you can get some inspiration in it, especially the edge cases.
>>
>> We also need to test invalid user space supplied data (see 
>> layout1/inval test in fs_test.c).
