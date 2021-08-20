Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C413F344B
	for <lists+linux-security-module@lfdr.de>; Fri, 20 Aug 2021 21:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbhHTTHK (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 20 Aug 2021 15:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbhHTTHJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Aug 2021 15:07:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7797BC061756
        for <linux-security-module@vger.kernel.org>; Fri, 20 Aug 2021 12:06:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z20so22099768ejf.5
        for <linux-security-module@vger.kernel.org>; Fri, 20 Aug 2021 12:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7x0Wnew5RknOSTO10okIRBDq0FR331ikFBd/KJhU7w=;
        b=ZD/+w+EFNdejqYMxwwHRtxROULeDpkT8Y0rR0OpRm9gwMSyoRym3wleTjHg5Gn+Rox
         S4jhOeIZCQZppC+uLcpnzlfOflaDBdt69verfNFDsGYNmsC9l6D6sUWHOMzSkOKdU7PB
         Jaqjm8M4SyXtg+7e9vMQ7fxG3NnVLG3zHdE1fNFnz4vgl1S4dSPCJq1pbn83M/lra4TC
         bAE/mxTQ+8cbSb1lwkR5hTvj17ijLsKfNOsZQnpqUqQuzuG4RIQZpFwdsRGcROLrrCYa
         jzyzoo8/3iwKC8/pOSFutwMj9eHTcKB9v3YIoAdBToL33nDhPF/93lP1etyBp6VnKqZi
         C8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7x0Wnew5RknOSTO10okIRBDq0FR331ikFBd/KJhU7w=;
        b=nSk5yafaLaIcCteyITxzSYZd/u2grow/X8AAYcwqepnsaYseOvnZ05k+vs0ZIjFOfA
         TIWXoyBfKMv8TPLq/fC+499TSq2TXOrqSemS/8dpzt1+oYtuPeUnUuxLiXhd4eywtnHE
         B2T26p4k6vyv2oRpYz4l+AIWUV/yQoYFFSvmzi0coYyFGbs1+H/9Ztz0WjJs02b908rV
         9cXOaLU1XTv9O/BlPZJds8NvC/vgvk0b5ZydcfoT7Mxa4Nzx3StHX7IqGUfoZIwXSwkS
         IvfePF2e5J5ji8zQ8lUaWPwsQln5cB2V8+zLSUhnGAIii137Mq1rKQ3XEl00EstGrMww
         jeyA==
X-Gm-Message-State: AOAM533vMmDinQLvqstY/fFpJr7OgHQ4+FWzadZGHF6vNSvqC4X0CySj
        o5SF4q6FMRO+XmanO5wlWdjsTUTt60BdGw9L3+M0
X-Google-Smtp-Source: ABdhPJwuDhsnxNJYKIJdPMBi1jGG0b+kJyGeIdr1cU2IvPwA6WANdxklzKLtMSlx2+JNzX6LuQwaPAl1YCQ+kn0RCpU=
X-Received: by 2002:a17:906:488a:: with SMTP id v10mr22887812ejq.91.1629486386535;
 Fri, 20 Aug 2021 12:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210722004758.12371-1-casey@schaufler-ca.com>
 <20210722004758.12371-23-casey@schaufler-ca.com> <CAHC9VhTj2OJ7E6+iSBLNZaiPK-16UY0zSFJikpz+teef3JOosg@mail.gmail.com>
 <ace9d273-3560-3631-33fa-7421a165b038@schaufler-ca.com> <CAHC9VhSSASAL1mVwDo1VS3HcEF7Yb3LTTaoajEtq1HsA-8R+xQ@mail.gmail.com>
 <fba1a123-d6e5-dcb0-3d49-f60b26f65b29@schaufler-ca.com> <CAHC9VhQxG+LXxgtczhH=yVdeh9mTO+Xhe=TeQ4eihjtkQ2=3Fw@mail.gmail.com>
 <3ebad75f-1887-bb31-db23-353bfc9c0b4a@schaufler-ca.com> <CAHC9VhQCN2_MsCoXfU7Z-syYHj2o8HaSECf5E62ZFcNZd9_4QA@mail.gmail.com>
 <062ba5f9-e4e8-31f4-7815-826f44b35654@schaufler-ca.com> <CAHC9VhT=QL5pKekaPB-=LDzU3hck9nXDiL5n1-upSqPg3gq=7w@mail.gmail.com>
 <f3137410-185a-3012-1e38-e05a175495cc@schaufler-ca.com> <6f219a4d-8686-e35a-6801-eb66f98c8032@schaufler-ca.com>
In-Reply-To: <6f219a4d-8686-e35a-6801-eb66f98c8032@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 20 Aug 2021 15:06:15 -0400
Message-ID: <CAHC9VhSsJoEc=EDkUCrHr5Uid9DhsoininpvPVt+Ab6RsqieOQ@mail.gmail.com>
Subject: Re: [PATCH v28 22/25] Audit: Add record for multiple process LSM attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 19, 2021 at 6:41 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 8/18/2021 5:56 PM, Casey Schaufler wrote:
> > On 8/18/2021 5:47 PM, Paul Moore wrote:
> >> ...
> >> I just spent a few minutes tracing the code paths up from audit
> >> through netlink and then through the socket layer and I'm not seeing
> >> anything obvious where the path differs from any other syscall;
> >> current->audit_context *should* be valid just like any other syscall.
> >> However, I do have to ask, are you only seeing these audit records
> >> with a current->audit_context equal to NULL during early boot?
> >
> > Nope. Sorry.
>
> It looks as if all of the NULL audit_context cases are for either
> auditd or systemd. Given what the events are, this isn't especially
> surprising.

I think we may be back to the "early boot" theory.

Unless you explicitly enable audit on the kernel cmdline, e.g.
"audit=1", processes started before userspace enables audit will not
have a properly allocated audit_context; see the "if
(likely(!audit_ever_enabled))" check at the top of audit_alloc() for
the reason why.

I could be wrong here, but I suspect if you add "audit=1" to your
kernel command line those remaining cases of NULL audit_contexts will
resolve themselves.  If not, we still have work to do ... well, I mean
we still have (different) work to do even if this solves the mystery,
it's just that we can now explain what you are seeing :)

-- 
paul moore
www.paul-moore.com
