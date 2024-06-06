Return-Path: <linux-security-module+bounces-3698-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890338FDDC8
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Jun 2024 06:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049962820D7
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Jun 2024 04:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD642576B;
	Thu,  6 Jun 2024 04:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRBNwY0f"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7EB8821;
	Thu,  6 Jun 2024 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717648576; cv=none; b=rpHaAvtaBVvTwJPfAqw2NwIpMbxwiXYgjlWq1xKC81b3ymY4h0xEsKtQF9Q5Qt9Qj6nusqDAWEzjKUJczfOQdPeHaUvw+sR/GHsAV5EOke0+SP0p9Xw7DRYf8wYhggAiEsEbSkNW6s3i5ZEeCH8ZBfRNYJpuZENs+otMAwdPrww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717648576; c=relaxed/simple;
	bh=zMAyk+pSE+4NQafLdJUNH4Iy60pBlPfnVpsQh7Ya378=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lwFZfkMElcqAUU7qFiIFdqWGK7F6JYVooSL1NF1vU3SQcTW0Kc60enKGiikiQrDjMNdZ6GvMA40lOSPezQnD3vomJXtRrEzdU+wgSQ0lZ7qNBwhV7W+iTfuGJl6UCOKDAeZ1/ngd3rO3Un4yx0tAM04qC8lpESfG+OEXAcvvXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRBNwY0f; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70260814b2dso375456b3a.1;
        Wed, 05 Jun 2024 21:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717648574; x=1718253374; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xcF8PFHFr/p434RkI6nR7otyk8YbjAtvIYLs5PV77k=;
        b=LRBNwY0fdKIpFX7jlbttF36s4YMBtIplWwlC3zv6FlRvMtB7rqWCWg5IgcJRC8VRDS
         zbY6KTgVG0+mBkstV4b4AxdoBF8R919EZDtNzLzpYLgmj4wWCFcX8Yz521RdNZpO87x0
         b4wdSutnjzeMJ+CId0CNgCn+62WbheFzFMiAFgXUOretYSRoaAQqryWVx7SXEOPzD3ZD
         xHUychVwAyqizFDBVptK6EdEf4Yk+IgTF37aTrwL1DVi/b1mikqjhuDX+WXJ69gxk3n4
         fPoWuNvfZxMWDfT1+VyIPVsRqPVgrDq7lndGNUkEVBQq2a0jg0AJ8aONSCStZbwXZTs2
         S3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717648574; x=1718253374;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xcF8PFHFr/p434RkI6nR7otyk8YbjAtvIYLs5PV77k=;
        b=L6wtqzB7IOD/SePuHekKu6fSdDMqcpLI6xqtvTaxVwbqZ3Qz02gjXS9/S6U7v/4mtJ
         l6bbRMwZvbXFJ1tjCmO9cO7UFFjVZUbiNCmbE2Is9H4HSsGbB0r96sMpa8Iv7Vx5U3d+
         b9NKCeeV15bBUXVdEBJ92bPyl8vDZkp5cMzDNWnKAu6nbLjllMIu6G+odK07NX3G6KV5
         Lbor2JCyP341SXe/L0b3vrH35LqzryFBRfbVxQAWcKKvlgQHYrOsyDfDQ2/fcnCjDzun
         OshAB6KvCuCeUCCwArwcgTs/lUqSeY1Lpqpj1axm9JPq+ylSX8YldRliTDrWC6VEquKl
         b8sg==
X-Forwarded-Encrypted: i=1; AJvYcCX3tzuUIPlXM7oCUfvwPWqJM/rDyoBxd/JIt9mLzhAGZJF/e6W9BB9NZTFY/GeRO+XcWOoLiQ85fZb7HM3wQnpim142GchHdbFFlNBdvbuaMwMbezCSV4GRrPNrgMXlzk8ePD1JWCRixKo0Dh5fpQE9152r5GYpdkOY3SgFd2XEyu2AveuS+FmYLMNn
X-Gm-Message-State: AOJu0YxAdcW/D0YjKErzACk+EwsB8U/0zbzFdXJOf0d+lIJ9KmsGUnZ7
	QWu/9fhcn/OD9kMdxYyYgRls55vH/4caF2Ws7M4pR30VZTgd4ArY7QsWr3O5
X-Google-Smtp-Source: AGHT+IHHaU940zCga72Pb/qf4xB7UDeXArgqcCyZZNnEWu4qofchBidngqbfNcPZ0ryDcbJr3971Gg==
X-Received: by 2002:a05:6a00:18aa:b0:702:496d:d8b5 with SMTP id d2e1a72fcca58-703f8622841mr2599132b3a.6.1717648574353;
        Wed, 05 Jun 2024 21:36:14 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd495175sm304247b3a.123.2024.06.05.21.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 21:36:13 -0700 (PDT)
Date: Wed, 5 Jun 2024 22:36:11 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Jann Horn <jannh@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	outreachy@lists.linux.dev
Subject: [PATCH v3] landlock: Add abstract unix socket connect restriction
Message-ID: <ZmE8u1LV6aOWV9tB@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Abstract unix sockets are used for local inter-process communications
without on a filesystem. Currently a sandboxed process can connect to a
socket outside of the sandboxed environment, since landlock has no
restriction for connecting to a unix socket in the abstract namespace.
Access to such sockets for a sandboxed process should be scoped the same
way ptrace is limited.

Because of compatibility reasons and since landlock should be flexible,
we extend the user space interface by adding a new "scoped" field. This
field optionally contains a "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to
specify that the ruleset will deny any connection from within the
sandbox to its parents(i.e. any parent sandbox or non-sandbox processes)

Closes: https://github.com/landlock-lsm/linux/issues/7

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

-------
V3: Added "scoped" field to landlock_ruleset_attr
V2: Remove wrapper functions

-------
---
 include/uapi/linux/landlock.h | 22 +++++++++++++++
 security/landlock/limits.h    |  5 ++++
 security/landlock/ruleset.c   | 16 +++++++----
 security/landlock/ruleset.h   | 31 ++++++++++++++++++--
 security/landlock/syscalls.c  |  9 ++++--
 security/landlock/task.c      | 53 ++++++++++++++++++-----------------
 6 files changed, 102 insertions(+), 34 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 68625e728f43..1641aeb9eeaa 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -37,6 +37,12 @@ struct landlock_ruleset_attr {
 	 * rule explicitly allow them.
 	 */
 	__u64 handled_access_net;
+	/**
+	 * scoped: Bitmask of actions (cf. `Scope access flags`_)
+	 * that is handled by this ruleset and should be permitted
+	 * by default if no rule explicitly deny them.
+	 */
+	__u64 scoped;
 };
 
 /*
@@ -266,4 +272,20 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
 /* clang-format on */
+
+/**
+ * DOC: scoped
+ *
+ * Scope access flags
+ * ~~~~~~~~~~~~~~~~~~~~
+ * These flags enable to restrict a sandboxed process to a set of
+ * inter-process communications actions. 
+ *
+ * IPCs with scoped actions:
+ * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandbox process to
+ *   connect to another process through abstract unix sockets. 
+ */
+/* clang-format off */
+#define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
+/* clang-format on*/
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 20fdb5ff3514..d6fb82fd1e67 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -28,6 +28,11 @@
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 #define LANDLOCK_SHIFT_ACCESS_NET	LANDLOCK_NUM_ACCESS_FS
 
+#define LANDLOCK_LAST_ACCESS_UNIX       LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
+#define LANDLOCK_MASK_ACCESS_UNIX	((LANDLOCK_LAST_ACCESS_UNIX << 1) - 1)
+#define LANDLOCK_NUM_ACCESS_UNIX         __const_hweight64(LANDLOCK_MASK_ACCESS_UNIX)
+#define LANDLOCK_SHIFT_ACCESS_UNIX      LANDLOCK_SHIFT_ACCESS_NET
+
 /* clang-format on */
 
 #endif /* _SECURITY_LANDLOCK_LIMITS_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index e0a5fbf9201a..0592e53cdc9d 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -52,12 +52,13 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 
 struct landlock_ruleset *
 landlock_create_ruleset(const access_mask_t fs_access_mask,
-			const access_mask_t net_access_mask)
+			const access_mask_t net_access_mask,
+			const access_mask_t unix_access_mask)
 {
 	struct landlock_ruleset *new_ruleset;
 
 	/* Informs about useless ruleset. */
-	if (!fs_access_mask && !net_access_mask)
+	if (!fs_access_mask && !net_access_mask && !unix_access_mask)
 		return ERR_PTR(-ENOMSG);
 	new_ruleset = create_ruleset(1);
 	if (IS_ERR(new_ruleset))
@@ -66,6 +67,9 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
 		landlock_add_fs_access_mask(new_ruleset, fs_access_mask, 0);
 	if (net_access_mask)
 		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
+	if (unix_access_mask)
+		landlock_add_unix_socket_access_mask(new_ruleset,
+						     unix_access_mask, 0);
 	return new_ruleset;
 }
 
@@ -173,9 +177,11 @@ static void build_check_ruleset(void)
 
 	BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
 	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
-	BUILD_BUG_ON(access_masks <
-		     ((LANDLOCK_MASK_ACCESS_FS << LANDLOCK_SHIFT_ACCESS_FS) |
-		      (LANDLOCK_MASK_ACCESS_NET << LANDLOCK_SHIFT_ACCESS_NET)));
+	BUILD_BUG_ON(
+		access_masks <
+		((LANDLOCK_MASK_ACCESS_FS << LANDLOCK_SHIFT_ACCESS_FS) |
+		 (LANDLOCK_MASK_ACCESS_NET << LANDLOCK_SHIFT_ACCESS_NET) |
+		 (LANDLOCK_MASK_ACCESS_UNIX << LANDLOCK_SHIFT_ACCESS_UNIX)));
 }
 
 /**
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index c7f1526784fd..6e755d924a5e 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -35,6 +35,8 @@ typedef u16 access_mask_t;
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
 /* Makes sure all network access rights can be stored. */
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
+/* Makes sure all abstract Unix Socket access rights can be stored*/
+static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_UNIX);
 /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
 static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 
@@ -42,7 +44,8 @@ static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 typedef u32 access_masks_t;
 /* Makes sure all ruleset access rights can be stored. */
 static_assert(BITS_PER_TYPE(access_masks_t) >=
-	      LANDLOCK_NUM_ACCESS_FS + LANDLOCK_NUM_ACCESS_NET);
+	      LANDLOCK_NUM_ACCESS_FS + LANDLOCK_NUM_ACCESS_NET +
+		      LANDLOCK_NUM_ACCESS_UNIX);
 
 typedef u16 layer_mask_t;
 /* Makes sure all layers can be checked. */
@@ -233,7 +236,8 @@ struct landlock_ruleset {
 
 struct landlock_ruleset *
 landlock_create_ruleset(const access_mask_t access_mask_fs,
-			const access_mask_t access_mask_net);
+			const access_mask_t access_mask_net,
+			const access_mask_t access_mask_unix);
 
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
@@ -282,6 +286,18 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
 		(net_mask << LANDLOCK_SHIFT_ACCESS_NET);
 }
 
+static inline void
+landlock_add_unix_socket_access_mask(struct landlock_ruleset *const ruleset,
+				     const access_mask_t unix_access_mask,
+				     const u16 layer_level)
+{
+	access_mask_t unix_mask = unix_access_mask & LANDLOCK_MASK_ACCESS_UNIX;
+
+	WARN_ON_ONCE(unix_access_mask != unix_mask);
+	ruleset->access_masks[layer_level] |=
+		(unix_mask << LANDLOCK_SHIFT_ACCESS_UNIX);
+}
+
 static inline access_mask_t
 landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
 				const u16 layer_level)
@@ -309,6 +325,17 @@ landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
 	       LANDLOCK_MASK_ACCESS_NET;
 }
 
+static inline access_mask_t
+landlock_get_unix_access_mask(const struct landlock_ruleset *const ruleset,
+			      const u16 layer_level)
+{
+	return landlock_get_raw_fs_access_mask(ruleset, layer_level) |
+	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+	return (ruleset->access_masks[layer_level] >>
+		LANDLOCK_SHIFT_ACCESS_UNIX) &
+	       LANDLOCK_MASK_ACCESS_UNIX;
+}
+
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
 			    const access_mask_t access_request,
 			    layer_mask_t (*const layer_masks)[],
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 03b470f5a85a..955d3d028963 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -97,8 +97,9 @@ static void build_check_abi(void)
 	 */
 	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
 	ruleset_size += sizeof(ruleset_attr.handled_access_net);
+	ruleset_size += sizeof(ruleset_attr.scoped);
 	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
-	BUILD_BUG_ON(sizeof(ruleset_attr) != 16);
+	BUILD_BUG_ON(sizeof(ruleset_attr) != 24);
 
 	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
 	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
@@ -212,10 +213,14 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if ((ruleset_attr.handled_access_net | LANDLOCK_MASK_ACCESS_NET) !=
 	    LANDLOCK_MASK_ACCESS_NET)
 		return -EINVAL;
+	if ((ruleset_attr.scoped | LANDLOCK_MASK_ACCESS_UNIX) !=
+	    LANDLOCK_MASK_ACCESS_UNIX)
+		return -EINVAL;
 
 	/* Checks arguments and transforms to kernel struct. */
 	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
-					  ruleset_attr.handled_access_net);
+					  ruleset_attr.handled_access_net,
+					  ruleset_attr.scoped);
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 67528f87b7de..b42f31cca2ae 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -14,6 +14,7 @@
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <net/sock.h>
+#include <net/af_unix.h>
 
 #include "common.h"
 #include "cred.h"
@@ -109,32 +110,25 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 	return task_ptrace(parent, current);
 }
 
-static bool unix_sock_is_scoped(struct sock *const sock,
-				struct sock *const other)
+static bool sock_is_scoped(struct sock *const sock, struct sock *const other)
 {
 	bool is_scoped = true;
-
-	/* get the ruleset of connecting sock*/
-	const struct landlock_ruleset *const dom_sock =
-		landlock_get_current_domain();
-
-	if (!dom_sock)
-		return true;
-
-	/* get credential of listening sock*/
-	const struct cred *cred_other = get_cred(other->sk_peer_cred);
-
-	if (!cred_other)
-		return true;
-
-	/* retrieve the landlock_rulesets */
-	const struct landlock_ruleset *dom_parent;
-
-	rcu_read_lock();
-	dom_parent = landlock_cred(cred_other)->domain;
-	is_scoped = domain_scope_le(dom_parent, dom_sock);
-	rcu_read_unlock();
-
+	const struct landlock_ruleset *dom_other;
+	const struct cred *cred_other;
+
+	const struct landlock_ruleset *const dom = landlock_get_current_domain();
+	if (!dom)
+		goto out_put_cred;
+
+	
+	lockdep_assert_held(&unix_sk(other)->lock);
+	/* the credentials will not change */
+	cred_other = get_cred(other->sk_peer_cred);
+	dom_other = landlock_cred(cred_other)->domain;
+	is_scoped = domain_scope_le(dom, dom_other);
+
+out_put_cred:
+	put_cred(cred_other);
 	return is_scoped;
 }
 
@@ -142,7 +136,15 @@ static int hook_unix_stream_connect(struct sock *const sock,
 				    struct sock *const other,
 				    struct sock *const newsk)
 {
-	if (unix_sock_is_scoped(sock, other))
+	if (sock_is_scoped(sock, other))
+		return 0;
+	return -EPERM;
+}
+
+static int hook_unix_may_send(struct socket *const sock,
+			      struct socket *const other)
+{
+	if (sock_is_scoped(sock->sk, other->sk))
 		return 0;
 	return -EPERM;
 }
@@ -151,6 +153,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
 	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
+	LSM_HOOK_INIT(unix_may_send, hook_unix_may_send),
 };
 
 __init void landlock_add_task_hooks(void)
-- 
2.34.1


