Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D01D6474
	for <lists+linux-security-module@lfdr.de>; Sun, 17 May 2020 00:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgEPWOU (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 16 May 2020 18:14:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35058 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgEPWOT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 16 May 2020 18:14:19 -0400
Received: by linux.microsoft.com (Postfix, from userid 1029)
        id BE57820B717B; Sat, 16 May 2020 15:14:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE57820B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1589667257;
        bh=snQA8e5UPF7RYST6vOttqczg0QEhodtAgr/CG72qmDM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=GFQEkSUChdP9ijldDnE99RaLqe60G9nu/YTSOJFYny8tH8UKXrCoY2ccZSWVc3+ed
         pskmycAVpYpiG4WbQdPOE/yMc9QzuJ3CYkqkIhQseJzCvk4z/TsdChZcUdJdlJGtu7
         jGvncEl7hvygYUJat3OkxsA998irsOIYxcVKTUDo=
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id B34633070322;
        Sat, 16 May 2020 15:14:17 -0700 (PDT)
Date:   Sat, 16 May 2020 15:14:17 -0700 (PDT)
From:   Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
X-X-Sender: jaskarankhurana@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc:     Deven Bowers <deven.desai@linux.microsoft.com>, agk@redhat.com,
        axboe@kernel.dk, snitzer@redhat.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, jannh@google.com,
        tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, nramas@linux.microsoft.com,
        mdsakib@linux.microsoft.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net
Subject: Re: [RFC PATCH v3 00/12] Integrity Policy Enforcement LSM (IPE)
In-Reply-To: <44fb36ae-959d-4ff7-ed1f-ccfc2e292232@digikod.net>
Message-ID: <alpine.LRH.2.21.2005161420490.8455@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <20200415162550.2324-1-deven.desai@linux.microsoft.com> <b07ac7e1-7cf5-92c9-81d0-64174c3d5024@digikod.net> <0001755a-6b2a-b13b-960c-eb0b065c8e3c@linux.microsoft.com> <8ba7b15f-de91-40f7-fc95-115228345fce@linux.microsoft.com>
 <44fb36ae-959d-4ff7-ed1f-ccfc2e292232@digikod.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="656392-2094691721-1589667257=:8455"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--656392-2094691721-1589667257=:8455
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT


Hello Mickael,

On Thu, 14 May 2020, Micka�l Sala�n wrote:

>
> On 12/05/2020 22:46, Deven Bowers wrote:
>>
>>
>> On 5/11/2020 11:03 AM, Deven Bowers wrote:
>>>
>>>
>>> On 5/10/2020 2:28 AM, Micka�l Sala�n wrote:
>>>
>>> [...snip]
>>>
>>>>>
>>>>> Additionally, rules are evaluated top-to-bottom. As a result, any
>>>>> revocation rules, or denies should be placed early in the file to
>>>>> ensure
>>>>> that these rules are evaluated before a rule with "action=ALLOW" is
>>>>> hit.
>>>>>
>>>>> IPE policy is designed to be forward compatible and backwards
>>>>> compatible,
>>>>> thus any failure to parse a rule will result in the line being ignored,
>>>>> and a warning being emitted. If backwards compatibility is not
>>>>> required,
>>>>> the kernel commandline parameter and sysctl, ipe.strict_parse can be
>>>>> enabled, which will cause these warnings to be fatal.
>>>>
>>>> Ignoring unknown command may lead to inconsistent beaviors. To achieve
>>>> forward compatibility, I think it would be better to never ignore
>>>> unknown rule but to give a way to userspace to known what is the current
>>>> kernel ABI. This could be done with a securityfs file listing the
>>>> current policy grammar.
>>>>
>>>
>>> That's a fair point. From a manual perspective, I think this is fine.
>>> A human-user can interpret a grammar successfully on their own when new
>>> syntax is introduced.
>>>
>>> �From a producing API perspective, I'd have to think about it a bit
>>> more. Ideally, the grammar would be structured in such a way that the
>>> userland
>>> interpreter of this grammar would not have to be updated once new syntax
>>> is introduced, avoiding the need to update the userland binary. To do so
>>> generically ("op=%s") is easy, but doesn't necessarily convey sufficient
>>> information (what happens when a new "op" token is introduced?). I think
>>> this may come down to regular expression representations of valid values
>>> for these tokens, which worries me as regular expressions are incredibly
>>> error-prone[1].
>>>
>>> I'll see what I can come up with regarding this.
>>
>> I have not found a way that I like to expose some kind of grammar
>> through securityfs that can be understood by usermode to parse the
>> policy. Here's what I propose as a compromise:
>>
>> ����1. I remove the unknown command behavior. This address your
>> first point about inconsistent behaviors, and effectively removes the
>> strict_parse sysctl (as it is always enabled).
>>
>> ����2. I introduce a versioning system for the properties
>> themselves. The valid set of properties and their versions
>> can be found in securityfs, under say, ipe/config in a key=value
>> format where `key` indicates the understood token, and `value`
>> indicates their current version. For example:
>>
>> ����$ cat $SECURITYFS/ipe/config
>> ����op=1
>> ����action=1
>> ����policy_name=1
>> ����policy_version=1
>> ����dmverity_signature=1
>> ����dmverity_roothash=1
>> ����boot_verified=1
>
> The name ipe/config sounds like a file to configure IPE. Maybe something
> like ipe/config_abi or ipe/config_grammar?
>
>>
>> if new syntax is introduced, the version number is increased.
>>
>> ����3. The format of those versions are documented as part of
>> the admin-guide around IPE. If user-mode at that point wants to rip
>> the documentation formats and correlate with the versioning, then
>> it fulfills the same functionality as above, with out the complexity
>> around exposing a parsing grammar and interpreting it on-the-fly.
>> Many of these are unlikely to move past version 1, however.
>>
>> Thoughts?
>>
>
> That seems reasonable.
>

There is a use case for not having strict parsing in the cloud world where 
there are multiple versions of OS deployed across a large number of 
systems say 100,000 nodes. An OS update can take weeks to complete 
across all the nodes, and we end up having a heterogeneous mix of OS 
versions.

Without non-strict parsing, to fix an issue in a policy we will need to 
update the various versions of the policy (one each for all OS versions
which have different IPE policy schema). We will lose the agility we 
need to fix and deploy something urgently in the policy, the nodes might 
be failing some critical workloads meanwhile. All the various versions of 
the policy will need to be changed and production signed then deployed 
etc. Further some versions might introduce newer issues and we will need 
to see what all versions of the policy have that bug.

I propose keeping the non-strict option as well to cater to this use case. 
Let me know your thoughts on this.

Regards,
JK
--656392-2094691721-1589667257=:8455--
