Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 995B0FD76
	for <lists+linux-security-module@lfdr.de>; Tue, 30 Apr 2019 18:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfD3QIC (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 30 Apr 2019 12:08:02 -0400
Received: from namei.org ([65.99.196.166]:36620 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3QIC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Apr 2019 12:08:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3UG7sGD028650;
        Tue, 30 Apr 2019 16:07:54 GMT
Date:   Wed, 1 May 2019 02:07:54 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PULL] Smack: one more change for 5.2
In-Reply-To: <a0fd7fe4-d86f-798e-df66-c4390bc38567@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1905010207400.32268@namei.org>
References: <a0fd7fe4-d86f-798e-df66-c4390bc38567@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 29 Apr 2019, Casey Schaufler wrote:

> James, would you pull this fix from Tetsuo? Thank you.
> 
> The following changes since commit f7450bc6e76860564f3842a41892f9b74313cc23:
> 
>   Smack: Fix IPv6 handling of 0 secmark (2019-04-03 14:28:38 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/cschaufler/next-smack.git smack-for-5.2-b
> 
> for you to fetch changes up to b9ef5513c99bf9c8bfd9c9e8051b67f52b2dee1e:
> 
>   smack: Check address length before reading address family (2019-04-29
> 17:32:27 -0700)
> 

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<jmorris@namei.org>

