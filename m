Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C8A73B9A7
	for <lists+linux-security-module@lfdr.de>; Fri, 23 Jun 2023 16:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjFWOPs (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 23 Jun 2023 10:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjFWOPr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Jun 2023 10:15:47 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDDA1BDF
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 07:15:45 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so1129807276.1
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687529745; x=1690121745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZ40BfK4CnBhJx25kfzQB13i0/OJA6zciMTT5kdfKAo=;
        b=RFGTdVVW8Yhc1LfhCKoT7tZJjAg0vl/TG5mdh0fIXb1uQ/8Poj4XX3LsFrlUaZ3kky
         7IYnhcO5ruEmyR7utuCqLftUJ8mM1GPbHPNYS+DKKja1eh/OlXTYiBj5d+UtB74c+/JQ
         3ABB2RUM2UoIZKgFjCxsPzMFvzKLARCxWCbuK/Zk2fCsuN+KiuPjS79i0eDs/xNNGhAT
         1ixK1E5TNM4nfJEPZU3kCWXCJwP95O1WkHREf+kVnuU2jEJgVkX829HklEaFYS2/ANXE
         B6EU4ViRGvHnPAsPvkE/PHd6ClGnXdCkc+ROm4h3HH6ewVZuQvWGtnsxKkH4eQF7gyfm
         k5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529745; x=1690121745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZ40BfK4CnBhJx25kfzQB13i0/OJA6zciMTT5kdfKAo=;
        b=d5o1UlCTx5eto/HL6Z90d8sj0geWT7VOufG0EZtimacrwZhjLJI0VqdMWWMc8yMBAa
         IyaBOu/xCCuLi9lQQA4+Zqa+tpvP/I28g26jrFvc2a/V8VmSrM/++u13LGe9QmNSoEY1
         atd6lposejSxIXXH37DP2lx+lVUJWV4Fr+is1OYZULuDjT+Kbg0jelxupjUKN8eFx2od
         7CARrC1OYSgJhO+h7l/4I3appWKRQ73vwAE6Z4F3+Cpn0zGtVPvU07v+V1xHV4bzCa+t
         mSFo97cHpdHK6lYGUPxRcC11gEs3sNDUEQmCITud59ZQ3I3OLE84/6NWQRP9ZwJzb8yd
         bnzg==
X-Gm-Message-State: AC+VfDxSXBJRmzSg2z7hFWB2QhfkWBpuyL303Z2UrV+KdFuIXobjJPa8
        RrBTfJYvuAxRMYT/PpQSqzsK5dXEq8y+0PsfDehZ
X-Google-Smtp-Source: ACHHUZ4MXZenIaH7vCged36otPESh2P7/JdhFqDKhEbuyEnzoZAuU0ZxX/YyXDxCpmkkhp356crSA6yGZRW42lvEdzs=
X-Received: by 2002:a25:609:0:b0:c01:e1c0:3c70 with SMTP id
 9-20020a250609000000b00c01e1c03c70mr5873869ybg.25.1687529745019; Fri, 23 Jun
 2023 07:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230621144507.55591-1-jlayton@kernel.org> <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-76-jlayton@kernel.org>
In-Reply-To: <20230621144735.55953-76-jlayton@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Jun 2023 10:15:34 -0400
Message-ID: <CAHC9VhQEvq2MFRyj0HCDBT0+5mnbnqN_DDgrHhwPK+e+nx_xdg@mail.gmail.com>
Subject: Re: [PATCH 77/79] security: switch to new ctime accessors
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 21, 2023 at 10:49=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  security/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/inode.c b/security/inode.c
> index 6c326939750d..086280390793 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -145,7 +145,7 @@ static struct dentry *securityfs_create_dentry(const =
char *name, umode_t mode,
>
>         inode->i_ino =3D get_next_ino();
>         inode->i_mode =3D mode;
> -       inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_=
time(inode);
> +       inode->i_atime =3D inode->i_mtime =3D inode_ctime_set_current(ino=
de);

In the process of looking at inode_ctime_set_current() I ran into the
same bug others noticed regarding inode_set_ctime()/inode_ctime_set();
assuming that gets fixed this looks fine to me.

Acked-by: Paul Moore <paul@paul-moore.com>

>         inode->i_private =3D data;
>         if (S_ISDIR(mode)) {
>                 inode->i_op =3D &simple_dir_inode_operations;
> --
> 2.41.0

--=20
paul-moore.com
