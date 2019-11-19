Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDABB10239B
	for <lists+linux-security-module@lfdr.de>; Tue, 19 Nov 2019 12:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfKSLuy (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 19 Nov 2019 06:50:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49339 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725798AbfKSLuy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Nov 2019 06:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574164253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cPDx/uSvia+AQrxrnk91IgNIxhLAnZO1Su6r+uKdtAA=;
        b=Xyu5eQX3kFBkqlsNcG4jr22IE1GH9UGb2NDZssWJqgI/MHbm0nbx6oMe5u6iIU/+uG0YTP
        1Vgs2VhbRcapvT+A6R/Hy7JXm7MmBC1dCLSVF+tpAGRaXagUOtjXivN4362+EAux8BKvzW
        oA534PdevgEVw8sJUnpzicjT09hsOFw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-pFkKmwWCNfaj4_9NpdbUwA-1; Tue, 19 Nov 2019 06:50:52 -0500
Received: by mail-wr1-f72.google.com with SMTP id u2so18136985wrm.7
        for <linux-security-module@vger.kernel.org>; Tue, 19 Nov 2019 03:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5ig2axvrBBg2yqUEfYVOSTsjkK15L7GgIG4wHTcsyY=;
        b=KYnztmUYDJAIudEduTAAjkkt1/6jl1ujSNWcHR6Q3tjaBKQGSU0NSFECvJJ0i7pCOy
         nNRrWellLY5eD380/HxDwy0MqEQ3KoXfeaKUjaRRXkSYwfwCccFaRZo39AodOC1R6b0q
         +Nkg1ywVzWS9cEphbg99QejmicbThKyKWxSovGP/u5wukb5EGFSAyy+xtWHay6xZbTRH
         ctC6u/JHIjav7fUqhReB+kKQxuyWLcEt3LV1bUzrTuiWOfhV3gh24cM0WS/R/2StlbEr
         SDZ69+UIIEnjti0m5fela3jmsO+nLrSagSbKfq+2MJh8zVrybbxs4Ga31lpJgkFtKufU
         hx4Q==
X-Gm-Message-State: APjAAAUUzhsPmDtCkt/WYoIKYoa2DWp+UeU/IzFPRuWvCk+ReSG7hXd+
        upAJeoVtOuk7gCd+ya//ylfseJH8Os/Fkn/hkskstXaqLN/XhnvDWJOiI1LiPIXjFFug8r0MOro
        bpbiEhTMLSqRnhCoidzY52VsIfYYKrNYKE2qs
X-Received: by 2002:adf:f147:: with SMTP id y7mr29236881wro.236.1574164250927;
        Tue, 19 Nov 2019 03:50:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzfkFrPwr5GBaC8zTsKB6a8VVCsDMt5ztYjz3WxhjO18rrmQI/1tvJ0GngHBzW+BeULOmYiQg==
X-Received: by 2002:adf:f147:: with SMTP id y7mr29236855wro.236.1574164250675;
        Tue, 19 Nov 2019 03:50:50 -0800 (PST)
Received: from minerva.home ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id a206sm2909726wmf.15.2019.11.19.03.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 03:50:50 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2] efi: Only print errors about failing to get certs if EFI vars are found
Date:   Tue, 19 Nov 2019 12:50:43 +0100
Message-Id: <20191119115043.21585-1-javierm@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: pFkKmwWCNfaj4_9NpdbUwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

If CONFIG_LOAD_UEFI_KEYS is enabled, the kernel attempts to load the certs
from the db, dbx and MokListRT EFI variables into the appropriate keyrings.

But it just assumes that the variables will be present and prints an error
if the certs can't be loaded, even when is possible that the variables may
not exist. For example the MokListRT variable will only be present if shim
is used.

So only print an error message about failing to get the certs list from an
EFI variable if this is found. Otherwise these printed errors just pollute
the kernel ring buffer with confusing messages like the following:

[    5.427251] Couldn't get size: 0x800000000000000e
[    5.427261] MODSIGN: Couldn't get UEFI db list
[    5.428012] Couldn't get size: 0x800000000000000e
[    5.428023] Couldn't get UEFI MokListRT

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---
Hans,

I'll really appreciate if you can test this patch. I just built tested it
because I don't have access to a machine to reproduce the issue right now.

Best regards,
Javier

Changes in v2:
- Fix flaws in the logic, that caused the signature list was parsed if
  the return code was EFI_NOT_FOUND that pointed out Hans de Goede.
- Print debug messages if the variables are not found.

 security/integrity/platform_certs/load_uefi.c | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integ=
rity/platform_certs/load_uefi.c
index 81b19c52832..020fc7a11ef 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -39,16 +39,18 @@ static __init bool uefi_check_ignore_db(void)
  * Get a certificate list blob from the named EFI variable.
  */
 static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
-=09=09=09=09  unsigned long *size)
+=09=09=09=09  unsigned long *size, efi_status_t *status)
 {
-=09efi_status_t status;
 =09unsigned long lsize =3D 4;
 =09unsigned long tmpdb[4];
 =09void *db;
=20
-=09status =3D efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
-=09if (status !=3D EFI_BUFFER_TOO_SMALL) {
-=09=09pr_err("Couldn't get size: 0x%lx\n", status);
+=09*status =3D efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
+=09if (*status =3D=3D EFI_NOT_FOUND)
+=09=09return NULL;
+
+=09if (*status !=3D EFI_BUFFER_TOO_SMALL) {
+=09=09pr_err("Couldn't get size: 0x%lx\n", *status);
 =09=09return NULL;
 =09}
=20
@@ -56,10 +58,10 @@ static __init void *get_cert_list(efi_char16_t *name, e=
fi_guid_t *guid,
 =09if (!db)
 =09=09return NULL;
=20
-=09status =3D efi.get_variable(name, guid, NULL, &lsize, db);
-=09if (status !=3D EFI_SUCCESS) {
+=09*status =3D efi.get_variable(name, guid, NULL, &lsize, db);
+=09if (*status !=3D EFI_SUCCESS) {
 =09=09kfree(db);
-=09=09pr_err("Error reading db var: 0x%lx\n", status);
+=09=09pr_err("Error reading db var: 0x%lx\n", *status);
 =09=09return NULL;
 =09}
=20
@@ -144,6 +146,7 @@ static int __init load_uefi_certs(void)
 =09efi_guid_t mok_var =3D EFI_SHIM_LOCK_GUID;
 =09void *db =3D NULL, *dbx =3D NULL, *mok =3D NULL;
 =09unsigned long dbsize =3D 0, dbxsize =3D 0, moksize =3D 0;
+=09efi_status_t status;
 =09int rc =3D 0;
=20
 =09if (!efi.get_variable)
@@ -153,9 +156,12 @@ static int __init load_uefi_certs(void)
 =09 * an error if we can't get them.
 =09 */
 =09if (!uefi_check_ignore_db()) {
-=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize);
+=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize, &status);
 =09=09if (!db) {
-=09=09=09pr_err("MODSIGN: Couldn't get UEFI db list\n");
+=09=09=09if (status =3D=3D EFI_NOT_FOUND)
+=09=09=09=09pr_debug("MODSIGN: db variable wasn't found\n");
+=09=09=09else
+=09=09=09=09pr_err("MODSIGN: Couldn't get UEFI db list\n");
 =09=09} else {
 =09=09=09rc =3D parse_efi_signature_list("UEFI:db",
 =09=09=09=09=09db, dbsize, get_handler_for_db);
@@ -166,9 +172,12 @@ static int __init load_uefi_certs(void)
 =09=09}
 =09}
=20
-=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize);
+=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
 =09if (!mok) {
-=09=09pr_info("Couldn't get UEFI MokListRT\n");
+=09=09if (status =3D=3D EFI_NOT_FOUND)
+=09=09=09pr_debug("MokListRT variable wasn't found\n");
+=09=09else
+=09=09=09pr_info("Couldn't get UEFI MokListRT\n");
 =09} else {
 =09=09rc =3D parse_efi_signature_list("UEFI:MokListRT",
 =09=09=09=09=09      mok, moksize, get_handler_for_db);
@@ -177,9 +186,12 @@ static int __init load_uefi_certs(void)
 =09=09kfree(mok);
 =09}
=20
-=09dbx =3D get_cert_list(L"dbx", &secure_var, &dbxsize);
+=09dbx =3D get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
 =09if (!dbx) {
-=09=09pr_info("Couldn't get UEFI dbx list\n");
+=09=09if (status =3D=3D EFI_NOT_FOUND)
+=09=09=09pr_debug("dbx variable wasn't found\n");
+=09=09else
+=09=09=09pr_info("Couldn't get UEFI dbx list\n");
 =09} else {
 =09=09rc =3D parse_efi_signature_list("UEFI:dbx",
 =09=09=09=09=09      dbx, dbxsize,
--=20
2.23.0

