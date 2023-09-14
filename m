Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C3A7A0DAD
	for <lists+linux-security-module@lfdr.de>; Thu, 14 Sep 2023 21:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbjINTAq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 14 Sep 2023 15:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241457AbjINTAl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Sep 2023 15:00:41 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E15B2D60
        for <linux-security-module@vger.kernel.org>; Thu, 14 Sep 2023 11:42:55 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5738cb00eebso761219eaf.2
        for <linux-security-module@vger.kernel.org>; Thu, 14 Sep 2023 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694716974; x=1695321774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wW6Cg1zJm3pIpAsBkeDcyTsYyw/bFmOedVjHRUmaqB0=;
        b=aV2KMBDNvU9cOBjNOdThSdUR+SVqEaYaJ0clxmkIM7M3VUj9sIMj4IOw3QU3YhncmL
         56yStPR7MO0vmEQNnp52TcxgruWCD+2WJYGtitOsY6HIUdzz9dqqC/SZFpQNvfMltBfE
         VmIwHxmNxX8JvrovDafsRCOMZNKRelZwi2cj2l56nljvlSpqJ7uZsCnyvPH/DMET2dXa
         VFfehfwJJ+yr8qtcLVRmnJF1+lA+i5JVirwRGeRA5GPKuNqI6CFVubTrc3jZiBZDc4SW
         g2y4DvJjmFTjcDBThbEUGoBs9FD5fpWaRn6nt41ubZgqjDR+mIYtMsKGAV6h7Q8g73Uy
         7zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694716974; x=1695321774;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wW6Cg1zJm3pIpAsBkeDcyTsYyw/bFmOedVjHRUmaqB0=;
        b=KL9gqKSXktz4SzeExVzCX+2HxuGU6nPHLM2YbEg7ngTtb2yzFOZ2ZZnZXQ+hB9uo3L
         eXbUV0OpUklJYWK7IcCo5DTzPvjluSHqq6gtE7SRGVuUYVUIWWldFhxN87d//t8gPt2e
         jelVtcpJK69RwWFDBshBbmC6iInLeTU9AonGpNMm1vthIQRQBLshFPWYB0yNmF6/+hlc
         gu3P0rcVPIEmD92Mqg77lmqZLn1+VeqMhtnIHZxzryMMYVke9bTY80HPstVutU/tEJ0E
         Ccuxp78CTarnoPcnNXDCECvUHOBp3Qc8+2uIqgYPTNxF0zmPFp35aCS4NY2NJvXYMiWf
         Zoqw==
X-Gm-Message-State: AOJu0Ywdmfkmw0FSnIkBb0P7Z695LMvbXS+gbUAWJDUM8qqgwAia7t/g
        /3YNMMC4fkpnKE4SOVjSE4Oj60JxhYDuZGUEcj0ftHl10GDSW9etIw==
X-Google-Smtp-Source: AGHT+IGPNy8EbKLj4XJ8pXuM3HonrcFslH5yiD8vr8y0o+cR6/0HT4xmd/jBQVZX5t3JRdCy/vsL1H3t0hcRku9emNs=
X-Received: by 2002:a05:6870:6393:b0:1c8:bae6:527d with SMTP id
 t19-20020a056870639300b001c8bae6527dmr7958709oap.55.1694716974516; Thu, 14
 Sep 2023 11:42:54 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Sep 2023 14:42:43 -0400
Message-ID: <CAHC9VhT4yfGtBf3ECh9gMEQg9Tx4=ZjHDj_uEDPVqR=ihWph4A@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v6.6 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

A relatively small SELinux patch to fix an issue with a
vfs/LSM/SELinux patch that went upstream during the recent merge
window.  The short version is that the original patch changed how we
initialized mount options to resolve a NFS issue and we inadvertently
broke a use case due to the changed behavior; the fix in this pull
request restores this behavior for the cases that require it while
keeping the original NFS fix in place.  Please merge.

Thanks,
-Paul
--
The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

 Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20230914

for you to fetch changes up to ccf1dab96be4caed7c5235b1cfdb606ac161b996:

 selinux: fix handling of empty opts in selinux_fs_context_submount()
   (2023-09-12 17:31:08 -0400)

----------------------------------------------------------------
selinux/stable-6.6 PR 20230914

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: fix handling of empty opts in selinux_fs_context_submount()

security/selinux/hooks.c | 10 ++++++++--
1 file changed, 8 insertions(+), 2 deletions(-)

-- 
paul-moore.com
