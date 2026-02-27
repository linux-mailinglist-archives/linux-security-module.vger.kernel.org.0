Return-Path: <linux-security-module+bounces-15039-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKSQGxIsomk/0gQAu9opvQ
	(envelope-from <linux-security-module+bounces-15039-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Sat, 28 Feb 2026 00:43:14 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F251BF1A5
	for <lists+linux-security-module@lfdr.de>; Sat, 28 Feb 2026 00:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C4083122163
	for <lists+linux-security-module@lfdr.de>; Fri, 27 Feb 2026 23:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14DF45BD78;
	Fri, 27 Feb 2026 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QJBfTcF0"
X-Original-To: linux-security-module@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF85244BCA9;
	Fri, 27 Feb 2026 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235605; cv=none; b=ChMj4hJCIqoRuTetKvQVsDumoSa/rC1U4opLr98rOjgkEOeXSGAvLOkeV4GG9h2lgMooZD7KznzVetqPdDeONROSsVWOEigvF0vzmFIAGtqGEFC53M7IpivjsTcFIH1X/gBo3xgJhYuMXIjADy2YlptR+uK/7wlaZ01P1Kjzbdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235605; c=relaxed/simple;
	bh=VtAO1aHUhC9GAwsrw7oglChv2WQS/B5QX4FczTnXMHg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t82GD/qVMU9W7q1JDE0pF/pMsim2GqcSN0MVx62CFAWiUTu55UoeGU4Yq8iiNghD4Y4U68qeJfjcfbGn7x/GzUE/MXGNnc6MNsUcJjs/xKDPQ+U/0aTOzKbzGoyf+wW9d4ddqn95alFv67wVTQ2rX0YM0HuMTS4YJuxhMBo3tN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QJBfTcF0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id EF1AC20B6F03;
	Fri, 27 Feb 2026 15:40:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF1AC20B6F03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772235602;
	bh=RBqj14ByqU03ua4MJUgxwy9+3AHd3KDJxeUsz+GRKaE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QJBfTcF0octRPXIelj/NvbPllJ6T5DXkXY3DfdZ+M06E6yWiZmHvaM13N9xm+ITLr
	 5X9EjdLZmadIDmZasTiGesxO4JrlrJxhexU85lqSRdFSmKSq31ZSd0Insdu6Jn1IHc
	 /+x90Gpx528iazKvUBXI/khZaZK5W6019zzEAUlo=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	Fan Wu <wufan@kernel.org>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 09/10] hornet: Add a light skeleton data extractor scripts
Date: Fri, 27 Feb 2026 15:38:38 -0800
Message-ID: <20260227233930.2418522-10-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
References: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[linux.microsoft.com,lwn.net,paul-moore.com,namei.org,hallyn.com,digikod.net,google.com,treblig.org,linux-foundation.org,HansenPartnership.com,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-15039-lists,linux-security-module=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bboscaccy@linux.microsoft.com,linux-security-module@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9F251BF1A5
X-Rspamd-Action: no action

These script eases light skeleton development against Hornet by
generating a data payloads which can be used for signing a light
skeleton binary using gen_sig.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 scripts/hornet/extract-insn.sh | 27 +++++++++++++++++++++++++++
 scripts/hornet/extract-map.sh  | 27 +++++++++++++++++++++++++++
 scripts/hornet/extract-skel.sh | 27 +++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100755 scripts/hornet/extract-insn.sh
 create mode 100755 scripts/hornet/extract-map.sh
 create mode 100755 scripts/hornet/extract-skel.sh

diff --git a/scripts/hornet/extract-insn.sh b/scripts/hornet/extract-insn.sh
new file mode 100755
index 000000000000..52338f057ff6
--- /dev/null
+++ b/scripts/hornet/extract-insn.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Microsoft Corporation
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+
+function usage() {
+    echo "Sample script for extracting instructions"
+    echo "autogenerated eBPF lskel headers"
+    echo ""
+    echo "USAGE: header_file"
+    exit
+}
+
+ARGC=$#
+
+EXPECTED_ARGS=1
+
+if [ $ARGC -ne $EXPECTED_ARGS ] ; then
+    usage
+else
+    printf $(gcc -E $1 | grep "opts_insn" | \
+		 awk -F"=" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g')
+fi
diff --git a/scripts/hornet/extract-map.sh b/scripts/hornet/extract-map.sh
new file mode 100755
index 000000000000..c309f505c623
--- /dev/null
+++ b/scripts/hornet/extract-map.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Microsoft Corporation
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+
+function usage() {
+    echo "Sample script for extracting instructions"
+    echo "autogenerated eBPF lskel headers"
+    echo ""
+    echo "USAGE: header_file"
+    exit
+}
+
+ARGC=$#
+
+EXPECTED_ARGS=1
+
+if [ $ARGC -ne $EXPECTED_ARGS ] ; then
+    usage
+else
+    printf $(gcc -E $1 | grep "opts_data" | \
+		 awk -F"=" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g')
+fi
diff --git a/scripts/hornet/extract-skel.sh b/scripts/hornet/extract-skel.sh
new file mode 100755
index 000000000000..6550a86b8991
--- /dev/null
+++ b/scripts/hornet/extract-skel.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Microsoft Corporation
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+
+function usage() {
+    echo "Sample script for extracting instructions and map data out of"
+    echo "autogenerated eBPF lskel headers"
+    echo ""
+    echo "USAGE: header_file field"
+    exit
+}
+
+ARGC=$#
+
+EXPECTED_ARGS=2
+
+if [ $ARGC -ne $EXPECTED_ARGS ] ; then
+    usage
+else
+    printf $(gcc -E $1 | grep "static const char opts_$2" | \
+		 awk -F"=" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g')
+fi
-- 
2.52.0


