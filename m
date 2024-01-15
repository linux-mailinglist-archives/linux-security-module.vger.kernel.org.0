Return-Path: <linux-security-module+bounces-971-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F3982D3AF
	for <lists+linux-security-module@lfdr.de>; Mon, 15 Jan 2024 05:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8AF1C20E8D
	for <lists+linux-security-module@lfdr.de>; Mon, 15 Jan 2024 04:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A0023CC;
	Mon, 15 Jan 2024 04:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X7lgAjgo"
X-Original-To: linux-security-module@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295223A2;
	Mon, 15 Jan 2024 04:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6XW9jqaIh1AQzD94ZZd4+VKcTSdu8kLFek2bVy3e7es=; b=X7lgAjgo2UkCI6NdpJtV3OUDpW
	2PKdoPGhk8T9JjakgBG17xMArruV5r5ilz+KhQCSj0MGSz8QVFjAMrdbjF67W6pyKYyBXFnrGxjS0
	9ecOLWG6PSod9bz8a13Lcz83W9OgMysBmflYpfmCRcfmN0xR/xYKYfqjnAjZLNuRlGVWUUzWdYm7c
	yLv4iCE6GFS1xUszSgcslfeM+hYXnTKpCVQaU3xTF+Uqocn0wdwfCr10L8SYnBOygPnKGJSYLrH5+
	qihKvCmehPE3yieaTexIbNAg9LputiJkcMMgvRQ+Xisa/1hmItUXmp3JCcmzh0ARyeH2/THCjzHed
	TTg/HB/w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPEjA-007ktb-05;
	Mon, 15 Jan 2024 04:37:36 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	John Johansen <john.johansen@canonical.com>,
	John Johansen <john@apparmor.net>,
	apparmor@lists.ubuntu.com,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] apparmor: lsm: fix kernel-doc typo
Date: Sun, 14 Jan 2024 20:37:35 -0800
Message-ID: <20240115043735.7751-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a kernel-doc function parameter name to resolve two
kernel-doc warnings:

lsm.c:1136: warning: Function parameter or struct member 'protocol' not described in 'apparmor_socket_post_create'
lsm.c:1136: warning: Excess function parameter 'ptotocol' description in 'apparmor_socket_post_create'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: John Johansen <john@apparmor.net>
Cc: apparmor@lists.ubuntu.com
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
 security/apparmor/lsm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/security/apparmor/lsm.c b/security/apparmor/lsm.c
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1122,7 +1122,7 @@ static int apparmor_socket_create(int fa
  * @sock: socket that is being setup
  * @family: family of socket being created
  * @type: type of the socket
- * @ptotocol: protocol of the socket
+ * @protocol: protocol of the socket
  * @kern: socket is a special kernel socket
  *
  * Note:

