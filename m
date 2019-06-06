Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9381237070
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Jun 2019 11:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfFFJnS (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 6 Jun 2019 05:43:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfFFJnS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Jun 2019 05:43:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D069307C941;
        Thu,  6 Jun 2019 09:43:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69D78679F1;
        Thu,  6 Jun 2019 09:43:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/10] block: Add block layer notifications [ver #3]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jun 2019 10:43:14 +0100
Message-ID: <155981419467.17513.4571857983219270447.stgit@warthog.procyon.org.uk>
In-Reply-To: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
References: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 06 Jun 2019 09:43:17 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a block layer notification mechanism whereby notifications about
block-layer events such as I/O errors, can be reported to a monitoring
process asynchronously.

Firstly, an event queue needs to be created:

	fd = open("/dev/event_queue", O_RDWR);
	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, page_size << n);

then a notification can be set up to report block notifications via that
queue:

	struct watch_notification_filter filter = {
		.nr_filters = 1,
		.filters = {
			[0] = {
				.type = WATCH_TYPE_BLOCK_NOTIFY,
				.subtype_filter[0] = UINT_MAX;
			},
		},
	};
	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
	device_notify(fd, 12);

After that, records will be placed into the queue when, for example, errors
occur on a block device.  Records are of the following format:

	struct block_notification {
		struct watch_notification watch;
		__u64	dev;
		__u64	sector;
	} *n;

Where:

	n->watch.type will be WATCH_TYPE_BLOCK_NOTIFY

	n->watch.subtype will be the type of notification, such as
	NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM.

	n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
	record.

	n->watch.info & WATCH_INFO_ID will be the second argument to
	device_notify(), shifted.

	n->dev will be the device numbers munged together.

	n->sector will indicate the affected sector (if appropriate for the
	event).

Note that it is permissible for event records to be of variable length -
or, at least, the length may be dependent on the subtype.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/watch_queue.rst    |   10 +++++++++-
 block/Kconfig                    |    9 +++++++++
 block/blk-core.c                 |   29 +++++++++++++++++++++++++++++
 include/linux/blkdev.h           |   15 +++++++++++++++
 include/uapi/linux/watch_queue.h |   27 +++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index e4b8233d5aa8..c2954e191989 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -11,7 +11,9 @@ receive notifications from the kernel.  This can be used in conjunction with::
 
   * Superblock event notifications
 
-  * General device event notifications
+  * General device event notifications, including::
+
+    * Block layer event notifications
 
 
 The notifications buffers can be enabled by:
@@ -336,6 +338,12 @@ Any particular buffer can be fed from multiple sources.  Sources include:
 
     See Documentation/security/keys/core.rst for more information.
 
+  * WATCH_TYPE_BLOCK_NOTIFY
+
+    Notifications of this type indicate block layer events, such as I/O errors
+    or temporary link loss.  Watchpoints of this type are set on the global
+    device watch list.
+
 
 Event Filtering
 ===============
diff --git a/block/Kconfig b/block/Kconfig
index 1b220101a9cb..4ff4a56ba9f9 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -163,6 +163,15 @@ config BLK_SED_OPAL
 	Enabling this option enables users to setup/unlock/lock
 	Locking ranges for SED devices using the Opal protocol.
 
+config BLK_NOTIFICATIONS
+	bool "Block layer event notifications"
+	select DEVICE_NOTIFICATIONS
+	help
+	  This option provides support for getting block layer event
+	  notifications.  This makes use of the /dev/watch_queue misc device to
+	  handle the notification buffer and provides the device_notify() system
+	  call to enable/disable watches.
+
 menu "Partition Types"
 
 source "block/partitions/Kconfig"
diff --git a/block/blk-core.c b/block/blk-core.c
index 419d600e6637..edad86172d47 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -144,6 +144,22 @@ static const struct {
 	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
 };
 
+#ifdef CONFIG_BLK_NOTIFICATIONS
+static const
+enum block_notification_type blk_notifications[ARRAY_SIZE(blk_errors)] = {
+	[BLK_STS_TIMEOUT]	= NOTIFY_BLOCK_ERROR_TIMEOUT,
+	[BLK_STS_NOSPC]		= NOTIFY_BLOCK_ERROR_NO_SPACE,
+	[BLK_STS_TRANSPORT]	= NOTIFY_BLOCK_ERROR_RECOVERABLE_TRANSPORT,
+	[BLK_STS_TARGET]	= NOTIFY_BLOCK_ERROR_CRITICAL_TARGET,
+	[BLK_STS_NEXUS]		= NOTIFY_BLOCK_ERROR_CRITICAL_NEXUS,
+	[BLK_STS_MEDIUM]	= NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM,
+	[BLK_STS_PROTECTION]	= NOTIFY_BLOCK_ERROR_PROTECTION,
+	[BLK_STS_RESOURCE]	= NOTIFY_BLOCK_ERROR_KERNEL_RESOURCE,
+	[BLK_STS_DEV_RESOURCE]	= NOTIFY_BLOCK_ERROR_DEVICE_RESOURCE,
+	[BLK_STS_IOERR]		= NOTIFY_BLOCK_ERROR_IO,
+};
+#endif
+
 blk_status_t errno_to_blk_status(int errno)
 {
 	int i;
@@ -179,6 +195,19 @@ static void print_req_error(struct request *req, blk_status_t status)
 				req->rq_disk ?  req->rq_disk->disk_name : "?",
 				(unsigned long long)blk_rq_pos(req),
 				req->cmd_flags);
+
+#ifdef CONFIG_BLK_NOTIFICATIONS
+	if (blk_notifications[idx]) {
+		struct block_notification n = {
+			.watch.type	= WATCH_TYPE_BLOCK_NOTIFY,
+			.watch.subtype	= blk_notifications[idx],
+			.watch.info	= sizeof(n),
+			.dev		= req->rq_disk ? disk_devt(req->rq_disk) : 0,
+			.sector		= blk_rq_pos(req),
+		};
+		post_block_notification(&n);
+	}
+#endif
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1aafeb923e7b..8b8e235f47c9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -43,6 +43,7 @@ struct pr_ops;
 struct rq_qos;
 struct blk_queue_stats;
 struct blk_stat_callback;
+struct block_notification;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
@@ -1744,6 +1745,20 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+#ifdef CONFIG_BLK_NOTIFICATIONS
+static inline void post_block_notification(struct block_notification *n)
+{
+	u64 id = 0; /* Might want to allow dev# here. */
+
+	post_device_notification(&n->watch, id);
+}
+#else
+static inline void post_block_notification(struct block_notification *n)
+{
+}
+#endif
+
+
 #else /* CONFIG_BLOCK */
 
 struct block_device;
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index aeffcfd7a742..22e3326b83a6 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -155,4 +155,31 @@ struct superblock_error_notification {
 	__u32	error_cookie;
 };
 
+/*
+ * Type of block layer notification.
+ */
+enum block_notification_type {
+	NOTIFY_BLOCK_ERROR_TIMEOUT		= 1, /* Timeout error */
+	NOTIFY_BLOCK_ERROR_NO_SPACE		= 2, /* Critical space allocation error */
+	NOTIFY_BLOCK_ERROR_RECOVERABLE_TRANSPORT = 3, /* Recoverable transport error */
+	NOTIFY_BLOCK_ERROR_CRITICAL_TARGET	= 4, /* Critical target error */
+	NOTIFY_BLOCK_ERROR_CRITICAL_NEXUS	= 5, /* Critical nexus error */
+	NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM	= 6, /* Critical medium error */
+	NOTIFY_BLOCK_ERROR_PROTECTION		= 7, /* Protection error */
+	NOTIFY_BLOCK_ERROR_KERNEL_RESOURCE	= 8, /* Kernel resource error */
+	NOTIFY_BLOCK_ERROR_DEVICE_RESOURCE	= 9, /* Device resource error */
+	NOTIFY_BLOCK_ERROR_IO			= 10, /* Other I/O error */
+};
+
+/*
+ * Block layer notification record.
+ * - watch.type = WATCH_TYPE_BLOCK_NOTIFY
+ * - watch.subtype = enum block_notification_type
+ */
+struct block_notification {
+	struct watch_notification watch; /* WATCH_TYPE_BLOCK_NOTIFY */
+	__u64	dev;			/* Device number */
+	__u64	sector;			/* Affected sector */
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */

