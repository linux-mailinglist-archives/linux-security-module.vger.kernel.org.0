Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190172308B
	for <lists+linux-security-module@lfdr.de>; Mon, 20 May 2019 11:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfETJju (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 20 May 2019 05:39:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32956 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727720AbfETJju (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 May 2019 05:39:50 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 4A75E6FA85003A8236AE;
        Mon, 20 May 2019 10:39:48 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 20 May
 2019 10:39:40 +0100
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <viro@zeniv.linux.org.uk>, <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zohar@linux.vnet.ibm.com>,
        <silviu.vlasceanu@huawei.com>, <dmitry.kasatkin@huawei.com>,
        <takondra@cisco.com>, <kamensky@cisco.com>, <arnd@arndb.de>,
        <rob@landley.net>, <james.w.mcmechan@gmail.com>,
        <niveditas98@gmail.com>
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
 <20190517165519.11507-3-roberto.sassu@huawei.com>
 <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
 <20190517210219.GA5998@rani.riverdale.lan>
 <d48f35a1-aab1-2f20-2e91-5e81a84b107f@zytor.com>
 <20190517221731.GA11358@rani.riverdale.lan>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <7bdca169-7a01-8c55-40e4-a832e876a0e5@huawei.com>
Date:   Mon, 20 May 2019 11:39:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190517221731.GA11358@rani.riverdale.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/18/2019 12:17 AM, Arvind Sankar wrote:
> On Fri, May 17, 2019 at 02:47:31PM -0700, H. Peter Anvin wrote:
>> On 5/17/19 2:02 PM, Arvind Sankar wrote:
>>> On Fri, May 17, 2019 at 01:18:11PM -0700, hpa@zytor.com wrote:
>>>>
>>>> Ok... I just realized this does not work for a modular initramfs, composed at load time from multiple files, which is a very real problem. Should be easy enough to deal with: instead of one large file, use one companion file per source file, perhaps something like filename..xattrs (suggesting double dots to make it less likely to conflict with a "real" file.) No leading dot, as it makes it more likely that archivers will sort them before the file proper.
>>> This version of the patch was changed from the previous one exactly to deal with this case --
>>> it allows for the bootloader to load multiple initramfs archives, each
>>> with its own .xattr-list file, and to have that work properly.
>>> Could you elaborate on the issue that you see?
>>>
>>
>> Well, for one thing, how do you define "cpio archive", each with its own
>> .xattr-list file? Second, that would seem to depend on the ordering, no,
>> in which case you depend critically on .xattr-list file following the
>> files, which most archivers won't do.
>>
>> Either way it seems cleaner to have this per file; especially if/as it
>> can be done without actually mucking up the format.
>>
>> I need to run, but I'll post a more detailed explanation of what I did
>> in a little bit.
>>
>> 	-hpa
>>
> Not sure what you mean by how do I define it? Each cpio archive will
> contain its own .xattr-list file with signatures for the files within
> it, that was the idea.
> 
> You need to review the code more closely I think -- it does not depend
> on the .xattr-list file following the files to which it applies.
> 
> The code first extracts .xattr-list as though it was a regular file. If
> a later dupe shows up (presumably from a second archive, although the
> patch will actually allow a second one in the same archive), it will
> then process the existing .xattr-list file and apply the attributes
> listed within it. It then will proceed to read the second one and
> overwrite the first one with it (this is the normal behaviour in the
> kernel cpio parser). At the end once all the archives have been
> extracted, if there is an .xattr-list file in the rootfs it will be
> parsed (it would've been the last one encountered, which hasn't been
> parsed yet, just extracted).
> 
> Regarding the idea to use the high 16 bits of the mode field in
> the header that's another possibility. It would just require additional
> support in the program that actually creates the archive though, which
> the current patch doesn't.

Yes, for adding signatures for a subset of files, no changes to the ram
disk generator are necessary. Everything is done by a custom module. To
support a generic use case, it would be necessary to modify the
generator to execute getfattr and the awk script after files have been
placed in the temporary directory.

If I understood the new proposal correctly, it would be task for cpio to
read file metadata after the content and create a new record for each
file with mode 0x18000, type of metadata encoded in the file name and
metadata as file content. I don't know how easy it would be to modify
cpio. Probably the amount of changes would be reasonable.

The kernel will behave in a similar way. It will call do_readxattrs() in
do_copy() for each file. Since the only difference between the current
and the new proposal would be two additional calls to do_readxattrs() in
do_name() and unpack_to_rootfs(), maybe we could support both.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
