Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12807B4874
	for <lists+linux-security-module@lfdr.de>; Sun,  1 Oct 2023 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbjJAPoX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 1 Oct 2023 11:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjJAPoX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 1 Oct 2023 11:44:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BABDD3
        for <linux-security-module@vger.kernel.org>; Sun,  1 Oct 2023 08:44:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FC6C433C7;
        Sun,  1 Oct 2023 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696175061;
        bh=/IsxbXaX8ShRWS7iabtsMjh/RPNy74azDw8MnY7ouUY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=pPGl0/a3hN0QDnnZUXEY/nvf8D2fGZ78ZGJIWoHvZqW58MhXdNi0P8kPVPaEgYuhC
         GxF6CrcV2nVuB7TzlvmsvZziyoq4qKUG3RPjD8pJNGpdpFyUbfSqHKufYLQ7NCsiHz
         LzkVBCAu9UA0WbW6c6UHUNvlKaQ/MgXBVMP0rrtJa68tI+hsw7Y7ujXGckp0h1+Ql4
         zOLk9fvY5qYTlbjEnzY/oV9VrmBwbPq82RMREMl9ByYyK6EC4oMb6SXwRzSAHYRV9z
         NF829XrP3R9rkikN/OSrXf1iZgNH4x4twlHfkqy6PHhB2hk/viNJugFpMDCHoWo2ZG
         VNwFG/WWo7f/Q==
Date:   Sun, 01 Oct 2023 08:44:15 -0700
From:   Kees Cook <kees@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
User-Agent: K-9 Mail for Android
In-Reply-To: <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp> <57295dac-9abd-3bac-ff5d-ccf064947162@schaufler-ca.com> <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
Message-ID: <06BC106C-E0FD-4ACA-83A8-DFD1400B696E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On October 1, 2023 4:31:05 AM PDT, Tetsuo Handa <penguin-kernel@I-love=2ESA=
KURA=2Ene=2Ejp> wrote:
>Kees Cook said there is no problem if the policy of assigning LSM ID valu=
e were
>
>  1) author: "Hello, here is a new LSM I'd like to upstream, here it is=
=2E I assigned
>              it the next LSM ID=2E"
>     maintainer(s): "Okay, sounds good=2E *review*"
>
>  2) author: "Hello, here is an LSM that has been in active use at $Place=
,
>              and we have $Xxx many userspace applications that we cannot=
 easily
>              rebuild=2E We used LSM ID $Value that is far away from the =
sequential
>              list of LSM IDs, and we'd really prefer to keep that assign=
ment=2E"
>    maintainer(s): "Okay, sounds good=2E *review*"
>
>and I agreed at https://lkml=2Ekernel=2Eorg/r/6e1c25f5-b78c-8b4e-ddc3-484=
129c4c0ec@I-love=2ESAKURA=2Ene=2Ejp =2E
>
>But Paul Moore's response was
>
>  No LSM ID value is guaranteed until it is present in a tagged release
>  from Linus' tree, and once a LSM ID is present in a tagged release
>  from Linus' tree it should not change=2E  That's *the* policy=2E
>
>which means that the policy is not what Kees Cook has said=2E

These don't conflict at all! Paul is saying an ID isn't guaranteed in upst=
ream until it's in upstream=2E I'm saying the id space is large enough that=
 you could make a new out of tree LSM every second for the next billion yea=
rs=2E The upstream assignment process is likely sequential, but that out of=
 sequence LSMs that show a need to be upstream could make a case for their =
existing value=2E

But again, I've already demonstrated how there is nothing technical blocki=
ng out of tree LSMs=2E If you want a declarative statement that some theore=
tical code will land upstream, you will not get it=2E And that's just norma=
l FLOSS development: any number of technical, social, or political things m=
ay cause code to go unaccepted=2E

-Kees


--=20
Kees Cook
