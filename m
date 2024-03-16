Return-Path: <linux-security-module+bounces-2192-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C0687DAFD
	for <lists+linux-security-module@lfdr.de>; Sat, 16 Mar 2024 18:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67695281602
	for <lists+linux-security-module@lfdr.de>; Sat, 16 Mar 2024 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBDF1BC53;
	Sat, 16 Mar 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="A6EeWpqG"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A591C2AC
	for <linux-security-module@vger.kernel.org>; Sat, 16 Mar 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710609451; cv=none; b=bt8RqumKtcIzr+I+jzTxqqVhsdEtnVFw1zD2fva1QjXUH30PRT0Lpbp/7A0F7k7OinRCexCsmwCVnyqhGJgbjMAU6e+QYyWBnwXALr2ir4mP4CSXfaC5POtAMBEz5bkrArGYJ83gkyH1OX7//2gEOEPHk6Uqy+VeW0iEupNp/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710609451; c=relaxed/simple;
	bh=kxTk/zWbrWQmT2PYOeEcrde+if1JXoN1MgZJTpb862Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPwIHUuEHAF709bxo6HA/CbEG1NVZtBqNdWMCoonCixwnx7naddb/89bB5MeHDJH3RZ5v37MGY6u4mWXtqPQgmx8uJ0v28cT8FLU8S6sPy/tg7p+dKtVuIwkb590tpNpw/BOEoF3GWDDNmRcRBsq2kaA5hzL7eOsMd7SkoXgw/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=A6EeWpqG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6ca65edc9so887072b3a.0
        for <linux-security-module@vger.kernel.org>; Sat, 16 Mar 2024 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710609449; x=1711214249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwyFsUDC4cYPBKX6IfNABRcCDq2xzgMKMVjZ16s/Y7M=;
        b=A6EeWpqG+nmbCu0wSHseUQeGvokZdhBMidrggEr0tnxAQeYjRw6WoWlm998jDJoEIx
         Pi0O3+Rv5R+m2zLvBVYx6Lt5DkOuWuVlsAMn2RmLJ6d+boB92d9OSp0/wKbBQG7e14nu
         P7atWzkM2tOGL3b30wVOlijUBZrusivefI+VNd/en+TtqjeEUWdgTi/NmGqbumKyPTRM
         fDs8reh4hGRJqIbi+R4pOAZmBnfvzLoWgBnfCXK8Ss5NVyglvjV/vbS/+BT35W186jQ2
         8BpMiXasdd3uUSiKtp5xz6POfwFiD9YxKxasaHHoPl5h3pTvLKnGhVNIDbBTBzQrm33Y
         SP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710609449; x=1711214249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwyFsUDC4cYPBKX6IfNABRcCDq2xzgMKMVjZ16s/Y7M=;
        b=PUTRrpldTkqTRo5nkoEGHkH5EzHANTCtTawzRABNbAsRc2ad4M8+7sCRsSf08HL4bD
         CbsaIM3D9HUVJaIG/UmIyJ+WRTyDrrUWI8roavk/uURC7LGFosoLUrVA3REAF8zFyYmh
         L8PaZslaHTGNJ9RWjNAlhoKK96d304Zk7DKwuPVXoYQIvJ4+dL+hodkfx/wqAgAL2ZDH
         hC1qUOyFHsKz06lzhPWKkNaHY/gkHM69R61zDGpS/hx8aPb/YRlHwV2JHbzEAsC5zaXp
         LcOnS3ia7cjByNhmnzJOUAvMizYtg8W2R+eIZSBwjv6lsrLK7ghcyUOEcSRRse/rqezy
         5z2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWo/sO1coVkjjwIhK6QyRNqNxOoGTmcCzT1wWW6SovXEVdUqUv5XpZNz2Qu40FEB6fZE5XFE7sd8qvOOb6WCojXOA70T8tQURP+qogW5VbJI0cGzZ8Q
X-Gm-Message-State: AOJu0Yy1Iod0YzLJH059RFEAPIXp9/7pG1QoKcAPLicjtO6WLg4XHt3N
	E76EBReOukQJqUYYYHBJN7OIGjkYvipS1WmxRkC/X78Hw9Di8kADOm0ebbeQeeg=
X-Google-Smtp-Source: AGHT+IG3DPOFC1jCqg0VsU6zQ3yiocZQTZSrqg+K4gBfn0DXYa5cYs2kvobaBYLoCDVrM0MSeTmAvw==
X-Received: by 2002:a17:902:d2ce:b0:1df:fbc3:d130 with SMTP id n14-20020a170902d2ce00b001dffbc3d130mr2372826plc.1.1710609448903;
        Sat, 16 Mar 2024 10:17:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090311cc00b001db9e12cd62sm6011304plh.10.2024.03.16.10.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 10:17:28 -0700 (PDT)
Message-ID: <4405edd4-f20f-4040-ad67-aca3fcd7eff3@kernel.dk>
Date: Sat, 16 Mar 2024 11:17:26 -0600
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] capability: add any wrappers to test for multiple
 caps with exactly one audit message
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-security-module@vger.kernel.org, linux-block@vger.kernel.org,
 Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240315113828.258005-1-cgzones@googlemail.com>
 <20240315113828.258005-2-cgzones@googlemail.com>
 <CAEf4BzZF0A9qEzmRigHFLQ4vBQshGUQWZVG5L0q2_--kx4=AXA@mail.gmail.com>
 <0f8291f7-48b1-4be1-8a57-dbad5d0ab28c@kernel.dk>
 <CAEf4BzbgQrYDMma=NbW6A-qikA693eSnz9-RwjkF3xPLRE8qqg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAEf4BzbgQrYDMma=NbW6A-qikA693eSnz9-RwjkF3xPLRE8qqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 3:16 PM, Andrii Nakryiko wrote:
> On Fri, Mar 15, 2024 at 11:41?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 3/15/24 10:45 AM, Andrii Nakryiko wrote:
>>>> +/**
>>>> + * ns_capable_any - Determine if the current task has one of two superior capabilities in effect
>>>> + * @ns:  The usernamespace we want the capability in
>>>> + * @cap1: The capabilities to be tested for first
>>>> + * @cap2: The capabilities to be tested for secondly
>>>> + *
>>>> + * Return true if the current task has at least one of the two given superior
>>>> + * capabilities currently available for use, false if not.
>>>> + *
>>>> + * In contrast to or'ing capable() this call will create exactly one audit
>>>> + * message, either for @cap1, if it is granted or both are not permitted,
>>>> + * or @cap2, if it is granted while the other one is not.
>>>> + *
>>>> + * The capabilities should be ordered from least to most invasive, i.e. CAP_SYS_ADMIN last.
>>>> + *
>>>> + * This sets PF_SUPERPRIV on the task if the capability is available on the
>>>> + * assumption that it's about to be used.
>>>> + */
>>>> +bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
>>>> +{
>>>> +       if (cap1 == cap2)
>>>> +               return ns_capable(ns, cap1);
>>>> +
>>>> +       if (ns_capable_noauditondeny(ns, cap1))
>>>> +               return true;
>>>> +
>>>> +       if (ns_capable_noauditondeny(ns, cap2))
>>>> +               return true;
>>>> +
>>>> +       return ns_capable(ns, cap1);
>>>
>>> this will incur an extra capable() check (with all the LSMs involved,
>>> etc), and so for some cases where capability is expected to not be
>>> present, this will be a regression. Is there some way to not redo the
>>> check, but just audit the failure? At this point we do know that cap1
>>> failed before, so might as well just log that.
>>
>> Not sure why that's important - if it's a failure case, and any audit
>> failure should be, then why would we care if that's now doing a bit of
>> extra work?
> 
> Lack of capability doesn't necessarily mean "failure". E.g., in FUSE
> there are at least few places where the code checks
> capable(CAP_SYS_ADMIN), and based on that decides on some limit values
> or extra checks. So if !capable(CAP_SYS_ADMIN), operation doesn't
> necessarily fail outright, it just has some more restricted resources
> or something.
> 
> Luckily in FUSE's case it's singular capable() check, so capable_any()
> won't incur extra overhead. But I was just wondering if it would be
> possible to avoid this with capable_any() as well, so that no one has
> to do these trade-offs.

That's certainly a special and odd case, as most other cases really
would be of the:

if (capable(SOMETHING))
	return -EFAUL;

Might make more sense to special case the FUSE thing then, or provide a
cheap way for it to do what it needs to do. I really don't think that
kind of:

if (capable(SOMETHING))
	do something since I can
else
	bummer, do something else then

is a common occurrence.

> We also had cases in production of some BPF applications tracing
> cap_capable() calls, so each extra triggering of it would be a bit of
> added overhead, as a general rule.
> 
> Having said the above, I do like capable_any() changes (which is why I
> acked BPF side of things).

Yes, the BPF tracking capable in production is a pain in the butt, as it
slows down any valid fast path capable checking by a substantial amount.
We've had to work around that on the block side, unfortunately. These
are obviously cases where you expect success, and any failure is
permanent as far as that operation goes.

-- 
Jens Axboe


