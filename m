Return-Path: <linux-security-module+bounces-3010-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B729D8C0D2A
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2024 11:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362B5B21135
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2024 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290F614A4DD;
	Thu,  9 May 2024 09:09:30 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE87713C9D4
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245770; cv=none; b=WhqrulA0lI9Q5lVnmG+7UCbfozSYv5hK0gt6PgB4qDupwr7GAdKXr/G9vUDp49B5GpO72DMgtjaFecVup2r8dnm67xV/RCnuJqYZ5LEGry/A5Vxev05Bye1UpI+E4zWJ2teVKFqMbVEkRX9f0TWjNvvn/IgQcN8gnH2IOkcik6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245770; c=relaxed/simple;
	bh=ytulcG2hVBXjfdv2BsEYipYgZI8539mOevLNiwL9VHU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RFNAt8piMpKtRjyNo4On44jqVjPe5R5LTDMrhvZoCL3DamJmLEjLCiS0tIUM2N7cyFKo3f8d+rH4SEbZiX67r8OSfdvuamQpWL/PKvo72N+sxJGyRoFvlTiaU8FyXE0D7athLOpsh3uVkjh6RUcX1f0mM5uEOZIUoQEk5fKpZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c6dfc6134so6504935ab.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 02:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715245768; x=1715850568;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8D562yGBs8i5WORQrx0v7SIEwVWve7FyJMoaMqizq5k=;
        b=xTXMTM6SUKrv6sFfbIT/wHzgeZp0HFyRVA2OZaaSaWHBhBJiBbAxa4Qct2M6dfhsvb
         /c8jvj5VWL3az9pw5C+JzID69Pu/Yq7Y3z9PlV8lvKVHSvVM6/yFxylUViMLU+OaSzC0
         QQvhmy1pCssYMb/aHd7miWieYykos2dw1Uw5cseSntH8puwUbhihZjWxzsMtD5D7v4Ox
         /LEwtSQjHa4wxm9iPy5Quyc4/mbHz6QmhHDP0pz62Hq0H+9SZlKSelEusLzTDFl/S5hJ
         Y1OEkGY2TJq87g6Ungo/0JFmb4tZMPeFGaP5BvotU9xGPriGBUAlconUpWHMb/pzx0kJ
         3yqw==
X-Forwarded-Encrypted: i=1; AJvYcCUCRUzUBcN9ZFzX0H6xE6UWNwBvSGjiKRL9dhVxxSyalCGGuBfsnyIqVlako1tJXpzoAWg76aM87102AGDNOLVjqntscv6bhK1m04lcIM5Sp35fKH3R
X-Gm-Message-State: AOJu0Yy241HHu0OtrSrdudwupD487m51cA4oyNxx4rkjShtlqXA3u5To
	OZgYIVylx4Yy2nbeoaSsKd6JhvObzWCH/0CRvE6u6VAyabHAJOvgoGMFvkDcL85Vw9xZLJuBk9U
	aYdOiMzotbnVEQp1Ec+kPwZYWCZnh7plDYaTCe2qsyxJWh1RaIBCogDo=
X-Google-Smtp-Source: AGHT+IEydKNEtwD6pR0GHqjBkUmc3x39AWxaa1Mfx8AA9Du3xZe9hbmxeS315gojuwDiJdpAPBW+FBrnmFOfF8ahbGQKOIdA7KQm
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188e:b0:36c:4b17:e05d with SMTP id
 e9e14a558f8ab-36caed49e7cmr1440815ab.4.1715245767870; Thu, 09 May 2024
 02:09:27 -0700 (PDT)
Date: Thu, 09 May 2024 02:09:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2601a061801c6cc@google.com>
Subject: [syzbot] Monthly lsm report (May 2024)
From: syzbot <syzbot+list1a10eccb1964edee7534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello lsm maintainers/developers,

This is a 31-day syzbot report for the lsm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/lsm

During the period, 3 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 25 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 54      No    INFO: task hung in process_measurement (2)
                  https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
<2> 8       No    general protection fault in hook_inode_free_security
                  https://syzkaller.appspot.com/bug?extid=5446fbf332b0602ede0b
<3> 8       No    possible deadlock in keyring_clear
                  https://syzkaller.appspot.com/bug?extid=7e7ae1ea0744f1adce1a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

