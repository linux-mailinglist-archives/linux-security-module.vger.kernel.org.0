Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088F074796C
	for <lists+linux-security-module@lfdr.de>; Tue,  4 Jul 2023 23:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjGDVGr (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 4 Jul 2023 17:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGDVGr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Jul 2023 17:06:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0ED10C9
        for <linux-security-module@vger.kernel.org>; Tue,  4 Jul 2023 14:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC5F36137B
        for <linux-security-module@vger.kernel.org>; Tue,  4 Jul 2023 21:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B6BC433C8;
        Tue,  4 Jul 2023 21:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688504805;
        bh=jTJXMuycxtbjbPhCmDl31JsIwZY1+YlwTav8RHw3ofE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=qNXmmgGm7H4pVBKPlKFpT1TCCziFgX42r2fbca1qV1pvBz0t1vTe/WEZipAzH7R1p
         jPei9fVYGanesbmoBg3qBla6Br/n291FnmoMhNoWuIVZGtdyyawPJSM4RqFzQRjgg6
         us9PSC16wAhZZ6bBkCuLohIQFJTG2Z9OGZKfd+RftLtdHc1E37vFy94sOTGOl0wnYg
         ogWt5Ay5Cw/qPphFnc8hfSs4JFlLBhNDKmDkHCmq5QcNJ+eVeNjPOxx5j+HwLtN0s8
         Np5ODzf56i7PwBZcuCakLuEg0htYp7yiRP2nvJ7OfqUjotkpr4woAnui0xIEsXWMvm
         ZFZYIv6MSlfNQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id AEE5027C0054;
        Tue,  4 Jul 2023 17:06:43 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 04 Jul 2023 17:06:43 -0400
X-ME-Sender: <xms:44mkZBHa_am8b9oTGYNLdyEngVBmPWUUnRrRNZslYF4bSym4LkknSw>
    <xme:44mkZGU7o4AHwDc0riWlayTNZMEpfHjP-MKd3hWNTGAPlyaAqo3HCUb8TPcaiQyFs
    qyclZQM8xJOZyQXMfI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeggdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:44mkZDJgWbsAQX_i6gAKuHbujsIV9TSV_3PCQ2ADQ9P1NfPbYsrM8A>
    <xmx:44mkZHFNdmDxrJ00JyGYLLxfVAYGQlwsgj-S0ch6wJ_cZ3qjquvfGw>
    <xmx:44mkZHVDYvqSGJ0P0ohHMOqsLGpJmHPsI0-asGzhrSQIzSps4dtdEQ>
    <xmx:44mkZDq5yNI7PrmWX_ciGNMHiWDI2vQ9U2vtmmiTdzb5cvXmJqjctA>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6F7FB31A0064; Tue,  4 Jul 2023 17:06:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Mime-Version: 1.0
Message-Id: <ebe24a54-0900-45bc-85c6-46f8e1be101f@app.fastmail.com>
In-Reply-To: <640eeef7-48df-464e-a49f-d7ee31193e04@app.fastmail.com>
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
 <9b0e9227-4cf4-4acb-ba88-52f65b099709@app.fastmail.com>
 <173f0af7-e6e1-f4b7-e0a6-a91b7a4da5d7@iogearbox.net>
 <fe47aeb6-dae8-43a6-bcb0-ada2ebf62e08@app.fastmail.com>
 <8340aaf2-8b4c-4f7d-8eed-f72f615f6fd0@app.fastmail.com>
 <77fc8c9b-220f-da93-c6b8-a8f36eb1086f@iogearbox.net>
 <640eeef7-48df-464e-a49f-d7ee31193e04@app.fastmail.com>
Date:   Tue, 04 Jul 2023 14:06:19 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
        "Maryam Tahhan" <mtahhan@redhat.com>
Cc:     "Andrii Nakryiko" <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Kees Cook" <keescook@chromium.org>,
        "Christian Brauner" <brauner@kernel.org>, lennart@poettering.net,
        cyphar@cyphar.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On Tue, Jul 4, 2023, at 1:48 PM, Andy Lutomirski wrote:
> On Mon, Jun 26, 2023, at 8:23 AM, Daniel Borkmann wrote:
>> On 6/24/23 5:28 PM, Andy Lutomirski wrote:
>>
>> Wasn't this the idea of the BPF tokens proposal, meaning you could 
>> create them with
>> restricted access as you mentioned - allowing an explicit subset of 
>> program types to
>> be loaded, subset of helpers/kfuncs, map types, etc.. Given you pass in 
>> this token
>> context upon program load-time (resp. map creation), the verifier is 
>> then extended
>> for restricted access. For example, see the 
>> bpf_token_allow_{cmd,map_type,prog_type}()
>> in this series. The user namespace relation was part of the use cases, 
>> but not strictly
>> part of the mechanism itself in this series.
>
> Hmm. It's very coarse grained.
>
> Also, the bpf() attach API seems to be largely (completely?) missing 
> what I would expect to be basic access controls on the things being 
> attached to.   For example, the whole cgroup_bpf_prog_attach() path 
> seems to be entirely missing any checks as to whether its caller has 
> any particular permission over the cgroup in question.  It doesn't even 
> check whether the cgroup is being accessed from the current userns 
> (i.e. whether the fd refers to a struct file with f_path.mnt belonging 
> to the current userns).  So the API in this patchset has no way to 
> restrict permission to attach to cgroups to only apply to cgroups 
> belonging to the container.
>

Forgot to mention: there's also no way to limit the functions that can be called.  While it's currently a bit of a pipe dream to do much useful work without bpf_probe_kernel_read(), it's at least conceptually possible to accomplish quite a bit without it, but there's no way to make that be part of the policy.
