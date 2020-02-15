Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D340C15FF4F
	for <lists+linux-security-module@lfdr.de>; Sat, 15 Feb 2020 17:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgBOQ46 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 15 Feb 2020 11:56:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44020 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgBOQ46 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 15 Feb 2020 11:56:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id s1so6614373pfh.10
        for <linux-security-module@vger.kernel.org>; Sat, 15 Feb 2020 08:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=s2yh5Cuuxtdx7l4MqowreyFFihQLy338R8kSW89UAdc=;
        b=vJ/tRDiScWVGmu1Pcz0PXheuQmj39Q57evTUZqyRwSdPMTUvV7dg83tCVlWrdy57Cr
         UW+Kz4AmVF+2X7bf0pcSHP8csmUSjaQPMjzwsVd7s4JTe3BnW9TPxrLsqIuSsEPkxpJW
         faFLUO3H5RHqUuzurNsYGcNMy1cqtsvXRKn6phv7Rt0UKBIQnL96TbU9Y8+xHEBVc9uS
         C9Hex6y3UZdBm0ns9UZ75HmdGi7EVnOpTc8ErLa5bSffS+xYKedNBipuFpRty1TRgwJ0
         dBVkRPN+CEIn/XSOBI+rQU88GY8WNwqw70LgWgLoPfNadpONIPQ2I8ozJGOyfkeZAUQe
         2x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=s2yh5Cuuxtdx7l4MqowreyFFihQLy338R8kSW89UAdc=;
        b=UXSHP7qil6a3tdZuMtfDL/qSz77tg4AyUQGA6LS3rWpngRhj2w0vWRv6idsoy38GA3
         1iE3yhKrEE0561TSFssuPQl9vCCAySFOqRqGINr860frN28E/Eg+Ejz+81QlNSj8sEiw
         YeklN4AgVii5haWZGo4uJnxmqb5+nKuJVmNSgYCc+XZafoH4IEUEy8rfW1cEisaSRFb6
         SUsV1kCOiQ8lUAHqikeo6HO/V1cpMx4RZO7F5bcS7TLlsgsD4NDVcQNECgZSx7rsUTer
         ABYlA7k9WclgbjPit1RhlXwv/966xkKVf6uJRfu81rcf+0y+U+G7lkhnvQ6yyAZO006D
         MV9A==
X-Gm-Message-State: APjAAAXCVB27K25if+9hOgNL5VUGihHDUG4w7zIMlkku3GUuGIA1nO6d
        qdupT+kZ8QTrYpRznu1q1PNYtg==
X-Google-Smtp-Source: APXvYqznz92DmqBfK1fg/rH6pdzEPLv2+da6EipQJAMGpTWpVgaJfxuLgnYC8V4LqRcDfc98oUu1Tw==
X-Received: by 2002:a63:5807:: with SMTP id m7mr8719324pgb.83.1581785817824;
        Sat, 15 Feb 2020 08:56:57 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:393a:fee0:9ddb:4055? ([2601:646:c200:1ef2:393a:fee0:9ddb:4055])
        by smtp.gmail.com with ESMTPSA id s124sm11696091pfc.57.2020.02.15.08.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2020 08:56:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v26 10/22] x86/sgx: Linux Enclave Driver
Date:   Sat, 15 Feb 2020 08:56:54 -0800
Message-Id: <033BCE0D-FA8C-40FB-849A-E401A5C6F6A3@amacapital.net>
References: <20200214175211.GE20690@linux.intel.com>
Cc:     Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        haitao.huang@intel.com, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de, kai.svahn@intel.com, bp@alien8.de,
        josh@joshtriplett.org, luto@kernel.org, kai.huang@intel.com,
        rientjes@google.com, cedric.xing@intel.com, puiterwijk@redhat.com,
        linux-security-module@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>
In-Reply-To: <20200214175211.GE20690@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailer: iPhone Mail (17D50)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


> On Feb 14, 2020, at 9:52 AM, Sean Christopherson <sean.j.christopherson@in=
tel.com> wrote:
>=20
> =EF=BB=BFOn Fri, Feb 14, 2020 at 09:40:00AM -0800, Andy Lutomirski wrote:
>>=20
>>=20
>>>> On Feb 14, 2020, at 9:11 AM, Sean Christopherson <sean.j.christopherson=
@intel.com> wrote:
>>>=20
>>> =EF=BB=BFOn Fri, Feb 14, 2020 at 10:24:10AM +0100, Jethro Beekman wrote:=

>>>>> On 2020-02-13 19:07, Sean Christopherson wrote:
>>>>> On Thu, Feb 13, 2020 at 02:59:52PM +0100, Jethro Beekman wrote:
>>>>>> On 2020-02-09 22:25, Jarkko Sakkinen wrote:
>>>>>>> +/**
>>>>>>> + * struct sgx_enclave_add_pages - parameter structure for the
>>>>>>> + *                                %SGX_IOC_ENCLAVE_ADD_PAGE ioctl
>>>>>>> + * @src:    start address for the page data
>>>>>>> + * @offset:    starting page offset
>>>>>>> + * @length:    length of the data (multiple of the page size)
>>>>>>> + * @secinfo:    address for the SECINFO data
>>>>>>> + * @flags:    page control flags
>>>>>>> + * @count:    number of bytes added (multiple of the page size)
>>>>>>> + */
>>>>>>> +struct sgx_enclave_add_pages {
>>>>>>> +    __u64    src;
>>>>>>> +    __u64    offset;
>>>>>>> +    __u64    length;
>>>>>>> +    __u64    secinfo;
>>>>>>> +    __u64    flags;
>>>>>>> +    __u64    count;
>>>>>>> +};
>>>>>>=20
>>>>>> Compared to the last time I looked at the patch set, this API removes=
 the
>>>>>> ability to measure individual pages chunks. That is not acceptable.
>>>>>=20
>>>>> Why is it not acceptable?  E.g. what specific use case do you have tha=
t
>>>>> _requires_ on measuring partial 4k pages of an enclave?
>>>>=20
>>>> The use case is someone gives me an enclave and I want to load it. If I=
 don't
>>>> load it exactly as the enclave author specified, the enclave hash will b=
e
>>>> different, and it won't work.
>>>=20
>>> And if our ABI says "thou shall measure in 4k chunks", then it's an inva=
lid
>>> enclave if its author generated MRENCLAVE using a different granularity.=

>>=20
>> ISTM, unless there=E2=80=99s a particularly compelling reason, if an encl=
ave is
>> valid, we should be able to load it.
>=20
> That means we have to have a separate ioctl() for EEXTEND, otherwise we
> can't handle EADD[0]->EADD[1]->EADD[2]->EEXTEND[0]->EEXTEND[1]->EEXTEND[2]=
.
>=20
> I think we'd still want to keep the MEASURE flag for SGX_IOC_ENCLAVE_ADD_P=
AGE
> so that we can optimize EADD[0]->EEXTEND[0]->EADD[1]->EEXTEND[1].

Seems reasonable to me. I suppose such as ioctl could also be added later if=
 there=E2=80=99s a need.=
