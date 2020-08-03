Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D55223A7AD
	for <lists+linux-security-module@lfdr.de>; Mon,  3 Aug 2020 15:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgHCNhv (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 3 Aug 2020 09:37:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49570 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728115AbgHCNhu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Aug 2020 09:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596461869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dlVU5+GMSrdvCBW+7n3oeDdgAb5ayGjJS8YwidPL448=;
        b=iziosJpN9DA5TYXrQ1J0XuERST6MnKv10bQco6GMk28ftUP/zMoAEzvrXzdo9CVmhFR/VT
        qRVdrsQ7gYZOVaCqepfYsIP64x5aJN+R7MQhKXacyUaLr5cDme4D251Aa1c5uD288D7Q0E
        B0DVupVLbmkRyNQTaN1VIs8t2jJskLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-7Na673rrNVO597M3ba-GGg-1; Mon, 03 Aug 2020 09:37:47 -0400
X-MC-Unique: 7Na673rrNVO597M3ba-GGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97F50800138;
        Mon,  3 Aug 2020 13:37:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 462BE5FC36;
        Mon,  3 Aug 2020 13:37:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/18] watch_queue: Mount event counters [ver #21]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 14:37:42 +0100
Message-ID: <159646186240.1784947.2050531865230554652.stgit@warthog.procyon.org.uk>
In-Reply-To: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add three event counters to each mount object:

 (1) mnt_topology_changes.

     Counts the number of changes to the mount tree topology, including
     addition of new mount objects, removal of mount objects and mount
     objects being moved about.

 (2) mnt_attr_changes.

     Counts the number of changes to a mount object's attributes, such as
     whether or not the device files it contains are interpretable as such.

 (3) mnt_subtree_notifications.

     Counts the number of events within the mount subtree at this point.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/mount.h        |    3 +++
 fs/mount_notify.c |    4 ++++
 2 files changed, 7 insertions(+)

diff --git a/fs/mount.h b/fs/mount.h
index 1037781be055..9758a9fa8f69 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -83,6 +83,9 @@ struct mount {
 	u64	mnt_unique_id;		/* ID unique over lifetime of kernel */
 #endif
 #ifdef CONFIG_MOUNT_NOTIFICATIONS
+	atomic_long_t mnt_topology_changes;	/* Number of topology changes applied */
+	atomic_long_t mnt_attr_changes;		/* Number of attribute changes applied */
+	atomic_long_t mnt_subtree_notifications; /* Number of notifications in subtree */
 	struct watch_list *mnt_watchers; /* Watches on dentries within this mount */
 #endif
 } __randomize_layout;
diff --git a/fs/mount_notify.c b/fs/mount_notify.c
index d8ba66ed5f77..57eebae51cb1 100644
--- a/fs/mount_notify.c
+++ b/fs/mount_notify.c
@@ -61,6 +61,7 @@ static void post_mount_notification(struct mount *changed,
 			cursor.dentry = READ_ONCE(mnt->mnt_mountpoint);
 			mnt = parent;
 			cursor.mnt = &mnt->mnt;
+			atomic_long_inc(&mnt->mnt_subtree_notifications);
 		} else {
 			cursor.dentry = cursor.dentry->d_parent;
 		}
@@ -96,6 +97,7 @@ void notify_mount(struct mount *trigger,
 	case NOTIFY_MOUNT_EXPIRY:
 	case NOTIFY_MOUNT_READONLY:
 	case NOTIFY_MOUNT_SETATTR:
+		atomic_long_inc(&trigger->mnt_attr_changes);
 		break;
 
 	case NOTIFY_MOUNT_NEW_MOUNT:
@@ -103,6 +105,8 @@ void notify_mount(struct mount *trigger,
 	case NOTIFY_MOUNT_MOVE_FROM:
 	case NOTIFY_MOUNT_MOVE_TO:
 		n.auxiliary_mount = aux->mnt_unique_id;
+		atomic_long_inc(&trigger->mnt_topology_changes);
+		atomic_long_inc(&aux->mnt_topology_changes);
 		break;
 
 	default:


