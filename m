Return-Path: <linux-security-module+bounces-3570-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D178D298F
	for <lists+linux-security-module@lfdr.de>; Wed, 29 May 2024 02:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B86D1F238B2
	for <lists+linux-security-module@lfdr.de>; Wed, 29 May 2024 00:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66971F176;
	Wed, 29 May 2024 00:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ID47KXG+"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57241A8F;
	Wed, 29 May 2024 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716943511; cv=none; b=hxWhB/4lridbpcNXzFUW0Sp/Aeyqrac3wDByRWhojfTvi5egpGddGUlOkNmYC1KEEE5SRFj/8AvNoBibf/7zv2JlTtj7RL8jf2UDsIURESxeMvwDkLOycRcBPJpKkPLXXj8c25iaOAZgNcBF942ToJpA9uY3p2CZGu4PmEB533c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716943511; c=relaxed/simple;
	bh=cQbN2r3CmQABtW562IFpglpJQtyEA0sY9zYqJksu/1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3KGMx3r60wyCF+dQ5SuPbQVNh+MkPKKfIJlP7bcK+ZcRpBmjqq38JRgqepjSQ7fRwXTpsSEvAHbXoeybG4UP6Cz322FVnQ1yhnshioR2ZUKJb7s2T7eJf7dq0kArW+qsB+qFWeGRAJtcLvw8oJZe41gJS/FFQHQSw0jMRPRqek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ID47KXG+; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DEE10448DA;
	Wed, 29 May 2024 00:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716943036;
	bh=IwmVenT12WYsF09BaY/drCT+mrjDvXzOd7X5S9Bb/ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ID47KXG+Xk+BaIiF787r3WoHw/PYHhALsMch2yqO3DO62hhJRSuDhr+t5kps40LOa
	 b93I+miTStl6vCii0TBBmhepmr29/eQxmlwqKa6MnYsx38Cta9IkrsszLodXOB3F+G
	 9mJDiRZ1kADE8FHi3CH6prRgLOKb8UYCwh+p+jnDJlT7t63hnvGTXyqW/aEIl/HphZ
	 i1+egW+heOx0SDdpvFmYUt7+RxyeJg2d8x2MC4OKyCt3zllM1ClMreCI/I55lNfOs/
	 23+acb8pKoGLD0wuW1OMdrYWWF4nKQUsyy04ixn37HjmQM4UhlMGyXlW8oTsEKxQPp
	 ZC8+WVIbTTt3Q==
Message-ID: <78cfe966-33ec-4858-b114-57697e478109@canonical.com>
Date: Tue, 28 May 2024 17:37:12 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/9] Nginx refcount scalability issue with Apparmor enabled
 and potential solutions
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Shukla, Santosh" <Santosh.Shukla@amd.com>,
 "Narayan, Ananth" <Ananth.Narayan@amd.com>,
 raghavendra.kodsarathimmappa@amd.com, koverstreet@google.com,
 paulmck@kernel.org, boqun.feng@gmail.com, vinicius.gomes@intel.com
References: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com>
 <096178c9-91de-4752-bdc4-6a31bcdcbaf8@amd.com>
 <4871a305-5d45-47d2-85f2-d718c423db80@canonical.com>
 <CAGudoHFkDmGuPQDLf6rfiJxUdqFxjeeM-_9rFCApSrBYzfyRmA@mail.gmail.com>
 <3b880c7c-0d19-4bb6-9f0f-fb69047f41cd@canonical.com>
 <CAGudoHEycK3iTO2Rrsqr56_Lm69rCzMRaYz11NLrOcn5gKB3RA@mail.gmail.com>
 <5c94947b-1f1f-44a7-8b9c-b701c78350b4@canonical.com>
 <CAGudoHFxma+H_iHPV8+gfEkHc0uwFD8=rJtFy7ZE3TH+7tGiwQ@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAGudoHFxma+H_iHPV8+gfEkHc0uwFD8=rJtFy7ZE3TH+7tGiwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/28/24 06:29, Mateusz Guzik wrote:
> On Fri, May 24, 2024 at 11:52 PM John Johansen
> <john.johansen@canonical.com> wrote:
>>
>> On 5/24/24 14:10, Mateusz Guzik wrote:
>>> On Fri, Mar 8, 2024 at 9:09 PM John Johansen
>>> <john.johansen@canonical.com> wrote:
>>>>
>>>> On 3/2/24 02:23, Mateusz Guzik wrote:
>>>>> On 2/9/24, John Johansen <john.johansen@canonical.com> wrote:
>>>>>> On 2/6/24 20:40, Neeraj Upadhyay wrote:
>>>>>>> Gentle ping.
>>>>>>>
>>>>>>> John,
>>>>>>>
>>>>>>> Could you please confirm that:
>>>>>>>
>>>>>>> a. The AppArmor refcount usage described in the RFC is correct?
>>>>>>> b. Approach taken to fix the scalability issue is valid/correct?
>>>>>>>
>>>>>>
>>>>>> Hi Neeraj,
>>>>>>
>>>>>> I know your patchset has been waiting on review for a long time.
>>>>>> Unfortunately I have been very, very busy lately. I will try to
>>>>>> get to it this weekend, but I can't promise that I will be able
>>>>>> to get the review fully done.
>>>>>>
>>>>>
>>>>> Gentle prod.
>>>>>
>>>>> Any chances of this getting reviewed in the foreseeable future? Would
>>>>> be a real bummer if the patchset fell through the cracks.
>>>>>
>>>>
>>>> yes, sorry I have been unavailable for the last couple of weeks. I am
>>>> now back, I have a rather large backlog to try catching up on but this
>>>> is has an entry on the list.
>>>>
>>>
>>> So where do we stand here?
>>>
>> sorry I am still trying to dig out of my backlog, I will look at this,
>> this weekend.
>>
> 
> How was the weekend? ;)
> 

lets say it was busy. Have I looked at this, yes. I am still digesting it.
I don't have objections to moving towards percpu refcounts, but the overhead
of a percpu stuct per label is a problem when we have thousands of labels
on the system. That is to say, this would have to be a config option. We
moved buffers from kmalloc to percpu to reduce memory overhead to reduce
contention. The to percpu, to a global pool because the percpu overhead was
too high for some machines, and then from a global pool to a hybrid scheme
because of global lock contention. I don't see a way of doing that with the
label, which means a config would be the next best thing.

Not part of your patch but something to be considered is that the label tree
needs a rework, its locking needs to move to read side a read side lock less
scheme, and the plan was to make it also use a linked list such that new
labels are always queued at the end, allowing dynamically created labels to
be lazily added to the tree.

I see the use of the kworker as problematic as well, especially if we are
talking using kconfig to switch reference counting modes. I am futzing with
some ideas, on how to deal with this.

Like I said I am still digesting.


