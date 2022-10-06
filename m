Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70AE5F6A81
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Oct 2022 17:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiJFPZL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 6 Oct 2022 11:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiJFPZI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Oct 2022 11:25:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085CD8E0C6
        for <linux-security-module@vger.kernel.org>; Thu,  6 Oct 2022 08:25:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y136so2363432pfb.3
        for <linux-security-module@vger.kernel.org>; Thu, 06 Oct 2022 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=OtDkks39cgYVeSHQm8gd1cyY+JEJiwboAG4vuizNOOQ=;
        b=bwYKBKdRbKMXUGR+1Ba8s3APih/vqE4MzepUDPFpZZHmlwMDQPXFSRTr6JI2afx1mB
         5cCbkbKmfA/SsPQewwxLX0n1fuUOpqCqwDg8icP+4MjefbAGmbzfdCmtuHboewFG1cgf
         2Xuw32nN44/m5B/9jthRwgcr/98+HiByIIItU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=OtDkks39cgYVeSHQm8gd1cyY+JEJiwboAG4vuizNOOQ=;
        b=uxDvCtLtZg/pvz6zBqLFWkQDMui1kaWfgthvgHftZteVmG2P6X2NPL2Z6cGQAgAa6b
         wlc4jmsVq0dLGJ5Ep8mfqiqRosHuOdaNMQaPX+ebYNDd+/LePPrqwIuT9Oa/4pJZvFmc
         wAWnDeGmebFQrT2ttxGUnVfyfC0XCbCdlaqim9f9+IOwEUBVDrDe2JZKkMI30K3h0Tzv
         81/eDzDXjiRi4L8/mRLlMq7VSGE/LBOzTxq+DlVMlHK/Ocy6mEhLXzO/SmfNqLZWIMBU
         oNgQG2bcTLP3SeU7j9vvQSme2b0oEBtlM9fLP2tKSFj5zO5wxnMGGkw/m1ESDkrcUAaQ
         JYVQ==
X-Gm-Message-State: ACrzQf02FE5mE8vhzVTSZQ5efvr0HV7m/+cvgdzZePN64bSXmU/c6pE4
        AJxFKUj4V0c5vvno0QX8freqsw==
X-Google-Smtp-Source: AMsMyM5z1VQ/jYK2JD6/gNJiBdecIUmzcUy8MsflqoW0L8g/0cewBDfu6RFeroKPJlKOEYkHIn4RBA==
X-Received: by 2002:a05:6a00:22c9:b0:561:8635:7b35 with SMTP id f9-20020a056a0022c900b0056186357b35mr334380pfj.3.1665069905412;
        Thu, 06 Oct 2022 08:25:05 -0700 (PDT)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 73-20020a63054c000000b0042fe1914e26sm2006066pgf.37.2022.10.06.08.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 08:25:04 -0700 (PDT)
Date:   Thu, 06 Oct 2022 08:25:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
CC:     Eric Biederman <ebiederm@xmission.com>,
        Jorge Merlino <jorge.merlino@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
User-Agent: K-9 Mail for Android
In-Reply-To: <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
References: <20221006082735.1321612-1-keescook@chromium.org> <20221006082735.1321612-2-keescook@chromium.org> <20221006090506.paqjf537cox7lqrq@wittgenstein> <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
Message-ID: <86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On October 6, 2022 7:13:37 AM PDT, Jann Horn <jannh@google=2Ecom> wrote:
>On Thu, Oct 6, 2022 at 11:05 AM Christian Brauner <brauner@kernel=2Eorg> =
wrote:
>> On Thu, Oct 06, 2022 at 01:27:34AM -0700, Kees Cook wrote:
>> > The check_unsafe_exec() counting of n_fs would not add up under a hea=
vily
>> > threaded process trying to perform a suid exec, causing the suid port=
ion
>> > to fail=2E This counting error appears to be unneeded, but to catch a=
ny
>> > possible conditions, explicitly unshare fs_struct on exec, if it ends=
 up
>>
>> Isn't this a potential uapi break? Afaict, before this change a call to
>> clone{3}(CLONE_FS) followed by an exec in the child would have the
>> parent and child share fs information=2E So if the child e=2Eg=2E, chan=
ges the
>> working directory post exec it would also affect the parent=2E But afte=
r
>> this change here this would no longer be true=2E So a child changing a
>> workding directoro would not affect the parent anymore=2E IOW, an exec =
is
>> accompanied by an unshare(CLONE_FS)=2E Might still be worth trying ofc =
but
>> it seems like a non-trivial uapi change but there might be few users
>> that do clone{3}(CLONE_FS) followed by an exec=2E
>
>I believe the following code in Chromium explicitly relies on this
>behavior, but I'm not sure whether this code is in active use anymore:
>
>https://source=2Echromium=2Eorg/chromium/chromium/src/+/main:sandbox/linu=
x/suid/sandbox=2Ec;l=3D101?q=3DCLONE_FS&sq=3D&ss=3Dchromium

Oh yes=2E I think I had tried to forget this existed=2E Ugh=2E Okay, so ba=
ck to the drawing board, I guess=2E The counting will need to be fixed=2E=
=2E=2E

It's possible we can move the counting after dethread -- it seems the earl=
y count was just to avoid setting flags after the point of no return, but i=
t's not an error condition=2E=2E=2E

--=20
Kees Cook
