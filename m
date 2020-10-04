Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04D282B37
	for <lists+linux-security-module@lfdr.de>; Sun,  4 Oct 2020 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJDOYd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 4 Oct 2020 10:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgJDOYd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 4 Oct 2020 10:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601821471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type;
        bh=ImS+DzrKsQVbgZPvAgl58XuPNm8KTHvfc5J8ftfxKXw=;
        b=IA6xWNby//VZulgXUkm5mI9ayFA36KHqT+LeOMfMl/Ue78q1XZYgImgVoXGZE0BwX4l6oU
        4dtR7rJxBjG7LUXCrA416FVmBIgOIK9TVN9d4xcbqc/CUzG4FIud8L0HOGEOHMH4JDNyqk
        UTA3JPJ29Fx5Oj3QlcsuCt9DR0E85bI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-oW2FiNNKNTmH9LoReL-NOw-1; Sun, 04 Oct 2020 10:24:30 -0400
X-MC-Unique: oW2FiNNKNTmH9LoReL-NOw-1
Received: by mail-qv1-f72.google.com with SMTP id y45so1668305qve.15
        for <linux-security-module@vger.kernel.org>; Sun, 04 Oct 2020 07:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ImS+DzrKsQVbgZPvAgl58XuPNm8KTHvfc5J8ftfxKXw=;
        b=QqxsF2mBkmF7mx9eI4mantvJXgH5TrZ+Qs+UJ7zNUOBqwTIV4fFmq6ZnJYhfb6BcL0
         EFrIymbwb0aL8RXBcRWG8egxiuc6WUSA/hGE2h77Zi9f3xXLVaaTExEj+Q0CN5oVguT0
         EyPvPtJb7gG0ApOP5rtpd4VPgzmY2uy3GX1A+lAMg3kJ3Ed6yiOx7M0JCnR0YoLLvfIk
         6/fjOKIAs7rpgYCmkLym1BztHIepja2Nl0aBqKh7h9EZi2LWtkRQ78vlgI+Gb6VBrLYl
         u9gksgIc+UFppDrV2wbgYOO7avMDtJT4+wmGNPFwSf+/BnHdjTA3S0ejuL+xvRAxlBrn
         reIA==
X-Gm-Message-State: AOAM533WR3fw5BGjuyMFlXPdiGjAVcHUmfVS8+RjsvtEzpr5H+V2m3ab
        iRnvZMX59CEX1NR03EW7f4uKMkbAdI64IwaHIZXy9GORMz+7A5+84+/BzVZScoGjhO80ANmDWgB
        VCs74OtTMM4XqK722B2kOIMqevlobdbSpPC2Y
X-Received: by 2002:a05:620a:10a7:: with SMTP id h7mr2850460qkk.40.1601821469671;
        Sun, 04 Oct 2020 07:24:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznXfn0azZEw4IrpOhwWc02Vc6jdkQKYSLJTj5F+V8VauW2yCaxAoTWsPnZlcn+8Dc1Cr58Yg==
X-Received: by 2002:a05:620a:10a7:: with SMTP id h7mr2850439qkk.40.1601821469386;
        Sun, 04 Oct 2020 07:24:29 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g12sm5292344qke.90.2020.10.04.07.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 07:24:28 -0700 (PDT)
From:   trix@redhat.com
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        natechancellor@gmail.com, ndesaulniers@google.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] apparmor: fix error check
Date:   Sun,  4 Oct 2020 07:24:22 -0700
Message-Id: <20201004142422.5717-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Tom Rix <trix@redhat.com>

clang static analysis reports this representative problem:

label.c:1463:16: warning: Assigned value is garbage or undefined
        label->hname = name;
                     ^ ~~~~

In aa_update_label_name(), this the problem block of code

	if (aa_label_acntsxprint(&name, ...) == -1)
		return res;

On failure, aa_label_acntsxprint() has a more complicated return
that just -1.  So check for a negative return.

It was also noted that the aa_label_acntsxprint() main comment refers
to a nonexistent parameter, so clean up the comment.

Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/apparmor/label.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index e68bcedca976..6222fdfebe4e 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -1454,7 +1454,7 @@ bool aa_update_label_name(struct aa_ns *ns, struct aa_label *label, gfp_t gfp)
 	if (label->hname || labels_ns(label) != ns)
 		return res;
 
-	if (aa_label_acntsxprint(&name, ns, label, FLAGS_NONE, gfp) == -1)
+	if (aa_label_acntsxprint(&name, ns, label, FLAGS_NONE, gfp) < 0)
 		return res;
 
 	ls = labels_set(label);
@@ -1704,7 +1704,7 @@ int aa_label_asxprint(char **strp, struct aa_ns *ns, struct aa_label *label,
 
 /**
  * aa_label_acntsxprint - allocate a __counted string buffer and print label
- * @strp: buffer to write to. (MAY BE NULL if @size == 0)
+ * @strp: buffer to write to.
  * @ns: namespace profile is being viewed from
  * @label: label to view (NOT NULL)
  * @flags: flags controlling what label info is printed
-- 
2.18.1

