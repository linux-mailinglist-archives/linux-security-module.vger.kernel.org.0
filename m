Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A66D343178
	for <lists+linux-security-module@lfdr.de>; Sun, 21 Mar 2021 06:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhCUFt6 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 21 Mar 2021 01:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhCUFtd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 21 Mar 2021 01:49:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0588C061574;
        Sat, 20 Mar 2021 22:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uXfNM/aoeG0C6gMF2mOkomBH0iMI0iTCKPtZRtjZo54=; b=CQ3ja5rnjOK0ctPu5BYb+tsWNJ
        w3clZjo3ohAuviNYExObS3l7zUO9Zn7tq3bmlqEz/1ia4LQjrkrP4eAAo13/Hvr1xRT82xq/jQ/Ui
        gQgKbxgGtO414OpzqSMOWGv0EpCmN2/d+6+zKXXlB8Cj9vUboONO7jXI9PB2lrOHKBWkbENJjyJgy
        9vWlIMpRjE5VinDtwmM57N7DTzBXOHq5TohXB+lNS4KavqgIbZC0K69BwszVJZDmvvXNtJ8s6IA/7
        Is4HagethxKXWTJ44DrJuNZADa4AsvmREPoVNgfYC80nvc10O+zpWMD/TzjopEn4WtW6pd1OtAPga
        QgYVq9FQ==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNqxu-002BZH-UV; Sun, 21 Mar 2021 05:49:32 +0000
Date:   Sat, 20 Mar 2021 22:49:30 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] device_cgroup: A typo fix
In-Reply-To: <20210321040941.31973-1-unixbhaskar@gmail.com>
Message-ID: <1f7b653a-3e15-eea4-9128-402b2ed28b@bombadil.infradead.org>
References: <20210321040941.31973-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_224931_005385_32AD44C1 
X-CRM114-Status: GOOD (  12.79  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote: > > s/acessed/accessed/
    > > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by:
   Randy Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/acessed/accessed/
>
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

although I still don't care for the $Subject.


> ---
> Changes from V1:
>  Getting rid of unwanted comment delimeter addition
>  Subject line missed propper commit subject labeling
>
> security/device_cgroup.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index 04375df52fc9..30b3083276df 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -409,7 +409,7 @@ static bool verify_new_ex(struct dev_cgroup *dev_cgroup,
> 		} else {
> 			/*
> 			 * new exception in the child will add more devices
> -			 * that can be acessed, so it can't match any of
> +			 * that can be accessed, so it can't match any of
> 			 * parent's exceptions, even slightly
> 			 */
> 			match = match_exception_partial(&dev_cgroup->exceptions,
> --
> 2.20.1
>
>
