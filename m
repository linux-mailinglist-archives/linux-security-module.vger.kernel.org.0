Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B05225AFE
	for <lists+linux-security-module@lfdr.de>; Mon, 20 Jul 2020 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGTJOg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 20 Jul 2020 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgGTJOg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD74C061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so16998941wrw.12
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Tn3fVW3IjvsSlXxR30H4KOgdbvOUOH/p/mHP87uMh0=;
        b=eiofgWvIKdukvrnMmfGMxDJqM9erebbWFeeVMOOrjLkyHElYlstLc/1P2QWxJuo+RQ
         Uw6pzYKo5zSdBnqN/wS5aDeMcbilGem4GGZ6Cg/bXnjL0ozGVolV4PC+DdEADSmSp3/9
         52Y4S0SyBq6IsH9NLAMyW+/Qdndf8QqfFv0uZqh2vuNa9373Ahxzr/G4zO6pluNWSvgi
         PeyopWueBUqENkq6ToapeDSwc7eBOXQ3ZvT7iP605QH6IXDCTNr9t7+pA8EA1FLDrKDE
         d/eseYrw2VozGnc2RMdf/oXLSLOM/eqf2TCPBcPzzhH0iIWxe8wWUUyplklyfrKmQEHK
         epZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Tn3fVW3IjvsSlXxR30H4KOgdbvOUOH/p/mHP87uMh0=;
        b=ilmkdfloUCXxgEoIucGG00M7d0T9EDoS1ApxYP492Beh+enJwJSN9krkR14JcYYFKj
         9ol2mPiw8A+w9d/3ZRYe4XUbJ+d3tZOHPUaPIIM9quZoyIiDGBCd8qTN7b+dMP8nI2zv
         4ZnnVCk0kRNAfHUIVChMr9UgEdLO4wP9+FtiUGioTd3dui2g3JJbSc3pdTHTIL0jZPIC
         JM3rtS9AqjM86OeZVTAXm/C8liBodg+WF60IgsSrLoJhgeM7Z1tw4VlKPBPrPJ1jFDxn
         wABovHdBX9N9eOu0Ch3qpQeRQ2zDRzGTTdSMZV+/T+DFWqvuosYwjs40oRvCeSiKsVoA
         v3Ag==
X-Gm-Message-State: AOAM530fSeU2WIr3YhKEyjMyZviuMbTCrlKjMop2ZfNjnPjbvtmlQP6w
        X+hT76vE0knkKEK3lJv3S90=
X-Google-Smtp-Source: ABdhPJwYZDz2FbPnQy8TUj+V46supWh9ob5bIs3LRop6j0a4fYKwi282VSp72T7zAKDI2YcNcn0X6Q==
X-Received: by 2002:adf:bc07:: with SMTP id s7mr6854852wrg.254.1595236474824;
        Mon, 20 Jul 2020 02:14:34 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id u15sm32379032wrm.64.2020.07.20.02.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:34 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 11/15] Manual pages: setcap.8: Typo fix
Date:   Mon, 20 Jul 2020 11:13:24 +0200
Message-Id: <20200720091328.290336-12-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720091328.290336-1-mtk.manpages@gmail.com>
References: <20200720091328.290336-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/setcap.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/setcap.8 b/doc/setcap.8
index ae044aa..582c781 100644
--- a/doc/setcap.8
+++ b/doc/setcap.8
@@ -39,7 +39,7 @@ is used to remove a capability set from a file. Note, setting an empty
 capability set is
 .B not the same
 as removing it. An empty set can be used to guarantee a file is not
-executed with privilege inspite of the fact that the prevailing
+executed with privilege in spite of the fact that the prevailing
 ambient+inheritable sets would otherwise bestow capabilities on
 executed binaries.
 .PP
-- 
2.26.2

