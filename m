Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8067B5591B1
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Jun 2022 07:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiFXEu1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 24 Jun 2022 00:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiFXEs3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 Jun 2022 00:48:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6519869276
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jun 2022 21:48:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k127so1531048pfd.10
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jun 2022 21:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=YbFhCGzhKhLbr2G2ThS1s0sN7jwXYQ4vWhYkrXF5osc=;
        b=kkxvDxX6n5CO12HAysNPgLTCaKTovZj6n1W4WM6NrdWPKdt8jHf/gjXiqu7I26pISm
         ua6NuOBU0e747Hkio56Q5FXCk7rSyhq3Y6Zq55CZ25pU97Fj2MfR7zJOcZ41hi7FIff1
         UZdKWwl3KHRXa7tdvTwjrgx6d6+yqM9BG8AZIhTjl1u7f/aVNNosUAXA5LKe9/MYnIvG
         LlPZDl/L+rPWYZtuuiuwai4BFZqZ2PEnrQKWLvGk7JAWOVawnMXlmZxb2Q+2Kgculowg
         wQXZjqI2+6jVMZLja/f8RD2VIlQY6lApwCHArAD4TdMuo1d9XJYF0lETVOugyAaATC3x
         mPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=YbFhCGzhKhLbr2G2ThS1s0sN7jwXYQ4vWhYkrXF5osc=;
        b=rjlyMYGDhY7oIONaEJpNkuGWWp2msm0l2MY+VAwrqdeANBt3viYytUpJAq4Z91cX5U
         /1r1jSaTGQJDRhaS4fJS8AXf3N5p2ERgwZoXzcIcsXJWiLEcrrUvlqjWncO2aCghw3xf
         95vgHSkKO5a5FNHKdqmS78vW7PV1D2O0lWaGE6xAcZel3zirjJxUFqO+QNZrYJgYA801
         0rdqSBZMs1uuEDPrV6zcsi06WApkcLS31V86lF4hUEO4sxRHIGcmxryZMTBlNRM3CPAt
         Z9Se2hRIPjG84si7s/d0yO67B09Bi5elHjUnhpaOO+Rq9pbMdtsOIn79RZC/WKYnBcFX
         ipWQ==
X-Gm-Message-State: AJIora+uMhm+mpi6CXaeh+avgxu/Ph1pCamwDiQigWxOVEh/ypwJWN/0
        92zYZXzrmgPN9H7hvjnwdXHT87VwvsIHzw==
X-Google-Smtp-Source: AGRyM1vJW29/sVxuMxr0tG1PDaIe69h+YLS81Q9kQN6GZXjLMUjcoObBkYAeIvvbIZG+ephEELUDwg==
X-Received: by 2002:aa7:9470:0:b0:525:4214:bd9e with SMTP id t16-20020aa79470000000b005254214bd9emr13914582pfq.11.1656046106909;
        Thu, 23 Jun 2022 21:48:26 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id j5-20020a63ec05000000b0040d2f92d30fsm503488pgh.88.2022.06.23.21.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 21:48:26 -0700 (PDT)
Subject: [PATCH v2 2/5] ima: Fix a build issue on 32-bit platforms
Date:   Thu, 23 Jun 2022 21:48:08 -0700
Message-Id: <20220624044811.9682-3-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624044811.9682-1-palmer@rivosinc.com>
References: <20220624044811.9682-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
            linux-security-module@vger.kernel.org,
            Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

ima_dump_measurement_list() took an "unsigned long *", but was passed a
size_t.  This triggers build warnings on 32-bit RISC-V.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 security/integrity/ima/ima_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 13753136f03f..f2a94ec3002a 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,7 +15,7 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
-static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
+static int ima_dump_measurement_list(size_t *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
 	struct ima_queue_entry *qe;
-- 
2.34.1

