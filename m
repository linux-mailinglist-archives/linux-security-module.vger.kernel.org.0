Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6CD70AAC2
	for <lists+linux-security-module@lfdr.de>; Sat, 20 May 2023 21:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjETTrR (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 20 May 2023 15:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjETTrQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 20 May 2023 15:47:16 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A64119
        for <linux-security-module@vger.kernel.org>; Sat, 20 May 2023 12:47:15 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-561bd0d31c1so40107617b3.0
        for <linux-security-module@vger.kernel.org>; Sat, 20 May 2023 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684612034; x=1687204034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ue7/cVqXgfA7kNhmyGLtkRQz93W3e/8NXAw0hFFNEc=;
        b=EKM8LbVJ8GwlUQJKb8kSEWKvl/Y3bVBhzHr9a6f3ZaoSou91MibiqYCFMlODRo7jas
         45I+9RQNUhElZgHYD+OzSsLZRLMkdeytpKkSIkQNUzpIJNsFxMyvNRm1pZ7RIlH9FPkz
         braS+fSGZmX+jTylltN6Iws1WIh5kwNAJjF+u1NCrhn89UamcoEwiRyyBFkDHSF9Nv8s
         2lnQ6RxMZt++jZLr0bod3bVekOktBgDImXSp/8f3u0J+HVFSz3P46cpi57IAPxLyxcvg
         mLjIAkFhRsSYeZ2pgTyN5dQxE/mwLil1TjYwghRYsciJIBBY2CCehvaMIwtw7UQ/sPWo
         W6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684612034; x=1687204034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ue7/cVqXgfA7kNhmyGLtkRQz93W3e/8NXAw0hFFNEc=;
        b=X+yNxpuw9lxe97b7HFasBdcadNGxsDZqaUoehwga+untt/2bRcL5dMRBRnIqowApi6
         6RsYbFu+ha6teQ8WFNrKhjXXMO3WAbvYbsKa5iVUeaS4WFXkFC40LsTVWE1/uno/iqzo
         8hJxWKc/Js98nOx4lAm+nE+3iy3DilAmlguvKEJFMV/OXDIz41PqKVOHbRXTdZjzc0CK
         YKA7U58xQevnu85Ak0xPATViOg27YxDQKLgIcrpBEqcQpWLyfg26Fg5cEAs+NSZtj5e3
         3sc0EpCWMJ//ZU0KljL4/Mc9s+Y4W86/JF3LbW5iCNjARserMmnebVS/9n7xt+F7DDcz
         HfJA==
X-Gm-Message-State: AC+VfDzf97IXw0RJplj3Ax4hVnneb7H9+kghDaC5f0vnPmezbFt9S+88
        cxAE/bz26B2XmuhAKwBLeZbgpVGkFl9gqM3rajcG
X-Google-Smtp-Source: ACHHUZ6i5FalX6tGGgh5dqOlKoU/1XDcXIr/+yjKbw4jVsrha8KamVqydhHwlCyxovFMjXNO7bq2qfG3haoVaK+2IAg=
X-Received: by 2002:a0d:e541:0:b0:55a:8226:6192 with SMTP id
 o62-20020a0de541000000b0055a82266192mr7183129ywe.7.1684612034607; Sat, 20 May
 2023 12:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d368dd05fb5dd7d3@google.com> <a800496b-cae9-81bf-c79e-d8342418c5be@I-love.SAKURA.ne.jp>
In-Reply-To: <a800496b-cae9-81bf-c79e-d8342418c5be@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 20 May 2023 15:47:03 -0400
Message-ID: <CAHC9VhSEd5BK=ROaN7wMB4WtGMZ=vXz7gQk=xjjn1-mbp_RWSQ@mail.gmail.com>
Subject: Re: [PATCH] reiserfs: Initialize sec->length in reiserfs_security_init().
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+00a3779539a23cbee38c@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        reiserfs-devel@vger.kernel.org, glider@google.com,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 11, 2023 at 10:49=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting that sec->length is not initialized.
>
> Since security_inode_init_security() returns 0 when initxattrs is provide=
d
> but call_int_hook(inode_init_security) returned -EOPNOTSUPP, control will
> reach to "if (sec->length && ...) {" without initializing sec->length.
>
> Reported-by: syzbot <syzbot+00a3779539a23cbee38c@syzkaller.appspotmail.co=
m>
> Closes: https://syzkaller.appspot.com/bug?extid=3D00a3779539a23cbee38c
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 52ca4b6435a4 ("reiserfs: Switch to security_inode_init_security()"=
)
> ---
>  fs/reiserfs/xattr_security.c | 1 +
>  1 file changed, 1 insertion(+)

Adding the LSM list to the CC line.

> diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
> index 6e0a099dd788..078dd8cc312f 100644
> --- a/fs/reiserfs/xattr_security.c
> +++ b/fs/reiserfs/xattr_security.c
> @@ -67,6 +67,7 @@ int reiserfs_security_init(struct inode *dir, struct in=
ode *inode,
>
>         sec->name =3D NULL;
>         sec->value =3D NULL;
> +       sec->length =3D 0;
>
>         /* Don't add selinux attributes on xattrs - they'll never get use=
d */
>         if (IS_PRIVATE(dir))
> --
> 2.18.4

--=20
paul-moore.com
