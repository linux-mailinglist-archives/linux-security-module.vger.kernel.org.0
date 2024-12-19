Return-Path: <linux-security-module+bounces-7264-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 071A99F8374
	for <lists+linux-security-module@lfdr.de>; Thu, 19 Dec 2024 19:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5544B7A277C
	for <lists+linux-security-module@lfdr.de>; Thu, 19 Dec 2024 18:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542CD1AA1C9;
	Thu, 19 Dec 2024 18:40:24 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E891A706F
	for <linux-security-module@vger.kernel.org>; Thu, 19 Dec 2024 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633624; cv=none; b=fnI9oGXIbQ7jiKgn1DHW285GvPs4o3Zw4ak05pcqDTGNyDVbCP+Jupx30uzkfMezF60a2HtgXnuMh4zcGiFXejMa3PnCK1LxnEzPxUY9ZtgZwD+d1ZS4BchN4uN1jrveYpBuY452/lTYWj/OXIDTZ6m3m1vpfDSyzL4JZJJYiWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633624; c=relaxed/simple;
	bh=gDf+BPfIkSPnVJ7zbO7I5xjgNlAwBsHfh+/J2jqeoxc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e+1T/fN/4APFq9hiJrOUQ6M8bdsU2IrTxtIsZpWAUJ7hhHOQbU6JCjl18UJs8bNx2YqtrT+78u72J9y7er4FAbweOM3nuVkHNYWaqGYJUuVp1xPXgWjFSTRLNGpJGoAxlIPSb//Mg46nuOYNCCml1eCGxmg8PAwY8Ync60FY1oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-844db107601so94288639f.2
        for <linux-security-module@vger.kernel.org>; Thu, 19 Dec 2024 10:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734633621; x=1735238421;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8u3rMqE96D64AVGgHVJ+6NfO8SqzpxUakalREW7TUig=;
        b=WEitMQKvbSQgl0Hm6OYv8MpAQkF3CodzHoYAr6AqOKeqehTVHBkAguE1bi3vnOJHJu
         Pm1ThAeD70w3onea8cutrBiV7tc3wxdugt00isKRQEHS4v7OGEH8X6FUacCQhHzZo/hs
         qRDeqKIB3CQbcXEzjpTmol76xrAjgrMzvKq+2EynDuelxZMSp4lR3a/I4PH9CDCYh2Eq
         jbPuLbIyftMFmVIX4xMorPTOblFUcd9WmNANYp7jiu6wBvQDbKiRsYtoFLTZiYUWnmpz
         LhrAgOXATamd23lLEVOlbkNfm++tfcUWmDHhOKLBbD0ShpYjLM+h4KXACs3HhZng657g
         V92g==
X-Forwarded-Encrypted: i=1; AJvYcCUbl3VPD6eKuYJe4R+BxW2kpzD19lbY2yHv/rFqg7dRVEuLv55Btti1M6OUXI9CzAjRvWeQztMxYfV43XkVN/Dmae9ln9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8/3tMRo8Mh2vqRxmVgqV6jREuaRdtI8KO6F3nutMHiX5N4ah
	nbgEE4+kgaTdOf3beyJPfIwCaJVG+C5Z74fYLFmHvyyXHXwU4zFJB66jvqwPw1SuXpUVuPLoQo2
	IYVOTxai4xP54QpZtaCuvPZS0ZizaAQipg+/qwwKxoj1wIbDcer1wb84=
X-Google-Smtp-Source: AGHT+IHuthix/ncNKyHv6rjtpgTpO5JA62lRbGbGwRKVzn+Ch8EGZI+M+0AheUx+vCyqkVx8r1gWTQa628HJmxJLb/Yl8pqVgXZk
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c07:b0:843:f261:60e0 with SMTP id
 ca18e2360f4ac-84987c0620emr351942439f.5.1734633621418; Thu, 19 Dec 2024
 10:40:21 -0800 (PST)
Date: Thu, 19 Dec 2024 10:40:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67646895.050a0220.1dcc64.0023.GAE@google.com>
Subject: [syzbot] Monthly tomoyo report (Dec 2024)
From: syzbot <syzbot+list046505ae3554066e8ffe@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	penguin-kernel@I-love.SAKURA.ne.jp, syzkaller-bugs@googlegroups.com, 
	takedakn@nttdata.co.jp, tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"

Hello tomoyo maintainers/developers,

This is a 31-day syzbot report for the tomoyo subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/tomoyo

During the period, 3 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 11 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 22      Yes   general protection fault in tomoyo_gc_thread
                  https://syzkaller.appspot.com/bug?extid=bf6351831bc4f9148d98
<2> 6       No    BUG: corrupted list in tomoyo_try_to_gc
                  https://syzkaller.appspot.com/bug?extid=e92661ab419d1a81b816
<3> 5       No    general protection fault in tomoyo_check_acl (4)
                  https://syzkaller.appspot.com/bug?extid=2232f2316fe61cb50344

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

