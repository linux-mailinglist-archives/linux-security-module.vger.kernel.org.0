Return-Path: <linux-security-module+bounces-4581-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE29439C3
	for <lists+linux-security-module@lfdr.de>; Thu,  1 Aug 2024 01:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D55C1F21D43
	for <lists+linux-security-module@lfdr.de>; Wed, 31 Jul 2024 23:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD16189B9A;
	Wed, 31 Jul 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaFYhRSZ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B83171092;
	Wed, 31 Jul 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470187; cv=none; b=qj2wIhrmcxM2gMWKkhe65Am7UK7GH48/h6il9/tGNtywpGYDYoxgJmlzGAKSxG0409pFUIYETxCHQtAVFjwUEe7DEoKdDNdYCkbfpf2kxcK9modmnoYFgcIOFymkn/Mq8WnGX7tI7d0D2f1tO4FGEDWTNcs9psCWVvp4qs00yQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470187; c=relaxed/simple;
	bh=NqDoeRrjks1G5Aw5HYm25tIhR6gmk9Tw4E1W+3F1Sx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJk9WjGPdLdLQLggtqfLf/2qJRE4hGLjNn52FnbhT+6Tyj7dWasU3+fE+uNY7R9Rmo+1os54RBPjo/V5KNK62wSPXIUFhRQEBBLTC173GKq6Cgjt2R5YdyemGSZphK2MeOJiB81v2T52M3vna+hmlmVePzC5p3AGnf9l9hrESlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaFYhRSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B482DC116B1;
	Wed, 31 Jul 2024 23:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470187;
	bh=NqDoeRrjks1G5Aw5HYm25tIhR6gmk9Tw4E1W+3F1Sx4=;
	h=From:To:Cc:Subject:Date:From;
	b=YaFYhRSZXU6VmGtqvtKG24RGJBin/Afm6vi7cRg8mOhqHCW0usJXFbQTJ2lGH/rTC
	 kWdVznmVALYZbVi8VSb0S287uyClqRG4RcelhdH8CqZjUx5DvDelgW8AHPlvqwtw71
	 yozX7OjDOVdqEuLurZyDj7qIF51u0vv38E1nws1J4nwqqZOlK6kvrT+wNRhAnEnt9w
	 6r5BJsaS9ip3LSOuAdUStB0XWnUXr9fvG4q4xujuyMYNRVRFIbCG4EDdkfvRWtnGla
	 uo3pRdKTEn/p+569Krc1h7PWGm709wVEpcH8DJiMIgpNaS9M0rNgm1Y67OfxfNMQO4
	 MFo2ZDyCi8Kdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leesoo Ahn <lsahn@ooseel.net>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/2] apparmor: fix possible NULL pointer dereference
Date: Wed, 31 Jul 2024 19:56:22 -0400
Message-ID: <20240731235624.3929717-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: Leesoo Ahn <lsahn@ooseel.net>

[ Upstream commit 3dd384108d53834002be5630132ad5c3f32166ad ]

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
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/apparmorfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 62736465ac82a..efe04f54be9ed 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1593,6 +1593,10 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
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
2.43.0


