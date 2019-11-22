Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11177105D8B
	for <lists+linux-security-module@lfdr.de>; Fri, 22 Nov 2019 01:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfKVANB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 21 Nov 2019 19:13:01 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33021 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKVANB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Nov 2019 19:13:01 -0500
Received: by mail-lf1-f65.google.com with SMTP id d6so4122752lfc.0
        for <linux-security-module@vger.kernel.org>; Thu, 21 Nov 2019 16:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOBi1WwWtcIIHmDYKEBflC9qA0sYXu/jMhHwxUFr15o=;
        b=D8qwDVI1cMBgCC8PKeBS5gUeUODYEEH56772JUFSDUraDMHYm94+FTtHzg09IJB3BZ
         HbQT4ZNQOhd3fTe8tBToaiHr20dA30W/pWbOHLzOIIik51TcAUZoYd7tkPL4puZggQVX
         3icvCKc5PBQXRctYNUpWrek5wyKIF6yW9UKEyj91zdF4FUA8Wi2LmbvcB+ATm8FOGHNd
         S/6Gso7JPzpgu868w8HObQEi2b6VnZ5xgcPGNU7OW8WD8xmgnCssANMsGZZw3sLKWLyL
         ldw9Hm/PGyCISycfZ7srQg9QYp7wCRJUolOsySKWQy/tH/yQjIX0l0XzNpXv5KyImTYY
         Bc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOBi1WwWtcIIHmDYKEBflC9qA0sYXu/jMhHwxUFr15o=;
        b=HXB5rbWYp9kQEkC+rbk94aI8XWtUtnqVlmixLadc9jDWkUjpOoxVdyQ+jAbzL08WcH
         EtMZXJlkylk6GVvFl/byTZruRxLSHV18Hmyi3YJHdwI1qmexrMLj1oArQ4I9OWKuJDt6
         ChJjX6gF4auHwrcBHUznImxtiqfWZK2OvMkdlg0z0vez7O+MTMSBGtRMhFmkrB/ntP+P
         dsG+eEmCBWm/4DsfmxzVGSlyFxftSV5/EMUpYjJ5yXv97RzlC7qljRTAsa8+bYNMIxzS
         oHbm6S8zflUl58Q+XH2RlDibc4yORcHsXNzwrbqFa/roIZpEg6nHJQWh074TSKreanup
         bIsg==
X-Gm-Message-State: APjAAAVwAjhG5x8CukcrlHO5veAFvgthHKd2vi1tf7wt2nG7AUdcVqZb
        tGKWDyecUmf7JWTYihCm268qsvUI3uilFaeNonHA
X-Google-Smtp-Source: APXvYqzoZahyHJ95X8I/WE5Tjtr+DJ4kcSHxi7f5BXJohRfDYHuENEejmf6qONF+F6BOZf5ufdwSCWHiYEVi2w+38mk=
X-Received: by 2002:a19:6a15:: with SMTP id u21mr9182848lfu.31.1574381578839;
 Thu, 21 Nov 2019 16:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20191121145245.8637-1-sds@tycho.nsa.gov> <20191121145245.8637-2-sds@tycho.nsa.gov>
In-Reply-To: <20191121145245.8637-2-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 21 Nov 2019 19:12:47 -0500
Message-ID: <CAHC9VhTAq7CgcRRcvZCYis7ELAo+bo2q8pCUXfHUP9YAcUhwsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] selinux: fall back to ref-walk upon
 LSM_AUDIT_DATA_DENTRY too
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, will@kernel.org, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 21, 2019 at 9:52 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> commit bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
> passed down the rcu flag to the SELinux AVC, but failed to adjust the
> test in slow_avc_audit() to also return -ECHILD on LSM_AUDIT_DATA_DENTRY.
> Previously, we only returned -ECHILD if generating an audit record with
> LSM_AUDIT_DATA_INODE since this was only relevant from inode_permission.
> Return -ECHILD on either LSM_AUDIT_DATA_INODE or LSM_AUDIT_DATA_DENTRY.
> LSM_AUDIT_DATA_INODE only requires this handling due to the fact
> that dump_common_audit_data() calls d_find_alias() and collects the
> dname from the result if any.
> Other cases that might require similar treatment in the future are
> LSM_AUDIT_DATA_PATH and LSM_AUDIT_DATA_FILE if any hook that takes
> a path or file is called under RCU-walk.
>
> Fixes: bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/avc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 74c43ebe34bb..f1fa1072230c 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -779,7 +779,8 @@ noinline int slow_avc_audit(struct selinux_state *state,
>          * during retry. However this is logically just as if the operation
>          * happened a little later.
>          */
> -       if ((a->type == LSM_AUDIT_DATA_INODE) &&
> +       if ((a->type == LSM_AUDIT_DATA_INODE ||
> +            a->type == LSM_AUDIT_DATA_DENTRY) &&
>             (flags & MAY_NOT_BLOCK))
>                 return -ECHILD;

Added the LSM list as I'm beginning to wonder if we should push this
logic down into common_lsm_audit(), this problem around blocking
shouldn't be SELinux specific.

For the LSM folks just joining, the full patchset can be found here:
* https://lore.kernel.org/selinux/20191121145245.8637-1-sds@tycho.nsa.gov/T/#t

-- 
paul moore
www.paul-moore.com
