Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8243073BB44
	for <lists+linux-security-module@lfdr.de>; Fri, 23 Jun 2023 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjFWPMJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 23 Jun 2023 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjFWPLZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Jun 2023 11:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14215270E
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 08:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11E0B61A98
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 15:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF50CC433BB;
        Fri, 23 Jun 2023 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687533055;
        bh=QBE/kH9Q80W4WJgITS8+fO0pjyCVTYSsyr+2jnkMnpU=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=ZVPko1/injThMSOKx4LYVq42w7G4RXDkA3YrJ69K9WBDDKioNw+ni3s+kEsKQWBPR
         17WtdzZsKuiYv/zwoFPNpgOd3QG0o5919aJBYDcxivGA1T7NgRbutPsrr2CmqT1xqX
         T+6U9Ei82rc/YvYfcYniL+gPOxcFDZ7sebOqYTDP1s58gH53bH/kkJJjup4Qr/IGCQ
         kAehtGjo7v5wg6kXkgajRN2aqPmhJRoJ833Dn+EcOk/lpLQnMkhf7qSe0MZ78JR2+S
         xYyctu9KMab4P3CMdY5upz8uHxNTHKBHe5JrF7jvFrXw6aSnM+nEThUNKnZKTV0prb
         lKwcsihgjv/qA==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8D9C327C005B;
        Fri, 23 Jun 2023 11:10:53 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Fri, 23 Jun 2023 11:10:53 -0400
X-ME-Sender: <xms:_bWVZBDpLFg3qKAQdsRgRE2kSK41_YU9fsMuDt-PQOto4yDZBiRxvg>
    <xme:_bWVZPi3OeePMktmI2FFLOMFy0x0rT4MiEYubXA737O3J-2O-g8tEm1CqYKLQEU7h
    7g_8BQNnW9OnHyp5y8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeggedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:_bWVZMl83O41PIIoJ_aQGs4GF8z0dEzLtYzo3VTqa9bUEZoeheS0Ug>
    <xmx:_bWVZLwjLWjaxFmsj-1i4MdnZW1bi3yQugItIDfdsjjLI6ZMbIK-Cg>
    <xmx:_bWVZGTj5h6QEngz8WgDmCzIOMH73u_wrIw7xj3iqfEsnh5U9UOHcQ>
    <xmx:_bWVZDQw4XdIDDmcQWLpETLFOofa1qvqop1hvO_eq2KbxFMAqD__OA>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F34CE31A0063; Fri, 23 Jun 2023 11:10:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <9b0e9227-4cf4-4acb-ba88-52f65b099709@app.fastmail.com>
In-Reply-To: <82b79e57-a0ad-4559-abc9-858e0f51fbba@app.fastmail.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
 <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
 <5a75d1f0-4ed9-399c-4851-2df0755de9b5@redhat.com>
 <CAEf4Bza9GvJ0vw2-0M8GKSXmOQ8VQCmeqEiQpMuZBjwqpA03vw@mail.gmail.com>
 <82b79e57-a0ad-4559-abc9-858e0f51fbba@app.fastmail.com>
Date:   Fri, 23 Jun 2023 08:10:32 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
        "Maryam Tahhan" <mtahhan@redhat.com>
Cc:     "Andrii Nakryiko" <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Kees Cook" <keescook@chromium.org>,
        "Christian Brauner" <brauner@kernel.org>, lennart@poettering.net,
        cyphar@cyphar.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On Thu, Jun 22, 2023, at 6:02 PM, Andy Lutomirski wrote:
> On Thu, Jun 22, 2023, at 11:40 AM, Andrii Nakryiko wrote:
>
>> Hopefully you can see where I'm going with this. And this is just one
>> random tiny example. We can think up tons of other cases to prove BPF
>> is not isolatable to any sort of "container".
>
> No.  You have not come up with an example of why BPF is not isolatable 
> to a container.  You have come up with an example of why binding to a 
> sched_switch raw tracepoint does not make sense in a container without 
> additional mechanisms to give it well defined functionality and 
> appropriate security.

Thinking about this some more:

Suppose the goal is to allow a workload in a container to monitor itself by attaching to a tracepoint (something in the scheduler, for example).  The workload is in the container.  The tracepoint is global.  Kernel memory is global unless something that is trusted and understands the containers is doing the reading.  And proxying BPF is a mess.

So here are a couple of possible solutions:

(a) Improve BPF maps a bit so that BPF maps work well in containers.  It should be possible to create a map and share it (the file descriptor!) between the outside and the container without running into various snags.  (IIRC my patch series was a decent step in this direction,)  Now load the BPF program and attach it to the tracepoint outside the container but have it write its gathered data to the map that's in the container.  So you end up with a daemon outside the container that gets a request like "help me monitor such-and-such by running BPF program such-and-such (where the BPF program code presumably comes from a library outside the container", and the daemon arranges for the requesting container to have access to the map it needs to get the data.

(b) Make a way to pass a pre-approved program into a container.  So a daemon outside loads the program and does some new magic to say "make an fd that can be used to attach this particular program to this particular tracepoint" and pass that into the container.

I think (a) is better.  In particular, if you have a workload with many containers, and they all want to monitor the same tracepoint as it relates to their container, you will get much better performance if a single BPF program does the monitoring and sends the data out to each container as needed instead of having one copy of the program per container.

For what it's worth, BPF tokens seem like they'll have the same performance problem -- without coordination, you can end up with N containers generating N hooks all targeting the same global resource, resulting in overhead that scales linearly with the number of containers.

And, again, I'm not an XDP expert, but if you have one NIC, and you attach N XDP programs to it, and each one is inspecting packets and sending some to one particular container's AF_XDP socket, you are not going to get good performance.  You want *one* XDP program fanning the packets out to the relevant containers.

If this is hard right now, perhaps you could add new kernel mechanisms as needed to improve the situation.

--Andy
