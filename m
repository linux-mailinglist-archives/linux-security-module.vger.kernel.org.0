Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4786C7431
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Mar 2023 00:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjCWXmC (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 23 Mar 2023 19:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCWXmB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Mar 2023 19:42:01 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868F32D156
        for <linux-security-module@vger.kernel.org>; Thu, 23 Mar 2023 16:41:50 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id cf7so310703ybb.5
        for <linux-security-module@vger.kernel.org>; Thu, 23 Mar 2023 16:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679614909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thV1/AZ1OuJuOWPw7pjV/QbFzpiTpQJ2MyO692gPvR0=;
        b=NYkNtemoCv6R5EsPq8GFyteH85EBMhiY99YqBUPV0GxorXDwZ4BHHPSZ6jApnoObXy
         jGQ/kATiHKMLZEW++ynU0B7JvOnCW6cBkdelAe/3hXU6fX57j670XX0rdqwWEYgEBugM
         uXcC0JuwpCs8op/L0zT4SdZ8DdAjD9nJ8c0NLjQvRMVrAIgmxl8MSQsY0g9jf308b89O
         Ny5DEfLM2K0uAK/anxZCKnpF3xg64462iQnVBf3Q5lJZlNStMNfnnwO2+brs/NhCVAH/
         gJkJnPcj4CS9WDqN5OLuvgCi/tHgzFwLERnhG7WUmCoHefD/Y/pZw1AJClRi01+wp5BC
         dMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679614909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thV1/AZ1OuJuOWPw7pjV/QbFzpiTpQJ2MyO692gPvR0=;
        b=0fIJ2mK2bX3L+jBWOHbGKpPTtXNHzI5az6yGdOx1OqjPXsjve+MCyws0FuXWRyiRBG
         D4ni6FDNgYL8ClSX6WWI43kbbPN75ohBEcHKT0uyo7B2o5STgvpLz2Xup6nzYHlBz+Q0
         vh8zVbfcEBhh6twnjoYKqSeE/YrUXNm2y8dDxHJDJ3f59o4TYH341naCTQDY6Bi+8k77
         QTQEI4RwS7M2qjSgKdkoSo1vGwTHPVq4/qsVtFUk5+TpRt+BWCvgqjztxx8aMru3n5wQ
         cgnx6UHeALLYFn1ydMupVTn13t+h/uYpwEY93/PZjrOfLyYNjMz9ldiZ8TcQAwlpeqGT
         bTLQ==
X-Gm-Message-State: AAQBX9fiJVw+6nRQqpE3LtfbIQcsk9yLrzEJrOoX6OaJ96W8H1G0fdeB
        Dz9QYydtJlMaMl8U85VsrZUsdqrWH5Wn1RVTtL1y
X-Google-Smtp-Source: AKy350Y07LmdJ00VZHB5SCSf+bLOqKsfH0jPu8dbkgkADvJ+KRyt25TCp5x1Uyuw9HiLKhJv2/hToxbHH1V58rKDxHw=
X-Received: by 2002:a25:db91:0:b0:b75:8ac3:d5d9 with SMTP id
 g139-20020a25db91000000b00b758ac3d5d9mr202424ybf.3.1679614909693; Thu, 23 Mar
 2023 16:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230314081720.4158676-1-roberto.sassu@huaweicloud.com> <20230314081720.4158676-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230314081720.4158676-4-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Mar 2023 19:41:39 -0400
Message-ID: <CAHC9VhS4=bH1nO6eag7zLOQrx80AAqsnCZPPJsTZ1wcQXSn0uw@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] security: Remove security_old_inode_init_security()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 14, 2023 at 4:18=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> As the remaining two users reiserfs and ocfs2 switched to
> security_inode_init_security(), security_old_inode_init_security() can be
> now removed.
>
> Out-of-tree kernel modules should switch to security_inode_init_security(=
)
> too.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  include/linux/security.h | 12 ------------
>  security/security.c      | 11 -----------
>  2 files changed, 23 deletions(-)

Merged into lsm/next, thanks.

--=20
paul-moore.com
