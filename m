Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E05F30AD04
	for <lists+linux-security-module@lfdr.de>; Mon,  1 Feb 2021 17:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhBAQtl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 1 Feb 2021 11:49:41 -0500
Received: from smtp-8fad.mail.infomaniak.ch ([83.166.143.173]:47361 "EHLO
        smtp-8fad.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231584AbhBAQtg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Feb 2021 11:49:36 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DTv6707XSzMqPjY;
        Mon,  1 Feb 2021 17:48:47 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DTv636kvnzlh8TS;
        Mon,  1 Feb 2021 17:48:43 +0100 (CET)
Subject: Re: [PATCH v5 0/5] Enable root to update the blacklist keyring
To:     David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20210128191705.3568820-1-mic@digikod.net>
 <4160652.1612184844@warthog.procyon.org.uk>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <9d95ec74-cc89-9e0c-dac8-c05ea52991ac@digikod.net>
Date:   Mon, 1 Feb 2021 17:48:26 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <4160652.1612184844@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

Yes, you can pull this patchset from here:
https://github.com/l0kod/linux branch dyn-auth-blacklist-v5 (commit
33b94bcd56843b4235c6ba4a44157b3c5a8792f1).

 Mickaël


On 01/02/2021 14:07, David Howells wrote:
> 
> Hi Mickaël,
> 
> Do you have a public branch somewhere I can pull from?
> 
> David
> 
