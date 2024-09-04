Return-Path: <linux-security-module+bounces-5316-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE0096C5EB
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Sep 2024 20:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4CC9B218D0
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Sep 2024 18:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F84F1E1A04;
	Wed,  4 Sep 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XbW7O68X"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55E1E0B80
	for <linux-security-module@vger.kernel.org>; Wed,  4 Sep 2024 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472915; cv=none; b=oBvKxWhgLD+LRxDz+9gllzauMRhM7bd33GcAwwS19qlWzFDWngm8HpdA+PFdB1dlCuKglwROJAb2x11tgOx3lX4nHO+XTezW4FiyimVzJFOD4Id5zndXGOX3r+YaZbRLy3AZhtLDlPynLh4atst1z0x9L6vugPV3n8GRWYl1Kpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472915; c=relaxed/simple;
	bh=kvhqnlfhsbpncUCZEiavCzg2LzA66ExExMNp1OY8eBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sL3N8Zjpn/YOieEIWIpPYor1dkp1ghsQZBjti89i9kv33T+274O6F/7IJY3faUrogkC1qZ5ywRqNkBB5MdVnm0knSroEiOOA9sqrvf6abY2cSkcLWhnnFk29AvVCTxK+me4vCXYVAKYFZODfDYEnMGCAqw1VO8XrOKRW+8Te1kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XbW7O68X; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-824ee14f7bfso281872839f.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Sep 2024 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725472913; x=1726077713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DtTeYjj02Mtv2WzzkSyeLasv4f+WjuGZCMl+K7JYzM0=;
        b=XbW7O68XhAVyoIOcmKTdw5Ilxj7olMPKSD/W+m8mkSQ6eTMdkYM88U5EZfADMX63Kg
         M6TfB1mLDcmMzE7AeYFnneFWokQozgT/HZ6m2AbGhCcJTyvfJNvNF5SMOaAqY6X1x+xs
         pyVTLuq7KfkJ3HLxY26RuvZpKJlEBEXgrFYbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472913; x=1726077713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtTeYjj02Mtv2WzzkSyeLasv4f+WjuGZCMl+K7JYzM0=;
        b=V8hvDCtp3tKovL5p4ztK+PZIxsvatPrryeVcrlEKhxyMIgV/amQRQHsYUxOgkKY1DI
         FaJ+E0nWu7YFEn1+MiIFeDiI0EoIj1jNP3RE0VhwR+FSPh5ORAtcM5R+sy5MPTiW91NN
         04hKom90vb701ZDUxyaMz1KPbuBjyv2N/Im/dmPbbPK0DQ87VVudwLS5nkR8jZpcn+Qi
         ZwQKvPh80ngxSTg05uLZFY/4Suv7HqSGhrpYO7hCWOkNW0cekwS7vMocCZaHF8sgLjXR
         u07jbAGmhTqepVvEm5qLCD82Hu8DcAm3pjJGOB5yEotx2c6ntazKOw8hXhk0a6EaJseP
         zOnw==
X-Forwarded-Encrypted: i=1; AJvYcCWLKh2DcJWTmgaTn5F0WXRDKtaNCROmzcmIgvm+mf+oPPAEPAJSUGI7KGtxRcCmHkDLcMcvwUj5uM1kz13wovQA+l1oaxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJuXjZdCUkaLFsWguFZHv6Ab60f19yqggpkFK3pCl0u4GBzR9
	4GQk6Kfv7QUMyRoJw/REmuCf15WPwB3mDRYKb+ZmTLSLtD4N1/JSxtqOnPDmshw=
X-Google-Smtp-Source: AGHT+IE09d+IBeWwgHe5zjgeYzKqlOeVFBKdTyoUXo2CmM5mem85ZvAmg7ax8y1cyKmmP1BgZ4kZOg==
X-Received: by 2002:a05:6602:60c7:b0:807:f0fb:11a2 with SMTP id ca18e2360f4ac-82a11094588mr2605807839f.13.1725472912591;
        Wed, 04 Sep 2024 11:01:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a49897bsm366616139f.37.2024.09.04.11.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:01:52 -0700 (PDT)
Message-ID: <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
Date: Wed, 4 Sep 2024 12:01:50 -0600
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Michal Hocko <mhocko@suse.com>
Cc: Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 "conduct@kernel.org" <conduct@kernel.org>
References: <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 03:51, Kent Overstreet wrote:
> On Mon, Sep 02, 2024 at 11:39:41AM GMT, Michal Hocko wrote:
>> On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
>>> On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
>>>> On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
>>>> [...]
>>>>> But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
>>>>> in the case of bugs, because that's going to be an improvement w.r.t.
>>>>> system robustness, in exactly the same way we don't use BUG_ON() if it's
>>>>> something that we can't guarantee won't happen in the wild - we WARN()
>>>>> and try to handle the error as best we can.
>>>>
>>>> We have discussed that in a different email thread. And I have to say
>>>> that I am not convinced that returning NULL makes a broken code much
>>>> better. Why? Because we can expect that broken NOFAIL users will not have a
>>>> error checking path. Even valid NOFAIL users will not have one because
>>>> they _know_ they do not have a different than retry for ever recovery
>>>> path.
>>>
>>> You mean where I asked you for a link to the discussion and rationale
>>> you claimed had happened? Still waiting on that
>>
>> I am not your assistent to be tasked and search through lore archives.
>> Find one if you need that.
>>
>> Anyway, if you read the email and even tried to understand what is
>> written there rather than immediately started shouting a response then
>> you would have noticed I have put actual arguments here. You are free to
>> disagree with them and lay down your arguments. You have decided to
>>
>> [...]
>>
>>> Yeah, enough of this insanity.
>>
>> so I do not think you are able to do that. Again...
> 
> Michal, if you think crashing processes is an acceptable alternative to
> error handling _you have no business writing kernel code_.
> 
> You have been stridently arguing for one bad idea after another, and
> it's an insult to those of us who do give a shit about writing reliable
> software.
> 
> You're arguing against basic precepts of kernel programming.
> 
> Get your head examined. And get the fuck out of here with this shit.
> 

Kent,

Using language like this is clearly unacceptable and violates the
Code of Conduct. This type of language doesn't promote respectful
and productive discussions and is detrimental to the health of the
community.

You should be well aware that this type of language and personal
attack is a clear violation of the Linux kernel Contributor Covenant
Code of Conduct as outlined in the following:

https://www.kernel.org/doc/html/latest/process/code-of-conduct.html

Refer to the Code of Conduct and refrain from violating the Code of
Conduct in the future.

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)

