Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 759C351BC2
	for <lists+linux-security-module@lfdr.de>; Mon, 24 Jun 2019 21:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfFXTyN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 24 Jun 2019 15:54:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43847 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbfFXTyM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Jun 2019 15:54:12 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so1373016ios.10
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jun 2019 12:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCg/MjFmfZjibFv1+zfjJ/08w0AqICIa/H9ziec7kII=;
        b=T5bgSuFF2J0SClg2TX96KcIkt8PMoAR1G3u6wAV9ZlHT11IjSJBWqyLCR87fxH+c29
         LTufoMIaOaS5RzlQZdhwIhVGqFpXAIChtxNsI8BWjtM0tF2pFRYeHCKuLi5czhKl6iw/
         Kh4t45FA7uaBdu+cxYKWG6S4qqD66Wb7/01m2fvDCCMbfZCFA4qJWtcmCxfFo0R0UJYn
         9RwhYjanjDxnX37mmFLMatT8eDcY+4IhBRCV/7mN+h5oZP/SOk7UlIo3kxh2grH6N1Aq
         nB2By88uwy0THJJ3z/Iol2KMXK0mq8grrgUkxODb07Yba6xPmycLbGleHl0GH6KQvt/o
         4a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCg/MjFmfZjibFv1+zfjJ/08w0AqICIa/H9ziec7kII=;
        b=ekmBnRy0MOzFOdsca6fzWLdkmOHFMEtZ08i7wJe1JxsSZAVMdjTvDuZ9eoli0udXz9
         xKpLH+Xpbi6sygbB4XC2erirnYC+bqriZ2ZmQCAnB57/Gal/no8UFYHNj1pYITr/5qAv
         LphB2eg8pulpA9oYFEQhZAdQxz6GpUfvDtcoKa5vYFHFwdFwTziAN6UO9ThVE+Msl78a
         OaPbzi3sTxIuIaf8vQ6v4bo3Kc+31BiCvm610jOG791YVCw6noO+Oh/la3dsn/HTejyX
         5iq8vM981AOb3scgDc41jN7WfaoOk/Tuz9LeFfsNwwMYL8gs+5Xf2zzyzmPUeu1UuId9
         HXng==
X-Gm-Message-State: APjAAAXMN2nzPbKfK2y8xUPxzLKowNpSWHm10xgf00adsMYLxn5aQbZe
        icCQ455wp+okCIly2oIysANghg7XR63JAM9YDeaTgg==
X-Google-Smtp-Source: APXvYqyFU7p5SRJ6nKCqIZqMdeK3zYkp5IdfxuzZhylp6PCqxOOHmnAokMWRrX7K9YZRQdLi+tIxlDW1HYKDsttAmXA=
X-Received: by 2002:a05:6638:3d3:: with SMTP id r19mr30442055jaq.53.1561406051539;
 Mon, 24 Jun 2019 12:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-24-matthewgarrett@google.com> <739e21b5-9559-d588-3542-bf0bc81de1b2@iogearbox.net>
In-Reply-To: <739e21b5-9559-d588-3542-bf0bc81de1b2@iogearbox.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 24 Jun 2019 12:54:00 -0700
Message-ID: <CACdnJuvR2bn3y3fYzg06GWXXgAGjgED2Dfa5g0oAwJ28qCCqBg@mail.gmail.com>
Subject: Re: [PATCH V34 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>, Jann Horn <jannh@google.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 24, 2019 at 8:37 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 06/22/2019 02:03 AM, Matthew Garrett wrote:
> > From: David Howells <dhowells@redhat.com>
> >
> > There are some bpf functions can be used to read kernel memory:
>
> Nit: that

Fixed.

> > bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
>
> Please explain how bpf_probe_write_user reads kernel memory ... ?!

Ha.

> > private keys in kernel memory (e.g. the hibernation image signing key) to
> > be read by an eBPF program and kernel memory to be altered without
>
> ... and while we're at it, also how they allow "kernel memory to be
> altered without restriction". I've been pointing this false statement
> out long ago.

Yup. How's the following description:

    bpf: Restrict bpf when kernel lockdown is in confidentiality mode

    There are some bpf functions that can be used to read kernel memory and
    exfiltrate it to userland: bpf_probe_read, bpf_probe_write_user and
    bpf_trace_printk.  These could be abused to (eg) allow private
keys in kernel
    memory to be leaked. Disable them if the kernel has been locked
down in confidentiality
    mode.

> This whole thing is still buggy as has been pointed out before by
> Jann. For helpers like above and few others below, error conditions
> must clear the buffer ...

Sorry, yes. My fault.
