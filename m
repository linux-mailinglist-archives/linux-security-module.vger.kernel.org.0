Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207BC1F4E77
	for <lists+linux-security-module@lfdr.de>; Wed, 10 Jun 2020 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgFJG5y (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 10 Jun 2020 02:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFJG5x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Jun 2020 02:57:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D834BC03E96F
        for <linux-security-module@vger.kernel.org>; Tue,  9 Jun 2020 23:57:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so903417wru.12
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jun 2020 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bmjTCUR4HAGNSH0v1nRx3c5xjU7b4qeB1apQs6A1zGw=;
        b=bozXkOi/HUXwxduOCmidVG4plhkh+Lk5KsvGr8BEmPsKEvUG3yEn6AnxzuJtrv5gEA
         zXPLE34oXeIRtZuTZKGETSkdgz/GIUq1o+OB+VplH41YCN5HGSLuJAW727SoqpZJGu9Q
         Qba4VrtsYNh1evyiAoBasQ448VHBsZjVMHnkJgFTieIrau6wdAT8X0S/+lC8QJYcC2Mj
         khDn6W251bvo7t/P0XFYzGv3hDB12lYBzFqdNkLq1lpjXOrxpByNpQKAJk3ay11kMIHW
         erUa/InMgxpGkmnourydytujNkVs5r3hc3GGwYCUnVfX+8FeJzo7y+nHX5ZvzoKFzrcR
         op4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bmjTCUR4HAGNSH0v1nRx3c5xjU7b4qeB1apQs6A1zGw=;
        b=XxdzPTYiGyVfk3TwehbJ+rh5hMy7G0/ffrQNaCo9npXjPbORPiwvWoNgGfzLE/3+9O
         ZsfTtWpscYmOHEa1AgNkCWu/NDj2reh0HzSowroKxW3/Gy+L9jXkiEbPCf7VpYmF4kme
         ntsRot4v5n4koCDFD3WtDOEeLpDdG5QYgzckLHrwaa7btKiChIloH46FfGGu3KpY8ad4
         rD8FnRuKYYF0ElIn/ummghzS/k28qxZnIo3bP2PC6PTp2TU//2sNnKSR4CRMNCH6sRyD
         Y4NyUD6skqv6bkOAdLXKsP5tQdSCFZJ/ffJf8tMUEWQ9iYQaI/pkaCVlohoW3Wi0aJWz
         X+wA==
X-Gm-Message-State: AOAM532b602F2PrBG1On97Co85iDCjOopjWSoBJ8lt6bpEJCOBchO16Y
        DDx1QNf4n9ZUCcNuzNGpStm6kFzXCE0yeQ==
X-Google-Smtp-Source: ABdhPJz9BdtQme2J+4ZuZxkBzplzInhRppm1Oub3rQLiFLgJthrneU1Be6Dkf9T/RANX0XYfEJyyaQ==
X-Received: by 2002:adf:fec3:: with SMTP id q3mr1847191wrs.123.1591772271561;
        Tue, 09 Jun 2020 23:57:51 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id g18sm5889977wme.17.2020.06.09.23.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 23:57:51 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 2/4] cap_get_proc.3: for cap_get_pid(), pid==0 means "the calling process"
Date:   Wed, 10 Jun 2020 08:57:33 +0200
Message-Id: <20200610065735.3975740-2-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610065735.3975740-1-mtk.manpages@gmail.com>
References: <20200610065735.3975740-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

It's useful to know that when cap_get_pid() gets pid==0,
it returns the caller's capabilities.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_get_proc.3 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/cap_get_proc.3 b/doc/cap_get_proc.3
index c2ce212..0238601 100644
--- a/doc/cap_get_proc.3
+++ b/doc/cap_get_proc.3
@@ -78,6 +78,9 @@ see
 .BR cap_init (3),
 with the process capabilities of the process indicated by
 .IR pid .
+(If
+.I pid
+is 0, then the calling process's capabilities are returned.)
 This information can also be obtained from the
 .I /proc/<pid>/status
 file.
-- 
2.26.2

