Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBE8797EA2
	for <lists+linux-security-module@lfdr.de>; Fri,  8 Sep 2023 00:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbjIGWNI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 7 Sep 2023 18:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjIGWNI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Sep 2023 18:13:08 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC301BC9
        for <linux-security-module@vger.kernel.org>; Thu,  7 Sep 2023 15:13:01 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3ab244f2c89so1041385b6e.3
        for <linux-security-module@vger.kernel.org>; Thu, 07 Sep 2023 15:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694124781; x=1694729581; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9vryx3hjoLOWu4YDmGUva+XdRwlAV4TRPTjIeRyZj8=;
        b=Wh2kNeAtLFz3tRg5mg4OKzxHATLWqelEKzaLqmuj+iJyMn9dPsYpLGTXr2YGD3zguf
         jSfYmtiZjbYDpociC4pkZPwgh0UG3lUY5DPrKYiSDcQnt6bxH4H5u3tX6aawCpLpph5I
         IsUaJuEpVp5LfIWRVGOa/8Zx7tiQAZqaTIFcIvI3Z5rL4nEipqPrIwe+jFb4qdXXDTJA
         rsA4rSrHeboMJuFzZaCRvU9SPu+6nm4qYWpBmZXsibZGahOXUMhvW3B8QeuqAMApTacG
         ysyX5frEAcRFuKsrosLprM5YkbWj/uoSHfPHa6uoDa+tlJ9HguAnO4c2mLMt9sYr52ry
         IqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694124781; x=1694729581;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9vryx3hjoLOWu4YDmGUva+XdRwlAV4TRPTjIeRyZj8=;
        b=w11aWU1MAkMIvmIDMPWfIo3WXuB1qRkLJit1zDlYAL6b899IYBXc+5mSCv7rR3uh2P
         JbFRw8z1RvDVT/akMdCqn0xvBnuLynfhhEi0JmQBrGtEZrKbWbmIuQYKUKDjOZYGQcrB
         PBI161XbFt0xpwTdMtTwvFuxLQD7jmxj2CKfzCSgiDs8EPi1rGwqUWasTcQ2XTON5/Kd
         WyE9XbQCbjGlyiRlOtJS3wdfg3cpoc/zACMP3tlo1b/ZKJGCHBFuh9SixpYWdboWn8F/
         hwyScI5RZkpMML8kisCZIXKwerO2Rru0yjn7DpYh2T/j11yd7rtzHcQ0bEZW3o3IddGE
         IBCQ==
X-Gm-Message-State: AOJu0YxNsMweNTZWExqqSiF2YlQILIWw8YoRIimqNw6wu2QO52V7gUJ3
        +4rfmOxPHo+6Aw3Cmn4SWvyP1NneuOsPGAcY/JZrSQzZJhE6BLVqhA==
X-Google-Smtp-Source: AGHT+IH4XXwGsy3o7vJ23zfTPNm2/rFYSCSzijLQKAHM9MLCI6RhtV2xiGVz3NvjUQWTf/o+r4hkUAmNV6A2Dh7eMlM=
X-Received: by 2002:a05:6808:1994:b0:3a7:6213:6898 with SMTP id
 bj20-20020a056808199400b003a762136898mr1093879oib.12.1694124780790; Thu, 07
 Sep 2023 15:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com> <CAHC9VhSw6B5D9ru8trwcejAt_MQKN4g6R0zeTqO_BKRL06km7Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSw6B5D9ru8trwcejAt_MQKN4g6R0zeTqO_BKRL06km7Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Sep 2023 18:12:49 -0400
Message-ID: <CAHC9VhQgZ6kRQA7M8BG1H4gW=dPBhPqc5qV72EQqrSt9p0Uhkg@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 3, 2023 at 5:38=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Aug 2, 2023 at 6:00=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Aug 1, 2023 at 6:47=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > I've updated the README.md doc based on the feedback, and copied the
> > > two new sections below for easier review.  If anyone has any
> > > additional feedback or concerns, please let me know.
> >
> > Another update based on feedback received (thanks everyone!).  Just as
> > before, I welcome any comments or feedback you are able to share.
>
> MOAR UPDATES!
>
> ## New LSM Hook Guidelines

...

> ## New LSM Guidelines
>
> Historically we have had few requirements around new LSM additions, with
> Arjan van de Ven being the first to describe a basic protocol for accepti=
ng new
> LSMs into the Linux kernel[^1].  In an attempt to document Arjan's basic =
ideas
> and update them for modern Linux kernel development, here are a list of
> requirements for new LSM submissions:
>
> * The new LSM's author(s) must commit to maintain and support the new LSM=
 for
> an extended period of time.  While the authors may be currently employed =
to
> develop and support the LSM, there is an expectation upstream that suppor=
t will
> continue beyond the author's employment with the original company, or the
> company's backing of the LSM.

Based on some off-list discussions, I've added some text to the end of
the paragraph above to allow for a reasonable plan of succession in
cases where the original LSM authors are not able to commit to long
term support.  Just as before, comments are always welcome :)

Here is the new paragraph:

"The new LSM's author(s) must commit to maintain and support the new LSM fo=
r
an extended period of time.  While the authors may be currently employed to
develop and support the LSM, there is an expectation upstream that support =
will
continue beyond the authors' employment with the original company, or the
company's backing of the LSM.  If the authors are not able to commit to
supporting the LSM for an extended period of time, a reasonable succession =
plan
must be submitted along with the LSM."

--=20
paul-moore.com
