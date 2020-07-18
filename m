Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C414422482F
	for <lists+linux-security-module@lfdr.de>; Sat, 18 Jul 2020 05:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGRC7o (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 17 Jul 2020 22:59:44 -0400
Received: from mail.hallyn.com ([178.63.66.53]:35298 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgGRC7o (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Jul 2020 22:59:44 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id CC52AC13; Fri, 17 Jul 2020 21:59:42 -0500 (CDT)
Date:   Fri, 17 Jul 2020 21:59:42 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] LSM: drop duplicated words in header file comments
Message-ID: <20200718025942.GB11982@mail.hallyn.com>
References: <9299abf4-75e3-6d73-a8b8-c2617208a990@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9299abf4-75e3-6d73-a8b8-c2617208a990@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 17, 2020 at 04:36:40PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop the doubled words "the" and "and" in comments.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> Cc: linux-security-module@vger.kernel.org
> ---
>  include/linux/lsm_hook_defs.h |    2 +-
>  include/linux/lsm_hooks.h     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200714.orig/include/linux/lsm_hook_defs.h
> +++ linux-next-20200714/include/linux/lsm_hook_defs.h
> @@ -15,7 +15,7 @@
>   */
>  
>  /*
> - * The macro LSM_HOOK is used to define the data structures required by the
> + * The macro LSM_HOOK is used to define the data structures required by
>   * the LSM framework using the pattern:
>   *
>   *	LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
> --- linux-next-20200714.orig/include/linux/lsm_hooks.h
> +++ linux-next-20200714/include/linux/lsm_hooks.h
> @@ -822,7 +822,7 @@
>   *	structure. Note that the security field was not added directly to the
>   *	socket structure, but rather, the socket security information is stored
>   *	in the associated inode.  Typically, the inode alloc_security hook will
> - *	allocate and and attach security information to
> + *	allocate and attach security information to
>   *	SOCK_INODE(sock)->i_security.  This hook may be used to update the
>   *	SOCK_INODE(sock)->i_security field with additional information that
>   *	wasn't available when the inode was allocated.
> 
