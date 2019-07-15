Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 630AD69BE3
	for <lists+linux-security-module@lfdr.de>; Mon, 15 Jul 2019 22:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbfGOUAT (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 15 Jul 2019 16:00:19 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43899 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732326AbfGOUAS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:18 -0400
Received: by mail-pf1-f202.google.com with SMTP id 6so10857257pfz.10
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9fXbmdfL5KhuvIZCfCGIG29n6zuww7qo8MROnWxS5+E=;
        b=JPp3v2OPQVj5mQJ/3b5Yokag8YTSA13e3ADgk52AJxxllBnhkjU93txgGax0+MtozO
         26npTj2DMHNGP+TUBNZNV0ZhOD85M1Dq+QQ9kYUVPt28DoNQvCjG+QQHwGm6kxbIX3zE
         bc/r3C46ba2V3MCrciOB1HN57gPuvCJn5Cgltuz2ShtXDuI6cZqwi8Aeo1nOyb6sQ8YR
         QEswHcPf2gsuizE5pTK7+h04w+vZ5zRxYx/AtW8kIIjFRAXWGUco5+7wsec28LI6f9s8
         klefOADpWTmW2jS+yNC1A6YoHbtJ5rZxucOV9+SbKsLuPFcZM4VP0TNv2nw+RJr7PKg/
         JWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9fXbmdfL5KhuvIZCfCGIG29n6zuww7qo8MROnWxS5+E=;
        b=toDL9YtJxegLdPs2sLAYYnJ6d+5ZGUZjiLTGlrQ87yq7he8arOQF+CGqiXDcDqZipd
         0/Q6tRUlh9dgpnTjIyaTaipIyRQ+tjUg/iLU6JgbpfLO7OxJT8WFcEMdmmcXxp9iDqlm
         GaGccbmAeu31/Yp7auUijumn8qsVwX9ESeqM4rDnDhmMT7Lz3bhtSS2pXTpDq3WkAM59
         ZQmk/2KDQoMfW3E9MBTkiv5+cLaE3SKlYpxJEtzUbBgCormFomw2dRiTca9EgleMG9Kb
         R/GfIxDjL+oP9psX4MvuSz5jZs3FDIwuS4HL4NO0LE7t97TEhIws6h+eekq9guxDvyaO
         ZSVA==
X-Gm-Message-State: APjAAAX9FTVAUXOiGj/qFXvZVeOBbESQZnSQRkyGAdNXoXS4Bkybz9TW
        q8xXJOW2CxdZxzBVzdAjROrp9HhO2ZiXtOTb9ZVAZw==
X-Google-Smtp-Source: APXvYqzda0/+2/0BqgthTmHOTrEpqoXHvj8K+1i4P8qSZQtlqD+IWxOpDGqqORGgEcnwNsr18QG8jmmfFfkwNCSJxnuVGQ==
X-Received: by 2002:a63:2004:: with SMTP id g4mr27570338pgg.97.1563220817485;
 Mon, 15 Jul 2019 13:00:17 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:26 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 09/29] kexec_file: Restrict at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jiri Bohac <jbohac@suse.cz>

When KEXEC_SIG is not enabled, kernel should not load images through
kexec_file systemcall if the kernel is locked down.

[Modified by David Howells to fit with modifications to the previous patch
 and to return -EPERM if the kernel is locked down for consistency with
 other lockdowns. Modified by Matthew Garrett to remove the IMA
 integration, which will be replaced by integrating with the IMA
 architecture policy patches.]

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 875482c34154..dd06f1070d66 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -228,7 +228,10 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			goto out;
 		}
 
-		ret = 0;
+		ret = security_locked_down(LOCKDOWN_KEXEC);
+		if (ret)
+			goto out;
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
-- 
2.22.0.510.g264f2c817a-goog

