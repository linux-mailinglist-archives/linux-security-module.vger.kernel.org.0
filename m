Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EB9250D61
	for <lists+linux-security-module@lfdr.de>; Tue, 25 Aug 2020 02:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgHYAcI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 24 Aug 2020 20:32:08 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:52301 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgHYAcF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Aug 2020 20:32:05 -0400
Received: by mail-il1-f197.google.com with SMTP id q16so7869490ils.19
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 17:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=c5Kv1Rn0yV+exH6v0x9JjcLClh6/0bR8a+fScfVRIVU=;
        b=SsCAwxY333fGMqcsx3dWmd3SXUkZJQHDv5xSK9igfqMl7uqf9Xcd5AQM1ZFw0u0SM1
         h7OsOJmRx3gnk3orQGEOjarrjOB6nfdAHDMVWbkXN34xd/3Qsw3Yb6YXP2uns/sVlBJv
         WL7Jr1uMA7rucgKYgsF4mlk9pr0VbtTCoody/g808MMSWu0hoMOVnDaNziwAGZPS5ldh
         L2/ojArrBiVE170fq35s1iVe8fA/05Am/p8Fs9QUvXpdEry2AWgUxKIfd1G//A3ySnyT
         syjoEXx/S+SP/95NHY/93hF+IhvQp4pSRaRf+63NekbEHiZgXitY1oa22tFxHxOCezma
         INYA==
X-Gm-Message-State: AOAM532hsAnTJNBHAHNqtzeE8rNxZAvD7PvN1yJ9v15gXL//2pqWph9k
        DCwZ1zilYaM7Ff4EaC8rOrgMeaTY3MiVOfiWFNN5IDHm0r+L
X-Google-Smtp-Source: ABdhPJx5MOMoD70oFHm4ifkadWV41DDpC3TBkUtcU2ajYZ2Tp6W0+CZhNsxmqkl6PMO/AuyVZqFpYAiqtEXzphpRRafjmRKmf4LA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ca:: with SMTP id v10mr7365206ilj.105.1598315525364;
 Mon, 24 Aug 2020 17:32:05 -0700 (PDT)
Date:   Mon, 24 Aug 2020 17:32:05 -0700
In-Reply-To: <0000000000008caae305ab9a5318@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020e49105ada8d598@google.com>
Subject: Re: general protection fault in security_inode_getattr
From:   syzbot <syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, jmorris@namei.org, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        netdev@vger.kernel.org, omosnace@redhat.com, serge@hallyn.com,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot has bisected this issue to:

commit 35697c12d7ffd31a56d3c9604066a166b75d0169
Author: Yonghong Song <yhs@fb.com>
Date:   Thu Jan 16 17:40:04 2020 +0000

    selftests/bpf: Fix test_progs send_signal flakiness with nmi mode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13032139900000
start commit:   d012a719 Linux 5.9-rc2
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10832139900000
console output: https://syzkaller.appspot.com/x/log.txt?x=17032139900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
dashboard link: https://syzkaller.appspot.com/bug?extid=f07cc9be8d1d226947ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104a650e900000

Reported-by: syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com
Fixes: 35697c12d7ff ("selftests/bpf: Fix test_progs send_signal flakiness with nmi mode")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
