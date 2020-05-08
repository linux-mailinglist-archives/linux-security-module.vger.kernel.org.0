Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A476C1CA26E
	for <lists+linux-security-module@lfdr.de>; Fri,  8 May 2020 06:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgEHEyT (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 8 May 2020 00:54:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58991 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725865AbgEHEyS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 May 2020 00:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588913657;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+BH4TenlCplFqY4LfV4/xPxDpNHfh9hRZl8/P0YOWA=;
        b=jMu44hv/uGIfGIacGSfHEyXuTB/MXfdqWW+fQcJOhyWmWsqRgt2An/7IBXhtQ3Fc6TTbIH
        4m6J46b92hsiiGD1X8LKXuuimKhIqWcJNusLrByB942DV6iT3UVxjTmuI3jQK1kVOlzcDf
        CCjrktvvFhzQM4XZviiWZQ418CevwOQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-nVgfAIAdPcO6JmsIFAipeQ-1; Fri, 08 May 2020 00:54:14 -0400
X-MC-Unique: nVgfAIAdPcO6JmsIFAipeQ-1
Received: by mail-qv1-f69.google.com with SMTP id ce16so581065qvb.15
        for <linux-security-module@vger.kernel.org>; Thu, 07 May 2020 21:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=W+BH4TenlCplFqY4LfV4/xPxDpNHfh9hRZl8/P0YOWA=;
        b=I4XzpJ+gg3T6/EwWWyJZUoWeNA4Ky3Thq3RVOd+rONck70+1o4gZX4iH2DiAzzOHg/
         wkjaM3o8+/UEEVCWKugTbtuAjEJESy5wjHRkkBwd83ISdPERBbqhbZzQ+45ojeFgK/pv
         jVeimTZ+Rmpbu9CFXJ/01mqXGc92jMTQylvLI2jtMsoGKBjyMTcui6dInRzYn6h9LuQw
         plnF8wLHrtycyf6cAOBfuBQpxM3JsuWGZsujQCBP4H0ETGBSPrGaF4BqqbksJvbSxSeO
         F7lf0QZIb7oxMXzCPjIDEaEMl8P6NA/ZIWJYGaeikSxPaaWaksJcfYC1Ilr0hHq6yKPR
         YWBg==
X-Gm-Message-State: AGi0Puawcpku/ii1PcWrPRB+yRfPzZJVsLlh56mNpFyro6Eri4O6X/yR
        or3kY+w4r6JG7rrg0MeCW6LO9G4FCXgnbAPu7FsNpJASjluFrKW+Nl9AJDcwRSG0PeakPwbpxmV
        mRN4rBlyiv53QDqyE5zBz1p2zqajex+gS9A+a
X-Received: by 2002:a05:620a:137a:: with SMTP id d26mr981418qkl.326.1588913653470;
        Thu, 07 May 2020 21:54:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypKpCzh7dC75r/MEmmnhuO4dvSN1lWqIA2UHRHPDduq9JF8X3WqJrMJ1jfKbHh4DRXapi4o3bQ==
X-Received: by 2002:a05:620a:137a:: with SMTP id d26mr981403qkl.326.1588913653191;
        Thu, 07 May 2020 21:54:13 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id j20sm565484qtr.5.2020.05.07.21.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 21:54:12 -0700 (PDT)
Date:   Thu, 7 May 2020 21:54:10 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/7] ima: Switch to ima_hash_algo for boot aggregate
Message-ID: <20200508045410.t7gawyklyecupe2u@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        silviu.vlasceanu@huawei.com, stable@vger.kernel.org
References: <20200325104712.25694-1-roberto.sassu@huawei.com>
 <20200325104712.25694-2-roberto.sassu@huawei.com>
 <1585871617.7311.5.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1585871617.7311.5.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu Apr 02 20, Mimi Zohar wrote:
>Hi Roberto,
>
>On Wed, 2020-03-25 at 11:47 +0100, Roberto Sassu wrote:
>> boot_aggregate is the first entry of IMA measurement list. Its purpose is
>> to link pre-boot measurements to IMA measurements. As IMA was designed to
>> work with a TPM 1.2, the SHA1 PCR bank was always selected even if a
>> TPM 2.0 with support for stronger hash algorithms is available.
>>
>> This patch first tries to find a PCR bank with the IMA default hash
>> algorithm. If it does not find it, it selects the SHA256 PCR bank for
>> TPM 2.0 and SHA1 for TPM 1.2. Ultimately, it selects SHA1 also for TPM 2.0
>> if the SHA256 PCR bank is not found.
>>
>> If none of the PCR banks above can be found, boot_aggregate file digest is
>> filled with zeros, as for TPM bypass, making it impossible to perform a
>> remote attestation of the system.
>>
>> Cc: stable@vger.kernel.org # 5.1.x
>> Fixes: 879b589210a9 ("tpm: retrieve digest size of unknown algorithms with PCR read")
>> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>
>Thank you!  This patch set is now queued in next-integrity-testing
>during the open window.  Jerry, I assume this works for you.  Could we
>get your tag?
>
>thanks!
>
>Mimi
>

Hi Mimi,

Yes, I no longer get the errors with this patch.


Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>


Regards,
Jerry

