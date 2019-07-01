Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1095354EB
	for <lists+linux-security-module@lfdr.de>; Wed,  5 Jun 2019 03:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFEBQB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 4 Jun 2019 21:16:01 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:36711 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfFEBQB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Jun 2019 21:16:01 -0400
Received: by mail-it1-f200.google.com with SMTP id 12so609264itj.1
        for <linux-security-module@vger.kernel.org>; Tue, 04 Jun 2019 18:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tq94hQ5Or5MBqoFOhglGdojFAqBC1MTKP/WSj5YIV/8=;
        b=P6YQjHlPTkzBBqnQzNfRJFvInvERHR6ytHdKTiG+6vMUiiVX0AGhrqBPvIM86s41Nd
         RlyqA4/6Ho3X46Sgpw+fJ2U5XX21LJg5gOMEyTCPLn5+6bfytmvfJY+rPuUt3k6C1gSv
         EXuFerm7mLCPdAAFiiEuaWhRmQQWyDVIssVTs+6dbXNAauyajcVEn2a+rDTTfjH0JHlv
         9/mOAjjqr3dkiIfcLUWoJTz2D4yvYhrKvNAlrDQqpenT41iQrRs2K3ef6nDGu0kSUTWH
         NRmn2gqPG5Co/XgeKtsgTH2uQDG0BNRoaiC874WQK6kEFxlj80xGufKpOvl/+NkLVQqT
         vqNw==
X-Gm-Message-State: APjAAAX8vcERQgtu0HfhxDh7xk7NrmDh8mLOvo6g6HC0aEiFB/RDPaW8
        B9GhTxBNz7Fb4YmHYHjCt/1lNjzwulaOxE0Rlxx/x1MrsjMw
X-Google-Smtp-Source: APXvYqyZ29aiETxQGapPeY5BBEdXLC0rlE3NJCR2G4dNoGSX9gBRxgTLHXrDZB5y+iumqWQ8OcygrjVAkKZaPDKVOogeeEOvOhLK
MIME-Version: 1.0
X-Received: by 2002:a6b:e00b:: with SMTP id z11mr6761741iog.27.1559697360239;
 Tue, 04 Jun 2019 18:16:00 -0700 (PDT)
Date:   Tue, 04 Jun 2019 18:16:00 -0700
In-Reply-To: <000000000000543e45058a3cf40b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d42b5058a895703@google.com>
Subject: Re: possible deadlock in get_user_pages_unlocked (2)
From:   syzbot <syzbot+e1374b2ec8f6a25ab2e5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        dan.j.williams@intel.com, ira.weiny@intel.com, jack@suse.cz,
        jhubbard@nvidia.com, jmorris@namei.org, keith.busch@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, richard.weiyang@gmail.com,
        rppt@linux.ibm.com, serge@hallyn.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot has bisected this bug to:

commit 69d61f577d147b396be0991b2ac6f65057f7d445
Author: Mimi Zohar <zohar@linux.ibm.com>
Date:   Wed Apr 3 21:47:46 2019 +0000

     ima: verify mprotect change is consistent with mmap policy

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1055a2f2a00000
start commit:   56b697c6 Add linux-next specific files for 20190604
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1255a2f2a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1455a2f2a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4248d6bc70076f7d
dashboard link: https://syzkaller.appspot.com/bug?extid=e1374b2ec8f6a25ab2e5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165757eea00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dd3e86a00000

Reported-by: syzbot+e1374b2ec8f6a25ab2e5@syzkaller.appspotmail.com
Fixes: 69d61f577d14 ("ima: verify mprotect change is consistent with mmap  
policy")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
