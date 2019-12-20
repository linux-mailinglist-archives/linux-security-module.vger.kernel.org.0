Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7962127F93
	for <lists+linux-security-module@lfdr.de>; Fri, 20 Dec 2019 16:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfLTPmQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 20 Dec 2019 10:42:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42577 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfLTPmQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Dec 2019 10:42:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so9816667wro.9
        for <linux-security-module@vger.kernel.org>; Fri, 20 Dec 2019 07:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sAPx/qSpknm81mAjK6n50HYFMwR3Dc07XTjZ/N5q/14=;
        b=CG0ZvaL7Wd/DINrzFx+GeaXy7K63Erl9nn+5LqdgxsYGqiksVxbrDXCAu0fVki91kB
         GtQSHKuvsDqmk2cvFiy4Jmigdc02sK/KydIMyIe9ttsFEfpjkI3RPrpYL/hJjPuoA0N7
         JYlOP0PBy1DmUbV0WL051NdvQkki4QAFHG480=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sAPx/qSpknm81mAjK6n50HYFMwR3Dc07XTjZ/N5q/14=;
        b=ndsBewVRaCOc7LKAk0G6tuHQTR+9beiPZs5EeaFUbbSUYr3lYySme6MSfV1w/M+D5J
         VLaks25BouMPhfuWSAHkLRIOnD4QoLmeAT7RrZ22wYl2j7uksm9WScmGENgR/CmI8QFb
         uOoicLKGrer4HFvTeYVzjqmZkrVCGAh91VEQDg7gAfCz90SpNWR7hv5lyAfnHn/G90Z2
         /TmYxGfJl8PItmn3Gr0s1sNHAgqD8xuaV0aI70TMzn6cBf1PrUjoe8CAJM8NCiHo18X9
         pytcbS6nRjNaDqIRV8E/1L5pTnQhNOHtIkJK7TMwqAqCC1ZaK18KPGEG9Q9wGwvFF9nI
         bXEQ==
X-Gm-Message-State: APjAAAU03SyCWDT64BV+kEBnCu95Vcp2/pFW7rnaMrkJi5R5aHXbNLRG
        nJb4PYoTVbaUPe7joJdc9B7RZg==
X-Google-Smtp-Source: APXvYqxw9sxOQDAQeXYFvHsJkOAe+9rfbeVVbI7uTVCrv/2zfc5kXXzi/J5NgL/9VhQqjLKQZkd8pQ==
X-Received: by 2002:a5d:4045:: with SMTP id w5mr14951352wrp.59.1576856533909;
        Fri, 20 Dec 2019 07:42:13 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:c46b:b838:66cf:6204])
        by smtp.gmail.com with ESMTPSA id x11sm10118062wmg.46.2019.12.20.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:42:13 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v1 08/13] bpf: lsm: Show attached program names in hook read handler.
Date:   Fri, 20 Dec 2019 16:42:03 +0100
Message-Id: <20191220154208.15895-9-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

For inspectability the system administrator should be able to view the
list of active KRSI programs:

   bash # cat /sys/kernel/security/bpf/bprm_check_security
   bpf_prog1

Signed-off-by: KP Singh <kpsingh@google.com>
---
 security/bpf/lsm_fs.c | 81 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/security/bpf/lsm_fs.c b/security/bpf/lsm_fs.c
index b271e9582d0f..01a89bce1347 100644
--- a/security/bpf/lsm_fs.c
+++ b/security/bpf/lsm_fs.c
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/types.h>
 #include <linux/filter.h>
+#include <linux/seq_file.h>
 #include <linux/bpf.h>
 #include <linux/security.h>
 #include <linux/bpf_lsm.h>
@@ -19,7 +20,85 @@
 
 static struct dentry *bpf_lsm_dir;
 
-static const struct file_operations hook_ops = {};
+static void *seq_start(struct seq_file *m, loff_t *pos)
+	__acquires(RCU)
+{
+	struct bpf_prog_array_item *item;
+	struct bpf_prog_array *progs;
+	struct bpf_lsm_hook *h;
+	struct dentry *dentry;
+
+	/*
+	 * rcu_read_lock() must be held before any return statement because the
+	 * stop() will always be called and thus call rcu_read_unlock()
+	 */
+	rcu_read_lock();
+
+	dentry = file_dentry(m->file);
+	h = dentry->d_fsdata;
+	if (WARN_ON(!h))
+		return ERR_PTR(-EFAULT);
+
+	progs = rcu_dereference(h->progs);
+	if (!progs)
+		return NULL;
+
+	/* Assumes that no &dummy_bpf_prog entries exist */
+	if ((*pos) >= bpf_prog_array_length(progs))
+		return NULL;
+
+	item = progs->items + *pos;
+	if (!item->prog)
+		return NULL;
+
+	return item;
+}
+
+static void *seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct bpf_prog_array_item *item = v;
+
+	item++;
+	++*pos;
+
+	if (!item->prog)
+		return NULL;
+
+	return item;
+}
+
+static void seq_stop(struct seq_file *m, void *v)
+	__releases(RCU)
+{
+	rcu_read_unlock();
+}
+
+static int show_prog(struct seq_file *m, void *v)
+{
+	struct bpf_prog_array_item *item = v;
+
+	seq_printf(m, "%s\n", item->prog->aux->name);
+	return 0;
+}
+
+static const struct seq_operations hook_seq_ops = {
+	.show	= show_prog,
+	.start	= seq_start,
+	.next	= seq_next,
+	.stop	= seq_stop,
+};
+
+static int hook_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &hook_seq_ops);
+}
+
+static const struct file_operations hook_ops = {
+	.open		= hook_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
 
 int bpf_lsm_fs_initialized;
 
-- 
2.20.1

