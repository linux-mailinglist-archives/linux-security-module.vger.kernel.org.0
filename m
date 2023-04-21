Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0A96EA558
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Apr 2023 09:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjDUHy5 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Apr 2023 03:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjDUHyi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Apr 2023 03:54:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41119768;
        Fri, 21 Apr 2023 00:54:26 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2mtp6RJqz6J70q;
        Fri, 21 Apr 2023 15:51:30 +0800 (CST)
Received: from [10.123.123.126] (10.123.123.126) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 08:54:21 +0100
Message-ID: <7e14e18e-a9dd-b9e6-6d97-124d587599f3@huawei.com>
Date:   Fri, 21 Apr 2023 10:54:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v10 02/13] landlock: Allow filesystem layout changes for
 domains without such rule type
Content-Language: ru
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
CC:     <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
        <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>
References: <20230323085226.1432550-1-konstantin.meskhidze@huawei.com>
 <20230323085226.1432550-3-konstantin.meskhidze@huawei.com>
 <062447d5-bd64-f58e-9476-0d2d2034f333@digikod.net>
 <3dd0376c-2835-d1c0-60a9-79d1d22a4d3f@huawei.com>
 <17ddf6a0-79d1-b493-0432-c8e84593b165@digikod.net>
From:   "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <17ddf6a0-79d1-b493-0432-c8e84593b165@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.123.126]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



4/20/2023 8:32 PM, Mickaël Salaün пишет:
> 
> On 20/04/2023 13:42, Konstantin Meskhidze (A) wrote:
>> 
>> 
>> 4/16/2023 7:09 PM, Mickaël Salaün пишет:
>>>
>>> On 23/03/2023 09:52, Konstantin Meskhidze wrote:
>>>> From: Mickaël Salaün <mic@digikod.net>
>>>>
>>>> Allow mount point and root directory changes when there is no filesystem
>>>> rule tied to the current Landlock domain.  This doesn't change anything
>>>> for now because a domain must have at least a (filesystem) rule, but
>>>> this will change when other rule types will come.  For instance, a
>>>> domain only restricting the network should have no impact on filesystem
>>>> restrictions.
>>>>
>>>> Add a new get_current_fs_domain() helper to quickly check filesystem
>>>> rule existence for all filesystem LSM hooks.
>>>>
>>>> Remove unnecessary inlining.
>>>>
>>>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>>>> ---
>>>>
>>>> Changes since v9:
>>>> * Refactors documentaion landlock.rst.
>>>> * Changes ACCESS_FS_INITIALLY_DENIED constant
>>>> to LANDLOCK_ACCESS_FS_INITIALLY_DENIED.
>>>> * Gets rid of unnecessary masking of access_dom in
>>>> get_raw_handled_fs_accesses() function.
>>>>
>>>> Changes since v8:
>>>> * Refactors get_handled_fs_accesses().
>>>> * Adds landlock_get_raw_fs_access_mask() helper.
>>>>
>>>> ---
>>>>    Documentation/userspace-api/landlock.rst |  6 +-
>>>>    security/landlock/fs.c                   | 78 ++++++++++++------------
>>>>    security/landlock/ruleset.h              | 25 +++++++-
>>>>    security/landlock/syscalls.c             |  6 +-
>>>>    4 files changed, 68 insertions(+), 47 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
>>>> index 71aca7f990bc..d35cd5d304db 100644
>>>> --- a/security/landlock/syscalls.c
>>>> +++ b/security/landlock/syscalls.c
>>>> @@ -310,6 +310,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>>>>    	struct path path;
>>>>    	struct landlock_ruleset *ruleset;
>>>>    	int res, err;
>>>> +	access_mask_t mask;
>>>>
>>>>    	if (!landlock_initialized)
>>>>    		return -EOPNOTSUPP;
>>>> @@ -348,9 +349,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>>>>    	 * Checks that allowed_access matches the @ruleset constraints
>>>>    	 * (ruleset->access_masks[0] is automatically upgraded to 64-bits).
>>>>    	 */
>>>> -	if ((path_beneath_attr.allowed_access |
>>>> -	     landlock_get_fs_access_mask(ruleset, 0)) !=
>>>> -	    landlock_get_fs_access_mask(ruleset, 0)) {
>>>> +	mask = landlock_get_raw_fs_access_mask(ruleset, 0);
>>>> +	if ((path_beneath_attr.allowed_access | mask) != mask) {
>>>
>>> This hunk can be moved to the previous patch (i.e. mask = …). This patch
>>> should only contains the new landlock_get_raw_fs_access_mask() call.
>>>
>> 
>>    Sorry. Did not get this tip. Please can you explain what do you mean here?
> 
> You can squash this part in the previous patch:
> 
> -	if ((path_beneath_attr.allowed_access |
> -	     landlock_get_fs_access_mask(ruleset, 0)) !=
> -	    landlock_get_fs_access_mask(ruleset, 0)) {
> +	mask = landlock_get_fs_access_mask(ruleset, 0);
> +	if ((path_beneath_attr.allowed_access | mask) != mask) {

   Ok. Thanks.
> 
> And this patch will then only include this part:
> 
> -	mask = landlock_get_fs_access_mask(ruleset, 0);
> +	mask = landlock_get_raw_fs_access_mask(ruleset, 0);
> 
   Got it.
> 
>>>
>>>>    		err = -EINVAL;
>>>>    		goto out_put_ruleset;
>>>>    	}
>>>> --
>>>> 2.25.1
>>>>
>>> .
> .
