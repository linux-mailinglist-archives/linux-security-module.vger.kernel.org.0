Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429A9748EED
	for <lists+linux-security-module@lfdr.de>; Wed,  5 Jul 2023 22:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjGEU05 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 5 Jul 2023 16:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjGEU0w (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jul 2023 16:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80B31992
        for <linux-security-module@vger.kernel.org>; Wed,  5 Jul 2023 13:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688588766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t45r9A2YvfoSJv2GZo8UC8AtO/lxGa/2A2TsFaxOzFQ=;
        b=KvBPxlmM7mEvVLMsbCX/DAIj6BbKqGnVDhcdDKOY5frryJUrPW+4hqwqhS92uWh3DpKW3S
        hGldEEDgW8vwHY/fdrTBK2RpXHf5ZW7b2YHBVzH/oPXUDerM/7l7oAs/nuzz1RM81YElis
        CvSBJ/Ty6HOiEPf4gJ7AteLAfw5OeJc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-a2yr8pOsPZmNZ6KXpB7V_g-1; Wed, 05 Jul 2023 16:26:04 -0400
X-MC-Unique: a2yr8pOsPZmNZ6KXpB7V_g-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-67e3c6c4624so81930b3a.3
        for <linux-security-module@vger.kernel.org>; Wed, 05 Jul 2023 13:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688588764; x=1691180764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t45r9A2YvfoSJv2GZo8UC8AtO/lxGa/2A2TsFaxOzFQ=;
        b=ghvtLyxfNqL2EBHkXxColYKlrJ2sk7yyOeCTP72jCAGpbZ4cynLVx5Txd78+T2gTiq
         /yz7xkIULC9X2f1/AS3AHUYQRTn4YQIhqjy86m46JTOwyoQB9tLCxC+dQQ0Mrfql6VvK
         nJmMvxUd8PIpaOaAqHGPcHlzGw9RVVia3nKKsoRlEgtYcsPqXeAv1j0eJ3qs5848ZcKi
         gvwUAXm/3/+h+xOnFvuf2zJVTN0bpXmUn6ba7vtitYm/O7yarFqj/zAEKisXOmaCWMbZ
         O5AKyDsveNIlpM/REJ1SYitycqf/1FW31RV1J/AA1UGmLFrZL+1Ec1glbqwmpZXkuukU
         yyew==
X-Gm-Message-State: AC+VfDwfjlhIHCQbEGE5/+0sMKd7rsq7LVMAjQ6gZgV5M4rYlUVuhUYG
        SJ1Ky2KhoYIiP2KY4h/asTB+32yJi0DLvKfyTfg3c3QAM/h4Frimaa42wZMAm6J7jgzgI799qCo
        MUktt7ySDGYozsw01HPXXZIdT0/RHE6Dp78I0uVsCBor1eRtCooig
X-Received: by 2002:a05:6a21:6d88:b0:122:e4f:25c7 with SMTP id wl8-20020a056a216d8800b001220e4f25c7mr15659554pzb.31.1688588763755;
        Wed, 05 Jul 2023 13:26:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ds4xvbUG+ZYaDvJ2apGx91OQ4qB0akGNWWFL3LaWKhMz96IxFpmQ2sEuPoCI3p2ih7fuYhkf9fNjQ5oeaAq0=
X-Received: by 2002:a05:6a21:6d88:b0:122:e4f:25c7 with SMTP id
 wl8-20020a056a216d8800b001220e4f25c7mr15659535pzb.31.1688588763446; Wed, 05
 Jul 2023 13:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230609125023.399942-1-jlayton@kernel.org> <20230609125023.399942-8-jlayton@kernel.org>
 <CAHc6FU4wyfQT7T75j2Sd9WNp=ag7hpDZGYkR=m73h2nOaH+AqQ@mail.gmail.com> <a1f7a725186082d933aff702d1d50c6456da6f20.camel@kernel.org>
In-Reply-To: <a1f7a725186082d933aff702d1d50c6456da6f20.camel@kernel.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 5 Jul 2023 22:25:51 +0200
Message-ID: <CAHc6FU54Gh+5hovqXZZSADqym=VCMis-EH9sKhAjgjXD6MUtqw@mail.gmail.com>
Subject: Re: [PATCH 7/9] gfs2: update ctime when quota is updated
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 12, 2023 at 12:36=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> On Fri, 2023-06-09 at 18:44 +0200, Andreas Gruenbacher wrote:
> > Jeff,
> >
> > On Fri, Jun 9, 2023 at 2:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/gfs2/quota.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> > > index 1ed17226d9ed..6d283e071b90 100644
> > > --- a/fs/gfs2/quota.c
> > > +++ b/fs/gfs2/quota.c
> > > @@ -869,7 +869,7 @@ static int gfs2_adjust_quota(struct gfs2_inode *i=
p, loff_t loc,
> > >                 size =3D loc + sizeof(struct gfs2_quota);
> > >                 if (size > inode->i_size)
> > >                         i_size_write(inode, size);
> > > -               inode->i_mtime =3D inode->i_atime =3D current_time(in=
ode);
> > > +               inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =
=3D current_time(inode);
> >
> > I don't think we need to worry about the ctime of the quota inode as
> > that inode is internal to the filesystem only.
> >
>
> Thanks Andreas.  I'll plan to drop this patch from the series for now.
>
> Does updating the mtime and atime here serve any purpose, or should
> those also be removed? If you plan to keep the a/mtime updates then I'd
> still suggest updating the ctime for consistency's sake. It shouldn't
> cost anything extra to do so since you're dirtying the inode below
> anyway.

Yes, good point actually, we should keep things consistent for simplicity.

Would you add this back in if you do another posting?

Thanks,
Andreas

> Thanks!
>
> > >                 mark_inode_dirty(inode);
> > >                 set_bit(QDF_REFRESH, &qd->qd_flags);
> > >         }
> > > --
> > > 2.40.1
> > >
> >
> > Thanks,
> > Andreas
> >
>
> --
> Jeff Layton <jlayton@kernel.org>
>

