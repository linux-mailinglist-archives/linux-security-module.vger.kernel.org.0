Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED2214D03A
	for <lists+linux-security-module@lfdr.de>; Wed, 29 Jan 2020 19:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgA2SQc (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 29 Jan 2020 13:16:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:43232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgA2SQc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Jan 2020 13:16:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3A99EB27D;
        Wed, 29 Jan 2020 18:16:30 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dhowells@redhat.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] security, keys: Optimize barrier usage for Rmw atomic  bitops
Date:   Wed, 29 Jan 2020 10:06:25 -0800
Message-Id: <20200129180625.24486-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

For both set and clear_bit, we can avoid the unnecessary barriers
on non LL/SC architectures, such as x86. Instead, use the
smp_mb__{before,after}_atomic() calls.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 security/keys/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index 671dd730ecfc..ce7b4c22e3c4 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -102,7 +102,7 @@ void key_gc_keytype(struct key_type *ktype)
 
 	key_gc_dead_keytype = ktype;
 	set_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
-	smp_mb();
+	smp_mb__after_atomic();
 	set_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags);
 
 	kdebug("schedule");
@@ -308,7 +308,7 @@ static void key_garbage_collector(struct work_struct *work)
 
 	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_3)) {
 		kdebug("dead wake");
-		smp_mb();
+		smp_mb__before_atomic();
 		clear_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
 		wake_up_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE);
 	}
-- 
2.16.4

