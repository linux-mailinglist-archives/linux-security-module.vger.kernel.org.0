Return-Path: <linux-security-module+bounces-10292-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AC6ACAEF9
	for <lists+linux-security-module@lfdr.de>; Mon,  2 Jun 2025 15:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEB87A1C18
	for <lists+linux-security-module@lfdr.de>; Mon,  2 Jun 2025 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5963B213E69;
	Mon,  2 Jun 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="GeRAXIsA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L3slfywE"
X-Original-To: linux-security-module@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047862C3240
	for <linux-security-module@vger.kernel.org>; Mon,  2 Jun 2025 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870811; cv=none; b=eQBlU88lkHWdz0lFJ5MlMxq/xieZ+/WCiR72ruaelaGQqMJqV/8tD1WeHq8BH57Q6IdgiFvy0SHzYbi79SghSndLteUVc5afTzetbiwp9KjIT3rl/7KBe/zp88YVmZZaN5SvWPTv9o8mZ609fPiJmrFwVN+9Zp5SDirQpstAilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870811; c=relaxed/simple;
	bh=fkOdmAHrvg2cTXiEjx7jlfgo1e38QLix1i54ZnBqHpE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Oz8RIRZ5BNipTgRLJl0SrmpLNSifNWQ/TgEmu1OCrcHneC8JKTHnV7RmOOBAEwGi+zOoemxGgQTTRU+oZ2G1hQfiNQNoA1L/LEg6052nSTGOLYqrkr2pcoKDGBNmrXtdcncZk+4D3MWyMxbC1DkltjpxTOv0CIChWmIS2NYTMjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=GeRAXIsA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L3slfywE; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 125B711401C6;
	Mon,  2 Jun 2025 09:26:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 02 Jun 2025 09:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748870808;
	 x=1748957208; bh=nlPA5+DCL+mFeBZBcrQZy2m5mXqGkWNSk2/KLvDUbq8=; b=
	GeRAXIsAPawASDJg0NqJ0QAwBKB4I4pM4so9d9UVR5YgGlZpcGR3dupb/kmk2mCJ
	rzLHNX+UJAKOc29aiS2PRCSFkCyZiX6SS/ld3fz4NzzNb3AlCWRf2p//o2AzBd+E
	rmjsGpeOFsl57Z/iuN9nN4akyBFVCXxFud26E6xPMh3ERx8fqPQjUk+Qm5xFQpk2
	9LAHjH3P/WIWIQtlQKsVYstIy6XzbpCB/j1QrzcfE/BMTxp27eNwxUHD4Igmduav
	Q28rkMtLpe4jC9QtP1xNlZJPnoSHUYkD0BbFKUf4YUieSkKwnqBUNPvW60/s3jmC
	t4zOjylbDaHhHhcEyfwkyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748870808; x=
	1748957208; bh=nlPA5+DCL+mFeBZBcrQZy2m5mXqGkWNSk2/KLvDUbq8=; b=L
	3slfywEDBtsi57U2KsRphVhXEsaatbGPruqDT5/gEeIOckWsNHUoZZziNi52OHnZ
	aRf1h0Z+wto2WDDD/YSQBAFeuVqDV8KfBEbBXRqxxLN9ZTghSF8bbEWW3a1pHPsb
	l+UBYjyPn7jYqJfSge4VOphwSKQDwSxkTnXVxCYFDv2hPt+fVhnp/jcD4sDzIKE4
	CHBdM1fiR5I8wgTg8cg2Lu4EryakVFOwEg2duqwFM6lHY6oA18PmuV6bIH79ggl5
	Pzt2vKy2a5I1I1jQlt9K/xoHRT62GLR2bMgRX+4G/p4kXVuZjpbk792JJnm+itr6
	g/lnGdphc5Fzk2rxUb5ug==
X-ME-Sender: <xms:l6Y9aJhMnIUK1GUMhGpV10VkYmPktREltY_fmkYf4A5pAOp0f8aFyg>
    <xme:l6Y9aOBIcwSg9bwwNeWfijsC5pVLn32byfqJCJYDQ1s5LnSChTRQGdZ_pv1jlc_-b
    _lOaH8Q4qNiaxUb6zY>
X-ME-Received: <xmr:l6Y9aJGfb942bgzLafPOARjECFpLABBElA7XcaG_NRMdhsiiPfcUWMi02d81u6fO3GPRpa0DTDNcm_l9-PFrL9G9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeejkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuhffv
    vehfjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomh
    esmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeevueejgfehgfevgeejkeei
    leffvefgveeiveelvdefjedugeekgeffhfekffelveenucffohhmrghinhepghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohep
    ghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuh
    hrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ihhvrghnohhvrdhmihhkhhgrihhludeshhhurgifvghiqdhprghrthhnvghrshdrtghomh
    dprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:l6Y9aOSichtItEXUnIARESokpFROwsS6iDA1pUnnM4rX38Yqh0nLaw>
    <xmx:l6Y9aGz3m8wfLhl61M6bI1NxS0FfvWCQJuvX8LF7uL0EkABDGoDAtQ>
    <xmx:l6Y9aE79KX8THNAejR8Jj6lstShgTUqpcUI0bMHIt2PnmpSYXqstcQ>
    <xmx:l6Y9aLx_-ngrE-0DTBQF6z0hzlMsVibc_rdl-yl75Z-pXGjU0RBtaw>
    <xmx:mKY9aBOrzC6iFkeHprZcG0e0VxFgrppWhavqnkFMOxeQ8E8Sm9zV5Ak3>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 09:26:44 -0400 (EDT)
Message-ID: <119f5d1f-448c-4378-b8eb-ae4a00f16e4b@maowtm.org>
Date: Mon, 2 Jun 2025 14:26:42 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/10] landlock/hash: define (dynamic, non-resizable)
 hash table helpers
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Jann Horn <jannh@google.com>
References: <cover.1747836146.git.m@maowtm.org>
 <8b4d0d2f691e36507d5ad80ad4203c29ac6f216c.1747836146.git.m@maowtm.org>
 <20250526.quec3Dohsheu@digikod.net>
 <97fdaef3-1fe4-4aa2-a116-11d3864f0ba8@maowtm.org>
Content-Language: en-US
In-Reply-To: <97fdaef3-1fe4-4aa2-a116-11d3864f0ba8@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/2/25 14:20, Tingmao Wang wrote:
> On 5/27/25 12:00, Mickaël Salaün wrote:
>> On Wed, May 21, 2025 at 08:31:58PM +0100, Tingmao Wang wrote:
>>> While there is already include/linux/hash.h, it relies on the static size
>>> of the array as the size of the hash table, and thus is inconvenient to
>>> use for this case where we dynamically compute how many slots we need.
>>>
>>> There is also the relativistic hash tables in rhashtable.h which supports
>>> dynamic resizes etc, but is more complicated and might be slower to access?
>>>
>>> However, on second thought, I'm wondering if we should just use hash
>>> tables for both domain and a not-yet-merged ruleset anyway (which saves us
>>> from having a union in landlock_rule).  If we do that then we should
>>> indeed just use rhashtable.
>>
>> Thinking more about it, the important properties are that we can have a
>> lot of domains/tables (i.e. sandboxed processes) with a few
>> entries/rules (e.g. ~30 rules seems reasonable for now).  We should then
>> try to minimize the total amount of memory while still making access
>> checks quick.  As you noted, the cost of hashing should also not be
>> ignored.
>>
>> Instead of a hash table per domain, what about flat arrays with binary
>> search?  Here is a proposal:
> 
> I think this makes sense in terms of reducing memory footprint.
> 
> My understanding of the Slab allocator is that objects are allocated in
> power-of-two sized caches, so with a single-layer, 44 bytes landlock_rule,
> we will still use 64 bytes.  Putting them in an array, especially with
> your proposed structure, would reduce this.
> 
> I also checked how the allocations actually are distributed in the current
> implementation.  Dumping the addresses of the landlock_rule objects
> allocated and sorting them by the address, we see:
> 
> # env LL_FS_RO=/usr:/bin:/etc:/lib:/sys:/dev:/home/mao/.config:/home/mao/linux LL_FS_RW=/tmp:/proc:/dev/tty:/dev/null:/dev/zero \
>> ./sandboxer bash
> Executing the sandboxed command...
> bash: /home/mao/.bashrc: Permission denied
> mao@linux-devbox-vm:~$ cat /proc/dump_landlock_domain
> Ruleset: ffff9268489451e0
>   Inode tree:
>     ffff92684e767100: inode 5374060 in fs ext4
>     ffff92684e767380 (+640 (rule itself was 44 bytes)): inode 2883604 in fs ext4
>     ffff92684e767440 (+192 (rule itself was 44 bytes)): inode 2883992 in fs ext4
>     ffff92684e767580 (+320 (rule itself was 44 bytes)): inode 11 in fs devtmpfs
>     ffff92684e767740 (+448 (rule itself was 44 bytes)): inode 5377989 in fs ext4
>     ffff92684e767800 (+192 (rule itself was 44 bytes)): inode 1 in fs devtmpfs
>     ffff92684e7678c0 (+192 (rule itself was 44 bytes)): inode 1 in fs tmpfs
>     ffff92684e767980 (+192 (rule itself was 44 bytes)): inode 6 in fs devtmpfs
>     ffff92684e767b40 (+448 (rule itself was 44 bytes)): inode 4 in fs devtmpfs
>     ffff92684e767bc0 (+128 (rule itself was 44 bytes)): inode 2883585 in fs ext4
>     ffff92684e767c40 (+128 (rule itself was 44 bytes)): inode 1 in fs sysfs
>     ffff92684e767cc0 (+128 (rule itself was 44 bytes)): inode 6815745 in fs ext4
>     ffff92684e767f80 (+704 (rule itself was 44 bytes)): inode 1 in fs proc
> 
> Note: source code for this at
> https://github.com/micromaomao/linux-dev/commit/16c318fcbc64c23b87ca67836771f710d0d0ccf1
> 
> (this is a typical result out of several repeat runs)
> (KASLR etc disabled, no_hash_pointers)

Sorry I meant KASAN, KASLR is intact here.

> 
> Because all landlock rules are copied at domain creation time, I
> previously thought that they are likely to be allocated close together
> (perhaps there will be some fragmentation due to a ruleset extending an
> existing rule in the parent domain), but it looks like they are still
> spreaded out a bit for some reason, and if the allocations are sparse
> during domain creation time, this situation won't fix itself and could
> slow down all access checks.  (Maybe on a single core system, with nothing
> else touching the kmem cache when the domain is being merged, they would
> be allocated together?)
> 
> I'm not sure about the performance of binary search vs rbtrees. I can see
> that the improved locality should help, but going by my benchmark of the
> hashtable domains, I'm not sure how much of a difference it make, and
> whether it would be worth the added complexity.  I could try implementing
> this flat array + binary search approach and run the existing benchmarks
> on it tho (but as of writing this I haven't).
> 
>>
>> struct landlock_domain_index {
>>     union landlock_key key;
>>     u32 shift; // value to add to this array's index to jump to the set
>>                // of mapped landlock_layer
> 
> Can you clarify the comment?  Is it the index into the layers array, or
> are you suggesting adding the index of the current landlock_domain_index
> with this shift value, and use that to index into the layers array?
> 
> While it's probably an unlikely situation, what if there are more than
> 2^29 rules, each having 16 layers?  I think that would overflow this u32
> even if it is an offset, and this is allowed as LANDLOCK_MAX_NUM_RULES is
> currently defined as U32_MAX.
> 
> (Unrelated to this patch, but I think once we have the supervise feature
> in, I can see a (probably badly implemented) supervisor getting close to
> this limit if the sandboxed application creates / delete and recreates
> lots of temporary files under /tmp)
> 
>>     u32 num_layers;
>> }; // 128-bit (or 96-bit) alligned
> 
> I guess this has to be 128 bits aligned if we have an u32 num_layers.
> Because we allow 16 layers, if we make it an u16, it would actually need
> to be the number of layers minus 1.  However maybe that is
> overcomplicating it and we should just make this 128 bits aligned
> (otherwise we have to deal with unaligned reads of the
> landlock_key->object too).
> 
>>
>> // Theoretical landlock_domain
>> struct landlock_domain {
>>     struct landlock_hierarchy *hierarchy;
>>     union {
>>         // See landlock_ruleset's union
>>     };
>>     u32 num_fs; // number of FS indexes
>>     u32 num_net; // number of net indexes
>>     struct access_masks access_masks[];
>>     struct landlock_domain_index fs_indexes[num_fs];
>>     struct landlock_layer fs_layers[sum of FS rules' layers];
>>     struct landlock_domain_index net_indexes[num_net];
>>     struct landlock_layer net_layers[sum of net rules' layers];
>> };
> 
> (Unrelated to this patch specifically, but I would probably like to use
> this domain struct for the mutable part of a domain as well later.  In
> that case the hierarchy pointer would be unused.)
> 
>>
>> // Real landlock_domain
>> struct landlock_domain {
>>     struct landlock_hierarchy *hierarchy;
>>     union {
>>         // See landlock_ruleset's union
>>     };
>>     u32 num_fs; // number of FS indexes
>>     u32 num_net; // number of net indexes
>>     u32 rules[]; // underlying typed arrays accessed via helpers
>> };
>>
>> The landlock_domain is a contiguously allocated memory buffer containing
>> variable-size arrays improving locality.  Another advantage is that we
>> would not get any potential allocation errors once the buffer is
>> allocated which should simplify domain creation.  Also, we avoid the
>> union in landlock_rule (patch 5) and only use landlock_rule in
>> landlock_ruleset.
> 
> I think doing this definitely has positives especially in terms of memory,
> however I'm worried about the complexity here.  Since we will have to do
> various index calculation and use it to access variable-sized arrays, I'm
> somewhat afraid that any mistake could end up either leaking kernel
> pointers, or at worst, memory corruption.
> 
> We should probably have a len_rules, and check (WARN_ON_ONCE and if fails
> returns -EINVAL) that any computed indices lies within range before
> accessing it.
> 
>>
>> An alternative approach would be to use a hash table instead of the
>> array (extending landlock_domain_index with a pointer/shift to the next
>> collision) but still with this big buffer.  I'm not sure the perf impact
>> would be noticable but it might be worse a try.
> 
> I can give that a try too and measure benchmarks.
> 
> BTW, going by the direction this discussion is going, I assume we're on
> board with a separate landlock_domain, and don't plan to change how
> unmerged landlock_ruleset are stored (at least for now)?  If so I can
> probably start work on quiet rules, removing access bits / rules by
> intersect, etc as discussed in
> https://github.com/landlock-lsm/linux/issues/44#issuecomment-2876500918
> 
>>
>>>
>>> Signed-off-by: Tingmao Wang <m@maowtm.org>
>>> ---
>>>  security/landlock/hash.h | 117 +++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 117 insertions(+)
>>>  create mode 100644 security/landlock/hash.h
>>>
>>> diff --git a/security/landlock/hash.h b/security/landlock/hash.h
>>> new file mode 100644
>>> index 000000000000..955c5756d4d9
>>> --- /dev/null
>>> +++ b/security/landlock/hash.h
>>> @@ -0,0 +1,117 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Landlock - Domain hashtable mainpulation
>>
>> typo
> 
> ack
> 
>>
>>> + *
>>> + * Copyright © 2025      Tingmao Wang <m@maowtm.org>
>>> + */
>>> +
>>> +#ifndef _SECURITY_LANDLOCK_HASH_H
>>> +#define _SECURITY_LANDLOCK_HASH_H
>>> +
>>> +#include <linux/slab.h>
>>> +#include <linux/hash.h>
>>> +
>>> +#include "ruleset.h"
>>> +
>>> +struct landlock_hashtable {
>>> +	struct hlist_head *hlist;
>>
>> A simple linked-list would be enough.
> 
> I'm not sure I understand what you meant by a "simple linked-list" - do
> you mean like an array of `landlock_rule`s, each itself is part of a
> linked list of all the rules that hashed to the same key?
> 
> Anyway, since we identified a flat array approach (whether we hash or
> binary search), I'm gonna try that instead.
> 
>>
>>> +
>>> +	/**
>>> +	 * @hash_bits: Number of bits in this hash index (i.e.  hlist has
>>> +	 * 2^this many elements).
>>> +	 */
>>> +	int hash_bits;
>>> +};
>>> +
>>> +#define landlock_hash_for_each(rule, ht, i)                \
>>> +	for (i = 0; i < (1ULL << (ht)->hash_bits); i += 1) \
>>> +		hlist_for_each_entry(rule, &(ht)->hlist[i], hlist)
>>> +
>>> +#define landlock_hash_for_each_safe(rule, tmp, ht, i)      \
>>> +	for (i = 0; i < (1ULL << (ht)->hash_bits); i += 1) \
>>> +		hlist_for_each_entry_safe(rule, tmp, &(ht)->hlist[i], hlist)
>>> +
>>> +static inline int landlock_hash_init(const size_t expected_num_entries,
>>> +				     struct landlock_hashtable *out_ht)
>>> +{
>>> +	size_t table_sz = 1;
>>
>> Please use variables with full name when they are not too big:
>> table_size in this case.
>>
>>> +	int hash_bits = 0;
>>> +
>>> +	if (likely(expected_num_entries > 0)) {
>>> +		table_sz = roundup_pow_of_two(expected_num_entries);
>>
>> With roundup_pow_of_two() we'll get a few collisions but a big table.
>> What would be the impact of using roundup_pow_of_two() instead to have a
>> compact hash table (with more collisions)?
> 
> I assume you meant using rounddown_pow_of_two - I can give it a quick test
> too with the flat array approach.
> 
>>
>>> +		hash_bits = fls_long(table_sz - 1);
>>> +	}
>>> +
>>> +	/*
>>> +	 * We allocate a table even if expected_num_entries == 0 to avoid
>>> +	 * unnecessary branching in lookup code
>>> +	 */
>>> +
>>> +	out_ht->hash_bits = hash_bits;
>>> +	out_ht->hlist = kcalloc(table_sz, sizeof(struct hlist_head),
>>> +				GFP_KERNEL_ACCOUNT);
>>> +	if (!out_ht->hlist) {
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static inline void landlock_hash_free(struct landlock_hashtable *ht,
>>> +				      const enum landlock_key_type key_type)
>>> +{
>>> +	struct landlock_rule *rule;
>>> +	struct hlist_node *tmp;
>>> +	size_t i;
>>> +
>>> +	if (key_type == LANDLOCK_KEY_INODE)
>>> +		might_sleep();
>>> +
>>> +	if (!ht->hlist)
>>> +		return;
>>> +
>>> +	landlock_hash_for_each_safe(rule, tmp, ht, i)
>>> +	{
>>> +		free_rule(rule, key_type);
>>> +	}
>>> +	kfree(ht->hlist);
>>> +	ht->hlist = NULL;
>>> +}
>>> +
>>> +static inline u32 landlock_hash_key(const union landlock_key key,
>>> +				    const int hash_bits)
>>> +{
>>> +	return hash_ptr((void *)key.data, hash_bits);
>>> +}
>>> +
>>> +static inline struct landlock_rule *
>>> +landlock_hash_find(const struct landlock_hashtable *const ht,
>>> +		   const union landlock_key key)
>>> +{
>>> +	struct hlist_head *head;
>>> +	struct landlock_rule *rule;
>>> +
>>> +	head = &ht->hlist[landlock_hash_key(key, ht->hash_bits)];
>>> +
>>> +	hlist_for_each_entry(rule, head, hlist) {
>>> +		if (rule->key.data == key.data)
>>> +			return rule;
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>> +/**
>>> + * @landlock_hash_count - Return number of entries in the hashtable.
>>> + */
>>> +static inline size_t landlock_hash_count(const struct landlock_hashtable *ht)
>>> +{
>>> +	size_t num_entries = 0;
>>> +	struct landlock_rule *rule;
>>> +	size_t i;
>>> +	landlock_hash_for_each(rule, ht, i)
>>> +	{
>>> +		num_entries += 1;
>>> +	}
>>> +	return num_entries;
>>> +}
>>> --
>>> 2.49.0
>>>
>>>
> 


