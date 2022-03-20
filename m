Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46484E1E46
	for <lists+linux-security-module@lfdr.de>; Mon, 21 Mar 2022 00:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbiCTXfi (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 20 Mar 2022 19:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343810AbiCTXfh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 20 Mar 2022 19:35:37 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D618D6A7
        for <linux-security-module@vger.kernel.org>; Sun, 20 Mar 2022 16:34:13 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id x6-20020a923006000000b002bea39c3974so6572264ile.12
        for <linux-security-module@vger.kernel.org>; Sun, 20 Mar 2022 16:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qN8EZrK1zqj9TBgeCNo+T4ll4VaGvoLHaMPomao8fYo=;
        b=U2gOl7WwH+ZrdsOxgH5MlopdQq4CCMBASOrlioLiJpniQPWPaxcmMWXKKRnUL1n54f
         2Tk0sEDZtm8asIQwZx+UA7uBpeRdB5mA2FuNO1eUcMi3B9RAAPuSKsSftKzD3w1e0hSn
         0i8onh3OGe6OXYcVRlkF1VtuFqelD7HxqKUa8sTwddxLivi1uZDlamy2zs4f59f50Ye/
         OOXHaByIXuXTJdx4ZagMqxlAu0biR4Y/yDo+pEQnfGS1337QbcVg8o7gNbDCWewPablf
         zRk3FgMml9JgcvqjeMwhyFeHHw7z+/KrGXmVjGZUkVVZM8ul+Jg7lRIGJFDIzqwe6iWt
         GoxQ==
X-Gm-Message-State: AOAM5317MOiC5Ba0fra4qv2V4L6TWm1vRHhydwwj8ijj/freKOa/u8iW
        ao5gbGtVU9D0DLozGYV1wiabiBja/hTBS4GJxSMXoz/aCZ8I
X-Google-Smtp-Source: ABdhPJx6dWZ0E2X4HAuXYLHIG295UGzXoP0sdKG/sso8cNgW2fDjJaSS+TE1T4Mvo6HYe+Xx+ND/ZNlvmt65aXRB8gm1s2+RBzx6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be4:b0:2c7:898a:3b93 with SMTP id
 y4-20020a056e021be400b002c7898a3b93mr8498537ilv.24.1647819253103; Sun, 20 Mar
 2022 16:34:13 -0700 (PDT)
Date:   Sun, 20 Mar 2022 16:34:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c424505daaed1b7@google.com>
Subject: [syzbot] memory leak in keyctl_watch_key
From:   syzbot <syzbot+6e2de48f06cdb2884bfc@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    56e337f2cf13 Revert "gpio: Revert regression in sysfs-gpio..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b65f8d700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c80259f3b3fdf91
dashboard link: https://syzkaller.appspot.com/bug?extid=6e2de48f06cdb2884bfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1786c3b5700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171ca6b1700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e2de48f06cdb2884bfc@syzkaller.appspotmail.com

Warning: Permanently added '10.128.10.13' (ECDSA) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810ce4a200 (size 96):
  comm "syz-executor352", pid 3605, jiffies 4294947473 (age 13.720s)
  hex dump (first 32 bytes):
    e0 82 48 0d 81 88 ff ff 00 00 00 00 00 00 00 00  ..H.............
    80 a2 e4 0c 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8214e6cc>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8214e6cc>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8214e6cc>] keyctl_watch_key+0xec/0x2e0 security/keys/keyctl.c:1800
    [<ffffffff8214ec84>] __do_sys_keyctl+0x3c4/0x490 security/keys/keyctl.c:2016
    [<ffffffff84493a25>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84493a25>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
