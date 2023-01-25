Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3DD67B7EC
	for <lists+linux-security-module@lfdr.de>; Wed, 25 Jan 2023 18:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbjAYRJD (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 25 Jan 2023 12:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjAYRIn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Jan 2023 12:08:43 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30A65A81F
        for <linux-security-module@vger.kernel.org>; Wed, 25 Jan 2023 09:08:01 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id v3so13836456pgh.4
        for <linux-security-module@vger.kernel.org>; Wed, 25 Jan 2023 09:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL4e11xv+GmUFacOcRwvCqNYJ3WEjaPDuu6riYZ8W5o=;
        b=Okczn7ZItRWhjh977ouqswLR4HNMLLYBj9IDXl6Rdzvd06Fu4RqPbT9QVmdfePhfZK
         nirgjF5gXkxLLrhei7M7iSj6zEpT/5ws3XRi4mfxB0mRTsr2TT2S6AiVXK/YdeO74iJW
         XH13Q6Yb7bO4OQq7DI9dXM23B1r4NbBBiSB+zjjNbAaqQNGwCrZR2rMMH2OIePzOZ/eL
         EykJcTyBq/x7PG+0dALSsvFI1LffgH8JWI6YZTI5MOTkdnZ0yR9TVYx9HofTIoYp9mi4
         PbcgQlDFWtsKi9hYLq6nqe7IH+a3rUc1PNmpW0oYOa4A9OD8ftr2QeyvBQEwBkNbo9WW
         cZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZL4e11xv+GmUFacOcRwvCqNYJ3WEjaPDuu6riYZ8W5o=;
        b=1L6Q6GSlJYahAwAajtFkdEYfRMIDqgeYO7eYYamtgh/sqr87/gJXLJMWrmBevhoTPU
         rz5wyOnHUiaJloOiiW3TjtppBDz775l6B6lZQ1cjum7eE9tuY52S90m9fOigNXgtYlYw
         QSsObzG0yvk5L45y2GmDy/8jOIv7Ml/HfPxI2EVfA/B3ys5SBqkUL7XEtc5aC7te/YZa
         kxfAHIDXGnPJX1MMq1lvq1WeAsniQug58CCLzcU4WXvZS9oaL408T4DWkZLwjlAmSk0m
         D1wKnJGFJVywOlHspcmQAkxEKCDEjhIWX1EKcs85lfVwZPj9QhoJrDEMXv3VWboWdccw
         krhA==
X-Gm-Message-State: AFqh2kq3Rla+qFFwbuwTpnp7YCsxNXMgJiKPIxjNl/hQ6HsrrhtnWFtZ
        WxIz7jsdtdm2ItelP19GQiXYevC13Q3sge7iMB9F01OjN717
X-Google-Smtp-Source: AMrXdXupWJ8tBREWhIQtIi3TU9O3qakvdpfreLWBVJoR65PEUnCtaekjQGcelo0lRu3P4bk3KD6sLcTSU8QzxlJ6OAo=
X-Received: by 2002:a65:4d09:0:b0:4a0:8210:f47a with SMTP id
 i9-20020a654d09000000b004a08210f47amr2853810pgt.14.1674666479563; Wed, 25 Jan
 2023 09:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
 <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com>
 <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com>
 <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com>
 <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com>
 <CAHC9VhSYg-BbJvNBZd3dayYCf8bzedASoidnX23_i4iK7P-WxQ@mail.gmail.com>
 <CAHk-=wiG5wdWrx2uXRK3-i31Zp416krnu_KjmBbS3BVkiAUXLQ@mail.gmail.com>
 <CAHC9VhTg8mMHzdSPbpxvOQCWxuNuXzR7c6FJOg5+XGb-PYemRw@mail.gmail.com> <CAGudoHG-42ziSNT0g8asRj8iGzx-Gn=ETZuXkswER3Daov37=A@mail.gmail.com>
In-Reply-To: <CAGudoHG-42ziSNT0g8asRj8iGzx-Gn=ETZuXkswER3Daov37=A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 25 Jan 2023 12:07:48 -0500
Message-ID: <CAHC9VhRG2gcuuN87sKtsPeF-S2BG1DrSCHruAnCAdCkviHuS3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, serge@hallyn.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 25, 2023 at 10:00 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> On 1/24/23, Paul Moore <paul@paul-moore.com> wrote:
> > Although I'm looking at this again and realized that only
> > do_faccessat() calls access_override_creds(), so why not just fold the
> > new access_need_override_creds() logic into access_override_creds()?
> > Just have one function that takes the flag value, and returns an
> > old_cred/NULL pointer (or pass old_cred to the function by reference
> > and return an error code); that should still provide the performance
> > win Mateusz is looking for while providing additional safety against
> > out-of-sync changes.  I would guess the code would be smaller too.
>
> It is unclear from the description if you are arguing for moving the new
> func into access_override_creds almost as is just put prior to existing
> code *or* mixing checks with assignments.

"arguing" is a bit strong of a word for what I was thinking, it was
more of just tossing out an idea to see if it has any merit with you,
the VFS folks, and possibly Linus.

> static bool *access_override_creds(struct cred **ptr)
>         [snip]
>         if (!uid_eq(cred->fsuid, cred->uid) ||
>             !gid_eq(cred->fsgid, cred->gid))
>                 return false;
>         /* remaining checks go here as well */
>         [snip]
>
>         override_cred = prepare_creds();
>         if (!override_cred) {
>                 *ptr = NULL;
>                 return true;
>         }
>
>         override_cred->fsuid = override_cred->uid;
>         override_cred->fsgid = override_cred->gid;
>         [snip]
>
> If this is what you had in mind, I note it retains all the duplication
> except in one func body which I'm confident does not buy anything,
> provided the warning comment is added.
>
> At the same time the downside is that it uglifies error handling at the
> callsite, so I would say a net loss.

Yes, I was thinking of combining the two functions into one to better
link the cred checks with the cred adjustments.

> Addition of the warning comment makes sense, but concerns after that
> don't sound legitimate to me.

Well, as we talked about earlier, it's really up to the VFS folks to
pick what they want, and they have been suspiciously quiet thus far.

--
paul-moore.com
