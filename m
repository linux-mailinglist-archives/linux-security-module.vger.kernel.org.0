Return-Path: <linux-security-module+bounces-6708-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78FD9D436A
	for <lists+linux-security-module@lfdr.de>; Wed, 20 Nov 2024 22:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E19B246BC
	for <lists+linux-security-module@lfdr.de>; Wed, 20 Nov 2024 21:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1461BD4F8;
	Wed, 20 Nov 2024 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fIUF5W8x"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1F199238
	for <linux-security-module@vger.kernel.org>; Wed, 20 Nov 2024 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732137136; cv=none; b=uNUCsbkQfUIc5fzjsh1lKsDLaqxvnAASXOcaSagSNH8MkijG2vC9JG24PsOUS/VEq5ChSqseb2iji9WqN6lBnDsyJr4mbtTaY98pLF6lniS1R3Rxc0RaWk5/KyUe5OwwXu5z17UTWtUhHu9msMB518g9yJR1yDB1TV/sAM0f68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732137136; c=relaxed/simple;
	bh=iWSamfZ6Xd9iRQUuq/gqkeSFTuaRn4oBQP7LBCKK5ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oauy91/sNdVpP3uL7djgdb6Fk7HNTNi75njvtlvSWSfr4H/AQyTTH41pODo9gcCnII3r333kpe5VKo8gHZCNEHpcSDWVKhLK9ojlEL7bSMYgYqFTdHKzLri3Ct/wQmr/p9xf07ZKSYfiZcVV2yOAUhqBae29Wd6LLdOM7nZGZLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fIUF5W8x; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83abcfb9f37so8892239f.1
        for <linux-security-module@vger.kernel.org>; Wed, 20 Nov 2024 13:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732137134; x=1732741934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pwRE5aWtMzLuuFheQxhwI6BjKxK09M8wwvrm4cZ/NdI=;
        b=fIUF5W8xxwZ3WOecbNLDqUWEYstIFVsyrIFXzyV0S3Xy4udFgrqbwt4BX+baODPOk+
         vmjToPMkukwB4B3/3Fn4mfYJHf9jmA7hpryVaJqh2+VoXG+0NuKt4EIFq4HhSVDUV7OP
         8yY12FSlZjrcr8vpkUZWiVPOYSZVw4YTOgp5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732137134; x=1732741934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwRE5aWtMzLuuFheQxhwI6BjKxK09M8wwvrm4cZ/NdI=;
        b=VWUeUR0DWY4zX3ggPplovIYcOIhFqRwvjCetHNFO8Co0TMgdQ+x2AQtP9S7x/c7hY7
         pCTjNbb/Pq/deCPoQJOG8MQXrkkDOITWixiZVb4OI/g1/1dKLwE+CPrzxvcqAOatCv6u
         9MqCQ4fyzWHYYiyhyeCsCcbSZeEorgwX5Km0snwPJbScrBe06ESqIaMmCaBR/ecVy57O
         Tqo0/N2RQbcowmukAGelSFS4xdsAzqFKM98KgPkfmndoiRStYAk7QsgA7cDvN7WmjtG0
         8YApMTACoL6dj5gWwQXwZNRB4knwzSVO+pzC9Lb4FWvi+X8HGdlOob6YbldnoMXd1Uw5
         Reug==
X-Forwarded-Encrypted: i=1; AJvYcCWpqSl3HKlmSF1d5/H942UNzay7ln3ZpL9du05MH/IU0SCHh8vTpUvtElBM7yHzQR22WTxOWCXWluPEwi1sVbdhyI15gEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEw6ae/6sFrL7AVwtmb0t9p89VKN7GtGkSkfoq4grQFIhp7NVr
	hc7rlYBR7lUruROHlmaMoupfl7GMh2s83J9poywjV9XPmiZW8djQ5FcikuBzanI=
X-Gm-Gg: ASbGncuJvOtYsds2ClXdT4mQuocrNx+HTOweNrvuLKN6YG0rc/6AnUYTwRcXywjl5Rb
	VwAyH7Kz1Uton2wGAZlLV1G6GGuxapPX0FvqsJyxXihsf+VUvt9cG+8kJ7tdBivMDQTR2AmFX/S
	VTtHqVnlkN3YlFsdtsBq4GHEyU+PY4CiLwyoNhsnL4RXucpjSH0I7t86cq5hCRmLLZqqUavdYw5
	TkN6AOwsxOGvsWzHQ/zXrYnoWaBH9106bEqt4ety7KG3SC1e2FyTM16aWLlIg==
X-Google-Smtp-Source: AGHT+IGF0X7D1su9KBsDu7YgP31JToa/OjzK2+lpjEy03i6Xz35JeAk4n1thkDF51vnmohZStzHzvA==
X-Received: by 2002:a05:6602:2b86:b0:835:45f9:c2ee with SMTP id ca18e2360f4ac-83eb5fb48d1mr532791239f.4.1732137133729;
        Wed, 20 Nov 2024 13:12:13 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6e7374sm3286443173.32.2024.11.20.13.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 13:12:13 -0800 (PST)
Message-ID: <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
Date: Wed, 20 Nov 2024 14:12:12 -0700
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
 linux-kernel@vger.kernel.org, "conduct@kernel.org" <conduct@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 13:34, Kent Overstreet wrote:
> On Wed, Sep 04, 2024 at 12:01:50PM -0600, Shuah Khan wrote:
>> On 9/2/24 03:51, Kent Overstreet wrote:
>>> On Mon, Sep 02, 2024 at 11:39:41AM GMT, Michal Hocko wrote:
>>>> On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
>>>>> On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
>>>>>> On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
>>>>>> [...]
>>>>>>> But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
>>>>>>> in the case of bugs, because that's going to be an improvement w.r.t.
>>>>>>> system robustness, in exactly the same way we don't use BUG_ON() if it's
>>>>>>> something that we can't guarantee won't happen in the wild - we WARN()
>>>>>>> and try to handle the error as best we can.
>>>>>>
>>>>>> We have discussed that in a different email thread. And I have to say
>>>>>> that I am not convinced that returning NULL makes a broken code much
>>>>>> better. Why? Because we can expect that broken NOFAIL users will not have a
>>>>>> error checking path. Even valid NOFAIL users will not have one because
>>>>>> they _know_ they do not have a different than retry for ever recovery
>>>>>> path.
>>>>>
>>>>> You mean where I asked you for a link to the discussion and rationale
>>>>> you claimed had happened? Still waiting on that
>>>>
>>>> I am not your assistent to be tasked and search through lore archives.
>>>> Find one if you need that.
>>>>
>>>> Anyway, if you read the email and even tried to understand what is
>>>> written there rather than immediately started shouting a response then
>>>> you would have noticed I have put actual arguments here. You are free to
>>>> disagree with them and lay down your arguments. You have decided to
>>>>
>>>> [...]
>>>>
>>>>> Yeah, enough of this insanity.
>>>>
>>>> so I do not think you are able to do that. Again...
>>>
>>> Michal, if you think crashing processes is an acceptable alternative to
>>> error handling _you have no business writing kernel code_.
>>>
>>> You have been stridently arguing for one bad idea after another, and
>>> it's an insult to those of us who do give a shit about writing reliable
>>> software.
>>>
>>> You're arguing against basic precepts of kernel programming.
>>>
>>> Get your head examined. And get the fuck out of here with this shit.
>>>
>>
>> Kent,
>>
>> Using language like this is clearly unacceptable and violates the
>> Code of Conduct. This type of language doesn't promote respectful
>> and productive discussions and is detrimental to the health of the
>> community.
>>
>> You should be well aware that this type of language and personal
>> attack is a clear violation of the Linux kernel Contributor Covenant
>> Code of Conduct as outlined in the following:
>>
>> https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
>>
>> Refer to the Code of Conduct and refrain from violating the Code of
>> Conduct in the future.
> 
> I believe Michal and I have more or less worked this out privately (and
> you guys have been copied on that as well).

Thank you for updating us on the behind the scenes work between you
and Michal.

I will make one correction to your statement, "you guys have been copied on
that as well" - which is inaccurate. You have shared your email exchanges
with Michal with us to let us know that the issue has been sorted out.

You might have your reasons and concerns about the direction of the code
and design that pertains to the discussion in this email thread. You might
have your reasons for expressing your frustration. However, those need to be
worked out as separate from this Code of Conduct violation.

In the case of unacceptable behaviors as defined in the Code of Conduct
document, the process is to work towards restoring productive and
respectful discussions. It is reasonable to ask for an apology to help
us get to the goal as soon as possible.

I urge you once again to apologize for using language that negatively impacts
productive discussions.

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)
  


