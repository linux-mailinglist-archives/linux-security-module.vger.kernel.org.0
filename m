Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82B466333F
	for <lists+linux-security-module@lfdr.de>; Mon,  9 Jan 2023 22:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjAIVkD (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 9 Jan 2023 16:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238093AbjAIVjf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Jan 2023 16:39:35 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A75236325
        for <linux-security-module@vger.kernel.org>; Mon,  9 Jan 2023 13:38:20 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id h1-20020a17090a470100b0022646263abfso3677113pjg.6
        for <linux-security-module@vger.kernel.org>; Mon, 09 Jan 2023 13:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g7XZ6zbY4DVhx/1OXdLF/gOX5xZT7N2TM5K+hmXQB+Q=;
        b=lp6mFgIFtl15wfLpEIICylaN7ba0rLKWyBcSmwWXHBIHGw2PfI8uc5JoYpz78iGrzt
         q7BwcvepUR121HS9evBvJZvukxIVfLEQnv4pKm0uyiAQHZ2lPiVMGwyZcSxUFbhaL90/
         ucKWwiEICRsvndQmUOtOCqlM9msyGSEUsXD5lwlIQfLeTtimxNUVh0grkxXS2J8ZCHmG
         Om+IZIdCATJX9OXIuWLzOFPLT1CV83yldN+eGwxCxvUZBerXOoxKxtFA5g5ttfCJSVS7
         8JY1ciKixBdA0fOe8xhy0huWzEPzI2dQz1uyE93OBKFPfOC0Iwt7BiU0pYO43R8uQXJv
         jjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g7XZ6zbY4DVhx/1OXdLF/gOX5xZT7N2TM5K+hmXQB+Q=;
        b=lIFMD9GrE5i7jFQoTGU+gNbvIRHVv2nk2T4hKpTgUZD96EMBs331EMGmzOXpIwaoAI
         9edyTVKU4Qwjy1VwTa5IaW63rhOSh5V3zb3oTSoBkiqHsU79AMtMOfX7it0qq8p/+sO2
         mZ3KcS374ctt1Rv2mANiiId9QKMuHZBrRm88PtBxYD/yWvKT3gNQTMlUHSJRaMz5a8Ef
         tVLhhu5u893fRgWcnGo8Ok9NJNEeUA2O1RcmxBc59/4X4Q/e9ZBc+PDQ4DIbmTUVos4C
         6jGpaJRcugRy2f3YaaqyUOpJiEK50UTHHrMNQCBf/IZU5zkbcfbq4dQ2OJ+0DxckcbBP
         kqEw==
X-Gm-Message-State: AFqh2kotzBz74nm4Rqqh9/4C1z1osadtTsUBBCqlVQ3veaBJJ2CYW+GW
        oLnaYDHmfWv3J7jRqyAxGwZffy+BSB/iUYg=
X-Google-Smtp-Source: AMrXdXtQbTYSpTLTOjbwoiA82zlu8FrSWZKcx71vLDnaBfZa7QUA/oE7cdXqxYT9vkecD3g3+ea7/6F21U6cq64=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a05:6a00:1384:b0:56b:9ce2:891f with SMTP
 id t4-20020a056a00138400b0056b9ce2891fmr3675608pfg.43.1673300299885; Mon, 09
 Jan 2023 13:38:19 -0800 (PST)
Date:   Mon,  9 Jan 2023 21:38:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109213809.418135-1-tjmercier@google.com>
Subject: [PATCH 0/4] Track exported dma-buffers with memcg
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Based on discussions at LPC, this series adds a memory.stat counter for
exported dmabufs. This counter allows us to continue tracking
system-wide total exported buffer sizes which there is no longer any
way to get without DMABUF_SYSFS_STATS, and adds a new capability to
track per-cgroup exported buffer sizes. The total (root counter) is
helpful for accounting in-kernel dmabuf use (by comparing with the sum
of child nodes or with the sum of sizes of mapped buffers or FD
references in procfs) in addition to helping identify driver memory
leaks when in-kernel use continually increases over time. With
per-application cgroups, the per-cgroup counter allows us to quickly
see how much dma-buf memory an application has caused to be allocated.
This avoids the need to read through all of procfs which can be a
lengthy process, and causes the charge to "stick" to the allocating
process/cgroup as long as the buffer is alive, regardless of how the
buffer is shared (unless the charge is transferred).

The first patch adds the counter to memcg. The next two patches allow
the charge for a buffer to be transferred across cgroups which is
necessary because of the way most dmabufs are allocated from a central
process on Android. The fourth patch adds a SELinux hook to binder in
order to control who is allowed to transfer buffer charges.

[1] https://lore.kernel.org/all/20220617085702.4298-1-christian.koenig@amd.com/

Hridya Valsaraju (1):
  binder: Add flags to relinquish ownership of fds

T.J. Mercier (3):
  memcg: Track exported dma-buffers
  dmabuf: Add cgroup charge transfer function
  security: binder: Add transfer_charge SElinux hook

 Documentation/admin-guide/cgroup-v2.rst |  5 +++
 drivers/android/binder.c                | 36 +++++++++++++++--
 drivers/dma-buf/dma-buf.c               | 54 +++++++++++++++++++++++--
 include/linux/dma-buf.h                 |  5 +++
 include/linux/lsm_hook_defs.h           |  2 +
 include/linux/lsm_hooks.h               |  6 +++
 include/linux/memcontrol.h              |  7 ++++
 include/linux/security.h                |  2 +
 include/uapi/linux/android/binder.h     | 23 +++++++++--
 mm/memcontrol.c                         |  4 ++
 security/security.c                     |  6 +++
 security/selinux/hooks.c                |  9 +++++
 security/selinux/include/classmap.h     |  2 +-
 13 files changed, 149 insertions(+), 12 deletions(-)


base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
-- 
2.39.0.314.g84b9a713c41-goog

