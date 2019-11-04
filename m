Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819D8EEB66
	for <lists+linux-security-module@lfdr.de>; Mon,  4 Nov 2019 22:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfKDVrj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 4 Nov 2019 16:47:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39797 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbfKDVrj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Nov 2019 16:47:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id x28so10199681pfo.6
        for <linux-security-module@vger.kernel.org>; Mon, 04 Nov 2019 13:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jVdp7lHPSLMEIaA4b3xI6KcYYdtPyzFWzQ17PK3XP4Q=;
        b=RhUkrzOZU4hM75KmE1n1Xc+DqHEZwOMbC9p2Q8ZftFTVxMW4fh94I9YTuMmh1r+s0K
         vqVvfX2hwsNckCL2SDa7gbc9eULatsKkcOLZGR21BQ9KrbfQYOEFc1Bc9PfnOINJbpqG
         H/6rVmaSvYgq1CiuduCzFZX4G+DZBQq90WHuR0JAW6vnKULq10QgCN/+afABpB5+3o+R
         t+Jy6OzwuqoB+e0xXeTS105YJdChtbZtKwR/I7TBDgGdg0pWennWIgMxMYdRIYfJeYBY
         8Q7/GZS6lMcWQPGCMfz1pJzgyaHSbiju6+nJCIPuWM9tGH3WS6vZYfPoq4MWgNUsEKIE
         CYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jVdp7lHPSLMEIaA4b3xI6KcYYdtPyzFWzQ17PK3XP4Q=;
        b=cd5sixShBrVMTNYd649FnsZveootwGZBxhhZC12Yz9i7wPAI6UkwXsOL2BfM2H/ViZ
         GNV1YqDwoLHWIZaI9da8mF/ILEzYA8QTz9/n5N/Ya5cGRZkSy11BaJzPYZ+QerjOuizX
         SHt4FrcwhHPgrdXC6G4l9kZAxQ89FhtyI2/gz1Srnm/vJc4qMf8P8+8mL3YTcYiefbpt
         +kHRydMOo+gMjGYSfcOPAPS0wsXrSDYhWwCnPM/jZRlQyBeH4n0wWInPDQ57f2a74gKl
         2o9kYejERs7P8demHxB1Z5sGXAL9wGfDPHhw5PPtratU91dsW17BdRZZ0tCTmqT2AAcd
         0TaA==
X-Gm-Message-State: APjAAAXo2jEa7hrBe0S/iTpEtFBqP6qVHTzD1IRZUkbSAtRcLL3gmNeE
        Wcuk/oteiLFkz68JoPSnBqIR2bei5ZRb1g==
X-Google-Smtp-Source: APXvYqyQKx8i/Q7YGG64yTbpKjKN6h7zLFv2aq2ytfgVLXAtoelPCLRRO87DQvTXmY0yUIF75hMztg==
X-Received: by 2002:a17:90a:34c1:: with SMTP id m1mr1677748pjf.89.1572904057340;
        Mon, 04 Nov 2019 13:47:37 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id m2sm16526943pff.154.2019.11.04.13.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 13:47:36 -0800 (PST)
Subject: Re: [PATCH v14 4/5] overlayfs: internal getxattr operations without
 sepolicy checking
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>
References: <20191022204453.97058-1-salyzyn@android.com>
 <20191022204453.97058-5-salyzyn@android.com>
 <CAOQ4uxgWOmV_x5gRZ9tR+u86GE6JoXn-MSxKkvi87e9owMApZw@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <bc508a5b-13f5-7de3-7146-f17b232df9d5@android.com>
Date:   Mon, 4 Nov 2019 13:47:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgWOmV_x5gRZ9tR+u86GE6JoXn-MSxKkvi87e9owMApZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/22/19 11:39 PM, Amir Goldstein wrote:
> On Tue, Oct 22, 2019 at 11:46 PM Mark Salyzyn <salyzyn@android.com> wrote:
>> Check impure, opaque, origin & meta xattr with no sepolicy audit
>> (using __vfs_getxattr) since these operations are internal to
>> overlayfs operations and do not disclose any data.  This became
>> an issue for credential override off since sys_admin would have
>> been required by the caller; whereas would have been inherently
>> present for the creator since it performed the mount.
>>
>> This is a change in operations since we do not check in the new
>> ovl_do_vfs_getxattr function if the credential override is off or
>> not.  Reasoning is that the sepolicy check is unnecessary overhead,
>> especially since the check can be expensive.
>>
>> Because for override credentials off, this affects _everyone_ that
>> underneath performs private xattr calls without the appropriate
>> sepolicy permissions and sys_admin capability.  Providing blanket
>> support for sys_admin would be bad for all possible callers.
>>
>> For the override credentials on, this will affect only the mounter,
>> should it lack sepolicy permissions. Not considered a security
>> problem since mounting by definition has sys_admin capabilities,
>> but sepolicy contexts would still need to be crafted.
>>
> It sounds reasonable to me, but I am not a "security person".
>
>> It should be noted that there is precedence, __vfs_getxattr is used
>> in other filesystems for their own internal trusted xattr management.
>>
> Urgh! "other" filesystems meaning ecryptfs_getxattr()?
> That looks like a loop hole to read any trusted xattr without any
> security checks. Not sure its a good example...

Yes. But it also makes sense since ecryptfs_getxattr is performed inside 
a layer where the security check is done above by the filesystem that 
called it (AFAIK)? This is used by the filesystem, or the security 
layers to pull the actual sepolicy, rather than getting an EPERM and no 
data. The xattr 'data' is needed by the internal layers.

-- Mark

