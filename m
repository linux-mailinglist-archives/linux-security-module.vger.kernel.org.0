Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882DD40A47A
	for <lists+linux-security-module@lfdr.de>; Tue, 14 Sep 2021 05:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbhINDe1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 13 Sep 2021 23:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbhINDeK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Sep 2021 23:34:10 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18E8C061764
        for <linux-security-module@vger.kernel.org>; Mon, 13 Sep 2021 20:32:53 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id u4so7585957qvb.6
        for <linux-security-module@vger.kernel.org>; Mon, 13 Sep 2021 20:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cTYGJOk0HtZnk34GmZSZev++L+Eu6A0VdG3w2gebSSk=;
        b=LoFmGCHVXIJpBv7EjiyhFcYPZ1zeK88Rz3Z9xnlnacxicW2tmr8SpgAttK75HSDfkn
         /REJpc2BwJrs4ES+R/Hh7JaSdYEvcBA9BLH9TcDG4EaN8H14Xeepi/tNZ6/0/BsRSb+E
         BereThF6W/bzh0NSPxpLDFxM4AE739m5JdMOoAXLHj2LvAiOecrjVca4fC5sVSUPH5v+
         oRyiWbTVVIWhDPq+V17NChY+SlhNtB18BUSaobsgQUD6u/OBVKS/x86Dl5i5F8ubsS6p
         HheNME6zMoDJTEn2z6/O6dbtMKKCjFlwRuxa88ZIpqoEw0zhaH/aICwDLLrE4Sd7E+oc
         jUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=cTYGJOk0HtZnk34GmZSZev++L+Eu6A0VdG3w2gebSSk=;
        b=dLuSbll9n1MAqZ7Y5Ns+ygH+O24Ja+UgWFNradwUPo4TxU7SSMbmuWBV+i9/3zolIF
         QjhDNk/lV1OwqBapAFpb0YmMr3JQwxHPrh4nSub8b1uoih61CN2gHrDp0dH7UpGTwxXC
         I5IAwQ3w75UsgcooNT0H1Ka8l5FOjXLCxOf12RieGFtJPMqCn2uEvV6HnwCDdNcLX77q
         n81XlnwlNToQyttmahPpge6hj0ZH9F+78h4MQ77CXO2BYosdXG7TYXLG19uetlDzWFYf
         s8UkBLzkw6kEyXOMNGtVpeJ+eifnm4xphbcMksQm+w3dA7BegkJCqTsHT9UTuiLHuo6M
         j7MA==
X-Gm-Message-State: AOAM5309BdWeUJMkvOME+eltoOLZlfjaG1d3PfUhSgVQ6sVo5WomBhC+
        z+1RktJ2cl2QJvcAdAoGxt5sNhVkkbQZ
X-Google-Smtp-Source: ABdhPJw+SiTYfZXvJV4HBrp1gH+biruQ+EkihhZGcestyrwuN5RpAdbhg6etlOTa5sQB3RWIxy/v5A==
X-Received: by 2002:ad4:470e:: with SMTP id k14mr3192394qvz.55.1631590372558;
        Mon, 13 Sep 2021 20:32:52 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id h68sm6975543qkf.126.2021.09.13.20.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 20:32:51 -0700 (PDT)
Subject: [PATCH v3 0/8] Add LSM access controls and auditing to io_uring
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 13 Sep 2021 23:32:51 -0400
Message-ID: <163159032713.470089.11728103630366176255.stgit@olly>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

As promised, here is revision #3 of the io_uring/LSM/audit patchset.
The changes from revision #2 are minimal and noted in the individual
patches; they are mostly focused on removing debug/dev code and
scary "BEWARE, DEVELOPMENT PATCH!" language from the commit
descriptions.

With plenty of good discussion happening on the initial RFC posting,
and the second revision incorporating all the feedback garnering no
objections, I plan to merge this patchset into the selinux/next tree
later this week.  Jens, Pavel, it would nice if I could get your ACK
on the io_uring patches before I merge them.

For those of you who may be seeing this for the first time, the
second RFC revision of the patchset can be found in the archives at
the link below:
https://lore.kernel.org/linux-security-module/162871480969.63873.9434591871437326374.stgit@olly/

... and the initial draft RFC can be found here:
https://lore.kernel.org/linux-security-module/162163367115.8379.8459012634106035341.stgit@sifl/

Those who would prefer to fetch these patches directly from git can
do so using the tree/branch below:
git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 (checkout branch "working-io_uring")

-Paul

---

Casey Schaufler (1):
      Smack: Brutalist io_uring support with debug

Paul Moore (7):
      audit: prepare audit_context for use in calling contexts beyond syscalls
      audit,io_uring,io-wq: add some basic audit support to io_uring
      audit: add filtering for io_uring records
      fs: add anon_inode_getfile_secure() similar to anon_inode_getfd_secure()
      io_uring: convert io_uring to the secure anon inode interface
      lsm,io_uring: add LSM hooks to io_uring
      selinux: add support for the io_uring access controls


 fs/anon_inodes.c                    |  29 ++
 fs/io-wq.c                          |   4 +
 fs/io_uring.c                       |  69 +++-
 include/linux/anon_inodes.h         |   4 +
 include/linux/audit.h               |  26 ++
 include/linux/lsm_hook_defs.h       |   5 +
 include/linux/lsm_hooks.h           |  13 +
 include/linux/security.h            |  16 +
 include/uapi/linux/audit.h          |   4 +-
 kernel/audit.h                      |   7 +-
 kernel/audit_tree.c                 |   3 +-
 kernel/audit_watch.c                |   3 +-
 kernel/auditfilter.c                |  15 +-
 kernel/auditsc.c                    | 477 ++++++++++++++++++++++------
 security/security.c                 |  12 +
 security/selinux/hooks.c            |  34 ++
 security/selinux/include/classmap.h |   2 +
 security/smack/smack_lsm.c          |  46 +++
 18 files changed, 654 insertions(+), 115 deletions(-)

