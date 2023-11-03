Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A727E0353
	for <lists+linux-security-module@lfdr.de>; Fri,  3 Nov 2023 14:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjKCNHJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 3 Nov 2023 09:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKCNHH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Nov 2023 09:07:07 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF751A8
        for <linux-security-module@vger.kernel.org>; Fri,  3 Nov 2023 06:07:04 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-9d223144f23so150742366b.3
        for <linux-security-module@vger.kernel.org>; Fri, 03 Nov 2023 06:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699016823; x=1699621623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCjRctCrzDCggG/c/dhJer4xLTSPmcHhvE3LQTQjHtc=;
        b=YKhMw2pLhoxL/56cS9IluByIXZZrdoSHwiEAyU8m7JFzr3lHvB0QsIBaUS8QPX9bZI
         52sHTUSVjYUgVL+8y9S1+2/GyjWj3AglxbAVSnUoF8AIfgn/G73qaI0FiaUx9U/EMS2m
         G+21wUkQfn4sri+E89YFAnNDDZHMuEj8u2UBbgdBbgdLPwA0+q5f9frjMJbG7GeFTqJj
         wjhkU+rGdeU9trVfcUjPgsIm1/6UbVTAPq8Zl5gdU6w8a7ELtEU+DciTpdjvawTad+aF
         +389uJDYPBj6QZXAfsRiAJDh9CymP3i7VBNEtdQZ2p00qF0X5W9FyPyDt7nCOuQ2Ue/c
         bDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699016823; x=1699621623;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kCjRctCrzDCggG/c/dhJer4xLTSPmcHhvE3LQTQjHtc=;
        b=rZZShJFnnMHMHs932JA343hcaqF6vSLyYsSgV656z095n7EZ9mbHbD9Y40+d8CIHcb
         hDVmPnOuQlRDOzFJ73e3H8zBY2Ob2h7kZrPH99qTCBCjatgS3PF5hlrpvMmLoSfBf7tv
         caTmwRWoHwtUVD3Vb8GbQ/PrOEFvf/zdEnMmJJ6SE741Owtbm8oXSVJ+M9p6ALzM7y40
         c1QFygnQoM0RR5NrODGIi8fJURs75Ts4KOkEan/4jgk3j4I8yB6GoEldcLR21duYNIal
         KIZoXK9YlI9SeYkKupdkUxDN7y10MIGw+V4Fuo+Jpu4TIKetaEYnMDAkJEKjktxdKsV8
         woNw==
X-Gm-Message-State: AOJu0Yy9c9hJ1XFHr5uego+rKCEGoORyYmyFdidDHWURAooW0nqH/Bme
        51Ce/TP5RQHPha4sVEVyb4FiWfQxxSM=
X-Google-Smtp-Source: AGHT+IGSX6SfkkW9RJlvLbfnkKNA8YUjGwfPH8iJVaf9U5sI6hBp617wlTa8WSsPdeeg++eWSnTv0I58G3Y=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:7ddd:bc72:7a4a:ba94])
 (user=gnoack job=sendgmr) by 2002:a17:906:6944:b0:9d2:3e00:a914 with SMTP id
 c4-20020a170906694400b009d23e00a914mr59003ejs.3.1699016823041; Fri, 03 Nov
 2023 06:07:03 -0700 (PDT)
Date:   Fri, 3 Nov 2023 14:06:53 +0100
In-Reply-To: <20231026.oiPeosh1yieg@digikod.net>
Message-Id: <ZUTwbTc6BETB1ClB@google.com>
Mime-Version: 1.0
References: <20230825.Zoo4ohn1aivo@digikod.net> <20230826.ohtooph0Ahmu@digikod.net>
 <ZPMiVaL3kVaTnivh@google.com> <20230904.aiWae8eineo4@digikod.net>
 <ZP7lxmXklksadvz+@google.com> <20230911.jie6Rai8ughe@digikod.net>
 <ZTGpIBve2LVlbt6p@google.com> <20231020.moefooYeV9ei@digikod.net>
 <ZTmRoESR5eXEA_ky@google.com> <20231026.oiPeosh1yieg@digikod.net>
Subject: Re: [PATCH v3 0/5] Landlock: IOCTL support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Micka=C3=ABl!

Thanks for the review!

On Thu, Oct 26, 2023 at 04:55:30PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> The third column "IOCTL unhandled" is not reflected here. What about
> this patch?
>=20
> if (!(handled & LANDLOCK_ACCESS_FS_IOCTL)) {
>   return am | dst;
> }

You are right that this needs special treatment.  The reasoning is the scen=
ario
where a user creates a ruleset where LANDLOCK_ACCESS_FS_READ_FILE is handle=
d,
but LANDLOCK_ACCESS_FS_IOCTL is not.  In that case, when a file is opened f=
or
which we do not have the READ_FILE access right, without your additional ch=
eck,
the IOCTLs associated with READ_FILE would be forbidden.  But this is also =
a
Landlock usage that was possible before the introduction of the IOCTL handl=
ing,
and so all IOCTLs should work in that case.

>=20
> >     if (handled & src) {
> >       /* If "src" access right is handled, populate "dst" from "src". *=
/
> >       return am | ((am & src) ? dst : 0);
> >     } else {
> >       /* Otherwise, populate "dst" flag from "ioctl" flag. */
> >       return am | ((am & LANDLOCK_ACCESS_FS_IOCTL) ? dst : 0);
> >     }
> >   }
> >=20
> >   static access_mask_t expand_all_ioctl(access_mask_t handled, access_m=
ask_t am)
> >   {
>=20
> Instead of reapeating "am | " in expand_ioctl() and assigning am several
> times in expand_all_ioctl(), you could simply do something like that:
>=20
> return am |
> 	expand_ioctl(handled, am, ...) |
> 	expand_ioctl(handled, am, ...) |
> 	expand_ioctl(handled, am, ...);

Agreed, this is more elegant.  Will do.


> >     am =3D expand_ioctl(handled, am,
> >                       LANDLOCK_ACCESS_FS_WRITE_FILE,
> > 		      IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G4);
> >     am =3D expand_ioctl(handled, am,
> >                       LANDLOCK_ACCESS_FS_READ_FILE,
> > 		      IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G3);
> >     am =3D expand_ioctl(handled, am,
> >                       LANDLOCK_ACCESS_FS_READ_DIR,
> > 		      IOCTL_CMD_G1);
> >     return am;
> >   }
> >=20
> >   and then during the installing of a ruleset, we'd call
> >   expand_all_ioctl(handled, access) for each specified file access, and
> >   expand_all_ioctl(handled, handled) for the handled access rights,
> >   to populate the synthetic IOCTL_CMD_G* access rights.
>=20
> We can do these transformations directly in the new
> landlock_add_fs_access_mask() and landlock_append_fs_rule().

Working on these changes, the location of these transformations is one of t=
he
last outstanding problems that I don't like yet.

I have added the expansion code to landlock_add_fs_access_mask() and
landlock_append_fs_rule() as you suggested.

This works, but as a result, this (somewhat complicated) expansion logic is=
 now
part of the ruleset.o module, where it seems a bit too FS-specific.  I thin=
k
that maybe we can pull this out further, but I'll probably send you a patch=
 set
with the current status before doing that, so that we are on the same page.


> Please base the next series on
> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=3Dne=
xt
> This branch might be rebased from time to time, but only minor changes
> will get there.

OK, will do.


In summary, I'll send a patch soon.

FYI, some open questions I still have are:

* Logic
  * How will userspace libraries handle best-effort fallback,
    when expanded IOCTL access rights come into play?
    (Still need to think about this more.)
* Internal code layout
  * Move expansion logic out of ruleset.o module into syscalls.o?
  * Find more appropriate names for IOCTL_CMD_G1,...,IOCTL_CMD_G4

but we can discuss these in the context of the next patch set.

=E2=80=94G=C3=BCnther
