Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D8A3E23C5
	for <lists+linux-security-module@lfdr.de>; Fri,  6 Aug 2021 09:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243543AbhHFHL7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 6 Aug 2021 03:11:59 -0400
Received: from mail.astralinux.ru ([217.74.38.119]:49304 "EHLO
        mail.astralinux.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243544AbhHFHL6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Aug 2021 03:11:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 74A442F62F88;
        Fri,  6 Aug 2021 10:03:19 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uAUCqItlukqu; Fri,  6 Aug 2021 10:03:18 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 13DC32F62F86;
        Fri,  6 Aug 2021 10:03:18 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pud7jXa3hKpQ; Fri,  6 Aug 2021 10:03:17 +0300 (MSK)
Received: from mastykin.cct.rbt (unknown [192.168.32.67])
        by mail.astralinux.ru (Postfix) with ESMTPSA id E5A332F62F80;
        Fri,  6 Aug 2021 10:03:17 +0300 (MSK)
From:   Dmitry Mastykin <dmastykin@astralinux.ru>
To:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc:     dmastykin@astralinux.ru, akovalenko@astralinux.ru
Subject: [PATCH 2/3] security/security: get rid of a duplicated condition
Date:   Fri,  6 Aug 2021 10:02:44 +0300
Message-Id: <20210806070245.26338-3-dmastykin@astralinux.ru>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210806070245.26338-1-dmastykin@astralinux.ru>
References: <20210806070245.26338-1-dmastykin@astralinux.ru>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Just remove a typo: the same if() was duplicated.

Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>
---
 security/security.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/security.c b/security/security.c
index fd14064e9106..1ab6f56a93b6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2930,8 +2930,6 @@ int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			continue;
 		if (lsmrule[hp->lsmid->slot] == NULL)
 			continue;
-		if (lsmrule[hp->lsmid->slot] == NULL)
-			continue;
 		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
 					       field, op,
 					       lsmrule[hp->lsmid->slot]);
-- 
2.11.0

