Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3C0AE78D
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Sep 2019 12:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405583AbfIJKDe (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 10 Sep 2019 06:03:34 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46006 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405459AbfIJKD0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Sep 2019 06:03:26 -0400
Received: by mail-pg1-f201.google.com with SMTP id i12so10335401pgm.12
        for <linux-security-module@vger.kernel.org>; Tue, 10 Sep 2019 03:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sGqYubR5Lthr7yxzMgwTRpMO66aeWf2qCN8tGk0FHOg=;
        b=H9a4A105QMmIT8qtxtAQb/NY2MEr1GOUe/9IKXYp1yvFWHSfAlO7CBzcQZRfYWqncZ
         ZxjG2BQdBexz3OJ4rQ18i+Tdc3DAR0KN3k1p2m17MRcZgGQGgZz5/r8Hh6ucuKYTFsIi
         fkb8CbJOBYh5MchJNUxddQmx01y0IRBgwhn9w7/i/8qNC3CBTrlV1D1ve6Q/DDPIurib
         yxPmoPvNIBTWUXkW4bGU99MVYfLii9je1nMATSauAG/U7ocCXMNyfCM+zbtllmDkLzGg
         do7yLqBRV4AxHkpxALJqAc8OwbG2kROF+aQt44aAwQhK2tgyyCAquB/tOVTRHxvF3hM2
         vuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sGqYubR5Lthr7yxzMgwTRpMO66aeWf2qCN8tGk0FHOg=;
        b=Pu5UHTsPCaJ7p4sDrP62HP+mkm89DQ/AJTz0NM5IPKwvcFHHe1dhjieh/jZ9DFkoMH
         ZAeixaRiHS3qH3/g9dcmymBi7p+Oalv7IZ6XvXwz1Bo6RjJv7zRvEV7lXFDIYmLPSj6u
         adE4n1qfAEY1cvCaC+7HBp+/ly8mWQTsykKsWzj4cAM0I1hyN1bmz+6xMBEpisRU2ubq
         5YkbrnLCAKSwquc0wJmD4hVhMeIoSNUnE9Vhg7UF0NSYbh/Wk6rvaFDdpnOhtOLHm1Ys
         ZXCRmbKHFIngo2uF1QOkvzQnwPWFj5qAWGArbtJXzYyfxI5+Ms5OADnoa2JPV8IUjkDs
         ZMVA==
X-Gm-Message-State: APjAAAUOS/ULRhi50ztDmU7lYEh+FpvWW8xdFZqrGthS2sHEC5V87sZl
        Jt/gnm95ZAmULRvtr7JvVpdWLC3KjVT3xyUCAabI3g==
X-Google-Smtp-Source: APXvYqzM05C6SE3TotMj3/meUIyoGC4bBZZMU7jv39OiAWQEeQWjMdLKgYPvcwQT8uU2wIK6u/jlz3kmMv7mFo/bmMBTvg==
X-Received: by 2002:a65:6850:: with SMTP id q16mr27663278pgt.423.1568109805751;
 Tue, 10 Sep 2019 03:03:25 -0700 (PDT)
Date:   Tue, 10 Sep 2019 03:03:17 -0700
In-Reply-To: <20190910100318.204420-1-matthewgarrett@google.com>
Message-Id: <20190910100318.204420-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190910100318.204420-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH 1/2] security: constify some arrays in lockdown LSM
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

No reason for these not to be const.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Suggested-by: David Howells <dhowells@redhat.com>
---
 security/lockdown/lockdown.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 0068cec77c05..8a10b43daf74 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -16,7 +16,7 @@
 
 static enum lockdown_reason kernel_locked_down;
 
-static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
+static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
@@ -40,7 +40,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-static enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
+static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
 						 LOCKDOWN_INTEGRITY_MAX,
 						 LOCKDOWN_CONFIDENTIALITY_MAX};
 
-- 
2.23.0.162.g0b9fbb3734-goog

