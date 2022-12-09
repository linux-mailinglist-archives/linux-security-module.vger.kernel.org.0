Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4DD648625
	for <lists+linux-security-module@lfdr.de>; Fri,  9 Dec 2022 17:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLIQF3 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 9 Dec 2022 11:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiLIQFW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Dec 2022 11:05:22 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDE06DCE0
        for <linux-security-module@vger.kernel.org>; Fri,  9 Dec 2022 08:05:04 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x66so4008524pfx.3
        for <linux-security-module@vger.kernel.org>; Fri, 09 Dec 2022 08:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZNFa0Som2cEXdyImA0PHzAPIxujgLNI2oeSKx5nHZI=;
        b=h3FquO7MkL3Xkcl57UR0vuuniHUg5+pjAS+449C9zKHXjh3bfCzGniHHohZYn5ZJxa
         PimfhG0DETXRYTKLCZGzQghCrFbpOJpZG5Zr0M0bfkbC/VGkO9Ut1cdT7lGwEdufbrrc
         PnxV8fbesmJTL6d00qwrsh707SkFtLJvebIYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZNFa0Som2cEXdyImA0PHzAPIxujgLNI2oeSKx5nHZI=;
        b=b/YevXbk+OfxVeIfuUh6ng1BkRRY3wYmv5w2ldxx7z+VD50eFfX5xLl2/W8olKtWFC
         Il83Vb/cj39ptUjOmISl0+FzE1o/iDgFCHDvOpiR4m7ie7YWNrUncLLSzaU6AdIKdvgI
         ytJDIm3igCqqFcNboY505g6AbrvOswTK8J2zTHyq+u9QnBzN1rOf8WshRYRDWdFmE3QZ
         D3+zJT/hJ/f9qbhwCsi5DDAh3U/RVUppdP3yr1XbqgKFvWYTqnUu8AE0aSdyfOlVSnQN
         HWY69xPjQYhBXYPh/u7tZ65yIOkOq8dDv+i1L3maPAHEXhYp5Z8xTIoS9QWRjddJPmZR
         B/4w==
X-Gm-Message-State: ANoB5pnRIPx2NN4JuHhdP2nJnns+y6PKYacr2YZhVFDJHZV8ef9l/Jpz
        MWxcUjU2dQAzd69TyCmVPzKJLA==
X-Google-Smtp-Source: AA0mqf6CmbxiVSZwu0zBPseh9ltyuMQpEJZ+0MzUajuKI0ToOlPtqG4/ib2Rp5GkK3d0hKasOROV5Q==
X-Received: by 2002:a05:6a00:a05:b0:566:900d:6396 with SMTP id p5-20020a056a000a0500b00566900d6396mr8624787pfh.22.1670601903758;
        Fri, 09 Dec 2022 08:05:03 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id a15-20020aa795af000000b00576670cc170sm1460504pfk.93.2022.12.09.08.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:05:03 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v7 4/6] mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
Date:   Fri,  9 Dec 2022 16:04:51 +0000
Message-Id: <20221209160453.3246150-5-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209160453.3246150-1-jeffxu@google.com>
References: <20221209160453.3246150-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

In order to avoid WX mappings, add F_SEAL_WRITE when apply
F_SEAL_EXEC to an executable memfd, so W^X from start.

This implys application need to fill the content of the memfd first,
after F_SEAL_EXEC is applied, application can no longer modify the
content of the memfd.

Typically, application seals the memfd right after writing to it.
For example:
1. memfd_create(MFD_EXEC).
2. write() code to the memfd.
3. fcntl(F_ADD_SEALS, F_SEAL_EXEC) to convert the memfd to W^X.
4. call exec() on the memfd.

Signed-off-by: Jeff Xu <jeffxu@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 mm/memfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index ec70675a7069..92f0a5765f7c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -222,6 +222,12 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
+	/*
+	 * SEAL_EXEC implys SEAL_WRITE, making W^X from the start.
+	 */
+	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
+		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
+
 	*file_seals |= seals;
 	error = 0;
 
-- 
2.39.0.rc1.256.g54fd8350bd-goog

