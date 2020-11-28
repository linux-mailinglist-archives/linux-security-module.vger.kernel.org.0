Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5502C73D1
	for <lists+linux-security-module@lfdr.de>; Sat, 28 Nov 2020 23:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbgK1WOj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 28 Nov 2020 17:14:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55612 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390586AbgK1WOe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 28 Nov 2020 17:14:34 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kj83D-0002aM-N8; Sat, 28 Nov 2020 21:46:39 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org, fstests@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 24/38] notify: handle idmapped mounts
Date:   Sat, 28 Nov 2020 22:35:13 +0100
Message-Id: <20201128213527.2669807-25-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
References: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Enable notify implementations to handle idmapped mounts by passing down the
mount's user namespace. If the initial user namespace is passed nothing changes
so non-idmapped mounts will see identical behavior as before.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch introduced

/* v3 */
unchanged
---
 fs/notify/fanotify/fanotify_user.c | 2 +-
 fs/notify/inotify/inotify_user.c   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index de4d01bb1d8d..e3b2cb6a9d81 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -702,7 +702,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 	}
 
 	/* you can only watch an inode if you have read permissions on it */
-	ret = inode_permission(&init_user_ns, path->dentry->d_inode, MAY_READ);
+	ret = inode_permission(mnt_user_ns(path->mnt), path->dentry->d_inode, MAY_READ);
 	if (ret) {
 		path_put(path);
 		goto out;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index e995fd4e4e53..f39f5b81f2b3 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -31,6 +31,7 @@
 #include <linux/wait.h>
 #include <linux/memcontrol.h>
 #include <linux/security.h>
+#include <linux/mount.h>
 
 #include "inotify.h"
 #include "../fdinfo.h"
@@ -343,7 +344,7 @@ static int inotify_find_inode(const char __user *dirname, struct path *path,
 	if (error)
 		return error;
 	/* you can only watch an inode if you have read permissions on it */
-	error = inode_permission(&init_user_ns, path->dentry->d_inode, MAY_READ);
+	error = inode_permission(mnt_user_ns(path->mnt), path->dentry->d_inode, MAY_READ);
 	if (error) {
 		path_put(path);
 		return error;
-- 
2.29.2

