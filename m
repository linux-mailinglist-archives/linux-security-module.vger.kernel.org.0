Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E583369F2
	for <lists+linux-security-module@lfdr.de>; Thu, 11 Mar 2021 02:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCKB47 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 10 Mar 2021 20:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhCKB4o (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Mar 2021 20:56:44 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56070C061574
        for <linux-security-module@vger.kernel.org>; Wed, 10 Mar 2021 17:56:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y6so426257eds.1
        for <linux-security-module@vger.kernel.org>; Wed, 10 Mar 2021 17:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgYrALYRpO2A+WbpiwGj0OYEpcJcSYMExr2Frk/9tDY=;
        b=1E3lSM66GDUj8+2H5YW3qnZLn0D7P5Yt9K3k3O22IkOF3ek944c4v6s93WHq94exbC
         PiwcX1xNUoNzpHG9B4WSai8YNsbRbXXgmL1yPOYZrqH1ZYASt8IFSKpjhBd7ldxMVosK
         DUDd3ytAojBD0SKpfiQjJhvWP5fAka8u/2vqJKsI3YqiinOHrsfFhV2AwkJtbRV5ofPL
         oD6exRJ1jpYIWqSE29SU+J6/0+3c3/GGnSP7/Ju0s5gdvnWTGzBpQJ5Y1mip9x5tp4Ht
         2fmq3d5H0TDBN/FwOSjEZZHsTvaULWJ60+M5cFhtIv1wHUwB3yBn8u3NGz0ra5Ifr9V9
         BDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgYrALYRpO2A+WbpiwGj0OYEpcJcSYMExr2Frk/9tDY=;
        b=j2nSNcX/LpS0XT2cHCKGoOvMrXA7xMTBmxapyAvQ061S5yh4Q5OrjAEbBOtxbvK4Vo
         J1m9ehdIUO/9SXTWDRUo/q1ZsVHF7XqmZT6RKIrj8a5OrjuiSm9/me6Ii402y7lB35q0
         Zpk+R9wVGx+2f61dHNeyUrIZn4aWpLqgl1bsK1R7+UJCKnUS9yPBb5wRxuFWhub9vRA9
         up5m1+nVlWh7ua7JHgxi7zDF1tKhfYdjoAmPQjZ6gPXJZpGttNVvCyHkDIVhTjsNh65y
         9imkBVwVM6nH7ATGh43Y/uhT/V+rphX7uOfvsvVXemCJgdafo5Tc7TKuP+Ytk+tnP/f5
         C7Qw==
X-Gm-Message-State: AOAM531NowIz76Abu0fzIM7SXWfMeuxPSgab1EHP4IzwzYa/dgyE31m8
        EZBHVF0LkqE4oGvkf3eSOBYLG2K08Gdjwufzga94y6DOSIeN
X-Google-Smtp-Source: ABdhPJwnYcNSoXOULX46ASJXgAFM3cjksNO9omg612I1jwKt1VXSvvAQTA89A9jfj8hUGY9t6MKDJx70wQ43U0b/7e4=
X-Received: by 2002:aa7:db4f:: with SMTP id n15mr6176265edt.12.1615427802976;
 Wed, 10 Mar 2021 17:56:42 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377734508.87807.8537642254664217815.stgit@sifl> <eda68a4e-f4f5-88c9-e748-1f1831f0266a@namei.org>
 <CAHC9VhRJ-CHMag-dmxDVBp0efQbj7mgGdhs2AjfWFP_kDCGTfw@mail.gmail.com>
 <CABXk95AXH=KHtQFYw6p76BLC-OEBBbxZnL9hA8tiBqdN8Dj6Pg@mail.gmail.com>
 <CAHC9VhQzNN=_iq_9xLs6k92__bY1WL+8oFqh7kHTY5iRc7xK7Q@mail.gmail.com> <CABXk95AodFLLH+ay7tF8fUhScBAMUPjbABr3CdK=M50hB0z4sA@mail.gmail.com>
In-Reply-To: <CABXk95AodFLLH+ay7tF8fUhScBAMUPjbABr3CdK=M50hB0z4sA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Mar 2021 20:56:31 -0500
Message-ID: <CAHC9VhQG1Md5KPkobr8zTe9gMtJNu0q3_-woSE5+3BWmLMPPvg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
To:     Jeffrey Vander Stoep <jeffv@google.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-audit@redhat.com, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 10, 2021 at 3:21 AM Jeffrey Vander Stoep <jeffv@google.com> wrote:
> On Fri, Mar 5, 2021 at 12:44 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Mar 4, 2021 at 5:04 AM Jeffrey Vander Stoep <jeffv@google.com> wrote:
> > > On Sat, Feb 20, 2021 at 3:45 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Fri, Feb 19, 2021 at 9:57 PM James Morris <jmorris@namei.org> wrote:
> > > > > On Fri, 19 Feb 2021, Paul Moore wrote:
> > > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > > > index c119736ca56ac..39d501261108d 100644
> > > > > > --- a/drivers/android/binder.c
> > > > > > +++ b/drivers/android/binder.c
> > > > > > @@ -2700,7 +2700,7 @@ static void binder_transaction(struct binder_proc *proc,
> > > > > >               u32 secid;
> > > > > >               size_t added_size;
> > > > > >
> > > > > > -             security_task_getsecid(proc->tsk, &secid);
> > > > > > +             security_task_getsecid_subj(proc->tsk, &secid);
> > > > > >               ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> > > > > >               if (ret) {
> > > > > >                       return_error = BR_FAILED_REPLY;
> > > > >
> > > > > Can someone from the Android project confirm this is correct for binder?
> > >
> > > This looks correct to me.
> >
> > Thanks for the verification.  Should I assume the SELinux specific
> > binder changes looked okay too?
> >
> Yes, those also look good to me.

Thanks, that binder changes were the one area I wasn't 100% on, I
appreciate the verification.

-- 
paul moore
www.paul-moore.com
