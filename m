Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2242FBC68
	for <lists+linux-security-module@lfdr.de>; Tue, 19 Jan 2021 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbhASQ2T (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 19 Jan 2021 11:28:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731461AbhASQXl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Jan 2021 11:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611073331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=u9Q4y96bo6R543WF3WIb9gh7PSMWrwFibDeVZ11baSM=;
        b=YpZskEslwcC1ql+JBHlrIdF4dVhhIyTG83eZVGtaXpZYmvuQKxP+s1QD72BKReQERkNXrd
        TafFgMNO/01gZxvyYDlH3eduEMrcyAU0EDZhF5Aq6q26zy9Vr5+9enFHtR0WUaiRJlgWep
        zSmKuY6X3/Fzlu/YNYm07BHjCSqbsD4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-Me7Zukm2PmG1Vmle86dbZQ-1; Tue, 19 Jan 2021 11:22:09 -0500
X-MC-Unique: Me7Zukm2PmG1Vmle86dbZQ-1
Received: by mail-ed1-f71.google.com with SMTP id g14so9699407edt.12
        for <linux-security-module@vger.kernel.org>; Tue, 19 Jan 2021 08:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9Q4y96bo6R543WF3WIb9gh7PSMWrwFibDeVZ11baSM=;
        b=SJKaudGdRB+vxJGusUGn34Y6OFCbBccoX7ezq7TLxV/bOHm6tkbbQ2imBga1n0mqFA
         iCx67eWihpKqFTW+VojKuANE41vISrvrSOCHnUPji5Ec0YjY/PZU4+vZoxmwiV27hfrR
         c/GyE08Yhs4FxJzjSPdtlIBtoYsz7Gy9E16e63VBIh/nc5crNjYXfOZPbDmrGHvoxNP6
         lzRhlujFVy7YPf4QTwclvAVUk3naYlOLlmDp/Qk0rwuaJH8kXxjXywEJyUWaAGPrJ81Z
         e03286Sv1+2+mQnQJBr5PvbUilWV8CdsEQSzvhPImD1O6JzeTe0YZmKpyjmmznbWImPY
         ktXA==
X-Gm-Message-State: AOAM532NRlZtNkYPmAuDGSFLMXlMAp2aT6g4Jqdx2czrYA/86k27fCfu
        tMyad7A1XaXn2anE6BpWAXOZPY1fYD48viFCbN6H0k6MOrZ9GFKOSKYSkFI39CtLYjcHpw/2JyU
        Cp3+KFFyva5oDGT0t6mUcSG9JUbd+B2NFvNsl
X-Received: by 2002:a17:906:b055:: with SMTP id bj21mr3576257ejb.355.1611073328352;
        Tue, 19 Jan 2021 08:22:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcHzUnJ7YyoKIR+WDesoLPvRjoftwu+C8P2YCi0ehF8psSXAN/K0sAcoG8KXYJcSh2tch14w==
X-Received: by 2002:a17:906:b055:: with SMTP id bj21mr3576247ejb.355.1611073328141;
        Tue, 19 Jan 2021 08:22:08 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id f22sm2168066eje.34.2021.01.19.08.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:22:07 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <code@tyhicks.com>
Subject: [PATCH 0/2] capability conversion fixes
Date:   Tue, 19 Jan 2021 17:22:02 +0100
Message-Id: <20210119162204.2081137-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

It turns out overlayfs is actually okay wrt. mutliple conversions, because
it uses the right context for lower operations.  I.e. before calling
vfs_{set,get}xattr() on underlying fs, it overrides creds with that of the
mounter, so the current user ns will now match that of
overlay_sb->s_user_ns, meaning that the caps will be converted to just the
right format for the next layer

OTOH ecryptfs, which is the only other one affected by commit 7c03e2cda4a5
("vfs: move cap_convert_nscap() call into vfs_setxattr()") needs to be
fixed up, since it doesn't do the cap override thing that overlayfs does.

I don't have an ecryptfs setup, so untested, but it's a fairly trivial
change.

My other observation was that cap_inode_getsecurity() messes up conversion
of caps in more than one case.  This is independent of the overlayfs user
ns enablement but affects it as well.

Maybe we can revisit the infrastructure improvements we discussed, but I
think these fixes are more appropriate for the current cycle.

Thanks,
Miklos

Miklos Szeredi (2):
  ecryptfs: fix uid translation for setxattr on security.capability
  security.capability: fix conversions on getxattr

 fs/ecryptfs/inode.c  | 10 +++++--
 security/commoncap.c | 67 ++++++++++++++++++++++++++++----------------
 2 files changed, 50 insertions(+), 27 deletions(-)

-- 
2.26.2

