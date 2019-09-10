Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B6CAE9CF
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Sep 2019 13:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfIJL52 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 10 Sep 2019 07:57:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40834 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733154AbfIJL4h (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so19614229wru.7
        for <linux-security-module@vger.kernel.org>; Tue, 10 Sep 2019 04:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EIsUn9Jau6/KXdzHwU5tqQRGOjQOzaD5sGChfY5yPIY=;
        b=fQDaaJcNPj2sPf2H7BhtU7Ap8m14kBNq8GYHsDC+Xbu3N6CadWR/9hgZxLMs8sRAHD
         Y3bXRzzMz60k+pQNzLSY52Lvc99Xddnp0bnDDfUeUQBTtGIkKdmbEhX7q0qJfLCgNWS5
         /q9JXIzNV6eDgkWQbomqYunLWFF1pqhJsb8gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EIsUn9Jau6/KXdzHwU5tqQRGOjQOzaD5sGChfY5yPIY=;
        b=D7vjGmOm/XMUQ5enWjclIoV7bLaq5gPYdJKTQGZA5/UXl2B2QVUVCuMUnfb9yTWzjx
         qLI5NdiUXP3gLN1AHXB12KL/lmi1+PappBc96u+x295dknQiAU8WcqDVnix344rqIBa9
         5GYYnDenSKuHQXJCF70bTascrCHF1r68r4/Oy1lBrXLOlAZilF490+KSh/at+aPqqg7N
         FEpYPGfwqtl6JfSZ/hEmXOzZ2J3TNiCGIIfR5Sptg0A0/FTb8tqBlh/zt/Ggh/OCE347
         8KFcfSOWzp8xT4hfTQ9VxCoPY58C9vuDnnK71gvvXrgFW5QjwCCIJ1oj300GBKiKogpD
         HE3w==
X-Gm-Message-State: APjAAAVqCamqK0CBxKTWNDOWk6Z3vCggN10AweP+V99RfFIDCPV8S9hJ
        f7u855jeIzHsW/SYvP3lGuQ1Rw==
X-Google-Smtp-Source: APXvYqxcquIR5poZ++yC0HYIAXEUfYXCiM1tVNnZaQn9El9Vx1mdrWz5lnAfc9Zwi+MRB67X7M7DgA==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr6946449wrs.315.1568116594481;
        Tue, 10 Sep 2019 04:56:34 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:34 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [RFC v1 07/14] krsi: Check for premissions on eBPF attachment
Date:   Tue, 10 Sep 2019 13:55:20 +0200
Message-Id: <20190910115527.5235-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910115527.5235-1-kpsingh@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

Add validation checks for the attachment of eBPF programs.

The following permissions are required:

- CAP_SYS_ADMIN to load eBPF programs
- CAP_MAC_ADMIN (to update the policy of an LSM)
- The securityfs file being a KRSI hook and writable (O_RDWR)

Signed-off-by: KP Singh <kpsingh@google.com>
---
 security/krsi/ops.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/security/krsi/ops.c b/security/krsi/ops.c
index cf4d06189aa1..a61508b7018f 100644
--- a/security/krsi/ops.c
+++ b/security/krsi/ops.c
@@ -23,11 +23,31 @@ static struct krsi_hook *get_hook_from_fd(int fd)
 		goto error;
 	}
 
+	/*
+	 * Only CAP_MAC_ADMIN users are allowed to make
+	 * changes to LSM hooks
+	 */
+	if (!capable(CAP_MAC_ADMIN)) {
+		ret = -EPERM;
+		goto error;
+	}
+
 	if (!is_krsi_hook_file(f.file)) {
 		ret = -EINVAL;
 		goto error;
 	}
 
+	/*
+	 * It's wrong to attach the program to the hook
+	 * if the file is not opened for a write. Note that,
+	 * this is an EBADF and not an EPERM because the file
+	 * has been opened with an incorrect mode.
+	 */
+	if (!(f.file->f_mode & FMODE_WRITE)) {
+		ret = -EBADF;
+		goto error;
+	}
+
 	/*
 	 * The securityfs dentry never disappears, so we don't need to take a
 	 * reference to it.
-- 
2.20.1

