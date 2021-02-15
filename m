Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB6B31C141
	for <lists+linux-security-module@lfdr.de>; Mon, 15 Feb 2021 19:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBOSPM (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 15 Feb 2021 13:15:12 -0500
Received: from smtp-8fa8.mail.infomaniak.ch ([83.166.143.168]:52587 "EHLO
        smtp-8fa8.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230019AbhBOSPL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Feb 2021 13:15:11 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DfXLS6QcrzMprlZ;
        Mon, 15 Feb 2021 19:14:24 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DfXLS42Jfzlh8TC;
        Mon, 15 Feb 2021 19:14:24 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v2 1/3] kconfig: Remove duplicate call to sym_get_string_value()
Date:   Mon, 15 Feb 2021 19:15:09 +0100
Message-Id: <20210215181511.2840674-2-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215181511.2840674-1-mic@digikod.net>
References: <20210215181511.2840674-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mickaël Salaün <mic@linux.microsoft.com>

Use the saved returned value of sym_get_string_value() instead of
calling it twice.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20210215181511.2840674-2-mic@digikod.net
---
 scripts/kconfig/conf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index db03e2f45de4..18a233d27a8d 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -137,7 +137,7 @@ static int conf_string(struct menu *menu)
 		printf("%*s%s ", indent - 1, "", menu->prompt->text);
 		printf("(%s) ", sym->name);
 		def = sym_get_string_value(sym);
-		if (sym_get_string_value(sym))
+		if (def)
 			printf("[%s] ", def);
 		if (!conf_askvalue(sym, def))
 			return 0;
-- 
2.30.0

