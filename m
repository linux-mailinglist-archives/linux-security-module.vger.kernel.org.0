Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003371AE188
	for <lists+linux-security-module@lfdr.de>; Fri, 17 Apr 2020 17:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgDQPtB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 17 Apr 2020 11:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729204AbgDQPtB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Apr 2020 11:49:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A890FC061A10
        for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2020 08:48:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j15so1879353ejt.13
        for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2020 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SK2DjpJ81H0wAlnMT0uQHQNIO5uBhpj8BFnEJZ1lTC4=;
        b=gPdvfDd3T4XrPrvm6XUh6uLBjCbRrAfPqe/yfovh5q9QI0kURRj9KogyvqwCfBvlh6
         hQokF0x38gmMhRejaW2R+2TEKPlIQvGlYZ3kpVZAkd6PvQNCx9FOo9Ns7LDf3SrrrY6m
         5tJYXXkHErWPc7XvtxIWWxN7y5U1FPz88ggWVmM0iW3ZxO0ryvBmXyirIiGQV+L41T2Z
         feVDy1wp5kH/1IfHQOk9mfnUVaqJQ/srS1S0YWxx34ZfIO1LzbgSUfrEHURLnv1Msy01
         T7zs875eUXst7kwr9czwCODAg1vWvbSPTpt5GDt6CPGAp4hv9sqzTQpR/FUkB3c2C24R
         DBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SK2DjpJ81H0wAlnMT0uQHQNIO5uBhpj8BFnEJZ1lTC4=;
        b=DgNq+FBj7Q3oS9fpFS6Tz8QCtt2Kk7kMWgHaQIgSN7R7MC0FIjc1iDzNsARuRkfWmZ
         oxrwcd69s4Q8n5d3DsK8Mt8vifaHZ0iekMK2eJEm79PIlEYDxWy/pWYixcsfn9nGCfmm
         t9mAx2a3lszuv1zQ6LAHroDpSJQ18NEVeQxj1+f39L0M4GCrurVJa0rZ8qBKu7WI7SLP
         QrYkgeTgLcK9ELpXS0Hn7408J5QzNXku/X5JUHeecrIjsBC4WkqjRUIe4w5N5BanzWJh
         lRMtIQdOe7q5osfoVpJSvL5ixEzEoRUk32rXvHCBBxQ6N/A4IPj7osNfgPb5bMF7n+I5
         KmDQ==
X-Gm-Message-State: AGi0Pubn6krHxe8ZG+hDLqGfjEnwaqSAFgRYmp7WgINvksiF0IXlkOYl
        HG/VC+6Oi3dLJN+ID85LiD9Qd8n5gCIeyp2Pa8SD
X-Google-Smtp-Source: APiQypLQNHVwrXWXol1IlZyAyRING3CKmZueDDGqk+czzYE3Us5tpwte/dUa8eBnUo4Qnq4jCyRr2IUeXGNQ7wXMaa4=
X-Received: by 2002:a17:906:f288:: with SMTP id gu8mr3734179ejb.281.1587138538052;
 Fri, 17 Apr 2020 08:48:58 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Apr 2020 11:48:47 -0400
Message-ID: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
Subject: Problem with 9ba09998baa9 ("selinux: Implement the watch_key security
 hook") in linux-next
To:     David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I just notice that the "selinux: Implement the watch_key security
hook" patch made it's way into linux-next via 9ba09998baa9:

  commit 9ba09998baa995518d94c9a32e6329b28ccb9045
  Author: David Howells <dhowells@redhat.com>
  Date:   Tue Jan 14 17:07:13 2020 +0000

   selinux: Implement the watch_key security hook

   Implement the watch_key security hook to make sure that a key grants the
   caller View permission in order to set a watch on a key.

   For the moment, the watch_devices security hook is left unimplemented as
   it's not obvious what the object should be since the queue is global and
   didn't previously exist.

   Signed-off-by: David Howells <dhowells@redhat.com>
   Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

I'm reasonably confident that this code hasn't been tested as I expect
it would fail, or at the very least behave in unintended ways.  The
problem is the selinux_watch_key(...) function, shown below:

+static int selinux_watch_key(struct key *key)
+{
+       struct key_security_struct *ksec = key->security;
+       u32 sid = current_sid();
+
+       return avc_has_perm(&selinux_state,
+                           sid, ksec->sid, SECCLASS_KEY, KEY_NEED_VIEW, NULL);
+}

... in particular it is the fifth argument to avc_has_perm(),
"KEY_NEED_VIEW" which is a problem.  KEY_NEED_VIEW is not a SELinux
permission and would likely result in odd behavior when passed to
avc_has_perm().  Given that the keyring permission to SELinux object
class permission is variable depending on the key_perms policy
capability, it probably makes the most sense to pull the permission
mapping in selinux_key_permission() out into a separate function, e.g.
key_perm_to_av(...) (see the other XXX_to_av() functions in
security/selinux/hooks.c), and then use this newly created mapping
function in both selinux_key_permission() and selinux_watch_key().  Or
you could just duplicate the KEY_NEED_VIEW mapping code in both
functions, but I would advise against that.

-- 
paul moore
www.paul-moore.com
