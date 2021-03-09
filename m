Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8C73326A7
	for <lists+linux-security-module@lfdr.de>; Tue,  9 Mar 2021 14:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCINV2 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 9 Mar 2021 08:21:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231354AbhCINVP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Mar 2021 08:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615296074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lijj9yQxXzlna1BJrD/I5Jd4FTt3CjaWcl0YVZNv5YA=;
        b=Ul6L3K0eUYZ/JlU9N2CBlhpu5TAGB0HeIZW6RJZIZIZT+JwskJp6xs7EVuDigBtadfpHEJ
        F01p34/E0I47e2namEzJ5NpnzaRaAI7iqpiEiwNR2F8W/ccaJWcscnSkGow2wHEBk+6np8
        x0Le6YHl4xPH/5GrNPOF+QJH0NQreV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-sMVSQPeEMbO7hu4At9YlwQ-1; Tue, 09 Mar 2021 08:21:10 -0500
X-MC-Unique: sMVSQPeEMbO7hu4At9YlwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06D81801817;
        Tue,  9 Mar 2021 13:21:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58CE95D6D7;
        Tue,  9 Mar 2021 13:21:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 3/4] certs: Add ability to preload revocation certs
From:   David Howells <dhowells@redhat.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, keyrings@vger.kernel.org,
        dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
        =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 09 Mar 2021 13:21:06 +0000
Message-ID: <161529606657.163428.3340689182456495390.stgit@warthog.procyon.org.uk>
In-Reply-To: <161529604216.163428.4905283330048991183.stgit@warthog.procyon.org.uk>
References: <161529604216.163428.4905283330048991183.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Eric Snowberg <eric.snowberg@oracle.com>

Add a new Kconfig option called SYSTEM_REVOCATION_KEYS. If set,
this option should be the filename of a PEM-formated file containing
X.509 certificates to be included in the default blacklist keyring.

DH Changes:
 - Make the new Kconfig option depend on SYSTEM_REVOCATION_LIST.
 - Fix SYSTEM_REVOCATION_KEYS=n, but CONFIG_SYSTEM_REVOCATION_LIST=y[1][2].
 - Use CONFIG_SYSTEM_REVOCATION_LIST for extract-cert[3].
 - Use CONFIG_SYSTEM_REVOCATION_LIST for revocation_certificates.o[3].

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Randy Dunlap <rdunlap@infradead.org>
cc: keyrings@vger.kernel.org
Link: https://lore.kernel.org/r/20200930201508.35113-3-eric.snowberg@oracle.com/
Link: https://lore.kernel.org/r/20210122181054.32635-4-eric.snowberg@oracle.com/ # v5
Link: https://lore.kernel.org/r/161428673564.677100.4112098280028451629.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/161433312452.902181.4146169951896577982.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/e1c15c74-82ce-3a69-44de-a33af9b320ea@infradead.org/ [1]
Link: https://lore.kernel.org/r/20210303034418.106762-1-eric.snowberg@oracle.com/ [2]
Link: https://lore.kernel.org/keyrings/20210304175030.184131-1-eric.snowberg@oracle.com/ [3]
---

 certs/Kconfig                   |    8 ++++++++
 certs/Makefile                  |   19 +++++++++++++++++--
 certs/blacklist.c               |   21 +++++++++++++++++++++
 certs/revocation_certificates.S |   21 +++++++++++++++++++++
 scripts/Makefile                |    1 +
 5 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100644 certs/revocation_certificates.S

diff --git a/certs/Kconfig b/certs/Kconfig
index 76e469b56a77..ab88d2a7f3c7 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -92,4 +92,12 @@ config SYSTEM_REVOCATION_LIST
 	  blacklist keyring and implements a hook whereby a PKCS#7 message can
 	  be checked to see if it matches such a certificate.
 
+config SYSTEM_REVOCATION_KEYS
+	string "X.509 certificates to be preloaded into the system blacklist keyring"
+	depends on SYSTEM_REVOCATION_LIST
+	help
+	  If set, this option should be the filename of a PEM-formatted file
+	  containing X.509 certificates to be included in the default blacklist
+	  keyring.
+
 endmenu
diff --git a/certs/Makefile b/certs/Makefile
index f4b90bad8690..b6db52ebf0be 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -4,7 +4,8 @@
 #
 
 obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o common.o
-obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o
+obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
+obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
 ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),"")
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
 else
@@ -29,7 +30,7 @@ $(obj)/x509_certificate_list: scripts/extract-cert $(SYSTEM_TRUSTED_KEYS_SRCPREF
 	$(call if_changed,extract_certs,$(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_TRUSTED_KEYS))
 endif # CONFIG_SYSTEM_TRUSTED_KEYRING
 
-clean-files := x509_certificate_list .x509.list
+clean-files := x509_certificate_list .x509.list x509_revocation_list
 
 ifeq ($(CONFIG_MODULE_SIG),y)
 ###############################################################################
@@ -104,3 +105,17 @@ targets += signing_key.x509
 $(obj)/signing_key.x509: scripts/extract-cert $(X509_DEP) FORCE
 	$(call if_changed,extract_certs,$(MODULE_SIG_KEY_SRCPREFIX)$(CONFIG_MODULE_SIG_KEY))
 endif # CONFIG_MODULE_SIG
+
+ifeq ($(CONFIG_SYSTEM_REVOCATION_LIST),y)
+
+$(eval $(call config_filename,SYSTEM_REVOCATION_KEYS))
+
+$(obj)/revocation_certificates.o: $(obj)/x509_revocation_list
+
+quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
+      cmd_extract_certs  = scripts/extract-cert $(2) $@
+
+targets += x509_revocation_list
+$(obj)/x509_revocation_list: scripts/extract-cert $(SYSTEM_REVOCATION_KEYS_SRCPREFIX)$(SYSTEM_REVOCATION_KEYS_FILENAME) FORCE
+	$(call if_changed,extract_certs,$(SYSTEM_REVOCATION_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_REVOCATION_KEYS))
+endif
diff --git a/certs/blacklist.c b/certs/blacklist.c
index 2b8644123d5f..c9a435b15af4 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -17,9 +17,15 @@
 #include <linux/uidgid.h>
 #include <keys/system_keyring.h>
 #include "blacklist.h"
+#include "common.h"
 
 static struct key *blacklist_keyring;
 
+#ifdef CONFIG_SYSTEM_REVOCATION_LIST
+extern __initconst const u8 revocation_certificate_list[];
+extern __initconst const unsigned long revocation_certificate_list_size;
+#endif
+
 /*
  * The description must be a type prefix, a colon and then an even number of
  * hex digits.  The hash is kept in the description.
@@ -220,3 +226,18 @@ static int __init blacklist_init(void)
  * Must be initialised before we try and load the keys into the keyring.
  */
 device_initcall(blacklist_init);
+
+#ifdef CONFIG_SYSTEM_REVOCATION_LIST
+/*
+ * Load the compiled-in list of revocation X.509 certificates.
+ */
+static __init int load_revocation_certificate_list(void)
+{
+	if (revocation_certificate_list_size)
+		pr_notice("Loading compiled-in revocation X.509 certificates\n");
+
+	return load_certificate_list(revocation_certificate_list, revocation_certificate_list_size,
+				     blacklist_keyring);
+}
+late_initcall(load_revocation_certificate_list);
+#endif
diff --git a/certs/revocation_certificates.S b/certs/revocation_certificates.S
new file mode 100644
index 000000000000..f21aae8a8f0e
--- /dev/null
+++ b/certs/revocation_certificates.S
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/export.h>
+#include <linux/init.h>
+
+	__INITRODATA
+
+	.align 8
+	.globl revocation_certificate_list
+revocation_certificate_list:
+__revocation_list_start:
+	.incbin "certs/x509_revocation_list"
+__revocation_list_end:
+
+	.align 8
+	.globl revocation_certificate_list_size
+revocation_certificate_list_size:
+#ifdef CONFIG_64BIT
+	.quad __revocation_list_end - __revocation_list_start
+#else
+	.long __revocation_list_end - __revocation_list_start
+#endif
diff --git a/scripts/Makefile b/scripts/Makefile
index b5418ec587fb..bd0718f7c493 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -11,6 +11,7 @@ hostprogs-always-$(CONFIG_ASN1)				+= asn1_compiler
 hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
 hostprogs-always-$(CONFIG_SYSTEM_TRUSTED_KEYRING)	+= extract-cert
 hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
+hostprogs-always-$(CONFIG_SYSTEM_REVOCATION_LIST)	+= extract-cert
 
 HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include


