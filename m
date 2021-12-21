Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED4047C8AF
	for <lists+linux-security-module@lfdr.de>; Tue, 21 Dec 2021 22:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhLUVM6 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 21 Dec 2021 16:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhLUVM5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Dec 2021 16:12:57 -0500
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F1BC061574
        for <linux-security-module@vger.kernel.org>; Tue, 21 Dec 2021 13:12:57 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4JJTgq02NCzMqPGX;
        Tue, 21 Dec 2021 22:12:55 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4JJTgp0qLfzlhNtr;
        Tue, 21 Dec 2021 22:12:54 +0100 (CET)
Message-ID: <ea3b1671-95b3-3cf0-9d0e-8b4c3303ad4d@digikod.net>
Date:   Tue, 21 Dec 2021 22:15:21 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     yusongping <yusongping@huawei.com>,
        Artem Kuzin <artem.kuzin@huawei.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "netfilter@vger.kernel.org" <netfilter@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20211210072123.386713-1-konstantin.meskhidze@huawei.com>
 <b50ed53a-683e-77cf-9dc2-f4ae1b5fa0fd@digikod.net>
 <12467d8418f04fbf9fd4a456a2a999f1@huawei.com>
 <b535d1d4-3564-b2af-a5e8-3ba6c0fa86c9@digikod.net>
 <c8588051-8795-9b8a-cb36-f5440b590581@digikod.net>
 <a1769c4239ee4e8aadb65f9ebb6061d8@huawei.com>
 <c325e5f6-d8d5-b085-fd2d-7f454629a1ec@digikod.net>
 <dc1866cec3134c51939a5fa104359b6c@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [RFC PATCH 0/2] Landlock network PoC implementation
In-Reply-To: <dc1866cec3134c51939a5fa104359b6c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 20/12/2021 04:52, Konstantin Meskhidze wrote:
> Hi, Mickaёl!
> 
> -----Original Message-----
> From: Mickaël Salaün <mic@digikod.net>
> Sent: Saturday, December 18, 2021 7:01 PM
> To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: yusongping <yusongping@huawei.com>; Artem Kuzin <artem.kuzin@huawei.com>; linux-security-module <linux-security-module@vger.kernel.org>; Network Development <netdev@vger.kernel.org>; netfilter@vger.kernel.org; Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Subject: Re: [RFC PATCH 0/2] Landlock network PoC implementation
> 
> 
> On 18/12/2021 09:26, Konstantin Meskhidze wrote:
>> Hi, Mickaёl
>> Thanks again for your opinion about minimal Landlock IPv4 network version.
>> I have already started refactoring the code.
>> Here are some additional thoughts about the design.
> 
> [...]
> 
>>>>
>>>> Accesses/suffixes should be:
>>>> - CREATE
>>>> - ACCEPT
>>>> - BIND
>>>> - LISTEN
>>>> - CONNECT
>>>> - RECEIVE (RECEIVE_FROM and SEND_TO should not be needed)
>>>> - SEND
>>>> - SHUTDOWN
>>>> - GET_OPTION (GETSOCKOPT)
>>>> - SET_OPTION (SETSOCKOPT)
>>
>>>> For now, the only access rights should be LANDLOCK_ACCESS_NET_BIND_TCP and LANDLOCK_ACCESS_NET_CONNECT_TCP (tie to two LSM hooks with struct sockaddr).
>>
>>>> These attribute and access right changes reduce the scope of the
>>>> network access control and make it simpler but still really useful. Datagram (e.g. UDP, which could add BIND_UDP and SEND_UDP) sockets will be more complex to restrict correctly and should then come in another patch series, once TCP is supported.
>>
>> I think that having access rights like LANDLOCK_ACCESS_NET_CREATE_TCP_SOCKET_DENY/LANDLOCK_ACCESS_NET_CREATE_UDP_SOCKET_DENY might be useful during initialization phase of container/sandbox, cause a user could have the possibility to restrict the creation of some type of sockets at all, and to reduce the attack surface related to security aspect.
>> So the logic could be the following:
>> 	1. Process restricts creation UDP sockets, allows TCP one.
>> 		- LANDLOCK_ACCESS_NET_CREATE_*_SOCKET_DENY rules are tied to process task_struct cause there are no sockets inodes created at this moment.
>> 	2. Creates necessary number of sockets.
>> 	3. Restricts sockets' access rights.
>> 		- LANDLOCK_ACCESS_NET_BIND_* / LANDLOCK_ACCESS_NET_CONNECT_* access rights are tied to sockets inodes individually.	
>>
> 
>>   Reducing the attack surface on the kernel is valuable but not the primary goal of Landlock. seccomp is designed for this task and a seccomp filters can easily forbid creation of specific sockets. We should consider using > both Landlock and seccomp, and your use case of denying UDP vs. TCP is good.
> 
>> Anyway, the LANDLOCK_ACCESS_NET_CREATE_TCP_SOCKET_DENY name in not appropriate. Indeed, mixing "access" and "deny" doesn't make sense. A LANDLOCK_ACCESS_NET_CREATE_TCP access could be useful if > > we can define such TCP socket semantic, e.g. with a port, which is not possible when creating a socket, and it is OK.
> 
> I think we can define if it’s a TCP or UDP socket in the moment of its creating using TYPE field in socket(domain, TYPE, protocol) function:
> 	- TCP services use SOCK_STREAM type.
> 	- UDP ones use SOCK_DGRAM type.
> So we can have LANDLOCK_ACCESS_NET_CREATE_TCP access rule in TCP socket semantic, and therefore check socket_create(domain, SOCK_STREAM, protocol) hook.
> The similar rule( LANDLOCK_ACCESS_NET_CREATE_UPD) could be used for recognizing UDP sockets in future patches.
> 

Allowing or forbidding socket creation is easy (and can also be done 
with seccomp), but it is not an access control per se (i.e. a socket 
doesn't give access to any data, but communicating with a peer does). 
Restricting access to network peers makes sense for Landlock, but not 
(only) file descriptor creation for now. In the future, this kind of 
restriction could make sense to implement Capsicum but it would probably 
be another interface.
