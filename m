Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501BD2A91C4
	for <lists+linux-security-module@lfdr.de>; Fri,  6 Nov 2020 09:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgKFIsL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 6 Nov 2020 03:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbgKFIsK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Nov 2020 03:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604652489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=akNSdNvLPnnajx6jK7BPQwI/2jOuawxzop+hGDzWRkM=;
        b=D5usBeBHvw5N/IhQsJI3g/2NSd53tHqFWjU1o58F+UEbOw1ANrIFE9UeKJpfml25D6R22V
        ukOPZWO+C/shhiZ3/aBbbJQzurV0S7Vd5RTnAUqRM/2gp1AkqS5zR+vkQoI+tb32nLhSKF
        YVL5EK1ImmOEFWd8Es1ln3yTrLQYa+c=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-Ya0683u6PiuAV7qkKuM2Vw-1; Fri, 06 Nov 2020 03:48:05 -0500
X-MC-Unique: Ya0683u6PiuAV7qkKuM2Vw-1
Received: by mail-lf1-f69.google.com with SMTP id e3so254102lfd.19
        for <linux-security-module@vger.kernel.org>; Fri, 06 Nov 2020 00:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akNSdNvLPnnajx6jK7BPQwI/2jOuawxzop+hGDzWRkM=;
        b=VSH3PAV0M+nXljAfeHEziUeOhVctG13AN0KYz9YMOV/qZ6UYVZ0IOP2fA7I3SDLCl7
         lLlbreOSBpsPgV9sOui++wLEkmE1QIPYhjjxQGLPU/tYD0nr81/zx093jD5RXpMrPN5+
         LDWcXHQvxhSrR0mvHlz9dSmBozNXGQOJf/vo1Zm6PJiAgusDKWcLfaa3t4cUTRiWBSyI
         6ZPFfbvfla0n5PuXZCp6ytpkRHd3b9KMABDBW08spIkf2kSs3CY/9gXbRckeUIDkYQHs
         THOJoR1yCwdmCEiBIUHvMcX09ftuLx6K/LGBCOY23Lx28xJArIX1AZYgllosDU2/Qi28
         jtKQ==
X-Gm-Message-State: AOAM5328WzkvR0oWSPIXXVMKgnc6qNU96H4c0wH52l/qTOglae01T8pc
        ZddfLmV8y4w14qmhsOmC5OsqoW6KCUFddwViZsJcko1KG+pIo0KWTsMHfw9+pa9weo8n4n7ukOt
        LaXROKI2p+e8XXneK17z/UCiCYoRjK1wz51980EgrDUF8AZ1Zl0g+
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr507823lff.9.1604652483637;
        Fri, 06 Nov 2020 00:48:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUGOpMljmh9ttPjJshD7XF2AeyO2HqMimeS7o20BfFzJyAmw5u7Z8/Y7W1f0mR/F+EyQw5J0yQx+O1gryn/Bw=
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr507813lff.9.1604652483406;
 Fri, 06 Nov 2020 00:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20201105173328.2539-1-olga.kornievskaia@gmail.com>
 <20201105173328.2539-2-olga.kornievskaia@gmail.com> <CAFqZXNtjMEF0LO4vtEmcgwydbWfUS36d8g24J6C-NDXORYbEJg@mail.gmail.com>
 <CAN-5tyF+cLpmT=rwAYvQQ445tjFKZtGq+Qzf6rDGg8COPpFRwA@mail.gmail.com>
 <a96c14c0f86ec274d5bdc255050ae71238bb43fe.camel@hammerspace.com> <CAN-5tyHc_fjDXwUngqVshB0Z7SzhAqjkXP7E=-k4sAPbfRwMmQ@mail.gmail.com>
In-Reply-To: <CAN-5tyHc_fjDXwUngqVshB0Z7SzhAqjkXP7E=-k4sAPbfRwMmQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 6 Nov 2020 09:47:52 +0100
Message-ID: <CAFqZXNu2cGC0Ub6E_b7cSY+JDk38hZt2mn7995S-1zA4Am62BA@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFSv4.2: condition READDIR's mask for security label
 based on LSM state
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 5, 2020 at 10:43 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
> On Thu, Nov 5, 2020 at 4:18 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Thu, 2020-11-05 at 14:51 -0500, Olga Kornievskaia wrote:
> > > On Thu, Nov 5, 2020 at 1:55 PM Ondrej Mosnacek <omosnace@redhat.com>
> > > wrote:
> > > >
> > > > On Thu, Nov 5, 2020 at 6:33 PM Olga Kornievskaia
> > > > <olga.kornievskaia@gmail.com> wrote:
> > > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > > >
> > > > > Currently, the client will always ask for security_labels if the
> > > > > server
> > > > > returns that it supports that feature regardless of any LSM
> > > > > modules
> > > > > (such as Selinux) enforcing security policy. This adds
> > > > > performance
> > > > > penalty to the READDIR operation.
> > > > >
> > > > > Instead, query the LSM module to find if anything is enabled and
> > > > > if not, then remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.
> > > >
> > > > Having spent some time staring at some of the NFS code very
> > > > recently,
> > > > I can't help but suggest: Would it perhaps be enough to decide
> > > > whether
> > > > to ask for labels based on (NFS_SB(dentry->d_sb)->caps &
> > > > NFS_CAP_SECURITY_LABEL)? It is set when mounting the FS iff some
> > > > LSM
> > > > confirms via the security_sb_*_mnt_opts() hook that it wants the
> > > > filesystem to give it labels (or at least that's how I interpret
> > > > the
> > > > cryptic name) [1]. It's just a shot in the dark, but it seems to
> > > > fit
> > > > this use case.
> > > >
> > > > [1]
> > > > https://elixir.bootlin.com/linux/v5.10-rc2/source/fs/nfs/getroot.c#L148
> > >
> > > Very interesting. I was not aware of something like that nor was it
> > > mentioned when I asked on the selinux mailing list. I wonder if this
> > > is a supported feature that will always stay? In that case, NFS
> > > wouldn't need the extra hook that was added for this series. I will
> > > try this out and report back.
> >
> > NFS_CAP_SECURITY_LABEL is just the NFS server capability flag. It tells
> > you whether or not the client believes that the server might support
> > NFSv4.2 requests for labelled NFS metadata.
> >
> > My understanding of Olga's requirement is that she needs to be able to
> > ignore that flag and simply not query for labelled NFS metadata if the
> > NFS client is not configured to enforce the LSM policy. The objective
> > is to avoid unnecessary RPC traffic to the server to query for data
> > that is unused.
>
> Actually that seems to be working. I think it's because while the
> server returns that it supports sec_labels, after calling
> security_sb_set_mnt_opts() the kflags_out don't have this
> SECURITY_LSM_NATIVE_LABELS set (assuming this happens because selinux
> isn't enabled) then we turned server's sec_labl cap off.
>
> I'm about to send v2 without relying on modifications to selinux.

Just to keep the LSM and SELinux lists in the loop: a v2 has been
posted to linux-nfs that uses NFS_CAP_SECURITY_LABEL instead of adding
a new hook:
https://lore.kernel.org/linux-nfs/CAFqZXNtJ2fkae7Xt-+nDR79kVs=yY=9vSoZaS-V-5UKSk22s4A@mail.gmail.com/T/

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

