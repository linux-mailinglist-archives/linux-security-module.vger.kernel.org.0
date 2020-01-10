Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 610F21378E3
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Jan 2020 23:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgAJWDP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 10 Jan 2020 17:03:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgAJWDN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Jan 2020 17:03:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42F2F20842;
        Fri, 10 Jan 2020 22:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578693792;
        bh=7j23WQ+SHE/7yvpHmS/CjtOS51UI0gESNBj+DtMCOWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7m2kOrNX9Jju+hGd/O1WRHQYYnha+t641BRyUhWsEmQWjTL7sxQWHMzo4UU1YgXT
         IjuchEzSvd8S2Ycr/rQo8TpWHdg6J47It3+0alqn6Xzaw41g6RDfOVjkVJaX2sLrH1
         c4DIIPKdwHhtXDhbWOxYdrX6jeA/wOU0Tx3GrlKw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Garry <john.garry@huawei.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 03/26] tomoyo: Suppress RCU warning at list_for_each_entry_rcu().
Date:   Fri, 10 Jan 2020 17:02:45 -0500
Message-Id: <20200110220308.27784-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110220308.27784-1-sashal@kernel.org>
References: <20200110220308.27784-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 6bd5ce6089b561f5392460bfb654dea89356ab1b ]

John Garry has reported that allmodconfig kernel on arm64 causes flood of
"RCU-list traversed in non-reader section!!" warning. I don't know what
change caused this warning, but this warning is safe because TOMOYO uses
SRCU lock instead. Let's suppress this warning by explicitly telling that
the caller is holding SRCU lock.

Reported-and-tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/tomoyo/common.c |  9 ++++++---
 security/tomoyo/domain.c | 15 ++++++++++-----
 security/tomoyo/group.c  |  9 ++++++---
 security/tomoyo/util.c   |  6 ++++--
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index dd3d5942e669..c36bafbcd77e 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -951,7 +951,8 @@ static bool tomoyo_manager(void)
 	exe = tomoyo_get_exe();
 	if (!exe)
 		return false;
-	list_for_each_entry_rcu(ptr, &tomoyo_kernel_namespace.policy_list[TOMOYO_ID_MANAGER], head.list) {
+	list_for_each_entry_rcu(ptr, &tomoyo_kernel_namespace.policy_list[TOMOYO_ID_MANAGER], head.list,
+				srcu_read_lock_held(&tomoyo_ss)) {
 		if (!ptr->head.is_deleted &&
 		    (!tomoyo_pathcmp(domainname, ptr->manager) ||
 		     !strcmp(exe, ptr->manager->name))) {
@@ -1095,7 +1096,8 @@ static int tomoyo_delete_domain(char *domainname)
 	if (mutex_lock_interruptible(&tomoyo_policy_lock))
 		return -EINTR;
 	/* Is there an active domain? */
-	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list) {
+	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list,
+				srcu_read_lock_held(&tomoyo_ss)) {
 		/* Never delete tomoyo_kernel_domain */
 		if (domain == &tomoyo_kernel_domain)
 			continue;
@@ -2778,7 +2780,8 @@ void tomoyo_check_profile(void)
 
 	tomoyo_policy_loaded = true;
 	pr_info("TOMOYO: 2.6.0\n");
-	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list) {
+	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list,
+				srcu_read_lock_held(&tomoyo_ss)) {
 		const u8 profile = domain->profile;
 		struct tomoyo_policy_namespace *ns = domain->ns;
 
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 8526a0a74023..7869d6a9980b 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -41,7 +41,8 @@ int tomoyo_update_policy(struct tomoyo_acl_head *new_entry, const int size,
 
 	if (mutex_lock_interruptible(&tomoyo_policy_lock))
 		return -ENOMEM;
-	list_for_each_entry_rcu(entry, list, list) {
+	list_for_each_entry_rcu(entry, list, list,
+				srcu_read_lock_held(&tomoyo_ss)) {
 		if (entry->is_deleted == TOMOYO_GC_IN_PROGRESS)
 			continue;
 		if (!check_duplicate(entry, new_entry))
@@ -119,7 +120,8 @@ int tomoyo_update_domain(struct tomoyo_acl_info *new_entry, const int size,
 	}
 	if (mutex_lock_interruptible(&tomoyo_policy_lock))
 		goto out;
-	list_for_each_entry_rcu(entry, list, list) {
+	list_for_each_entry_rcu(entry, list, list,
+				srcu_read_lock_held(&tomoyo_ss)) {
 		if (entry->is_deleted == TOMOYO_GC_IN_PROGRESS)
 			continue;
 		if (!tomoyo_same_acl_head(entry, new_entry) ||
@@ -166,7 +168,8 @@ void tomoyo_check_acl(struct tomoyo_request_info *r,
 	u16 i = 0;
 
 retry:
-	list_for_each_entry_rcu(ptr, list, list) {
+	list_for_each_entry_rcu(ptr, list, list,
+				srcu_read_lock_held(&tomoyo_ss)) {
 		if (ptr->is_deleted || ptr->type != r->param_type)
 			continue;
 		if (!check_entry(r, ptr))
@@ -298,7 +301,8 @@ static inline bool tomoyo_scan_transition
 {
 	const struct tomoyo_transition_control *ptr;
 
-	list_for_each_entry_rcu(ptr, list, head.list) {
+	list_for_each_entry_rcu(ptr, list, head.list,
+				srcu_read_lock_held(&tomoyo_ss)) {
 		if (ptr->head.is_deleted || ptr->type != type)
 			continue;
 		if (ptr->domainname) {
@@ -735,7 +739,8 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 
 		/* Check 'aggregator' directive. */
 		candidate = &exename;
-		list_for_each_entry_rcu(ptr, list, head.list) {
+		list_for_each_entry_rcu(ptr, list, head.list,
+					srcu_read_lock_held(&tomoyo_ss)) {
 			if (ptr->head.is_deleted ||
 			    !tomoyo_path_matches_pattern(&exename,
 							 ptr->original_name))
diff --git a/security/tomoyo/group.c b/security/tomoyo/group.c
index a37c7dc66e44..1cecdd797597 100644
--- a/security/tomoyo/group.c
+++ b/security/tomoyo/group.c
@@ -133,7 +133,8 @@ tomoyo_path_matches_group(const struct tomoyo_path_info *pathname,
 {
 	struct tomoyo_path_group *member;
 
-	list_for_each_entry_rcu(member, &group->member_list, head.list) {
+	list_for_each_entry_rcu(member, &group->member_list, head.list,
+				srcu_read_lock_held(&tomoyo_ss)) {
 		if (member->head.is_deleted)
 			continue;
 		if (!tomoyo_path_matches_pattern(pathname, member->member_name))
@@ -161,7 +162,8 @@ bool tomoyo_number_matches_group(const unsigned long min,
 	struct tomoyo_number_group *member;
 	bool matched = false;
 
-	list_for_each_entry_rcu(member, &group->member_list, head.list) {
+	list_for_each_entry_rcu(member, &group->member_list, head.list,
+				srcu_read_lock_held(&tomoyo_ss)) {
 		if (member->head.is_deleted)
 			continue;
 		if (min > member->number.values[1] ||
@@ -191,7 +193,8 @@ bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *address,
 	bool matched = false;
 	const u8 size = is_ipv6 ? 16 : 4;
 
-	list_for_each_entry_rcu(member, &group->member_list, head.list) {
+	list_for_each_entry_rcu(member, &group->member_list, head.list,
+				srcu_read_lock_held(&tomoyo_ss)) {
 		if (member->head.is_deleted)
 			continue;
 		if (member->address.is_ipv6 != is_ipv6)
diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index 52752e1a84ed..eba0b3395851 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -594,7 +594,8 @@ struct tomoyo_domain_info *tomoyo_find_domain(const char *domainname)
 
 	name.name = domainname;
 	tomoyo_fill_path_info(&name);
-	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list) {
+	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list,
+				srcu_read_lock_held(&tomoyo_ss)) {
 		if (!domain->is_deleted &&
 		    !tomoyo_pathcmp(&name, domain->domainname))
 			return domain;
@@ -1028,7 +1029,8 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
 		return false;
 	if (!domain)
 		return true;
-	list_for_each_entry_rcu(ptr, &domain->acl_info_list, list) {
+	list_for_each_entry_rcu(ptr, &domain->acl_info_list, list,
+				srcu_read_lock_held(&tomoyo_ss)) {
 		u16 perm;
 		u8 i;
 
-- 
2.20.1

