Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87AC746DFD
	for <lists+linux-security-module@lfdr.de>; Tue,  4 Jul 2023 11:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGDJwC (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 4 Jul 2023 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjGDJwB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Jul 2023 05:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0EFA3
        for <linux-security-module@vger.kernel.org>; Tue,  4 Jul 2023 02:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26319611B1
        for <linux-security-module@vger.kernel.org>; Tue,  4 Jul 2023 09:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4A2C433C8;
        Tue,  4 Jul 2023 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688464319;
        bh=vTzJCWSm3RPaGk9LEfK7QE5m4UMrj/ejn3sCq85uG7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o4wMatb9Fotj+e9UWmkQLrHcYieW70DS14+XEHXtfeIj74QkZH5qnXWMgcegeiqX7
         9DWz9bXotEjsfnJcxCwVlAtWti6b5rGqqdG5iPMhoITao+9VFEv8xzPObh8PiMofUH
         NnitqOhkLCAbl6L7yd/BTuRgiUl++uZbjzApYrG7Lyak7i9X8ULz+ysPx13XHRlx/u
         QeRjSxn87KymZMUD0L5DuibAYpgARHnARoqBRRdBwe//fbN3NEj1MPfDTLgghTfVlf
         x2ZrGRyVlbwRgu8irQXp/GslG7L97dtiyMn6XyEeec1qTQ+3oyHddik1Q8Oy9vVH7c
         S6ydWYx7D3E2Q==
Date:   Tue, 4 Jul 2023 11:51:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
        kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
Message-ID: <20230704-vielversprechend-zollfrei-a2a148f2699b@brauner>
References: <20230629051832.897119-1-andrii@kernel.org>
 <87sfa9eu70.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sfa9eu70.fsf@toke.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 30, 2023 at 01:15:47AM +0200, Toke Høiland-Jørgensen wrote:
> Andrii Nakryiko <andrii@kernel.org> writes:
> 
> > This patch set introduces new BPF object, BPF token, which allows to delegate
> > a subset of BPF functionality from privileged system-wide daemon (e.g.,
> > systemd or any other container manager) to a *trusted* unprivileged
> > application. Trust is the key here. This functionality is not about allowing
> > unconditional unprivileged BPF usage. Establishing trust, though, is
> > completely up to the discretion of respective privileged application that
> > would create a BPF token, as different production setups can and do achieve it
> > through a combination of different means (signing, LSM, code reviews, etc),
> > and it's undesirable and infeasible for kernel to enforce any particular way
> > of validating trustworthiness of particular process.
> >
> > The main motivation for BPF token is a desire to enable containerized
> > BPF applications to be used together with user namespaces. This is currently
> > impossible, as CAP_BPF, required for BPF subsystem usage, cannot be namespaced
> > or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BPF
> > helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely read
> > arbitrary memory, and it's impossible to ensure that they only read memory of
> > processes belonging to any given namespace. This means that it's impossible to
> > have namespace-aware CAP_BPF capability, and as such another mechanism to
> > allow safe usage of BPF functionality is necessary. BPF token and delegation
> > of it to a trusted unprivileged applications is such mechanism. Kernel makes
> > no assumption about what "trusted" constitutes in any particular case, and
> > it's up to specific privileged applications and their surrounding
> > infrastructure to decide that. What kernel provides is a set of APIs to create
> > and tune BPF token, and pass it around to privileged BPF commands that are
> > creating new BPF objects like BPF programs, BPF maps, etc.
> 
> So a colleague pointed out today that the Seccomp Notify functionality
> would be a way to achieve your stated goal of allowing unprivileged
> containers to (selectively) perform bpf() syscall operations. Christian
> Brauner has a pretty nice writeup of the functionality here:
> https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-in-unprivileged-container-development

I'm amazed you read this. :)
The seccomp notifier comes with a lot of caveats. I think it would be
impractical if not infeasible to handle bpf() delegation.

> 
> In fact he even mentions allowing unprivileged access to bpf() as a
> possible use case (in the second-to-last paragraph).

Yeah, I tried to work around a userspace regression with the
introduction of the cgroup v2 devices controller.
