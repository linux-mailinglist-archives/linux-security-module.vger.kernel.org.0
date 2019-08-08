Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7228C85713
	for <lists+linux-security-module@lfdr.de>; Thu,  8 Aug 2019 02:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389544AbfHHAHt (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 7 Aug 2019 20:07:49 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37995 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389542AbfHHAHs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Aug 2019 20:07:48 -0400
Received: by mail-pg1-f202.google.com with SMTP id w5so56580372pgs.5
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2019 17:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gySahCCzgGb/Q58L8c20Lrjjix8qIZkrCOd+PLUQfB8=;
        b=KUrK/PKBvaP9/XDEYsuifyH8DFiozIFrCZLZ5Ezfns7BHlTH1+1PJfamzSxJu1NHyI
         6ctpu4+uT8nJAWOBlOw5Ij7yVVB4PbtgL46p1TTpzX+B+CMrqDTNnSd/h/F0RIWkWGsT
         5q7WQ9rlyhjvhuKYCctrkMxQv0iNTuIiOglGqYM3qvLt1eLw1DNoOfnxzsT0wE2V6P/k
         PVdLaBRuVUmR6hOfxG3BBT79ZSXTJI0zzhUfln6YL1sopyhMdgEIdbyDl96i9J9Tnpyf
         N6gPcQJzR7WNQRCkjuNE7N5fVtucOuzZnjpMi6Qgl5IEk5vzH4IRaVOse20R5VKES5jH
         76XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gySahCCzgGb/Q58L8c20Lrjjix8qIZkrCOd+PLUQfB8=;
        b=PLw4NadHtRRy9NYXSCKON6U30bv1J7tx9SwrcGQAiQl1CQYXamPsxqyNezE3DSzN1b
         /TWraszXM5HUf8u8umu2kSrgdBRi3B20j8rRvNmlAqgCSTN2XZoQXhtq8JBZ8C4U7NAq
         vcuMslZHRWd9rGTPjk27J9Iphk5C6F5H9VKYqMbwv1wc9qJfAw9mW0pglSA98bLRJLEX
         TthUQ75cu1pYzshJLHURVKywmXheeI8ylrgF1k6F4BeJmVhQ6guULDnZXbEga3PslvDQ
         htMp58keX/kR4og8rJIrxKClCD0PJlW1Kk1dM39c1bZNjh+T6OMieACdK4SJrhA2M9Bu
         Jgtg==
X-Gm-Message-State: APjAAAVEFmpI+t84TjGXnR1q2qHB1HuJUSvdc/FB5f+U98/zsbxYX2j7
        MIyR/RJ4STyBLTJkr2IUFLgpXlFhLiN3NXRXwz9EOQ==
X-Google-Smtp-Source: APXvYqwkKPuHIr1WPHDEGoL8TaPLK20sGfDakPHoHeTUToI5rF/8klBhegI+5Ecn/fypk8Jj6wDHuVxgitecN1QavCSt6g==
X-Received: by 2002:a65:64cf:: with SMTP id t15mr9782881pgv.88.1565222867491;
 Wed, 07 Aug 2019 17:07:47 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:01 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 09/29] kexec_file: Restrict at runtime if the kernel is
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
2.22.0.770.g0f2c4a37fd-goog

