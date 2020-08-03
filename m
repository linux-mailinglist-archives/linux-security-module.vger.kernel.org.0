Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF21123A7D3
	for <lists+linux-security-module@lfdr.de>; Mon,  3 Aug 2020 15:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgHCNjp (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 3 Aug 2020 09:39:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52075 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726785AbgHCNjp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Aug 2020 09:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596461983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ghWxgCtP6DOJs2jlobm5OHTZI32yY8LeVsVq2n2kfjI=;
        b=UQmL7NNOTyCVkm/xvdc7dweOj9phqzjyZ885oZcT+AyXhniSIAgoyeMWy/zuu6FGyStuWl
        a6GwtBYQRIBRiR+cVVltikJe89Cy+nzNz2Epqk+sQhVhSsX4zFi6uZBlE7xzcYLdYsSk8n
        5K8b8+tgyJb/xexcuNjpcrBQSmRs19Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-LTGAt8n1OzWawJK_1tWwRg-1; Mon, 03 Aug 2020 09:39:40 -0400
X-MC-Unique: LTGAt8n1OzWawJK_1tWwRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE27891279;
        Mon,  3 Aug 2020 13:39:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 831A974F58;
        Mon,  3 Aug 2020 13:39:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/18] samples: add error state information to test-fsinfo.c
 [ver #21]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        torvalds@linux-foundation.org, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 14:39:10 +0100
Message-ID: <159646195075.1784947.11356745961373523948.stgit@warthog.procyon.org.uk>
In-Reply-To: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Layton <jlayton@kernel.org>

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/vfs/test-fsinfo.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 596fa5e71762..c359c3f52871 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -430,6 +430,15 @@ static void dump_afs_fsinfo_server_address(void *reply, unsigned int size)
 	printf("family=%u\n", ss->ss_family);
 }
 
+static void dump_fsinfo_generic_error_state(void *reply, unsigned int size)
+{
+	struct fsinfo_error_state *es = reply;
+
+	printf("\n");
+	printf("\tlatest error : %d (%s)\n", es->wb_error_last, strerror(es->wb_error_last));
+	printf("\tcookie       : 0x%x\n", es->wb_error_cookie);
+}
+
 static void dump_string(void *reply, unsigned int size)
 {
 	char *s = reply, *p;
@@ -518,6 +527,7 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	string),
 	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	string),
 	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_server_address),
+	FSINFO_VSTRUCT  (FSINFO_ATTR_ERROR_STATE,       fsinfo_generic_error_state),
 	{}
 };
 


