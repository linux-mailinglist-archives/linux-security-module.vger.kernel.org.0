Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20AC481720
	for <lists+linux-security-module@lfdr.de>; Wed, 29 Dec 2021 22:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhL2VyG (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 29 Dec 2021 16:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhL2VyF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Dec 2021 16:54:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59280C06173E
        for <linux-security-module@vger.kernel.org>; Wed, 29 Dec 2021 13:54:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u130-20020a254788000000b0060a9645f781so28446919yba.19
        for <linux-security-module@vger.kernel.org>; Wed, 29 Dec 2021 13:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=sWjORqABOdOtCeJq4LhyQJ9mB4LVqlD/Y4aoFLyP20c=;
        b=E4G4E/ZYBEC7Hau2pCewdeMnYUhT4PDZoqdLtC7UA+3Yv7qVvoHHNszhGpdOVRz75I
         fdC/vCXCTJyBQcYKn6lgpVeEhx2/HGMwKof1r/iycf+pVrBXpRPSvFJ4Fa+lnBw4ZfLN
         A4NY5g3HoRmF8jWpuaR0QVcwdeF1mF8VCjQqgqDZe+PZH8NC7Tb5ZPEdzEJSAv6U9t0m
         Tw5JWtda0Hjv2od0KZQ9LUPGmhQQfxo7na78ELvLRXdu29/eSzysM0cDKWbbMtTGzNJK
         0985xsWwG5NZvNHXNg9hM67GI6ZfgmhULcT4JuQhucEVRL6tMEivruZXGegf9rqxAEfv
         5Rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=sWjORqABOdOtCeJq4LhyQJ9mB4LVqlD/Y4aoFLyP20c=;
        b=Fmp6M6oIlLuRVDGJGWi6orX8ZV0dE0KEtsE1lF3eo7blHKQoLt27xm6qkQZt1V4zlq
         zpMBOjckn5ugKW+3n1aV1uAesEDW+5m+kyKtQrR1QMQousr/OoDXvI3wAfEpiS8ml041
         TrGJwGJc+iDaOHLGcStqucjCRRgGZCJ1rsWa2Mut5haqq2ONOzRHBwDn42ZCqVYbZh+n
         KfT0GtdrorZV2XfqMmA4m3T09QnHXcIoMEiA58WWAFyOeSe0VAnz39rxIbWcBMgOtYmN
         INNAyIFy5U7K/wofEYbpIhO4WXe/uFuB/Zpyq/ympFqrDfbx9irRmD0gFUHJTVoBYEXa
         m/Ig==
X-Gm-Message-State: AOAM530cH9skWQJHYZvTxqLmCkU1BCwEnvGrMvWcq6HH25Nms52uaDyW
        H3Wp4FBUT1TnAxGijDHAIEK6bkNyGw==
X-Google-Smtp-Source: ABdhPJzcw0GCm56DEx+tsE86Jr7lIzH9bwMfnb7zB8Pv11yK1M4TASLlfJ5NiuG1ubcTR0BwNFtltNuZMQ==
X-Received: from yaelt.nyc.corp.google.com ([2620:0:1003:415:20d1:e249:eb05:ae62])
 (user=yaelt job=sendgmr) by 2002:a25:aa8e:: with SMTP id t14mr21363549ybi.363.1640814844152;
 Wed, 29 Dec 2021 13:54:04 -0800 (PST)
Date:   Wed, 29 Dec 2021 16:53:30 -0500
Message-Id: <20211229215330.4134835-1-yaelt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
From:   Yael Tiomkin <yaelt@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        corbet@lwn.net, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Yael Tiomkin <yaelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The encrypted.c class supports instantiation of encrypted keys with
either an already-encrypted key material, or by generating new key
material based on random numbers. This patch defines a new datablob
format: [<format>] <master-key name> <decrypted data length>
<decrypted data> that allows to instantiate encrypted keys using
user-provided decrypted data, and therefore allows to perform key
encryption from userspace. The decrypted key material will be
inaccessible from userspace.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Yael Tiomkin <yaelt@google.com>
---

Notes:
    v -> v2: fixed compilation error.
   =20
    v2 -> v3: modified documentation.
   =20
    v3 -> v4: modified commit message.

 .../security/keys/trusted-encrypted.rst       | 25 ++++++--
 security/keys/encrypted-keys/encrypted.c      | 62 +++++++++++++------
 2 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentat=
ion/security/keys/trusted-encrypted.rst
index 80d5a5af62a1..f614dad7de12 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -107,12 +107,13 @@ Encrypted Keys
 --------------
=20
 Encrypted keys do not depend on a trust source, and are faster, as they us=
e AES
-for encryption/decryption. New keys are created from kernel-generated rand=
om
-numbers, and are encrypted/decrypted using a specified =E2=80=98master=E2=
=80=99 key. The
-=E2=80=98master=E2=80=99 key can either be a trusted-key or user-key type.=
 The main disadvantage
-of encrypted keys is that if they are not rooted in a trusted key, they ar=
e only
-as secure as the user key encrypting them. The master user key should ther=
efore
-be loaded in as secure a way as possible, preferably early in boot.
+for encryption/decryption. New keys are created either from kernel-generat=
ed
+random numbers or user-provided decrypted data, and are encrypted/decrypte=
d
+using a specified =E2=80=98master=E2=80=99 key. The =E2=80=98master=E2=80=
=99 key can either be a trusted-key or
+user-key type. The main disadvantage of encrypted keys is that if they are=
 not
+rooted in a trusted key, they are only as secure as the user key encryptin=
g
+them. The master user key should therefore be loaded in as secure a way as
+possible, preferably early in boot.
=20
=20
 Usage
@@ -199,6 +200,8 @@ Usage::
=20
     keyctl add encrypted name "new [format] key-type:master-key-name keyle=
n"
         ring
+    keyctl add encrypted name "new [format] key-type:master-key-name keyle=
n
+        decrypted-data" ring
     keyctl add encrypted name "load hex_blob" ring
     keyctl update keyid "update key-type:master-key-name"
=20
@@ -303,6 +306,16 @@ Load an encrypted key "evm" from saved blob::
     82dbbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564=
e0
     24717c64 5972dcb82ab2dde83376d82b2e3c09ffc
=20
+Instantiate an encrypted key "evm" using user-provided decrypted data::
+
+    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm_decrypted=
_data.blob`" @u
+    794890253
+
+    $ keyctl print 794890253
+    default user:kmk 32 2375725ad57798846a9bbd240de8906f006e66c03af53b1b38=
2d
+    bbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e02=
47
+    17c64 5972dcb82ab2dde83376d82b2e3c09ffc
+
 Other uses for trusted and encrypted keys, such as for disk and file encry=
ption
 are anticipated.  In particular the new format 'ecryptfs' has been defined
 in order to use encrypted keys to mount an eCryptfs filesystem.  More deta=
ils
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encry=
pted-keys/encrypted.c
index 87432b35d771..baf6fba5e05e 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -159,6 +159,7 @@ static int valid_master_desc(const char *new_desc, cons=
t char *orig_desc)
  *
  * datablob format:
  * new [<format>] <master-key name> <decrypted data length>
+ * new [<format>] <master-key name> <decrypted data length> <decrypted dat=
a>
  * load [<format>] <master-key name> <decrypted data length>
  *     <encrypted iv + data>
  * update <new-master-key name>
@@ -170,7 +171,7 @@ static int valid_master_desc(const char *new_desc, cons=
t char *orig_desc)
  */
 static int datablob_parse(char *datablob, const char **format,
 			  char **master_desc, char **decrypted_datalen,
-			  char **hex_encoded_iv)
+			  char **hex_encoded_iv, char **decrypted_data)
 {
 	substring_t args[MAX_OPT_ARGS];
 	int ret =3D -EINVAL;
@@ -231,6 +232,8 @@ static int datablob_parse(char *datablob, const char **=
format,
 				"when called from .update method\n", keyword);
 			break;
 		}
+		*decrypted_data =3D strsep(&datablob, " \t");
+
 		ret =3D 0;
 		break;
 	case Opt_load:
@@ -595,7 +598,8 @@ static int derived_key_decrypt(struct encrypted_key_pay=
load *epayload,
 static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 							 const char *format,
 							 const char *master_desc,
-							 const char *datalen)
+							 const char *datalen,
+							 const char *decrypted_data)
 {
 	struct encrypted_key_payload *epayload =3D NULL;
 	unsigned short datablob_len;
@@ -604,6 +608,7 @@ static struct encrypted_key_payload *encrypted_key_allo=
c(struct key *key,
 	unsigned int encrypted_datalen;
 	unsigned int format_len;
 	long dlen;
+	int i;
 	int ret;
=20
 	ret =3D kstrtol(datalen, 10, &dlen);
@@ -613,6 +618,20 @@ static struct encrypted_key_payload *encrypted_key_all=
oc(struct key *key,
 	format_len =3D (!format) ? strlen(key_format_default) : strlen(format);
 	decrypted_datalen =3D dlen;
 	payload_datalen =3D decrypted_datalen;
+
+	if (decrypted_data) {
+		if (strlen(decrypted_data) !=3D decrypted_datalen) {
+			pr_err("encrypted key: decrypted data provided does not match decrypted=
 data length provided\n");
+			return ERR_PTR(-EINVAL);
+		}
+		for (i =3D 0; i < strlen(decrypted_data); i++) {
+			if (!isalnum(decrypted_data[i])) {
+				pr_err("encrypted key: decrypted data provided must be alphanumeric\n"=
);
+				return ERR_PTR(-EINVAL);
+			}
+		}
+	}
+
 	if (format) {
 		if (!strcmp(format, key_format_ecryptfs)) {
 			if (dlen !=3D ECRYPTFS_MAX_KEY_BYTES) {
@@ -740,13 +759,14 @@ static void __ekey_init(struct encrypted_key_payload =
*epayload,
 /*
  * encrypted_init - initialize an encrypted key
  *
- * For a new key, use a random number for both the iv and data
- * itself.  For an old key, decrypt the hex encoded data.
+ * For a new key, use either a random number or user-provided decrypted da=
ta in
+ * case it is provided. A random number is used for the iv in both cases. =
For
+ * an old key, decrypt the hex encoded data.
  */
 static int encrypted_init(struct encrypted_key_payload *epayload,
 			  const char *key_desc, const char *format,
 			  const char *master_desc, const char *datalen,
-			  const char *hex_encoded_iv)
+			  const char *hex_encoded_iv, const char *decrypted_data)
 {
 	int ret =3D 0;
=20
@@ -760,21 +780,26 @@ static int encrypted_init(struct encrypted_key_payloa=
d *epayload,
 	}
=20
 	__ekey_init(epayload, format, master_desc, datalen);
-	if (!hex_encoded_iv) {
-		get_random_bytes(epayload->iv, ivsize);
-
-		get_random_bytes(epayload->decrypted_data,
-				 epayload->decrypted_datalen);
-	} else
+	if (hex_encoded_iv) {
 		ret =3D encrypted_key_decrypt(epayload, format, hex_encoded_iv);
+	} else if (decrypted_data) {
+		get_random_bytes(epayload->iv, ivsize);
+		memcpy(epayload->decrypted_data, decrypted_data,
+				epayload->decrypted_datalen);
+	} else {
+		get_random_bytes(epayload->iv, ivsize);
+		get_random_bytes(epayload->decrypted_data, epayload->decrypted_datalen);
+	}
 	return ret;
 }
=20
 /*
  * encrypted_instantiate - instantiate an encrypted key
  *
- * Decrypt an existing encrypted datablob or create a new encrypted key
- * based on a kernel random number.
+ * Instantiates the key:
+ * - by decrypting an existing encrypted datablob, or
+ * - by creating a new encrypted key based on a kernel random number, or
+ * - using provided decrypted data.
  *
  * On success, return 0. Otherwise return errno.
  */
@@ -787,6 +812,7 @@ static int encrypted_instantiate(struct key *key,
 	char *master_desc =3D NULL;
 	char *decrypted_datalen =3D NULL;
 	char *hex_encoded_iv =3D NULL;
+	char *decrypted_data =3D NULL;
 	size_t datalen =3D prep->datalen;
 	int ret;
=20
@@ -799,18 +825,18 @@ static int encrypted_instantiate(struct key *key,
 	datablob[datalen] =3D 0;
 	memcpy(datablob, prep->data, datalen);
 	ret =3D datablob_parse(datablob, &format, &master_desc,
-			     &decrypted_datalen, &hex_encoded_iv);
+			     &decrypted_datalen, &hex_encoded_iv, &decrypted_data);
 	if (ret < 0)
 		goto out;
=20
 	epayload =3D encrypted_key_alloc(key, format, master_desc,
-				       decrypted_datalen);
+				       decrypted_datalen, decrypted_data);
 	if (IS_ERR(epayload)) {
 		ret =3D PTR_ERR(epayload);
 		goto out;
 	}
 	ret =3D encrypted_init(epayload, key->description, format, master_desc,
-			     decrypted_datalen, hex_encoded_iv);
+			     decrypted_datalen, hex_encoded_iv, decrypted_data);
 	if (ret < 0) {
 		kfree_sensitive(epayload);
 		goto out;
@@ -860,7 +886,7 @@ static int encrypted_update(struct key *key, struct key=
_preparsed_payload *prep)
=20
 	buf[datalen] =3D 0;
 	memcpy(buf, prep->data, datalen);
-	ret =3D datablob_parse(buf, &format, &new_master_desc, NULL, NULL);
+	ret =3D datablob_parse(buf, &format, &new_master_desc, NULL, NULL, NULL);
 	if (ret < 0)
 		goto out;
=20
@@ -869,7 +895,7 @@ static int encrypted_update(struct key *key, struct key=
_preparsed_payload *prep)
 		goto out;
=20
 	new_epayload =3D encrypted_key_alloc(key, epayload->format,
-					   new_master_desc, epayload->datalen);
+					   new_master_desc, epayload->datalen, NULL);
 	if (IS_ERR(new_epayload)) {
 		ret =3D PTR_ERR(new_epayload);
 		goto out;
--=20
2.34.1.448.ga2b2bfdf31-goog

