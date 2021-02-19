Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9053201BD
	for <lists+linux-security-module@lfdr.de>; Sat, 20 Feb 2021 00:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBSX3m (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 19 Feb 2021 18:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBSX3l (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Feb 2021 18:29:41 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF9EC061574
        for <linux-security-module@vger.kernel.org>; Fri, 19 Feb 2021 15:29:00 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id h8so7272308qkk.6
        for <linux-security-module@vger.kernel.org>; Fri, 19 Feb 2021 15:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=I5IfKRdXnnleoBgn0KNJJhjGg9GGixgu98+3KfCYNQY=;
        b=uqBuAO5gv0zEWZQGwq2/w8bG8TOPKp6cEswcWJSsnGkpjNuLsZnUJ0VB8/MiL+yhf7
         tZSx+OpRi1gya46Ce+2nVqY6z2CtnXTBxaJa63j+H5PrMz06z4alN4N6BukTpGbCDmLF
         qjzvcPygcpZHrmDxzXd8GYlBzVGcMFo5kX8/m+W+jd5/t+e+ObYNk1N/FQVVCwJ2ZUHa
         XFw7g5Fs8ezFkMlCpyITGPSWe9CdiV2xUJbtFjUh7pwl9clnyc4HS92iIrlVRIbgcXIJ
         noATY4lfH1ObcE0wwFAl0Q2vSKmYbiFfxng0wNRlNVg+/A+aslJZg5hoQMsNHsdLjQUn
         0F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=I5IfKRdXnnleoBgn0KNJJhjGg9GGixgu98+3KfCYNQY=;
        b=QWtQSU2AY2a9b94ZeZaZ9c7hx7WYeJ13VpmNr8aIXol2ko/PWuZk5dtskpokwyphct
         xSigr0IHkzUm9TUPj+FtnnwbpjmwHiT0yvly2uM1v1wfXfwG2XLwqzJie9mO8iPp0e4x
         I7+ZfvypozdlVC1SKwuKEjHePA47AR4yyPy28Np+Uv9056DKrNotDypmvEe71aGLKo9B
         Op97dkKIKTP5Mun0Symeh66o31CWHMbi9l84gU77EiVJC6Uhf9zkpnYi+e5qjNznfgdw
         ES8lZ9PEpyqUREDBwwfcRzygXig6+1E8UOyR5dXM6Eble8kr68eaAx+a/QoZTrW9GGed
         3YAg==
X-Gm-Message-State: AOAM530+FrgUv9QQ6WNM+MZeB500QBsy/XRItLM0ylQPTCdDbxNqk5A4
        stbJ6ttR+QenZp+20j0JDDrvkASW9DHpODA=
X-Google-Smtp-Source: ABdhPJwgWsJeEMkcOJmtUzyQANZ/Grg+TX2XWY1BJccuBbUg3v+MNFHxWd696WqhMyJQrJBCr9CNjg==
X-Received: by 2002:a05:620a:1315:: with SMTP id o21mr11803309qkj.3.1613777339953;
        Fri, 19 Feb 2021 15:28:59 -0800 (PST)
Received: from localhost ([151.203.60.33])
        by smtp.gmail.com with ESMTPSA id l24sm6370024qtj.50.2021.02.19.15.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 15:28:59 -0800 (PST)
Subject: [RFC PATCH 0/4] Split security_task_getsecid() into subj and obj
 variants
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Date:   Fri, 19 Feb 2021 18:28:58 -0500
Message-ID: <161377712068.87807.12246856567527156637.stgit@sifl>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

As discussed briefly on the list (lore link below), we are a little
sloppy when it comes to using task credentials, mixing both the
subjective and object credentials.  This patch set attempts to fix
this by replacing security_task_getsecid() with two new hooks that
return either the subjective (_subj) or objective (_obj) credentials.

https://lore.kernel.org/linux-security-module/806848326.0ifERbkFSE@x2/T/

Casey and John, I made a quick pass through the Smack and AppArmor
code in an effort to try and do the right thing, but I will admit
that I haven't tested those changes, just the SELinux code.  I
would really appreciate your help in reviewing those changes.  If
you find it easier, feel free to wholesale replace my Smack/AppArmor
patch with one of your own.

---

Paul Moore (4):
      lsm: separate security_task_getsecid() into subjective and objective variants
      selinux: clarify task subjective and objective credentials
      smack: differentiate between subjective and objective task credentials
      apparmor: differentiate between subjective and objective task credentials


 security/apparmor/domain.c       |  2 +-
 security/apparmor/include/cred.h | 19 +++++--
 security/apparmor/include/task.h |  3 +-
 security/apparmor/lsm.c          | 23 ++++++---
 security/apparmor/task.c         | 23 +++++++--
 security/selinux/hooks.c         | 85 ++++++++++++++++++--------------
 security/smack/smack.h           | 18 ++++++-
 security/smack/smack_lsm.c       | 40 ++++++++++-----
 8 files changed, 147 insertions(+), 66 deletions(-)

--
Signature
