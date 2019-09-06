Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F340FAC0A0
	for <lists+linux-security-module@lfdr.de>; Fri,  6 Sep 2019 21:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393349AbfIFTdS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 6 Sep 2019 15:33:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393336AbfIFTdS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Sep 2019 15:33:18 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 735443CBC3
        for <linux-security-module@vger.kernel.org>; Fri,  6 Sep 2019 19:33:17 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id w3so42592wrv.10
        for <linux-security-module@vger.kernel.org>; Fri, 06 Sep 2019 12:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R/U7mUhygsddH+fGB+zy3E9CKa5h+Z8Nm54osdGuOgs=;
        b=Ok1UA/BNnnkFSIMwNG3YHnNJajaqmFN57GNCCutJjFuIh0L3HBl92V/kYOh2Rw2BzR
         HhZHO68ZQa71EtIVNOat0j4RGEsNB266POpOA/RFB2ph8O6eiu3c7iYU4vMB9xSV2mau
         nTmgIpuoWdeaSoO2qXVXqeC9hSiaX1HzSSzQ/teczZrqrBoE8wWMzvpiiIas/kagKezk
         C/EnGY7NU00bz4dreGsgDO/9EnCM4fHhrBBmGnBx+ST9EvIcNOlyrQcFkPNKUyY00Iut
         6K0WlIq5DbXMBgEJya6ksonIZRclLxuGgzlHkLTSWNwuFi55AMTs4F3vYj/ZDZZ3yBcF
         0gSg==
X-Gm-Message-State: APjAAAVZOuJW1PpGZgdGhY/A/Vf6WHyXLAlfElkPJEBn4ISi2kd7p5cO
        qfwXN8T6wTawEYJnvSzCZmyxoXcUSDK6d5bTxtE8WdjYjuUhPFXpa7d/A1zXsA27UThVtiwMjqF
        RbI2yQ71aswxNUmD99bJ7joN+i+T6U4JBen8lZjsCx6MZfftJNFQn
X-Received: by 2002:a1c:ca02:: with SMTP id a2mr9252528wmg.127.1567798396044;
        Fri, 06 Sep 2019 12:33:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTIyfiPV/yAsPvflKtcRM07P7nCUNe0sQoeZ2AMSNSLR0dzqdoxrOYrd5Bg/c1ZdH+IG1R0aOFq6s5vYlI0XA=
X-Received: by 2002:a1c:ca02:: with SMTP id a2mr9252505wmg.127.1567798395711;
 Fri, 06 Sep 2019 12:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com> <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
In-Reply-To: <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
From:   Ray Strode <rstrode@redhat.com>
Date:   Fri, 6 Sep 2019 15:32:37 -0400
Message-ID: <CAKCoTu70E9cbVu=jVG4EiXnTNiG-znvri6Omh2t++1zRw+639Q@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

On Thu, Sep 5, 2019 at 4:39 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> That is *way* too specific to make for any kind of generic
> notification mechanism.
Well from my standpoint, I just don't want to have to poll... I don't
have a strong opinion
about how it looks architecturally to reach that goal.

Ideally, at a higher level, I want the userspace api that gnome uses
to be something
like:

err = krb5_cc_watch (ctx, ccache, (krb5_cc_change_fct) on_cc_change ,
&watch_fd);

then a watch_fd would get handed back and caller could poll on it. if
it woke up poll(),
caller would do

krb5_cc_watch_update (ctx, ccache, watch_fd)

or so and it would trigger on_cc_change to get called (or something like that).

If under the hood,  fd comes from opening /dev/watch_queue, and
krb5_cc_watch_update reads from some mmap'ed buffer to decide whether
or not to call on_cc_change, that's fine with me.

If under the hood, fd comes from a pipe fd returned from some ioctl or syscall,
and krb5_cc_watch_update reads messages directly from that fd to decide
whether or not to call on_cc_change, that's fine with me. too.

it could be an eventfd too, or whatever, too, just as long as its
something I can add
to poll() and don't have to intermittently poll ... :-)

> Also, what is the security model here? Open a special character
> device, and you get access to random notifications from random
> sources?
I guess dhowells answered this...

> And why would you do a broken big-key thing in the kernel in the first
> place? Why don't you just have a kernel key to indirectly encrypt
> using a key and "additional user space data". The kernel should simply
> not take care of insane 1MB keys.
🤷 dunno.  I assume you're referencing the discussions from comment 0
on that 2013 bug.  I wasn't involved in those discussions, I just chimed in
after they happened trying to avoid having to add polling :-)

I have no idea why a ticket would get that large. I assume it only is in weird
edge cases.

Anyway, gnome treats the tickets as opaque blobs.  it doesn't do anything
with them other than tell the user when they need to get refreshed...

all the actual key manipulation happens from krb5 libraries.

of course, one advantage of having the tickets kernel side is nfs could
in theory access them directly, rather than up calling back to userspace...

--Ray
