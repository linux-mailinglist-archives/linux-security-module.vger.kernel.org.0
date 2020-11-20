Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8502BB20B
	for <lists+linux-security-module@lfdr.de>; Fri, 20 Nov 2020 19:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgKTSE5 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 20 Nov 2020 13:04:57 -0500
Received: from smtp-8fa9.mail.infomaniak.ch ([83.166.143.169]:37341 "EHLO
        smtp-8fa9.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729380AbgKTSEk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Nov 2020 13:04:40 -0500
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Cd4FM1thyzlhCpj;
        Fri, 20 Nov 2020 19:04:39 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Cd4FL73dLzlh8T2;
        Fri, 20 Nov 2020 19:04:38 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v1 5/9] PKCS#7: Fix missing include
Date:   Fri, 20 Nov 2020 19:04:22 +0100
Message-Id: <20201120180426.922572-6-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120180426.922572-1-mic@digikod.net>
References: <20201120180426.922572-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mickaël Salaün <mic@linux.microsoft.com>

Add missing stddef.h for size_t.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
---
 include/linux/verification.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/verification.h b/include/linux/verification.h
index 911ab7c2b1ab..b4a74568c0f0 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -8,6 +8,8 @@
 #ifndef _LINUX_VERIFICATION_H
 #define _LINUX_VERIFICATION_H
 
+#include <stddef.h>
+
 /*
  * Indicate that both builtin trusted keys and secondary trusted keys
  * should be used.
-- 
2.29.2

