Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD53745C7A2
	for <lists+linux-security-module@lfdr.de>; Wed, 24 Nov 2021 15:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245356AbhKXOmW (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 24 Nov 2021 09:42:22 -0500
Received: from fgw20-4.mail.saunalahti.fi ([62.142.5.107]:29039 "EHLO
        fgw20-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346520AbhKXOmP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Nov 2021 09:42:15 -0500
Received: from toshiba (88-113-3-224.elisa-laajakaista.fi [88.113.3.224])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 0147b8b0-4d32-11ec-8d6d-005056bd6ce9;
        Wed, 24 Nov 2021 16:22:51 +0200 (EET)
Message-ID: <619E4ABA.DC78AA58@users.sourceforge.net>
Date:   Wed, 24 Nov 2021 16:22:50 +0200
From:   Jari Ruusu <jariruusu@users.sourceforge.net>
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alistair Delva <adelva@google.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Serge Hallyn <serge@hallyn.com>, Jens Axboe <axboe@kernel.dk>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5.10 130/154] block: Check ADMIN before NICE for 
 IOPRIO_CLASS_RT
References: <20211124115702.361983534@linuxfoundation.org> <20211124115706.507376250@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Greg Kroah-Hartman wrote:
> From: Alistair Delva <adelva@google.com>
> 
> commit 94c4b4fd25e6c3763941bdec3ad54f2204afa992 upstream.
 [SNIP]
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -69,7 +69,14 @@ int ioprio_check_cap(int ioprio)
> 
>         switch (class) {
>                 case IOPRIO_CLASS_RT:
> -                       if (!capable(CAP_SYS_NICE) && !capable(CAP_SYS_ADMIN))
> +                       /*
> +                        * Originally this only checked for CAP_SYS_ADMIN,
> +                        * which was implicitly allowed for pid 0 by security
> +                        * modules such as SELinux. Make sure we check
> +                        * CAP_SYS_ADMIN first to avoid a denial/avc for
> +                        * possibly missing CAP_SYS_NICE permission.
> +                        */
> +                       if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
>                                 return -EPERM;
>                         fallthrough;
>                         /* rt has prio field too */

What exactly is above patch trying to fix?
It does not change control flow at all, and added comment is misleading.

-- 
Jari Ruusu  4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD  ACDF F073 3C80 8132 F189
