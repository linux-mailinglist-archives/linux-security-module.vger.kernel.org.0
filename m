Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C2044CD77
	for <lists+linux-security-module@lfdr.de>; Thu, 11 Nov 2021 00:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhKJXDR (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 10 Nov 2021 18:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhKJXDR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Nov 2021 18:03:17 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2289AC0613F5
        for <linux-security-module@vger.kernel.org>; Wed, 10 Nov 2021 15:00:29 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z19-20020aa79593000000b0049472f5e52dso2747972pfj.13
        for <linux-security-module@vger.kernel.org>; Wed, 10 Nov 2021 15:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=t5e0oq8q91cf/Ue6VqtW39BEhdWlEDVqG4XuF2W3UxM=;
        b=cjQh6yNRqAEib4bkuRUUV2DzILAxjUXsa2S96kVT5IHEIF8n+S7d9YYD9bP2jTRXjA
         cvieNrJ8MKHHV3sNffXW9ZMjXt1TjIuHA+6L9COj6WWGhbfPyFJPZd1CAaf7dH0hGVcG
         CiBvI5mu/gxKn7yJdaJ/WcysJmRd+w88jqtiJnn6d6sr1NDNcIX57iLVGRXIvREMQmBI
         6MZ5nuwDLR9H85UDRuW0pj/STyYHfI3ms3RtV9iiS24qAd3YBaZhriYVsy7GfokJe6p2
         BLFyw1YtsZ2z1X98STw3fU3qHQwOrIqFx1PYs+PcSlSnxgL8E6L4D/ZVL6hR+O3cfhbJ
         Qp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=t5e0oq8q91cf/Ue6VqtW39BEhdWlEDVqG4XuF2W3UxM=;
        b=53C+URM+mbpbcpIadyiGDBjnUQKSng9EsGouLWt3z4ITptXHdnFoK6GxVVXdHup0yi
         TOlb1TbGn4YacKl9jQf2REVa/cqTzyO6le7uJQ/EkdE1yHJ2rmMzByufoo1OasFxRn9o
         d+ZE6JlxYva/nIQPVzsBYhFZYmQ6oh9VWkE3VE8c/8rgYwNhaxUurErQEBoYKBjNWRnN
         MXlN5iF/4kNi/LzRyKTqr3kT0wa4Lo6WABNNMePIPNr+ktHmhP1Wlkr9fuhwSCzVVH/l
         v1DoDGhpsuZC0DMFzJ3st1Lt480SvMCSLveH/NKtLpLyBNuJD1Tm1wpQgbAjG/eco7j7
         TN2Q==
X-Gm-Message-State: AOAM5310KB0s87E9l1GLnT7UqYokYPGuCvfCpYuox2T5O8uNpS/tWbNY
        9O5ahxzAsxbUNFqOM9Zc7kBXBa+s7Q==
X-Google-Smtp-Source: ABdhPJwpQyLAed5G4PQyKeGJbPJXdZCROZTEk0QHj7f3ksUPOMbm0WkC0uB/PCoqBdVsesGfp5QwGOTDvA==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:4a73:99b6:9694:8c4d])
 (user=tkjos job=sendgmr) by 2002:a17:902:82c9:b0:142:401f:dc9 with SMTP id
 u9-20020a17090282c900b00142401f0dc9mr2619789plz.43.1636585228607; Wed, 10 Nov
 2021 15:00:28 -0800 (PST)
Date:   Wed, 10 Nov 2021 15:00:23 -0800
Message-Id: <20211110230025.3272776-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 5.4 1/3] binder: use euid from cred instead of using task
From:   Todd Kjos <tkjos@google.com>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        christian@brauner.io, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, keescook@chromium.org, jannh@google.com,
        jeffv@google.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

commit 29bc22ac5e5bc63275e850f0c8fc549e3d0e306b upstream.

Save the 'struct cred' associated with a binder process
at initial open to avoid potential race conditions
when converting to an euid.

Set a transaction's sender_euid from the 'struct cred'
saved at binder_open() instead of looking up the euid
from the binder proc's 'struct task'. This ensures
the euid is associated with the security context that
of the task that opened binder.

Cc: stable@vger.kernel.org # 4.4+
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Signed-off-by: Todd Kjos <tkjos@google.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Suggested-by: Jann Horn <jannh@google.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Change-Id: I91922e7f359df5901749f1b09094c3c68d45aed4
---
 drivers/android/binder.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 4eaef780844e..64f6fb3b1f66 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -424,6 +424,9 @@ enum binder_deferred_state {
  *                        (invariant after initialized)
  * @tsk                   task_struct for group_leader of process
  *                        (invariant after initialized)
+ * @cred                  struct cred associated with the `struct file`
+ *                        in binder_open()
+ *                        (invariant after initialized)
  * @deferred_work_node:   element for binder_deferred_list
  *                        (protected by binder_deferred_lock)
  * @deferred_work:        bitmap of deferred work to perform
@@ -469,6 +472,7 @@ struct binder_proc {
 	struct list_head waiting_threads;
 	int pid;
 	struct task_struct *tsk;
+	const struct cred *cred;
 	struct hlist_node deferred_work_node;
 	int deferred_work;
 	bool is_dead;
@@ -3092,7 +3096,7 @@ static void binder_transaction(struct binder_proc *proc,
 		t->from = thread;
 	else
 		t->from = NULL;
-	t->sender_euid = task_euid(proc->tsk);
+	t->sender_euid = proc->cred->euid;
 	t->to_proc = target_proc;
 	t->to_thread = target_thread;
 	t->code = tr->code;
@@ -4707,6 +4711,7 @@ static void binder_free_proc(struct binder_proc *proc)
 	}
 	binder_alloc_deferred_release(&proc->alloc);
 	put_task_struct(proc->tsk);
+	put_cred(proc->cred);
 	binder_stats_deleted(BINDER_STAT_PROC);
 	kfree(proc);
 }
@@ -5234,6 +5239,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	spin_lock_init(&proc->outer_lock);
 	get_task_struct(current->group_leader);
 	proc->tsk = current->group_leader;
+	proc->cred = get_cred(filp->f_cred);
 	INIT_LIST_HEAD(&proc->todo);
 	proc->default_priority = task_nice(current);
 	/* binderfs stashes devices in i_private */
-- 
2.34.0.rc0.344.g81b53c2807-goog

