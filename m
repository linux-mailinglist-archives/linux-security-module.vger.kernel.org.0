Return-Path: <linux-security-module+bounces-14912-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NPaIFCpn2mddAQAu9opvQ
	(envelope-from <linux-security-module+bounces-14912-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Thu, 26 Feb 2026 03:00:48 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F7F19FFA3
	for <lists+linux-security-module@lfdr.de>; Thu, 26 Feb 2026 03:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 891F53015711
	for <lists+linux-security-module@lfdr.de>; Thu, 26 Feb 2026 02:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EF1376462;
	Thu, 26 Feb 2026 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="K/dmU9pP"
X-Original-To: linux-security-module@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8F17A2EA;
	Thu, 26 Feb 2026 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071240; cv=none; b=ItvpIPsM9BNNMoI9/LRqz65GyZWPAONI/1QF9Ry/kR3sbezUkqHBzpp42XPxO/T1wWZvkBTI+onIdIDusg7BTidijwsy3xg1Wn8cWKIYqnb87Wgii1BNeh3YCL+sM6x5MGn/n6HRp6pnb90O7xJ3dDA17t/m/N383lWS5vm6G9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071240; c=relaxed/simple;
	bh=VWCcVP0bFtCwTr/zL6R2wbnPAoIRNzWKKeyKEW0sphA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rq5v2xkFUYBTbPOm42xOgZr1GM2HnR6pqLAoome9jBuRcYmk0e2sGTxwwkcNp+SkJn4ZurePyiS/PFGw7PF6MkeyiFcF720+NhrYCPIZHGeoekgLPi3ujt3Sv4xSKPq/+gdu0IvzTO/AA4g2FJ3F4DRk2SYS+DgqnsrQ+HfY7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=K/dmU9pP; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772071178;
	bh=g6Gax2GkxNxBm8UMC3q+9IbEHTMf9yW7D3HyhQCot6E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=K/dmU9pP49IRJYTBRlBGByYQa369ZQGu3eGENzXlfsseMkdY5uYt75JjAUnm32GCI
	 /+ZqjcQxI9gQYKfOgNNXdYNUUZXMigaUeD/06GUY/04HM+OVmeHGNsbXhFNFGvtW6e
	 QPky7P8V/K5okXH/h1M9S8JlNNdWnHM+XOeTOnNA=
X-QQ-mid: esmtpgz13t1772071162tfe91df3b
X-QQ-Originating-IP: g2gLZYG8S9sd9DL9x5IeSITYFQ4aevB0XCRRtj7QHfM=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Feb 2026 09:59:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9016088695343040984
EX-QQ-RecipientCnt: 8
From: Yihan Ding <dingyihan@uniontech.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com,
	Yihan Ding <dingyihan@uniontech.com>
Subject: [PATCH v3 1/2] landlock: Serialize TSYNC thread restriction
Date: Thu, 26 Feb 2026 09:59:02 +0800
Message-Id: <20260226015903.3158620-2-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260226015903.3158620-1-dingyihan@uniontech.com>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OMQrLjQu6P6m+XZHISugKMR5DIJezTgUzYaCMlp5fIJ9+PyzYkp9077C
	FSUBfGeGFq+gJ+ky7HYRAzL1Ar3hpw9p5fZcQ64JZegyjP9znyIK3st0X5ybWgjoqCxBl+n
	KKs+ncxozdhvgHokNgwiOgnlzsEBd99ziH4GW9K2E9oWLBCT8IUPqAmBGz7c4bLd0R19C96
	+j8YPD+yHGvlont4FmEx+tZNP2/GiKzwUxZ1RdX6+ruXSyqkc1rs0018AJa/B7Mx3SEfdo2
	FZJpCopVy1otRnCN2aPGH+3tLUlWdgBRBFYo0u4l/DlzKufWhyjAJCe4PmcEpiK9n9kFafp
	tqBWtmkVXk47L996iUKbIZVqruX0giuWyOE0hmA0OfKJd/eprFrn98oxf23Hl3NpstWzaWR
	85x1QPfF6MnkSUGGgjLXUJf4hbc1epAm8gpWnYQ3WBr7o9G4ZOb6OAcXw07JP3vbYOn5xWN
	jlIhFM93JOEHMkxPjaSSC5c9XehCe7dDJPDp/zusaDN9KlP3Rn6xrANBznS2KpZNj6pyp3w
	rCAOSfx9QGO+WwxSjogUrp0RVlX4q7asJS4V/Qlqjwa/PCIe+rHP34EoMaP1urWdr94IV6y
	OOmiF9YK5ilqzgl5h38Sxi+WCTF7b+37eolFfdhDNXXbIdTGw+UC324Fopr6D0vrkCAmqHd
	sKMwq9Mqi/dEOiKlGlCDpO41gcd8050DHOLYi7I1sNgQopixJXJ+BAT/nlRpoQPVg98raLA
	PEX2UUUH/dZbBKTar+XBBe2gMI/0yjdsh+OWoT+PbJkVnXezIg0kC9LlaX3B8BHYuH3L8s/
	IW4VwUYCbFv23gAs5Nb6YNSkDQMvpxNqdIEDB1b/8pn7DKxpJ2voll/5NxM2qdN3WqdjUBj
	XO/fsH4AZV9yIXOxPnu7zERdaTE/0ZwamgB27yGUYgXRtNiev2BbWi5aVRoqHZ2anqa2t1o
	qMeXnlHjD4M1RGdv6lMFWENQBrUiknBrMk3xdTGGzTOQDoHfSuuupsW2tDn94xBUibpdQjB
	gBTH+NyEbqZBncH8wHFtI/ki5C6UHgE5J/fvV/e/gXwzDo66i8tORkd3HZGso=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14912-lists,linux-security-module=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[digikod.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dingyihan@uniontech.com,linux-security-module@vger.kernel.org];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-security-module,7ea2f5e9dfd468201817];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,uniontech.com:mid,uniontech.com:dkim,uniontech.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: D9F7F19FFA3
X-Rspamd-Action: no action

syzbot found a deadlock in landlock_restrict_sibling_threads().
When multiple threads concurrently call landlock_restrict_self() with
sibling thread restriction enabled, they can deadlock by mutually
queueing task_works on each other and then blocking in kernel space
(waiting for the other to finish).

Fix this by serializing the TSYNC operations within the same process
using the exec_update_lock. This prevents concurrent invocations
from deadlocking. 

We use down_write_trylock() and return -ERESTARTNOINTR if the lock
cannot be acquired immediately. This ensures that if a thread fails
to get the lock, it will return to userspace, allowing it to process
any pending TSYNC task_works from the lock holder, and then
transparently restart the syscall.

Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
Suggested-by: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
---
Changes in v3:
- Replaced down_write_killable() with down_write_trylock() and 
  returned -ERESTARTNOINTR to avoid a secondary deadlock caused by 
  blocking the execution of task_works. (Caught by Günther Noack).

Changes in v2:
- Use down_write_killable() instead of down_write().
- Split the interrupt path cleanup into a separate patch.
---
 security/landlock/tsync.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index de01aa899751..xxxxxxxxxxxx 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 	shared_ctx.new_cred = new_cred;
 	shared_ctx.set_no_new_privs = task_no_new_privs(current);
 
+	/*
+	 * Serialize concurrent TSYNC operations to prevent deadlocks
+	 * when multiple threads call landlock_restrict_self() simultaneously.
+	 */
+	if (!down_write_trylock(&current->signal->exec_update_lock))
+		return -ERESTARTNOINTR;
+
 	/*
 	 * We schedule a pseudo-signal task_work for each of the calling task's
 	 * sibling threads.  In the task work, each thread:
@@ -556,6 +563,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 		wait_for_completion(&shared_ctx.all_finished);
 
 	tsync_works_release(&works);
+	up_write(&current->signal->exec_update_lock);
 
 	return atomic_read(&shared_ctx.preparation_error);
 }
-- 
2.51.0


