Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE102C6064
	for <lists+linux-security-module@lfdr.de>; Fri, 27 Nov 2020 08:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392697AbgK0HR0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 27 Nov 2020 02:17:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7996 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392683AbgK0HRZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Nov 2020 02:17:25 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cj5Xy4XlbzhcYm;
        Fri, 27 Nov 2020 15:17:06 +0800 (CST)
Received: from [10.174.178.154] (10.174.178.154) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 27 Nov
 2020 15:17:12 +0800
Subject: Re: [PATCH] tomoyo: Avoid potential null pointer access
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jmorris@namei.org>,
        <serge@hallyn.com>, <weiyongjun1@huawei.com>
References: <20201125121043.107662-1-zhengzengkai@huawei.com>
 <cfc96d99-adff-6eb9-9685-422587830eb8@i-love.sakura.ne.jp>
 <01d29bbf-9d77-c787-b2c2-d88a6a5047f7@huawei.com>
 <59e0abdd-88a9-6269-9cd1-0f65792784ec@i-love.sakura.ne.jp>
From:   Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <dfb6829e-0fb6-7dbc-5dfa-9707b2f0ae16@huawei.com>
Date:   Fri, 27 Nov 2020 15:17:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <59e0abdd-88a9-6269-9cd1-0f65792784ec@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Tetsuo,
> On 2020/11/26 15:33, Zheng Zengkai wrote:
>> As your say,  I found the function tomoyo_assign_namespace( )
>>
>> in security/tomoyo/domain.c has the similar situation,
>>
>> Can I add __GFP_NOWARN for both and remove the null check for _entry_ in tomoyo_assign_namespace( )?
>>
> Good catch. Yes, please send as a patch.
> .

I have resent a patch, thanks!

