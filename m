Return-Path: <linux-security-module+bounces-6607-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C4B9CDBA1
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Nov 2024 10:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8E6B24D96
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Nov 2024 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008819046E;
	Fri, 15 Nov 2024 09:32:28 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3919004B
	for <linux-security-module@vger.kernel.org>; Fri, 15 Nov 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663148; cv=none; b=pRr3X3qB41C5qcaYH/igD7oURxuKRr8Z8IKm+NdkrN/qVJ+Re+CppQdK86dMXYRiqNtMky9xioiEzB/ULGorL5g8YwoZXKiT0uijDgzyfMRRITbAeH2trP0n2WbtIFdLXh+PFWgVWRZBCu2L7/UxYl2TQ2esD81HnzzoBHYOyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663148; c=relaxed/simple;
	bh=pLEcRY782n6JBEDsQYEF4qteqYuuy8RnY6roI1WU2Vw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BJ5qrUFdJP3J4ntkrELtJGqyLsQ+BwV6VAunRJyXcPDSIrOsCjSOBWLql5qVSNGd4EIQJtLfhD0lv0T5I1idYZIVvXTb3sXLN89s/84cuvUzRH78vZouslyPTtemyA7XRL66RKtkzHuEwitX3SjIbHqn1wJ4gOXMOSryHxIFbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6c01d8df2so14508805ab.1
        for <linux-security-module@vger.kernel.org>; Fri, 15 Nov 2024 01:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731663146; x=1732267946;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/4JedLJscdKRq4iXzIJ827KeB/EVhqHO4lJWwOuHEs=;
        b=RtWp0c24oPqsFY+W+Z5PdszLZFF12c2MDJ7s/QpWTUYjltXHFOkZDo0mowMn2s1h6r
         zzt7hP/fBOwn7xwZeUW0Mwfr8kskMwToX9Wu7JEmdV7j/GvMrSMp/fJz21RadQqpy/X7
         IQtfIrFY1gqB4Y1ryV20MdMMzbE/5ZRW8ucnizUttv2ZBgRP09Vt9gbLckgQttYQWVpK
         CYCjo/RWXdGmu9khQTej0ZtkT5GFVuVB4GZU9c598qYoYOsA6BFs9oHlXWzu2NL1hXqb
         J2vjCe/UEBsx3ctTm+ichLHrKTea5KsCAPEABYZe/YRzG4TlcDRb94zKH1Xa4+Z5lw/r
         X4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm1lxdheAMjk1uda9z275mN69kZ2BjX0jTuScTokJnnlZwMxqtz822ApA6KJbdpaPlrYkTD+83borZOId2QRnMngbu1cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqwulJ8pM/XscNy5oUlkoIabBYWvNT5YPkQQoDDigzUs5YBho
	BPoVCES7TRWNuC+ZxNXi+nDdpgKgmgmzhoeKM+4SBRynb9AO2tB+FwumEd8/yFiq5lYZ/qWScGw
	Q9fZ6X1j+wbOJLSa9XcJxI3jU3+GU0Uql7bkARmX7gOiaiUiGpdpt4MA=
X-Google-Smtp-Source: AGHT+IFkNe6EY2UatPnRjrWl19SBY6KFPRa82qL/NArf+bDN37oMD9QNRnFcCmaGnthLHYlddNNg1sf4yBsqhf9D+XhJrXlzqckf
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3420:b0:3a6:b26f:a5c4 with SMTP id
 e9e14a558f8ab-3a746ffdb14mr17585525ab.8.1731663145709; Fri, 15 Nov 2024
 01:32:25 -0800 (PST)
Date: Fri, 15 Nov 2024 01:32:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67371529.050a0220.1324f8.00a4.GAE@google.com>
Subject: [syzbot] linux-next build error (18)
From: syzbot <syzbot+a521f132f5a83d10ab40@syzkaller.appspotmail.com>
To: apparmor@lists.ubuntu.com, jmorris@namei.org, john.johansen@canonical.com, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    744cf71b8bdf Add linux-next specific files for 20241115
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10525cc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ada879778ea11d6f
dashboard link: https://syzkaller.appspot.com/bug?extid=a521f132f5a83d10ab40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a521f132f5a83d10ab40@syzkaller.appspotmail.com

security/apparmor/domain.c:695:3: error: expected expression
security/apparmor/domain.c:697:3: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:699:8: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:704:11: error: use of undeclared identifier 'new_profile'

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

