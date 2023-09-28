Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A6D7B180F
	for <lists+linux-security-module@lfdr.de>; Thu, 28 Sep 2023 12:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjI1KHg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 28 Sep 2023 06:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjI1KHe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Sep 2023 06:07:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3148B199
        for <linux-security-module@vger.kernel.org>; Thu, 28 Sep 2023 03:07:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ad8a822508so1645485466b.0
        for <linux-security-module@vger.kernel.org>; Thu, 28 Sep 2023 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695895648; x=1696500448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DtI3kB3DRHPB9DqqP0XY+HAtUyMDubLkneuHlzD3860=;
        b=gYiPrQmN1jhYL+x8C0LEoXUdQcqshHo58gF2gKveAmY9rYqXs3JSyK6HSznIH6b1i8
         iRV/Or2UlbUuiqfPM4vmn3DQyXSjSbZTph6iyrIYNSHjMThz1dVLZzjbULl05eZl8fp3
         crc2xqIaMfNBcq1E1iWQx3ucLokdBXwTU7fJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695895648; x=1696500448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtI3kB3DRHPB9DqqP0XY+HAtUyMDubLkneuHlzD3860=;
        b=RtNN3ClwI0nGoh9MgbUVfIY1YgPHmjGBFdRPbourvkuEWKXqL/ccVDfYkk+AbAjYhX
         qQjpT8JIL07LAJmvieMJdHxEKGZLq5K/SlCbvPPRFPUIBZVzWHEsaRBLefZMAZPA3rvB
         WoHcEuyUFksRj+MpoZNpXYV0EaI0/mQyY0Fh07VjL5a3JerW6k7rF2nNjkyD/7xvvh6+
         iOQfboO5N43qj9Yl1kbLjhYQY9VfImVBVINUYNDk9dCgvQ9pAF0X5wAfBoIxrS4afAFK
         vS0xYoC01c8pEbfxognsTrxVTHH1/jf7tvHEsYbB2IQtPpvsuUt7JbYFTKDnglX7Jxr9
         CnzQ==
X-Gm-Message-State: AOJu0YwEnDqR+I0ayyMTGWctk2WU8/BekTZAcez29DvoXgwbkmehjrnl
        hYtc8B3b7MenXmbYGKaG8Ov4E/rxL9zDCCyv3SZY8A==
X-Google-Smtp-Source: AGHT+IEDypM3eCKriTL3toxyQv8Q1keb6DT2jEmjFo0FJ1MxFnDwMp3fk9njVXSZqz8oyH0A9Xgaw9Xxa1l5dOcoVH0=
X-Received: by 2002:a17:907:7609:b0:9a5:cf23:de5b with SMTP id
 jx9-20020a170907760900b009a5cf23de5bmr846668ejc.38.1695895648586; Thu, 28 Sep
 2023 03:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-4-mszeredi@redhat.com>
 <20230917005419.397938-1-mattlloydhouse@gmail.com> <CAOssrKcECS_CvifP1vMM8YOyMW7dkGXTDTKY2CRr-fPrJk76ZA@mail.gmail.com>
 <20230918-einblick-klaut-0a010e0abc70@brauner> <CAHC9VhQsChQO9aaY+NTtmvJgXBodvXO6rUN3d7ZyHGqitLBABw@mail.gmail.com>
In-Reply-To: <CAHC9VhQsChQO9aaY+NTtmvJgXBodvXO6rUN3d7ZyHGqitLBABw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 28 Sep 2023 12:07:17 +0200
Message-ID: <CAJfpegtJwcS9=7dCAVCEoBwD_U2MX44a6B62iDsc78AZt6nM7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] add listmnt(2) syscall
To:     Paul Moore <paul@paul-moore.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 19 Sept 2023 at 18:48, Paul Moore <paul@paul-moore.com> wrote:

> > Ideally we avoid multiple capable(CAP_SYS_ADMIN) calls by only doing it
> > once and saving the return value. capable() call's aren't that cheap.
>
> Agreed.  The capability check doesn't do any subject/object
> comparisons so calling it for each mount is overkill.  However, I
> would think we would want the LSM hook called from inside the loop as
> that could involve a subject (@current) and object (individual mount
> point) comparison.

The security_sb_statfs() one?

Should a single failure result in a complete failure?

Why is it not enough to check permission on the parent?

Thanks,
Miklos
