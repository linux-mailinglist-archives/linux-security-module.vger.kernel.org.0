Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253D95A9B8E
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Sep 2022 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiIAP1B (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 1 Sep 2022 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiIAP0n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Sep 2022 11:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA5A753A0
        for <linux-security-module@vger.kernel.org>; Thu,  1 Sep 2022 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662045997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXJ3eu32792Tz+PNWkqX8ynt0TaLdrtHwSsiZCTO97I=;
        b=RmxIBtrPWjPSI8LfMmWUb1CPTSpIYsbVHse8GE5xBhCcKVuUAKGmNiWnq8kzgjf8KQ+Tbq
        cZfyaGgnZ8D/koONr9zGvuMajS1pVzwKg5KNGXU9P5nVnX3ijKMNwWnAcoGjh4BUXOBRLp
        +Ne9g4L73sLBETtH235QgxspfRaWz6M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-MzH78ZovMZSy3ldZFkZq8g-1; Thu, 01 Sep 2022 11:26:36 -0400
X-MC-Unique: MzH78ZovMZSy3ldZFkZq8g-1
Received: by mail-ej1-f70.google.com with SMTP id ga33-20020a1709070c2100b0074084f48b12so6941625ejc.7
        for <linux-security-module@vger.kernel.org>; Thu, 01 Sep 2022 08:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xXJ3eu32792Tz+PNWkqX8ynt0TaLdrtHwSsiZCTO97I=;
        b=ybw3GaBmuB63JHmJfJaotSohpV2h6MbNxwM7z+0zWPWIDrPsDmzkyvxJjYDOtRdwor
         NAvEbrX3mLwsFhJ8TSua5/bzzO/9tV/wi9Cj878crT4gnFjKNgC/9jMCdYR9Oxun6rLo
         xPrcdyTtp5x+XrrL3uYc0G6OOAb25VGAfKyLN2DfbBbd6Ru77IPXO/2BGVc4lSGOZ3/I
         VOy+qnpOjf54/qNo72wFkCG03RWtvXNIkTHRA4hrDZgBpZJxIkf6oD/B7Oeq3jrvZgZq
         2q57HheSZRK5zxSyB/EnQi4yyS+xUN5SS/X1lgg6uzI+crHTKxJnx3i034L4qkYTumy7
         Berg==
X-Gm-Message-State: ACgBeo0XppcJScRhouiEc+JDKQN9SCwOby6EYyKPVJL2opU7WSLoJZaw
        rZk/F09kWH4OaTSFEw/eWIvVnzObVbZG3Anwa0mfSKYn6UeGDqy01zsX2gbDZchiMyUncm/j11B
        VLbNii4cM4UlTJtATqttNnn8rEik93H/y4Yvj
X-Received: by 2002:a17:906:845c:b0:730:bbf1:196a with SMTP id e28-20020a170906845c00b00730bbf1196amr24608317ejy.13.1662045995426;
        Thu, 01 Sep 2022 08:26:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5FRde2+0Kq+Aw/cF6maS0iAuZMFCEh7wb5iWZ1StV35X9kMHScj7jMEScvxLEBUmONF9VBmg==
X-Received: by 2002:a17:906:845c:b0:730:bbf1:196a with SMTP id e28-20020a170906845c00b00730bbf1196amr24608307ejy.13.1662045995247;
        Thu, 01 Sep 2022 08:26:35 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906775700b00730bfe6adc4sm8646031ejn.37.2022.09.01.08.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:26:34 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
Subject: [PATCH 1/2] fs: convert simple_xattrs to RCU list
Date:   Thu,  1 Sep 2022 17:26:31 +0200
Message-Id: <20220901152632.970018-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901152632.970018-1-omosnace@redhat.com>
References: <20220901152632.970018-1-omosnace@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use the RCU list mechanism instead of a simple lock to access/modify
simple_xattrs. The performance benefit is probably negligible, but it
will help avoid lock nesting concerns for an upcoming patch.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/xattr.c            | 36 ++++++++++++++++++++++--------------
 include/linux/xattr.h |  1 +
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index a1f4998bc6be..fad2344f1168 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -22,6 +22,8 @@
 #include <linux/audit.h>
 #include <linux/vmalloc.h>
 #include <linux/posix_acl_xattr.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
 
 #include <linux/uaccess.h>
 
@@ -1030,8 +1032,8 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 	struct simple_xattr *xattr;
 	int ret = -ENODATA;
 
-	spin_lock(&xattrs->lock);
-	list_for_each_entry(xattr, &xattrs->head, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(xattr, &xattrs->head, list) {
 		if (strcmp(name, xattr->name))
 			continue;
 
@@ -1044,10 +1046,18 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 		}
 		break;
 	}
-	spin_unlock(&xattrs->lock);
+	rcu_read_unlock();
 	return ret;
 }
 
+static void simple_xattr_free_rcu(struct rcu_head *rcu)
+{
+	struct simple_xattr *xattr = container_of(rcu, struct simple_xattr, rcu);
+
+	kfree(xattr->name);
+	kvfree(xattr);
+}
+
 /**
  * simple_xattr_set - xattr SET operation for in-memory/pseudo filesystems
  * @xattrs: target simple_xattr list
@@ -1094,11 +1104,11 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 				xattr = new_xattr;
 				err = -EEXIST;
 			} else if (new_xattr) {
-				list_replace(&xattr->list, &new_xattr->list);
+				list_replace_rcu(&xattr->list, &new_xattr->list);
 				if (removed_size)
 					*removed_size = xattr->size;
 			} else {
-				list_del(&xattr->list);
+				list_del_rcu(&xattr->list);
 				if (removed_size)
 					*removed_size = xattr->size;
 			}
@@ -1109,15 +1119,13 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 		xattr = new_xattr;
 		err = -ENODATA;
 	} else {
-		list_add(&new_xattr->list, &xattrs->head);
+		list_add_rcu(&new_xattr->list, &xattrs->head);
 		xattr = NULL;
 	}
 out:
 	spin_unlock(&xattrs->lock);
-	if (xattr) {
-		kfree(xattr->name);
-		kvfree(xattr);
-	}
+	if (xattr)
+		call_rcu(&xattr->rcu, simple_xattr_free_rcu);
 	return err;
 
 }
@@ -1169,8 +1177,8 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	}
 #endif
 
-	spin_lock(&xattrs->lock);
-	list_for_each_entry(xattr, &xattrs->head, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(xattr, &xattrs->head, list) {
 		/* skip "trusted." attributes for unprivileged callers */
 		if (!trusted && xattr_is_trusted(xattr->name))
 			continue;
@@ -1179,7 +1187,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 		if (err)
 			break;
 	}
-	spin_unlock(&xattrs->lock);
+	rcu_read_unlock();
 
 	return err ? err : size - remaining_size;
 }
@@ -1191,6 +1199,6 @@ void simple_xattr_list_add(struct simple_xattrs *xattrs,
 			   struct simple_xattr *new_xattr)
 {
 	spin_lock(&xattrs->lock);
-	list_add(&new_xattr->list, &xattrs->head);
+	list_add_rcu(&new_xattr->list, &xattrs->head);
 	spin_unlock(&xattrs->lock);
 }
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 979a9d3e5bfb..3236c469aaac 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -86,6 +86,7 @@ struct simple_xattrs {
 
 struct simple_xattr {
 	struct list_head list;
+	struct rcu_head rcu;
 	char *name;
 	size_t size;
 	char value[];
-- 
2.37.2

