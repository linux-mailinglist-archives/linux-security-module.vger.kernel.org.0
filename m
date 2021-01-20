Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA5F2FD08D
	for <lists+linux-security-module@lfdr.de>; Wed, 20 Jan 2021 13:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbhATMkg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 20 Jan 2021 07:40:36 -0500
Received: from smtp-42ab.mail.infomaniak.ch ([84.16.66.171]:47303 "EHLO
        smtp-42ab.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389247AbhATLSU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Jan 2021 06:18:20 -0500
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DLNKQ6xvLzMqF1J;
        Wed, 20 Jan 2021 12:17:30 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DLNKP0xC8zlppyy;
        Wed, 20 Jan 2021 12:17:29 +0100 (CET)
Subject: Re: [PATCH v3 05/10] certs: Replace K{U,G}IDT_INIT() with
 GLOBAL_ROOT_{U,G}ID
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-6-mic@digikod.net> <YAe8cr7bS2Dn0RRn@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <96550031-5183-e60f-f279-3475ab3851bc@digikod.net>
Date:   Wed, 20 Jan 2021 12:17:28 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <YAe8cr7bS2Dn0RRn@kernel.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 20/01/2021 06:15, Jarkko Sakkinen wrote:
> On Thu, Jan 14, 2021 at 04:19:04PM +0100, Micka�l Sala�n wrote:
>> From: Micka�l Sala�n <mic@linux.microsoft.com>
>>
>> Align with the new macros and add appropriate include files.
>>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Signed-off-by: Micka�l Sala�n <mic@linux.microsoft.com>
>> Signed-off-by: David Howells <dhowells@redhat.com>
> 
> The commit message makes no sense. What you new macros?

What about "Use the new GLOBAL_ROOT_UID and GLOBAL_ROOT_GID definitions,
and add appropriate include files."?

> 
> /Jarkko
> 
