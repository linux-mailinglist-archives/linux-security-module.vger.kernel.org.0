Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7621EB344
	for <lists+linux-security-module@lfdr.de>; Tue,  2 Jun 2020 04:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgFBCPG (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 1 Jun 2020 22:15:06 -0400
Received: from namei.org ([65.99.196.166]:40356 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgFBCPG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Jun 2020 22:15:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0522F4UU012542;
        Tue, 2 Jun 2020 02:15:04 GMT
Date:   Tue, 2 Jun 2020 12:15:04 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL][Security] lockdown: Allow unprivileged users to see
 lockdown status
Message-ID: <alpine.LRH.2.21.2006021212490.12446@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Just one update for the security subsystem: allows unprivileged users to 
see the status of the lockdown feature. From Jeremy Cline.

Please pull.


The following changes since commit 3e27a33932df104f4f9ff811467b0b4ccebde773:

  security: remove duplicated include from security.h (2020-02-21 08:53:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

for you to fetch changes up to 60cf7c5ed5f7087c4de87a7676b8c82d96fd166c:

  lockdown: Allow unprivileged users to see lockdown status (2020-05-14 10:23:05 -0700)

----------------------------------------------------------------
Jeremy Cline (1):
      lockdown: Allow unprivileged users to see lockdown status

 security/lockdown/lockdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---
commit 60cf7c5ed5f7087c4de87a7676b8c82d96fd166c
Author: Jeremy Cline <jcline@redhat.com>
Date:   Thu May 14 10:05:46 2020 -0400

    lockdown: Allow unprivileged users to see lockdown status
    
    A number of userspace tools, such as systemtap, need a way to see the
    current lockdown state so they can gracefully deal with the kernel being
    locked down. The state is already exposed in
    /sys/kernel/security/lockdown, but is only readable by root. Adjust the
    permissions so unprivileged users can read the state.
    
    Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
    Cc: Frank Ch. Eigler <fche@redhat.com>
    Signed-off-by: Jeremy Cline <jcline@redhat.com>
    Signed-off-by: James Morris <jmorris@namei.org>

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 40b790536def..ae594c0a127f 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -175,7 +175,7 @@ static int __init lockdown_secfs_init(void)
 {
 	struct dentry *dentry;
 
-	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
+	dentry = securityfs_create_file("lockdown", 0644, NULL, NULL,
 					&lockdown_ops);
 	return PTR_ERR_OR_ZERO(dentry);
 }
