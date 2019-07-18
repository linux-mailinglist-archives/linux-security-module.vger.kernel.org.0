Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D0E6D504
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Jul 2019 21:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391571AbfGRTon (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 18 Jul 2019 15:44:43 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39361 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391606AbfGRTon (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jul 2019 15:44:43 -0400
Received: by mail-qk1-f201.google.com with SMTP id x1so24154584qkn.6
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jul 2019 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9fXbmdfL5KhuvIZCfCGIG29n6zuww7qo8MROnWxS5+E=;
        b=vaFKk2Q89nA8m9zpY9o5P/RyryqHBdnZpR8gvBpiaUPOc73uQhRke4kFn/wkdzgCxl
         U2Duhl+4hspB7HHsAUKNt8g59w64Y0FqOLBAqNw3Pl3ej3rwSW/y589QZ6A6ApenF8w2
         daVo52oj5ggvqgEbXliWkyAt5Cs7XMh5cwhuDlUHhifbQULkx6UsimX5JAb/C2HZA3tE
         9v4X/c4Q4p7oikJ+1P7BAsp1XkYXcYcR5trJpUpZGQes+T6Dbg0lDgBMS7KxMgKrVRS8
         wxeppP6Cw5FcMVwd1u0yQsxFPsfRzN6VoauEsS4u/2f0lfU6SeMZf9gUfADnLY8TtFWv
         o/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9fXbmdfL5KhuvIZCfCGIG29n6zuww7qo8MROnWxS5+E=;
        b=QE0UR7NoCUf7uosbJGG+fK/qjs3gXPyAtJZJSLbCqQCKqH6oeJriwIe/fST7L6L6Cp
         ENif60QQh1uGC3S2bsBYKuMJ8nDqpsUBkcnqoH5UXceYjQpQj3Qi/S5cH5vL6F97K1Lz
         lB+yowJ3PRhq8DYsXybG3ugwVc5pDf7ksL5VxPXimNw2WaA5uP1mF50KOscXjx5L5/mo
         jSK0JIWgFG+c46xzAOiD361s+9cIiu6XtsYLemsn1ERGr8PuSnlxz/rzpAj61Cv64vto
         jwlt+rMK6PgpeITBRPHE9x+wpOFUKX8pYevoknyb7O7gAOl6/l63srPyjyZerVtx3ivP
         86ag==
X-Gm-Message-State: APjAAAW5p8H9GEqoQPPoLWsz3w/QiZa91Ja2xEsTkleUzM8u1E/bsqoR
        X88UKkVVzvS1EpaOEW6yWVwQbmVHIWrgeyj7RCDeAQ==
X-Google-Smtp-Source: APXvYqw1Vt8jWwUEn/Hr2prhO6C8MXEOo0YzibKrMSn4iA+j+KGx0PZu3RjycZEmtM6rOA+IxN/17K2wlDLSPEXZw1FUWw==
X-Received: by 2002:a0c:acfb:: with SMTP id n56mr34542609qvc.87.1563479082093;
 Thu, 18 Jul 2019 12:44:42 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:55 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 09/29] kexec_file: Restrict at runtime if the kernel is
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

