Return-Path: <linux-security-module+bounces-8637-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C000A57D95
	for <lists+linux-security-module@lfdr.de>; Sat,  8 Mar 2025 20:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF7E7A84E9
	for <lists+linux-security-module@lfdr.de>; Sat,  8 Mar 2025 18:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424937E0E4;
	Sat,  8 Mar 2025 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PYz3XabL"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D11A7AF7
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741460427; cv=none; b=KWUXM04YqH/neHAuD1vKL2QJWmRfxYLu+BM/xBAdfSQBgWO6VQh4KY/KN/Kj2FgKu2cu29Hp1lzaW31nNpm0MMKOh5KuLA6WcS+2db56gvZH4Txfc5Yr7e5jig9w3w9bDu/Zwlb/wLDn5UV0yBRUYY5K6Ejl5nDkfDV83uwttco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741460427; c=relaxed/simple;
	bh=AmtaGvKQQlXjo3JdTiWFG/rOYA6Xnap3wIdH9lIvMFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umuOp/F1UNow/c2whTjhwqp1N2+LSFaQS7/PqIH1E1VDqtrE6xFOmhOsbyy1+V+8vsGQM/DOiGJpdl2jlEI5lqKkEsSjFDOqBJficEEWMoWFxsNj8JXoIPMY1hZumErBeTwPzNqdE14CxAXLLREjhBv8LSPMwTDFHYgAjG7aZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PYz3XabL; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9BsM12pgzRSy;
	Sat,  8 Mar 2025 19:44:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459479;
	bh=TwH8+8Lj6sHCNuDChiWjCXEj20CBT3AkbxLELBQclZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYz3XabLHO0kwUd4p8LitPg1gLDmLSEJgPCqHI8WnabubJnnDRbpAJGez9J2sOpdf
	 FuHSnLdfHDANMBUfbf4doH+DR2Rbe74WrfjjH7uCDdWXaBREE/PqwOc0xM36jxTnfX
	 jTbnxJQHyNVbl8LlYMEwJXqKP42RRnYaH9RfXrcE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9BsL3fNzzMX;
	Sat,  8 Mar 2025 19:44:38 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 04/26] landlock: Prepare to use credential instead of domain for filesystem
Date: Sat,  8 Mar 2025 19:44:00 +0100
Message-ID: <20250308184422.2159360-5-mic@digikod.net>
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This cosmetic change is needed for audit support, specifically to be
able to filter according to cross-execution boundaries.

Add landlock_get_applicable_subject(), mainly a copy of
landlock_get_applicable_domain(), which will fully replace it in a
following commit.

Optimize current_check_access_path() to only handle the access request.

Partially replace get_current_fs_domain() with explicit calls to
landlock_get_applicable_subject().  The remaining ones will follow with
more changes.

Remove explicit domain->num_layers check which is now part of the
landlock_get_applicable_subject() call.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-5-mic@digikod.net
---

Changes since v4:
- New patch to avoid duplicated computation of the layer level that
  denied an access.
---
 security/landlock/cred.h | 50 +++++++++++++++++++++++++++++++
 security/landlock/fs.c   | 65 +++++++++++++++++++++++-----------------
 2 files changed, 88 insertions(+), 27 deletions(-)

diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index bf755459838a..fdbbaf66d151 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/rcupdate.h>
 
+#include "access.h"
 #include "ruleset.h"
 #include "setup.h"
 
@@ -53,6 +54,55 @@ static inline bool landlocked(const struct task_struct *const task)
 	return has_dom;
 }
 
+/**
+ * landlock_get_applicable_subject - Return the subject's Landlock credential
+ *                                   if its enforced domain applies to (i.e.
+ *                                   handles) at least one of the access rights
+ *                                   specified in @masks
+ *
+ * @cred: credential
+ * @masks: access masks
+ * @handle_layer: returned youngest layer handling a subset of @masks.  Not set
+ *                if the function returns NULL.
+ *
+ * Returns: landlock_cred(@cred) if any access rights specified in @masks is
+ * handled, or NULL otherwise.
+ */
+static inline const struct landlock_cred_security *
+landlock_get_applicable_subject(const struct cred *const cred,
+				const struct access_masks masks,
+				size_t *const handle_layer)
+{
+	const union access_masks_all masks_all = {
+		.masks = masks,
+	};
+	const struct landlock_ruleset *domain;
+	ssize_t layer_level;
+
+	if (!cred)
+		return NULL;
+
+	domain = landlock_cred(cred)->domain;
+	if (!domain)
+		return NULL;
+
+	for (layer_level = domain->num_layers - 1; layer_level >= 0;
+	     layer_level--) {
+		union access_masks_all layer = {
+			.masks = domain->access_masks[layer_level],
+		};
+
+		if (layer.all & masks_all.all) {
+			if (handle_layer)
+				*handle_layer = layer_level;
+
+			return landlock_cred(cred);
+		}
+	}
+
+	return NULL;
+}
+
 __init void landlock_add_cred_hooks(void);
 
 #endif /* _SECURITY_LANDLOCK_CRED_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 71b9dc331aae..d5b153d29fcb 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -771,11 +771,14 @@ static bool is_access_to_paths_allowed(
 
 	if (!access_request_parent1 && !access_request_parent2)
 		return true;
-	if (WARN_ON_ONCE(!domain || !path))
+
+	if (WARN_ON_ONCE(!path))
 		return true;
+
 	if (is_nouser_or_private(path->dentry))
 		return true;
-	if (WARN_ON_ONCE(domain->num_layers < 1 || !layer_masks_parent1))
+
+	if (WARN_ON_ONCE(!layer_masks_parent1))
 		return false;
 
 	allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
@@ -926,16 +929,21 @@ static bool is_access_to_paths_allowed(
 static int current_check_access_path(const struct path *const path,
 				     access_mask_t access_request)
 {
-	const struct landlock_ruleset *const dom = get_current_fs_domain();
+	const struct access_masks masks = {
+		.fs = access_request,
+	};
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), masks, NULL);
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
 
-	if (!dom)
+	if (!subject)
 		return 0;
 
-	access_request = landlock_init_layer_masks(
-		dom, access_request, &layer_masks, LANDLOCK_KEY_INODE);
-	if (is_access_to_paths_allowed(dom, path, access_request, &layer_masks,
-				       NULL, 0, NULL, NULL))
+	access_request = landlock_init_layer_masks(subject->domain,
+						   access_request, &layer_masks,
+						   LANDLOCK_KEY_INODE);
+	if (is_access_to_paths_allowed(subject->domain, path, access_request,
+				       &layer_masks, NULL, 0, NULL, NULL))
 		return 0;
 
 	return -EACCES;
@@ -1098,7 +1106,8 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 				    struct dentry *const new_dentry,
 				    const bool removable, const bool exchange)
 {
-	const struct landlock_ruleset *const dom = get_current_fs_domain();
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
 	bool allow_parent1, allow_parent2;
 	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
@@ -1106,10 +1115,9 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	layer_mask_t layer_masks_parent1[LANDLOCK_NUM_ACCESS_FS] = {},
 		     layer_masks_parent2[LANDLOCK_NUM_ACCESS_FS] = {};
 
-	if (!dom)
+	if (!subject)
 		return 0;
-	if (WARN_ON_ONCE(dom->num_layers < 1))
-		return -EACCES;
+
 	if (unlikely(d_is_negative(old_dentry)))
 		return -ENOENT;
 	if (exchange) {
@@ -1134,10 +1142,11 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		 * for same-directory referer (i.e. no reparenting).
 		 */
 		access_request_parent1 = landlock_init_layer_masks(
-			dom, access_request_parent1 | access_request_parent2,
+			subject->domain,
+			access_request_parent1 | access_request_parent2,
 			&layer_masks_parent1, LANDLOCK_KEY_INODE);
 		if (is_access_to_paths_allowed(
-			    dom, new_dir, access_request_parent1,
+			    subject->domain, new_dir, access_request_parent1,
 			    &layer_masks_parent1, NULL, 0, NULL, NULL))
 			return 0;
 		return -EACCES;
@@ -1160,10 +1169,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 						      old_dentry->d_parent;
 
 	/* new_dir->dentry is equal to new_dentry->d_parent */
-	allow_parent1 = collect_domain_accesses(dom, mnt_dir.dentry, old_parent,
+	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
+						old_parent,
 						&layer_masks_parent1);
-	allow_parent2 = collect_domain_accesses(
-		dom, mnt_dir.dentry, new_dir->dentry, &layer_masks_parent2);
+	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
+						new_dir->dentry,
+						&layer_masks_parent2);
 
 	if (allow_parent1 && allow_parent2)
 		return 0;
@@ -1175,9 +1186,9 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	 * destination parent access rights.
 	 */
 	if (is_access_to_paths_allowed(
-		    dom, &mnt_dir, access_request_parent1, &layer_masks_parent1,
-		    old_dentry, access_request_parent2, &layer_masks_parent2,
-		    exchange ? new_dentry : NULL))
+		    subject->domain, &mnt_dir, access_request_parent1,
+		    &layer_masks_parent1, old_dentry, access_request_parent2,
+		    &layer_masks_parent2, exchange ? new_dentry : NULL))
 		return 0;
 
 	/*
@@ -1504,11 +1515,10 @@ static int hook_file_open(struct file *const file)
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
 	access_mask_t open_access_request, full_access_request, allowed_access,
 		optional_access;
-	const struct landlock_ruleset *const dom =
-		landlock_get_applicable_domain(
-			landlock_cred(file->f_cred)->domain, any_fs);
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(file->f_cred, any_fs, NULL);
 
-	if (!dom)
+	if (!subject)
 		return 0;
 
 	/*
@@ -1529,9 +1539,10 @@ static int hook_file_open(struct file *const file)
 	full_access_request = open_access_request | optional_access;
 
 	if (is_access_to_paths_allowed(
-		    dom, &file->f_path,
-		    landlock_init_layer_masks(dom, full_access_request,
-					      &layer_masks, LANDLOCK_KEY_INODE),
+		    subject->domain, &file->f_path,
+		    landlock_init_layer_masks(subject->domain,
+					      full_access_request, &layer_masks,
+					      LANDLOCK_KEY_INODE),
 		    &layer_masks, NULL, 0, NULL, NULL)) {
 		allowed_access = full_access_request;
 	} else {
-- 
2.48.1


