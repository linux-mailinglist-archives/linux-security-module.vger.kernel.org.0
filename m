Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72411C0B0A
	for <lists+linux-security-module@lfdr.de>; Fri,  1 May 2020 01:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgD3Xnd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 30 Apr 2020 19:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726473AbgD3Xnd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Apr 2020 19:43:33 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302F0C035495
        for <linux-security-module@vger.kernel.org>; Thu, 30 Apr 2020 16:43:32 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l11so2716020lfc.5
        for <linux-security-module@vger.kernel.org>; Thu, 30 Apr 2020 16:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05oH2K+vg7L8+W/HnHl99DKxppRnrgZq0ok6k+htQb4=;
        b=XzR5U2YYxGN3xRIy/aE1u4RGhXZsY5P7C3x/9LAExW27SSRvRKmF6+7yld5rqLUCv5
         M+dioQa6yfzUT++eQic0svhLMLCzka1EJVAEfccNUEanl2fjcKkS8eyuWdKS+/VR23fR
         Rs2nhDJNGyWO2uVcPFWhrX9jZNEPFduLjHMXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05oH2K+vg7L8+W/HnHl99DKxppRnrgZq0ok6k+htQb4=;
        b=kLuEaksTd5V41o6pAVMLEYinEyO78LFPY8OMm/vxuao+wNfrNfGyS2d5zc+dzJEEMC
         cNIAubqveEDe7TJfznwmKpkyfZv0MekfznRutQus+S9aCs2Z0IFZysukzGcLznz01PIY
         3qagX7ZaHsneNUd6pf4AAv5hyo2x225V0wjjd4LELVp3D3sAkPmvOILvGfDy24j1x5CQ
         nlAiRVUEOSmvUAYkP3mFl+y9BDJosUfLuUdYZ26eyzdLrrj4TM7HTbbW24XkgGeVMlXQ
         jiRecZsr28FdH9xgSZ/Oh4Noi5nIW8ncjnC1xH0xrXxPI6umQ2MCH3dwpBDSdDM2ekmY
         CJtA==
X-Gm-Message-State: AGi0PuaT1DqC2+z9IRYUDe+aj4QVtfYOCWzI1zkrQQLfB7IA5tNtaW2H
        EeJgxCzxq59Tzv3lH3jQAe8KVEAhsNs=
X-Google-Smtp-Source: APiQypJercac+SLMjlAlGQ2QCz2yHZ0lSoUDBJA6+zTNkbAK7/f10XocCx8de9WuB6pi01iWHt50Pw==
X-Received: by 2002:a05:6512:31d6:: with SMTP id j22mr281846lfe.83.1588290209743;
        Thu, 30 Apr 2020 16:43:29 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id p2sm840314ljn.56.2020.04.30.16.43.28
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 16:43:28 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w14so2734872lfk.3
        for <linux-security-module@vger.kernel.org>; Thu, 30 Apr 2020 16:43:28 -0700 (PDT)
X-Received: by 2002:ac2:4da1:: with SMTP id h1mr692273lfe.152.1588290208226;
 Thu, 30 Apr 2020 16:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTu3YWPmwtA7RERHDRhQt0wAkmN4GJCmaRY7KSFRwtACQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTu3YWPmwtA7RERHDRhQt0wAkmN4GJCmaRY7KSFRwtACQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Apr 2020 16:43:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGjVLwTnYT8euAb_Lzqxd=-TFnJU-k2uu+Fn_hBfMc+w@mail.gmail.com>
Message-ID: <CAHk-=whGjVLwTnYT8euAb_Lzqxd=-TFnJU-k2uu+Fn_hBfMc+w@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.7 (#2)
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 30, 2020 at 2:24 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Two more SELinux patches to fix problems in the v5.7-rcX releases.
> Wei Yongjun's patch fixes a return code in an error path, and my patch
> fixes a problem where we were not correctly applying access controls
> to all of the netlink messages in the netlink_send LSM hook.

Side note: could we plan on (not for 5.7, but future) moving the "for
each message" part of that patch into the generic security layer (ie
security_netlink_send()), so that if/when other security subsystems
start doing that netlink thing, they won't have to duplicate that
code?

Obviously the "for each message" thing should only be done if there is
any security  hook at all..

Right now selinux is the only one that does this, so there's no
duplication of effort, but it seems a mistake to do this at the
low-level security level.

Or is there some fundamental reason why a security hook would want to
look at a single skb rather than the individual messages?

                Linus
