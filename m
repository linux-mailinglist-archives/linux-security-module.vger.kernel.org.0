Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5103F6BD069
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Mar 2023 14:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCPNIr (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 16 Mar 2023 09:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCPNIp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Mar 2023 09:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1398313DDC
        for <linux-security-module@vger.kernel.org>; Thu, 16 Mar 2023 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678972076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=I4vj27Hz37BxjdFryH4DTKt4lnMon3Rk+vYNnIOGHac=;
        b=TfClJtNeoHQCkDiy/LeFQu8HpUrR3WcrpbKDwJkU00RuZp7HZHlofIwDh0vF11uEiATl8P
        f9zpkiPQ8r18+z8wKDPxpmkUavZCwC+j1OeC4uqebDApqEEoLRbc8UJOkqYLghmAXHYpc/
        KTSS+3aHTRmEQzm5/WGjjNRepkpx7l4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-ALSEWPEEPdecTV2xg1YVoQ-1; Thu, 16 Mar 2023 09:07:54 -0400
X-MC-Unique: ALSEWPEEPdecTV2xg1YVoQ-1
Received: by mail-wm1-f71.google.com with SMTP id j6-20020a05600c1c0600b003eaf882cb85so631284wms.9
        for <linux-security-module@vger.kernel.org>; Thu, 16 Mar 2023 06:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678972073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4vj27Hz37BxjdFryH4DTKt4lnMon3Rk+vYNnIOGHac=;
        b=hqTq3/DHZlUqu1krzMTE8IS9AS/ls7RLde4QVHcFxaQHi+Q/7w+ebbTjkRRkFJmJUi
         oHycyRkyKUuYNCLV2xTpj0s9L8fq1x2WfiprnVaPHfzSRJ0642Og5mw6/jbz00mtd93Q
         3Q0x7kXlFWkpDM3e/Wfm99ivYMdSIZqwQqN68EHMggp9QQhifFXzeGb7nrXBU3WMrnUr
         /9RcVzd50eH78iWSEfyJK65In4q8FHNMb1wTk0YNlYiJZXHWApJbA2PjM5ZQlszvC0H4
         XRbtVBlF1M3s9HVd3QSscQ0KpcUuBbKaE3TtaPGHMfVgln1jfec1jUyLu0jqxsCXhxiU
         d6TQ==
X-Gm-Message-State: AO0yUKW+oOxi5SZzPT/mFNGcpwcIsXi1Tfnzj022kU9FOwnfu9cCEN+G
        1eZI2ghgHoiRl+avBN3Y6KKYjfALVYLVbe9qf9VJlf5F1XaDr9Kt5Qw/nM2Xks3iDasOHJ8oorg
        A9J7LR/dK/VTtG730R8qX3thRbxLD6K4gfoPD
X-Received: by 2002:adf:e8cd:0:b0:2ca:175b:d850 with SMTP id k13-20020adfe8cd000000b002ca175bd850mr4240829wrn.11.1678972073782;
        Thu, 16 Mar 2023 06:07:53 -0700 (PDT)
X-Google-Smtp-Source: AK7set9LHvhEZrQSzipUnLqiW/wptvdsDgTL4g6HkRzIVhGziWAGhpLTd6aBZEyk2PFeQSTNEnBmJA==
X-Received: by 2002:adf:e8cd:0:b0:2ca:175b:d850 with SMTP id k13-20020adfe8cd000000b002ca175bd850mr4240814wrn.11.1678972073510;
        Thu, 16 Mar 2023 06:07:53 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d4888000000b002d1959d2cf7sm2451012wrq.111.2023.03.16.06.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:07:52 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH RESEND] fs_context: drop the unused lsm_flags member
Date:   Thu, 16 Mar 2023 14:07:51 +0100
Message-Id: <20230316130751.334227-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This isn't ever used by VFS now, and it couldn't even work. Any FS that
uses the SECURITY_LSM_NATIVE_LABELS flag needs to also process the
value returned back from the LSM, so it needs to do its
security_sb_set_mnt_opts() call on its own anyway.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Resending because of no response for almost 2 years...

Previous submission:
https://lore.kernel.org/linux-fsdevel/20210409111234.271707-1-omosnace@redhat.com/

 Documentation/filesystems/mount_api.rst | 1 -
 fs/nfs/super.c                          | 3 ---
 include/linux/fs_context.h              | 1 -
 include/linux/security.h                | 2 +-
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index 63204d2094fdf..9aaf6ef75eb53 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -79,7 +79,6 @@ context.  This is represented by the fs_context structure::
 		unsigned int		sb_flags;
 		unsigned int		sb_flags_mask;
 		unsigned int		s_iflags;
-		unsigned int		lsm_flags;
 		enum fs_context_purpose	purpose:8;
 		...
 	};
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 05ae23657527d..397c096d874eb 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1274,9 +1274,6 @@ int nfs_get_tree_common(struct fs_context *fc)
 		if (ctx->clone_data.sb->s_flags & SB_SYNCHRONOUS)
 			fc->sb_flags |= SB_SYNCHRONOUS;
 
-	if (server->caps & NFS_CAP_SECURITY_LABEL)
-		fc->lsm_flags |= SECURITY_LSM_NATIVE_LABELS;
-
 	/* Get a superblock - note that we may end up sharing one that already exists */
 	fc->s_fs_info = server;
 	s = sget_fc(fc, compare_super, nfs_set_super);
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 5469ffee21c73..ff6341e09925b 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -104,7 +104,6 @@ struct fs_context {
 	unsigned int		sb_flags;	/* Proposed superblock flags (SB_*) */
 	unsigned int		sb_flags_mask;	/* Superblock flags that were changed */
 	unsigned int		s_iflags;	/* OR'd with sb->s_iflags */
-	unsigned int		lsm_flags;	/* Information flags from the fs to the LSM */
 	enum fs_context_purpose	purpose:8;
 	enum fs_context_phase	phase:8;	/* The phase the context is in */
 	bool			need_free:1;	/* Need to call ops->free() */
diff --git a/include/linux/security.h b/include/linux/security.h
index 5984d0d550b41..db9b659b02b91 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -68,7 +68,7 @@ struct watch_notification;
 /* If capable is being called by a setid function */
 #define CAP_OPT_INSETID BIT(2)
 
-/* LSM Agnostic defines for fs_context::lsm_flags */
+/* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
 #define SECURITY_LSM_NATIVE_LABELS	1
 
 struct ctl_table;
-- 
2.39.2

