Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D7A373840
	for <lists+linux-security-module@lfdr.de>; Wed,  5 May 2021 12:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhEEKCE (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 5 May 2021 06:02:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47725 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhEEKB6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 May 2021 06:01:58 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <dimitri.ledkov@canonical.com>)
        id 1leEKx-0000tw-DI
        for linux-security-module@vger.kernel.org; Wed, 05 May 2021 10:00:59 +0000
Received: by mail-ot1-f72.google.com with SMTP id l10-20020a056830054ab0290241bf5f8c25so890127otb.11
        for <linux-security-module@vger.kernel.org>; Wed, 05 May 2021 03:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hmv8ovZ+lzfrtpGUv4rzbEFq7f24tUyHf3OpammTdVs=;
        b=OdaaORfBtFeWb26slhw4yZ1vUji4dHTnCkstDjcyZKZVKp+3p7JHyt4i2vcB4fLb8S
         8ojGHJ5jUXpweCrD+sNyBpoCESgWwcGHyfjBW7V21rLobfGRN0EYebHF4afKC4lW6tZO
         jERi8k9qejI/1M14VXCQSnNNaf6iap+2X4Mid4+ZDiamPJfGCfY2lL+fgHEWB56iNf7V
         3QUGjtleyjyARsSKsJlfoSSo/oFQRB7jUINFOnWpsefkUp0ALD5W/Hq/xKSuqdFVfqKt
         L5eL8wWh5ivfCiVhCle+DkFN45JF0dWXNoyujbPd1ITBE2YcuGN+3ErnSuwWoptOBhRS
         MtyQ==
X-Gm-Message-State: AOAM532Isn6+2dihVJrilmLb/FM0skZ9I+WYtUfvR3sKDO/+wGfqq2e4
        9IfSgu+ILSw1Qp69yQcjX0K9pBpPOXzS/fFiXj/LiGdj7gq0DbgroiPiESSmWQL3xLOgRu8glaj
        oQcEo6sC5t5UoQfB4qcPTCH7cQCJ686Gifl1qGinaGVQ2F/OcguPy1a0Pro5xts9WVi91HQ==
X-Received: by 2002:aca:f008:: with SMTP id o8mr21310002oih.106.1620208858222;
        Wed, 05 May 2021 03:00:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpRAMGh4AS9JFPRCCBNyvlCeqrX9tgmlXqMVO13lCuk0UmTaaGw2kTzBqWRUd/WpjRXslgaBkTm9Kbc76fMKA=
X-Received: by 2002:aca:f008:: with SMTP id o8mr21309979oih.106.1620208857795;
 Wed, 05 May 2021 03:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <337B72A8-C81A-4C53-A4D6-FFFD7FA66CEC@oracle.com>
 <161428671215.677100.6372209948022011988.stgit@warthog.procyon.org.uk>
 <161428674320.677100.12637282414018170743.stgit@warthog.procyon.org.uk>
 <4b275a33-28ac-78c2-e075-ea2eda4f13a8@canonical.com> <92182F5F-327E-4F1D-A7D9-42355625C84C@oracle.com>
 <b10f51dc-b9d7-e84d-3a52-438ebd358a7d@canonical.com> <2579343.1615623232@warthog.procyon.org.uk>
 <12AAB359-A315-490E-8B94-FF947997B30E@oracle.com>
In-Reply-To: <12AAB359-A315-490E-8B94-FF947997B30E@oracle.com>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Wed, 5 May 2021 11:00:21 +0100
Message-ID: <CADWks+Z0xqDcJG_+VKKJYw2m1aG9DZ3pD9yoLCSSA5CUjJgsSA@mail.gmail.com>
Subject: Re: [PATCH 4/4] integrity: Load mokx variables into the blacklist keyring
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Mar 13, 2021 at 2:40 PM Eric Snowberg <eric.snowberg@oracle.com> wrote:
>
>
> > On Mar 13, 2021, at 1:13 AM, David Howells <dhowells@redhat.com> wrote:
> >
> > Eric Snowberg <eric.snowberg@oracle.com> wrote:
> >
> >> If MOKx will be available thru a config table in the next shim,
> >> I'll prepare a follow on patch to add this support.
> >
> > Can this go separately, or would it be better rolled into the existing
> > patchset?
>
> IMHO, since you have already sent a pull request and this is not available
> yet in shim, it seems save to have it go separately.  I should have time
> to send something out next week to address this change.
>

I don't think that was correct to call it "not available yet in shim".
Shim has always exported all the variables, it's just at the time most
shims from most distros did not have any contents in MokX. And as
usual with all EFI variables, empty ones do not exist.

The shim from Ubuntu which is now public contains 1 cert & 378 on
x86_64 and 1 cert & 170 hashes. Thus it is likely to fail to be read
by kernel correctly unless it uses efi_mokvar_entry_find(). These
patches are tagged with CVE number which it does not address
completely in some configurations. Are you working on a patch to add
efi_mokvar_entry_find() or do you want me to write it / test it /
submit it for review?


-- 
Regards,

Dimitri.
