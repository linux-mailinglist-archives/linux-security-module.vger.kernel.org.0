Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8EA79B66
	for <lists+linux-security-module@lfdr.de>; Mon, 29 Jul 2019 23:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbfG2VrQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 29 Jul 2019 17:47:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46540 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbfG2VrQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Jul 2019 17:47:16 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so10103147iol.13
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2019 14:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j10iEndEcfl7GFmx0FBUfHkT/DIF6Lz0Je3WuUXspf4=;
        b=JX9vGziMLV0bTzWdDEXuN2wORxj61dz7dEOXT8Y9SKYKtqwU+xD6ErVpMeRWiEzuI9
         98yyj3qE8qXIZZMfgOvU/ScnBtJ2CDT7V5DT0pjTOgpoyLSl95jt69WDW0iNODp2cmw9
         oF09HKKjSA6zgwa6539xg9dw/7oNc3Q6Debx/rjZCXOUFxjL/1CUBhy5gRGjz0EDELiY
         9DcD3CI1ee7sVs5VlAd44Xw0XZ16251YPtko3DyygrdJoTjMekRrdWrFZ1Nb2c4cLzEf
         KpxJZbxyRTy9MEYf/AHlJ0Sd8kVCJIC6j3PJvb19FoT65p1ROCUKwFKE9pqk9jvoKbBq
         E1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j10iEndEcfl7GFmx0FBUfHkT/DIF6Lz0Je3WuUXspf4=;
        b=YKOf/bIEh1ozcuZHoPGgDjPNPAaqgwA41h8Ruoy5zD1PswluSgqsmxw7PAT6uRRnV6
         G8wA80n8OUNxTfqF4m9WzsQ6XPYGPjZI+Jqgac72oUmheLSC+nrSIyU6Z3MKCBvw5m2j
         8W2ggRFHM+FLlSUtOU+4lzD9Yj9ST7HXYhxH61cBSMZCnDNu8stgcs5SLJ97UlFjri7g
         Vt+My6nTO71TCjM0qpNEmc4/NMh6jdkDjJbbCVIOJLCDgebfP9BzbKLvIwiTjBkwsXIB
         7tRBE0iTpjVX2A2zfuNn6jEFHUlZrDAGWOSKKIF+3lacCBRQUXE2Yk87J6FvvcItuijO
         QrVg==
X-Gm-Message-State: APjAAAXbCwjfguwLs6M8Lj5SgTrgQSITqc8OYpfM0rBhYkdvEFTd7lTg
        yLpcAYBnNxwVLjOTo8M3gPg/20nhrr3ovkT4aV8rZwtII/g=
X-Google-Smtp-Source: APXvYqzm3EZUnnvVpNns0C5pcvCXqaLAcYBywGrdM9ZfVRZDiZMOV9R7ercGbfHFqw5oA66zZL1UqInfPCyK99Izl1k=
X-Received: by 2002:a5e:8c11:: with SMTP id n17mr35080222ioj.64.1564436834661;
 Mon, 29 Jul 2019 14:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com> <20190718194415.108476-24-matthewgarrett@google.com>
In-Reply-To: <20190718194415.108476-24-matthewgarrett@google.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 29 Jul 2019 14:47:03 -0700
Message-ID: <CACdnJuvFBQCpR4hk1YBQ2HSxJcweB0_XBqYZxn=LpG6NFU7S6w@mail.gmail.com>
Subject: Re: [PATCH V36 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jul 18, 2019 at 12:45 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
> bpf_read() and bpf_read_str() could potentially be abused to (eg) allow
> private keys in kernel memory to be leaked. Disable them if the kernel
> has been locked down in confidentiality mode.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> cc: netdev@vger.kernel.org
> cc: Chun-Yi Lee <jlee@suse.com>
> cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>

Any further feedback on this?
