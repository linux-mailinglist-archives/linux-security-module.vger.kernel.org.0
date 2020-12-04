Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CABF2CE5AF
	for <lists+linux-security-module@lfdr.de>; Fri,  4 Dec 2020 03:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgLDCZh (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 3 Dec 2020 21:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLDCZh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Dec 2020 21:25:37 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75610C061A51
        for <linux-security-module@vger.kernel.org>; Thu,  3 Dec 2020 18:24:51 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id jx16so6476533ejb.10
        for <linux-security-module@vger.kernel.org>; Thu, 03 Dec 2020 18:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfNYS6MLlkiU5bhAM8lpLHEUCLkxO4vhhPJPNj6ZzNQ=;
        b=jzqTqHQxAL0LS5ScINSdTvJ5zKHIN4mzyc3RDRQIbl1EF4UgJZkgm9+LksrAiBWdBS
         GbvMqruzlhYe+6b/80eR3GUHCGeL2fngGwBJalds+M32lrMq4284PqYPLJ6VCgZT0OEH
         2qW55y14gA+aX3cIEzRC4/lE/OOde1EoiPcRzs7HsJ1mK/uRwagNqXDpHB4NAsufXXsS
         GKZEFR9a3A2ntPCAr3/+zwppZHZ0ymofctxTh2kzctf9p1ikhaOgAM1FH2Eof5su65oc
         NEUSsLlzwbrrGXb16IOK4N6YXa7SNMamWo2j3yHi+43Dwxz40xoj0BUpq4Ln7L59FnQ7
         fKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfNYS6MLlkiU5bhAM8lpLHEUCLkxO4vhhPJPNj6ZzNQ=;
        b=H/V1RDenoCMgEMQ38GzViHWhzufbPvd3t5/W3+nVHG8HTxMQPwgbzZSFAZ7WKWVP2b
         xGrYg/m9lFbDa9b7q+9UHEJapLAhGmBrPzyO9uO63qgRoTU2nrjV2jwDGmnykqbS9oKs
         TujmZbXbrndd+TjRi9STe4h2ylYXeF9W3iRU/NQyI6GQ/PikcqyxNYr2bbwbiA0n1dcF
         PZLVHQHfNFLDqtCieMN1NHA3HKcmvNVsOL8Rw14F2Vdyq/yRjUfF6RCSAKdhJcyeyf04
         GJbPS+UD7KzutLdbuTuOmCJK165SjJjl5Pwx66om+NOYJ5eAmjieZRnMzrtX2npySdRv
         gPaw==
X-Gm-Message-State: AOAM530j2NioxLYlbVWr3J9b3iaX/l4V/VkyxW9uMp8tKWwMQf0UVWcO
        KKZFb3OXmsXS+ma6xF4yhhRvAwk47F5XtKcQCVUJ
X-Google-Smtp-Source: ABdhPJw/wDaom2dKRiHEelptoKI7eTgbi/3h3Sigmu3HEvydpnNloOUiujb1l7lVayhrH7BWfiJip3s+9gbSZ/u8Evc=
X-Received: by 2002:a17:906:46d6:: with SMTP id k22mr5088315ejs.542.1607048690170;
 Thu, 03 Dec 2020 18:24:50 -0800 (PST)
MIME-Version: 1.0
References: <3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com>
 <3a5f156da4569957b91bb5aa4d2a316b729a2c69.camel@redhat.com>
 <539f376-62c2-dbe7-fbfd-6dc7a53eafa@linux.intel.com> <CAHC9VhTVc07P_MhWm7YRF6LXdMRQOcDEKe7SB+fpJJizdKOvEg@mail.gmail.com>
 <20201203235415.GD5710@breakpoint.cc>
In-Reply-To: <20201203235415.GD5710@breakpoint.cc>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Dec 2020 21:24:39 -0500
Message-ID: <CAHC9VhT-rj=tJwVycS19TgJDQ766oUH6ng+Uv=wu+WDrgE0AHA@mail.gmail.com>
Subject: Re: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
To:     Florian Westphal <fw@strlen.de>
Cc:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, mptcp@lists.01.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 3, 2020 at 6:54 PM Florian Westphal <fw@strlen.de> wrote:
> Paul Moore <paul@paul-moore.com> wrote:
> > I'm not very well versed in MPTCP, but this *seems* okay to me, minus
> > the else-crud chunk.  Just to confirm my understanding, while MPTCP
> > allows one TCP connection/stream to be subdivided and distributed
> > across multiple interfaces, it does not allow multiple TCP streams to
> > be multiplexed on a single connection, yes?
>
> Its the latter.  The application sees a TCP interface (socket), but
> data may be carried over multiple individual tcp streams on the wire.

Hmm, that may complicate things a bit from a SELinux perspective.  Maybe not.

Just to make sure I understand, with MPTCP, a client that
traditionally opened multiple TCP sockets to talk to a server would
now just open a single MPTCP socket and create multiple sub-flows
instead of multiple TCP sockets?

-- 
paul moore
www.paul-moore.com
