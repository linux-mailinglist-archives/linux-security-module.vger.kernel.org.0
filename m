Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49CF1D7099
	for <lists+linux-security-module@lfdr.de>; Mon, 18 May 2020 07:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgERFzY (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 18 May 2020 01:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgERFzG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 May 2020 01:55:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF94CC05BD09
        for <linux-security-module@vger.kernel.org>; Sun, 17 May 2020 22:55:05 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t40so4504846pjb.3
        for <linux-security-module@vger.kernel.org>; Sun, 17 May 2020 22:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APDZcTihvmp7cHgWc/okOQoKAjV6ESC0p6FoG4/I2RA=;
        b=B9zQ4JN8AYIxyezeNdzE6GbwPImYuyTUTkgaOcnyMLt8drlkAFBp16GCi7zqrrzQLS
         8cfO9dxZUQ1n2upwY50jdxeXPLHMYTEgyOk5KPR1DbyAlCJGW0UAcLW7PB3jp/iRXGsT
         B9XN9hHhnUnR6ItW4QHqc4AmFpJzkGeqGudHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APDZcTihvmp7cHgWc/okOQoKAjV6ESC0p6FoG4/I2RA=;
        b=VNNaSIxIkGA9XTeE2CuuFzOQ97xHWVu6JYy+hn3Bnc3/h4kznAzexRhfQeCvgx4s9Z
         hxx5w4tMM8ZdEkuHV7ukNyYaWHSWQolfv2EPNy7QwRR3ErYrXH5t3YTIYHbIanvSfWOh
         hQ9FqHka80onYLOayu5aJIkKdsCfJnTjDVNvXHlUCW6dFor15FdNdcXpRJxvOqpDbkzn
         EdJrxvgZJzTFSa7UJywaTQ8E02q4KipVlTBHUuaP+q4bt/kWp8H5ylSz/f1l+goIvyZO
         Zf/ZvUgAjL0bjFVjHVq84nvyUYWlDgxNGCFjnK/Fs1lQ82kaIqnyKb0Rma4SIg/1Kra2
         xOXg==
X-Gm-Message-State: AOAM533n33i57iMrux8vBWTTr8HnhVzQsZgl9BlWhjA+BHIdEYzUMk8t
        h4x06uNAocnY+Oo2kdBZ0vQ9Mw==
X-Google-Smtp-Source: ABdhPJxQAZtu/2s0TyYmdgb6LuY/0MGp2laY52exkkKqAzqWmG8gDpAARGenRF6/As3BMdDnDVFHyQ==
X-Received: by 2002:a17:90b:3650:: with SMTP id nh16mr16068611pjb.135.1589781305588;
        Sun, 17 May 2020 22:55:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g14sm6734674pfk.174.2020.05.17.22.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 22:55:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Relocate execve() sanity checks
Date:   Sun, 17 May 2020 22:54:53 -0700
Message-Id: <20200518055457.12302-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

While looking at the code paths for the proposed O_MAYEXEC flag, I saw
some things that looked like they should be fixed up.

  exec: Change uselib(2) IS_SREG() failure to EACCES
	This just regularizes the return code on uselib(2).

  exec: Relocate S_ISREG() check
	This moves the S_ISREG() check even earlier than it was already.

  exec: Relocate path_noexec() check
	This adds the path_noexec() check to the same place as the
	S_ISREG() check.

  fs: Include FMODE_EXEC when converting flags to f_mode
	This seemed like an oversight, but I suspect there is some
	reason I couldn't find for why FMODE_EXEC doesn't get set in
	f_mode and just stays in f_flags.

Thanks!

-Kees


Kees Cook (4):
  exec: Change uselib(2) IS_SREG() failure to EACCES
  exec: Relocate S_ISREG() check
  exec: Relocate path_noexec() check
  fs: Include FMODE_EXEC when converting flags to f_mode

 fs/exec.c                | 13 +++++++++----
 fs/namei.c               |  5 +++++
 fs/open.c                |  6 ------
 include/linux/fs.h       |  3 ++-
 include/linux/fsnotify.h |  4 ++--
 5 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.20.1

