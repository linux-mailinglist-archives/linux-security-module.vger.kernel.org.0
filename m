Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E10A112084C
	for <lists+linux-security-module@lfdr.de>; Mon, 16 Dec 2019 15:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfLPOPX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 16 Dec 2019 09:15:23 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:64720 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbfLPOPW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Dec 2019 09:15:22 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBGEF5kv045641;
        Mon, 16 Dec 2019 23:15:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Mon, 16 Dec 2019 23:15:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBGEF4Vj045638
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 16 Dec 2019 23:15:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: Suspicious RCU usage in tomoyo code
To:     John Garry <john.garry@huawei.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
References: <9620521a-c197-d54e-438b-759e244d24b3@huawei.com>
 <ab0f5a5b-4ba4-7a11-3b17-e84c30be3d49@i-love.sakura.ne.jp>
 <20191216010458.GQ2889@paulmck-ThinkPad-P72>
 <e5135d83-db1d-72dc-c74f-c563520f8686@huawei.com>
 <fb986973-a443-1b57-f0d3-970e8be62138@i-love.sakura.ne.jp>
 <f32e108c-1e92-9522-255d-676472c3b04e@huawei.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4ef6c5c3-73b1-c2b4-ae1b-fecadbce0c5d@i-love.sakura.ne.jp>
Date:   Mon, 16 Dec 2019 23:15:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <f32e108c-1e92-9522-255d-676472c3b04e@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/12/16 22:13, John Garry wrote:
> Yeah, this looks to have fixed it:
> 
> Tested-by: John Garry <john.garry@huawei.com>
> 
> Thanks
> 

Thank you. I added this patch to tomoyo-test1.git .
