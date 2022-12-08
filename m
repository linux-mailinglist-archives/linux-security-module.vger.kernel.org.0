Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62B1646AF8
	for <lists+linux-security-module@lfdr.de>; Thu,  8 Dec 2022 09:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiLHItS (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 8 Dec 2022 03:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLHItE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Dec 2022 03:49:04 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898F1686B0
        for <linux-security-module@vger.kernel.org>; Thu,  8 Dec 2022 00:48:34 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id a14-20020a921a0e000000b00302a8ffa8e5so678906ila.2
        for <linux-security-module@vger.kernel.org>; Thu, 08 Dec 2022 00:48:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VqWjUYvuQWzVVThhoLexOpyvD8JYD0kumxHxmjGt2g=;
        b=NiCRcJ3yiqbN38a2Zg7ryQrLXb2WzjTZJ+6w2/PnMkWdzlcCm3O8SC9OvkRdLuUFY4
         JWgL/NN3iOx+geAzvhycYLgfKbH0V15tlKrqEXQf+5DVNHd5vatYa8Y7xunaMtjV87Hh
         2fmtKlmXwHAVu2uoD2DEEOgh77EOJUGlt28RpaGXuI9VV29aw2IzoVgwzjb8QkUlEbKW
         6Ow1WDp5a3tYVFC5a+vxlPxRuK4Lsh3pBrwblxVec6Q7PFAaij20Ilf8lWZxvvvE1K0R
         FEXJ6gLQVX5EaYHIjvTb/2mtKgfMig1nfKvF8C9C6KSFGWgbAJp8TQTIWrKaaw3IVSGG
         fBeQ==
X-Gm-Message-State: ANoB5plFJQ2kxZhxDi91taS4ckhXxXv29UOeHDMbDZ8fn+ugqETw7dSm
        menwXSMhzcQBSQ+wFYN95b7Iec4wByYB5QnZr+H0hW7NF2vs
X-Google-Smtp-Source: AA0mqf7J8Po0jhjVcm8aCQTLmycs2e4R5vkgSAXCxFOqvvhtjFItvSs7WEGS0OdjpuIhvRw2gEFOIhjlmh/2oOAzyftS2OKgKISi
MIME-Version: 1.0
X-Received: by 2002:a92:c887:0:b0:302:fd5c:e0a3 with SMTP id
 w7-20020a92c887000000b00302fd5ce0a3mr28917754ilo.116.1670489313757; Thu, 08
 Dec 2022 00:48:33 -0800 (PST)
Date:   Thu, 08 Dec 2022 00:48:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025d41005ef4d1a72@google.com>
Subject: [syzbot] linux-next build error (14)
From:   syzbot <syzbot+5301015e05ed3b325b0d@syzkaller.appspotmail.com>
To:     apparmor@lists.ubuntu.com, jmorris@namei.org,
        john.johansen@canonical.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-security-module@vger.kernel.org,
        paul@paul-moore.com, serge@hallyn.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    f925116b24c0 Add linux-next specific files for 20221208
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15dfabd3880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2d3e63e054c24f
dashboard link: https://syzkaller.appspot.com/bug?extid=5301015e05ed3b325b0d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5301015e05ed3b325b0d@syzkaller.appspotmail.com

security/apparmor/policy_unpack.c:316:18: error: unknown type name 'tri'
security/apparmor/policy_unpack.c:325:10: error: 'TRI_TRUE' undeclared (first use in this function)
security/apparmor/policy_unpack.c:328:9: error: 'TRI_NONE' undeclared (first use in this function); did you mean 'IRQ_NONE'?
security/apparmor/policy_unpack.c:331:9: error: 'TRI_FALSE' undeclared (first use in this function)
security/apparmor/policy_unpack.c:455:42: error: 'TRI_TRUE' undeclared (first use in this function)
security/apparmor/policy_unpack.c:529:42: error: 'TRI_TRUE' undeclared (first use in this function)
security/apparmor/policy_unpack.c:559:42: error: 'TRI_TRUE' undeclared (first use in this function)
security/apparmor/policy_unpack.c:611:42: error: 'TRI_TRUE' undeclared (first use in this function)
security/apparmor/policy_unpack.c:674:42: error: 'TRI_TRUE' undeclared (first use in this function)

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
