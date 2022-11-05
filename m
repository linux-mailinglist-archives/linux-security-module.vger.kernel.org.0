Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620F261A787
	for <lists+linux-security-module@lfdr.de>; Sat,  5 Nov 2022 05:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKEEjL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 5 Nov 2022 00:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKEEjL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Nov 2022 00:39:11 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E8A317FA
        for <linux-security-module@vger.kernel.org>; Fri,  4 Nov 2022 21:39:10 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so7603217fac.1
        for <linux-security-module@vger.kernel.org>; Fri, 04 Nov 2022 21:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QVhCjTiXsm0XAmH+YRM1X339ickLF/GL0sKIvePwac0=;
        b=FCSnsB+Ncbn05GHt62BXuzIBr4rsH97IiQeiye272VEDnNBybqlEYM6y/waq3nV71X
         KaiiJRqUZTcnkEtCXHhVXzAmNgTVDOFb0BYeit0BPiJhk79dMcjE/vceD3btbG/nkPML
         Sm3DZk4p55e3hOTDWHNnf21GfDhgAx0bVHpoV0VyYDI1lXMoPQT8hyTC9bHRPciw8JpY
         eZ3sDpBvLCFakfNbS83WC96gEQjxzBIVJj5pWpvD6FPndHyIGhQPp6LOCChKqMqdnq/j
         QMd8VSRtjkvDQKWcnjd0BXbzYUlGxA6LG1Sxr6sSwrBkaa0Rl3aJHijXxEDFqV3gIa+K
         d1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVhCjTiXsm0XAmH+YRM1X339ickLF/GL0sKIvePwac0=;
        b=5bMfNKQoVUA43p5FXkPAeNpao0Nrinon9B2P1PwsNjydRuGx4Glj4IIbIDbM28ILzC
         ZFpuDWMRMIQpQbpuy3OsYXvMmLdFinqt7InZ9V9WKDyEfs4FwIQAK7175VlcvREqh7dF
         olnk56U9QAgLcTE6WdCuTeMA7myFJye1uET+Ru+tnUceT6hCCtgo7JpE1B/+jb+ArvqY
         xZUjj91Wc7Iq72KdTRmxaR7RlvtNmbeSKcErzLxxmjewoVqn+jg/4Zg31s+ICTfgMooW
         oyTbE6aggZ8Poq3sbytWX0i0l0Xqy3bx4FVdUmGnZonT6xCPgUi9bo+PJCTk1K8tco7X
         mAcQ==
X-Gm-Message-State: ACrzQf08pPPQuZqWSNant9uFGHvz2hat0sl+rvVgfmfltwt0yrg4Ldgn
        zJHHCQwdM17BCjU+uuVExnUS/SG/m5TxlvKwjAek
X-Google-Smtp-Source: AMsMyM4w7eiFkYBhePubE/PyYhcqGdnaotz0NDTczdH13Aq1WqMXxNy3Sb/YZHqSax4NIV/jSYcVfTpPs875XiKcH8E=
X-Received: by 2002:a05:6870:f299:b0:13b:ad21:934d with SMTP id
 u25-20020a056870f29900b0013bad21934dmr23511755oap.172.1667623149267; Fri, 04
 Nov 2022 21:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221103151205.702826-1-omosnace@redhat.com>
In-Reply-To: <20221103151205.702826-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Nov 2022 00:38:57 -0400
Message-ID: <CAHC9VhS460B4Jpk8kqmhTBZv_dMuysNb9yH=6hB4-+Oc35UkAQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs: don't audit the capability check in simple_xattr_list()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Pitt <mpitt@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 3, 2022 at 11:13 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The check being unconditional may lead to unwanted denials reported by
> LSMs when a process has the capability granted by DAC, but denied by an
> LSM. In the case of SELinux such denials are a problem, since they can't
> be effectively filtered out via the policy and when not silenced, they
> produce noise that may hide a true problem or an attack.
>
> Checking for the capability only if any trusted xattr is actually
> present wouldn't really address the issue, since calling listxattr(2) on
> such node on its own doesn't indicate an explicit attempt to see the
> trusted xattrs. Additionally, it could potentially leak the presence of
> trusted xattrs to an unprivileged user if they can check for the denials
> (e.g. through dmesg).
>
> Therefore, it's best (and simplest) to keep the check unconditional and
> instead use ns_capable_noaudit() that will silence any associated LSM
> denials.
>
> Fixes: 38f38657444d ("xattr: extract simple_xattr code from tmpfs")
> Reported-by: Martin Pitt <mpitt@redhat.com>
> Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v1 -> v2: switch to simpler and better solution as suggested by Christian
>
> v1: https://lore.kernel.org/selinux/CAFqZXNuC7c0Ukx_okYZ7rsKycQY5P1zpMPmmq_T5Qyzbg-x7yQ@mail.gmail.com/T/
>
>  fs/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

VFS folks, this should really go through a vfs tree, but if nobody
wants to pick it up *and* there are no objections to the change, I can
take this via the LSM tree.

Reviewed-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
