Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F747117B9B
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Dec 2019 00:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfLIXnB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 9 Dec 2019 18:43:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40766 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfLIXnB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Dec 2019 18:43:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id y5so12152742lfy.7
        for <linux-security-module@vger.kernel.org>; Mon, 09 Dec 2019 15:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtqRa889GoZnx3kjAxABN57oHgPb28WLq9td6hKp/GE=;
        b=V9GgiIatHKva79qeqGQ7v6slhUTadyGG1+h3fDzsFh/uOzEcFcxRjym6vTgH937xOB
         SbYCmsGZfVz8cbGv+ZZPAHzMWirrT3yhk3iwUevLVVgYnrqqP2pNhwyhXz3+OEqfVMhG
         sNhvLmkjKNxEyRClU/Onat4Glla63AkMe/xIvksLwtaKxNuWc1miERjcSY472yeHiNzn
         C7J3TJCslwdiKL71kAHxOclAn8uJHyirx7hyAlji3IHCifRqtiaGX4XZEDNUA4Ncrg9l
         l0AMYEMQGSGviXnDKpPRc8cFXhFGagbUaxirGRMhdprVnEW+T/0KejF1Zv46t4bTaQzC
         V/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtqRa889GoZnx3kjAxABN57oHgPb28WLq9td6hKp/GE=;
        b=Ya1XdICnYndA5a8Gfh4nil32EvCkco70aRQgTF7j/dB0igL7cm4EYuxMzNxNRt/Z29
         fbWACmIPDihppSmz9lBzdjbz4AJt28Lc1Q7Dhh8MR181ksqDrpTSRJR08/9xVReenIDD
         k20eyZ8pr4htusbn7iu/dTh9Z+p+7+YVUCk5jPLqdcDQLU651WhTj2vM3qEEjJbx6GPE
         qAc1qYwEjj8vWYd5XZ3XDLmPv4XsTgFBh/GVviKUOoWc+yxOYIK2rc20UwfxBihR5wa7
         QDTySMvCKmYjCjQGsV0lu2UKrENT+W+B47wc0imJkWM+EMndxkwmv2y/Y7DbBKxgKw5U
         CpCA==
X-Gm-Message-State: APjAAAWMZ5+qAEbDx7sfzWmoeC3qiy8Tw3W29tNxF4kSVcpHc/3NsBtt
        ymKEI1bzcLfatjGpnR5VjUmH8aTQ0sSP/IgypeDO4GeUsw==
X-Google-Smtp-Source: APXvYqz5xnlRDWwRwSMy0RIrgoC4ocWWMNdNe/ANkV+Dh1zgZqivst4S8XwY1Os+U+Jo1pW9zxV59uc+C8LU6y9O4jM=
X-Received: by 2002:a19:f514:: with SMTP id j20mr15634235lfb.31.1575934979071;
 Mon, 09 Dec 2019 15:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20191122172245.7875-1-sds@tycho.nsa.gov> <20191122172245.7875-2-sds@tycho.nsa.gov>
In-Reply-To: <20191122172245.7875-2-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Dec 2019 18:42:47 -0500
Message-ID: <CAHC9VhS_GthVA9+mV0E7D0HTUTuC7u-4J1ef2cpW56wD+85bOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: fall back to ref-walk if audit is required
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, will@kernel.org, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 22, 2019 at 12:23 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> commit bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
> passed down the rcu flag to the SELinux AVC, but failed to adjust the
> test in slow_avc_audit() to also return -ECHILD on LSM_AUDIT_DATA_DENTRY.
> Previously, we only returned -ECHILD if generating an audit record with
> LSM_AUDIT_DATA_INODE since this was only relevant from inode_permission.
> Move the handling of MAY_NOT_BLOCK to avc_audit() and its inlined
> equivalent in selinux_inode_permission() immediately after we determine
> that audit is required, and always fall back to ref-walk in this case.
>
> Fixes: bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
> Reported-by: Will Deacon <will@kernel.org>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/avc.c         | 24 +++++-------------------
>  security/selinux/hooks.c       | 11 +++++++----
>  security/selinux/include/avc.h |  8 +++++---
>  3 files changed, 17 insertions(+), 26 deletions(-)

Also merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
