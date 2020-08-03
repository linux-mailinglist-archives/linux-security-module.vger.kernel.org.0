Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1BF23A7A2
	for <lists+linux-security-module@lfdr.de>; Mon,  3 Aug 2020 15:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHCNh0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 3 Aug 2020 09:37:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22789 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726980AbgHCNhZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Aug 2020 09:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596461844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hU8iaSfxMsw9XkGj0tIpB78lpCOjCybB82gxIiAzFJ8=;
        b=gOvaAsMvqm7J7PNyhrjsMneNtErJYoIO29TAx7bIWIVJYZO3ExRD/4vEa0i9LMZhC3jI67
        /bth8C9WDD1e7QJTfYq1et7cTrDd5ZHV08Gc2HBVde1gFEQp6ijq7l9ujUbiHrNxPaa/Os
        syyFWCYoD1e4zxWSHK1OOgHLkAeSM8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-vyGcwsMZMMCSNlPiAT5O1g-1; Mon, 03 Aug 2020 09:37:21 -0400
X-MC-Unique: vyGcwsMZMMCSNlPiAT5O1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDF57107BEF9;
        Mon,  3 Aug 2020 13:37:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EC5160C47;
        Mon,  3 Aug 2020 13:37:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/18] fsinfo: Add a uniquifier ID to struct mount [ver #21]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 14:37:16 +0100
Message-ID: <159646183662.1784947.5709738540440380373.stgit@warthog.procyon.org.uk>
In-Reply-To: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a uniquifier ID to struct mount that is effectively unique over the
kernel lifetime to deal around mnt_id values being reused.  This can then
be exported through fsinfo() to allow detection of replacement mounts that
happen to end up with the same mount ID.

The normal mount handle is still used for referring to a particular mount.

The mount notification is then changed to convey these unique mount IDs
rather than the mount handle.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/mount.h        |    3 +++
 fs/mount_notify.c |    4 ++--
 fs/namespace.c    |    3 +++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 85456a5f5a3a..1037781be055 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -79,6 +79,9 @@ struct mount {
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
 	struct hlist_head mnt_stuck_children;
+#ifdef CONFIG_FSINFO
+	u64	mnt_unique_id;		/* ID unique over lifetime of kernel */
+#endif
 #ifdef CONFIG_MOUNT_NOTIFICATIONS
 	struct watch_list *mnt_watchers; /* Watches on dentries within this mount */
 #endif
diff --git a/fs/mount_notify.c b/fs/mount_notify.c
index 44f570e4cebe..d8ba66ed5f77 100644
--- a/fs/mount_notify.c
+++ b/fs/mount_notify.c
@@ -90,7 +90,7 @@ void notify_mount(struct mount *trigger,
 	n.watch.type	= WATCH_TYPE_MOUNT_NOTIFY;
 	n.watch.subtype	= subtype;
 	n.watch.info	= info_flags | watch_sizeof(n);
-	n.triggered_on	= trigger->mnt_id;
+	n.triggered_on	= trigger->mnt_unique_id;
 
 	switch (subtype) {
 	case NOTIFY_MOUNT_EXPIRY:
@@ -102,7 +102,7 @@ void notify_mount(struct mount *trigger,
 	case NOTIFY_MOUNT_UNMOUNT:
 	case NOTIFY_MOUNT_MOVE_FROM:
 	case NOTIFY_MOUNT_MOVE_TO:
-		n.auxiliary_mount	= aux->mnt_id;
+		n.auxiliary_mount = aux->mnt_unique_id;
 		break;
 
 	default:
diff --git a/fs/namespace.c b/fs/namespace.c
index b2b9920ffd3c..1db8a64cd76f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -115,6 +115,9 @@ static int mnt_alloc_id(struct mount *mnt)
 	if (res < 0)
 		return res;
 	mnt->mnt_id = res;
+#ifdef CONFIG_FSINFO
+	mnt->mnt_unique_id = atomic64_inc_return(&vfs_unique_counter);
+#endif
 	return 0;
 }
 


