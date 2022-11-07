Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085E961FFDB
	for <lists+linux-security-module@lfdr.de>; Mon,  7 Nov 2022 21:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiKGUwo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 7 Nov 2022 15:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiKGUwn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Nov 2022 15:52:43 -0500
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8A42AE36
        for <linux-security-module@vger.kernel.org>; Mon,  7 Nov 2022 12:52:41 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4N5k2H4r7ZzMpnbb;
        Mon,  7 Nov 2022 21:52:39 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4N5k2H2Q8GzMppDq;
        Mon,  7 Nov 2022 21:52:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1667854359;
        bh=LsKR82sVsWCqO8UUXv5FsIMGkxlff8w1JGMowFHG88E=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=DKtuNqwrnVJXc2kJIcxw7TxYVxZExGZFhWpcFv1JyaUppXCu9PBfLRCHq8uRtE1is
         ZdBdAE7WuLPwDeMUXWmkOVTk3WDe6AdhH30Gz+CzylAQ9PI5vR1z4fBiNkH+N5xsbp
         wz132/YM/rJyGAuuzSRB6fPX4lLvnjQa6xkwQAVk=
Message-ID: <9e517d5e-76d3-9125-bf96-74ee522fe0f9@digikod.net>
Date:   Mon, 7 Nov 2022 21:52:38 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v3] samples/landlock: Document best-effort approach for
 LANDLOCK_ACCESS_FS_REFER
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
References: <20221107181651.4555-1-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221107181651.4555-1-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks! Pushed to my -next branch.

On 07/11/2022 19:16, Günther Noack wrote:
> Add a comment to clarify how to handle best-effort backwards
> compatibility for LANDLOCK_ACCESS_FS_REFER.
> 
> The "refer" access is special because these operations are always
> forbidden in ABI 1, unlike most other operations, which are permitted
> when using Landlock ABI levels where they are not supported yet.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   samples/landlock/sandboxer.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index fd4237c64fb2..e2056c8b902c 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -234,7 +234,22 @@ int main(const int argc, char *const argv[], char *const *const envp)
>   	/* Best-effort security. */
>   	switch (abi) {
>   	case 1:
> -		/* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
> +		/*
> +		 * Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2
> +		 *
> +		 * Note: The "refer" operations (file renaming and linking
> +		 * across different directories) are always forbidden when using
> +		 * Landlock with ABI 1.
> +		 *
> +		 * If only ABI 1 is available, this sandboxer knowingly forbids
> +		 * refer operations.
> +		 *
> +		 * If a program *needs* to do refer operations after enabling
> +		 * Landlock, it can not use Landlock at ABI level 1.  To be
> +		 * compatible with different kernel versions, such programs
> +		 * should then fall back to not restrict themselves at all if
> +		 * the running kernel only supports ABI 1.
> +		 */
>   		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
>   		__attribute__((fallthrough));
>   	case 2:
> 
> base-commit: 4bc90a766ea5af69c12ca1ea00b7fc5fe1d68831
