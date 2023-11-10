Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206E97E8131
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Nov 2023 19:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345921AbjKJSZD (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 10 Nov 2023 13:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345724AbjKJSYI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Nov 2023 13:24:08 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF0842C0A
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 09:00:33 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-da819902678so2321164276.1
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 09:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699635633; x=1700240433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kjh5T8h9wjxj8rwI5k7AoyiBDuBw6RmJFRrtLAbwBaI=;
        b=Kw4Hrtks//V9GCBFNsZN64xQVmTkfjmZ2nrWWg5E0PLCIPDp8/N4lquzKdEtcwEuAc
         kpi1NA9RktLVAvG6JCjFaOfiq9amoXyXvHwnszhmYD1Vni0IuWmtBQVeOyleJRm7Eh7L
         RxFQPh7regjuw7pZBtrgeU37b1FeIfRjSMulzUq5tfsGqoYL+lzbwHmck8OoyAx6A1Wz
         lLvLDUlqbWoKcKWG3oI9MDTDXhMYsjRJWKINHMrELPSRk60MD+PC5TkkzURFdVnnuDCn
         x5suwLfwKN1hpizNDNvlfwFpYsSc5uI5QYN+1IXoCPmvmE51mlNaszQLnpMrsqVhgL/g
         fcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699635633; x=1700240433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kjh5T8h9wjxj8rwI5k7AoyiBDuBw6RmJFRrtLAbwBaI=;
        b=YlvZdvj/8t4+2s+1PmU/CJU+CYwxgj5fse1cfMwEXfFmvZNNsZz2DwdYJ5yiMN7j23
         aHRfhvm99b0Iti1Ki9ZxkV2lxxNNEhIOXBgc53l1LKSq9+S9BkmF08czr+3VxwXNk5H+
         qu444faH8BbuyAV5tCt9qmHH02UK7Pm9cYA3/ztrvuPQi4zwzu/Ayk9DaB/aL5HRyWqA
         o0wJmz95dCb2c806SicO3dTkbIKoqoOm+VicAWSnChYh4DfpRfx845g/lIHyd6hOP80E
         dmSxyFJiL/eBiyBZtfNT0A7lFLkNbVqwQ/V3j3vCdvw1vmdnV261CzeW5IN4ZbV+SC1A
         vn4A==
X-Gm-Message-State: AOJu0YxaBrFL+F0jGDJRnC+o9OXS/p5fWdY36nqEhfGwjf1YotP4Rb2n
        UP11ftKRrIp0kM24uDPqAeKvc2raGhO9Q2iOlMVS
X-Google-Smtp-Source: AGHT+IF6xmEmxjE5GSzP9TQylnTchoY8j5jR2rrNMdTsWqEfb4oLHP+Gj+Gl+tpZ0BvJlavju/oaKfSsOp4JqZZ+zWk=
X-Received: by 2002:a25:ca17:0:b0:d9a:4870:7943 with SMTP id
 a23-20020a25ca17000000b00d9a48707943mr8823635ybg.28.1699635632941; Fri, 10
 Nov 2023 09:00:32 -0800 (PST)
MIME-Version: 1.0
References: <20231025140205.3586473-5-mszeredi@redhat.com> <4ab327f80c4f98dffa5736a1acba3e0d.paul@paul-moore.com>
 <20231108-zwerge-unheil-b3f48a84038d@brauner> <CAHC9VhSLGyFRSbeZXE7z61Y2aDJi_1Dedjw0ioFOckRCs0CRaA@mail.gmail.com>
In-Reply-To: <CAHC9VhSLGyFRSbeZXE7z61Y2aDJi_1Dedjw0ioFOckRCs0CRaA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Nov 2023 12:00:22 -0500
Message-ID: <CAHC9VhRvYua4noiHbMqcAqz=Rkz=pxSgp5fVxXX+uhz61jYFag@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] add statmount(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 8, 2023 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Wed, Nov 8, 2023 at 2:58=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> > > > +static int do_statmount(struct stmt_state *s)
> > > > +{
> > > > +   struct statmnt *sm =3D &s->sm;
> > > > +   struct mount *m =3D real_mount(s->mnt);
> > > > +   size_t copysize =3D min_t(size_t, s->bufsize, sizeof(*sm));
> > > > +   int err;
> > > > +
> > > > +   err =3D security_sb_statfs(s->mnt->mnt_root);
> > > > +   if (err)
> > > > +           return err;
> > > > +
> > > > +   if (!capable(CAP_SYS_ADMIN) &&
> > > > +       !is_path_reachable(m, m->mnt.mnt_root, &s->root))
> > > > +           return -EPERM;
> > >
> > > In order to be consistent with our typical access control ordering,
> > > please move the security_sb_statfs() call down to here, after the
> > > capability checks.
> >
> > I've moved the security_sb_statfs() calls accordingly.
>
> Okay, good.  Did I miss a comment or a patch where that happened?  I
> looked over the patchset and comments yesterday and didn't recall
> seeing anything about shuffling the access control checks.

Gentle ping on this.  I'm asking because I know there have been issues
lately with the lists and some mail providers and I want to make sure
I'm not missing anything, I double checked lore again and didn't see
anything there either, but I might be missing it.

--=20
paul-moore.com
