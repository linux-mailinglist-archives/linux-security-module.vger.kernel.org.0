Return-Path: <linux-security-module+bounces-2070-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB22879FA0
	for <lists+linux-security-module@lfdr.de>; Wed, 13 Mar 2024 00:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A735BB21610
	for <lists+linux-security-module@lfdr.de>; Tue, 12 Mar 2024 23:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E4746556;
	Tue, 12 Mar 2024 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="V8PLminV"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC946439
	for <linux-security-module@vger.kernel.org>; Tue, 12 Mar 2024 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285612; cv=none; b=jFSEGBrkU/y9R+xfTrtwd6eRcJHXP3Ir9bnwwzr0bw1IcYMOP/Y+AT0vzA3nhb1NfQkM491JCbe2SjTEboEuee/5O90B/ifUullhT4NA5plfmwQJhQ6MyfEPgVSFSHNib7778a+79ATXNT+Wl1KN+NWd4PTv/yMchmskBM82KMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285612; c=relaxed/simple;
	bh=vAGRgWrFG29ZpKaYbISAdAT2VATvqnaiTARR7UUMkQI=;
	h=Date:Message-ID:From:To:Cc:Subject; b=t5bTOvI0oobA2i4h/rnEXiW5nVn6H95JM/oohkyY4SmslH98goH6hdfNP99VIpmzq81i3QA6NM79reWOZFKPZCKs+q3JcDXUKaW1xYpl6AOxNbc+MVUTCVzIQ8xNTe6gVW1wcUx73/nJ2i1XuM86yBiRGvpSQTxeI/UmPL/pwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=V8PLminV; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-690cf6ecd3cso21707546d6.2
        for <linux-security-module@vger.kernel.org>; Tue, 12 Mar 2024 16:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710285609; x=1710890409; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4uHZt7KxGUnidCn2bJMdIjiza7wq4HXerckaAOr2KE=;
        b=V8PLminVPu/UWAvRb0sRNVUPL4rkKf+gEGl/0qSc9yl3CRfxgdJ17WRIgRM1Bv1BTH
         ONvc1qEhIIh90g/qqi0IujsxsrJGdbnxuVxgdh8Dv5qpuAuApvSE5/5GZDsWjas0tht1
         TnHltsKE8VFWQ9li1sveNvgBZ8FgibLORLFCj7adfDkF1wQt97O/nmURzXrgXFR6EA09
         CmagFkmFT3DclTDcI28CBxECMTmtbe763y0wBVvs6h66Hag2LJd16I70Eq2vXQaZzDtU
         FnrQMN8D1WfP8astpsSC9DS/0PPCiGuspJ6dcdu5AFBFg+Phjr4nbqJ2OtYZ/YqE9QCF
         Bvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710285609; x=1710890409;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4uHZt7KxGUnidCn2bJMdIjiza7wq4HXerckaAOr2KE=;
        b=o8KAHOmhVGK+IXzBe70yqu7Oz+eeAdh7sMulMBw3wAS4deXcs1qH9zkcS01chbzjTw
         hhy+AGa72sPn1f0YVu55cQKmt9KTvVDDmnC9hnIlILiHdsmaUTDULYPhW7Mw81sdWGKu
         bbQszI7Am5hLr5MrvsjlRPhhTAekfxZ9CiMlLt9ZfPPpxBux3KTJ12A4Ztpw2IsU3EOG
         BBrELz58O6g5krXriWe5NK64/IzVRlyEg4RmK1D49tjJrYgk5bTiLhO0NTsHizD0aKom
         WSTfCWoIORUOo37R9uKLNcL+VzqVmEY6NvcbW7MivIltb3qmUBH4KwELIvi3v5RFZ497
         GaUg==
X-Gm-Message-State: AOJu0YxnEKK9QwcTI2SVVVA6KJRMg8rMU7N9zWNpBV7kLo2+2dRT49OM
	KxFsJAjmfV5gbdpkXpml2/lvvDxuI+IwSCAkfwcKNlN1+nrjkdF/ow13pD43Uw==
X-Google-Smtp-Source: AGHT+IHPNUqAo9RP2k/txKA5ka2+HmtdxQBwQrHxtktbiM4yqbVOMq5En0jyq+xx4sd9Qhe5ypBJeA==
X-Received: by 2002:a05:6214:4a41:b0:690:d000:c819 with SMTP id ph1-20020a0562144a4100b00690d000c819mr7679037qvb.60.1710285609159;
        Tue, 12 Mar 2024 16:20:09 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id u5-20020a0cea45000000b006906adc8aa2sm4055062qvp.102.2024.03.12.16.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 16:20:08 -0700 (PDT)
Date: Tue, 12 Mar 2024 19:20:08 -0400
Message-ID: <75311f9f32a3cd6e4528459ea986dfcf@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240312
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Hi Linus,

There are a number of LSM patches for the Linux v6.9 merge window,
the highlights are shown below.  As a heads-up, someone just flagged
a problem with the LSM syscalls earlier today, so expect another pull
request within a few days once we've had a chance to develop/review/test
the fix.

- Promote IMA/EVM to a proper LSM

This is the bulk of the diffstat in the pull request, and the source
of all the changes in the VFS code.  Prior to the start of the LSM
stacking work it was important that IMA/EVM were separate from the
rest of the LSMs, complete with their own hooks, infrastructure, etc.
as it was the only way to enable IMA/EVM at the same time as a LSM.
However, now that the bulk of the LSM infrastructure supports multiple
simultaneous LSMs, we can simplify things greatly by bringing IMA/EVM
into the LSM infrastructure as proper LSMs.  This is something I've
wanted to see happen for quite some time and Roberto was kind enough
to put in the work to make it happen.

- Use the LSM hook default values to simplify the call_int_hook() macro

Previously the call_int_hook() macro required callers to supply a
default return value, despite a default value being specified when
the LSM hook was defined.  This pull request simplifies the macro
by using the defined default return value which makes life easier
for callers and should also reduce the number of return value bugs
in the future (we've had a few pop up recently, hence this work).

- Use the KMEM_CACHE() macro instead of kmem_cache_create()

The guidance appears to be to use the KMEM_CACHE() macro when possible
and there is no reason why we can't use the macro, so let's use it.

- Fix a number of comment typos in the LSM hook comment blocks

Not much to say here, we fixed some questionable grammar decisions in
the LSM hook comment blocks.

Please merge when you have the chance,
-Paul

--
The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240312

for you to fetch changes up to edc6670233a333ccfd1ec0548f068bd121d209c8:

  cred: Use KMEM_CACHE() instead of kmem_cache_create()
    (2024-02-23 17:33:31 -0500)

----------------------------------------------------------------
lsm/stable-6.9 PR 20240312

----------------------------------------------------------------
Kunwu Chan (1):
      cred: Use KMEM_CACHE() instead of kmem_cache_create()

Ondrej Mosnacek (1):
      lsm: use default hook return value in call_int_hook()

Pairman Guo (1):
      lsm: fix typos in security/security.c comment headers

Roberto Sassu (25):
      ima: Align ima_inode_post_setattr() definition with LSM infrastructure
      ima: Align ima_file_mprotect() definition with LSM infrastructure
      ima: Align ima_inode_setxattr() definition with LSM infrastructure
      ima: Align ima_inode_removexattr() definition with LSM infrastructure
      ima: Align ima_post_read_file() definition with LSM infrastructure
      evm: Align evm_inode_post_setattr() definition with LSM infrastructure
      evm: Align evm_inode_setxattr() definition with LSM infrastructure
      evm: Align evm_inode_post_setxattr() definition with LSM infrastructure
      security: Align inode_setattr hook definition with EVM
      security: Introduce inode_post_setattr hook
      security: Introduce inode_post_removexattr hook
      security: Introduce file_post_open hook
      security: Introduce file_release hook
      security: Introduce path_post_mknod hook
      security: Introduce inode_post_create_tmpfile hook
      security: Introduce inode_post_set_acl hook
      security: Introduce inode_post_remove_acl hook
      security: Introduce key_post_create_or_update hook
      integrity: Move integrity_kernel_module_request() to IMA
      ima: Move to LSM infrastructure
      ima: Move IMA-Appraisal to LSM infrastructure
      evm: Move to LSM infrastructure
      evm: Make it independent from 'integrity' LSM
      ima: Make it independent from 'integrity' LSM
      integrity: Remove LSM

 fs/attr.c                                          |   5 +-
 fs/file_table.c                                    |   3 +-
 fs/namei.c                                         |  12 +-
 fs/nfsd/vfs.c                                      |   3 +-
 fs/open.c                                          |   1 -
 fs/posix_acl.c                                     |   5 +-
 fs/xattr.c                                         |   9 +-
 include/linux/evm.h                                | 117 +---
 include/linux/ima.h                                | 142 ----
 include/linux/integrity.h                          |  27 -
 include/linux/lsm_hook_defs.h                      |  20 +-
 include/linux/security.h                           |  59 ++
 include/uapi/linux/lsm.h                           |   2 +
 kernel/cred.c                                      |   4 +-
 security/integrity/Makefile                        |   1 +
 security/integrity/digsig_asymmetric.c             |  23 -
 security/integrity/evm/Kconfig                     |   1 +
 security/integrity/evm/evm.h                       |  19 +
 security/integrity/evm/evm_crypto.c                |   4 +-
 security/integrity/evm/evm_main.c                  | 195 +++++-
 security/integrity/iint.c                          | 197 +-----
 security/integrity/ima/Kconfig                     |   1 +
 security/integrity/ima/Makefile                    |   2 +-
 security/integrity/ima/ima.h                       | 148 +++-
 security/integrity/ima/ima_api.c                   |  23 +-
 security/integrity/ima/ima_appraise.c              |  66 +-
 security/integrity/ima/ima_iint.c                  | 142 ++++
 security/integrity/ima/ima_init.c                  |   2 +-
 security/integrity/ima/ima_main.c                  | 148 +++-
 security/integrity/ima/ima_policy.c                |   2 +-
 security/integrity/integrity.h                     |  80 +--
 security/keys/key.c                                |  10 +-
 security/security.c                                | 775 ++++++++++-----------
 security/selinux/hooks.c                           |   3 +-
 security/smack/smack_lsm.c                         |   4 +-
 .../testing/selftests/lsm/lsm_list_modules_test.c  |   6 +
 36 files changed, 1123 insertions(+), 1138 deletions(-)
 create mode 100644 security/integrity/ima/ima_iint.c

--
paul-moore.com

