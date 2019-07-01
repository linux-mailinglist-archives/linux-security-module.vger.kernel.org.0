Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD2E93010C
	for <lists+linux-security-module@lfdr.de>; Thu, 30 May 2019 19:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfE3R02 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 30 May 2019 13:26:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfE3R02 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 May 2019 13:26:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FBB7305D799;
        Thu, 30 May 2019 17:26:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 452387E304;
        Thu, 30 May 2019 17:26:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/10] keys: Add capability-checking keyctl function [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org
Date:   Thu, 30 May 2019 18:26:25 +0100
Message-ID: <155923718546.949.13039266815245271686.stgit@warthog.procyon.org.uk>
In-Reply-To: <155923711088.949.14909672457214372214.stgit@warthog.procyon.org.uk>
References: <155923711088.949.14909672457214372214.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 30 May 2019 17:26:27 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a keyctl function that requests a set of capability bits to find out
what features are supported.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/uapi/linux/keyctl.h |   14 ++++++++++++++
 security/keys/compat.c      |    3 +++
 security/keys/internal.h    |    2 ++
 security/keys/keyctl.c      |   37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index fd9fb11b312b..aa4972163442 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -68,6 +68,7 @@
 #define KEYCTL_PKEY_VERIFY		28	/* Verify a public key signature */
 #define KEYCTL_RESTRICT_KEYRING		29	/* Restrict keys allowed to link to a keyring */
 #define KEYCTL_MOVE			30	/* Move keys between keyrings */
+#define KEYCTL_CAPABILITIES		31	/* Find capabilities of keyrings subsystem */
 
 /* keyctl structures */
 struct keyctl_dh_params {
@@ -115,4 +116,17 @@ struct keyctl_pkey_params {
 
 #define KEYCTL_MOVE_EXCL	0x00000001 /* Do not displace from the to-keyring */
 
+/*
+ * Capabilities flags.  The capabilities list is an array of 32-bit integers;
+ * each integer can carry up to 32 flags.
+ */
+#define KEYCTL_CAPS0_CAPABILITIES	0x00000001 /* KEYCTL_CAPABILITIES supported */
+#define KEYCTL_CAPS0_PERSISTENT_KEYRINGS 0x00000002 /* Persistent keyrings enabled */
+#define KEYCTL_CAPS0_DIFFIE_HELLMAN	0x00000004 /* Diffie-Hellman computation enabled */
+#define KEYCTL_CAPS0_PUBLIC_KEY		0x00000008 /* Public key ops enabled */
+#define KEYCTL_CAPS0_BIG_KEY		0x00000010 /* big_key-type enabled */
+#define KEYCTL_CAPS0_INVALIDATE		0x00000020 /* KEYCTL_INVALIDATE supported */
+#define KEYCTL_CAPS0_RESTRICT_KEYRING	0x00000040 /* KEYCTL_RESTRICT_KEYRING supported */
+#define KEYCTL_CAPS0_MOVE		0x00000080 /* KEYCTL_MOVE supported */
+
 #endif /*  _LINUX_KEYCTL_H */
diff --git a/security/keys/compat.c b/security/keys/compat.c
index b326bc4f84d7..a53e30da20c5 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -162,6 +162,9 @@ COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 	case KEYCTL_MOVE:
 		return keyctl_keyring_move(arg2, arg3, arg4, arg5);
 
+	case KEYCTL_CAPABILITIES:
+		return keyctl_capabilities(compat_ptr(arg2), arg3);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/security/keys/internal.h b/security/keys/internal.h
index b54a58c025ae..884fd796f668 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -329,6 +329,8 @@ static inline long keyctl_pkey_e_d_s(int op,
 }
 #endif
 
+extern long keyctl_capabilities(unsigned int __user *_buffer, size_t buflen);
+
 /*
  * Debugging key validation
  */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index bbfe7d92d41c..b3db363e0b25 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -30,6 +30,18 @@
 
 #define KEY_MAX_DESC_SIZE 4096
 
+static const u32 keyrings_capabilities[1] = {
+	[0] = (KEYCTL_CAPS0_CAPABILITIES |
+	       (IS_ENABLED(CONFIG_PERSISTENT_KEYRINGS)	? KEYCTL_CAPS0_PERSISTENT_KEYRINGS : 0) |
+	       (IS_ENABLED(CONFIG_KEY_DH_OPERATIONS)	? KEYCTL_CAPS0_DIFFIE_HELLMAN : 0) |
+	       (IS_ENABLED(CONFIG_ASYMMETRIC_KEY_TYPE)	? KEYCTL_CAPS0_PUBLIC_KEY : 0) |
+	       (IS_ENABLED(CONFIG_BIG_KEYS)		? KEYCTL_CAPS0_BIG_KEY : 0) |
+	       KEYCTL_CAPS0_INVALIDATE |
+	       KEYCTL_CAPS0_RESTRICT_KEYRING |
+	       KEYCTL_CAPS0_MOVE
+	       ),
+};
+
 static int key_get_type_from_user(char *type,
 				  const char __user *_type,
 				  unsigned len)
@@ -1678,6 +1690,28 @@ long keyctl_restrict_keyring(key_serial_t id, const char __user *_type,
 	return ret;
 }
 
+/*
+ * Get keyrings subsystem capabilities.
+ */
+long keyctl_capabilities(unsigned int __user *_buffer, size_t buflen)
+{
+	size_t size = buflen;
+
+	if (size == 0)
+		return sizeof(keyrings_capabilities);
+	if (size & 3)
+		return -EINVAL;
+	if (size > sizeof(keyrings_capabilities))
+		size = sizeof(keyrings_capabilities);
+	if (copy_to_user(_buffer, keyrings_capabilities, size) != 0)
+		return -EFAULT;
+	if (size < buflen &&
+	    clear_user(_buffer + size, buflen - size) != 0)
+		return -EFAULT;
+
+	return sizeof(keyrings_capabilities);
+}
+
 /*
  * The key control system call
  */
@@ -1824,6 +1858,9 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 					   (key_serial_t)arg4,
 					   (unsigned int)arg5);
 
+	case KEYCTL_CAPABILITIES:
+		return keyctl_capabilities((unsigned int __user *)arg2, (size_t)arg3);
+
 	default:
 		return -EOPNOTSUPP;
 	}

