Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48545161E24
	for <lists+linux-security-module@lfdr.de>; Tue, 18 Feb 2020 01:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgBRAOi (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 17 Feb 2020 19:14:38 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44547 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgBRAOi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Feb 2020 19:14:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id g19so22661012eds.11
        for <linux-security-module@vger.kernel.org>; Mon, 17 Feb 2020 16:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1vYFSkdKc64YU909r3NN/RxWnwYJTgCAzVYJykceo4=;
        b=dPTgLG+YkkLPBW9twraX80RUev1XvRASe4OXsqmBuzlxxZR1SxZRuxc7fyQxjupqcv
         ywjCvau2eVJdkP5foRhAPzEcyd4ivNGjvrwSrpqLjRpinZLegg2PjvnFB4IcYDZbtusg
         OZM7pNxc/FUdrNtUYsh7YaTqEsOrn5cFeWXBEe99VTeuHLbmyAN2RScSyPrXh5hmWh6M
         0qlWjSjggkhQYRR4N0dNZI8R6JnLNapNQM7O0HIS5P1mBDyLb8bPpc9f6k9GXtEctxXJ
         EdfhLdGWGGq6HRVFkH/uZ8wGUPfyUCCbgTXqUTi8+h57QAJqSf1STcyVWvH8zlMBj3+a
         t/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1vYFSkdKc64YU909r3NN/RxWnwYJTgCAzVYJykceo4=;
        b=PGobyQM+aSDu+zZ2R3aLMyHuCNJUFbTzCCkkWNVRpBKkxwSJpZBLIjMgT4onv3miN2
         bu9ke2RI1ig0VQIk09cr0QMmA50azrlX2UggOLtw+wfYz+J8q/WaDICkE8dW+OuL0i5n
         jOKaLaKCnH5k0hsyn7axF39zgyFGX80ngrPrS+hHbjoYMM0WtIq66By67/JYCpOsmNS6
         zgSgfi/hdfHiOUXGH6G5aulpy1NyjdfSJr4YnQEHbAshB7eyWtqFByiWiDRrtWYtcX6a
         v97Dtkg8sXVt+7FdwzHXK9jvBMbhpq0LvOdbnEDRK5mjhEC5xnBTIjlmCjW1yspNGOh+
         4H8Q==
X-Gm-Message-State: APjAAAU18eZfBOk4QiEMIYpIyNd0DOOu8Vaq7zATdKPF79DnD2tMuBNP
        +Z4RI+rbJjjVIbIrpqc1N2JgxLvoZ1SCTHLgsejXHZtcsg==
X-Google-Smtp-Source: APXvYqwn0E8HDTiFXoWF/DdHcW13nSXh+LKbFA1du82DjhCL9nzW4mM5cz9RyEKKtHSNtDsWRxboa3ZJFD/dcTvfKo4=
X-Received: by 2002:a05:6402:61a:: with SMTP id n26mr15421837edv.135.1581984875984;
 Mon, 17 Feb 2020 16:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20200213194157.5877-1-sds@tycho.nsa.gov>
In-Reply-To: <20200213194157.5877-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Feb 2020 19:14:24 -0500
Message-ID: <CAHC9VhSsjrgu2Jn+yiV5Bz_wt2x5bgEXdhjqLA+duWYNo4gOtw@mail.gmail.com>
Subject: Re: [RFC PATCH] security,anon_inodes,kvm: enable security support for
 anon inodes
To:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     selinux@vger.kernel.org, kvm@vger.kernel.org, dancol@google.com,
        nnk@google.com, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 13, 2020 at 2:41 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> Add support for labeling and controlling access to files attached to anon
> inodes. Introduce extended interfaces for creating such files to permit
> passing a related file as an input to decide how to label the anon
> inode. Define a security hook for initializing the anon inode security
> attributes. Security attributes are either inherited from a related file
> or determined based on some combination of the creating task and policy
> (in the case of SELinux, using type_transition rules).  As an
> example user of the inheritance support, convert kvm to use the new
> interface for passing the related file so that the anon inode can inherit
> the security attributes of /dev/kvm and provide consistent access control
> for subsequent ioctl operations.  Other users of anon inodes, including
> userfaultfd, will default to the transition-based mechanism instead.
>
> Compared to the series in
> https://lore.kernel.org/selinux/20200211225547.235083-1-dancol@google.com/,
> this approach differs in that it does not require creation of a separate
> anonymous inode for each file (instead storing the per-instance security
> information in the file security blob), it applies labeling and control
> to all users of anonymous inodes rather than requiring opt-in via a new
> flag, it supports labeling based on a related inode if provided,
> it relies on type transitions to compute the label of the anon inode
> when there is no related inode, and it does not require introducing a new
> security class for each user of anonymous inodes.
>
> On the other hand, the approach in this patch does expose the name passed
> by the creator of the anon inode to the policy (an indirect mapping could
> be provided within SELinux if these names aren't considered to be stable),
> requires the definition of type_transition rules to distinguish userfaultfd
> inodes from proc inodes based on type since they share the same class,
> doesn't support denying the creation of anonymous inodes (making the hook
> added by this patch return something other than void is problematic due to
> it being called after the file is already allocated and error handling in
> the callers can't presently account for this scenario and end up calling
> release methods multiple times), and may be more expensive
> (security_transition_sid overhead on each anon inode allocation).
>
> We are primarily posting this RFC patch now so that the two different
> approaches can be concretely compared.  We anticipate a hybrid of the
> two approaches being the likely outcome in the end.  In particular
> if support for allocating a separate inode for each of these files
> is acceptable, then we would favor storing the security information
> in the inode security blob and using it instead of the file security
> blob.

Bringing this back up in hopes of attracting some attention from the
fs-devel crowd and Al.  As Stephen already mentioned, from a SELinux
perspective we would prefer to attach the security blob to the inode
as opposed to the file struct; does anyone have any objections to
that?

-- 
paul moore
www.paul-moore.com
