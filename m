Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43365295F9D
	for <lists+linux-security-module@lfdr.de>; Thu, 22 Oct 2020 15:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899471AbgJVNSG (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 22 Oct 2020 09:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899461AbgJVNSF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Oct 2020 09:18:05 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4F8C0613D5
        for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2020 06:18:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c17so1005527pjo.5
        for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2020 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=c5p1zV1CqKVH8prpsj7PEX/s64deTtbH6mLHz/sTWPo=;
        b=sPxj/eeSkGniZwpwGV+0kEAq//Ks1jlWunt480rMLYVSZRIi4xZOoKAn9mkn5HYPkN
         Fkw7AxIajl0UYvbLyw5iKfkrY3DUZs7/K5NVP0ecCTnIx4XoITfdeSBZU9NLP3nJbR+F
         m/CP8lnN5y45pgRiZup/NSe3sXBPCK7l1KQFu1/5XhbAsdix6UTYgjsk5NHZUggsf+R+
         buouCHVOu8EJVTknoEH0SXsWkVrr8c8UNxqUbrsdOW6XsWwDwjpR++Idct8cm2lU+IO3
         4ycrvMIJ47PM0kZ2TAbRvP2JqSFxdRFAQ6RAz6wopnTtNzOjDYWuHQiGClajvFJGWlHo
         G06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c5p1zV1CqKVH8prpsj7PEX/s64deTtbH6mLHz/sTWPo=;
        b=UgrF6MVNZNaOMYM92uuhUEqwKm7+jmf+PiHkido8oIsIBRBERzZHJS0/qoYMaYD1t2
         iIBHuN6qVwrU8s5g/IYT3US+LNiuR3FFQv2/w5K1X4QlDmsUrRfDRTT3KceCMJ/aR4I0
         J/61iW3oVXl7KaLnaeSfN8fSP1IABE0sP76d0zIvW1lOOPmcuuVtNeNF7fTS+weTEP4c
         Ek/7MfspHATeTgbC5Hr2eS4hTtoiPBvD4ySP//nVHfG7cmWjYe6ivsyPygxNQq5XwNxY
         DOgelyNCEs+ZjBH06IL5VX6TaAGkkNJHPLm20lyuH3y+v+fO82YbybJ2yl0nQMO2WmEz
         ttYQ==
X-Gm-Message-State: AOAM531d1feGQw4cFLlhegK6E4jqUDsbx7tgLXq/RH4JtWZDMUnzAvcs
        KVg6NhY+6qvAylyhvC+cLrW4oA==
X-Google-Smtp-Source: ABdhPJxFrJ8OvG+hbFts8koI3B46u1glVYhDvP6t0s8IfoVfSWdoLhC5db0WuzzwbxtbgXYlT10aAw==
X-Received: by 2002:a17:902:b40a:b029:d5:f77c:fb4e with SMTP id x10-20020a170902b40ab02900d5f77cfb4emr2576354plr.14.1603372684980;
        Thu, 22 Oct 2020 06:18:04 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:4a0f:cfff:fe35:d61b])
        by smtp.googlemail.com with ESMTPSA id w19sm2248589pfn.174.2020.10.22.06.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 06:18:04 -0700 (PDT)
Subject: Re: [RESEND PATCH v18 0/4] overlayfs override_creds=off & nested get
 xattr fix
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <20201021151903.652827-1-salyzyn@android.com>
 <20201022051914.GI857@sol.localdomain>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <ea67453d-e5de-7c3a-e1da-d1e5ac30b2dd@android.com>
Date:   Thu, 22 Oct 2020 06:18:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022051914.GI857@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/21/20 10:19 PM, Eric Biggers wrote:
> On Wed, Oct 21, 2020 at 08:18:59AM -0700, Mark Salyzyn wrote:
>> Mark Salyzyn (3):
>>    Add flags option to get xattr method paired to __vfs_getxattr
>>    overlayfs: handle XATTR_NOSECURITY flag for get xattr method
>>    overlayfs: override_creds=off option bypass creator_cred
>>
>> Mark Salyzyn + John Stultz (1):
>>    overlayfs: inode_owner_or_capable called during execv
>>
>> The first three patches address fundamental security issues that should
>> be solved regardless of the override_creds=off feature.
>>
>> The fourth adds the feature depends on these other fixes.
> FYI, I didn't receive patch 4, and neither https://lkml.kernel.org/linux-fsdevel
> nor https://lkml.kernel.org/linux-unionfs have it either.
>
> - Eric

Resent again, thanks.

