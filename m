Return-Path: <linux-security-module+bounces-12451-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF61BE4EAE
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Oct 2025 19:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA641A63E50
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Oct 2025 17:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705811EDA2B;
	Thu, 16 Oct 2025 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oJvdGaVf"
X-Original-To: linux-security-module@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1E3346B6;
	Thu, 16 Oct 2025 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637048; cv=none; b=qVHkiQs5OygiWREPaYBLVsid1qX959/Km8IZqhdqY7m8K9IK+tbp0VH4rlw5ar5cgpH+nDxAZ6l8xU1px/tje3BBd4/BsAsn7eFP4hwd3alI105RuNY1ygIyD5WIOrEeGW1Z0hWIMiWzwGxmty+H9UQ/rd6Fo5GnE3naeCOQBzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637048; c=relaxed/simple;
	bh=8EhcO8P++WCMtd9d5jKiU6/xyxDWH2jKha/FUfKmz0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djRUKYKGj3qONJtnGJV4GcU553NLIgnViL9ny0odr83YENbwlydxbhdG3Eg8sOvBXcCrz2QdVsXltLqfqB3LZhms21usr3Aj5gJd8rfISEmHc5hu+p2Ur8vmN3zDOP3weuOEtS7rkNAGxeP7GIX3ZiXXWXgoj/oouZaw6a87tfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oJvdGaVf; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760637043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tPptTdvt0P/Pr1HimNZSP+ELp6j7Af0CWu9+zWYFYX0=;
	b=oJvdGaVf1P7nt3yBU9MUXAsTFUduzn+mJaTJ/f/M19lnNzEc9jzlfFgU+RNoHRYsbEOiEi
	KxPVsrAntVNCsFKqE2cPqlFkg3pUtPrX4XgxUV1N2xu/07dM3qelY43Y6ezWA0SpPCyIya
	CPTFUDHXDWRq8dOi9Eh5T2FrsMHluCY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Replace deprecated strcpy in d_namespace_path
Date: Thu, 16 Oct 2025 19:49:15 +0200
Message-ID: <20251016174914.80831-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; replace it with a direct '/' assignment. The
buffer is already NUL-terminated, so there is no need to copy an
additional NUL terminator as strcpy() did.

Update the comment and add the local variable 'is_root' for clarity.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/path.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/apparmor/path.c b/security/apparmor/path.c
index d6c74c357ffd..65a0ca5cc1bd 100644
--- a/security/apparmor/path.c
+++ b/security/apparmor/path.c
@@ -164,12 +164,15 @@ static int d_namespace_path(const struct path *path, char *buf, char **name,
 	}
 
 out:
-	/*
-	 * Append "/" to the pathname.  The root directory is a special
-	 * case; it already ends in slash.
+	/* Append "/" to directory paths, except for root "/" which
+	 * already ends in a slash.
 	 */
-	if (!error && isdir && ((*name)[1] != '\0' || (*name)[0] != '/'))
-		strcpy(&buf[aa_g_path_max - 2], "/");
+	if (!error && isdir) {
+		bool is_root = (*name)[0] == '/' && (*name)[1] == '\0';
+
+		if (!is_root)
+			buf[aa_g_path_max - 2] = '/';
+	}
 
 	return error;
 }
-- 
2.51.0


