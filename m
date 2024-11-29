Return-Path: <linux-security-module+bounces-6784-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 663739D6886
	for <lists+linux-security-module@lfdr.de>; Sat, 23 Nov 2024 11:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B54C281D4E
	for <lists+linux-security-module@lfdr.de>; Sat, 23 Nov 2024 10:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB9B1632FE;
	Sat, 23 Nov 2024 10:02:26 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D281AC8
	for <linux-security-module@vger.kernel.org>; Sat, 23 Nov 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732356145; cv=none; b=NCpyB09POcy8HZxeXvWE8b3HcGmfJ0YnZkS2ucbQWI0pTt1o6Odj6Et6AovkxU8ijo7behIRiKRX92sZH1wNZdpEC/Ka45NYAxtRKiSbR+ETzsdPjWgw8dAxbtk416HP+V8C4o41PMCsLu7m+2KM/moEEO0VVDMU3IpELg9/Z7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732356145; c=relaxed/simple;
	bh=eIKYcVCQQjJFBkH1lJcvxgr2iA+FCk76ApgQpF0yQlw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XGZzUHJsxYWJOCo03nr4Tv3J06JGXpz2gTOm6P4zsx6DAgkMiOeJy4zUgOxeQkd2VRo3nIlD9qv11kVCLlpBnIjx3pmA1YZ7z2VyWJi7s5Q5CjxDsIvdfaRGnDJKwE2JdfcE8ZcaTYyz8vEiFhS/gSWpqtUCl6F2hB2YlwQNWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abf68e7f0so287627439f.2
        for <linux-security-module@vger.kernel.org>; Sat, 23 Nov 2024 02:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732356143; x=1732960943;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=se6nHRVLma2x6ELMn9VIGQomPTv3OczUsSGNoxBdl3s=;
        b=P5FRycYTQJuv+jznLrkKcgbOlzvZAzsrV5tvwFkHWdN9dk3ZHUY8eoDFKug3XUjtGv
         wA2r9YXnCgM4+uVJsiY+DS0w88OtnDDgBhBfst3WSSw3joQaNYe8xRvuUN594w0EYDHS
         utTuFqE+jYezqF6wqGAEtGzaaplbP5MvUEwkgNw8WfnYRJnqNwwzQZukaooQuoluphly
         /q0hfd0PqdhZE+sPKNNyNbvJewXzc4OQmnhQbzuLxm41u1wQvoDgnT4J8G0tK/ZACYFC
         ZrEVND7TayWzDq2C7QiKubIbQJpf+/tuBq0WpO6+OrC49peD0fFC6C3DDb94/2NpLAsE
         vEsA==
X-Forwarded-Encrypted: i=1; AJvYcCXe8/pGUcAVdZ8v/PwTeN3EpveXjMGT8p6JiotX/hmci9nYqTFTKe33NM6vhvBWGc41uZbiHfQLprp8NaYbjn9qdpA4dLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkYzPR428ZCTWmqsol2T+xoN5YUoO6IGBLMH9yYH42C7b+ozLR
	LVlduMfaTPEobppnor0nvBvjjREUWgRfvugt8vxa5KSDMSX/douWeTbl1PRkq5oIwBcduutjR5Z
	UTdXBAUXRKFuvAq+L+tfYjLjGPOWnbmsB0nH562QWc2PinmKkOhxVas0=
X-Google-Smtp-Source: AGHT+IEFZw7X4VqDou46tA28UccIR9yRsRnvS4wmHsZzCcqCTVT2/cdmvQKE/N6OdTIpVcedJAC3mB3B3UpAXE1iPILHsb6Aa/Af
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1885:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3a79acfb902mr90618525ab.1.1732356143548; Sat, 23 Nov 2024
 02:02:23 -0800 (PST)
Date: Sat, 23 Nov 2024 02:02:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6741a82f.050a0220.1cc393.0004.GAE@google.com>
Subject: [syzbot] Monthly lsm report (Nov 2024)
From: syzbot <syzbot+list403996b4777f311516dc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello lsm maintainers/developers,

This is a 31-day syzbot report for the lsm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/lsm

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 28 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 409     No    INFO: task hung in process_measurement (2)
                  https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
<2> 56      Yes   WARNING in current_check_refer_path
                  https://syzkaller.appspot.com/bug?extid=34b68f850391452207df
<3> 29      Yes   KMSAN: uninit-value in ima_add_template_entry (2)
                  https://syzkaller.appspot.com/bug?extid=91ae49e1c1a2634d20c0
<4> 7       Yes   WARNING in get_mode_access
                  https://syzkaller.appspot.com/bug?extid=360866a59e3c80510a62
<5> 2       Yes   INFO: task hung in ima_file_free (4)
                  https://syzkaller.appspot.com/bug?extid=8036326eebe7d0140944

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

