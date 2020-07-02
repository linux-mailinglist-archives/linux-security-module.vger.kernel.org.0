Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4473212F33
	for <lists+linux-security-module@lfdr.de>; Fri,  3 Jul 2020 00:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgGBWAZ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 2 Jul 2020 18:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgGBWAX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Jul 2020 18:00:23 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8131C08C5DF
        for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2020 15:00:22 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ga4so31544837ejb.11
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2020 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQjS9Ie2JLW+5joMKLIKCU6b/2UCakl57GgRGFSlTtk=;
        b=y2q6/ZImKC9EyqaN+Cp25cLz1ciVm4U7qtXibl4rJLq7yDQxPIwOaQiDW4uPnhkAI8
         VRW0HSRxSAmlfFw/Jce/k0WugBY6dAl4O6HQ/sc/VLK6/v4c05dZ28qBMUNFtXbku8Ch
         AULevi22Fz6RKjCBjNEoLvV62nXHhiI0ALpbVAFFC6eC3/8cU19LT7W6/+o8hdExkIVp
         SpzhSXPTolBo/5B/rPenjUqcOQ+Q44Ekpah8XqISOcoMHY3/BTSU/R5r9kYGnOKn1iQ4
         3Eelioz4+/tk104uJvI7uaxboR8nMC2mTgZeV8NgshGTgOJtB/3rVeJ8cjXz8tU5nKfO
         mLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQjS9Ie2JLW+5joMKLIKCU6b/2UCakl57GgRGFSlTtk=;
        b=XM4NDNAzpF3+yGGHE171sF1iumRQVcGoHcb/pE22l/nfsoozUQTIpzQPqYEjMuJKrY
         qADYFOoyvtVblgUSsIL/TE9mv0w+e/wi1GcdXeljPiVRiNA6ai+B3sXJwtOKBAf4jX7M
         7KgIcaOjGL+YxiEHlj9yDjfbuVmc4d+YngPx4ofOijd2jfgD7EGg5tzOgtGvHB5Ql76q
         SZaMQSIyMq81fcWlLh+Xj7jTK3p54KWUSyUBwHJ7Tlnfu5JDw/99IXHa6oDbrvSMwwIe
         F6EZbB5DCwSszNpbHSeh4Epx6ElRJYtqcelM+qmPNET39Bf+xzvF3jyY+q6YF9FXIhi5
         DLfw==
X-Gm-Message-State: AOAM5322TZ1+jtlmj6wcUB/B2dRQGp4LxElKFElzBQNAAIgXmujIzv+H
        7bqnYAUlapNrY5wOMVrLwcEXyGDGQfOdBrlrprWq
X-Google-Smtp-Source: ABdhPJymg7hoMn4NQo9VkFS8SsNN1VIXxrtL9dctJ/u8BOTmybW6CezLxVIBxEEQqtZorAPFuFOU58gSTBkhV1lUPSk=
X-Received: by 2002:a17:906:456:: with SMTP id e22mr23944788eja.178.1593727221274;
 Thu, 02 Jul 2020 15:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200701064906.323185-1-areber@redhat.com> <20200701064906.323185-4-areber@redhat.com>
 <20200702211647.GB3283@mail.hallyn.com>
In-Reply-To: <20200702211647.GB3283@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Jul 2020 18:00:10 -0400
Message-ID: <CAHC9VhQZ=cwiOay6OMMdM1UHm69wDaga9HBkyTbx8-1OU=aBvA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] prctl: Allow ptrace capable processes to change /proc/self/exe
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jul 2, 2020 at 5:16 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> On Wed, Jul 01, 2020 at 08:49:06AM +0200, Adrian Reber wrote:
> > From: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> >
> > Previously, the current process could only change the /proc/self/exe
> > link with local CAP_SYS_ADMIN.
> > This commit relaxes this restriction by permitting such change with
> > CAP_CHECKPOINT_RESTORE, and the ability to use ptrace.
> >
> > With access to ptrace facilities, a process can do the following: fork a
> > child, execve() the target executable, and have the child use ptrace()
> > to replace the memory content of the current process. This technique
> > makes it possible to masquerade an arbitrary program as any executable,
> > even setuid ones.
> >
> > Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> > Signed-off-by: Adrian Reber <areber@redhat.com>
>
> This is scary.  But I believe it is safe.
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>
> I am a bit curious about the implications of the selinux patch.
> IIUC you are using the permission of the tracing process to
> execute the file without transition, so this is a way to work
> around the policy which might prevent the tracee from doing so.
> Given that SELinux wants to be MAC, I'm not *quite* sure that's
> considered kosher.  You also are skipping the PROCESS__PTRACE
> to SECCLASS_PROCESS check which selinux_bprm_set_creds does later
> on.  Again I'm just not quite sure what's considered normal there
> these days.
>
> Paul, do you have input there?

I agree, the SELinux hook looks wrong.  Building on what Christian
said, this looks more like a ptrace operation than an exec operation.

-- 
paul moore
www.paul-moore.com
