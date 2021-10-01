Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0BD41EFE5
	for <lists+linux-security-module@lfdr.de>; Fri,  1 Oct 2021 16:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354649AbhJAOqu (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 1 Oct 2021 10:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354643AbhJAOqt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Oct 2021 10:46:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D220AC06177F
        for <linux-security-module@vger.kernel.org>; Fri,  1 Oct 2021 07:45:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g8so35836895edt.7
        for <linux-security-module@vger.kernel.org>; Fri, 01 Oct 2021 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/H4joMu0i9PRc5y/5IfyO1O3DFiCiHeAFXYOy9MybLU=;
        b=Sqtq3HVEmFqyq/iZGy3bAUBBvoIIgqDCQe03hPij1pHQ+afGQ+qW4oxzfc6+IQYFAk
         8sdQMlTfSDwM/Vdd1CJBkNXlYzqUIs7kjIrH/2t+zg3ttq27VO3sQ43AlcBfvpXxKTvl
         LJ3PlZ6m4VGH2MQRjDVCng2EuhT9h0wVEaeNU4baqn2jFjdOfQHFiF2yKOb9Jj/nE2WT
         +c/MWFqDTQ0Mz7EPjLT8UhMOzISMjhG8DhpniuDVQDNev5vXymJFaLiemoBg6FM8YkNB
         qKOz2aScbgR3tKjPuAU54oJVPgg5Bzspd8vBSSjyF4fyOuUspQHrydXkPUbbOutVmVuA
         y+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/H4joMu0i9PRc5y/5IfyO1O3DFiCiHeAFXYOy9MybLU=;
        b=orlDj892kVds/7blFMbnvsy/FswY56hpxjnjae8qGVYtemCt2wEt/e0AafyVR2UqDL
         FQRPh5s0bBNJxHHZMmsmYI7f9VGg9k9d52WQxaPfqtFivlh74TaWn4E15MSw2xwLu4bN
         +nmVEXA/bY4mfqoatMnZzxfotrEKKUMJlI7LLAq7vvD5ZNqhjEEnuqSI/qDlZQjTnN4q
         nPPdw5fx2vXkGdKem8BLabT0a1HFujPmsvrBKuZL65JITPE7q1VriUZEKf9kNOASUCY5
         RKCDrQgUz7o1Z4PryOJMiWXePDMZBVgSehsFI/AE8soHumnfur0ZGc+RujHY/DYYbKfM
         yWrg==
X-Gm-Message-State: AOAM532IFHlzF5F+IIlnDgo9+vkc1Db1BdxB8IF9qvGq/vNgIrhN8FqN
        ltCAly55Eu3nNV4Sb6BAmW8yDt+WKutr/3UHRljW
X-Google-Smtp-Source: ABdhPJzS4Iw/cDlHH6KS55tisJ+ktQs+SukEzIuiCOuC5dk2GUdyTS52lv4qmMGUFGDGNBh9PabWSBxWmsNBGr46Xdw=
X-Received: by 2002:a50:9b06:: with SMTP id o6mr14719691edi.284.1633099502606;
 Fri, 01 Oct 2021 07:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211001024506.3762647-1-tkjos@google.com> <CAHC9VhQ-uziaYRYWaah=RMmz7HUVvxGs+4F=g2sizVXR0ZSWVw@mail.gmail.com>
In-Reply-To: <CAHC9VhQ-uziaYRYWaah=RMmz7HUVvxGs+4F=g2sizVXR0ZSWVw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 Oct 2021 10:44:51 -0400
Message-ID: <CAHC9VhSet40x697Of5GJhpuWo-AH4TzEu_SgfBDMmANSzByQEw@mail.gmail.com>
Subject: Re: [PATCH] binder: use cred instead of task for selinux checks
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, keescook@chromium.org,
        jannh@google.com, Jeffrey Vander Stoep <jeffv@google.com>,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 1, 2021 at 10:38 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Sep 30, 2021 at 10:45 PM Todd Kjos <tkjos@google.com> wrote:
> >
> > Save the struct cred associated with a binder process
> > at initial open to avoid potential race conditions
> > when converting to a security ID.
> >
> > Since binder was integrated with selinux, it has passed
> > 'struct task_struct' associated with the binder_proc
> > to represent the source and target of transactions.
> > The conversion of task to SID was then done in the hook
> > implementations. It turns out that there are race conditions
> > which can result in an incorrect security context being used.
> >
> > Fix by saving the 'struct cred' during binder_open and pass
> > it to the selinux subsystem.
> >
> > Fixes: 79af73079d75 ("Add security hooks to binder and implement the
> > hooks for SELinux.")
> > Signed-off-by: Todd Kjos <tkjos@google.com>
> > Cc: stable@vger.kernel.org # 5.14 (need backport for earlier stables)
> > ---
> >  drivers/android/binder.c          | 14 +++++----
> >  drivers/android/binder_internal.h |  3 ++
> >  include/linux/lsm_hook_defs.h     | 14 ++++-----
> >  include/linux/security.h          | 28 +++++++++---------
> >  security/security.c               | 14 ++++-----
> >  security/selinux/hooks.c          | 48 +++++++++----------------------
> >  6 files changed, 52 insertions(+), 69 deletions(-)
>
> Thanks Todd, I'm happy to see someone with a better understanding of
> binder than me pitch in to clean this up :)  A couple of quick
> comments/questions below ...

Ooops, I was a little over zealous when trimming my response and I
accidentally cut off my comment that the associated comment blocks in
include/linux/lsm_hooks.h should also be updated to reflect the binder
LSM hook changes.

-- 
paul moore
www.paul-moore.com
