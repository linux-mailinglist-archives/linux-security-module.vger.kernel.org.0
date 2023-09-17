Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7877A3719
	for <lists+linux-security-module@lfdr.de>; Sun, 17 Sep 2023 20:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjIQSTC (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 17 Sep 2023 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbjIQSS7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 17 Sep 2023 14:18:59 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922DE12C
        for <linux-security-module@vger.kernel.org>; Sun, 17 Sep 2023 11:18:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bffe2840adso10180991fa.2
        for <linux-security-module@vger.kernel.org>; Sun, 17 Sep 2023 11:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google; t=1694974732; x=1695579532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+GZybm26Jw3S/QLqnyCqrZ/lHqylFFuVPFliXlkHwI=;
        b=daFPiJ5BccJge9gfdHPZsr+R09O6Y2XqKNPQeAONPglVjQlaqkK66Dn5W8SjF99GsN
         Dc6GxcyHHlnlU7tVdPYhvDsMOQoqHwC2nsEFM1ig5SfrpY/Z1r0Mk8F7OimPLVLF9nCj
         qKxTPDv8XJ2nQi6o/lgPIfiSwZRqvXoksRFIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694974732; x=1695579532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+GZybm26Jw3S/QLqnyCqrZ/lHqylFFuVPFliXlkHwI=;
        b=XyK+sCGSKxcAywzoqKv7bkJfWJ46Q3wqfyQyHoiAYpPPTh4UVyYHBqbGKd0hEAXnvV
         V7nfeKfEaDUULYUkg+lXme5Up5mgS5iQEQpRvCF0cWbeBcxlfnrGTGTSKQbpjCAM1Ki+
         1QIgHlZMcJvquEbFHcYDWKxxTe0WIWOFTjqQeXt1sgJ0FzRL2qIjEkLesI+u7DcNE4ue
         OYkok8BtgkhKF8jnsHSCRBYKobKdIAhDMtHqWaRT2lt7m0FuG7hNirupQyf9nHrPlQNE
         SdjhdD1+dd3LLTNyUYEX604U3VTuHY9AuuWLHl2933rZS+vQm2IlmabiQqqPZ6T90OuJ
         6+Jw==
X-Gm-Message-State: AOJu0YyYmiryfvoVV1EC7dqs/fkFA8XBMwCZFrP54h9cOJWHi41ZmWe+
        U9z6gZQjkQTamJ4zdXMTdMWAYq766CBz3N0A8bNAEQ==
X-Google-Smtp-Source: AGHT+IHCxWbRlQ2+N/9gSVdzC1Np1+nWUoDofADS96XpMKxgBmfPJMd2/4WiuZcmuioPYSiRs2Zwoyut/KuiaTv+kwc=
X-Received: by 2002:a2e:b98b:0:b0:2c0:d06:9e6b with SMTP id
 p11-20020a2eb98b000000b002c00d069e6bmr562052ljp.33.1694974731628; Sun, 17 Sep
 2023 11:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
In-Reply-To: <20230913152238.905247-3-mszeredi@redhat.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Sun, 17 Sep 2023 12:18:15 -0600
Message-ID: <CAMp4zn-r5BV_T9VBPJf8Z-iG6=ziDEpCdmPgHRRXF78UoOjTjQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 13, 2023 at 9:25=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Add a way to query attributes of a single mount instead of having to pars=
e
> the complete /proc/$PID/mountinfo, which might be huge.
>
> Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a mount
> needs to be queried based on path, then statx(2) can be used to first que=
ry
> the mount ID belonging to the path.
>
> Design is based on a suggestion by Linus:
>
>   "So I'd suggest something that is very much like "statfsat()", which ge=
ts
>    a buffer and a length, and returns an extended "struct statfs" *AND*
>    just a string description at the end."
>
> The interface closely mimics that of statx.
>
> Handle ASCII attributes by appending after the end of the structure (as p=
er
> above suggestion).  Allow querying multiple string attributes with
> individual offset/length for each.  String are nul terminated (terminatio=
n
> isn't counted in length).
>
> Mount options are also delimited with nul characters.  Unlike proc, speci=
al
> characters are not quoted.
>

Thank you for writing this patch. I wish that this had existed the many tim=
es
I've written parsers for mounts files in my life.

What do you think about exposing the locked flags, a la what happens
on propagation of mount across user namespaces?
