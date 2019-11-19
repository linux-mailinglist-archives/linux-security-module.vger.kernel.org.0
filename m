Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 886AF101FFE
	for <lists+linux-security-module@lfdr.de>; Tue, 19 Nov 2019 10:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbfKSJSo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 19 Nov 2019 04:18:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26150 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727250AbfKSJSo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Nov 2019 04:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574155123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F5gVroGd0jCB/6b+aqlr6VxWgFq7818TIln7vtMs1d8=;
        b=iiFBuwOKR8bevPklnBkgV2g0M0C87ZxACeuqBJu2/exEPqM2OQ+J4qgTUWiJKOdcF1di64
        RexxBwgHCIv4DIYOn5eQGIgkCFFzMivCP8T6nIYqI4a0/xMSyZ8SwZT0jHxZi1CAYq2MAt
        2r56+ejkGH8sAguB549GKtkgxQGcPw8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-1CxssZghPUir_CnQRtshvg-1; Tue, 19 Nov 2019 04:18:39 -0500
Received: by mail-wr1-f71.google.com with SMTP id b4so17898421wrn.8
        for <linux-security-module@vger.kernel.org>; Tue, 19 Nov 2019 01:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I0ochwV95DWb+Vb/kQFhi7I2FhfRb9PfG9M5Z+gcjYQ=;
        b=MXh4/gCOC/EEXzIoOGLVOuKr5I/tHDU4B/WwvQbcs4auvz/CbpO6a9ypa61/KnYgPI
         EfajZPpX54RyrRvrb5NBmxk2cINplyRkf6UV8p5BtigZI8YK5sD+3pdDw37ZeEaHhMge
         sYQljvVOXtw1kDe4KaWsKjkLWxuUjCOBUf9PXQnuJ6nW05EGTGTMdcpuJiSpQKAc2u8n
         Nb0pZsbN4n6T/kyjpPSYwOCz2LlIIgGO5DeQmd4LtwfZzGV6NGohAR9L2dqDrb+JITVK
         pfDyqo3mYitg/sPJ57HwtxYFt59atKaNOfwuC2n6pRmle6ysfkHgkExjBFI1SLGhBKMx
         bjZQ==
X-Gm-Message-State: APjAAAXOaJlXUSQM7CR/88GB5WMXSPdTG2pxt7NlzyGRbwEP7Pr9l+/S
        xq1ckSAO0Ntcm/iJ61tENgZS6D/ZQ5AszjVaaS8j+Lx8cKfIoA5SOVYW2QVXIykHJsu5tdu7SjT
        6xjpMexnpr80oY3mdDFt1dBlAz4x/CEbLtWeB
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr4388612wmc.143.1574155118631;
        Tue, 19 Nov 2019 01:18:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/3ENyoIZuytZnCqKEgxHHFsE1tK9q5FPF1B1/0eBPoNkV5H1Fk3MNUOM61TMOl+cJiT5QLg==
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr4388590wmc.143.1574155118380;
        Tue, 19 Nov 2019 01:18:38 -0800 (PST)
Received: from minerva.redhat.com ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id f140sm2427588wme.21.2019.11.19.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 01:18:37 -0800 (PST)
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
Subject: [PATCH] efi: Only print errors about failing to get certs if EFI vars are found
Date:   Tue, 19 Nov 2019 10:18:21 +0100
Message-Id: <20191119091822.276265-1-javierm@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: 1CxssZghPUir_CnQRtshvg-1
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

 security/integrity/platform_certs/load_uefi.c | 31 ++++++++++---------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integ=
rity/platform_certs/load_uefi.c
index 81b19c52832..336fa528359 100644
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
@@ -153,8 +156,8 @@ static int __init load_uefi_certs(void)
 =09 * an error if we can't get them.
 =09 */
 =09if (!uefi_check_ignore_db()) {
-=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize);
-=09=09if (!db) {
+=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize, &status);
+=09=09if (!db && status !=3D EFI_NOT_FOUND) {
 =09=09=09pr_err("MODSIGN: Couldn't get UEFI db list\n");
 =09=09} else {
 =09=09=09rc =3D parse_efi_signature_list("UEFI:db",
@@ -166,8 +169,8 @@ static int __init load_uefi_certs(void)
 =09=09}
 =09}
=20
-=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize);
-=09if (!mok) {
+=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
+=09if (!mok && status !=3D EFI_NOT_FOUND) {
 =09=09pr_info("Couldn't get UEFI MokListRT\n");
 =09} else {
 =09=09rc =3D parse_efi_signature_list("UEFI:MokListRT",
@@ -177,8 +180,8 @@ static int __init load_uefi_certs(void)
 =09=09kfree(mok);
 =09}
=20
-=09dbx =3D get_cert_list(L"dbx", &secure_var, &dbxsize);
-=09if (!dbx) {
+=09dbx =3D get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
+=09if (!dbx && status !=3D EFI_NOT_FOUND) {
 =09=09pr_info("Couldn't get UEFI dbx list\n");
 =09} else {
 =09=09rc =3D parse_efi_signature_list("UEFI:dbx",
--=20
2.23.0

