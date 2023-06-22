Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205E973A669
	for <lists+linux-security-module@lfdr.de>; Thu, 22 Jun 2023 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjFVQuT (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 22 Jun 2023 12:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjFVQuS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Jun 2023 12:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43FB1B4
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jun 2023 09:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 737BC618C4
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jun 2023 16:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9E3C433C0;
        Thu, 22 Jun 2023 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687452615;
        bh=W5B1EoieuFITn7VHZ5d47xW7gpUpfyKhprvwWti/EZQ=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=c8hNyHt5HJbKVyWN9tIHLGLU3FzWVV6jEybouRn0u6xcHVD5UXGRQ4k+eyY1M8Btt
         uIdbrd0bwDbr2LMQLnHNWBtOGKrCzGeSuVq2Np/pW1PM7CjN080JOx8oFXFJ68AiS6
         ZG8zIvi3vrd+4xtTPlYez+jMsFRsAUJErtHuBRThV/uiNSIQ7HX0iJKwL3Td4Eu5U+
         zmS6iReRued9On6c46db4YLE4NNyDXyjNai7jHW6jNGKRbp2Qvd2sCfVNU2ZkgmRYP
         Ta/62mSy0vakTotMQDWrEMxNo3rRbESwlOH7EwjZRHK7PYTcbrx5CCeFMpAR7rbZks
         O3DXerUa+tGOw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6274827C0054;
        Thu, 22 Jun 2023 12:50:14 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Thu, 22 Jun 2023 12:50:14 -0400
X-ME-Sender: <xms:xXuUZPPvN1Fit3S_cC-7mb5s4ztTGzZxHyCre3Cx8mh0X5MtI39xYA>
    <xme:xXuUZJ-YXwxrTVLTw6bhJmlafzLawIkAYxjperneH7JIJJpG98c3Ca1FdoYXapqDt
    fVD8RaJPqjcN7SHlv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehnugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepteeggedtfeejteekueejieetleehteduvefhuefgvefftdet
    hfeugfekueefjefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdphhhtthhpthhorg
    hmrghgihgtihhprghnughpohhrthdrhihouhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsoh
    hnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghr
    nhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:xXuUZOQtx7O8nk3a3PkpXH200fEB5CD-dMg7X7j8-2C_v0xz3kj1iw>
    <xmx:xXuUZDvOHMrXRzb3BgzjudsV1m1xfiMknDWmsIM0hfuijC6OrASGwA>
    <xmx:xXuUZHeVNHQX6_cdQpv-udWds47gmzqylCHaAaNzgrvBKtlFHpJSxw>
    <xmx:xnuUZJuI7J3CchXjGuARcNxxFHJY9XTqmJzIBhR3ChhNt1ibo9Z5Gw>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BFBBA31A0063; Thu, 22 Jun 2023 12:50:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
In-Reply-To: <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
Date:   Thu, 22 Jun 2023 09:49:40 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Maryam Tahhan" <mtahhan@redhat.com>,
        "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc:     "Andrii Nakryiko" <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Kees Cook" <keescook@chromium.org>,
        "Christian Brauner" <brauner@kernel.org>, lennart@poettering.net,
        cyphar@cyphar.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On Thu, Jun 22, 2023, at 1:22 AM, Maryam Tahhan wrote:
> On 22/06/2023 00:48, Andrii Nakryiko wrote:
>>
>>>>> Giving a way to enable BPF in a container is only a small part of =
the overall task -- making BPF behave sensibly in that container seems l=
ike it should also be necessary.
>>>> BPF is still a privileged thing. You can't just say that any
>>>> unprivileged application should be able to use BPF. That's why BPF
>>>> token is about trusting unpriv application in a controlled environm=
ent
>>>> (production) to not do something crazy. It can be enforced further
>>>> through LSM usage, but in a lot of cases, when dealing with internal
>>>> production applications it's enough to have a proper application
>>>> design and rely on code review process to avoid any negative effect=
s.
>>> We really shouldn=E2=80=99t be creating new kinds of privileged cont=
ainers that do uncontained things.
>>>
>>> If you actually want to go this route, I think you would do much bet=
ter to introduce a way for a container manager to usefully proxy BPF on =
behalf of the container.
>> Please see Hao's reply ([0]) about his and Google's (not so rosy)
>> experiences with building and using such BPF proxy. We (Meta)
>> internally didn't go this route at all and strongly prefer not to.
>> There are lots of downsides and complications to having a BPF proxy.
>> In the end, this is just shuffling around where the decision about
>> trusting a given application with BPF access is being made. BPF proxy
>> adds lots of unnecessary logistical, operational, and development
>> complexity, but doesn't magically make anything safer.
>>
>>    [0] https://lore.kernel.org/bpf/CA+khW7h95RpurRL8qmKdSJQEXNYuqSWnP=
16o-uRZ9G0KqCfM4Q@mail.gmail.com/
>>
> Apologies for being blunt, but=C2=A0 the token approach to me seems to=
 be a=20
> work around providing the right level/classification for a pod/contain=
er=20
> in order to say you support unprivileged containers using eBPF. I thin=
k=20
> if your container needs to do privileged things it should have and be=20
> classified with the right permissions (privileges) to do what it needs=20
> to do.

Bluntness is great.

I think that this whole level/classification thing is utterly wrong.  Re=
place "BPF" with basically anything else, and you'll see how absurd it i=
s.

"the token approach to me seems like a work around providing the right l=
evel/classification for a pod/container in order to say you support unpr=
ivileged containers using files on disk"

That's very 1990's.  Maybe 1980's.  Of *course* giving access to a files=
ystem has some inherent security exposure.  So we can give containers ac=
cess to *different* filesystems.  Or we can use ACLs.  Or MAC policy.  O=
r whatever.  We have many solutions, none of which are perfect, and we'r=
e doing okay.

"the token approach to me seems like a work around providing the right l=
evel/classification for a pod/container in order to say you support unpr=
ivileged containers using the network"

The network is a big deal.  For some reason, it's cool these days to tre=
at TCP as highly privileged.  You can get secrets from your favorite (or=
 least favorite) cloud provider with unauthenticated HTTP to a magic IP =
and port.  You can bypass a whole lot of authenticating/authorizing prox=
ies with unauthenticated HTTP (no TLS!) if you're on the right network.

This is IMO obnoxious, but we deal with it by having network namespaces =
and firewalls and rather outdated port <=3D 1024 rules.

"the token approach to me seems like a work around providing the right l=
evel/classification for a pod/container in order to say you support unpr=
ivileged containers using BPF"

My response is: what's wrong with BPF?  BPF has maps and programs and su=
ch, and we could easily apply 1990's style ownership and DAC rules to th=
em.  I even *wrote the code*.  But for some reason, the BPF community wa=
nts to bury its head in the sand, pretend it's 1980, declare that BPF is=
 too privileged to have access control, and instead just have a complica=
ted switch to turn it on and off in different contexts.

Please try harder.
