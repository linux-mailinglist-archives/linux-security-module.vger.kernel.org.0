Return-Path: <linux-security-module+bounces-11893-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9445AB58D6A
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Sep 2025 06:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E62526E20
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Sep 2025 04:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B112E888C;
	Tue, 16 Sep 2025 04:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4Xjumc0"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274E2E7BDA
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 04:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998150; cv=none; b=egXaS01FCnI92qvS6tes0mU4+jMaWn/MXHDNeqrJZIO1Sk2qNbkPx+UGLbBrHVw7TwrJvQ6zxp1EWya7mXQcZNZ+LqlR8uN60mgHBOgL8E7pifbq95rLz7ovveL4ZQk1A8oBsRKeZ4FZFArSXBW4MBNVqtrNc/zOc1nEYw03wVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998150; c=relaxed/simple;
	bh=A1DaGpRAAYNdE/JnkBcpbGGz1TWyQSRA1+c5fRETaCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z2mWvMni9phuqD23cmDtaKLfeTNH1bH1XPFEfT7P1FE9aEEP6uPBI6lGIZtp2/ZxB1Ghshom0Z4oe+wlPHGTulv9m8YmsdW9S4GdQke2S50Oe5oATTn09JRU+NC9VAZGwjzIymb04d/BjDtl4G1oM+CQtUIGmbHh1dzNyFNI2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4Xjumc0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso4444343a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 21:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998147; x=1758602947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp+N7RFYdL+M8U5Aod5ZJl4PoDAFL89oD30EaW4MsNY=;
        b=K4Xjumc0nBcco5KyK7TayYg1GVB3J8fMW7YfmCjhgTTUc/fPIDKia1bI2dpOo4Dlpx
         o0oYiCFoIl/qnLukCt0JaKCTycIs9+9f38sOAgldyz8tQIGpDGM4I5xSF1yz9foe5Y+0
         2p4TuTz/xI8E76jU6e6NUTzqr4tF4KFkj0cyt03nQJvtbqEvTMv5/6XrYgnXmNQLeb+O
         sDFNMQP/6B3RWiK8Q1KWu4oWPdcxqbwd7gQ0AyvjLj19qMjmrrjdeeVtI4h+aCXWk442
         XnCfLw3QPsQeRmrhv0yiLaCyo05omJolYFv4x6BgsEMJUeoyH1rHSkFxKz1mCDro3W3Y
         TL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998147; x=1758602947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gp+N7RFYdL+M8U5Aod5ZJl4PoDAFL89oD30EaW4MsNY=;
        b=ipvpYwipayDzYI+6gYBCnLTvAPk1fJt/qvrYBMQL+8luarjBWtB63ugxyQfTW0TwRF
         14vCfZEh3KtGdIsSozheSSIKvCkgDZ+JJFLPI5pI7NTbijhjDZ6AuhePkYYgcOqiGcK4
         V23R1v3OZqvS8/yUWgOseVsi1PAkXYFIC98FvkK7lMOlFumgOr2d+uoGXsmF5vVGDZVe
         V+O6h76oowBPZhgTfd//+S/DDKfldwm7cmd9dU2a2YxQS4l58WXBEStU2nOHTskqenGd
         KYhBgHuagIxktLy5U5olRGG8ZWz/YK6Lqh8ZbiK5k1kFPns/TLUtkKoSLjriT91+nPNP
         YLbg==
X-Forwarded-Encrypted: i=1; AJvYcCXZGf9a6Mu5t5mdxVhjptflwnG7XVJZKhBKh5E7RLI96qwtqmSyefOmIFABpGdvffCU8U753zVwoAq+zae2Aj/Ypwx53iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT9YSIa91gnMl6XxB9KlbOGr68QR2Np3d9zCTmNCL0Y7Olg3hl
	aM01H6I1lfQLd6qCZWgqtCv5LgHLwfEoYNl/+4Io7riZ9x9nrUgDCRQ7
X-Gm-Gg: ASbGncuDjMK6nFkzePeWAmHI1aJs6KI9N6SZqGID3qNGy3BBa0Blui/Gbwyg3rHgRh+
	X8CFWs+KddTvTns1OBX6VEnCU1+5GKPBo3iwr+vczEXZSRad3shEUTUcnbPwAhBraHwfNVRDGFt
	7/dA2PUevmS0eTnNDVxjKd10pm4bmKga34HUKaf5K9XOgFvNNnMqwZZ+l8atlwzV5I6mAVASWQZ
	ww8ItchHyo087Ruk316AWv+hjAUlkLeZqGa+rMKMwOSfWiCl7dycFp/TlfjejB1xXSeJWfK7Tyu
	VRT5hyuIOTkzbSzKNtddAJJB5UzLlkWPuWx6I2tV0qVe+5digCJOf2kV5qBWmXM+6TARJmQ5qvA
	FWTryV4ZTGkeU1w3NQX8L+hxCf6GCmu/9KsNFPt4=
X-Google-Smtp-Source: AGHT+IFqD7sgMgos1nHHN1tffY5PC8RBagTW/SlAHYpHIH6iPNz9WSa7pJxkI6T7wvTsG+plknRS6A==
X-Received: by 2002:a17:902:f70e:b0:266:120a:29c7 with SMTP id d9443c01a7336-266120a3078mr75581275ad.6.1757998147150;
        Mon, 15 Sep 2025 21:49:07 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:06 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 08/14] cgroup: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:29 +0800
Message-Id: <20250916044735.2316171-9-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 kernel/cgroup/cgroup.c | 2 --
 kernel/cgroup/debug.c  | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..db9e00a559df 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2944,14 +2944,12 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 
 	/* look up all src csets */
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	task = leader;
 	do {
 		cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
 		if (!threadgroup)
 			break;
 	} while_each_thread(leader, task);
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 
 	/* prepare dst csets and commit */
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 80aa3f027ac3..81ea38dd6f9d 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -49,7 +49,6 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 		return -ENODEV;
 
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	cset = task_css_set(current);
 	refcnt = refcount_read(&cset->refcount);
 	seq_printf(seq, "css_set %pK %d", cset, refcnt);
@@ -67,7 +66,6 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 		seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
 			  css, css->id);
 	}
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 	cgroup_kn_unlock(of->kn);
 	return 0;
@@ -95,7 +93,6 @@ static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
 		return -ENOMEM;
 
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	cset = task_css_set(current);
 	list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
 		struct cgroup *c = link->cgrp;
@@ -104,7 +101,6 @@ static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
 		seq_printf(seq, "Root %d group %s\n",
 			   c->root->hierarchy_id, name_buf);
 	}
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 	kfree(name_buf);
 	return 0;
-- 
2.34.1


