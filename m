Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A4B2D7E24
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Dec 2020 19:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390795AbgLKSdq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 11 Dec 2020 13:33:46 -0500
Received: from smtp-bc0f.mail.infomaniak.ch ([45.157.188.15]:45427 "EHLO
        smtp-bc0f.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393989AbgLKSdV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Dec 2020 13:33:21 -0500
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Cszsp6KkXzlh8TL;
        Fri, 11 Dec 2020 19:32:30 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Cszsm6CK0zlh8TF;
        Fri, 11 Dec 2020 19:32:28 +0100 (CET)
Subject: Re: [PATCH v1 4/9] certs: Check that builtin blacklist hashes are
 valid
To:     David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20201120180426.922572-5-mic@digikod.net>
 <20201120180426.922572-1-mic@digikod.net>
 <1221725.1607515111@warthog.procyon.org.uk>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <492d0fe7-826a-ac8f-bc41-29718ab3bb60@digikod.net>
Date:   Fri, 11 Dec 2020 19:32:28 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <1221725.1607515111@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 09/12/2020 12:58, David Howells wrote:
> Mickaël Salaün <mic@digikod.net> wrote:
> 
>> +      cmd_check_blacklist_hashes = $(AWK) -f scripts/check-blacklist-hashes.awk $(2); touch $@
> 
> The script name needs prefixing with $(srctree)/ so that it can be used with
> alternative build directories.

Right

> 
> Note that doesn't apply to scripts/extract-cert in the same makefile as that's
> a built program and is to be found in the build dir, not the sources.
> 
> Btw, I'm pulling some of your cleanups/fixes into my fixes branch.

OK, thanks. I'll send a new patch series rebased on your branch.

> 
> David
> 
