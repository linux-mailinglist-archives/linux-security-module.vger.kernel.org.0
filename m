Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1894215FA0
	for <lists+linux-security-module@lfdr.de>; Tue,  7 May 2019 10:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEGInz (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 7 May 2019 04:43:55 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:58776 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfEGIny (ORCPT
        <rfc822;groupwise-linux-security-module@vger.kernel.org:0:0>);
        Tue, 7 May 2019 04:43:54 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 07 May 2019 10:43:37 +0200
Received: from linux-l9pv.suse (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 07 May 2019 09:43:19 +0100
Date:   Tue, 7 May 2019 16:43:09 +0800
From:   joeyli <jlee@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 v3] efi: print appropriate status message when
 loading certificates
Message-ID: <20190507084309.GA18931@linux-l9pv.suse>
References: <20190502040441.30372-1-jlee@suse.com>
 <20190502040441.30372-2-jlee@suse.com>
 <CAKv+Gu8MESd3BXCKR=EH7Z1kWegm9XjTP38jBsizpgDAuyA3YQ@mail.gmail.com>
 <20190503071819.GN11486@linux-l9pv.suse>
 <CAKv+Gu9CdWYMELxBz9WqaB4BSRbRx81iR-x4P+2OANAcfLUhUQ@mail.gmail.com>
 <20190503085834.GQ11486@linux-l9pv.suse>
 <CAKv+Gu-AuoObBW5Ha_cXtYQOdeYYpTRBu=6RqH7+DYvwACKR1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-AuoObBW5Ha_cXtYQOdeYYpTRBu=6RqH7+DYvwACKR1A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 03, 2019 at 04:23:51PM +0200, Ard Biesheuvel wrote:
> On Fri, 3 May 2019 at 10:59, joeyli <jlee@suse.com> wrote:
> >
> > On Fri, May 03, 2019 at 10:07:59AM +0200, Ard Biesheuvel wrote:
> > > On Fri, 3 May 2019 at 09:18, joeyli <jlee@suse.com> wrote:
> > > >
> > > > Hi Ard,
> > > >
> > > > On Thu, May 02, 2019 at 11:04:34AM +0200, Ard Biesheuvel wrote:
> > > > > On Thu, 2 May 2019 at 06:04, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > > > > >
> > > > > > When loading certificates list from UEFI variable, the original error
> > > > > > message direct shows the efi status code from UEFI firmware. It looks
> > > > > > ugly:
> > > > > >
> > > > > > [    2.335031] Couldn't get size: 0x800000000000000e
> > > > > > [    2.335032] Couldn't get UEFI MokListRT
> > > > > > [    2.339985] Couldn't get size: 0x800000000000000e
> > > > > > [    2.339987] Couldn't get UEFI dbx list
> > > > > >
> > > > > > So, this patch shows the status string instead of status code.
> > > > > >
> > > > > > On the other hand, the "Couldn't get UEFI" message doesn't need
> > > > > > to be exposed when db/dbx/mok variable do not exist. So, this
> > > > > > patch set the message level to debug.
> > > > > >
> > > > > > v3.
> > > > > > - Print messages similar to db/mok when loading dbx hash to blacklist:
> > > > > > [    1.500952] EFI: Blacklisting hash of an executable: UEFI:dbx
> > > > > > [    1.501773] blacklist: Loaded blacklisting hash
> > > > > > 'bin:80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d411f92659f0a'
> > > > > >
> > > > > > - Setting messages for the existence of db/mok/dbx lists to debug level.
> > > > > >
> > > > > > v2.
> > > > > > Setting the MODSIGN messages level to debug.
> > > > > >
> > > > > > Link:
> > > > > > https://forums.opensuse.org/showthread.php/535324-MODSIGN-Couldn-t-get-UEFI-db-list?p=2897516#post2897516
> > > > > > Cc: James Morris <jmorris@namei.org>
> > > > > > Cc: Serge E. Hallyn" <serge@hallyn.com>
> > > > > > Cc: David Howells <dhowells@redhat.com>
> > > > > > Cc: Nayna Jain <nayna@linux.ibm.com>
> > > > > > Cc: Josh Boyer <jwboyer@fedoraproject.org>
> > > > > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > > > > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > > > > > ---
> > > > > >  certs/blacklist.c                             |  3 +-
> > > > > >  security/integrity/platform_certs/load_uefi.c | 40 +++++++++++++++++++--------
> > > > > >  2 files changed, 31 insertions(+), 12 deletions(-)
> > > > > >
> > > > > > diff --git a/certs/blacklist.c b/certs/blacklist.c
> > > > > > index 3a507b9e2568..f91437e39e44 100644
> > > > > > --- a/certs/blacklist.c
> > > > > > +++ b/certs/blacklist.c
> > > > > > @@ -100,7 +100,8 @@ int mark_hash_blacklisted(const char *hash)
> > > > > >         if (IS_ERR(key)) {
> > > > > >                 pr_err("Problem blacklisting hash (%ld)\n", PTR_ERR(key));
> > > > > >                 return PTR_ERR(key);
> > > > > > -       }
> > > > > > +       } else
> > > > > > +               pr_notice("Loaded blacklisting hash '%s'\n", hash);
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> > > > > > index 81b19c52832b..6b6996e5bc27 100644
> > > > > > --- a/security/integrity/platform_certs/load_uefi.c
> > > > > > +++ b/security/integrity/platform_certs/load_uefi.c
> > > > > > @@ -1,5 +1,7 @@
> > > > > >  // SPDX-License-Identifier: GPL-2.0
> > > > > >
> > > > > > +#define pr_fmt(fmt) "EFI: "fmt
> > > > > > +
> > > > > >  #include <linux/kernel.h>
> > > > > >  #include <linux/sched.h>
> > > > > >  #include <linux/cred.h>
> > > > > > @@ -35,6 +37,18 @@ static __init bool uefi_check_ignore_db(void)
> > > > > >         return status == EFI_SUCCESS;
> > > > > >  }
> > > > > >
> > > > > > +static void str16_to_str(efi_char16_t *str16, char *str, int str_size)
> > > > > > +{
> > > > > > +       int i = 0;
> > > > > > +
> > > > > > +       while (str16[i] != '\0' && i < (str_size - 1)) {
> > > > > > +               str[i] = str16[i];
> > > > > > +               i++;
> > > > > > +       }
> > > > > > +
> > > > > > +       str[i] = '\0';
> > > > > > +}
> > > > > > +
> > > > > >  /*
> > > > > >   * Get a certificate list blob from the named EFI variable.
> > > > > >   */
> > > > > > @@ -44,13 +58,20 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
> > > > > >         efi_status_t status;
> > > > > >         unsigned long lsize = 4;
> > > > > >         unsigned long tmpdb[4];
> > > > > > +       char namestr[16];
> > > > > >         void *db;
> > > > > >
> > > > > > +       str16_to_str(name, namestr, ARRAY_SIZE(namestr));
> > > > >
> > > > > Please drop this (and the function above) - instead, just return NULL
> > > > > if the variable is not found (without reporting an error).
> > > > >
> > > >
> > > > This name string is for printing debug level message, not error message.
> > > > This function already returns NULL when EFI_NOT_FOUND be returned by
> > > > firmware.
> > > >
> > > > > >         status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
> > > > > >         if (status != EFI_BUFFER_TOO_SMALL) {
> > > > > > -               pr_err("Couldn't get size: 0x%lx\n", status);
> > > > > > +               if (status == EFI_NOT_FOUND)
> > > > > > +                       pr_debug("UEFI %s list doesn't exist\n", namestr);
> > > > > > +               else
> > > > > > +                       pr_err("Couldn't get size for UEFI %s list: %s\n",
> > > > > > +                               namestr, efi_status_to_str(status));
> > > > > >                 return NULL;
> > > >
> > > > here returns NULL when EFI_NOT_FOUND. The message of existence is for
> > > > debugging.
> > > >
> > >
> > > I understand that. But I don't think we need it.
> > >
> >
> > OK. I will remove the debug message.
> >
> > > > > >         }
> > > > > > +       pr_debug("UEFI %s list exists\n", namestr);
> > > > > >
> > > > > >         db = kmalloc(lsize, GFP_KERNEL);
> > > > > >         if (!db)
> > > > > > @@ -59,7 +80,8 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
> > > > > >         status = efi.get_variable(name, guid, NULL, &lsize, db);
> > > > > >         if (status != EFI_SUCCESS) {
> > > > > >                 kfree(db);
> > > > > > -               pr_err("Error reading db var: 0x%lx\n", status);
> > > > > > +               pr_err("Error reading UEFI %s list: %s\n",
> > > > > > +                       namestr, efi_status_to_str(status));
> > > > > >                 return NULL;
> > > > > >         }
> > > > > >
> > > > > > @@ -95,6 +117,7 @@ static __init void uefi_blacklist_hash(const char *source, const void *data,
> > > > > >  static __init void uefi_blacklist_x509_tbs(const char *source,
> > > > > >                                            const void *data, size_t len)
> > > > > >  {
> > > > > > +       pr_info("Blacklisting X.509 TBS hash: %s\n", source);
> > > > > >         uefi_blacklist_hash(source, data, len, "tbs:", 4);
> > > > > >  }
> > > > > >
> > > > > > @@ -104,6 +127,7 @@ static __init void uefi_blacklist_x509_tbs(const char *source,
> > > > > >  static __init void uefi_blacklist_binary(const char *source,
> > > > > >                                          const void *data, size_t len)
> > > > > >  {
> > > > > > +       pr_info("Blacklisting hash of an executable: %s\n", source);
> > > > > >         uefi_blacklist_hash(source, data, len, "bin:", 4);
> > > > > >  }
> > > > > >
> > > > >
> > > > > These are separate changes - I don't have an opinion whether they are
> > > > > appropriate or not, but they should be in a separate patch.
> > > > >
> > > >
> > > > I will move the message of blacklising hash to other patch. Thanks!
> > > >
> > > > > > @@ -154,9 +178,7 @@ static int __init load_uefi_certs(void)
> > > > > >          */
> > > > > >         if (!uefi_check_ignore_db()) {
> > > > > >                 db = get_cert_list(L"db", &secure_var, &dbsize);
> > > > > > -               if (!db) {
> > > > > > -                       pr_err("MODSIGN: Couldn't get UEFI db list\n");
> > > > > > -               } else {
> > > > > > +               if (db) {
> > > > > >                         rc = parse_efi_signature_list("UEFI:db",
> > > > > >                                         db, dbsize, get_handler_for_db);
> > > > > >                         if (rc)
> > > > > > @@ -167,9 +189,7 @@ static int __init load_uefi_certs(void)
> > > > > >         }
> > > > > >
> > > > > >         mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
> > > > > > -       if (!mok) {
> > > > > > -               pr_info("Couldn't get UEFI MokListRT\n");
> > > > > > -       } else {
> > > > > > +       if (mok) {
> > > > > >                 rc = parse_efi_signature_list("UEFI:MokListRT",
> > > > > >                                               mok, moksize, get_handler_for_db);
> > > > > >                 if (rc)
> > > > > > @@ -178,9 +198,7 @@ static int __init load_uefi_certs(void)
> > > > > >         }
> > > > > >
> > > > > >         dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
> > > > > > -       if (!dbx) {
> > > > > > -               pr_info("Couldn't get UEFI dbx list\n");
> > > > > > -       } else {
> > > > > > +       if (dbx) {
> > > > > >                 rc = parse_efi_signature_list("UEFI:dbx",
> > > > > >                                               dbx, dbxsize,
> > > > > >                                               get_handler_for_dbx);
> > > > > > --
> > > > > > 2.16.4
> > > > > >
> > > > >
> > > > > I think we should consider carefully what it means if some of these
> > > > > variables don't exist:
> > > > > - if secure boot is enabled, db and dbx must exist, so if they don't,
> > > > > something is wrong
> > > >
> > > > The existence of db/dbx is not related to secure boot. If manufacturer/user
> > > > enrolled certificate/hash to db or dbx, then the variable will be created.
> > > > If user didn't enroll anything to db/dbx, then variables will not show up.
> > > >
> > >
> > > Yes, but if secure boot is enabled and db is empty, how could you have
> > > booted in the first place?
> > >
> >
> > I agree. When secure boot enabled, kernel can not be booted without db.
> >
> > > And what about the converse case: if secure boot is not enabled, why
> > > should we trust the contents of db?
> > >
> >
> > The db and dbx are authenticated variables that it protected by KEK.
> > So it can be trusted even secure boot is disabled. Unless manufacturer
> > or user's KEK is leaked.
> >
> 
> Is that true for non-secureboot capable firmware? Of course, in that
> case, we cannot be sure that the kernel itself is trusted, but we
> shouldn't open up another hole either.
>

I agree with you that we should filer-out non-secureboot firmware. I
think that we can check the existence of SecureBoot variable before loading
db/dbx. On the other hand, the SetupMode should also be checked because
db/dbx can be changed in setup mode. 

> > > > > - secure boot might be enabled but we may be booting without shim.
> > > >
> > > > Shim always creates MokListRT no matter secure boot enabled or disabled.
> > > >
> > >
> > > That is not my point. What happens if you booted with secure boot
> > > enabled but without the help of shim?
> > >
> >
> > Without shim, the signed EFI stub can still be booted by EFI boot manager.
> > But the MokListRT will not be created for runtime. So MOK signed kernel
> > module can not be verified. (or IMA can not verify MOK signed kernel image
> > for kexec...)
> >
> 
> So if we opt out of using shim, we lose kexec capability as well? That
> doesn't make any sense.
>

MOK is just one of options that it can be used to sign crash kernel image.
We can also use the key in db or the kernel embedded keys.
 
> In general, I am very uncomfortable with the way we have painted
> ourselves into a corner with shim. If I install Suse on a system that
> has the Suse cert in db or KEK, why would I need shim in the first
> place?
>

Yes! We don't need MOK if distro's certificates are preloaded in most
machines' db. Unfortunately it's not the case on most x86 machines.
 
> > > > > - secure boot might be disabled.
> > > > >
> > > >
> > > > It's not about secure boot, db/dbx/MokListRT are always available at
> > > > runtime if user was enrolled something to those list.
> > > >
> > >
> > > Yes, but again, depending on whether shim was involved, and/or whether
> > > secure boot was enabled or not, the way we interpret these things may
> > > be very different.
> > >
> > > I want the reasoning to be sound before merging any patches that deal
> > > with these variables.
> >
> > Here is a simple summary:
> >
> > When secure boot is enabled:
> >     - db/dbx: Can be trusted because they are authenticated variables.
> >               (unless end user doesn't want to trust db/dbx)
> >     - MokListRT:
> >         - with shim: MokListRT will be created. It can be trusted.
> >         - without shim: MokListRT will not be created.
> >                         MOK protected kernel module or file can not be
> >                         verified.
> >
> 
> So who polices that MoKlistRT is not created?
>

At boot time, shim copies MokList (boot variable) to MokListRT (runtime
variable). The MokListRT is a read-only runtime volatile variable. So,
without shim, the MokListRT will not be created for runtime. 
 
> > When secure boot is disabled:
> >     - db/dbx: Can be trusted because they are authenticated variables.
> >               (unless end user doesn't want to trust db/dbx)
> 
> Is this true? Does non-secure boot capable firmware still guarantee
> that db/dbx can't be created?
>

I agree. So we should check the existence of SecureBoot variable as I
mentioned above. 
 
> >     - MokListRT:
> >         - with shim: MokListRT will be created. But it can not be trusted.
> >                      MOK protected kernel module or file can not be
> >                      verified.
> >         - without shim: MokListRT will not be created.
> >                         MOK protected kernel module or file can not be
> >                         verified.
> >
> 
> Enabling this securely involves more than connecting the dots when it
> comes to db, MokListRT etc. I would like for someone to convince me as
> a maintainer, as well as the IMA maintainers, that the security
> requirements are still met in all cases we care about. Just copying db
> and MokListRT into a kernel keychain doesn't appear to do that, and if
> it does, it needs more documentation to clarify that.

Welcome for more input from other maintainers. But I hope that my cosmetic
can be accepted because current warning messages looks ugly. 

Thanks a lot!
Joey Lee
