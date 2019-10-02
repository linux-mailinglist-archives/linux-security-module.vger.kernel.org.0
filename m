Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3BEC86B7
	for <lists+linux-security-module@lfdr.de>; Wed,  2 Oct 2019 12:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfJBKvL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 2 Oct 2019 06:51:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61743 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfJBKvL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Oct 2019 06:51:11 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x92Ap0xH091030;
        Wed, 2 Oct 2019 19:51:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Wed, 02 Oct 2019 19:51:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x92Aoru9090973
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 2 Oct 2019 19:51:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
References: <0000000000004f43fa058a97f4d3@google.com>
 <201906060520.x565Kd8j017983@www262.sakura.ne.jp>
 <1b5722cc-adbc-035d-5ca1-9aa56e70d312@I-love.SAKURA.ne.jp>
 <a4ed1778-8b73-49d1-0ff0-59d9c6ac0af8@I-love.SAKURA.ne.jp>
 <20190618204933.GE17978@ZenIV.linux.org.uk>
 <8f874b03-b129-205f-5f05-125479701275@i-love.sakura.ne.jp>
 <bc146372-764d-93a9-af27-666d73ed3af5@i-love.sakura.ne.jp>
 <alpine.LRH.2.21.1907061944050.2662@namei.org>
 <alpine.LRH.2.21.1907061949040.2662@namei.org>
 <289ebc65-8444-37e3-e54e-21b55d2c9192@i-love.sakura.ne.jp>
 <a28f2680-bafc-5e23-4eea-6b432f561cd4@i-love.sakura.ne.jp>
 <A9CE5147-4047-4C42-B772-F0ED510FA283@canb.auug.org.au>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <36906718-d2ae-3514-c6b2-371037c98da5@i-love.sakura.ne.jp>
Date:   Wed, 2 Oct 2019 19:50:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <A9CE5147-4047-4C42-B772-F0ED510FA283@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/09/14 16:36, Stephen Rothwell wrote:
> Hi,
> 
> I am on vacation until after the merge window closes, so I will add it then.
> Please remind me if I don't.

Did you return from the vacation?

> 
> Cheers,
> Stephen Rothwell 
> 
> On 13 September 2019 2:41:24 pm GMT+01:00, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> Hello, Stephen Rothwell.
>>
>> Can you add https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1.git#master
>> into the list for linux-next.git tree?
