Return-Path: <linux-security-module+bounces-14303-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMF9Hu/3e2nmJgIAu9opvQ
	(envelope-from <linux-security-module+bounces-14303-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Fri, 30 Jan 2026 01:14:39 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D4AB5D21
	for <lists+linux-security-module@lfdr.de>; Fri, 30 Jan 2026 01:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F69A3010D8F
	for <lists+linux-security-module@lfdr.de>; Fri, 30 Jan 2026 00:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02A513AD1C;
	Fri, 30 Jan 2026 00:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcwwchHB"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B65541C72;
	Fri, 30 Jan 2026 00:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769732076; cv=none; b=dPpjlVm//CSeO6jxo6OzcIoYSBfXWbpjpAoBLxZLf5FO3a64g1BTSFdz/yStzmwKYhKF0qBKRiGwg/BQjIxwHS4WlJ7UyA88tgJ+FiTpj2SKppCSpPYmHKSzVgL9fRUd0dxtJWvRn3IDLu94dARok2eS0eMu0171NZSYhJvOIz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769732076; c=relaxed/simple;
	bh=MFYc7QZX/EcS0/lin6rkPLcoR1gv1Dfino1TVsSDx6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t6Jtg0O8DCR9m35Lb7l8Is9SP1hYn0yhR2zEhSOhsM8bbRZGAw2XhJZ9aYeYAqisPUNghjnZg2KG6MlYu2YP2omA/OFKDPMfpwhqoQWRfDqczcc1jLsCrGaKpj/BKA8G2HrDFSCQPwVZIQEPrvxnj/5kXFPItPlOQ0MV4S5iOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcwwchHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13057C4CEF7;
	Fri, 30 Jan 2026 00:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769732076;
	bh=MFYc7QZX/EcS0/lin6rkPLcoR1gv1Dfino1TVsSDx6Q=;
	h=From:To:Cc:Subject:Date:From;
	b=fcwwchHBZZqZCBGAGAbybhVbkmwp8deGQKCX1ukcvzMNHuEEkE01L/NJhilGngsRR
	 oPOT7F8cvmv9SXqyw/+xq2kZKA6oLxKTLvRFP1Z+SHVNDed69QuHqsEVodXDzn4aZA
	 QognOKgpKGpTqneiKMgQXsQOtQgX4JdVmvbDSE7v76qBGrC2oczqTlMewHL6qBKa5F
	 qAQynNLdKK4kTns9gR/PuP9utDMpOx46LzSI5hDVjrolp9jUKeM7KLhkEzzRSsEW7Z
	 oD7P0aUpDiEUxSVFUp2yfpdNeO+D+BwEA8f2K4xYGlDXayhug2ZBjaTWND+ATaPwns
	 WYcWwLSkLr7NQ==
From: wufan@kernel.org
To: linux-security-module@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	mic@digikod.net,
	miklos@szeredi.hu,
	amir73il@gmail.com,
	linux-unionfs@vger.kernel.org,
	Fan Wu <wufan@kernel.org>
Subject: [PATCH] ipe: document AT_EXECVE_CHECK TOCTOU issue on OverlayFS
Date: Fri, 30 Jan 2026 00:14:18 +0000
Message-Id: <20260130001418.18414-1-wufan@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lwn.net,digikod.net,szeredi.hu,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-14303-lists,linux-security-module=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wufan@kernel.org,linux-security-module@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8D4AB5D21
X-Rspamd-Action: no action

From: Fan Wu <wufan@kernel.org>

Document a known TOCTOU (time-of-check to time-of-use) issue when using
AT_EXECVE_CHECK with read() on OverlayFS. The deny_write_access()
protection is only held during the syscall, allowing a copy-up operation
to be triggered afterward, causing subsequent read() calls to return
content from the unprotected upper layer.

This is generally not a concern for typical IPE deployments since
dm-verity and fs-verity protected files are effectively read-only.
However, OverlayFS with a writable upper layer presents a special case.

Document mitigation strategies including mounting overlay as read-only
and using mmap() instead of read(). Note that the mmap() mitigation
relies on current OverlayFS implementation details and should not be
considered a security guarantee.

Signed-off-by: Fan Wu <wufan@kernel.org>
---
 Documentation/admin-guide/LSM/ipe.rst | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index a756d8158531..b621a98fe5e2 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -110,6 +110,34 @@ intercepts during the execution process, this mechanism needs the interpreter
 to take the initiative, and existing interpreters won't be automatically
 supported unless the signal call is added.
 
+.. WARNING::
+
+   There is a known TOCTOU (time-of-check to time-of-use) issue with
+   ``AT_EXECVE_CHECK`` when interpreters use ``read()`` to obtain script
+   contents after the check [#atacexecvecheck_toctou]_. The ``AT_EXECVE_CHECK``
+   protection (via ``deny_write_access()``) is only held during the syscall.
+   After it returns, the file can be modified before the interpreter reads it.
+
+   In typical IPE deployments, this is not a concern because files protected
+   by dm-verity or fs-verity are effectively read-only and cannot be modified.
+   However, OverlayFS presents a special case: when the lower layer is
+   dm-verity protected (read-only) but the upper layer is writable, an
+   attacker with write access can trigger a copy-up operation after the
+   ``AT_EXECVE_CHECK`` returns, causing subsequent ``read()`` calls to return
+   content from the unprotected upper layer instead of the verified lower layer.
+
+   To mitigate this issue on OverlayFS:
+
+   -  Mount the overlay as read-only, or restrict write access to the upper
+      layer.
+   -  Interpreters may use ``mmap()`` instead of ``read()`` to obtain script
+      contents. Currently, OverlayFS fixes the underlying real file reference
+      at ``open()`` time for mmap operations, so mmap will continue to access
+      the original lower layer file even after a copy-up. However, this
+      behavior is an implementation detail of OverlayFS and is not guaranteed
+      to remain stable across kernel versions. Do not rely on this as a
+      security guarantee.
+
 Threat Model
 ------------
 
@@ -833,3 +861,7 @@ A:
                      kernel's fsverity support; IPE does not impose any
                      restrictions on the digest algorithm itself;
                      thus, this list may be out of date.
+
+.. [#atacexecvecheck_toctou] See the O_DENY_WRITE RFC discussion for details on
+                             this TOCTOU issue:
+                             https://lore.kernel.org/all/20250822170800.2116980-1-mic@digikod.net/
-- 
2.52.0


