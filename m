Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBA85F6972
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Oct 2022 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiJFOR1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 6 Oct 2022 10:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiJFOQt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Oct 2022 10:16:49 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1545CAE210
        for <linux-security-module@vger.kernel.org>; Thu,  6 Oct 2022 07:14:15 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id o65so1362946iof.4
        for <linux-security-module@vger.kernel.org>; Thu, 06 Oct 2022 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uPoSw2DcS8I2PL1GAxLCIjBZkmIbahmymE7q5ESqNH4=;
        b=J9UmphxOwRlKuKwKJGEStMq2njru+PiIwGVLUfPBPq5L+NiQWR0X0ph0BMc2W5nbt8
         4fY0afnp5OGHoR48WDeXsZwHxoMN5k4f3cAvRzRwXhvGYbcMUIpKQGeu62j2J2SnGy+J
         Xj/w4pUH+FdGPKiKioCFBigar50r6VlCGptHXogYu0vEHZthEC9POAERgLfXsIlNUJAT
         4LL5lhcH/9QJf5wjtvXr093IFQ5FVgHnW9DKsbH5n9oFVp8IFEYJH/pVve/xHlsOIZTb
         JrrThpZZTRv6pIFAUlojtCkCpeK6hrRAxbyXE8fkyWQe0FnS13WwHzjaGBDQmYXcBSxS
         r/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPoSw2DcS8I2PL1GAxLCIjBZkmIbahmymE7q5ESqNH4=;
        b=2YfOlj8kPDyPf+AgLqJGCPrDgoiac0W09RsJXKP3xxbd7QbUM5wyPqKSiqRv0p6Wtd
         uLgjX48dXOufpt8+NRaW47q6UWvCs1is1S2MhEmc9y+JZt8HKaF09rmdDqhJWNPsglQW
         0ank/HrwNTTTy6yEkvNI2DWA2MSOf8Mxw/KVeIDwA1fBF60/0Elhue+zO71pQYw+jI01
         tHNTlAiZS+4wmH2ULe90RBdpNLT6e9On7WPuVWvcJcAaKSyUd09xSJL4+Er5XNGQhids
         SMIBlZlrZMWrtYDhfv1qpwjhlDwwTC52MK/9HGkFaJ0TKfq/tkL7fPF8DKYLJiPVIc0w
         uJxA==
X-Gm-Message-State: ACrzQf0cGB6eTGJiQU98gktQL+c+dd7svSQkOxxySTA08xp3ujkBwUa5
        2f83cBaZy8P6SdbQtcNGrELXq9kq3p5+seBxW/AbIg==
X-Google-Smtp-Source: AMsMyM6kii+MO2rLiB+gLKVkRtdEKc2Fqc0GkifGVmj9R/yf+5vbD7WJTCsBBNNUYIzb2JEn4WLbsp9vBGxMSZlBt2Y=
X-Received: by 2002:a6b:5d07:0:b0:6bb:7253:a439 with SMTP id
 r7-20020a6b5d07000000b006bb7253a439mr37286iob.2.1665065653849; Thu, 06 Oct
 2022 07:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org> <20221006090506.paqjf537cox7lqrq@wittgenstein>
In-Reply-To: <20221006090506.paqjf537cox7lqrq@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Oct 2022 16:13:37 +0200
Message-ID: <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
To:     Christian Brauner <brauner@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 6, 2022 at 11:05 AM Christian Brauner <brauner@kernel.org> wrote:
> On Thu, Oct 06, 2022 at 01:27:34AM -0700, Kees Cook wrote:
> > The check_unsafe_exec() counting of n_fs would not add up under a heavily
> > threaded process trying to perform a suid exec, causing the suid portion
> > to fail. This counting error appears to be unneeded, but to catch any
> > possible conditions, explicitly unshare fs_struct on exec, if it ends up
>
> Isn't this a potential uapi break? Afaict, before this change a call to
> clone{3}(CLONE_FS) followed by an exec in the child would have the
> parent and child share fs information. So if the child e.g., changes the
> working directory post exec it would also affect the parent. But after
> this change here this would no longer be true. So a child changing a
> workding directoro would not affect the parent anymore. IOW, an exec is
> accompanied by an unshare(CLONE_FS). Might still be worth trying ofc but
> it seems like a non-trivial uapi change but there might be few users
> that do clone{3}(CLONE_FS) followed by an exec.

I believe the following code in Chromium explicitly relies on this
behavior, but I'm not sure whether this code is in active use anymore:

https://source.chromium.org/chromium/chromium/src/+/main:sandbox/linux/suid/sandbox.c;l=101?q=CLONE_FS&sq=&ss=chromium
