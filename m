Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A044A241D4C
	for <lists+linux-security-module@lfdr.de>; Tue, 11 Aug 2020 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgHKPja (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 11 Aug 2020 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgHKPj3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Aug 2020 11:39:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6214C061788
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 08:39:28 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so6992357plt.3
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=k5Vv6xhQn88lB15k7GWg1mV+u5XAmiBOD5QRLYqo0NY=;
        b=nHEtCEzA+K3xCyhNyTZMcv8HcHHns+1Hk8pycDEXFieqNICHleSe+O63Dg8nrD0ywV
         o9FxDHPVmLM0E84TppnHf8iG7S6jFvmUO80JLVLQouLtTWeM771ruHtVW5aDq9qPlFD/
         nPvs2QyLb4JcANu1Lw9v6YsDaxc4gzzjaYoAo+A4op1aaTwKJdGjDEBtT2htvCkHP/QB
         M2r/LMeVxfL75GbnkDd0Rr7a/6JSOT1h/M4gxH2FCh1IUGFdbam1qcqLH8k5yRdjSkoQ
         WGIhvHaJscZeR6w7h6ionNs/EknZAEI60DlrcQnPgdDW7ZSAV7EvgtRxy0pWXvYZnNYr
         I/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=k5Vv6xhQn88lB15k7GWg1mV+u5XAmiBOD5QRLYqo0NY=;
        b=Ya6SL31jP3cKKU9KpNX8mGiNY4AQgxJvS/PVea7p3gQjhwlaE49UBiIM6scHx0Ppy8
         rtMX+FZ1AQXcned553yKsCmyziZI3SUlMooqS6zmXmVVECd1Sy6IW7ZXcfCken6/40YF
         P8XJoBgter8vd3DJg87y+Zm2FLNYse47cD6vrde50bGTCpNl/zlJkQbLhyYkjsEGzsIh
         bw0LCJ2G0QJe7nyUut41Usd3pL1h0Ko4EziyFSnfjWynyFx16CUITQjl04kCfwXdhBrM
         omqJbD6XKDC3UXi/22tSQebOzBH4jdJaxyFXQA8K90uzSyKn3hSeX+/ZZLLV3Uo5iEHj
         IavA==
X-Gm-Message-State: AOAM530Tb0Mo/O1F6+45tFwM+5CcGCI01pQPfV03+5XYetQULb8ccDEN
        RKPFyOVvFyrmr8lx2+EDsmaKuQ==
X-Google-Smtp-Source: ABdhPJy0yB+Dw1/CiiHffwfE44OfK3nBhmxE+9kmrh4+Xqbf7oNah664PCqIvEwN6uoP1FczdMwiuQ==
X-Received: by 2002:a17:902:8693:: with SMTP id g19mr1455443plo.66.1597160368219;
        Tue, 11 Aug 2020 08:39:28 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:6127:e67c:651c:a994? ([2601:646:c200:1ef2:6127:e67c:651c:a994])
        by smtp.gmail.com with ESMTPSA id 193sm25644247pfu.169.2020.08.11.08.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 08:39:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
Date:   Tue, 11 Aug 2020 08:39:26 -0700
Message-Id: <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net>
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17G68)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



> On Aug 11, 2020, at 8:20 AM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> =EF=BB=BF[ I missed the beginning of this discussion, so maybe this was al=
ready
> suggested ]
>=20
>> On Tue, Aug 11, 2020 at 6:54 AM Miklos Szeredi <miklos@szeredi.hu> wrote:=

>>=20
>>>=20
>>> E.g.
>>>  openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);
>>=20
>> Proof of concept patch and test program below.
>=20
> I don't think this works for the reasons Al says, but a slight
> modification might.
>=20
> IOW, if you do something more along the lines of
>=20
>       fd =3D open(""foo/bar", O_PATH);
>       metadatafd =3D openat(fd, "metadataname", O_ALT);
>=20
> it might be workable.
>=20
> So you couldn't do it with _one_ pathname, because that is always
> fundamentally going to hit pathname lookup rules.
>=20
> But if you start a new path lookup with new rules, that's fine.
>=20
> This is what I think xattrs should always have done, because they are
> broken garbage.
>=20
> In fact, if we do it right, I think we could have "getxattr()" be 100%
> equivalent to (modulo all the error handling that this doesn't do, of
> course):
>=20
>  ssize_t getxattr(const char *path, const char *name,
>                        void *value, size_t size)
>  {
>     int fd, attrfd;
>=20
>     fd =3D open(path, O_PATH);
>     attrfd =3D openat(fd, name, O_ALT);
>     close(fd);
>     read(attrfd, value, size);
>     close(attrfd);
>  }
>=20
> and you'd still use getxattr() and friends as a shorthand (and for
> POSIX compatibility), but internally in the kernel we'd have a
> interface around that "xattrs are just file handles" model.
>=20
>=20

This is a lot like a less nutty version of NTFS streams, whereas the /// ide=
a is kind of like an extra-nutty version of NTFS streams.

I am personally not a fan of the in-band signaling implications of overloadi=
ng /.  For example, there is plenty of code out there that thinks that (a + =E2=
=80=9C/=E2=80=9C + b) concatenates paths. With /// overloaded, this stops be=
ing true.=
