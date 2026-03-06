Return-Path: <linux-security-module+bounces-15347-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOZxLKQ5qmnUNQEAu9opvQ
	(envelope-from <linux-security-module+bounces-15347-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Fri, 06 Mar 2026 03:19:16 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1215A21A8AC
	for <lists+linux-security-module@lfdr.de>; Fri, 06 Mar 2026 03:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37A6B305B44E
	for <lists+linux-security-module@lfdr.de>; Fri,  6 Mar 2026 02:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11443328E3;
	Fri,  6 Mar 2026 02:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="djX3wARl"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7537317715;
	Fri,  6 Mar 2026 02:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763499; cv=none; b=mq7XgYmFTS4IA2wlHIcHK7I9ms07W9CJUcTojUwsBnLdCgR2kwHX0SifKxDZaDLb0lKc85XgYfVyER9Xeuee8w68vaHTjgnb4Dxlm24B8157U/XzeUAlTKT2mBbsP33WbDG22og+Dae4EaeeDhp+CH2AzHJUvtNsWK+8E4zA1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763499; c=relaxed/simple;
	bh=JIIsENqr+ijZqwesf9PmBThzsFa2kfYIQ+aD5452FTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qDr7LVbwAQD5Cka3pUdKodXG/QGXJD1NMXy9oFYFeFpDRs4FZLlSW2jDwuKYx8L20JyhdCGkIfaKuHKinoreK8QyEhv7EOHWuUvlPyGyBqk40ZBM4qUZ8pC8FlIUFe0JMD9Lh+8Sa1LT+gOMwob5miTokQIsQmaDQUh4TXbPus0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=djX3wARl; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772763438;
	bh=6Lvw1y8jO53tsdMBEuP/2gWGmjzhOC/b4ItepTfDW7U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=djX3wARlbxoi1tXnQtXgjcFgTU/WEGMjDvExC8cfrEeRERwR0QqOuMVaO0YpCN4nW
	 SM7Dd6jsy/46HM1rXwddEZ8RhWqgIMtmXvVj7sNcNdgCCl3vsP+IIcJWe99Gh3E8g7
	 XMKSRYUlNORawLHckS4dhMJOhdMwtFI3zijKlBmE=
X-QQ-mid: esmtpgz16t1772763420t656afca9
X-QQ-Originating-IP: JjtnBdP+c9fPNjHvn0HE62t9ESrMHBnp/4VP8A1fOS8=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Mar 2026 10:16:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16607703761546890952
EX-QQ-RecipientCnt: 10
From: Yihan Ding <dingyihan@uniontech.com>
To: gnoack3000@gmail.com
Cc: dingyihan@uniontech.com,
	jannh@google.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	mic@digikod.net,
	paul@paul-moore.com,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com,
	utilityemal77@gmail.com
Subject: [PATCH v5 0/2] landlock: Fix TSYNC deadlock and clean up error path
Date: Fri,  6 Mar 2026 10:16:49 +0800
Message-Id: <20260306021651.744723-1-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
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
X-QQ-XMAILINFO: MGXSylOY155T/6Yf8DJ1cuk5IqXXrSBiYiN76x9yzzL44eNCtb1DF0W2
	jSGPS9Vh0t2HKOLvKBDFT+Ef2uxobn77jDO512lu+QWZHHJQko+gbRc1xToJQ0IeyBavzB5
	eYna0waMquffOWJWJNr7zllvY0TpPQ7aNYvwDH3TdqqnRjgM//y/NuiROQUAe/WY5h6lgr5
	s0WYYzwYVr5qaKx1SE2KsA3cgu51/mT6iImmaF4ci8cktLC+EcLkq579yzN+8SVVzb3mAv9
	lnmB8opTNO7g0a+NduYqz5CUn3TEgINHd7vq/6fpJjtHCVIldCtNDwQcOHI3YTOxZEhvSwX
	JYek+RLwslKENCsQilbn1hbXWw3oIgkIWPExrS8hWjw5/b6aBw/vaQNyEeS7lUviLQVWade
	HhCJ4QDRiuZvi4s8i9f7IthJ5aHR36u95AsnE4kTddupNRBlD+rD99PXWVygjn4skD0a5VO
	o2xF8+7oTRbOQu2uYHLYjZajCoV+dy53HuMBQv1dOqTCkCsiPANGt2Rh75ViRybV9j+ZNz9
	0bitOA3QX1JFJtw/6XqAYNKqwC7x/vpBY9pJoIQw6RMPQeoVhb2FqKd90RvLu3kAyWFfZyQ
	c/5SImrzWEZ2ggzm1D7cnVyUYfydOhr57E60kpo2Dm++2KnuwyGo9WNgkIRwe/4/FYdF+xg
	xNafR8MXsNx4N+mDAaeWp1mMzq6DtjY5KE4ImxVKEhIUV0WV/+7CuYHvzV7UkcFG5RDqE5V
	zakZbVd0uMU7NXwBB4vEXrT9MRDxhQxyhJD4zWzos6wpa4LH0AU7zmxBq+bp/AGApRA12IG
	/SFcmdwtLeM9tqQTFsw2/qzrFx3ESrd9uBgliLp//4jgXhaC8VmjMOWPY3kio5grnM5teJf
	t+LrQdcSjc9zpe3uTvt6jrLNd4I4LHcCnlmnBEgf+CNFZUxVcVA9P5/D4xhyTGpKdvHXK75
	6xBpGVIM00qzk4eC+QSjEV0T4jtgmts/4RRFh870WJVGVJEyJEgcweF5iNwbVaHPNJNthvC
	xJF8Bgqm2ist1uJiwefgSTiOseenRsIznuV+6QXcqnHHJqN3lz
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 1215A21A8AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[uniontech.com,google.com,vger.kernel.org,maowtm.org,digikod.net,paul-moore.com,syzkaller.appspotmail.com,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15347-lists,linux-security-module=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dingyihan@uniontech.com,linux-security-module@vger.kernel.org];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-security-module,7ea2f5e9dfd468201817];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:dkim,uniontech.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


Hello,

This patch series fixes a deadlock in the Landlock TSYNC multithreading 
support, originally reported by syzbot, and cleans up the associated 
interrupt recovery path.

The deadlock occurs when multiple threads concurrently call 
landlock_restrict_self() with sibling thread restriction enabled, 
causing them to mutually queue task_works on each other and block 
indefinitely.

* Patch 1 fixes the root cause by serializing the TSYNC operations 
  within the same process using the exec_update_lock.
* Patch 2 cleans up the interrupt recovery path by replacing an 
  unnecessary wait_for_completion() with a straightforward loop break, 
  avoiding Use-After-Free while unblocking remaining task_works.
---
Changes in v5:
- Just simple formatting changes, no code changes.

Changes in v4:
- Patch 1: Use restart_syscall() instead of returning -ERESTARTNOINTR.
  This ensures the syscall is properly restarted without leaking the
  internal error code to userspace, fixing a test failure in
  tsync_test.competing_enablement. (Caught by Justin Suess, suggested
  by Tingmao Wang).
- Patch 1 and 2: Wrap comments to fit in 80 columns

Changes in v3:
- Patch 1: Changed down_write_killable() to down_write_trylock() and
  return -ERESTARTNOINTR on failure. This avoids a secondary deadlock 
  where a blocking wait prevents a sibling thread from waking up to 
  execute the requested TSYNC task_work. (Noted by Günther Noack. 
  down_write_interruptible() was also suggested but is not implemented 
  for rw_semaphores in the kernel).
- Patch 2: No changes.

Changes in v2:
- Split the changes into a 2-patch series.
- Patch 1: Adopted down_write_killable() instead of down_write().
- Patch 2: Removed wait_for_completion(&shared_ctx.all_prepared) and 
  replaced it with a `break` to prevent UAF.

Link to v4: https://lore.kernel.org/all/20260304095418.465594-1-dingyihan@uniontech.com/
Link to v3: https://lore.kernel.org/all/20260226015903.3158620-1-dingyihan@uniontech.com/
Link to v2: https://lore.kernel.org/all/20260225024734.3024732-1-dingyihan@uniontech.com/
Link to v1: https://lore.kernel.org/all/20260224062729.2908692-1-dingyihan@uniontech.com/

Yihan Ding (2):
  landlock: Serialize TSYNC thread restriction
  landlock: Clean up interrupted thread logic in TSYNC

 security/landlock/tsync.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

-- 
2.20.1


