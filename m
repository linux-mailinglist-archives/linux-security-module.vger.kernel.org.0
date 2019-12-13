Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE84B11E18B
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Dec 2019 11:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfLMKES (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 13 Dec 2019 05:04:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54999 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfLMKES (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Dec 2019 05:04:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so1462586wmj.4
        for <linux-security-module@vger.kernel.org>; Fri, 13 Dec 2019 02:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXK6UjT3yvQXehTLYa6S1u2sa5BlRdomwa2/Hcjjkmc=;
        b=Sqme3mDOu29bXcnx3JAe8SM+kNYOjY0c1eOn0jeZhyWGeYUz5rGyQns0Ag7pq/6y+4
         kyNlzPph787dZHJXZEiOAQhGqvDODOeUvfLalFGgPiFOIIbTOdaXxqCO4YXJM6O/J8A5
         7y+ODXuNB/C6mQD7u8B9P5qd4jMdTwZO/82wv52hSD1gubm9gWP71J3kBDqhi6pnnpca
         +eMsnw4qmTsvG5PLIGt4gyyUyu8eeJJt0qvL6jGUQfBofpLosscXuEDnqCzV3F3SUx26
         ANV1PwSCvLnuSYw3unH3vKxAF87HodZ174wMuHlQoyrwyn7WrIeh517gJIyDMCnxww0g
         DLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXK6UjT3yvQXehTLYa6S1u2sa5BlRdomwa2/Hcjjkmc=;
        b=VfWa5J0AiLJrjXEl4vk6h4ucMpA4TFc8trIPkHWlm9AWfSDWRkTGiuDFmpPhz1IqX8
         JTXjeOyytzcVPXYg1bEyxwGDMHEWWZxKzuomDXjqU3/uJv/XXGsRGHo7cEWlR7zOixUB
         MB5aNdOxRS0YTZqtOIESINrs7R4HpzR5x4w4B5iTRZpRCPgEd++g4eyIWlSum/sueW8Q
         ZyqaXuoxNTbrJguO+NdBTBqQFWEBBXv3uobLAc+vzpHrgHoINwDgVnQnXkBpgflmQEzN
         PAvZec2QG4fzN526eU4cTWs0Un1MF36WgZ4SvE21qAkmItX2PaviXU5PIXifybdwjTMT
         ca2Q==
X-Gm-Message-State: APjAAAXQVpFu6G5cCp3BIuWuj9DKtgbCDYd7yBjcKK5hROKLuUWtnsG/
        4+Tsg+ij8oy2tHJjbn/8XFDgsv+sWSg8YhmjraX20eqoeIcvVTNu
X-Google-Smtp-Source: APXvYqzrrrCcFiuqdvaZaLnkNV6SCoP4uctJu8CpEBW12Wz60eMvE/ICbTcq/LDfsqhURwKKOS2I+ILGE90133ebxOI=
X-Received: by 2002:a1c:a795:: with SMTP id q143mr11772299wme.52.1576231456007;
 Fri, 13 Dec 2019 02:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20191213090646.12329-1-jlee@suse.com> <20191213090646.12329-3-jlee@suse.com>
 <CAKv+Gu_2GTqKJNVpMEg4ic_3ACb5GJKAkgfFWoEdWqMN7pmwiA@mail.gmail.com> <20191213092049.GW22409@linux-l9pv.suse>
In-Reply-To: <20191213092049.GW22409@linux-l9pv.suse>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Dec 2019 10:04:14 +0000
Message-ID: <CAKv+Gu8-Ay2R9wU-wwz2w+Q9jZOduXYigmFJL8Rmppnm1CSpHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: show error messages only when loading
 certificates is failed
To:     Joey Lee <JLee@suse.com>
Cc:     Chun-Yi Lee <joeyli.kernel@gmail.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 13 Dec 2019 at 10:21, Joey Lee <JLee@suse.com> wrote:
>
> Hi Ard,
>
> On Fri, Dec 13, 2019 at 09:10:12AM +0000, Ard Biesheuvel wrote:
> > On Fri, 13 Dec 2019 at 10:07, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > >
> > > When loading certificates list from EFI variables, the error
> > > message and efi status code always be emitted to dmesg. It looks
> > > ugly:
> > >
> > > [    2.335031] Couldn't get size: 0x800000000000000e
> > > [    2.335032] Couldn't get UEFI MokListRT
> > > [    2.339985] Couldn't get size: 0x800000000000000e
> > > [    2.339987] Couldn't get UEFI dbx list
> > >
> > > This cosmetic patch moved the messages to the error handling code
> > > path. And, it also shows the corresponding status string of status
> > > code.
> > >
> >
> > So what output do we get after applying this patch when those
> > variables don't exist?
> >
>
> A "UEFI:xxxx list was not found" message will be exposed in dmesg
> when kernel loglevel be set to debug. Otherwise there have no messages.
>

OK, that works for me.

I take it this will go via the linux-security tree along with 1/2?

Acked-by: Ard Biesheuvel <ardb@kernel.org>



> > > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > > ---
> > >  security/integrity/platform_certs/load_uefi.c | 40 ++++++++++++++-------------
> > >  1 file changed, 21 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> > > index 81b19c52832b..b6c60fb3fb6c 100644
> > > --- a/security/integrity/platform_certs/load_uefi.c
> > > +++ b/security/integrity/platform_certs/load_uefi.c
> > > @@ -1,4 +1,5 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > >
> > >  #include <linux/kernel.h>
> > >  #include <linux/sched.h>
> > > @@ -39,7 +40,7 @@ static __init bool uefi_check_ignore_db(void)
> > >   * Get a certificate list blob from the named EFI variable.
> > >   */
> > >  static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
> > > -                                 unsigned long *size)
> > > +                                 unsigned long *size, const char *source)
> > >  {
> > >         efi_status_t status;
> > >         unsigned long lsize = 4;
> > > @@ -48,23 +49,30 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
> > >
> > >         status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
> > >         if (status != EFI_BUFFER_TOO_SMALL) {
> > > -               pr_err("Couldn't get size: 0x%lx\n", status);
> > > -               return NULL;
> > > +               if (status == EFI_NOT_FOUND) {
> > > +                       pr_debug("%s list was not found\n", source);
> > > +                       return NULL;
> > > +               }
> > > +               goto err;
> > >         }
> > >
> > >         db = kmalloc(lsize, GFP_KERNEL);
> > > -       if (!db)
> > > -               return NULL;
> > > +       if (!db) {
> > > +               status = EFI_OUT_OF_RESOURCES;
> > > +               goto err;
> > > +       }
> > >
> > >         status = efi.get_variable(name, guid, NULL, &lsize, db);
> > >         if (status != EFI_SUCCESS) {
> > >                 kfree(db);
> > > -               pr_err("Error reading db var: 0x%lx\n", status);
> > > -               return NULL;
> > > +               goto err;
> > >         }
> > >
> > >         *size = lsize;
> > >         return db;
> > > +err:
> > > +       pr_err("Couldn't get %s list: %s\n", source, efi_status_to_str(status));
> > > +       return NULL;
> > >  }
> > >
> > >  /*
> > > @@ -153,10 +161,8 @@ static int __init load_uefi_certs(void)
> > >          * an error if we can't get them.
> > >          */
> > >         if (!uefi_check_ignore_db()) {
> > > -               db = get_cert_list(L"db", &secure_var, &dbsize);
> > > -               if (!db) {
> > > -                       pr_err("MODSIGN: Couldn't get UEFI db list\n");
> > > -               } else {
> > > +               db = get_cert_list(L"db", &secure_var, &dbsize, "UEFI:db");
> > > +               if (db) {
> > >                         rc = parse_efi_signature_list("UEFI:db",
> > >                                         db, dbsize, get_handler_for_db);
> > >                         if (rc)
> > > @@ -166,10 +172,8 @@ static int __init load_uefi_certs(void)
> > >                 }
> > >         }
> > >
> > > -       mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
> > > -       if (!mok) {
> > > -               pr_info("Couldn't get UEFI MokListRT\n");
> > > -       } else {
> > > +       mok = get_cert_list(L"MokListRT", &mok_var, &moksize, "UEFI:MokListRT");
> > > +       if (mok) {
> > >                 rc = parse_efi_signature_list("UEFI:MokListRT",
> > >                                               mok, moksize, get_handler_for_db);
> > >                 if (rc)
> > > @@ -177,10 +181,8 @@ static int __init load_uefi_certs(void)
> > >                 kfree(mok);
> > >         }
> > >
> > > -       dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
> > > -       if (!dbx) {
> > > -               pr_info("Couldn't get UEFI dbx list\n");
> > > -       } else {
> > > +       dbx = get_cert_list(L"dbx", &secure_var, &dbxsize, "UEFI:dbx");
> > > +       if (dbx) {
> > >                 rc = parse_efi_signature_list("UEFI:dbx",
> > >                                               dbx, dbxsize,
> > >                                               get_handler_for_dbx);
> > > --
> > > 2.16.4
> > >
