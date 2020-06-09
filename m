Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C8D1F49CD
	for <lists+linux-security-module@lfdr.de>; Wed, 10 Jun 2020 00:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgFIW6o (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 9 Jun 2020 18:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgFIW5k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Jun 2020 18:57:40 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC48BC00863D
        for <linux-security-module@vger.kernel.org>; Tue,  9 Jun 2020 15:57:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b201so232458pfb.0
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jun 2020 15:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I8ffuKnAI6ePp72FbTqXndKW4mWsmd4YfaiykgykUjE=;
        b=ggaIRQep0r9gJKaPKzz5zfk2jSKqaYojEj7TqbGTeEGhi6jnwUsuWWBXbsRvtVLUIa
         4t9J+N5/UNu4Ti1R2tXux1oeDcnxz5wd5BEz6mgmzNx5+DLrPeUulrM/iklcpFFBvvKL
         Cmc2f9h0KIN4UoLrbP5IHbVNb5+Vg8MBFIH0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I8ffuKnAI6ePp72FbTqXndKW4mWsmd4YfaiykgykUjE=;
        b=iTNjq6ZHb6sD5Av4HwYYQH5ASQgwQ4hRE63FfmIgWqFbPbdiXLtTmj3o65EQVxNxBg
         JUFBYfZ29eIO8rRgS2sk6pZJ5iKKUXKmdBMWgOwCSLExRXK4SAXa7+IljBfAMLh1nEwt
         tcWkClIrgC7m8Z9nf4N2QbZ2l/wHYoB2hB7MCoSUZ17mFvMR8A2+aaj0xz5ji8dhAZzV
         I0+21xYil/MP4svV03RqQOVsjK69bBJ+sa2yl4c2RHmAy1F6M1ruGFrr8e4HV0t6kwPa
         eNXf4idedzAQGX/pcVdtQAxupaDmhGVIa7TROu5kd5HmW3z8+3XsIBe2bpBsW8TI3Rmu
         1IKg==
X-Gm-Message-State: AOAM533a903GEL9gY4ZmyWT+6ttx9bi7Pp46Kr4Qye1Qqs4DxngfkXN6
        wQXILXwCfFg44FqHJYQWsqpeBQ==
X-Google-Smtp-Source: ABdhPJwrq+BbJyVNoQDQIQYM/E9dbeyvZqllAsieA1UQyWozBug/ETQFIesWoN1TqS1km0emwF07RQ==
X-Received: by 2002:a63:4b4a:: with SMTP id k10mr217449pgl.135.1591743452273;
        Tue, 09 Jun 2020 15:57:32 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p8sm9104978pgs.29.2020.06.09.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:57:31 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v8 7/8] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Tue,  9 Jun 2020 15:56:55 -0700
Message-Id: <20200609225656.18663-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609225656.18663-1-scott.branden@broadcom.com>
References: <20200609225656.18663-1-scott.branden@broadcom.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5985a7847316..28e3dc1d3244 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3656,6 +3656,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VK DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

