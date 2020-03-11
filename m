Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82EA01815A9
	for <lists+linux-security-module@lfdr.de>; Wed, 11 Mar 2020 11:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgCKKUw (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 11 Mar 2020 06:20:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52279 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgCKKUw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Mar 2020 06:20:52 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02BAKlMD040736;
        Wed, 11 Mar 2020 19:20:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Wed, 11 Mar 2020 19:20:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02BAKl2U040733
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 11 Mar 2020 19:20:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: Use scnprintf() for avoiding potential buffer
 overflow
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org
References: <20200311093627.25409-1-tiwai@suse.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <fbe60125-091d-c536-36a0-5cfab2eff707@i-love.sakura.ne.jp>
Date:   Wed, 11 Mar 2020 19:20:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311093627.25409-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020/03/11 18:36, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  security/tomoyo/audit.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Thanks for a patch. But current code will simply hit WARN_ON_ONCE() in vsnprintf()
if the would-be-output size went beyond the given buffer limit, and we have never
hit that warning from this function. That is, the buffer limit is large enough,
and the last byte is guaranteed to be '\0'.
