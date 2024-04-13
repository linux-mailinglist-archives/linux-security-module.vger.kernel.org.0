Return-Path: <linux-security-module+bounces-2673-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86868A39B7
	for <lists+linux-security-module@lfdr.de>; Sat, 13 Apr 2024 02:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F141C21528
	for <lists+linux-security-module@lfdr.de>; Sat, 13 Apr 2024 00:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB9D20B28;
	Sat, 13 Apr 2024 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kNW5UiUR"
X-Original-To: linux-security-module@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2814F62;
	Sat, 13 Apr 2024 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969772; cv=none; b=CeCiH869PXTqrNsW+L5HtAYlJbxoa5qf1EZlfGEhwHrWlTcn2Z2BpizWR32+0Kr4xqPj/Z2BidcXltF/qoJD3Jy0PWGeiAEyfjjkxxGLALuU+OuISBPxdJD0pKmnPY6KuuC/5Wk9MB9WmePFIko165Pl0hBZWoswHOCGSgRko/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969772; c=relaxed/simple;
	bh=mNmtNgz74PFT2c3Is9zdzhkCoWnYL7bqfPhIFkDP+3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m5VMT64fyHsCmulJGg3liyVrmzI544jrJA+FuvH7vedpg2RUFx1nh9d9rlcgikiSZ23YBQcjrKTTNTJpHeV0BIu6dkmLjSEdLb95GPtpTTZpenGGauyVccQ3zmHZtBoH6ZUd7OCvqP7997zyweiNoLWlsIl8ZaDft8BqYlCJIEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kNW5UiUR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 2E06320FC5EA; Fri, 12 Apr 2024 17:56:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E06320FC5EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712969766;
	bh=gbZowhlpyPqRy4N7sQZjy5zab1m8o7WhIT2V077wSTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNW5UiURj84Mio+/Svq6J2xeDiUgCZXRnscP8DVKxvvC8YLtcHP3IKSYIvYabPTTZ
	 Hf/4ej+agKFxI5USfZr8uIxsf6h/aBA2c6yXjMKpG8Jg644e0GuWyZtTKBtfb4qq09
	 dN7B/I/uJGPG6Qou+DSqV26v8NY+yu8y9t+K9Kqo=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	jmorris@namei.org,
	serge@hallyn.com,
	tytso@mit.edu,
	ebiggers@kernel.org,
	axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [PATCH v17 12/21] dm: add finalize hook to target_type
Date: Fri, 12 Apr 2024 17:55:55 -0700
Message-Id: <1712969764-31039-13-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

This patch adds a target finalize hook.

The hook is triggered just before activating an inactive table of a
mapped device. If it returns an error the __bind get cancelled.

The dm-verity target will use this hook to attach the dm-verity's
roothash metadata to the block_device struct of the mapped device.

Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v1-v10:
  + Not present

v11:
  + Introduced

v12:
  + No changes

v13:
  + No changes

v14:
  + Add documentation

v15:
  + No changes

v16:
  + No changes

v17:
  + No changes
---
 drivers/md/dm.c               | 12 ++++++++++++
 include/linux/device-mapper.h |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 56aa2a8b9d71..16d3fd644176 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2270,6 +2270,18 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 		goto out;
 	}
 
+	for (unsigned int i = 0; i < t->num_targets; i++) {
+		struct dm_target *ti = dm_table_get_target(t, i);
+
+		if (ti->type->finalize) {
+			ret = ti->type->finalize(ti);
+			if (ret) {
+				old_map = ERR_PTR(ret);
+				goto out;
+			}
+		}
+	}
+
 	old_map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
 	rcu_assign_pointer(md->map, (void *)t);
 	md->immutable_target_type = dm_table_get_immutable_target_type(t);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 82b2195efaca..ad368904b1d5 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -160,6 +160,14 @@ typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
  */
 typedef size_t (*dm_dax_recovery_write_fn)(struct dm_target *ti, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i);
+/*
+ * This hook allows DM targets in an inactive table to complete their setup
+ * before the table is made active.
+ * Returns:
+ *  < 0 : error
+ *  = 0 : success
+ */
+typedef int (*dm_finalize_fn) (struct dm_target *target);
 
 void dm_error(const char *message);
 
@@ -210,6 +218,7 @@ struct target_type {
 	dm_dax_direct_access_fn direct_access;
 	dm_dax_zero_page_range_fn dax_zero_page_range;
 	dm_dax_recovery_write_fn dax_recovery_write;
+	dm_finalize_fn finalize;
 
 	/* For internal device-mapper use. */
 	struct list_head list;
-- 
2.44.0


