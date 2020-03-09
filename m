Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 343EA17DFB3
	for <lists+linux-security-module@lfdr.de>; Mon,  9 Mar 2020 13:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgCIMRd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 9 Mar 2020 08:17:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52073 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726521AbgCIMRd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Mar 2020 08:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583756252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i32RwNIexlSTGjPdh8V9cz3m8rKQLmmbJ0m7mElrktI=;
        b=jEabYTXk3NnMi0NAy9URjzAnwI1oRE2dQjcZQkuSboOrtLFfeFqKAyOwE/qLXxxRxb3n5v
        kANidRHizt8C9FL5xz4qWuDgdcg52adF6u2ozCZ7vyj9TG0Q7s6C5kPeIMW3NIpUv/Jh8+
        mBRbzY9gtosYE3q39j50+e5dcmhafhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-bIeZIp8RObmFqOx2kn-jCA-1; Mon, 09 Mar 2020 08:17:28 -0400
X-MC-Unique: bIeZIp8RObmFqOx2kn-jCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B3F618A72CA;
        Mon,  9 Mar 2020 12:17:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D328B5D9CA;
        Mon,  9 Mar 2020 12:17:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 01/17] uapi: General notification queue definitions [ver
 #4]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, nicolas.dichtel@6wind.com, raven@themaw.net,
        christian@brauner.io, andres@anarazel.de, jlayton@redhat.com,
        dray@redhat.com, kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 12:17:21 +0000
Message-ID: <158375624103.334846.15282432828559449957.stgit@warthog.procyon.org.uk>
In-Reply-To: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
References: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add UAPI definitions for the general notification queue, including the
following pieces:

 (*) struct watch_notification.

     This is the metadata header for notification messages.  It includes a
     type and subtype that indicate the source of the message
     (eg. WATCH_TYPE_MOUNT_NOTIFY) and the kind of the message
     (eg. NOTIFY_MOUNT_NEW_MOUNT).

     The header also contains an information field that conveys the
     following information:

	- WATCH_INFO_LENGTH.  The size of the entry (entries are variable
          length).

	- WATCH_INFO_ID.  The watch ID specified when the watchpoint was
          set.

	- WATCH_INFO_TYPE_INFO.  (Sub)type-specific information.

	- WATCH_INFO_FLAG_*.  Flag bits overlain on the type-specific
          information.  For use by the type.

     All the information in the header can be used in filtering messages at
     the point of writing into the buffer.

 (*) struct watch_notification_removal

     This is an extended watch-removal notification record that includes an
     'id' field that can indicate the identifier of the object being
     removed if available (for instance, a keyring serial number).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/uapi/linux/watch_queue.h |   55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 include/uapi/linux/watch_queue.h

diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
new file mode 100644
index 000000000000..5f3d21e8a34b
--- /dev/null
+++ b/include/uapi/linux/watch_queue.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_WATCH_QUEUE_H
+#define _UAPI_LINUX_WATCH_QUEUE_H
+
+#include <linux/types.h>
+
+enum watch_notification_type {
+	WATCH_TYPE_META		= 0,	/* Special record */
+	WATCH_TYPE__NR		= 1
+};
+
+enum watch_meta_notification_subtype {
+	WATCH_META_REMOVAL_NOTIFICATION	= 0,	/* Watched object was removed */
+	WATCH_META_LOSS_NOTIFICATION	= 1,	/* Data loss occurred */
+};
+
+/*
+ * Notification record header.  This is aligned to 64-bits so that subclasses
+ * can contain __u64 fields.
+ */
+struct watch_notification {
+	__u32			type:24;	/* enum watch_notification_type */
+	__u32			subtype:8;	/* Type-specific subtype (filterable) */
+	__u32			info;
+#define WATCH_INFO_LENGTH	0x0000007f	/* Length of record */
+#define WATCH_INFO_LENGTH__SHIFT 0
+#define WATCH_INFO_ID		0x0000ff00	/* ID of watchpoint */
+#define WATCH_INFO_ID__SHIFT	8
+#define WATCH_INFO_TYPE_INFO	0xffff0000	/* Type-specific info */
+#define WATCH_INFO_TYPE_INFO__SHIFT 16
+#define WATCH_INFO_FLAG_0	0x00010000	/* Type-specific info, flag bit 0 */
+#define WATCH_INFO_FLAG_1	0x00020000	/* ... */
+#define WATCH_INFO_FLAG_2	0x00040000
+#define WATCH_INFO_FLAG_3	0x00080000
+#define WATCH_INFO_FLAG_4	0x00100000
+#define WATCH_INFO_FLAG_5	0x00200000
+#define WATCH_INFO_FLAG_6	0x00400000
+#define WATCH_INFO_FLAG_7	0x00800000
+};
+
+
+/*
+ * Extended watch removal notification.  This is used optionally if the type
+ * wants to indicate an identifier for the object being watched, if there is
+ * such.  This can be distinguished by the length.
+ *
+ * type -> WATCH_TYPE_META
+ * subtype -> WATCH_META_REMOVAL_NOTIFICATION
+ */
+struct watch_notification_removal {
+	struct watch_notification watch;
+	__u64	id;		/* Type-dependent identifier */
+};
+
+#endif /* _UAPI_LINUX_WATCH_QUEUE_H */


