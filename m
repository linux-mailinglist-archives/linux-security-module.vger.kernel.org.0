Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7CDD341D
	for <lists+linux-security-module@lfdr.de>; Fri, 11 Oct 2019 01:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfJJXAe (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 10 Oct 2019 19:00:34 -0400
Received: from namei.org ([65.99.196.166]:53540 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfJJXAe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Oct 2019 19:00:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x9AN0Xil009597
        for <linux-security-module@vger.kernel.org>; Thu, 10 Oct 2019 23:00:33 GMT
Date:   Fri, 11 Oct 2019 10:00:33 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     linux-security-module@vger.kernel.org
Subject: shmem: fix LSM options parsing (fwd)
Message-ID: <alpine.LRH.2.21.1910111000260.9215@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

---------- Forwarded message ----------
Date: Thu, 10 Oct 2019 15:42:18 +0000
From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Al Viro <viro@zeniv.linux.org.uk>
To: git-commits-head@vger.kernel.org
Subject: shmem: fix LSM options parsing

Commit:     33f37c648812bdbe1bd1eea75ddab3e799d51e77
Parent:     a3bc18a48e2e678efe62f1f9989902f9cd19e0ff
Refname:    refs/heads/master
Web:        https://git.kernel.org/torvalds/c/33f37c648812bdbe1bd1eea75ddab3e799d51e77
Author:     Al Viro <viro@zeniv.linux.org.uk>
AuthorDate: Wed Oct 9 22:48:01 2019 -0400
Committer:  Al Viro <viro@zeniv.linux.org.uk>
CommitDate: Wed Oct 9 22:48:01 2019 -0400

    shmem: fix LSM options parsing
    
    ->parse_monolithic() there forgets to call security_sb_eat_lsm_opts()
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/shmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0f7fd4a85db6..8dcc8d04cbaf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3482,6 +3482,12 @@ static int shmem_parse_options(struct fs_context *fc, void *data)
 {
 	char *options = data;
 
+	if (options) {
+		int err = security_sb_eat_lsm_opts(options, &fc->security);
+		if (err)
+			return err;
+	}
+
 	while (options != NULL) {
 		char *this_char = options;
 		for (;;) {
