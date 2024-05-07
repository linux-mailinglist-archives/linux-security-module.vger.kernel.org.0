Return-Path: <linux-security-module+bounces-2953-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854198BE876
	for <lists+linux-security-module@lfdr.de>; Tue,  7 May 2024 18:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118B01F2885E
	for <lists+linux-security-module@lfdr.de>; Tue,  7 May 2024 16:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0398C16190C;
	Tue,  7 May 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJx8au/+"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE11161313;
	Tue,  7 May 2024 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098379; cv=none; b=opS4y6jzX/cjYpB1e8Nfww7Z5K3UXj9PO18SzBjV0TwQ3tyUQG68GrFa77dmUKG+o0C+UENet+arVv20wpUNm+Wmq66IwaZ6myRB8BkmtIRM7FNT7clN9M86q3OKdbiclFBsjygrX37oHYeOoBB+GCpsXP6hot0fgjos7cGL+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098379; c=relaxed/simple;
	bh=bbTDWh66UED1QLhPAXsQ6AZkQ2EoBcMaONnv7YCq/hY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e8sv4lQIpZHzwIwGyCcHtZZSSQt4oIxVb6tURkKjMNVYe0vi7yoR+f+tTRjM40ttwbzsWWXL5pxgjKFaSQBlmxE/YPkPmB8E63KcNQkvrbwCoL1QBfpErRmrK2jmWxaJYUUTEO04LQW35BVumKtxi/f41keySFxxs0SvCugEjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJx8au/+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b432be5e80so2247874a91.1;
        Tue, 07 May 2024 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715098377; x=1715703177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PKiNs+Eyb9Bn48MccDEqrFWd4i9lupG2qQOeAxxeZro=;
        b=kJx8au/+9pf5edTeIh3vn80HqFcFiz4BDSq439Al6yD5J1IH6rmdY6GUo+tu6Sx8Kz
         14wrqATnDjsRXqEJR3VP1i44l6uN6m9lU1MxPwHsJfWxsLhU4HpF0V/KZlnsTngSQUiD
         iP3E0mVKAYKEzebdvvZQa96ckO5U/LQCaxzOiFgG0AFGW21Bal6dzQ6s04lFh6mqiUO7
         mSLnjXCN9XdobGp5VwGets5etRCjdJl1H7ZuyFZodYrZF0Y4JqslgKRCWc11jdn2gl2c
         ImRYy6TubfruHpj4GnRkwnRFF1OdoNOUGJjGBjuNLXJslYfsr2fGjR5I0W5m8eq4qeha
         AqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098377; x=1715703177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKiNs+Eyb9Bn48MccDEqrFWd4i9lupG2qQOeAxxeZro=;
        b=nz+VcN4JF94ksqtyOvn3WOaExzbJJU4SMOQZYWQWwyyzNmOqesBOWF+2g+nnKQZGDv
         vvkVW9oTSQ3qit1MBnXKzZfk974Dg2spcobPKZSE97sQRc1/WCnKPGeRFWDrzP2tIm7F
         tt59XOWcXE5Ch1nmz96w7Lm+YEJ7JZXkIVKcF9WdB/Q0y+SXdBSV7wM/13jL10q+votu
         0DnWm/45Hkn/ll77OGnBb5KkSB+m+mLu6l0GNq3J3ktORCg33jzJ1Mhquvi2e8Hv/4W0
         lyVReLsG8Amea80Xe7TwAAoHkBzyc0WvL1/zQFSmfVdz6306HtnTrQeN0vBzUQHeqJDQ
         zJIg==
X-Forwarded-Encrypted: i=1; AJvYcCXPT31nhcKcLrpPGCNzQj+8GotCisJIYrMsj92uABiIFdjgKidGwUGDq3Vd9NgKiv7rAVgC+17TaUec1OBnmjsq4rvuZb/cpDMufAO9WGOix7LBkjYhhUmZUBz6E2ji0SCkLzsb2IyQHMYcq+XG93SquHCt
X-Gm-Message-State: AOJu0YxoC3fPqxSneE9SnINUjTnIgvuzEUXbAHnJOSAyTZTfHiVrY0Sf
	qrIiWvK14EPhN5FuNWAQB9JTYU2cGU8yvOyVTyb9v9zSBsosKCjxXmGXWA==
X-Google-Smtp-Source: AGHT+IEuuYCIffhrOC39efKRS9JKHBE+xaSPvS4I2ZB91kuyZJ0uPufzOcOoMgDhL3tqMFR7dFh1Bw==
X-Received: by 2002:a17:90a:ab12:b0:2b2:9855:2836 with SMTP id 98e67ed59e1d1-2b616be1f64mr5304a91.34.1715098377109;
        Tue, 07 May 2024 09:12:57 -0700 (PDT)
Received: from SYSOS.. ([115.178.65.130])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090a744900b002b1cad4fd97sm10038382pjk.25.2024.05.07.09.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:12:56 -0700 (PDT)
Sender: Leesoo Ahn <yisooan.dev@gmail.com>
From: Leesoo Ahn <lsahn@ooseel.net>
X-Google-Original-From: Leesoo Ahn <lsahn@wewakecorp.com>
To: lsahn@wewakecorp.com
Cc: Leesoo Ahn <lsahn@ooseel.net>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: fix possible NULL pointer dereference
Date: Wed,  8 May 2024 01:12:29 +0900
Message-Id: <20240507161229.4175603-1-lsahn@wewakecorp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

profile->parent->dents[AAFS_PROF_DIR] could be NULL only if its parent is made
from __create_missing_ancestors(..) and 'ent->old' is NULL in
aa_replace_profiles(..).
In that case, it must return an error code and the code, -ENOENT represents
its state that the path of its parent is not existed yet.

BUG: kernel NULL pointer dereference, address: 0000000000000030
PGD 0 P4D 0
PREEMPT SMP PTI
CPU: 4 PID: 3362 Comm: apparmor_parser Not tainted 6.8.0-24-generic #24
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
RIP: 0010:aafs_create.constprop.0+0x7f/0x130
Code: 4c 63 e0 48 83 c4 18 4c 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 45 31 d2 c3 cc cc cc cc <4d> 8b 55 30 4d 8d ba a0 00 00 00 4c 89 55 c0 4c 89 ff e8 7a 6a ae
RSP: 0018:ffffc9000b2c7c98 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000041ed RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000b2c7cd8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82baac10
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007be9f22cf740(0000) GS:ffff88817bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000030 CR3: 0000000134b08000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ? show_regs+0x6d/0x80
 ? __die+0x24/0x80
 ? page_fault_oops+0x99/0x1b0
 ? kernelmode_fixup_or_oops+0xb2/0x140
 ? __bad_area_nosemaphore+0x1a5/0x2c0
 ? find_vma+0x34/0x60
 ? bad_area_nosemaphore+0x16/0x30
 ? do_user_addr_fault+0x2a2/0x6b0
 ? exc_page_fault+0x83/0x1b0
 ? asm_exc_page_fault+0x27/0x30
 ? aafs_create.constprop.0+0x7f/0x130
 ? aafs_create.constprop.0+0x51/0x130
 __aafs_profile_mkdir+0x3d6/0x480
 aa_replace_profiles+0x83f/0x1270
 policy_update+0xe3/0x180
 profile_load+0xbc/0x150
 ? rw_verify_area+0x47/0x140
 vfs_write+0x100/0x480
 ? __x64_sys_openat+0x55/0xa0
 ? syscall_exit_to_user_mode+0x86/0x260
 ksys_write+0x73/0x100
 __x64_sys_write+0x19/0x30
 x64_sys_call+0x7e/0x25c0
 do_syscall_64+0x7f/0x180
 entry_SYSCALL_64_after_hwframe+0x78/0x80
RIP: 0033:0x7be9f211c574
Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d d5 ea 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
RSP: 002b:00007ffd26f2b8c8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00005d504415e200 RCX: 00007be9f211c574
RDX: 0000000000001fc1 RSI: 00005d504418bc80 RDI: 0000000000000004
RBP: 0000000000001fc1 R08: 0000000000001fc1 R09: 0000000080000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00005d504418bc80
R13: 0000000000000004 R14: 00007ffd26f2b9b0 R15: 00007ffd26f2ba30
 </TASK>
Modules linked in: snd_seq_dummy snd_hrtimer qrtr snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device i2c_i801 snd_timer i2c_smbus qxl snd soundcore drm_ttm_helper lpc_ich ttm joydev input_leds serio_raw mac_hid binfmt_misc msr parport_pc ppdev lp parport efi_pstore nfnetlink dmi_sysfs qemu_fw_cfg ip_tables x_tables autofs4 hid_generic usbhid hid ahci libahci psmouse virtio_rng xhci_pci xhci_pci_renesas
CR2: 0000000000000030
---[ end trace 0000000000000000 ]---
RIP: 0010:aafs_create.constprop.0+0x7f/0x130
Code: 4c 63 e0 48 83 c4 18 4c 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 45 31 d2 c3 cc cc cc cc <4d> 8b 55 30 4d 8d ba a0 00 00 00 4c 89 55 c0 4c 89 ff e8 7a 6a ae
RSP: 0018:ffffc9000b2c7c98 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000041ed RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000b2c7cd8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82baac10
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007be9f22cf740(0000) GS:ffff88817bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000030 CR3: 0000000134b08000 CR4: 00000000000006f0

Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
---
 security/apparmor/apparmorfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index bcfea073e3f2..01b923d97a44 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1692,6 +1692,10 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 		struct aa_profile *p;
 		p = aa_deref_parent(profile);
 		dent = prof_dir(p);
+		if (!dent) {
+			error = -ENOENT;
+			goto fail2;
+		}
 		/* adding to parent that previously didn't have children */
 		dent = aafs_create_dir("profiles", dent);
 		if (IS_ERR(dent))
-- 
2.34.1


