Return-Path: <linux-security-module+bounces-9201-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D33A82F8B
	for <lists+linux-security-module@lfdr.de>; Wed,  9 Apr 2025 20:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA8588422E
	for <lists+linux-security-module@lfdr.de>; Wed,  9 Apr 2025 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059CD27814D;
	Wed,  9 Apr 2025 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MjLp0N4S"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFFD1C5D63
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224812; cv=none; b=FH7SP+jS/FfUyotlHVDJIp7libXL8A5Bts+eASL1Dmc/N8mIiX2tx+xeaHxEvsKjJGt9+hsm7X/NT1WE2qR/JE4QlUTp1y7hJfCA7CCHdVX7m0miEznzflVS29BqC6k2M7zM6xruVeq228o7mx55VpWNpt4wQhr9ALBzkQjQgGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224812; c=relaxed/simple;
	bh=sLMzSrXsUIil2wRtDnFkLH+HQYSi3rPJfhvER7QLSAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=odnXWxSO42IcVwIDefZiuyPXumyG94eaECkIG2q6uSjucIgpzVdPV+qnYgY00ztYHhlhXipg0M9q51zflw4mviNCIZ5A2xBCNPmBtdHhdmupXLAgM67tjkQhMNMXq/rlhGzGu+gxAVKgXnzGE3+444qtK9U7CcM/Molhx2hnd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MjLp0N4S; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c07cd527e4so905585a.3
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 11:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224809; x=1744829609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=miFGAAuBMi9MBGwDEl9qwyMnAIkegKYbeffs6codIYs=;
        b=MjLp0N4SJh+tlcg92Vg4f1dBkA8kkcIQF29bbSBfr/4eFji3AwlrGQR50xiK5QT7tU
         ar3vZeC9BJwWGQFFNWldPxFMAYXfyl8dQG0/ZkOIXAa94zgJEuHN4nihRkeF3dnIV5Bd
         fuQoiF6RIvCJJFxIb39+rj40SnSUcA4yqvDtTfYYNn5h0OXTV3uiWcd4LCiN8yQW5NJo
         HgrJaQFAHYoj6OAK+bKYEfttTYSQwvMUvRk9JDNBsZDDLxuSVxl0T7ZLTtGwmb5Sc1tg
         /l0ZIORYd6fs4da48uC1xcctwecqa0sWUqhkFiQfYR2rvIgoF0VefCuGs9EdcmPI7pDt
         YxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224809; x=1744829609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miFGAAuBMi9MBGwDEl9qwyMnAIkegKYbeffs6codIYs=;
        b=wS5lPaZpLo+VG5PXEft54eCAeK3u4Tz/OvVZgIiXLEZTXC4HyCEpsV+kdPH9//wjzQ
         EyvNIvp3sH6y7mSHGQL6bsTHesXmSz+lf+8zheRM4yFDgza5rsZqg8fJQ2GbbLZZrtr9
         Fl8Gxf71LB4+qdu6xTM8agW/D8Thuiqe0f0mG8ClMxS7EZq7PJFj61OeUW8SjpXY2Tqy
         tpGX4OU50XYov3nOPfSn0M0/fIOMsoKCJ0jbKsi42btavwWSHPcv9NBvQJ/HdcEAZAQ2
         fiku4Znqn09sjYgWP3CucqFOZmFY9nzcvAliCv/DBVU8GLnIrXHafezPAklmRrhbEty3
         2gqQ==
X-Gm-Message-State: AOJu0Ywccys1fNNce9NKnBI+HNTqW6UqQcMsStenR0KSdU2yAmLo5mkD
	SkEWAzpQGh6f7qRiS+xgBGJqZ/FmvKwQxABrwT/fkKnXJbZitU5a3ZAkcCnjGXZW1NJayKqxfU4
	=
X-Gm-Gg: ASbGncuhTF6EsAIkr1a5fCqDCXX6/KxDUJPqSs3F8wn1Ao4EFPPjPbyob4KRKIsmsi1
	4obL0wuU4D59sZh6sH2BufCDHAxcu7Zk1H/8C2nPpYGB4WS0xFMYfZUGHDyi8y22uQ2b2y+FEvy
	RnFtV8Ku9kp64ToGrmklnxfFNKuygergiUQhVtSPl4sfb49HoLKs0AVu4VjwRd6CeaY0cJrP81R
	VuWgb5W+1Yx7lSUY0JKmrF1uJLtPq2GEnmWNfZF72LyS/ar5RoDzk0hEFwd3NN3MoUKU5L3SXTJ
	YXGuj3OHaBQjzLxF9f3QuO/MQMOMu6nx5+jU8GW3ZQqOVPhxqOxvf9YLNyjmnBZAEUtmaz809L3
	oDCfLy+jfvw==
X-Google-Smtp-Source: AGHT+IEFQZZfpjTxBPbxnAt5NtSsTZKlOx6o2FSyNOuE9kBJYVho9NQQBcVz13YHelwz1j5lnd+j9A==
X-Received: by 2002:a05:620a:4002:b0:7c5:5d4b:e62a with SMTP id af79cd13be357-7c79cc4b05cmr690761685a.54.1744224809591;
        Wed, 09 Apr 2025 11:53:29 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a10ba5d9sm106723685a.26.2025.04.09.11.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:29 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 0/29] Rework the LSM initialization
Date: Wed,  9 Apr 2025 14:49:45 -0400
Message-ID: <20250409185019.238841-31-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is one of those patchsets that started out small and then quickly
expanded to what you see here.  I will warn you that some of the
individual patches are a bit ugly to look at, but I believe the end
result is much cleaner than what we have now, fixes some odd/undesirable
behavior on boot, and enables some new functionality.

The most obvious changes are the extraction of the LSM notifier and
initialization code out of security/security.c and into their own files,
security/lsm_notifier.c and security/lsm_init.c.  While not strictly
necessary, I think we can all agree that security/security.c has grown
to be a bit of a mess, and these are two bits of functionality which
can be extracted out into their own files without too much fuss.  I
personally find this to be a nice quality-of-life improvement, and while
I'm open to keeping everything in security.c, the argument for doing so
is going to need to be *very* persuasive.

The other significant change is moving all of the LSM initcalls into the
LSM framework.  While I've always pushed to keep the LSM framework as
minimal as possible, there are some things that we really can't defer to
the individual LSMs and with the LSM framework responsible for enabling
or disabling the individual LSMs at boot, I believe management and
execution of the LSM initcalls needs to be handled in the framework as
well.  Not only does this move ensure that we aren't running initcalls
for LSMs which are disabled, it also provides us with a convenient spot
to signal when all of the LSMs have been actived (see the LSM_STARTED_ALL
patch towards the end of the patchset).  This is not a feature we
currently need, but I'm aware of some future work that does require this
so I thought it would be good to think about it now while doing this
work.

Related to the LSM_STARTED_ALL patch, the final patch in this series
adds support for LSMs to indicate if they provide lsm_prop values for
subjects and/or objects.  Casey needs this functionality for his recent
audit changes, and I personally find the counting approach presented
here to be ... less ugly I guess?

This patchset is marked as a RFC for a number of reasons: additional
testing is required, the commit descriptions could benefit from some
extra attention, and I still have hopes that some of the individual
patches could be cleaned up a bit (I still like the end result, but how
we get there could be improved).  I would really appreciate if the
individual LSM maintainers could give this a quick look, especially
the individual LSM patches that move the initcalls into the LSM
framework as some of those are non-trivial.  Mimi and Roberto, the
IMA/EVM work here was particularly "fun"; from what I've seen thus far
it appears to work correctly, but I have no idea if that code is good
or bad from you perspective.  It's perfectly okay if you want to
reject the approach taken in IMA/EVM, but we do need to move the
initcalls up to the LSM framework, so please suggest some code that
would allow us to do that for IMA/EVM.

--
Paul Moore (29):
      lsm: split the notifier code out into lsm_notifier.c
      lsm: split the init code out into lsm_init.c
      lsm: simplify prepare_lsm() and rename to lsm_prep_single()
      lsm: simplify ordered_lsm_init() and rename to lsm_init_ordered()
      lsm: replace the name field with a pointer to the lsm_id struct
      lsm: cleanup and normalize the LSM order symbols naming
      lsm: rework lsm_active_cnt and lsm_idlist[]
      lsm: get rid of the lsm_names list and do some cleanup
      lsm: cleanup and normalize the LSM enabled functions
      lsm: cleanup the LSM blob size code
      lsm: cleanup initialize_lsm() and rename to lsm_init_single()
      lsm: cleanup the LSM ordered parsing
      lsm: fold lsm_init_ordered() into security_init()
      lsm: add missing function header comment blocks in lsm_init.c
      lsm: cleanup the debug and console output in lsm_init.c
      lsm: output available LSMs when debugging
      lsm: introduce an initcall mechanism into the LSM framework
      loadpin: move initcalls to the LSM framework
      ipe: move initcalls to the LSM framework
      smack: move initcalls to the LSM framework
      tomoyo: move initcalls to the LSM framework
      safesetid: move initcalls to the LSM framework
      apparmor: move initcalls to the LSM framework
      lockdown: move initcalls to the LSM framework
      ima,evm: move initcalls to the LSM framework
      selinux: move initcalls to the LSM framework
      lsm: consolidate all of the LSM framework initcalls
      lsm: add a LSM_STARTED_ALL notification event
      lsm: add support for counting lsm_prop support among LSMs

 include/linux/lsm_hooks.h                            |   73 -
 include/linux/security.h                             |    3 
 security/Makefile                                    |    2 
 security/apparmor/apparmorfs.c                       |    4 
 security/apparmor/crypto.c                           |    4 
 security/apparmor/include/apparmorfs.h               |    2 
 security/apparmor/include/crypto.h                   |    1 
 security/apparmor/lsm.c                              |   12 
 security/bpf/hooks.c                                 |    3 
 security/commoncap.c                                 |    3 
 security/inode.c                                     |   29 
 security/integrity/Makefile                          |    2 
 security/integrity/evm/evm_main.c                    |   10 
 security/integrity/iint.c                            |    4 
 security/integrity/ima/ima_main.c                    |   10 
 security/integrity/ima/ima_mok.c                     |    4 
 security/integrity/initcalls.c                       |   97 +
 security/integrity/initcalls.h                       |   23 
 security/integrity/platform_certs/load_ipl_s390.c    |    4 
 security/integrity/platform_certs/load_powerpc.c     |    4 
 security/integrity/platform_certs/load_uefi.c        |    4 
 security/integrity/platform_certs/machine_keyring.c  |    4 
 security/integrity/platform_certs/platform_keyring.c |   14 
 security/ipe/fs.c                                    |    4 
 security/ipe/ipe.c                                   |    4 
 security/ipe/ipe.h                                   |    2 
 security/landlock/setup.c                            |    3 
 security/loadpin/loadpin.c                           |   16 
 security/lockdown/lockdown.c                         |    6 
 security/lsm.h                                       |   46 
 security/lsm_init.c                                  |  566 ++++++++++
 security/lsm_notifier.c                              |   31 
 security/lsm_syscalls.c                              |    8 
 security/min_addr.c                                  |    5 
 security/safesetid/lsm.c                             |    4 
 security/safesetid/lsm.h                             |    2 
 security/safesetid/securityfs.c                      |    3 
 security/security.c                                  |  620 -----------
 security/selinux/Makefile                            |    2 
 security/selinux/hooks.c                             |   12 
 security/selinux/ibpkey.c                            |    5 
 security/selinux/include/audit.h                     |    5 
 security/selinux/include/initcalls.h                 |   19 
 security/selinux/initcalls.c                         |   50 
 security/selinux/netif.c                             |    5 
 security/selinux/netlink.c                           |    5 
 security/selinux/netnode.c                           |    5 
 security/selinux/netport.c                           |    5 
 security/selinux/selinuxfs.c                         |    5 
 security/selinux/ss/services.c                       |   26 
 security/smack/smack.h                               |    6 
 security/smack/smack_lsm.c                           |   19 
 security/smack/smack_netfilter.c                     |    4 
 security/smack/smackfs.c                             |    4 
 security/tomoyo/common.h                             |    2 
 security/tomoyo/securityfs_if.c                      |    4 
 security/tomoyo/tomoyo.c                             |    4 
 security/yama/yama_lsm.c                             |    3 
 58 files changed, 1102 insertions(+), 724 deletions(-)


