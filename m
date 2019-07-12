Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7B676DE
	for <lists+linux-security-module@lfdr.de>; Sat, 13 Jul 2019 01:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfGLXhY (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 12 Jul 2019 19:37:24 -0400
Received: from namei.org ([65.99.196.166]:34978 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfGLXhY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Jul 2019 19:37:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6CNZroi024242;
        Fri, 12 Jul 2019 23:35:53 GMT
Date:   Sat, 13 Jul 2019 09:35:53 +1000 (AEST)
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
Subject: Re: [PATCH v5 03/12] S.A.R.A.: cred blob management
In-Reply-To: <1562410493-8661-4-git-send-email-s.mesoraca16@gmail.com>
Message-ID: <alpine.LRH.2.21.1907130921580.21853@namei.org>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com> <1562410493-8661-4-git-send-email-s.mesoraca16@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 6 Jul 2019, Salvatore Mesoraca wrote:

> Creation of the S.A.R.A. cred blob management "API".
> In order to allow S.A.R.A. to be stackable with other LSMs, it doesn't use
> the "security" field of struct cred, instead it uses an ad hoc field named
> security_sara.
> This solution is probably not acceptable for upstream, so this part will
> be modified as soon as the LSM stackable cred blob management will be
> available.

This description is out of date wrt cred blob sharing.

> +	if (sara_data_init()) {
> +		pr_crit("impossible to initialize creds.\n");
> +		goto error;
> +	}
> +

> +int __init sara_data_init(void)
> +{
> +	security_add_hooks(data_hooks, ARRAY_SIZE(data_hooks), "sara");
> +	return 0;
> +}

This can't fail so make it return void and simplify the caller.



-- 
James Morris
<jmorris@namei.org>

