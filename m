Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE082B26C6
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Nov 2020 22:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgKMVao (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 13 Nov 2020 16:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMVan (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Nov 2020 16:30:43 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70297C08E9AA
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2020 13:30:43 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id a15so3235548qvk.5
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2020 13:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=p9cmsU0CLi5tDhUSce4W56NG03m1gfWpOTNcudHv6mk=;
        b=LntATJHKoayQxbIf2gR5COo4Sh4QVFH+KEfFYss+PxJ1FrYILV6wWxKgLqrrzpV6NS
         Qj1W+q6kBK/CEoHPj8GbX6zf6oWw4JbkXVjpldpgxATqV/7e4r/YwI2UJ5rUYb3RsaJz
         832OUi+U9sdNXVKP5Skc82+awpjfN2yKzrVrQi9ag4qvz5rQV2KMAK2wZZzog5CTujKW
         aKiimqDZn5dqvr/QtQREJuoI0/AIPPZ2IBUnyhPBeMJ+R+uDQr/RRcCFZRyoKpbJds/M
         KDXO5iWVEi1JEKQA15eZ1Q/CRPP94mbzI9xUo7ztaIgX/5w6RD60BDQnrFFMhtvsCyGN
         t4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=p9cmsU0CLi5tDhUSce4W56NG03m1gfWpOTNcudHv6mk=;
        b=h/QGyd9tRyfHQfblYdWXgAGj5lAW/3+a6GUX56hLoFzBWfv+u25UdlyYxj0R/dfvtY
         e2zhsXhveY0UpRuG3RO+G3DFlt55Eof56BY1/WDi+mARYnfgT+g+LIB2ef3+wici96qO
         0swVBCttBXHbp0Xc6R9OdsbdMJ172HKnIX7hqoyDh2itllFW8uKgcQ/tcq4TQsGI07zP
         fUwjdAkZhyhn89GgW+YmnqPd1MF/frnKJXy/Ec9Z/+1+M0EIikQhGyFbam3abv3v7SEC
         3uvGvphHsJGS+RoH6eqIopiUYlxEKQAiXKT/8e/kKKbTg+gYM/XZ7uilZAtcy9VwrgJB
         lJhA==
X-Gm-Message-State: AOAM533o0kbbRiAqrMhIUdDn6dlGp9Zo/NIGf5YkNJjxB2RP87r/jjCX
        O1zKJ9AIGtTQtAmk2i2g19j1
X-Google-Smtp-Source: ABdhPJzAO3kTUUIz6ySjW3XiOLT/TmYChj1SbHd/uzIxPN5qqJk5DRmd3PVoC/4dXeRlBdgEknnhLw==
X-Received: by 2002:a05:6214:1805:: with SMTP id o5mr4484226qvw.41.1605303042527;
        Fri, 13 Nov 2020 13:30:42 -0800 (PST)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id p48sm8060359qtp.67.2020.11.13.13.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 13:30:41 -0800 (PST)
Subject: [PATCH] netlabel: fix an uninitialized warning in
 netlbl_unlabel_staticlist()
From:   Paul Moore <paul@paul-moore.com>
To:     netdev@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Date:   Fri, 13 Nov 2020 16:30:40 -0500
Message-ID: <160530304068.15651.18355773009751195447.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Static checking revealed that a previous fix to
netlbl_unlabel_staticlist() leaves a stack variable uninitialized,
this patches fixes that.

Fixes: 866358ec331f ("netlabel: fix our progress tracking in netlbl_unlabel_staticlist()")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 net/netlabel/netlabel_unlabeled.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index fc55c9116da0..ccb491642811 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1167,7 +1167,7 @@ static int netlbl_unlabel_staticlist(struct sk_buff *skb,
 	u32 skip_bkt = cb->args[0];
 	u32 skip_chain = cb->args[1];
 	u32 skip_addr4 = cb->args[2];
-	u32 iter_bkt, iter_chain, iter_addr4 = 0, iter_addr6 = 0;
+	u32 iter_bkt, iter_chain = 0, iter_addr4 = 0, iter_addr6 = 0;
 	struct netlbl_unlhsh_iface *iface;
 	struct list_head *iter_list;
 	struct netlbl_af4list *addr4;

