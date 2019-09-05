Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0FCAACF7
	for <lists+linux-security-module@lfdr.de>; Thu,  5 Sep 2019 22:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbfIEU1M (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 5 Sep 2019 16:27:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34039 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731552AbfIEU1L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Sep 2019 16:27:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id z21so3146223lfe.1
        for <linux-security-module@vger.kernel.org>; Thu, 05 Sep 2019 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVsYT5LiDmTkAuyzoCSrPPZFZ3YwCseupt2r60psf1I=;
        b=bHZ8uJcq2zcPozORM+OzqAQ0bUd3F3XQYjLPmB7yusYpkag+KiR64E1V3jWDbDycP2
         vOrw5bkSrr+36y6niHqNRzPtMJQ6GSjsiuF+UC4uv855LXZNJ4rgsMRT28AlJ+Cp1/hI
         rUDkTms10z6P/y2UpO/FxewO0gHi1hYSi2RKoU6ZYGm9DfXNhEHaepUXf2esHvoMzb/E
         5wPof8VuXMSlT7sthHMqWPY/4pBi2Jk3nTZe+3Pl6UM51Yk71NvLz0SWI7qiwWWgTxzw
         LGWlSPIwqjbYVjWl9dR0iGioUGl3k87QExGfIHBFkkfaLW3Ee5e7FIkMaQ84U/vICuA0
         sWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVsYT5LiDmTkAuyzoCSrPPZFZ3YwCseupt2r60psf1I=;
        b=r/2CnIqVMQGjHIM1sIDLnNJfB98iJkl31tAfPiPCdrOV8CgITlSDL6k+FK/HiJ5Gfe
         /LrM5DDDNFV5styfbUOBzHamdZS/y+XMUuBshgzI329xE06ZC0yVIirvY7xH4yW5KCtN
         phZtIk0KfQIgkMp2LMVKQ0lCgEHwETWID9ReKVSzo9Ih55GKfQMcdtDPK6lkyYDUZJAO
         uSRT0/Fn9OsWXVhEH3gn2JymKxbuNvtJ3aEBNNAyPV9SqRJWWvTOhcPcXRn9ZRkNC3Pc
         pb5b4BdYrLNR1ifSXB2Q/oqCJGSRg7BnhYEooAOVopf6wz7GCvumm6LGYPGKnJRUX7aD
         c43g==
X-Gm-Message-State: APjAAAX0YrzVxz0+LLZgkBcPb+selghoZmSHAC02RM6t6q3p3jPOs8Zw
        GRK114JZXizGeZpYkG+saqHDEL949sqIKaqATOSD
X-Google-Smtp-Source: APXvYqy9TN7/1cq1Af9uGfhXRRn5jIXAUcggtttorgLfQcc8cNyky0AkBfXNplb8OsogBH6JhvMh7RQCbDI4mrQL/QI=
X-Received: by 2002:a19:8c14:: with SMTP id o20mr3712142lfd.158.1567715229715;
 Thu, 05 Sep 2019 13:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <156763801639.13084.2856415198922787618.stgit@chester> <alpine.LRH.2.21.1909051134200.30667@namei.org>
In-Reply-To: <alpine.LRH.2.21.1909051134200.30667@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Sep 2019 16:26:58 -0400
Message-ID: <CAHC9VhS9Rz2T0W=g_e0a5Jn7XxSjXAA7nTHSEi3z__PQN3oxTg@mail.gmail.com>
Subject: Re: [PATCH] lsm: remove current_security()
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 4, 2019 at 9:34 PM James Morris <jmorris@namei.org> wrote:
> On Wed, 4 Sep 2019, Paul Moore wrote:
>
> > There are no remaining callers and it really is unsafe in the brave
> > new world of LSM stacking.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: James Morris <jamorris@linux.microsoft.com>

Thanks.

> You might as well push this through with the SELinux changes.

That is what I was planning, it will break the build if merged via
another tree without Stephen's patch.  Merged into selinux/next to be
sent upstream during the next merge window.

-- 
paul moore
www.paul-moore.com
