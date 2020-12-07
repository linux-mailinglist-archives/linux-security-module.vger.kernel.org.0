Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D02D1660
	for <lists+linux-security-module@lfdr.de>; Mon,  7 Dec 2020 17:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgLGQfS (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 7 Dec 2020 11:35:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727589AbgLGQec (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YovU3sr3PaW3+O202/CGPLg5GcG7AOB5YNKN3Gg/9CM=;
        b=Z7RjMwM5cujFgJ0lPS6xHmwUpW23QTAlk1x3732QUUgbcR7UgmZATKf4bF7QYeT6kRm0Uh
        4s/h2o5QO81CwFhG6x4+zgkHMDKUAd019OWtNiqkWCIz9HUrUTOTTNfvl9raff5RGBF3iP
        r2dn8j5zKrHWhwn6Ha4Ry79EYWH7JUQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-9xNuyCL4PLSfoY6JWeqXZg-1; Mon, 07 Dec 2020 11:33:04 -0500
X-MC-Unique: 9xNuyCL4PLSfoY6JWeqXZg-1
Received: by mail-ej1-f71.google.com with SMTP id 3so3328515ejw.13
        for <linux-security-module@vger.kernel.org>; Mon, 07 Dec 2020 08:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YovU3sr3PaW3+O202/CGPLg5GcG7AOB5YNKN3Gg/9CM=;
        b=gIOOxoxwfwOnkU21JHW37KvPV2vccPWB0DLuZk0F/YqAZ2RgAnZ1GOtLA7LuByNnXy
         ZaKntofuCl/mRhkymWBfdsIElpioxSycWDRdXuruxQgbx9OEqC38WwoJwVgspSkggbNC
         vDWOyQ3TmGXqzxHRJHuBWgOpE9NSdXEq2/roTnFIjcnHT1e+htRMl3Eb6R9puiGNrAiW
         wUfRKsrUN9FrgRxACxLes9IzprZpt1FLGsZbLFxNOHh422GTCK+gl0ZAaotMIzvueKhj
         3PrYN3dFfnm52G2xJdL30AMU8UFc01odhOK8h3LkcJMQaeBjOAlYhzb82k5XnrAkzvb8
         C6EA==
X-Gm-Message-State: AOAM532Qo2SEdMeTChJrrPXabEi1Z/jMrtgZgogK4WYqHtbHnkxjeQl3
        f7HyoKRIzWOGGKoleQyYRe0QOc7WmNDzr5a4ViTIt6LF2jnv+Uq5Fghr7GkwKE3RARLeDKIphaI
        xIwh3TsVt5GhOl1wrK4sGQfPH5wbAjVvTvw3c
X-Received: by 2002:a17:906:fa12:: with SMTP id lo18mr20047771ejb.354.1607358783581;
        Mon, 07 Dec 2020 08:33:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRh6Xa+5iZaFkMzkShNmnm8HMI1mEJZ43C03cBXKlr6CObJxEgF3paS8CuYV44ij1yPUSsGQ==
X-Received: by 2002:a17:906:fa12:: with SMTP id lo18mr20047758ejb.354.1607358783452;
        Mon, 07 Dec 2020 08:33:03 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:02 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] ovl: check privs before decoding file handle
Date:   Mon,  7 Dec 2020 17:32:48 +0100
Message-Id: <20201207163255.564116-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

CAP_DAC_READ_SEARCH is required by open_by_handle_at(2) so check it in
ovl_decode_real_fh() as well to prevent privilege escalation for
unprivileged overlay mounts.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index a6162c4076db..82a55fdb1e7a 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -156,6 +156,9 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
 	struct dentry *real;
 	int bytes;
 
+	if (!capable(CAP_DAC_READ_SEARCH))
+		return NULL;
+
 	/*
 	 * Make sure that the stored uuid matches the uuid of the lower
 	 * layer where file handle will be decoded.
-- 
2.26.2

