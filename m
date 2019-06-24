Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE8251D21
	for <lists+linux-security-module@lfdr.de>; Mon, 24 Jun 2019 23:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbfFXVa7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 24 Jun 2019 17:30:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33138 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfFXVa6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Jun 2019 17:30:58 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so918831iop.0
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jun 2019 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1crQPJTAtGM5uUHM8HI5Md6CDkFNGlZyxi3sPcH+qY=;
        b=GV/T5Ga4ZWk+3W3tqaFce2Ne2RQBxrSLyrhdSzfTB7LlQz8v8cPfHUnL0gw97i2ytW
         U4a+Nfv1evzoydxm7+aE0QEItVbBUUIJG/3U7ZVO97sH5R/GBfQ/sK+TpOvu118vpAVE
         5Ebmq730K8DfY367AGv9eK+RcSiWu/TKO7xNIlIMr46k+uacGMr0RWHh9AkvQlBwPQz/
         3dK8NiOrmCOZBOFRnBLzpc7otO4y3P98/1Bzu4aZ7JDhtZf7jNuJnBC8VOF1BZHvZufo
         L+R4LgK/I5cGCdrR41cI4yo5nDHrqGqdldJiFjF0OI44NEPptk1A10JIl1ioUUvMRyJx
         zBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1crQPJTAtGM5uUHM8HI5Md6CDkFNGlZyxi3sPcH+qY=;
        b=cg7pdicskJrnj70hXnAQPP5CMdBCeo0keZ9pvMu5GPW+wOra3LW8ewJRNbmhB2EgX0
         Vzyus3lzIf2zNo1GnTtT80b1i7xk8U1lDWxr1kHikZbS6JBZAHzknv57j++3nFhWRzCA
         3gyngr8pU5FNXKO3fu2+KIAShTunPiijgu30n4dHT3Cm6dsuKFDT3qFHOE9bHujhPubx
         oZi1IA06bCdk0US/6SJW0//38C+i+k7PW2dPDyisXo5tx58E5b/wR50HvsaTO5TnfSS9
         yN/Tm87JgLDZA3DcBeYcyDnhw+OemI7Kt/j5Bf1BFIbZJ+VQHC0sqn+LalAXqPU4b7Lx
         tp/Q==
X-Gm-Message-State: APjAAAWZ4MQa7SsSCq0jlFDyBYCDQWcIdHVFScHIutH6bLkwRy9SYcK+
        6WB3JJdyGjt57p89YM2xkgqKuBIpDMfotQfWrKKOtQ==
X-Google-Smtp-Source: APXvYqwbJ6/OJ4cAqwtkSkNEdex1XxYWjuM6oISUMTZ0zxZxc1DgCYwtvFO6zbVNKmMolpTJMIfjoUOPVX3NdCWBiKk=
X-Received: by 2002:a6b:f114:: with SMTP id e20mr39401495iog.169.1561411857221;
 Mon, 24 Jun 2019 14:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-24-matthewgarrett@google.com> <739e21b5-9559-d588-3542-bf0bc81de1b2@iogearbox.net>
 <CACdnJuvR2bn3y3fYzg06GWXXgAGjgED2Dfa5g0oAwJ28qCCqBg@mail.gmail.com>
 <CALCETrWmZX3R1L88Gz9vLY68gcK8zSXL4cA4GqAzQoyqSR7rRQ@mail.gmail.com> <7f36edf7-3120-975e-b643-3c0fa470bafd@iogearbox.net>
In-Reply-To: <7f36edf7-3120-975e-b643-3c0fa470bafd@iogearbox.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 24 Jun 2019 14:30:46 -0700
Message-ID: <CACdnJuuHdX-y5VpqVFVDM3ORUXLNh+-XKxykxypvYKotHuk1mA@mail.gmail.com>
Subject: Re: [PATCH V34 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        James Morris <jmorris@namei.org>,
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

On Mon, Jun 24, 2019 at 2:22 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> Agree, for example, bpf_probe_write_user() can never write into
> kernel memory (only user one). Just thinking out loud, wouldn't it
> be cleaner and more generic to perform this check at the actual function
> which performs the kernel memory without faulting? All three of these
> are in mm/maccess.c, and the very few occasions that override the
> probe_kernel_read symbol are calling eventually into __probe_kernel_read(),
> so this would catch all of them wrt lockdown restrictions. Otherwise
> you'd need to keep tracking every bit of new code being merged that
> calls into one of these, no? That way you only need to do it once like
> below and are guaranteed that the check catches these in future as well.

Not all paths into probe_kernel_read/write are from entry points that
need to be locked down (eg, as far as I can tell ftrace can't leak
anything interesting here).
