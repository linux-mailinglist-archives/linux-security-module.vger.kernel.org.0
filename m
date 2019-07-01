Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D38EB58
	for <lists+linux-security-module@lfdr.de>; Mon, 29 Apr 2019 22:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfD2UHm (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 29 Apr 2019 16:07:42 -0400
Received: from namei.org ([65.99.196.166]:36480 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfD2UHm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Apr 2019 16:07:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3TK7dWM026091;
        Mon, 29 Apr 2019 20:07:39 GMT
Date:   Tue, 30 Apr 2019 06:07:39 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tomoyo: Change pathname calculation for read-only
 filesystems.
In-Reply-To: <52027db5-a4e3-fc5e-4149-529d95d251b2@i-love.sakura.ne.jp>
Message-ID: <alpine.LRH.2.21.1904300607110.20645@namei.org>
References: <1551277164-8715-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp> <alpine.LRH.2.21.1902280724410.7990@namei.org> <52027db5-a4e3-fc5e-4149-529d95d251b2@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 12 Apr 2019, Tetsuo Handa wrote:

> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> ---
> >>  security/tomoyo/realpath.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
> >> index 85e6e31..e7832448 100644
> >> --- a/security/tomoyo/realpath.c
> >> +++ b/security/tomoyo/realpath.c
> >> @@ -295,7 +295,8 @@ char *tomoyo_realpath_from_path(const struct path *path)
> >>  		 * or dentry without vfsmount.
> >>  		 */
> >>  		if (!path->mnt ||
> >> -		    (!inode->i_op->rename))
> >> +		    (!inode->i_op->rename &&
> >> +		     !(sb->s_type->fs_flags & FS_REQUIRES_DEV)))
> >>  			pos = tomoyo_get_local_path(path->dentry, buf,
> >>  						    buf_len - 1);
> >>  		/* Get absolute name for the rest. */

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tomoyo

-- 
James Morris
<jmorris@namei.org>

