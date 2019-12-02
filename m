Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD72C10F35F
	for <lists+linux-security-module@lfdr.de>; Tue,  3 Dec 2019 00:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfLBX3m (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 2 Dec 2019 18:29:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44263 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLBX3m (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Dec 2019 18:29:42 -0500
Received: by mail-io1-f66.google.com with SMTP id z23so1425396iog.11
        for <linux-security-module@vger.kernel.org>; Mon, 02 Dec 2019 15:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9k4NqUc+xhjxb0wpUBTLIN6jxygDGuanFeLQh7FhkQ=;
        b=a6OkHA15jExD/u6MbTZiZcNDxVr2sahdM1MTjjv7a+hAXQP5mNdIYea3qbVo73L+Tw
         2JCr6cAkShzhyLu8TCzm6305YWtFndKd93aQqlgYJY40IbXZKCF4waSGDeH7x15p2aPC
         mDJStounf2hUPaI/ufwyijTbf6CyNj+m7mSid2R+L0E0bjPSBRxYiQ/yPp1GoFkHIjY+
         NQsKFBDH1cs5o3wKz+PQkeMu9QtrtlVhlxjMLp2nzg1ybuhvF7+Fhph8gtTbJkA8fKHb
         fKdCBYOGXgYD53ytUr641QT6H2iUwv2JglH6FbliyAZZQf9uq0Fxu2tWBJZZZzypCk3z
         0dQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9k4NqUc+xhjxb0wpUBTLIN6jxygDGuanFeLQh7FhkQ=;
        b=aI3LyedLukpSxIHvRIWZsvVTYGj/tbGj5MFL75cG44j3O0s+MifNdpPVIhjuRUXgii
         xlvpPgzvlOPhAi13Nv8ovxN7jVjG3KGwdrDcC9YMaOvz2m2sPz6He2DYwusfwjvj9Xew
         jM7UIv5aCAUAWK1+YL6ZxaA7/lTo2CokfsDXyGQUlWRdQqZNIjHtRffR5F5sMIhcY0sZ
         gPtN2UUT0pHuK0HtY8CoCzltbY260P1hrOFciqSNj9hGFHrPZ56lGPgO9ei13dSZf1g/
         UBwI3QFg+KeotGvOMpGxI9zh4xdHDvcaL3qy+mvc51yslMR2y+e8Rs7KC858lYU2PKmL
         j+cA==
X-Gm-Message-State: APjAAAWbluKlhix3e03SFE8lxKzkRniAdcM6tJRcD9wL1eYmPKdGK7dI
        qdXfR/pBdqywFxkkGgqUO0gzsE66/s9nJ4i7IsIC5A==
X-Google-Smtp-Source: APXvYqwiQug+cHVbYVLfy2B2+UrlAMKkhOnnRJppni5MabOmDdafctIQce7BPJcHb2YFmpwVbuZsimLUmEstk8yHhZA=
X-Received: by 2002:a6b:f70e:: with SMTP id k14mr1377026iog.169.1575329381361;
 Mon, 02 Dec 2019 15:29:41 -0800 (PST)
MIME-Version: 1.0
References: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
 <201911301035.74813D4533@keescook> <f415ec28-8440-3b29-176c-50da09247ea3@gmail.com>
 <f988a531-a7f8-cef6-d3b4-6fbd89f5351f@gmail.com> <96625b06-3bba-6831-7127-22b690fccf1b@gmail.com>
 <-uRGQFmc8hMANlmvOpPXEib39VyGsx15MXwgVf-vripxhDcjILDfe5O17fyf5MXoZflmIE4avp7SqW4ijO1kHPqgHJMCqg1fWtXeGylu2uc=@protonmail.ch>
In-Reply-To: <-uRGQFmc8hMANlmvOpPXEib39VyGsx15MXwgVf-vripxhDcjILDfe5O17fyf5MXoZflmIE4avp7SqW4ijO1kHPqgHJMCqg1fWtXeGylu2uc=@protonmail.ch>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 2 Dec 2019 15:29:30 -0800
Message-ID: <CACdnJutjZk4r_7oCZTnQdmKGZKay1KvvDA+7goj9fwkMVcfHmQ@mail.gmail.com>
Subject: Re: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access
 even, in confidentiality mode.
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Matt Parnell <mparnell@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 2, 2019 at 2:55 PM Jordan Glover
<Golden_Miller83@protonmail.ch> wrote:

> Could you clarify if blocking msr breaks internal power management of intel
> cpu or it only prevents manual tinkering with it by user? If the latter then
> I think it's ok to keep it as is.

The latter.
