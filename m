Return-Path: <linux-security-module+bounces-7254-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F119F9F7973
	for <lists+linux-security-module@lfdr.de>; Thu, 19 Dec 2024 11:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C54B16F857
	for <lists+linux-security-module@lfdr.de>; Thu, 19 Dec 2024 10:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35AD223323;
	Thu, 19 Dec 2024 10:20:37 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34005222D45;
	Thu, 19 Dec 2024 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603637; cv=none; b=THyxVhuqTLrC0i1tv4TMx7ARxPXkvsJx95Od/ezu+4Mx4KG/7i8Xi8QjLWOX/txfV+I8bohkOAO0xq6svM57D4AJ7SqQVGExVuJhZ/Elyn/2jHG1JPrvUwNrIRRGxcDpCaFQcwyYeyle00z9J/rEBliZRxo93tyxqM2ycRG1lk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603637; c=relaxed/simple;
	bh=bVAK5qqrzNv/+QX0XmTlgynG+PuvzBKkGTqdKXAMwC0=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fAetzd8Cx55JX5vPAjzUQZ2ntZxBZFmnDHTyX1zsiN1XfoQ7kfgXUdGAY8Bu+Wl+GQcSmBqh0wGHk4UaBugKawpIuJKbhjWmCqIpUOuFsU/VJEMZE4yT6VqFJScf2Z3c+7s+vjKXNdwX7RwUmM+PCGlu07TTGqSlraSQDswsyYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YDRMr3q9XzRjrm;
	Thu, 19 Dec 2024 18:18:32 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 39D8F1402E1;
	Thu, 19 Dec 2024 18:20:26 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Dec 2024 18:20:22 +0800
Subject: Re: [PATCH v3 -next 11/15] sunrpc: use vfs_pressure_ratio() helper
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>
References: <> <12ec5b63b17b360f2e249a4de0ac7b86e09851a3.camel@kernel.org>
 <172859659591.444407.1507982523726708908@noble.neil.brown.name>
 <b0cf00eec77014ad473d4510904eb2d4fd084e5a.camel@kernel.org>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <j.granados@samsung.com>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <linux-sh@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <dhowells@redhat.com>,
	<haifeng.xu@shopee.com>, <baolin.wang@linux.alibaba.com>,
	<shikemeng@huaweicloud.com>, <dchinner@redhat.com>, <bfoster@redhat.com>,
	<souravpanda@google.com>, <hannes@cmpxchg.org>, <rientjes@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<ying.huang@intel.com>, <yang@os.amperecomputing.com>,
	<zev@bewilderbeest.net>, <serge@hallyn.com>, <vegard.nossum@oracle.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
From: yukaixiong <yukaixiong@huawei.com>
Message-ID: <3efccfae-3f76-c99c-29f9-fdf5dd65894d@huawei.com>
Date: Thu, 19 Dec 2024 18:20:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b0cf00eec77014ad473d4510904eb2d4fd084e5a.camel@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml100004.china.huawei.com (7.185.36.247) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2024/10/11 20:38, Jeff Layton wrote:
> On Fri, 2024-10-11 at 08:43 +1100, NeilBrown wrote:
>> On Fri, 11 Oct 2024, Jeff Layton wrote:
>>> On Thu, 2024-10-10 at 23:22 +0800, Kaixiong Yu wrote:
>>>> Use vfs_pressure_ratio() to simplify code.
>>>>
>>>> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
>>>> Reviewed-by: Kees Cook <kees@kernel.org>
>>>> Acked-by: Anna Schumaker <anna.schumaker@oracle.com>
>>>> ---
>>>>   net/sunrpc/auth.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
>>>> index 04534ea537c8..3d2b51d7e934 100644
>>>> --- a/net/sunrpc/auth.c
>>>> +++ b/net/sunrpc/auth.c
>>>> @@ -489,7 +489,7 @@ static unsigned long
>>>>   rpcauth_cache_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>>>>   
>>>>   {
>>>> -	return number_cred_unused * sysctl_vfs_cache_pressure / 100;
>>>> +	return vfs_pressure_ratio(number_cred_unused);
>>>>   }
>>>>   
>>>>   static void
>>> Acked-by: Jeff Layton <jlayton@kernel.org>
>>>
>> I realise this is a bit of a tangent, and I'm not objecting to this
>> patch, but I wonder what the justification is for using
>> vfs_cache_pressure here.  The sysctl is documented as
>>
>>     This percentage value controls the tendency of the kernel to reclaim
>>     the memory which is used for caching of directory and inode objects.
>>
>> So it can sensibly be used for dentries and inode, and for anything
>> directly related like the nfs access cache (which is attached to inodes)
>> and the nfs xattr cache.
>>
>> But the sunrpc cred cache scales with the number of active users, not
>> the number of inodes/dentries.
>>
>> So I think this should simply "return number_cred_unused;".
>>
>> What do others think?
>>
>> NeilBrown
>>
> -----------------8<------------------
>   * @count_objects should return the number of freeable items in the cache. If
>   * there are no objects to free, it should return SHRINK_EMPTY, while 0 is
>   * returned in cases of the number of freeable items cannot be determined
>   * or shrinker should skip this cache for this time (e.g., their number
>   * is below shrinkable limit)...
> -----------------8<------------------
>
> number_cred_unused does sound like a better way to report this.
Thanks, I'll take NeilBrown's advice.


