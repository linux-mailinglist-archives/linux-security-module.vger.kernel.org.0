Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F0D25609
	for <lists+linux-security-module@lfdr.de>; Tue, 21 May 2019 18:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfEUQuJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 21 May 2019 12:50:09 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:42480 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfEUQuJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 May 2019 12:50:09 -0400
Received: by mail-lj1-f172.google.com with SMTP id 188so2304177ljf.9
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2019 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=i0j6kDnEIeaPX+1KUXPs7si1+pehMqLyQylQVBwbYdQ=;
        b=pAt/gkOM6HSmPpnHOr2potyfhHapA+fv7YdZ8Mwej7N9YXmb49ctGf7PnHuBSE8a/T
         iWCJWU7dKfqCPe8fl+PdKkxSpqMHncJT3dckU3T/Ex3cot50U3lYxHEG0sm4hI55PVh1
         t2ygIqje1rZ7OYpjtPqRDN4Ldgs2G/0nW8a6cHWs0nM7A8S42cEelG7/nyvMR2ldDibH
         MjQ6kV3sjTmqDrNYOfXSpYBwp7xTGFCz3g705R3mqOSxrtGrWg4CT4X7jGzLrVOru6wD
         dIiXUHuyl3IQpTtKHF7Wu+ywRlu9Ncce/wJfBBo674DWSRA4I4R37a0pk9azdUTS21NN
         Y4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=i0j6kDnEIeaPX+1KUXPs7si1+pehMqLyQylQVBwbYdQ=;
        b=jTrSzZi6i6e+ax4oAw12uYbJBmaoxYRZQvVEEoO02FRbwPyBye07TULwaEXbTqqnGN
         fzvVxvsOIqAXmTirrAxwq4CvWneaf/99i1I0AvVI1EYvtMVBY4ZcMcQhG8+supr9SrPX
         xcaPlYVWkFGx6Q/zmEVUgpuJxogr1f42Qyok2Ysjl8IPzceLavcXBufXWUcvu76IyoEB
         mkLWimOeUcfjBLD9ASP+J6Bhzqd+g6S2mgIw5/Rh9D/30Cf+E+PY5NnMdedbU8Inprjt
         viORBR4INSVI76U7ubMrhtLnLcR+cKgXMgOB5v5r1QFJ+uM/ivX0ZDrbu6o5nFHmwnNC
         ERaQ==
X-Gm-Message-State: APjAAAVpFOVbLAWDumw3L7agNuXlutRXANzHU3w7X5AwR98sglu09iXg
        zQPloyVzErhPyOv7v3K2lHla/Ry8DWGbE1llrUJP
X-Google-Smtp-Source: APXvYqxWgk6A9MlHhUyl+gJsVKB8GP0WXya0zsymp9swKk8LdqPHx9o76G382EqZguQYbQ8YOjZjPhLS1e3m5Ru/d44=
X-Received: by 2002:a2e:380c:: with SMTP id f12mr5075618lja.53.1558457406870;
 Tue, 21 May 2019 09:50:06 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 May 2019 12:49:55 -0400
Message-ID: <CAHC9VhTvU7kQ7D8OwRPvc0tpjtXVK6FiiT07WuQyjtJ80TeQrQ@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.2 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

One small SELinux patch for v5.2 to fix a problem when disconnecting a
SCTP socket with connect(AF_UNSPEC).  Please merge this fix for v5.2.

Thanks,
-Paul
--
The following changes since commit 35a196bef449b5824033865b963ed9a43fb8c730:

 proc: prevent changes to overridden credentials (2019-04-29 09:51:21 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190521

for you to fetch changes up to 05174c95b83f8aca0c47b87115abb7a6387aafa5:

 selinux: do not report error on connect(AF_UNSPEC)
   (2019-05-20 21:46:02 -0400)

----------------------------------------------------------------
selinux/stable-5.2 PR 20190521

----------------------------------------------------------------
Paolo Abeni (1):
     selinux: do not report error on connect(AF_UNSPEC)

security/selinux/hooks.c | 10 ++++++++--
1 file changed, 8 insertions(+), 2 deletions(-)

-- 
paul moore
www.paul-moore.com
