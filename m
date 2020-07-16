Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0A7222069
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Jul 2020 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgGPKSd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 16 Jul 2020 06:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgGPKSc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:18:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCC1C061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id q15so9788086wmj.2
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6AOzZ14SVUOE16zA82Tvkg9B3ZamwJzL6LbuYN6274w=;
        b=WZqgH0CSof1WY3MvFmOjIbq3CI/rc+xs9HCYf05cDVBVnoR4SVZH7QfnbscYLyHLs1
         zMYLSPhM7/JuvXGKFpjYXlQ/SNHZx/WQDf2S68W5hs6cI9+um0UnHNPPJBeAVZDhpmlq
         KiQyzZ0iObZOIdJDV8PJ4emu7j87M9jIZkAtrRmRg3xrl9JeMUpS58NNpV1mCSUppIDk
         4bFCZ8lNcqf4TKyRmU1IUdtIkupzkS9+XL8dx4b/fKhK7EjHabhlUQgjATSopKLmDh5+
         JipA5PHR2lnEov4nHl4nVwAoTi9/dkD9Re8DbduUWnlEbBh6sQp/ZJ5Jvt+luaH9dxsA
         NlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6AOzZ14SVUOE16zA82Tvkg9B3ZamwJzL6LbuYN6274w=;
        b=Dh+d79NwoWcAD/11guKdUKxYGN6MamAB/XqU6dgeObezzcrVJKzuji49uop4XuTvw2
         gO1+BcAk45Ur47aPHGQL9HfgVtgkauRs5PUfhx1Pzy497qsNu3+6DwCRi9U1qqUTfa5z
         amZbgFrx8phziUOOWvJXAfY8dhDtTznrbQ4G4CcaDuF6q/wTgK103Jcf18K32FEGzwVD
         FBpZlzmdGg/e/OoppQtZA0HY24hNkaCOZ90RqZeQZVr6v+OeqpK8bt6kr9BKjD4idRz/
         sW7S0V4O9/UVvr30bwHOqQuZrjWcxOkxO1DsLDSUgdnndNrAHJhz2WDUzs8QeHPY3I7u
         SI3Q==
X-Gm-Message-State: AOAM533cgmTOCKWF1Hww+ImBwOzzZEAa5MhY+WSG+Err+DSHygsRM7VA
        8plBhNppBe3EgEBma+1npxM=
X-Google-Smtp-Source: ABdhPJyGO6azkkiFYiS0BDRJ3dOdpAJUq+o/ObZeIDMp6dGK2wzSClDLgXFlwQhq8/1A+D3n5DSVeg==
X-Received: by 2002:a1c:408b:: with SMTP id n133mr3722218wma.88.1594894710708;
        Thu, 16 Jul 2020 03:18:30 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id 33sm8935059wri.16.2020.07.16.03.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:18:30 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 01/16] Manual pages: getcap.8, getpcaps.8, setcap.8: SEE ALSO: add capabilities(7)
Date:   Thu, 16 Jul 2020 12:18:12 +0200
Message-Id: <20200716101827.162793-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/getcap.8   | 1 +
 doc/getpcaps.8 | 1 +
 doc/setcap.8   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/doc/getcap.8 b/doc/getcap.8
index 05ee9bb..0547ff9 100644
--- a/doc/getcap.8
+++ b/doc/getcap.8
@@ -31,4 +31,5 @@ https://bugzilla.kernel.org/buglist.cgi?component=libcap&list_id=1047723&product
 .SH "SEE ALSO"
 .BR cap_get_file (3),
 .BR cap_to_text (3),
+.BR capabilities (7),
 .BR setcap (8)
diff --git a/doc/getpcaps.8 b/doc/getpcaps.8
index b070a3c..53d342e 100644
--- a/doc/getpcaps.8
+++ b/doc/getpcaps.8
@@ -34,6 +34,7 @@ Displays output in a somewhat ugly legacy format.
 Displays usage in a legacy-like format but not quite so ugly in modern
 default terminal fonts.
 .SH SEE ALSO
+.BR capabilities (7),
 .BR capsh "(8), " setcap "(8) and " getcap (8).
 .br
 .SH AUTHOR
diff --git a/doc/setcap.8 b/doc/setcap.8
index 445ed03..da95afb 100644
--- a/doc/setcap.8
+++ b/doc/setcap.8
@@ -58,4 +58,5 @@ https://bugzilla.kernel.org/buglist.cgi?component=libcap&list_id=1047723&product
 .SH "SEE ALSO"
 .BR cap_from_text (3),
 .BR cap_get_file (3),
+.BR capabilities (7),
 .BR getcap (8)
-- 
2.26.2

