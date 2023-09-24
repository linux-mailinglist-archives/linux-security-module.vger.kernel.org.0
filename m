Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBBC7AC64E
	for <lists+linux-security-module@lfdr.de>; Sun, 24 Sep 2023 04:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjIXCqo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 23 Sep 2023 22:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXCqo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 23 Sep 2023 22:46:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28C5124
        for <linux-security-module@vger.kernel.org>; Sat, 23 Sep 2023 19:46:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690f9c787baso3317116b3a.1
        for <linux-security-module@vger.kernel.org>; Sat, 23 Sep 2023 19:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695523597; x=1696128397; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UUfFHuKVjM5JOni2b5J9b/IsHZrumQoMr1+fGJ0xnKM=;
        b=kr5dG5ffkP4ScmF5g3g3Llj6uFhgYOM0m9tV/PlG3fbJHLhpkmaCxNlVd3ksyTj7RQ
         jS0Xa6KuU8/2OtsvbpdTqoymdDLXJwAlS8fG/FHY35pOvrujHiDmQmCsNB13EIh8gH58
         LmY8RcELnmpHtS4KOAJpd8HCvHvfdr04BuhGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695523597; x=1696128397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUfFHuKVjM5JOni2b5J9b/IsHZrumQoMr1+fGJ0xnKM=;
        b=mqmJxpGyTMTlqS34AkwrVlK086o6XWOvjq+A3EnugpCWfHlAz5aBI8xk6rRND8dawT
         k+hHw4grzNjJ+pxaC6wig/NfmvSkBL+aih1L7mjIld2/TG/UETuiIn28wyWihGtBS1z7
         3j82tRFioaYivwAu878FBeroOH9QxGZYcPHD90PCQDRDXVMyVPSC+RdH5Es6OU+K4kQS
         2KWI3qFnPhhFZztXz42zj/SCyVZG7Nh7j7pNUsqKkXPqoNpDQ7eSW9Dsrs4ny6JTTB3W
         Oe2vPBQGXam/3ZIgBrEQxuvmGazuCFH40T4Ttw5EFUI1qdG6GDmKLSJK64kfRzwAEyhx
         9YaQ==
X-Gm-Message-State: AOJu0YxIoKBnGJMk+tedvE+YiP/MRb0onaVDUVaI6MMFjJavQFZihg42
        Y6qTOZdpm8j3rRTePjNbj4VIaA==
X-Google-Smtp-Source: AGHT+IEkhicNhbG2SYATOjifWSwE2fbbZegRCyhHcmD3QB2yNh/5t73V/1gziA4II4SKjRvczT0fRA==
X-Received: by 2002:a17:902:ec85:b0:1c0:9d6f:9d28 with SMTP id x5-20020a170902ec8500b001c09d6f9d28mr2886607plg.11.1695523597125;
        Sat, 23 Sep 2023 19:46:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz19-20020a170902ef9300b001c3bc7b8816sm6045723plb.284.2023.09.23.19.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 19:46:36 -0700 (PDT)
Date:   Sat, 23 Sep 2023 19:46:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Subject: Re: [PATCH v4 0/5] Reduce overhead of LSMs with static calls
Message-ID: <202309231925.D9C4917@keescook>
References: <20230922145505.4044003-1-kpsingh@kernel.org>
 <20230922184224.kx4jiejmtnvfrxrq@f>
 <CACYkzJ67gw6bvTzX6wx_OtxUXi6kpVT196CXV6XCN1AaGQuKAw@mail.gmail.com>
 <CAGudoHE+od5oZLVAU4z3nXCNGk6uangd+zmDEuoATmDLHeFLGQ@mail.gmail.com>
 <CAGudoHFiVLmaMbFJno47_-x3Rs2tvgXNKyNznJeCq_cF8hFVvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFiVLmaMbFJno47_-x3Rs2tvgXNKyNznJeCq_cF8hFVvA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Sep 23, 2023 at 07:15:05PM +0200, Mateusz Guzik wrote:
> On 9/23/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > On 9/23/23, KP Singh <kpsingh@kernel.org> wrote:
> >> On Fri, Sep 22, 2023 at 8:42 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >>>
> >>> On Fri, Sep 22, 2023 at 04:55:00PM +0200, KP Singh wrote:
> >>> > Since we know the address of the enabled LSM callbacks at compile time
> >>> > and only
> >>> > the order is determined at boot time, the LSM framework can allocate
> >>> > static
> >>> > calls for each of the possible LSM callbacks and these calls can be
> >>> > updated once
> >>> > the order is determined at boot.
> >>> >
> >>>
> >>> Any plans to further depessimize the state by not calling into these
> >>> modules if not configured?
> >>>
> >>> For example Debian has a milipede:
> >>> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"
> >>>
> >>> Everything is enabled (but not configured).
> >>
> >> If it's not configured, we won't generate static call slots and even
> >> if they are in the CONFIG_LSM (or lsm=) they are simply ignored.
> >>
> >
> > Maybe there is a terminology mismatch here, so let me be more specific
> > with tomoyo as an example.
> >
> > In debian you have:
> > CONFIG_SECURITY_TOMOYO=y
> >
> > CONFIG_LSM, as per above, includes it on the list.
> >
> > At the same time debian does not ship any tooling to configure tomoyo
> > -- it is compiled into the kernel but not configured to enforce
> > anything.
> >
> > On stock kernel this results in tons of calls to
> > tomoyo_init_request_info, which are quite expensive due to an
> > avoidable memset thrown in, and which always return
> > tomoyo_init_request_info.
> >
> 
> Erm, which always return TOMOYO_CONFIG_DISABLED.
> 
> > Does not look like your patch whacks this problem.
> >
> 
> So I am asking if there are plans to make these modules get out of the
> way if they have nothing to do, like tomoyo in the example above.
> 
> Of course preferably distros would not make these weird configs, but I
> suspect this ship has sailed.

This is an artifact of the existing stacking behavior (and solving it,
if needed, can be done in parallel to this series). Specifically it
seems Tomoyo is in the "lsm=" list when it shouldn't be.

That said, I've long advocated[1] for a way to explicitly disable LSMs
without affecting operational ordering. I think it would be very nice to
be able to boot with something like:

lsm=!yama

to disable Yama. Or for your case, "lsm=!tomoyo". Right now, you have to
figure out what the lsm list is, and then create a new one with the
LSM you want disabled removed from the list. i.e. with v6.2 and later
check the boot log, and you'll see:

LSM: initializing lsm=lockdown,capability,landlock,yama,integrity,apparmor

If you wanted to boot with Yama removed, you'd then pass:

	lsm=lockdown,capability,landlock,integrity,apparmor

As a boot param. But I think this is fragile since now any new LSMs will
be by-default disabled once a sysadmin overrides the "lsm" list. Note
that booting with "lsm.debug=1" will show even more details. See commit
86ef3c735ec8 ("LSM: Better reporting of actual LSMs at boot").

So, if a distro has no support for an LSM but they want it _available_
in the kernel, they should leave it built in, but remove it from the
"lsm=" list. That's a reasonable bug to file against a distro...

-Kees

[1] https://lore.kernel.org/linux-security-module/202210171111.21E3983165@keescook/

-- 
Kees Cook
