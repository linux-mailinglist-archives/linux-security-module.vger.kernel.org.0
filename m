Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB5A16843C
	for <lists+linux-security-module@lfdr.de>; Fri, 21 Feb 2020 17:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgBUQ4f (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 21 Feb 2020 11:56:35 -0500
Received: from namei.org ([65.99.196.166]:47406 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgBUQ4f (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Feb 2020 11:56:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 01LGu5Us014747;
        Fri, 21 Feb 2020 16:56:05 GMT
Date:   Sat, 22 Feb 2020 03:56:05 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     YueHaibing <yuehaibing@huawei.com>
cc:     dhowells@redhat.com, casey@schaufler-ca.com, sds@tycho.nsa.gov,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH -next] security: remove duplicated include from
 security.h
In-Reply-To: <20200221074342.16788-1-yuehaibing@huawei.com>
Message-ID: <alpine.LRH.2.21.2002220355530.18183@namei.org>
References: <20200221074342.16788-1-yuehaibing@huawei.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 21 Feb 2020, YueHaibing wrote:

> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/security.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 910a1ef..fe2c566 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -30,7 +30,6 @@
>  #include <linux/err.h>
>  #include <linux/string.h>
>  #include <linux/mm.h>
> -#include <linux/fs.h>
>  
>  struct linux_binprm;
>  struct cred;
> 

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<jmorris@namei.org>

