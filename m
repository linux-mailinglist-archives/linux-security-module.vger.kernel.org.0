Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B8BDF260
	for <lists+linux-security-module@lfdr.de>; Mon, 21 Oct 2019 18:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfJUQFw (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 21 Oct 2019 12:05:52 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42780 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUQFw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Oct 2019 12:05:52 -0400
Received: by mail-il1-f196.google.com with SMTP id o16so4425646ilq.9;
        Mon, 21 Oct 2019 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+9Fw9C3VNmrkj4O0SxMaQ6+MpbqTvqoB6rYX9UMgB/Q=;
        b=El1z6SHTX7CqiaLgncFAg/FvJ1ExE/Im2uEY3oUmCkZF5hwFGBPBCmNjKk6PTUha23
         KEPoJBnSq7ZW+6tqenfQL/J/zIwFtJIZ+YA0kjV6XqFEfwUOUxFJK5+HvXosbRl9hjCi
         DauRXVF/sa4FufQZmYsUkaw6+ZgF915p7bQTj9klNgAHViC6q8yiiMxtj7Y0JGoEKWko
         YOxQhpaPKYrTiWyrfHTzUG1+pqJE2LXVFjwqOFCGm7D7ummtUomWGRlNxCc9HYmy95TV
         4VlTypk1b4QE0EOQdkNQV3zPgPkI+XFQLYYQbSoCnPTWjk/bKgp6DDbUK/jQRDTicKvz
         N6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+9Fw9C3VNmrkj4O0SxMaQ6+MpbqTvqoB6rYX9UMgB/Q=;
        b=aK6PF4842SNgYr2bMiiCLM+OupPfVV4f0FO3sQwzBCmJ0FBxWsx5mli0KsoyioOSK8
         BvsmK8JbL4ksB+Mvg9en+H5UNQCOAqmALmAtbENzj6+2/0TB8yc9yI7S7A46VN5+PARf
         KvHlMlSh1dz0qD9XXXIslAtWnuIhhRR05QZnHFe3WI2hOgUvSJQP5VDkjKJYHIoz6fJM
         kqnlEFZVF/mHeZv+PAa84qLA1mSC3uzqyOVsWmjG9ocjw8eisYvjPsRO8FTmpZwDKhhH
         gv0FtD7qqa5bY5oaK/+3NiBdMmcjCFTBr2vw4aEODG2cSW5Ts6fb3gXtgbVv9yLRAoWK
         6d8Q==
X-Gm-Message-State: APjAAAXIZahFJizZyxzktTNsNKrSOBxsx+ttCHzEWT5e2sGI+8Db8w6Z
        JLVdfNZy6VqD3f6+Lr7eHLA=
X-Google-Smtp-Source: APXvYqz9Imm6P88RdnmB8s87ECVZmRmwVokZUw4Id0w7IF2XQdSetobkXMjZKb7YPJn1eCaxxbYelw==
X-Received: by 2002:a92:6f08:: with SMTP id k8mr25825599ilc.57.1571673949954;
        Mon, 21 Oct 2019 09:05:49 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id l7sm589694ilq.57.2019.10.21.09.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 09:05:48 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     tyhicks@canonical.com
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] apparmor: Fix use-after-free in aa_audit_rule_init
Date:   Mon, 21 Oct 2019 11:05:31 -0500
Message-Id: <20191021160532.7719-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021154533.GB12140@elm>
References: <20191021154533.GB12140@elm>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In the implementation of aa_audit_rule_init(), when aa_label_parse()
fails the allocated memory for rule is released using
aa_audit_rule_free(). But after this release, the return statement
tries to access the label field of the rule which results in
use-after-free. Before releasing the rule, copy errNo and return it
after release.

Fixes: 52e8c38001d8 ("apparmor: Fix memory leak of rule on error exit path")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v3:
	-- applied Tyler Hicks recommendation on err initialization.

 security/apparmor/audit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 5a98661a8b46..597732503815 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -197,8 +197,9 @@ int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	rule->label = aa_label_parse(&root_ns->unconfined->label, rulestr,
 				     GFP_KERNEL, true, false);
 	if (IS_ERR(rule->label)) {
+		int err = PTR_ERR(rule->label);
 		aa_audit_rule_free(rule);
-		return PTR_ERR(rule->label);
+		return err;
 	}
 
 	*vrule = rule;
-- 
2.17.1

