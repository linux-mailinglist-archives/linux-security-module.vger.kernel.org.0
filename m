Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492A369B0C4
	for <lists+linux-security-module@lfdr.de>; Fri, 17 Feb 2023 17:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBQQY7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 17 Feb 2023 11:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjBQQYv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Feb 2023 11:24:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627BF6EF2A
        for <linux-security-module@vger.kernel.org>; Fri, 17 Feb 2023 08:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FVuEhhYScOgrQqnypKq2VFgUAU8z41nhpw8bLy+N1Yw=;
        b=g2VYfU8l/3RI2Kdaa2jQvuvlwybHC5n+h05ikj65HNlRYFKDHkynLhRn3DlYGl/6HAfE6c
        KF0v1hnr7tftElnmw391T7EWtsNnFnroMwxcVsy2PUOqLC4nRGrvoSyMQNeOG+0i93VpFk
        5CuwI6ow+QFdqRPZVk6t5buMhEr1OPw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-nfvAdyGVPyic0BQg8CktUA-1; Fri, 17 Feb 2023 11:21:59 -0500
X-MC-Unique: nfvAdyGVPyic0BQg8CktUA-1
Received: by mail-ed1-f69.google.com with SMTP id z17-20020a05640240d100b004acc6cf6322so2581614edb.18
        for <linux-security-module@vger.kernel.org>; Fri, 17 Feb 2023 08:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVuEhhYScOgrQqnypKq2VFgUAU8z41nhpw8bLy+N1Yw=;
        b=H3h0ZE0SU3OgksWOQU+JAuXVS581TadhEEARAzsjn9nCILaRCRyWLnTy8e1GseHW/S
         vvsbGVy8fJ1kiPr5MbkjcLQVflZ2MA//nBK/TfHDMDsMNSCMCg+ixmyh5cwXN7kNRQX2
         w/LfZIoWbMsID/xIuDsKBf45p3C13cbbBQex0HvwKxLr1Vo/E9BuyBjwmLInkc12XZpb
         kQbwbdZYj2NbDulSKUrYyuhTSWhKqUVCQVw3F9hqQmIPiifqyAw1vzv2IrN5aAhoPJie
         P6d1y8aLLVcuhY9chDiXAfUzkdjrj/wZ6kr6PzTXrMPAhquZmcLDxhcu+kaVILuvQAds
         utvA==
X-Gm-Message-State: AO0yUKW3jEmKOqFk9mY/Fb9UCwCNAROCOeXPqEf94ZhfP/+nL+gTL0d0
        l4AWY1mq/MJ3URPqoFffWYXWumr/qjVLX6s8MmcsLnKaQdQrfUB9jZQhF9mawny++KrSlomYi3+
        LsUeNOB7nGzu/RFbmGhhgMpjtCb6GlqWKzCtn
X-Received: by 2002:a17:907:a04f:b0:88b:23bb:e61f with SMTP id gz15-20020a170907a04f00b0088b23bbe61fmr600696ejc.25.1676650918323;
        Fri, 17 Feb 2023 08:21:58 -0800 (PST)
X-Google-Smtp-Source: AK7set+2V1s8Vrcaw1IdncZUIDiJtFhF0s+J+nN3KbpRNbsOqBYYFZYQf7nMroPkCGG4qrSwQIuMIA==
X-Received: by 2002:a17:907:a04f:b0:88b:23bb:e61f with SMTP id gz15-20020a170907a04f00b0088b23bbe61fmr600677ejc.25.1676650918056;
        Fri, 17 Feb 2023 08:21:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906539700b008b128106fc7sm2293812ejo.46.2023.02.17.08.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 08:21:57 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()
Date:   Fri, 17 Feb 2023 17:21:54 +0100
Message-Id: <20230217162154.837549-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Linux Security Modules (LSMs) that implement the "capable" hook will
usually emit an access denial message to the audit log whenever they
"block" the current task from using the given capability based on their
security policy.

The occurrence of a denial is used as an indication that the given task
has attempted an operation that requires the given access permission, so
the callers of functions that perform LSM permission checks must take
care to avoid calling them too early (before it is decided if the
permission is actually needed to perform the requested operation).

The __sys_setres[ug]id() functions violate this convention by first
calling ns_capable_setid() and only then checking if the operation
requires the capability or not. It means that any caller that has the
capability granted by DAC (task's capability set) but not by MAC (LSMs)
will generate a "denied" audit record, even if is doing an operation for
which the capability is not required.

Fix this by reordering the checks such that ns_capable_setid() is
checked last and -EPERM is returned immediately if it returns false.

While there, also do two small optimizations:
* move the capability check before prepare_creds() and
* bail out early in case of a no-op.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2: improve commit message

 kernel/sys.c | 69 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 5fd54bf0e8867..6fd88686cd06f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -664,6 +664,7 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 	struct cred *new;
 	int retval;
 	kuid_t kruid, keuid, ksuid;
+	bool ruid_new, euid_new, suid_new;
 
 	kruid = make_kuid(ns, ruid);
 	keuid = make_kuid(ns, euid);
@@ -678,25 +679,29 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 	if ((suid != (uid_t) -1) && !uid_valid(ksuid))
 		return -EINVAL;
 
+	old = current_cred();
+
+	/* check for no-op */
+	if ((ruid == (uid_t) -1 || uid_eq(kruid, old->uid)) &&
+	    (euid == (uid_t) -1 || (uid_eq(keuid, old->euid) &&
+				    uid_eq(keuid, old->fsuid))) &&
+	    (suid == (uid_t) -1 || uid_eq(ksuid, old->suid)))
+		return 0;
+
+	ruid_new = ruid != (uid_t) -1        && !uid_eq(kruid, old->uid) &&
+		   !uid_eq(kruid, old->euid) && !uid_eq(kruid, old->suid);
+	euid_new = euid != (uid_t) -1        && !uid_eq(keuid, old->uid) &&
+		   !uid_eq(keuid, old->euid) && !uid_eq(keuid, old->suid);
+	suid_new = suid != (uid_t) -1        && !uid_eq(ksuid, old->uid) &&
+		   !uid_eq(ksuid, old->euid) && !uid_eq(ksuid, old->suid);
+	if ((ruid_new || euid_new || suid_new) &&
+	    !ns_capable_setid(old->user_ns, CAP_SETUID))
+		return -EPERM;
+
 	new = prepare_creds();
 	if (!new)
 		return -ENOMEM;
 
-	old = current_cred();
-
-	retval = -EPERM;
-	if (!ns_capable_setid(old->user_ns, CAP_SETUID)) {
-		if (ruid != (uid_t) -1        && !uid_eq(kruid, old->uid) &&
-		    !uid_eq(kruid, old->euid) && !uid_eq(kruid, old->suid))
-			goto error;
-		if (euid != (uid_t) -1        && !uid_eq(keuid, old->uid) &&
-		    !uid_eq(keuid, old->euid) && !uid_eq(keuid, old->suid))
-			goto error;
-		if (suid != (uid_t) -1        && !uid_eq(ksuid, old->uid) &&
-		    !uid_eq(ksuid, old->euid) && !uid_eq(ksuid, old->suid))
-			goto error;
-	}
-
 	if (ruid != (uid_t) -1) {
 		new->uid = kruid;
 		if (!uid_eq(kruid, old->uid)) {
@@ -761,6 +766,7 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 	struct cred *new;
 	int retval;
 	kgid_t krgid, kegid, ksgid;
+	bool rgid_new, egid_new, sgid_new;
 
 	krgid = make_kgid(ns, rgid);
 	kegid = make_kgid(ns, egid);
@@ -773,23 +779,28 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 	if ((sgid != (gid_t) -1) && !gid_valid(ksgid))
 		return -EINVAL;
 
+	old = current_cred();
+
+	/* check for no-op */
+	if ((rgid == (gid_t) -1 || gid_eq(krgid, old->gid)) &&
+	    (egid == (gid_t) -1 || (gid_eq(kegid, old->egid) &&
+				    gid_eq(kegid, old->fsgid))) &&
+	    (sgid == (gid_t) -1 || gid_eq(ksgid, old->sgid)))
+		return 0;
+
+	rgid_new = rgid != (gid_t) -1        && !gid_eq(krgid, old->gid) &&
+		   !gid_eq(krgid, old->egid) && !gid_eq(krgid, old->sgid);
+	egid_new = egid != (gid_t) -1        && !gid_eq(kegid, old->gid) &&
+		   !gid_eq(kegid, old->egid) && !gid_eq(kegid, old->sgid);
+	sgid_new = sgid != (gid_t) -1        && !gid_eq(ksgid, old->gid) &&
+		   !gid_eq(ksgid, old->egid) && !gid_eq(ksgid, old->sgid);
+	if ((rgid_new || egid_new || sgid_new) &&
+	    !ns_capable_setid(old->user_ns, CAP_SETGID))
+		return -EPERM;
+
 	new = prepare_creds();
 	if (!new)
 		return -ENOMEM;
-	old = current_cred();
-
-	retval = -EPERM;
-	if (!ns_capable_setid(old->user_ns, CAP_SETGID)) {
-		if (rgid != (gid_t) -1        && !gid_eq(krgid, old->gid) &&
-		    !gid_eq(krgid, old->egid) && !gid_eq(krgid, old->sgid))
-			goto error;
-		if (egid != (gid_t) -1        && !gid_eq(kegid, old->gid) &&
-		    !gid_eq(kegid, old->egid) && !gid_eq(kegid, old->sgid))
-			goto error;
-		if (sgid != (gid_t) -1        && !gid_eq(ksgid, old->gid) &&
-		    !gid_eq(ksgid, old->egid) && !gid_eq(ksgid, old->sgid))
-			goto error;
-	}
 
 	if (rgid != (gid_t) -1)
 		new->gid = krgid;
-- 
2.39.2

