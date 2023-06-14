Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF272A24F
	for <lists+linux-security-module@lfdr.de>; Fri,  9 Jun 2023 20:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjFISc5 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 9 Jun 2023 14:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjFISc4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Jun 2023 14:32:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464013A97
        for <linux-security-module@vger.kernel.org>; Fri,  9 Jun 2023 11:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2FE465ACD
        for <linux-security-module@vger.kernel.org>; Fri,  9 Jun 2023 18:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD2BC433D2;
        Fri,  9 Jun 2023 18:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686335558;
        bh=STU3Tv/r0O1GGB8jYK3ZFllhddnik3Om6vxPQUm4bLA=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=hKdJTBA5wzWbKUuXr3OU99zHGJItn9ohuD/HnEMljD/26ZuNhFbPRzNmPW3603wuU
         IAIkwI2kYJOx8qXP290PX4jE1B68fstBFKDF0PCZGlb0UmZ0miskGe83psow8K6+az
         VySR0XAo703UeIg8bLaDHMY5OgWCjE6X7Mme9m2jScr+fQSmyh/HZ4AdPBrYVnUtpH
         qCepXc4cDg7R5gmIZGtMolit+No0mzHseh7uWiOlq7J2e7/IRgVYIv3e1d2bOAl07m
         N6sHSiYDfS9tspYodga0L1muxuVOXmk9Jt6pjxKnqmGm3rBfYGbDhVdNPdNT7HK3DT
         cTSjFidFap5Lw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id D6AC827C0054;
        Fri,  9 Jun 2023 14:32:36 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Fri, 09 Jun 2023 14:32:36 -0400
X-ME-Sender: <xms:RHCDZF4HJYIdEHTCxb4ujXc5cgTmrJHcXnv6OTqEja-lDXHOo2kY8Q>
    <xme:RHCDZC6zAEVKrcZCTk46kPHdbjjupwL2tDVhLQiEeGLpE6OOzeo6SczvtlJtBPizf
    KajXNcu9L3Ea9ejVtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtkedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:RHCDZMf2DwwnP3eFfkfrAzcRwrunEEnJHUQY_z_0EX1RQ1QbaByNAg>
    <xmx:RHCDZOJI2tBdvkjCBAxGWR1soxZD2rijQE9CCLwb6QFb6J-XRFXdAA>
    <xmx:RHCDZJLYB3PIsj0mXFr5RtEyXgPjFVJvpz39iRa1WHtkXfYaH5410w>
    <xmx:RHCDZHgEB7AxNh0jPTXoEYRMutaEMUFnCZ1sUpcWaZTDqwBU52fqqQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7937A31A0063; Fri,  9 Jun 2023 14:32:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
Date:   Fri, 09 Jun 2023 11:32:16 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Andrii Nakryiko" <andrii@kernel.org>, bpf@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
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

On Wed, Jun 7, 2023, at 4:53 PM, Andrii Nakryiko wrote:
> This patch set introduces new BPF object, BPF token, which allows to delegate
> a subset of BPF functionality from privileged system-wide daemon (e.g.,
> systemd or any other container manager) to a *trusted* unprivileged
> application. Trust is the key here. This functionality is not about allowing
> unconditional unprivileged BPF usage. Establishing trust, though, is
> completely up to the discretion of respective privileged application that
> would create a BPF token.
>

I skimmed the description and the LSFMM slides.

Years ago, I sent out a patch set to start down the path of making the bpf() API make sense when used in less-privileged contexts (regarding access control of BPF objects and such).  It went nowhere.

Where does BPF token fit in?  Does a kernel with these patches applied actually behave sensibly if you pass a BPF token into a container?  Giving a way to enable BPF in a container is only a small part of the overall task -- making BPF behave sensibly in that container seems like it should also be necessary.
