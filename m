Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C727D6A78
	for <lists+linux-security-module@lfdr.de>; Wed, 25 Oct 2023 13:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjJYLya (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 25 Oct 2023 07:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjJYLy3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Oct 2023 07:54:29 -0400
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E5E186
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 04:54:26 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SFnQm0zRMzMpp4B;
        Wed, 25 Oct 2023 11:54:24 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SFnQk6tmVz3d;
        Wed, 25 Oct 2023 13:54:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1698234864;
        bh=mMYv/OtCtrMkSzUGCDriDfowe8jgvj19HXrHCnj/SwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WKlVFa/XjMXHzCCMDDthMvz02Bgem94sRhDHQNoLhGYAc/bVNvnEhiMxm5DTZHOLl
         mVMffrv7ck2pEkUAAHNAKJbtDBD0ZlstfQegKG4xbb+PNSOPdFyjKID1WeZlcIDlZV
         BPY/K3CbLj9VsfHcrIQyirsQlZ2KQs9nqznhfaRU=
Date:   Wed, 25 Oct 2023 13:54:21 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stefan Bavendiek <stefan.bavendiek@mailbox.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-security-module@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: Isolating abstract sockets
Message-ID: <20231025.eecai4uGh5Ie@digikod.net>
References: <Y59qBh9rRDgsIHaj@mailbox.org>
 <20231024134608.GC320399@mail.hallyn.com>
 <CAHC9VhRCJfBRu8172=5jF_gFhv2znQXTnGs_c_ae1G3rk_Dc-g@mail.gmail.com>
 <20231024141807.GB321218@mail.hallyn.com>
 <CAHC9VhQaotVPGzWFFzRCgw9mDDc2tu6kmGHioMBghj-ybbYx1Q@mail.gmail.com>
 <20231024160714.GA323539@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024160714.GA323539@mail.hallyn.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 24, 2023 at 11:07:14AM -0500, Serge E. Hallyn wrote:
> On Tue, Oct 24, 2023 at 10:29:17AM -0400, Paul Moore wrote:
> > On Tue, Oct 24, 2023 at 10:18 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > > On Tue, Oct 24, 2023 at 10:14:29AM -0400, Paul Moore wrote:
> > > > On Tue, Oct 24, 2023 at 9:46 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > > > > On Sun, Dec 18, 2022 at 08:29:10PM +0100, Stefan Bavendiek wrote:
> > > > > > When building userspace application sandboxes, one issue that does not seem trivial to solve is the isolation of abstract sockets.
> > > > >
> > > > > Veeery late reply.  Have you had any productive discussions about this in
> > > > > other threads or venues?
> > > > >
> > > > > > While most IPC mechanism can be isolated by mechanisms like mount namespaces, abstract sockets are part of the network namespace.
> > > > > > It is possible to isolate abstract sockets by using a new network namespace, however, unprivileged processes can only create a new empty network namespace, which removes network access as well and makes this useless for network clients.
> > > > > >
> > > > > > Same linux sandbox projects try to solve this by bridging the existing network interfaces into the new namespace or use something like slirp4netns to archive this, but this does not look like an ideal solution to this problem, especially since sandboxing should reduce the kernel attack surface without introducing more complexity.
> > > > > >
> > > > > > Aside from containers using namespaces, sandbox implementations based on seccomp and landlock would also run into the same problem, since landlock only provides file system isolation and seccomp cannot filter the path argument and therefore it can only be used to block new unix domain socket connections completely.
> > > > > >
> > > > > > Currently there does not seem to be any way to disable network namespaces in the kernel without also disabling unix domain sockets.
> > > > > >
> > > > > > The question is how to solve the issue of abstract socket isolation in a clean and efficient way, possibly even without namespaces.
> > > > > > What would be the ideal way to implement a mechanism to disable abstract sockets either globally or even better, in the context of a process.
> > > > > > And would such a patch have a realistic chance to make it into the kernel?
> > > > >
> > > > > Disabling them altogether would break lots of things depending on them,
> > > > > like X :)  (@/tmp/.X11-unix/X0).  The other path is to reconsider network
> > > > > namespaces.  There are several directions this could lead.  For one, as
> > > > > Dinesh Subhraveti often points out, the current "network" namespace is
> > > > > really a network device namespace.  If we instead namespace at the
> > > > > bind/connect/etc calls, we end up with much different abilities.
> > > >
> > > > The LSM layer supports access controls on abstract sockets, with at
> > > > least two (AppArmor, SELinux) providing abstract socket access
> > > > controls, other LSMs may provide controls as well.
> > >
> > > Good point.  And for Stefan that may suffice, so thanks for mentioning
> > > that.  But The LSM layer is mandatory access control for use by the
> > > admins.  That doesn't help an unprivileged user.
> > 
> > Individual LSMs may implement mandatory access control models, but
> > that is not an inherent requirement imposed by the LSM layer.  While
> > the Landlock LSM does not (yet?) support access controls for abstract
> > sockets, it is a discretionary access control mechanism.

A recent discussion focused on this topic:
https://lore.kernel.org/all/20231023.ahphah4Wii4v@digikod.net/

I'd like Landlock to be able to scope the use of unix sockets according
to a Landlock domain the same way it is done for ptrace. This would make
it possible to easily isolate unix sockets to a sandbox even by
unprivileged processes (without any namespace change). I'd be happy to
help implement such mechanism.

> 
> In 2005, before namespaces were upstreamed, I posted the 'bsdjail' LSM,
> which briefly made it into the -mm kernel, but was eventually rejected as
> being an abuse of the LSM interface for OS level virtualization :)
> 
> It's not 100% clear to me whether Stefan only wants isolation, or
> wants something closer to virtualization.
> 
> Stefan, would an LSM allowing you to isolate certain processes from
> some abstract unix socket paths (or by label, whatever0 suffice for you?
> 
> > I'm not currently aware of a discretionary access control LSM that
> > supports abstract socket access control, but such a LSM should be
> > possible if someone wanted to implement one.
> > 
> > -- 
> > paul-moore.com
