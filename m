Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B030026CDC2
	for <lists+linux-security-module@lfdr.de>; Wed, 16 Sep 2020 23:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgIPVE5 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 16 Sep 2020 17:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgIPQPB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101DEC0D9419
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 07:52:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o5so7173083wrn.13
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Jprj3Ljb1hJqVas03n8biEIlmZI1CNLC20MekGwZ6qM=;
        b=AZNeyeOMfnv1iw6EUbZxwoPYMEiCX84IG2zN8hU26Bn77jdCTqA4AnlrrvQj5LSZoH
         Xw0/DwrzjcgpzUOhzGqZiLEU07teqHaVbZelkyFe0jmVlJiYh2xNrTWb6M8qYbW8xPHC
         8vZ5C/bAiUZA87xhIrHQSpggRDb+fASpYhozE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Jprj3Ljb1hJqVas03n8biEIlmZI1CNLC20MekGwZ6qM=;
        b=TtSXl8qQF2GkhwHGAoV5a//UjLzaGWbkzs3tJr1NXKvOfeK3yqlN+XFwmYu22Cuywn
         CQ/WUar1uC0Cyc8y4XVVWEHOgc1wo7Rh4+GZ1WlZW5IMlTsV1fiose1usaf5ZYbW8jex
         GCpnESvwaQ/a7m4gy4vM97zb0bbRhlHUNIenxKoobrthPtpwjhapbZ15QfbXxxzh4eBh
         25DVnYEwa7NZpqpzGMGVF6+wVvAbs1LS9J8X++5apk8l8Wtma6yMMM467oqd4hQy6Peh
         vUpxRgklETZV8f8rDWOGwdgJ7B5VqEQJ+t+RtxLXQQIRxjy6OaIBa2H7E0lxahDb2lto
         aZIA==
X-Gm-Message-State: AOAM532pf6h4AlyGmZ0XxIjrcticsTDYkIg3AaILWkWXDK/8okiLUfZy
        27h916Mt4GUa70yrB4+ivVIRBb+JIBcPXZkk3iL/M7A/yrGRekiv
X-Google-Smtp-Source: ABdhPJzs4OEsf1kM0ZNCGKyUVbO+v3o4OUzHCNsOvXaX4m5BYp7TOLc7AQVnFz3jjb00B8Zr0J0N8RKNgx+x8wr0R/w=
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr27884370wrr.269.1600267923353;
 Wed, 16 Sep 2020 07:52:03 -0700 (PDT)
MIME-Version: 1.0
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 16 Sep 2020 16:51:52 +0200
Message-ID: <CACYkzJ6fVfQOEztvsbMHXg7y3OkSUUdZ+dkg7pQAPb0GDcUxJg@mail.gmail.com>
Subject: [TEST]: Patches not making it to the lists
To:     Linux Security Module list <linux-security-module@vger.kernel.org>
Cc:     James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The mailing lists seem to be silently dropping my patches. it gets
delivered to the CC'ed folks but does not appear any archives or
delivered to the subscribers. The patch is not in HTML and was sent
using git send-email.

I don't get a bounce back either and replying-all does not help (my
colleague tried it as well and it did not appear on the list)

I can think of two possibilities:

- My email is triggering a spam filter. In which case this email won't
be delivered either.
- The body of the patch is causing something to crash on the mailserver.

Here's the patch ("ima: Fix NULL pointer dereference in
ima_file_hash") on a github gist for your reference:

https://gist.githubusercontent.com/sinkap/6dd3829a8259343a6b178cef3f59342b/raw/2b3152a48d77b1c65d0e1b5b8b2e8b6ae6d04ec5/ima.patch

- KP
