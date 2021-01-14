Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252692F6466
	for <lists+linux-security-module@lfdr.de>; Thu, 14 Jan 2021 16:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbhANPVX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 14 Jan 2021 10:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbhANPVX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Jan 2021 10:21:23 -0500
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6DFC06179C
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jan 2021 07:19:18 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DGnz91BD1zMpv3g;
        Thu, 14 Jan 2021 16:19:17 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DGnz85r23zlppyg;
        Thu, 14 Jan 2021 16:19:16 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v3 10/10] tools/certs: Add print-cert-tbs-hash.sh
Date:   Thu, 14 Jan 2021 16:19:09 +0100
Message-Id: <20210114151909.2344974-11-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210114151909.2344974-1-mic@digikod.net>
References: <20210114151909.2344974-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mickaël Salaün <mic@linux.microsoft.com>

Add a new helper print-cert-tbs-hash.sh to generate a TBSCertificate
hash from a given certificate.  This is useful to generate a blacklist
key description used to forbid loading a specific certificate in a
keyring, or to invalidate a certificate provided by a PKCS#7 file.

Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
---

Changes since v1:
* Fix typo.
* Use "if" block instead of "||" .
---
 MAINTAINERS                        |  1 +
 tools/certs/print-cert-tbs-hash.sh | 91 ++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100755 tools/certs/print-cert-tbs-hash.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index bda31ccbfad0..c7bad1354531 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4123,6 +4123,7 @@ F:	certs/
 F:	scripts/check-blacklist-hashes.awk
 F:	scripts/extract-cert.c
 F:	scripts/sign-file.c
+F:	tools/certs/
 
 CFAG12864B LCD DRIVER
 M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
diff --git a/tools/certs/print-cert-tbs-hash.sh b/tools/certs/print-cert-tbs-hash.sh
new file mode 100755
index 000000000000..c93df5387ec9
--- /dev/null
+++ b/tools/certs/print-cert-tbs-hash.sh
@@ -0,0 +1,91 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright © 2020, Microsoft Corporation. All rights reserved.
+#
+# Author: Mickaël Salaün <mic@linux.microsoft.com>
+#
+# Compute and print the To Be Signed (TBS) hash of a certificate.  This is used
+# as description of keys in the blacklist keyring to identify certificates.
+# This output should be redirected, without newline, in a file (hash0.txt) and
+# signed to create a PKCS#7 file (hash0.p7s).  Both of these files can then be
+# loaded in the kernel with.
+#
+# Exemple on a workstation:
+# ./print-cert-tbs-hash.sh certificate-to-invalidate.pem > hash0.txt
+# openssl smime -sign -in hash0.txt -inkey builtin-private-key.pem \
+#               -signer builtin-certificate.pem -certfile certificate-chain.pem \
+#               -noattr -binary -outform DER -out hash0.p7s
+#
+# Exemple on a managed system:
+# keyctl padd blacklist "$(< hash0.txt)" %:.blacklist < hash0.p7s
+
+set -u -e -o pipefail
+
+CERT="${1:-}"
+BASENAME="$(basename -- "${BASH_SOURCE[0]}")"
+
+if [ $# -ne 1 ] || [ ! -f "${CERT}" ]; then
+	echo "usage: ${BASENAME} <certificate>" >&2
+	exit 1
+fi
+
+# Checks that it is indeed a certificate (PEM or DER encoded) and exclude the
+# optional PEM text header.
+if ! PEM="$(openssl x509 -inform DER -in "${CERT}" 2>/dev/null || openssl x509 -in "${CERT}")"; then
+	echo "ERROR: Failed to parse certificate" >&2
+	exit 1
+fi
+
+# TBSCertificate starts at the second entry.
+# Cf. https://tools.ietf.org/html/rfc3280#section-4.1
+#
+# Exemple of first lines printed by openssl asn1parse:
+#    0:d=0  hl=4 l= 763 cons: SEQUENCE
+#    4:d=1  hl=4 l= 483 cons: SEQUENCE
+#    8:d=2  hl=2 l=   3 cons: cont [ 0 ]
+#   10:d=3  hl=2 l=   1 prim: INTEGER           :02
+#   13:d=2  hl=2 l=  20 prim: INTEGER           :3CEB2CB8818D968AC00EEFE195F0DF9665328B7B
+#   35:d=2  hl=2 l=  13 cons: SEQUENCE
+#   37:d=3  hl=2 l=   9 prim: OBJECT            :sha256WithRSAEncryption
+RANGE_AND_DIGEST_RE='
+2s/^\s*\([0-9]\+\):d=\s*[0-9]\+\s\+hl=\s*[0-9]\+\s\+l=\s*\([0-9]\+\)\s\+cons:\s*SEQUENCE\s*$/\1 \2/p;
+7s/^\s*[0-9]\+:d=\s*[0-9]\+\s\+hl=\s*[0-9]\+\s\+l=\s*[0-9]\+\s\+prim:\s*OBJECT\s*:\(.*\)$/\1/p;
+'
+
+RANGE_AND_DIGEST=($(echo "${PEM}" | \
+	openssl asn1parse -in - | \
+	sed -n -e "${RANGE_AND_DIGEST_RE}"))
+
+if [ "${#RANGE_AND_DIGEST[@]}" != 3 ]; then
+	echo "ERROR: Failed to parse TBSCertificate." >&2
+	exit 1
+fi
+
+OFFSET="${RANGE_AND_DIGEST[0]}"
+END="$(( OFFSET + RANGE_AND_DIGEST[1] ))"
+DIGEST="${RANGE_AND_DIGEST[2]}"
+
+# The signature hash algorithm is used by Linux to blacklist certificates.
+# Cf. crypto/asymmetric_keys/x509_cert_parser.c:x509_note_pkey_algo()
+DIGEST_MATCH=""
+while read -r DIGEST_ITEM; do
+	if [ -z "${DIGEST_ITEM}" ]; then
+		break
+	fi
+	if echo "${DIGEST}" | grep -qiF "${DIGEST_ITEM}"; then
+		DIGEST_MATCH="${DIGEST_ITEM}"
+		break
+	fi
+done < <(openssl list -digest-commands | tr ' ' '\n' | sort -ur)
+
+if [ -z "${DIGEST_MATCH}" ]; then
+	echo "ERROR: Unknown digest algorithm: ${DIGEST}" >&2
+	exit 1
+fi
+
+echo "${PEM}" | \
+	openssl x509 -in - -outform DER | \
+	dd "bs=1" "skip=${OFFSET}" "count=${END}" "status=none" | \
+	openssl dgst "-${DIGEST_MATCH}" - | \
+	awk '{printf "tbs:" $2}'
-- 
2.30.0

