Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274D96772D
	for <lists+linux-security-module@lfdr.de>; Sat, 13 Jul 2019 02:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfGMAPV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 12 Jul 2019 20:15:21 -0400
Received: from namei.org ([65.99.196.166]:35010 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfGMAPV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Jul 2019 20:15:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6D0Efvn025905;
        Sat, 13 Jul 2019 00:14:41 GMT
Date:   Sat, 13 Jul 2019 10:14:41 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
cc:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 01/12] S.A.R.A.: add documentation
In-Reply-To: <1562410493-8661-2-git-send-email-s.mesoraca16@gmail.com>
Message-ID: <alpine.LRH.2.21.1907130953130.21853@namei.org>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com> <1562410493-8661-2-git-send-email-s.mesoraca16@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 6 Jul 2019, Salvatore Mesoraca wrote:

> Adding documentation for S.A.R.A. LSM.

It would be good if you could add an operational overview to help people 
understand how it works in practice, e.g. setting policies for binaries 
via sara-xattr and global config via saractl (IIUC). It's difficult to 
understand if you have to visit several links to piece things together.

> +S.A.R.A.'s Submodules
> +=====================
> +
> +WX Protection
> +-------------
> +WX Protection aims to improve user-space programs security by applying:
> +
> +- `W^X enforcement`_
> +- `W!->X (once writable never executable) mprotect restriction`_
> +- `Executable MMAP prevention`_
> +
> +All of the above features can be enabled or disabled both system wide
> +or on a per executable basis through the use of configuration files managed by
> +`saractl` [2]_.

How complete is the WX protection provided by this module? How does it 
compare with other implementations (such as PaX's restricted mprotect).

> +Parts of WX Protection are inspired by some of the features available in PaX.

Some critical aspects are copied (e.g. trampoline emulation), so it's 
more than just inspired. Could you include more information in the 
description about what's been ported from PaX to SARA?
	

-- 
James Morris
<jmorris@namei.org>

