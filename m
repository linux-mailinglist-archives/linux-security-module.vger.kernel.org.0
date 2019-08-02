Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFFAD7FE56
	for <lists+linux-security-module@lfdr.de>; Fri,  2 Aug 2019 18:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390127AbfHBQLL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 2 Aug 2019 12:11:11 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33111 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732543AbfHBQLL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Aug 2019 12:11:11 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C1C8DC64785C6836DBC4;
        Fri,  2 Aug 2019 17:11:09 +0100 (IST)
Received: from [10.220.135.74] (10.220.135.74) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 2 Aug
 2019 17:11:03 +0100
Subject: Re: [PATCH v2] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Tyler Hicks <tyhicks@canonical.com>
CC:     <jarkko.sakkinen@linux.intel.com>, <jejb@linux.ibm.com>,
        <zohar@linux.ibm.com>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <crazyt2019+lml@gmail.com>, <nayna@linux.vnet.ibm.com>,
        <silviu.vlasceanu@huawei.com>
References: <20190802150733.1972-1-roberto.sassu@huawei.com>
 <20190802153030.GB26616@elm>
 <3222714a-a280-0708-f4c0-5db6d342d8dc@huawei.com>
Message-ID: <8baf1c39-ad04-5cd6-bc67-341e7411db16@huawei.com>
Date:   Fri, 2 Aug 2019 18:11:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <3222714a-a280-0708-f4c0-5db6d342d8dc@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.135.74]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/2/2019 5:34 PM, Roberto Sassu wrote:
> On 8/2/2019 5:30 PM, Tyler Hicks wrote:
>> On 2019-08-02 17:07:33, Roberto Sassu wrote:
>>> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize 
>>> w/o a
>>> TPM") allows the trusted module to be loaded even a TPM is not found to
>>                                                     ^ if
>>
>>> avoid module dependency problems.
>>>
>>> However, trusted module initialization can still fail if the TPM is
>>> inactive or deactivated. This patch ignores tpm_get_random() errors in
>>> init_digests() and returns -EFAULT in pcrlock() if the TPM didn't return
>>> random data.
>>>
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> The code changes look correct to me.
>>
>>    Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
>>
>> For whoever takes this patch through their tree, I think that adding the
>> following Fixes tag would be useful (as well as cc'ing stable):
>>
>>    Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip 
>> structure...")
>>
>> I think it is also worth leaving a short note, in the commit message,
>> for backporters that commit 782779b60faa ("tpm: Actually fail on TPM
>> errors during "get random"") should be included with any backports of
>> this patch.
> 
> Right, thanks. I wait for Jarkko's comments and I add both the Fixes tag
> and the short note in the next version of the patch.

Uhm, I was thinking that maybe it is not necessary to mention commit
782779b60faa. This patch would still return 0 even if that commit is not
backported (TPM_ERR_DISABLED < TPM_MAX_DIGEST_SIZE).

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
