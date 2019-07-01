Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE1647B8A
	for <lists+linux-security-module@lfdr.de>; Mon, 17 Jun 2019 09:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbfFQHpF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 17 Jun 2019 03:45:05 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:48538 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFQHpF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Jun 2019 03:45:05 -0400
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id Rjkv2000S3XaVaC06jkvPh; Mon, 17 Jun 2019 09:45:03 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcmJy-0000To-Bl; Mon, 17 Jun 2019 09:44:54 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcmJy-0003Ms-AA; Mon, 17 Jun 2019 09:44:54 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Nayna Jain <nayna@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] integrity: Fix __integrity_init_keyring() section mismatch
Date:   Mon, 17 Jun 2019 09:44:52 +0200
Message-Id: <20190617074452.12901-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

With gcc-4.6.3:

    WARNING: vmlinux.o(.text.unlikely+0x24c64): Section mismatch in reference from the function __integrity_init_keyring() to the function .init.text:set_platform_trusted_keys()
    The function __integrity_init_keyring() references
    the function __init set_platform_trusted_keys().
    This is often because __integrity_init_keyring lacks a __init
    annotation or the annotation of set_platform_trusted_keys is wrong.

Indeed, if the compiler decides not to inline __integrity_init_keyring(),
a warning is issued.

Fix this by adding the missing __init annotation.

Fixes: 9dc92c45177ab70e ("integrity: Define a trusted platform keyring")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 security/integrity/digsig.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 4582bc26770a34a7..868ade3e89702ba7 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -69,8 +69,9 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 	return -EOPNOTSUPP;
 }
 
-static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
-				    struct key_restriction *restriction)
+static int __init __integrity_init_keyring(const unsigned int id,
+					   key_perm_t perm,
+					   struct key_restriction *restriction)
 {
 	const struct cred *cred = current_cred();
 	int err = 0;
-- 
2.17.1

