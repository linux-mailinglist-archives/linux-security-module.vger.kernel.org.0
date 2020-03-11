Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9182D181687
	for <lists+linux-security-module@lfdr.de>; Wed, 11 Mar 2020 12:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgCKLGb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 11 Mar 2020 07:06:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:33554 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgCKLGb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Mar 2020 07:06:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E1E4FB297;
        Wed, 11 Mar 2020 11:06:29 +0000 (UTC)
Date:   Wed, 11 Mar 2020 12:06:28 +0100
Message-ID: <s5hwo7rnoaz.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tomoyo: Use scnprintf() for avoiding potential buffer overflow
In-Reply-To: <fbe60125-091d-c536-36a0-5cfab2eff707@i-love.sakura.ne.jp>
References: <20200311093627.25409-1-tiwai@suse.de>
        <fbe60125-091d-c536-36a0-5cfab2eff707@i-love.sakura.ne.jp>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 11 Mar 2020 11:20:44 +0100,
Tetsuo Handa wrote:
> 
> On 2020/03/11 18:36, Takashi Iwai wrote:
> > Since snprintf() returns the would-be-output size instead of the
> > actual output size, the succeeding calls may go beyond the given
> > buffer limit.  Fix it by replacing with scnprintf().
> > 
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  security/tomoyo/audit.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> Thanks for a patch. But current code will simply hit WARN_ON_ONCE() in vsnprintf()
> if the would-be-output size went beyond the given buffer limit, and we have never
> hit that warning from this function. That is, the buffer limit is large enough,
> and the last byte is guaranteed to be '\0'.

Right, I don't think this actually hitting the overflow, either.
If the code is intended to rely on the sanity check in vsnprintf(),
it's fine.  But I find it a bit fragile and would prefer more explicit
check in the caller side instead.


thanks,

Takashi
