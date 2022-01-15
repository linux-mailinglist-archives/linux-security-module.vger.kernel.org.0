Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F9248F3FE
	for <lists+linux-security-module@lfdr.de>; Sat, 15 Jan 2022 02:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiAOBPF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 14 Jan 2022 20:15:05 -0500
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87]:43993 "EHLO
        out162-62-57-87.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbiAOBPE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 Jan 2022 20:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1642209301;
        bh=YNp/yvFhsx77bB3jyjujX9DWqCR9bbA1zfZ2FCw+jcg=;
        h=From:To:Cc:Subject:Date;
        b=Rrxdimic9PTTYFsvGOdZ080n/7GJRIAl0/FlKm3G90QAeiexThCBlh3rSeNanI+3m
         QRNbA6sXEdE7tjqO4UMrDcAQNbxoJTYq6ym95WKtzkUq70W7xtjVJwXPQg8q8Bcr6Z
         oN+vFmfONFcRQw401efhNGvIBRcfPEFMWQ7b4Qw4=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id 2E800642; Sat, 15 Jan 2022 09:11:40 +0800
X-QQ-mid: xmsmtpt1642209100t1cufa6nb
Message-ID: <tencent_46E8FF37413C984772AD382429DAC2719409@qq.com>
X-QQ-XMAILINFO: MxUBm8splV+pt5nDB6L0MjDMuGjDdD35LsIelK25JsJDfx0j4TvaYukC+2hLfR
         lic28361A6ZtdQfi0EGqCVjse8JL2ATl7AmlhZhXqoLIbu3TPKZJSMPugGMu39QQ5BYeKLZt75fo
         lxZoFYdH6k84WQFuCwhdFDIuCntoIuWdPK9thCwaBaS8951YHRQoXu4wZPq/DLw92e2mDzOISb6Q
         yTcExWgUrtTIZySiNsSktwB3U2eGC6HEhFlWkJ1fAz3mb5RWl22z6ppTR7hRl1tG+BQJq2QigQIW
         GxMDRT9hDnONgXQ1vQhuJ1IRwI3eX4EzBr3lKUEnR7gz14WKRcDmOCL1nzyM+Bh79VetYA6lfb8T
         gHvHd86FR4QpnhkqHgmqx5a7Mof06pnzlbdB91AWN9J6BQxBLPr5mWtGpYm9tIQMlOWuHvC6J+A5
         5OwgwD8+AThjrKUcsrdiO6tgZQFv9BuIvQD1/EMcH4fzciTVjsHJ/g2cdDrk+/fDNWSWLiaKgJOn
         psM0RYxf3gQoW0SPcJ2C8JIF7XYlBQuVrp9M8WFcocnDue3IppdekhIp/37YIMTPqaox/aNZevtU
         aIkR4p4EgWHkh0/WdBLSVHxAZs9+Ium9Gc+zxxvFHnxwmA5JTyrXaUpZbqqgyPBL13HmBKKP5ssS
         cy6dJa/4k/w1Xd9n7Nht2stcAO/CqhvTQrG2FjEnlOmRDO5hZxXX7zepBaULbLBKdsWrJRUyt/KI
         Ygbfi61TPwVbil7cq/L4otiZOo05Fa7YMOedB5ikvq6lQFZJA3r8Qmm/YbWVqLtj5Y+pg7vCC/ul
         o/dxxGTH0z2Ln3Qvln0tj1cdeEK/fG835TPn/onpn9J5Io3K8pf9/rqBtn6iWtEa0QLDBWToEobv
         XZoMzgO+BiWuEismfUIQDfRApGlSl6/nQui4PMLob3pBMfBbcww9k=
From:   xkernel.wang@foxmail.com
To:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3] integrity: check the return value of audit_log_start()
Date:   Sat, 15 Jan 2022 09:11:11 +0800
X-OQ-MSGID: <20220115011111.1900-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Xiaoke Wang <xkernel.wang@foxmail.com>

audit_log_start() returns audit_buffer pointer on success or NULL on
error, so it is better to check the return value of it.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
Reviewed-by: Paul Moore <paul@paul-moore.com>
---
Changelogs:
V2 -> V3: add the Reviewed-by tag.
V1 -> V2: simplify the patch. 
 security/integrity/integrity_audit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 2922005..0ec5e4c 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -45,6 +45,8 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
 		return;
 
 	ab = audit_log_start(audit_context(), GFP_KERNEL, audit_msgno);
+	if (!ab)
+		return;
 	audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
 			 task_pid_nr(current),
 			 from_kuid(&init_user_ns, current_uid()),
-- 
