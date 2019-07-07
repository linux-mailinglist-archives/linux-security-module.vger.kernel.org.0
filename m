Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB916111E
	for <lists+linux-security-module@lfdr.de>; Sat,  6 Jul 2019 16:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfGFOdJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 6 Jul 2019 10:33:09 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:17788 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfGFOdI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Jul 2019 10:33:08 -0400
Date:   Sat, 06 Jul 2019 14:33:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1562423586;
        bh=haA5wvB0xh+dZtWZGeuep4dEUXcEIlBy0xdSwX483iI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=HQzIhk8PxKYt36ErbKPrQMJqON9fHmTQ3PYtYZqeFvsD1zSHVwbkoGWN0bzw7aR8K
         ARMyt0tMl0YH2vDYzZbyJiNYKRjCOTq+GXhhio/qQiJlEQqHfHCkqYGRG+bPNFvlhE
         1q+18riMHNgpRcuVQ6PozQhMO2ct7zAiMwLG2T2M=
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH v5 00/12] S.A.R.A. a new stacked LSM
Message-ID: <HJktY5gtjje4zNNpxEQx_tBd_TRDsjz0-7kL29cMNXFvB_t6KSgOHHXFQef04GQFqCi1Ie3oZFh9DS9_m-70pJtnunZ2XS0UlGxXwK9UcYo=@protonmail.ch>
In-Reply-To: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,GAPPY_SUBJECT autolearn=no
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Saturday, July 6, 2019 10:54 AM, Salvatore Mesoraca <s.mesoraca16@gmail.=
com> wrote:

> S.A.R.A. is meant to be stacked but it needs cred blobs and the procattr
> interface, so I temporarily implemented those parts in a way that won't
> be acceptable for upstream, but it works for now. I know that there
> is some ongoing work to make cred blobs and procattr stackable, as soon
> as the new interfaces will be available I'll reimplement the involved
> parts.

I thought all stacking pieces for minor LSM were merged in Linux 5.1.
Is there still something missing or is this comment out-fo-date?

Jordan
