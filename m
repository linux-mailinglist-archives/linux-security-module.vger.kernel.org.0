Return-Path: <linux-security-module+bounces-12214-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D966EBA6360
	for <lists+linux-security-module@lfdr.de>; Sat, 27 Sep 2025 22:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722DB7A17F9
	for <lists+linux-security-module@lfdr.de>; Sat, 27 Sep 2025 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3A6227BB5;
	Sat, 27 Sep 2025 20:43:34 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F92367A0
	for <linux-security-module@vger.kernel.org>; Sat, 27 Sep 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759005814; cv=none; b=qrcZHe8nATeQEN4DAZ/2cuHSzAD5rxNaVeEOYV/AzVBW6PEAdhRyYZnyl4QtU3Fg0uRmqQzMsuAai3IeYFFAzDkHWUU8R7iGkciPYsntyPcc54Mpnwrc8zDJQDn34neYpXBQgvPk/MulpHwQebCyIuVfP/O3P2ofyovGelCCP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759005814; c=relaxed/simple;
	bh=7SkEe/zvyQysTDka38ynuqkbsVoHOJ2iyi9zBfiyT4o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rBwHujIPktile5R99HYGPcZ0ysUHDBhPS1ZzJyB0tA2NLG4KYV2RQTgepOHWFTz8qdL/Gmc+9zc+5KEOubJ6BxOVWal6BjdoI0APK/C8zbgDE8BeMvAPtPe8auxPimjZ8Rli/UK+wQZ4j+qvocv93EjMaCV+BLNc/fEbOtExOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9228ed70eb7so17842239f.2
        for <linux-security-module@vger.kernel.org>; Sat, 27 Sep 2025 13:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005812; x=1759610612;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXZUIJbPItwdz9/xAAErgDFB6Tn5IZZJ2tB/9ZZez0c=;
        b=oOIUafeugFtv+/zu3NRRZriwPX0JsWBroSgYLDGAsJgTiGSw43uBu6s1xXlIdK7R8F
         OdQdX7B0JSLO5xxwLRpS4Lv30LcHI7yP7qJrYmGH7PPS1uHIQCDbY9CMEzJDcAJWcXt0
         AJD4exrEG1BTGoKkduotyUD4BbQJJvNed+i6HjVOlC0jEZiQMZGmGEi58rr0EoXmAyZw
         rvoXrlz+bI5wQp12cKqHtl8WQzPB/np9UMQXPVl6IsRBfsfulXC3cqH74ZK+J2UZbzHD
         /Bsl99dFB2p9RPQ9smfXW9I6nRgLExDpg3+gQjqsQPBRDzuWezqq3af4RkPtJd1rghyL
         JIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG0zGlaNqgK0IK1cRvAakE56tH5TxOmJEZjPytZaRpsxZw00CgvKeV4tItp6ezW1Jm63Nz0zjjgg+jZlqV2aQ/x2yhj4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMPhtVrCa95I/ZJY+Zh7lg41g/mxWrle92klgpcmTVq1QmVOxo
	Q6djFrcPyNl41sP+Dumv/c4ftVs62P7n8b4fxrTltiFKUBj9RYdH/uIsE5OJCmBFW+GBvlWFm6x
	ZEo4jq3FAauk5cqRZ+8juEJBh7jk9gumnpOrfabCkahqbiCAzbmbui48NHLE=
X-Google-Smtp-Source: AGHT+IENnQaf2eCJDj8lumKevT293Bl2t/ol4S17x7fpk04JZjuTuu/gb6/4XOruJmaCKea7MStdMPCvmOcPnawNJCjlNPGxmNwJ
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:427:be36:2952 with SMTP id
 e9e14a558f8ab-427be362c13mr90845285ab.4.1759005812238; Sat, 27 Sep 2025
 13:43:32 -0700 (PDT)
Date: Sat, 27 Sep 2025 13:43:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d84c74.a00a0220.102ee.001d.GAE@google.com>
Subject: [syzbot] Monthly lsm report (Sep 2025)
From: syzbot <syzbot+list42e94670ec5498409de3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello lsm maintainers/developers,

This is a 31-day syzbot report for the lsm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/lsm

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 41 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 45      No    possible deadlock in process_measurement (5)
                  https://syzkaller.appspot.com/bug?extid=6529afa25091aee8536c
<2> 43      Yes   INFO: task hung in process_measurement (3)
                  https://syzkaller.appspot.com/bug?extid=cb9e66807bcb882cd0c5
<3> 13      Yes   INFO: task hung in ima_file_free (4)
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

