Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47AE2EA842
	for <lists+linux-security-module@lfdr.de>; Tue,  5 Jan 2021 11:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbhAEKLo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 5 Jan 2021 05:11:44 -0500
Received: from smtp-42af.mail.infomaniak.ch ([84.16.66.175]:41381 "EHLO
        smtp-42af.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728016AbhAEKLo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Jan 2021 05:11:44 -0500
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4D97YX59sPzMqSQR;
        Tue,  5 Jan 2021 11:10:56 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4D97YV4fMjzlh8T2;
        Tue,  5 Jan 2021 11:10:54 +0100 (CET)
Subject: Re: [PATCH v2 0/5] Enable root to update the blacklist keyring
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20201211190330.2586116-1-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <67945fa6-2796-bfcd-5541-d54662e9802a@digikod.net>
Date:   Tue, 5 Jan 2021 11:12:57 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20201211190330.2586116-1-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Jarkko, David, what is the status of this patch series? Do you need help
to test it?

On 11/12/2020 20:03, Mickaël Salaün wrote:
> Hi,
> 
> This second patch series includes some minor fixes and remove the 4 fix
> patches picked by David Howells.  This patch series can then be applied
> on top of
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-fixes
> 
> The goal of these patches is to add a new configuration option to enable
> the root user to load signed keys in the blacklist keyring.  This
> keyring is useful to "untrust" certificates or files.  Enabling to
> safely update this keyring without recompiling the kernel makes it more
> usable.
> 
> Previous patch series:
> https://lore.kernel.org/lkml/20201120180426.922572-1-mic@digikod.net/
> 
> Regards,
> 
> Mickaël Salaün (5):
>   certs: Make blacklist_vet_description() more strict
>   certs: Factor out the blacklist hash creation
>   certs: Check that builtin blacklist hashes are valid
>   certs: Allow root user to append signed hashes to the blacklist
>     keyring
>   tools/certs: Add print-cert-tbs-hash.sh
> 
>  MAINTAINERS                                   |   2 +
>  certs/.gitignore                              |   1 +
>  certs/Kconfig                                 |  10 +
>  certs/Makefile                                |  15 +-
>  certs/blacklist.c                             | 202 ++++++++++++++----
>  crypto/asymmetric_keys/x509_public_key.c      |   3 +-
>  include/keys/system_keyring.h                 |  14 +-
>  scripts/check-blacklist-hashes.awk            |  37 ++++
>  .../platform_certs/keyring_handler.c          |  26 +--
>  tools/certs/print-cert-tbs-hash.sh            |  91 ++++++++
>  10 files changed, 326 insertions(+), 75 deletions(-)
>  create mode 100755 scripts/check-blacklist-hashes.awk
>  create mode 100755 tools/certs/print-cert-tbs-hash.sh
> 
> 
> base-commit: 1b91ea77dfeb2c5924ab940f2e43177c78a37d8f
> 
