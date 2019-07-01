Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034BCED05
	for <lists+linux-security-module@lfdr.de>; Tue, 30 Apr 2019 00:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfD2Wze (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 29 Apr 2019 18:55:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45289 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbfD2Wze (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Apr 2019 18:55:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id m18so6321545lje.12
        for <linux-security-module@vger.kernel.org>; Mon, 29 Apr 2019 15:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fEaW15WXnU2V0dtGDjKdZi5j8WWSKMMheyucMQDKRlE=;
        b=JE/CgKxfVFMT2O4k1B1n9IpLRcpNVbTxLJKQJSEYTPpJej7K0ymOZQzaX1eTgNVVc8
         ODi8F4XgvYkXysUUYeH7U0sX5ATTAhhd81EUxhDrUIpbYuNEdLS8mlfKINsRlSe/dLJs
         b9Yh5BhC8to5SKcjqa+Au0xXW9jjZyxpRAkzl3FiYc9JYpJrrYrCnKdwjt0+PQARyiB0
         0NAV4T6DUMqAoue9U8asntZZ/+Rn1JiITlQdsU5s6V/8GGuE6UX7iz4Q0eV5jC/mi3+0
         e9HFoyzaMDPSCYWCL65VsT9GivSoYsFKzpV/7sU70NgINIwuPaf1+IAUso45bEScsTf7
         dwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fEaW15WXnU2V0dtGDjKdZi5j8WWSKMMheyucMQDKRlE=;
        b=DB4CKW2s5G39OEcdTw0vUU+MKyBYUDBrr1bze+pD8twnw5OVvI4vp81DXa8/0Q0PSH
         l2pRW4KMmif6Fn9hrnhjCXwCMmJqU0jEP7CMHh4JiFXz3SN8a2Mxy8UaI4fTcjWxnAKc
         DDxIxkNvAAJnk0Eynto9uV7BKl+zuVNAIaOMK3LKAJD+BVzYaRP8MKNOiaLefS5qqj1d
         rTTeW15HNkS3ewiZCDJN4ttjIDxk840gpvFCEGVSLXv4lfcArXK8BtVu/vc7zXVC8dhb
         gDYkYup9XugQ91TU0R/Xgz3/FEAXkrTAj5tD+D+cGzz6NjEFkel/+hCdPtylIjAtcJJT
         ogxQ==
X-Gm-Message-State: APjAAAUq/FjLgFMl5X1gSxKbQh+C6Kk57lO0wCwNcRtJ6nvu6iqAVEWp
        49CNG8l5hnPNnaUPAyRUDHeb64Q8nyMO7LOSbucy
X-Google-Smtp-Source: APXvYqwt/xs7gpwOInhsa+VWGGSsdPSzmeyzfTV52zkPVRNXLp2xL9ILBAddJyokIiniKHcZETsfQfqIe5jw/Dtex+o=
X-Received: by 2002:a2e:888a:: with SMTP id k10mr20443582lji.57.1556578532417;
 Mon, 29 Apr 2019 15:55:32 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 29 Apr 2019 18:55:19 -0400
Message-ID: <CAHC9VhQ6QF7LvuFjr2YdYNX-3pW80nm+VJh4jK080JsKOzOVsA@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.1 (#3)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

One small patch for the stable folks to fix a problem when building
against the latest glibc.  I'll be honest and say that I'm not really
thrilled with the idea of sending this up right now, but Greg is a
little annoyed so here I figured I would at least send the PR.

-Paul

--
The following changes since commit 6a1afffb08ce5f9fb9ccc20f7ab24846c0142984:

 selinux: fix NULL dereference in policydb_destroy()
   (2019-03-18 12:19:48 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190429

for you to fetch changes up to dfbd199a7cfe3e3cd8531e1353cdbd7175bfbc5e:

 selinux: use kernel linux/socket.h for genheaders and mdp
   (2019-04-29 11:34:58 -0400)

----------------------------------------------------------------
selinux/stable-5.1 PR 20190429

----------------------------------------------------------------
Paulo Alcantara (1):
     selinux: use kernel linux/socket.h for genheaders and mdp

scripts/selinux/genheaders/genheaders.c | 1 -
scripts/selinux/mdp/mdp.c               | 1 -
security/selinux/include/classmap.h     | 1 +
3 files changed, 1 insertion(+), 2 deletions(-)

-- 
paul moore
www.paul-moore.com
