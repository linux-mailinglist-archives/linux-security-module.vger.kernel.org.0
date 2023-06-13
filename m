Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245B172EECF
	for <lists+linux-security-module@lfdr.de>; Wed, 14 Jun 2023 00:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjFMWDG (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 13 Jun 2023 18:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFMWDF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Jun 2023 18:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5367F191
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 15:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8274638EE
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 22:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4712AC433CA
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 22:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686693783;
        bh=YE2OLlRjrJoJAPFKOj7F8Uj++jD+iQljN8/NDOKswSQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mz9Rqfe30vJajOuqtICUjH7noYNgTHguDRQ4gMNCLIP9G5dk4ACpjESWKEyK18at7
         PPXo+/I75ZosPfgYZZXDU0zr4JGax/ZrtFLZ36MqTMGi9JeLWa5gbQXLZ1WaQhCME3
         cVGsBcfnygzRjB7rmEn+NyYBhVGkHfBHLv5Yg5tdmf2M9XlSYKEraAT3Yj0xSOjVUW
         1jq7W/hJh5cPLU6auc+jI1blB3cCPBmszSUXS8Y2Dp6f4CeNuTrtNEKilHYY65Ye+S
         gy9k9dyxlOkAL5suQoil2ZvGCcdr2PhhuKopveKOECrZN45QrIOYKk7rGxJq/4tPlF
         RmpWfWiKGVkGg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f64fb05a8aso7612453e87.0
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 15:03:03 -0700 (PDT)
X-Gm-Message-State: AC+VfDzcgvLY+03jBkPKc9BP5N/419W/H+OjB9huZe3vpkNZUpupEVnM
        MsBONbZP+5VM2I3Y0g4SVTVplCRb2NKlL2EQbvxmfw==
X-Google-Smtp-Source: ACHHUZ6gjl930j2aon0qqXN2JouzYxRQohMBZOFjtZwenAgNBpVDiOJ227hITV4LX78UUwZG7PLMbfLzsvEb/Q3BoIw=
X-Received: by 2002:a19:6445:0:b0:4f3:9868:bee4 with SMTP id
 b5-20020a196445000000b004f39868bee4mr6858582lfj.32.1686693781181; Tue, 13 Jun
 2023 15:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230119231033.1307221-1-kpsingh@kernel.org> <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
 <63e525a8.170a0220.e8217.2fdb@mx.google.com> <CAHC9VhTCiCNjfQBZOq2DM7QteeiE1eRBxW77eVguj4=y7kS+eQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTCiCNjfQBZOq2DM7QteeiE1eRBxW77eVguj4=y7kS+eQ@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 14 Jun 2023 00:02:50 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4w3BKNaogHdgW8AKmS2O+wJuVZSpCVVTCKj5j5PPK-Vg@mail.gmail.com>
Message-ID: <CACYkzJ4w3BKNaogHdgW8AKmS2O+wJuVZSpCVVTCKj5j5PPK-Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, casey@schaufler-ca.com, song@kernel.org,
        revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 10, 2023 at 9:03=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Feb 9, 2023 at 11:56 AM Kees Cook <keescook@chromium.org> wrote:
> > On Fri, Jan 27, 2023 at 03:16:38PM -0500, Paul Moore wrote:
> > > On Thu, Jan 19, 2023 at 6:10 PM KP Singh <kpsingh@kernel.org> wrote:
> > > >
> > > > # Background
> > > >
> > > > LSM hooks (callbacks) are currently invoked as indirect function ca=
lls. These
> > > > callbacks are registered into a linked list at boot time as the ord=
er of the
> > > > LSMs can be configured on the kernel command line with the "lsm=3D"=
 command line
> > > > parameter.
> > >
> > > Thanks for sending this KP.  I had hoped to make a proper pass throug=
h
> > > this patchset this week but I ended up getting stuck trying to wrap m=
y
> > > head around some network segmentation offload issues and didn't quite
> > > make it here.  Rest assured it is still in my review queue.
> > >
> > > However, I did manage to take a quick look at the patches and one of
> > > the first things that jumped out at me is it *looks* like this
> > > patchset is attempting two things: fix a problem where one LSM could
> > > trample another (especially problematic with the BPF LSM due to its
> > > nature), and reduce the overhead of making LSM calls.  I realize that
> > > in this patchset the fix and the optimization are heavily
> > > intermingled, but I wonder what it would take to develop a standalone
> > > fix using the existing indirect call approach?  I'm guessing that is
> > > going to potentially be a pretty significant patch, but if we could
> > > add a little standardization to the LSM hooks without adding too much
> > > in the way of code complexity or execution overhead I think that migh=
t
> > > be a win independent of any changes to how we call the hooks.
> > >
> > > Of course this could be crazy too, but I'm the guy who has to ask
> > > these questions :)
> >
> > Hm, I am expecting this patch series to _not_ change any semantics of
> > the LSM "stack". I would agree: nothing should change in this series, a=
s
> > it should be strictly a mechanical change from "iterate a list of
> > indirect calls" to "make a series of direct calls". Perhaps I missed
> > a logical change?
>

There is no logical change in the 2nd patch that introduces static
calls. There is however a logical change in the fourth patch (as you
noticed) which allows some hooks to register themselves as disabled by
default. This reduces the buggy side effects we have currently with
BPF LSM.

> I might be missing something too, but I'm thinking of patch 4/4 in
> this series that starts with this sentence:

Patch 4/4 is the semantic change but we do need that for both a
performant BPF LSM and eliminating the side effects.

>
>  "BPF LSM hooks have side-effects (even when a default value is
>   returned), as some hooks end up behaving differently due to
>   the very presence of the hook."
>
> Ignoring the static call changes for a moment, I'm curious what it
> would look like to have a better mechanism for handling things like
> this.  What would it look like if we expanded the individual LSM error
> reporting back to the LSM layer to have a bit more information, e.g.
> "this LSM erred, but it is safe to continue evaluating other LSMs" and
> "this LSM erred, and it was too severe to continue evaluating other

I tried proposing an idea in
https://patchwork.kernel.org/project/netdevbpf/patch/20220609234601.2026362=
-1-kpsingh@kernel.org/
 as an LSM_HOOK_NO_EFFECT but that did not seemed to have stuck.

> LSMs"?  Similarly, would we want to expand the hook registration to
> have more info, e.g. "run this hook even when other LSMs have failed"
> and "if other LSMs have failed, do not run this hook"?
>
> I realize that loading a BPF LSM is a privileged operation so we've
> largely mitigated the risk there, but with stacking on it's way to
> being more full featured, and IMA slowly working its way to proper LSM
> status, it seems to me like having a richer, and proper way to handle
> individual LSM failures would be a good thing.  I feel like patch 4/4
> definitely hints at this, but I could be mistaken.
>
> --
> paul-moore.com
