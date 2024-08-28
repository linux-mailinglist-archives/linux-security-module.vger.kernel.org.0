Return-Path: <linux-security-module+bounces-5187-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8DB96314A
	for <lists+linux-security-module@lfdr.de>; Wed, 28 Aug 2024 21:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC021F270FA
	for <lists+linux-security-module@lfdr.de>; Wed, 28 Aug 2024 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D851ABEC4;
	Wed, 28 Aug 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MG10//j5"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1631AB51B
	for <linux-security-module@vger.kernel.org>; Wed, 28 Aug 2024 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874702; cv=none; b=IXZEdEz20IEqJMcxaZNwLgf7y9NCTi4Src+CW438NwoAh+BbFCJXocUFagMr2oRzeaL6i5iswoAdnxgwX1LN64GDXOfBDuEFOXcf6Z4dIy+sKZJQIdFxggAxPcXPcXMUo/JaTZ4IHC+jbgA0ItA4/+WCosEEpPWvO6rRKr9fRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874702; c=relaxed/simple;
	bh=fVISxZv2SeBGuVrnBIvZJ1tXtBQtdpAeMoaYfNH5R0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ppajOl8WAeWnb0fJBHx18X43abFHl2mNONnETj4G/D73lgISLiB2rHmdP+emHS69V0jtPoBwF0CQiAp3dHnMb+3rUr1zyk5nW1oMbjbQb+DeGI/xAHpshitMxS6ZZ8UvAiPwRj0sR5Em13xWuBng5/kt56db9d/DX2sho+zDE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MG10//j5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724874699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aQ9LTm9VbgupYTnWRM8uzbNpl19bMmaQOYwLWwUdRQk=;
	b=MG10//j5AuzyTDG+p3EyjVqlhcYFWzVKTlbvTSzI13zjdcct+kN4SpEwmeBy/X4Qv2/qgA
	e85KnAFCXSjdshUMh06CvQJbmPMfQo2eCjLfNKa0Jt16vpDq77nxLbCwDk5DS1HYVZCVHR
	A4g9W5JjDSitY+cVGbR1tfDYhXsg4dE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-lJH4D0t4PturfPDp0wlmTg-1; Wed,
 28 Aug 2024 15:51:34 -0400
X-MC-Unique: lJH4D0t4PturfPDp0wlmTg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F17C1955BEF;
	Wed, 28 Aug 2024 19:51:32 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.9.161])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE3AA19560AA;
	Wed, 28 Aug 2024 19:51:31 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id D2F1C1F0955;
	Wed, 28 Aug 2024 15:51:29 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com
Cc: chuck.lever@oracle.com,
	marek.gresko@protonmail.com,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] selinux,smack: don't bypass permissions check in inode_setsecctx hook
Date: Wed, 28 Aug 2024 15:51:28 -0400
Message-ID: <20240828195129.223395-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Marek Gresko reports that the root user on an NFS client is able to
change the security labels on files on an NFS filesystem that is
exported with root squashing enabled.

I wasn't able to do a bisect on this issue... partially because when I
go back far enough I have trouble building a kernel that actually boots
in a KVM guest, but also because not all of the related code landed in
mainline at the same time (more on that in a bit).

Although I wasn't able to do a bisect, I do believe this behavior goes
all the way back to the introduction of labeled NFS.  I was able to
reproduce this behavior on all versions of RHEL, going all the way back
to RHEL 7.0, which was based on a 3.10 kernel with post-3.10 code
(including the labeled NFS code) backported on top.

The v1 posting of the labeled NFS patchset actually mentions a similar
issue related to root squashing:
https://lore.kernel.org/lkml/7e0fb38c0802280622o75a474deg38157ff6aace16b@mail.gmail.com/t/

There is no mention of root squashing issues (fixed or otherwise) in
subsequent postings.

The inode_setsecctx hooks first appear in v2:
https://lore.kernel.org/all/1221511278-28051-1-git-send-email-dpquigl@tycho.nsa.gov/
The posting mentions other mailing list discussions related to the
hooks, but I'm not really able to find anything specific on why the
caller of the setsecctx hook would be expected to perform the
permissions checking rather than doing it in the hook itself.

The inode_setsecctx hook was merged in September 2009 (merge commit
f6f79190866d).  It looks like this was for labeling support on sysfs,
which used the inode_getsecctx and inode_notifysecctx hooks, but not the
inode_setsecctx hook.  It doesn't look like there was any user of the
inode_setsecctx hook until the labeled NFS code was merged in July 2013
(merge commit 0ff08ba5d066).

The end of the kerneldoc comment for __vfs_setxattr_noperm() states:

 *  This function requires the caller to lock the inode's i_mutex before it
 *  is executed. It also assumes that the caller will make the appropriate
 *  permission checks.

nfsd_setattr() does do permissions checking via fh_verify() and
nfsd_permission(), but those don't do all the same permissions checks
that are done by security_inode_setxattr() and its related LSM hooks do.

Since nfsd_setattr() is the only consumer of security_inode_setsecctx(),
simplest solution appears to be to replace the call to
__vfs_setxattr_noperm() with a call to __vfs_setxattr_locked().  This
fixes the above issue and has the added benefit of causing nfsd to
recall conflicting delegations on a file when a client tries to change
its security label.

I guess it's also worth mentioning that when nfsd rejects root's attempt
to set a label on a file on a root squashed export, the error on the
wire is NFS4ERR_PERM rather than NFS4ERR_ACCESS.

-Scott

Scott Mayhew (1):
  selinux,smack: don't bypass permissions check in inode_setsecctx hook

 security/selinux/hooks.c   | 4 ++--
 security/smack/smack_lsm.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.46.0


