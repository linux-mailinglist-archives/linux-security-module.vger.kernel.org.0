Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0992CF768
	for <lists+linux-security-module@lfdr.de>; Sat,  5 Dec 2020 00:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgLDXXL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 4 Dec 2020 18:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgLDXXK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Dec 2020 18:23:10 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8759C0613D1
        for <linux-security-module@vger.kernel.org>; Fri,  4 Dec 2020 15:22:24 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id ce23so7281631ejb.8
        for <linux-security-module@vger.kernel.org>; Fri, 04 Dec 2020 15:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlS3C6WuGwoBn7IObI4+YTjRX0/xv/TM3dmDMkafGlw=;
        b=FPM0PRzrYdMcK1zg3P9Wu0xJvL3z6vDGp5YNtp5fKJcuOddtsm8WOeC20JJzhSLaNH
         D+NNNWLUVM0BGkeeQUTlPd9v/oNB+bLWeOnTZWgvGe9Htk0ALBY4cHazx1MTEkIJ/rLB
         BYWt5/wuiXK9XlgUlUeKcjC9ypilxegwkbP/GF0E2sWNGea+rX7twJyOexEYi1/nWukW
         WU9nEjec6CNEgQnbnTmpqwxjOLDQPMvVpBKPkVmjWEjp7ldxtmTL50hdIxpis822zyCN
         koujM6BUbbzVfM+5k3XwkkU+gtMj/uD5fbLwBolQDCjFNddqfw5CYMDQOBiIbA+uYJ5y
         yU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlS3C6WuGwoBn7IObI4+YTjRX0/xv/TM3dmDMkafGlw=;
        b=UGWH2HM95sjZWUpcvP1bsNQOmoP3/aW2nRdACsxPYRqIHVsbYo+LddFxVXx999sw3L
         XGAOikXDEhLv6aJQkjFWJyqJqY+/MsofJJvogNkYeaBCvr+Or+z58kfQvs6fMHbLoGIl
         PXm+lpuwr0d6nwZu8j9+nUByDhXdasngcWPW6fNIXV+SAWnGTGnUIPOZ/4tvKv6eTDTy
         4Xqoj/US/dC2Zmg9AfVxdw/a7kTmel49P/1Uv5Bn9cs1A7KnKh7V08CABr2ogohdrIlm
         TBSE633dLXXrFPW9TTi7xzkbrNdXycG1Km6H2Vb38vlSJcKCL7MzXSdGod+K/NdLJXaj
         hKrA==
X-Gm-Message-State: AOAM533XeoX49ITnrj8cjOHXsM+7v/pXS614FK0twIsuMWSywTuMxmBP
        Yoie8hfErY6YpyHDGvh+DwJcDSqR084NjV12o29h
X-Google-Smtp-Source: ABdhPJyralX6EO3PtSqy1eB+Kk4U1fsGsLAzxcLe/3O1w/Nv5j7MlLXXrZ+NiPUhiLtwFqNVy3lBR1szM+0ofdHR8rw=
X-Received: by 2002:a17:906:46d6:: with SMTP id k22mr9222051ejs.542.1607124143374;
 Fri, 04 Dec 2020 15:22:23 -0800 (PST)
MIME-Version: 1.0
References: <3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com>
 <3a5f156da4569957b91bb5aa4d2a316b729a2c69.camel@redhat.com>
 <539f376-62c2-dbe7-fbfd-6dc7a53eafa@linux.intel.com> <CAHC9VhTVc07P_MhWm7YRF6LXdMRQOcDEKe7SB+fpJJizdKOvEg@mail.gmail.com>
 <20201203235415.GD5710@breakpoint.cc> <CAHC9VhT-rj=tJwVycS19TgJDQ766oUH6ng+Uv=wu+WDrgE0AHA@mail.gmail.com>
 <8c844984eaa92413066367af69b56194b111ad8f.camel@redhat.com>
In-Reply-To: <8c844984eaa92413066367af69b56194b111ad8f.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 4 Dec 2020 18:22:12 -0500
Message-ID: <CAHC9VhS9xRSbHMCgDkix0fHYeO=aA_=DVyV1Xdu8qFpggws8Kg@mail.gmail.com>
Subject: Re: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, mptcp@lists.01.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 4, 2020 at 5:04 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Thu, 2020-12-03 at 21:24 -0500, Paul Moore wrote:
> > On Thu, Dec 3, 2020 at 6:54 PM Florian Westphal <fw@strlen.de> wrote:
> > > Paul Moore <paul@paul-moore.com> wrote:
> > > > I'm not very well versed in MPTCP, but this *seems* okay to me, minus
> > > > the else-crud chunk.  Just to confirm my understanding, while MPTCP
> > > > allows one TCP connection/stream to be subdivided and distributed
> > > > across multiple interfaces, it does not allow multiple TCP streams to
> > > > be multiplexed on a single connection, yes?
> > >
> > > Its the latter.  The application sees a TCP interface (socket), but
> > > data may be carried over multiple individual tcp streams on the wire.
> >
> > Hmm, that may complicate things a bit from a SELinux perspective.  Maybe not.
> >
> > Just to make sure I understand, with MPTCP, a client that
> > traditionally opened multiple TCP sockets to talk to a server would
> > now just open a single MPTCP socket and create multiple sub-flows
> > instead of multiple TCP sockets?
>
> I expect most clients will not be updated specifically for MPTCP,
> except changing the protocol number at socket creation time - and we
> would like to avoid even that.
>
> If a given application creates multiple sockets, it will still do that
> with MPTCP. The kernel, according to the configuration provided by the
> user-space and/or by the peer, may try to create additional subflows
> for each MPTCP sockets, using different local or remote address and/or
> port number. Each subflow is represented inside the kernel as a TCP
> 'struct sock' with specific ULP operations. No related 'struct socket'
> is exposed to user-space.

Hmm, okay, there are probably a few other things we need to worry
about then from a SELinux point of view.  Smack may be okay since it
largely ignores sockets as a security entity, but Casey would be the
one to comment on that.  I'm not certain of the current AppArmor
network controls, or the other LSMs for that matter, but they should
be seeing this conversation on the LSM list so I assume they will
comment as necessary.

For SELinux the issue is that we need to track state in the sock
struct, via sock->sk_security, and that state needs to be initialized
and set properly.  Similarly with TCP request_sock structs, via
request_sock->{secid,peer_secid}.  Is the MPTCP code allocating and/or
otherwise creating socks or request_socks outside of the regular TCP
code?  We would also be concerned about socket structs, but I'm
guessing that code reuses the TCP code based on what you've said.

-- 
paul moore
www.paul-moore.com
