Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC629B71
	for <lists+linux-security-module@lfdr.de>; Fri, 24 May 2019 17:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbfEXPrA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 24 May 2019 11:47:00 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32969 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389079AbfEXPrA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 May 2019 11:47:00 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 27C5215AA8D2C4377753;
        Fri, 24 May 2019 16:46:59 +0100 (IST)
Received: from [10.204.65.201] (10.204.65.201) by smtpsuk.huawei.com
 (10.201.108.34) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 24 May
 2019 16:46:57 +0100
Subject: Re:
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mjg59@google.com>, <vgoyal@redhat.com>
References: <20190521000645.16227-1-prsriva02@gmail.com>
 <20190521000645.16227-3-prsriva02@gmail.com>
 <1558710722.3977.68.camel@linux.ibm.com>
 <a7acac28-156e-80d1-b759-cb0c59f73169@huawei.com>
Message-ID: <cb0eb785-9050-738e-c1bf-8e769fe096fa@huawei.com>
Date:   Fri, 24 May 2019 17:47:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <a7acac28-156e-80d1-b759-cb0c59f73169@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.204.65.201]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/24/2019 5:42 PM, Roberto Sassu wrote:
> On 5/24/2019 5:12 PM, Mimi Zohar wrote:
>> On Mon, 2019-05-20 at 17:06 -0700, Prakhar Srivastava wrote:
>>> A buffer(cmdline args) measured into ima cannot be appraised
>>> without already being aware of the buffer contents.Since we
>>> don't know what cmdline args will be passed (or need to validate
>>> what was passed) it is not possible to appraise it.
>>>
>>> Since hashs are non reversible the raw buffer is needed to
>>> recompute the hash.
>>> To regenrate the hash of the buffer and appraise the same
>>> the contents of the buffer need to be available.
>>>
>>> A new template field buf is added to the existing ima template
>>> fields, which can be used to store/read the buffer itself.
>>> Two new fields are added to the ima_event_data to carry the
>>> buf and buf_len whenever necessary.
>>>
>>> Updated the process_buffer_measurement call to add the buf
>>> to the ima_event_data.
>>> process_buffer_measurement added in "Add a new ima hook
>>> ima_kexec_cmdline to measure cmdline args"
>>>
>>> - Add a new template field 'buf' to be used to store/read
>>> the buffer data.
>>> - Added two new fields to ima_event_data to hold the buf and
>>> buf_len [Suggested by Roberto]
>>> -Updated process_buffer_meaurement to add the buffer to
>>> ima_event_data
>>
>> This patch description can be written more concisely.
>>
>> Patch 1/3 in this series introduces measuring the kexec boot command
>> line.  This patch defines a new template field for storing the kexec
>> boot command line in the measurement list in order for a remote
>> attestation server to verify.
>>
>> As mentioned, the first patch description should include a shell
>> command for verifying the digest in the kexec boot command line
>> measurement list record against /proc/cmdline.  This patch description
>> should include a shell command showing how to verify the digest based
>> on the new field.  Should the new field in the ascii measurement list
>> be displayed as a string, not hex?
> 
> We should define a new type. If the type is DATA_FMT_STRING, spaces are
> replaced with '_'.

Or better. Leave it as hex, otherwise there would be a parsing problem
if there are spaces in the data for a field.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
