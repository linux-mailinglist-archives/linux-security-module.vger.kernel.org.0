Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 887B88A3FD
	for <lists+linux-security-module@lfdr.de>; Mon, 12 Aug 2019 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfHLRG1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 12 Aug 2019 13:06:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44471 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfHLRG1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Aug 2019 13:06:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so111252489otl.11
        for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2019 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CJXVGkD5gwHmhaWFfky1xzAZEEjaJsOI/bewJ/ZWQM=;
        b=oUfGTZvEThugoKFj26lfK3BkfDcGdvq6FdjxRl1rkH+FIEBE7b/aC5h1CMgDOtaieI
         L+EkOXdjf69RSW44vYTtkv3d5cDFYfMJJJFTSOzfPYUkIufSYq91RlskMh0QlhF3vJ3R
         FOZ7MyP78IV1ZMeV/SRP5cyood7FWVLhwRF/v6/9TEAN68fdaQWcbXvVM+sBssomi8t9
         ntdvAy2kolCpg2PUmATBdEtME9uN90rqh4iZ0/8yaEAJENc88sDgHvj9yVtyGMtYkmYU
         8kS2rJlc7iSA0K7X6FDEfsJX+injfIidOBPCaa4fgC4HKsxJ1cJeC9bjcu6I9qyLaBlF
         GiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CJXVGkD5gwHmhaWFfky1xzAZEEjaJsOI/bewJ/ZWQM=;
        b=UbyuCGsfslQbIumO95ZopyWm9RiIEMtLjX8FBhq6nBSQDa6BBs5m5hpMyJCWNRZFFd
         i5eh5ZscfuPiqB/sE3rEzK7NoJ8PEngehYXPTQgJNuDAgq/uBVggJp08xs57iZZcgAgl
         48/k2GyrHbXiAH/oW4NLlCtsOQ5p62+W4z4og//cEM2SxZUN6XJRv+KiOH8ke7x1I372
         apFXtkctgJg0julMPh4YLjtwAIXSoO3geSYmsF/ak+eK+ActNtXu5Z+LRQejpejxvToE
         fKgpZXcqQdPdn9UYoCweLdh7kPfhHKw2Z1wfRS8txKTSN+rqJOweCmf5UfjWhIZG+R9G
         rG1A==
X-Gm-Message-State: APjAAAUrsZjcCv4tkkUTni3ux9ZvCzspJkw2SuN4TlcUaYiT1j4rE4VF
        LYrvxePS/2IPmGjpGxXnTuuFYzwuFYbyV8HJfQAUxY1hQ+I=
X-Google-Smtp-Source: APXvYqwr2GIcyiBsHsQTXi2n4WnrNw8lR5CUTTTQEcH8VjjHdKGIi7W65y25V1EcF9fo+pzg7yI53LA3HOxbRlnZJFo=
X-Received: by 2002:a02:a88e:: with SMTP id l14mr6960804jam.105.1565629586211;
 Mon, 12 Aug 2019 10:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com> <alpine.LRH.2.21.1908101608260.25186@namei.org>
In-Reply-To: <alpine.LRH.2.21.1908101608260.25186@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 12 Aug 2019 10:06:14 -0700
Message-ID: <CACdnJusx3N_ZoH4=+tqt85K9J5wmUnC-+bTtG_5qSD_TYu74+A@mail.gmail.com>
Subject: Re: [PATCH V38 00/29] security: Add support for locking down the kernel
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 9, 2019 at 11:08 PM James Morris <jmorris@namei.org> wrote:
> Please verify and test, as I had to make a few minor fixups for my v5.2
> base.

Thanks James - there's a few small fixups required, would you like
those as separate patches or should I just send you a fixed copy of
the original patchset?
