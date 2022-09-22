Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0942B5E6A12
	for <lists+linux-security-module@lfdr.de>; Thu, 22 Sep 2022 19:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiIVR6D (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 22 Sep 2022 13:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiIVR57 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Sep 2022 13:57:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E2B106501
        for <linux-security-module@vger.kernel.org>; Thu, 22 Sep 2022 10:57:57 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id cm7-20020a056830650700b006587fe87d1aso6730896otb.10
        for <linux-security-module@vger.kernel.org>; Thu, 22 Sep 2022 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TgDgY+ntTJT5LrRO/2yKf3PhPIjqGDJ5ckxVAeXb9pM=;
        b=EzxJCwqj8SUwpLATOCTQCPXxDArAx6jFOBINEfe0RkA59zcTvCk63VJoJ1bzwwuIVb
         V1mD5vSARYHIY+JC4SPQ/okkb4NfsVbzqL94CXKsz3w9yhvAfHII3L0jSoZFPnLVF9K/
         b96T0Tc7ngdEn6LxvZQF4QI0CBnLRHl8wFXus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TgDgY+ntTJT5LrRO/2yKf3PhPIjqGDJ5ckxVAeXb9pM=;
        b=odyOZmPFFnFJFqAA/vDktCJJOkwBqO09DX4gv6cirsJAY+sdGMCoJbPX3g/xFrV2bd
         WE3oQbw6p1XglDwUoqij79C/nTFH4tJ+KfhSYi8qDjsxf6ipT094Cu1fr6la/LLnqeld
         CTzmzcNTBh98clKWo9tTJG6BK3Tmu7/LuV+I9rOCLtJmYa/guNj5tnn87as6VnGEpKZJ
         ijDo/6/KntoVBlvDxLaz+iBGdMpLgke8zJdEWM53mf4pzU5X0ZEXX4cbhnFe4fT1QkIt
         yyFQlArXfOhK/VprctG0OQVVkh7Nu5+CrP8S9HIeRyTpy7/iZu0iztwWHS9wK2pTsIEz
         Ra2g==
X-Gm-Message-State: ACrzQf0lrybgdg9j6fX/DKCFuU4eKQo/rdiQj+5e6yawMHQvhROKleq9
        QOf6j/uEDY6fJw/BmSpCMj6HLTWO/ChY9Q==
X-Google-Smtp-Source: AMsMyM7DHLcOW5/t559DEF7a5fGj3Z9YlJa/90ZCo669ArTWk9tds76lewt+JW8vc1DSjyernMQ3Bw==
X-Received: by 2002:a9d:d89:0:b0:654:fc7e:f4ec with SMTP id 9-20020a9d0d89000000b00654fc7ef4ecmr2317627ots.49.1663869476412;
        Thu, 22 Sep 2022 10:57:56 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id l19-20020a4ae2d3000000b0044884c40c8asm2424582oot.30.2022.09.22.10.57.54
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 10:57:55 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-12c8312131fso14991798fac.4
        for <linux-security-module@vger.kernel.org>; Thu, 22 Sep 2022 10:57:54 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr2732855oad.126.1663869474518; Thu, 22
 Sep 2022 10:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
In-Reply-To: <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Sep 2022 10:57:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com>
Message-ID: <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/29] acl: add vfs posix acl api
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 22, 2022 at 9:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Could we please see the entire patch set on the LSM list?

While I don't think that's necessarily wrong, I would like to point
out that the gitweb interface actually does make it fairly easy to
just see the whole patch-set.

IOW, that

  https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/log/?h=fs.acl.rework

that Christian pointed to is not a horrible way to see it all. Go to
the top-most commit, and it's easy to follow the parent links.

It's a bit more work to see them in another order, but I find the
easiest way is actually to just follow the parent links to get the
overview of what is going on (reading just the commit messages), and
then after that you "reverse course" and use the browser back button
to just go the other way while looking at the details of the patches.

And I suspect a lot of people are happier *without* large patch-sets
being posted to the mailing lists when most patches aren't necessarily
at all relevant to that mailing list except as context.

                 Linus
