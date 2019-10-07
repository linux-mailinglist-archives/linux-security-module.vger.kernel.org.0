Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7CBCE8AE
	for <lists+linux-security-module@lfdr.de>; Mon,  7 Oct 2019 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfJGQJ1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 7 Oct 2019 12:09:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40900 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfJGQJ1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Oct 2019 12:09:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so8944276pfb.7
        for <linux-security-module@vger.kernel.org>; Mon, 07 Oct 2019 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aeEaJtarLqJ/0FUJVYNbwn+6HPdzfTKq5CySN2cpkL8=;
        b=WclQk7CqmZhdOvOLCv7bcbzhzQmzjahDqMBGbnnQMbfR+9Qr5Xtu2s4Pq3udBWYK3e
         GoWCLwm019+p9dKJnQT6RlhXwMB+3RrjdnZn6tx2kl/ylqM4mc/PyUyNj+lU7/yQ9NZJ
         KxYS/aSvd4bWsbKruGsMqIUZefM9aluM+5oFIv3S1DJ10bNO52A06lGf57EBsnVJKZ0w
         XMcJ9xAC8U2/pLfmvcFKcJzaUjo3yIi/b5PT2TuOq3N4yoK93MDj3/3JFcpF/FkTgRJz
         KovVEYC9Ir32aKghqE1WmmCNMId/lP6/3CiNDL0nw91hNfed+TIH1o2+/PCmnwpeNlCh
         ZRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aeEaJtarLqJ/0FUJVYNbwn+6HPdzfTKq5CySN2cpkL8=;
        b=dk1f+1GEfYRXRgzGgIRiH3/fSEdgh8WMvUDMErVOv5cyNj8pm/tDfgdoLw2pv996z9
         ge4gl4GJ2iKGxfcKmgC9V9PitOkNlq7rb5+L9e+AosdXE+vXMFjbmNLsos3T61y/i4GU
         0Chr+nAaXKw3e89/lvOF6qxnVbYr0BhHs/u6wGINlEC6alxc5vLcSwvza3PDlr089Zlt
         +smiFIlB1eC2P573CkVP8p39C5aCnGidIlsh5rbVaQRfSh2XXMsihG4wxaAomX9h9N4d
         /xw0zouUiiltgi5M2t5sosin02nrxa/qCxZ2p451KlEIbL1kM6KKMA5ldJk7WauTjHF6
         /dKQ==
X-Gm-Message-State: APjAAAVFXOwq9ejz/2fql6uhkKLhAZeExyXfAv6+EibVjYqVQvtpBLBt
        LF1FeeTX5RmaBPcpfkJS8Hnq0w==
X-Google-Smtp-Source: APXvYqxOwvzzrjEtteWgmzgIWO6ke9wfqYA06v+6RaJ5Zxl0ufcPdavUTQcVgAmJgyYhl4ADnqIDlA==
X-Received: by 2002:a17:90a:e008:: with SMTP id u8mr81782pjy.46.1570464566766;
        Mon, 07 Oct 2019 09:09:26 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id v13sm17660512pgo.79.2019.10.07.09.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:09:26 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH] ovl: filter of trusted xattr results in audit
Date:   Mon,  7 Oct 2019 09:09:16 -0700
Message-Id: <20191007160918.29504-1-salyzyn@android.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When filtering xattr list for reading, presence of trusted xattr
results in a security audit log.  However, if there is other content
no errno will be set, and if there isn't, the errno will be -ENODATA
and not -EPERM as is usually associated with a lack of capability.
The check does not block the request to list the xattrs present.

Switch to has_capability_noaudit to reflect a more appropriate check.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org # v3.18
Fixes: upstream a082c6f680da ("ovl: filter trusted xattr for non-admin")
Fixes: 3.18 4bcc9b4b3a0a ("ovl: filter trusted xattr for non-admin")
---
Replaced ns_capable_noaudit with 3.18.y tree specific
has_capability_noaudit present in original submission to kernel.org
commit 5c2e9f346b815841f9bed6029ebcb06415caf640
("ovl: filter of trusted xattr results in audit")

 fs/overlayfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index a01ec1836a72..1175efa5e956 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -265,7 +265,8 @@ static bool ovl_can_list(const char *s)
 		return true;
 
 	/* Never list trusted.overlay, list other trusted for superuser only */
-	return !ovl_is_private_xattr(s) && capable(CAP_SYS_ADMIN);
+	return !ovl_is_private_xattr(s) &&
+	       has_capability_noaudit(current, CAP_SYS_ADMIN);
 }
 
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
-- 
2.23.0.581.g78d2f28ef7-goog

