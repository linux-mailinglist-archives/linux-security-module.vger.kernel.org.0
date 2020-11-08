Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A842AA8B7
	for <lists+linux-security-module@lfdr.de>; Sun,  8 Nov 2020 02:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgKHBOk (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 7 Nov 2020 20:14:40 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56732 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgKHBOk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 7 Nov 2020 20:14:40 -0500
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0A81DxVN060525;
        Sun, 8 Nov 2020 10:13:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Sun, 08 Nov 2020 10:13:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0A81Dx49060520
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 8 Nov 2020 10:13:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 1/2] tomoyo: Convert get_user_pages*() to
 pin_user_pages*()
To:     John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
 <e5401549-8c31-2c6d-58dd-864232de17af@nvidia.com>
 <e6859981-bc3c-9513-99e5-a99849786156@nvidia.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5efeb909-3e02-ba14-7a86-f18562a2fe69@i-love.sakura.ne.jp>
Date:   Sun, 8 Nov 2020 10:13:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e6859981-bc3c-9513-99e5-a99849786156@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020/11/08 4:17, John Hubbard wrote:
> On 11/7/20 1:04 AM, John Hubbard wrote:
>> On 11/7/20 12:24 AM, Souptick Joarder wrote:
>>> In 2019, we introduced pin_user_pages*() and now we are converting
>>> get_user_pages*() to the new API as appropriate. [1] & [2] could
>>> be referred for more information. This is case 5 as per document [1].
>>
>> It turns out that Case 5 can be implemented via a better pattern, as long
>> as we're just dealing with a page at a time, briefly:
>>
>> lock_page()
>> write to page's data
>> unlock_page()
>>
>> ...which neatly synchronizes with writeback and other fs activities.
> 
> Ahem, I left out a key step: set_page_dirty()!
> 
> lock_page()
> write to page's data
> set_page_dirty()
> unlock_page()
> 

Excuse me, but Documentation/core-api/pin_user_pages.rst says 
"CASE 5: Pinning in order to _write_ to the data within the page"
while tomoyo_dump_page() is for "_read_ the data within the page".
Do we want to convert to pin_user_pages_remote() or lock_page() ?
