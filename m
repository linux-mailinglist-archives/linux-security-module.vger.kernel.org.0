Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C706B67B89A
	for <lists+linux-security-module@lfdr.de>; Wed, 25 Jan 2023 18:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjAYRbY (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 25 Jan 2023 12:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbjAYRbU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Jan 2023 12:31:20 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E543A870;
        Wed, 25 Jan 2023 09:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674667873; x=1706203873;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b/qAzqJTvFy4xiZPmOAm7JkVbr9jZZbEQu9s5cua2Is=;
  b=AWcklGPuXD/+9cf1Hhwl+Js//5W4kdegH/s0Gsfid2lOqlLRlb+x3I2W
   +pbkW5XILBBx4R1+PNuSE8oRW4FgaWulShnBLOkKWlS+uhbh0zDiFg18b
   B0HjcV5HkJ4l49rkjRSObzCRk/cdHpbAxDpFpDh9wOMFKiS95tbPYl1Kq
   Ot2LLUNYqUoPmFYD48gejB0bRZ7kz1QxWT4du2BC+j37+/OrVu5C1QCzU
   vGmNQIWiZblHr58LJMtiiQZtjmG4bpn6uWsBsR9DRE/KcVtOiJMs/A0FN
   nj/2SCV6VpRy4QFDaAIqFZ5mJzJilrDWScKgr3pC/WGhkgPoafYyLKp3x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="310194555"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="310194555"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 09:30:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="805079453"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="805079453"
Received: from dodonnel-mobl.ger.corp.intel.com (HELO [10.213.233.83]) ([10.213.233.83])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 09:30:45 -0800
Message-ID: <347560bc-d06a-92b7-8003-133d2b8af2df@linux.intel.com>
Date:   Wed, 25 Jan 2023 17:30:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/4] memcg: Track exported dma-buffers
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>
Cc:     linux-doc@vger.kernel.org, daniel.vetter@ffwll.ch,
        Roman Gushchin <roman.gushchin@linux.dev>, cmllamas@google.com,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        jstultz@google.com, Zefan Li <lizefan.x@bytedance.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, android-mm@google.com,
        Jonathan Corbet <corbet@lwn.net>, jeffv@google.com,
        linux-media@vger.kernel.org, selinux@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        "T.J. Mercier" <tjmercier@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230123191728.2928839-1-tjmercier@google.com>
 <20230123191728.2928839-2-tjmercier@google.com>
 <Y8/ybgp2FW+e3bjc@dhcp22.suse.cz>
 <20230124194628.d44rtcfsv23fndxw@google.com>
 <Y9EX+usSpAjZ/8LS@dhcp22.suse.cz>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <Y9EX+usSpAjZ/8LS@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Hi,

On 25/01/2023 11:52, Michal Hocko wrote:
> On Tue 24-01-23 19:46:28, Shakeel Butt wrote:
>> On Tue, Jan 24, 2023 at 03:59:58PM +0100, Michal Hocko wrote:
>>> On Mon 23-01-23 19:17:23, T.J. Mercier wrote:
>>>> When a buffer is exported to userspace, use memcg to attribute the
>>>> buffer to the allocating cgroup until all buffer references are
>>>> released.
>>>
>>> Is there any reason why this memory cannot be charged during the
>>> allocation (__GFP_ACCOUNT used)?
>>> Also you do charge and account the memory but underlying pages do not
>>> know about their memcg (this is normally done with commit_charge for
>>> user mapped pages). This would become a problem if the memory is
>>> migrated for example.
>>
>> I don't think this is movable memory.
>>
>>> This also means that you have to maintain memcg
>>> reference outside of the memcg proper which is not really nice either.
>>> This mimicks tcp kmem limit implementation which I really have to say I
>>> am not a great fan of and this pattern shouldn't be coppied.
>>>
>>
>> I think we should keep the discussion on technical merits instead of
>> personal perference. To me using skmem like interface is totally fine
>> but the pros/cons need to be very explicit and the clear reasons to
>> select that option should be included.
> 
> I do agree with that. I didn't want sound to be personal wrt tcp kmem
> accounting but the overall code maintenance cost is higher because
> of how tcp take on accounting differs from anything else in the memcg
> proper. I would prefer to not grow another example like that.
> 
>> To me there are two options:
>>
>> 1. Using skmem like interface as this patch series:
>>
>> The main pros of this option is that it is very simple. Let me list down
>> the cons of this approach:
>>
>> a. There is time window between the actual memory allocation/free and
>> the charge and uncharge and [un]charge happen when the whole memory is
>> allocated or freed. I think for the charge path that might not be a big
>> issue but on the uncharge, this can cause issues. The application and
>> the potential shrinkers have freed some of this dmabuf memory but until
>> the whole dmabuf is freed, the memcg uncharge will not happen. This can
>> consequences on reclaim and oom behavior of the application.
>>
>> b. Due to the usage model i.e. a central daemon allocating the dmabuf
>> memory upfront, there is a requirement to have a memcg charge transfer
>> functionality to transfer the charge from the central daemon to the
>> client applications. This does introduce complexity and avenues of weird
>> reclaim and oom behavior.
>>
>>
>> 2. Allocate and charge the memory on page fault by actual user
>>
>> In this approach, the memory is not allocated upfront by the central
>> daemon but rather on the page fault by the client application and the
>> memcg charge happen at the same time.
>>
>> The only cons I can think of is this approach is more involved and may
>> need some clever tricks to track the page on the free patch i.e. we to
>> decrement the dmabuf memcg stat on free path. Maybe a page flag.
>>
>> The pros of this approach is there is no need have a charge transfer
>> functionality and the charge/uncharge being closely tied to the actual
>> memory allocation and free.
>>
>> Personally I would prefer the second approach but I don't want to just
>> block this work if the dmabuf folks are ok with the cons mentioned of
>> the first approach.
> 
> I am not familiar with dmabuf internals to judge complexity on their end
> but I fully agree that charge-when-used is much more easier to reason
> about and it should have less subtle surprises.

Disclaimer that I don't seem to see patches 3&4 on dri-devel so maybe I 
am missing something, but in principle yes, I agree that the 2nd option 
(charge the user, not exporter) should be preferred. Thing being that at 
export time there may not be any backing store allocated, plus if the 
series is restricting the charge transfer to just Android clients then 
it seems it has the potential to miss many other use cases. At least 
needs to outline a description on how the feature will be useful outside 
Android.

Also stepping back for a moment - is a new memory category really 
needed, versus perhaps attempting to charge the actual backing store 
memory to the correct client? (There might have been many past 
discussions on this so it's okay to point me towards something in the 
archives.)

Regards,

Tvrtko
