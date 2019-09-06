Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39FFBABE7A
	for <lists+linux-security-module@lfdr.de>; Fri,  6 Sep 2019 19:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404096AbfIFRPL (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 6 Sep 2019 13:15:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46193 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391025AbfIFRPI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Sep 2019 13:15:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so5631033lfc.13
        for <linux-security-module@vger.kernel.org>; Fri, 06 Sep 2019 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgnD7xuPPV7kJPJv1y/oxrmL+dxJJMuTrQ4Q4FChOdU=;
        b=S6FXIRgesHQioG8oGxLk5Tjwzb4SPiDI6TQkN/1PfVNUkJMeUM47+DjxmFZZnsgnqF
         aVUh5gjMjdVeG3Ez1LdJPa9NKOGaCIHQumkrSOBf3OS+YC+yfMLrM6/zSsHJRG8ghrAg
         d5Mr3bY5beGZhlJwy9YNIxLVtQzi4ydOFbhE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgnD7xuPPV7kJPJv1y/oxrmL+dxJJMuTrQ4Q4FChOdU=;
        b=bAsV2jTKjT8cqZ2o8OYERUtK0ik9VM5y4PiWVAg+VMIHm7Bc4ZnST+cvKwShOXuRIc
         HNkJS1Bk7Nz0Aj1PBQcFugsvAuzG0RczlhljGOwDKKHtgbMRnlqtxa87s4QRdwVyc+I5
         KpEyqEWjsAcLZKm6drQ2d2Y89hH64Vodoj0nzgave4fXw4ySfc+IMqVxD/Di6LZ7Jrlp
         NjYmxi0OEuM4sIjGLwthgT7MrXezpZMPQdJQ8n20x44jL/3T5+f6JCC3E0wAmvZXADhU
         HOCcqEn6aM9XchXGpjci+v1o1wsiFjVlMHQqvLTAYAjMfj2jFPJWPJHStg8/PUFWyKxU
         /asA==
X-Gm-Message-State: APjAAAX/cmHkUOIAr3Yt4xwOxe8HOgMx1mwpOC0EMBbXHI3sfKuT1XpM
        QEmrzUKMGYmMqvz13QTZXZE5lGrKNWE=
X-Google-Smtp-Source: APXvYqwkj8Eq/zQ08jSu7+Tp0P85ye2lipR/sBPp+mKEWcNXyXk6UWQyfmu/tHhvKfAJXLpJpDtYkA==
X-Received: by 2002:ac2:54a9:: with SMTP id w9mr7565225lfk.49.1567790106877;
        Fri, 06 Sep 2019 10:15:06 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id u8sm1403592lfb.36.2019.09.06.10.15.04
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 10:15:04 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a4so6684521ljk.8
        for <linux-security-module@vger.kernel.org>; Fri, 06 Sep 2019 10:15:04 -0700 (PDT)
X-Received: by 2002:a2e:8507:: with SMTP id j7mr6626752lji.156.1567790104003;
 Fri, 06 Sep 2019 10:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
 <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
 <5396.1567719164@warthog.procyon.org.uk> <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
 <14883.1567725508@warthog.procyon.org.uk> <CAHk-=wjt2Eb+yEDOcQwCa0SrZ4cWu967OtQG8Vz21c=n5ZP1Nw@mail.gmail.com>
 <27732.1567764557@warthog.procyon.org.uk> <CAHk-=wiR1fpahgKuxSOQY6OfgjWD+MKz8UF6qUQ6V_y2TC_V6w@mail.gmail.com>
 <CAHk-=wioHmz69394xKRqFkhK8si86P_704KgcwjKxawLAYAiug@mail.gmail.com>
 <8e60555e-9247-e03f-e8b4-1d31f70f1221@redhat.com> <CAHk-=wg6=qhw0-F=2_8y=VdT+fj8k7G1+t2XNSkRYimXhampVg@mail.gmail.com>
In-Reply-To: <CAHk-=wg6=qhw0-F=2_8y=VdT+fj8k7G1+t2XNSkRYimXhampVg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Sep 2019 10:14:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaSzdzYNuQXUSZNkT75Wmfw2v96tekgnV8nOwBQ3h0ig@mail.gmail.com>
Message-ID: <CAHk-=wjaSzdzYNuQXUSZNkT75Wmfw2v96tekgnV8nOwBQ3h0ig@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Ray Strode <rstrode@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 6, 2019 at 10:07 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. Maybe somebody can come up with a good legacy signaling solution
> (and "just use another pipe for error notification and OOB data" for
> the first one may _work_, but that sounds pretty hacky and just not
> very convenient).

... actually, maybe the trivial solution for at least some prototyping
cases is to make any user mode writers never drop messages. Don't use
a non-blocking fd for the write direction.

That's obviously *not* acceptable for a kernel writer, and it's not
acceptable for an actual system daemon writer (that you could block by
just not reading the notifications), but it's certainly acceptable for
the "let's prototype having kernel support for /proc/mounts
notifications using a local thread that just polls for it every few
seconds".

So at least for _some_ prototypes you can probably just ignore the
overflow issue. It won't get you full test coverage, but it will get
you a working legacy solution and a "look, if we have kernel support
for this, we can do better".

                 Linus
