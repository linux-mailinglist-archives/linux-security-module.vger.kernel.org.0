Return-Path: <linux-security-module+bounces-5637-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBD397E80C
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Sep 2024 11:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3266CB20E5A
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Sep 2024 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8330A19415E;
	Mon, 23 Sep 2024 09:02:24 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076244C8C
	for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082144; cv=none; b=epjgHDnNEJ7uYmV0zxF0ZciZTaZyHq1V/oSpOwKKZuLuPLkePt5F0gXNcy614pMf2gRRDJJl4CHlwQATIOFVy+aS0wKaXiNcjkfyFIezTCDGAoHWH9caXvJBWBqMwFJoSXP2WlnH/oYrTNnhMQGXN4hV8MQstKe9df+gDa/u+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082144; c=relaxed/simple;
	bh=zjYN+6XNObuuD6Fgeuukf6MO590AzBoG+ZyBDnAYjHQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XsMn7lDQJkokqVh6sFKaDQDpp+s3Mr9keQiEWFzjYmTa9BWO2KpQoT+dqYzjle0hwuw9haDc0JVjjEpVlVHIL0aUy2g5DwIO2nXH4Ibmb3BKFzldObe8LZLNGwyA++XF/ZinuFlPoD569jVdV/X69QsbyQK61NRlUoqCeir3abI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a19534ac2fso24655495ab.2
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 02:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082142; x=1727686942;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWuOSJPdiAi2bYO8+Uv3jbCSpy3BYawpRw6/d3ft83A=;
        b=lwrcVrLLzEiC+onEyYwo5GXBjFkH/DFmfemQmw+ky5j8TyxWk1vzAU45+1BGoxpMGy
         RUIwotVUZnL8DTY89IgniHzqUh2nv7F/d8acO1LU0pLntUJ6uzlKwD5CZ91F5GYxh1dA
         RmHXLEXQTySbT1JJgPOnv2JYQzbqy0K8rZH2L2GcHJ7GtMmDXJQHthlrZ+wyuYRxg1AJ
         TICNYKX1yXW3NLc82DqA+seOYIH7TCjK7nJQbjqsoln+tqPqP1AuHphKDeC+bselj7eS
         LTkKWRlGjoU0fdBmS4zo4BiUXer18BXoCgoaGLPZKoJfpLzRLdAVGzk4kBsKmpfjrg0A
         N5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUfUfIBTacfokgCkj5xOPVfhk/z0avMFXT+Pu8J/gQI3zm7djeT1Ztnkzpva23PN+s4nNDC9xxFdEZCEzqtYQJMwhtFm/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJp/dJxp9ZoagF5jM7xXnwWjCSgxGe+lz5zbeHDg6R8LkQjgbz
	bCRczC1cJ2bK0bd7z8RRf0KXiJKlmyUH3yeZI7bYMEPJuqiZYlYXGIROYvetWKNsVi6IY18emuZ
	iZAR8qWKnPK3htEixpLZHSTMxOSgttnYaVECurSvBYkbC+zUkHno62dw=
X-Google-Smtp-Source: AGHT+IGpY1JfcOhf7M78o2gWPkVjnHWZjnOfDvV7XM6hmxug7L/cN8DTFKoD6Y275/LyHBWILVfa4UaPIsxt/qYK07JEGZKtd7fa
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:3a0:9026:3b65 with SMTP id
 e9e14a558f8ab-3a0c8d3d77cmr82137435ab.25.1727082142225; Mon, 23 Sep 2024
 02:02:22 -0700 (PDT)
Date: Mon, 23 Sep 2024 02:02:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f12e9e.050a0220.3eed3.0009.GAE@google.com>
Subject: [syzbot] Monthly lsm report (Sep 2024)
From: syzbot <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello lsm maintainers/developers,

This is a 31-day syzbot report for the lsm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/lsm

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 27 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 306     No    INFO: task hung in process_measurement (2)
                  https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
<2> 9       No    general protection fault in smack_inode_permission
                  https://syzkaller.appspot.com/bug?extid=4ac565a7081cc43bb185
<3> 3       Yes   WARNING in current_check_refer_path
                  https://syzkaller.appspot.com/bug?extid=34b68f850391452207df

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

