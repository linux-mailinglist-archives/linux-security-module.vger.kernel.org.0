Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA02C4F0B
	for <lists+linux-security-module@lfdr.de>; Thu, 26 Nov 2020 08:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbgKZG6F (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 26 Nov 2020 01:58:05 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59781 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388217AbgKZG6F (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Nov 2020 01:58:05 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0AQ6vn4d083776;
        Thu, 26 Nov 2020 15:57:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Thu, 26 Nov 2020 15:57:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0AQ6vnYB083773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 26 Nov 2020 15:57:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: Avoid potential null pointer access
To:     Zheng Zengkai <zhengzengkai@huawei.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        weiyongjun1@huawei.com
References: <20201125121043.107662-1-zhengzengkai@huawei.com>
 <cfc96d99-adff-6eb9-9685-422587830eb8@i-love.sakura.ne.jp>
 <01d29bbf-9d77-c787-b2c2-d88a6a5047f7@huawei.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <59e0abdd-88a9-6269-9cd1-0f65792784ec@i-love.sakura.ne.jp>
Date:   Thu, 26 Nov 2020 15:57:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <01d29bbf-9d77-c787-b2c2-d88a6a5047f7@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020/11/26 15:33, Zheng Zengkai wrote:
> As your say,  I found the function tomoyo_assign_namespace( )
> 
> in security/tomoyo/domain.c has the similar situation,
> 
> Can I add __GFP_NOWARN for both and remove the null check for _entry_ in tomoyo_assign_namespace( )?
> 

Good catch. Yes, please send as a patch.
