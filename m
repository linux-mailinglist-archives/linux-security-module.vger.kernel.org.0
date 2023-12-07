Return-Path: <linux-security-module+bounces-378-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C821809081
	for <lists+linux-security-module@lfdr.de>; Thu,  7 Dec 2023 19:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07DEFB20A55
	for <lists+linux-security-module@lfdr.de>; Thu,  7 Dec 2023 18:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F76945BF0
	for <lists+linux-security-module@lfdr.de>; Thu,  7 Dec 2023 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MjO6jXPv"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADD41703
	for <linux-security-module@vger.kernel.org>; Thu,  7 Dec 2023 09:34:27 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5d96efd26f8so9285327b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 07 Dec 2023 09:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701970466; x=1702575266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwvXlaYuZum7+GGaBCsmSEKkxyRwqkMx+Zc6wns+Rno=;
        b=MjO6jXPvBXmJGFpZRcdFKXIZTjWMz0gi6OM/8Ximlq9xAnzfwCUjHF4nTEWE4PdsVg
         V8RiVb01u0zAbI0fznGBNPHVkIviqtfujbwEwEr05waJlonlFgZjtz5EkCINbdbiH/O/
         aGBmec3egA6tN03SJ0e0rwRQL+ELPnCYiKucldTRuOe8evih/dU1SGwz0d3I6aZo+XVb
         j8EM4M0K4u/fZ64ZQNvKEdlo0WmQkb+KBBUQntFtf1mmJrepXHpnfs0Um3j8vh+kzHEN
         RWJjpcs8yZEn/wePmZ4XD1VEjt3t1ElEb2wAnqgF5QElo0zN6A+XYkzphC1AViQZzHxq
         n5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701970466; x=1702575266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwvXlaYuZum7+GGaBCsmSEKkxyRwqkMx+Zc6wns+Rno=;
        b=GfIB8mgqjW6R8EcZznaEoOaivg+GLvQUYgDlgsREHrxADe+Ij6PfOa2A42PNxV+6SX
         0kkIIT2aJO6kYShgaSzRroH5Ru2qNhvMF+rJqRiMiyN5ElrtBlnnh67VYtFEbr36CiiA
         h6acE3KcKuBLLQn/WYXeVBEkj+FXpExjzFN1znTl+fRNzMLw47gDMW5qDxEmZEVY/pC2
         w87Ab6Fa3+lzb/N1yiO97ghPRUVov8U3BGIf6++J6boUWJlntMfw+CB9snf26qxl7y8j
         BVXZ4Ny3eqe0opipt3BWG/IirpCu5zCXeq0wRqYtjCcFvKMpYko1sig0wTRmOZuaCIuV
         wekw==
X-Gm-Message-State: AOJu0Yw173lLBhpYCnYxCjQpftyGeB9EIqlA7Pz2hVndIocuKV+PzfK6
	n/QnEco25TvSuzGXgScv6Emx5wQD0XfnxXjRjGZ1
X-Google-Smtp-Source: AGHT+IGOrVt0ZVnwbQvZgKnQGQH30d6LgCTCab39685Gqr2S+sqowhFbrhyYYzl/q1LhxaOhyRa2U2hzhZ6HJdN8Mqc=
X-Received: by 2002:a25:6989:0:b0:db9:9bae:c5e5 with SMTP id
 e131-20020a256989000000b00db99baec5e5mr2433583ybc.36.1701970466360; Thu, 07
 Dec 2023 09:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZW+KYViDT3HWtKI1@CMGLRV3> <CALOAHbANu2tq73bBRrGBAGq9ioTixqKgzpMyOPS3NMPXMg+pwA@mail.gmail.com>
 <ZXCNC8nJZryEy+VR@CMGLRV3> <CALOAHbAfixyvA5HpOXgqS32G-5p4Z=OXRso7_isz2fNKk76mmg@mail.gmail.com>
In-Reply-To: <CALOAHbAfixyvA5HpOXgqS32G-5p4Z=OXRso7_isz2fNKk76mmg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Dec 2023 12:34:15 -0500
Message-ID: <CAHC9VhSRdXLeJvS3tOmAAat+h8G7_cvAYnFvbrTwgG+sC+PRYg@mail.gmail.com>
Subject: Re: BPF LSM prevent program unload
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Frederick Lawler <fred@cloudflare.com>, jmorris@namei.org, 
	"Serge E. Hallyn" <serge@hallyn.com>, kpsingh@kernel.org, revest@chromium.org, 
	jackmanb@chromium.org, bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 9:28=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
> On Wed, Dec 6, 2023 at 11:02=E2=80=AFPM Frederick Lawler <fred@cloudflare=
.com> wrote:
> > On Wed, Dec 06, 2023 at 10:42:50AM +0800, Yafang Shao wrote:
> > > On Wed, Dec 6, 2023 at 4:39=E2=80=AFAM Frederick Lawler wrote:
> > > >
> > > > Hi,
> > > >
> > > > IIUC, LSMs are supposed to give us the ability to design policy aro=
und
> > > > unprivileged users and in addition to privileged users. As we expan=
d
> > > > our usage of BPF LSM's, there are cases where we want to restrict
> > > > privileged users from unloading our progs. For instance, any privil=
eged
> > > > user that wants to remove restrictions we've placed on privileged u=
sers.
> > > >
> > > > We currently have a loader application doesn't leverage BPF skeleto=
ns. We
> > > > instead load BPF object files, and then pin the progs to a mount po=
int that
> > > > is a bpf filesystem. On next run, if we have new policies, load in =
new
> > > > policies, and finally unload the old.
> > > >
> > > > Here are some conditions a privileged user may unload programs:
> > > >
> > > >         umount /sys/fs/bpf
> > > >         rm -rf /sys/fs/bpf/lsm
> > > >         rm /sys/fs/bpf/lsm/some_prog
> > > >         unlink /sys/fs/bpf/lsm/some_prog
> > > >
> > > > This works because once we remove the last reference, the programs =
and
> > > > pinned maps are cleaned up.
> > > >
> > > > Moving individual pins or moving the mount entirely with mount --mo=
ve
> > > > do not perform any clean up operations. Lastly, bpftool doesn't cur=
rently
> > > > have the ability to unload LSM's AFAIK.

If you haven't already, I would suggest talking with KP Singh as he is
the BPF LSM maintainer; I see him on the To/CC line so I'm sure he'll
comment when he has the chance to do so.

> > > > The few ideas I have floating around are:
> > > >
> > > > 1. Leverage some LSM hooks (BPF or otherwise) to restrict on the fu=
nctions
> > > >    security_sb_umount(), security_path_unlink(), security_inode_unl=
ink().
> > > >
> > > >    Both security_path_unlink() and security_inode_unlink() handle t=
he
> > > >    unlink/remove case, but not the umount case.

I'm not a BPF expert, but this seems like the most obvious solution,
although as Tetsuo already mentioned you probably don't want to block
all unmount operations as that would be bad for obvious reasons.  I'm
guessing that a BPF LSM would have access to things like the current
task credentials and enough of the mounted filesystem's state (BPF
prog pinning?) to make a reasonable decision about granting or denying
the umount operation request.

> > > > 3. Leverage SELinux/Apparmor to possibly handle these cases.

SELinux has support for restricting unmount operations as well BPF
program loading.  I see that AppArmor also has controls around
unmount, but I am less familiar with how that works.  It is also worth
mentioning that Tomoyo and Landlock provide unmount hook
implementations although both LSMs are fairly unique so I can't say if
they would be a good fit for your proposed use case.

> > > > 4. Introduce a security_bpf_prog_unload() to target hopefully the
> > > >    umount and unlink cases at the same time.

At first glance that seems reasonable, but I guess we would need to
see it discussed a bit before I could promise to commit to that.

As a FYI, we have some documented guidelines on creating new LSM
hooks; it's worth a quick read if you haven't seen it already.

https://github.com/LinuxSecurityModule/kernel?tab=3Dreadme-ov-file#new-lsm-=
hook-guidelines

> > > All the above programs can also be removed by privileged users.
> > >
> >
> > I should probably clarify the "BPF or otherwise" a bit better. Even a
> > compiled in LSM module? If so, where can I find a bit more information
> > about that?

I'm not quite sure what you are asking about here, but we don't
currently support "unloading" built-in LSM modules and I don't see us
changing that anytime soon.  The closest one could get would be with a
LSM that supports runtime configuration of its security policy; one
could go from a restrictive or an allow-all, permissive policy
effectively disabling the LSM from an access control standpoint.

I don't want to speak for all the LSMs here, but at least SELinux has
the ability to restrict policy loading so that one could prevent
replacing a relatively strict policy with a more permissive policy.
Although it is worth noting that enabling this restriction has a
number of caveats, i.e. policy updates require a reboot, and isn't
something I would recommend for a general purpose system.

--=20
paul-moore.com

