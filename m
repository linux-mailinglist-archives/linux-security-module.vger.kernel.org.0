Return-Path: <linux-security-module+bounces-3454-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF02F8CC584
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 19:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A141C20F9F
	for <lists+linux-security-module@lfdr.de>; Wed, 22 May 2024 17:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BC11420BB;
	Wed, 22 May 2024 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ7nZJzP"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA82869B;
	Wed, 22 May 2024 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398981; cv=none; b=Q2x4GPLi2RrcHKuWMc6xA0BQCAn6095q0w7gHeRakQLQMDShthiRXtIMXJmdteFqGMCpvbLOF+1+0hktLEEnKpy6WuIZG4S5r5ZnXtXQAc5iOL13j9cvlxgZzxIzDfwQLnxIwuReM8rkxR24wl49W58naB8IiANixlMqLobtY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398981; c=relaxed/simple;
	bh=UOM2BH8YpyNbWZ+1zFlYjCrwNfWnDJfkxxAhGazq2QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gtv5MvF3aD1N3uHW7/w0WCKAKEhv4xQsLJ8NLZZTruFwWVZ6bC7rmjxk3NduIKR0YTCzOBPvLXyTEt0uS9Gf5yQQBbJs3ojSHAaZP0DDmXSkwGYkXcPI0QWYJwH1Bfc/qSInpoMqWHkLoJj8ahYlJUoY5OioOGSgTlZ9WqkWW6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJ7nZJzP; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-60585faa69fso779743a12.1;
        Wed, 22 May 2024 10:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716398979; x=1717003779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEc+arxvFWhx8lCR8GzmhsnqiINgipEWkuKuwOGrkaU=;
        b=hJ7nZJzP9e873l1GRnfuhQe1PZh/rzgNcx+Yv8/CyJ9qsSAA4YsemwsXuE1IaGDEj8
         bEzD0b0RnvNbUJ9ND7S00wy2i32v5skQ1YkfL2795uF8tKyohKFl2WtRl41Ct1t8oacI
         ujdU2i4GZjk6PoHkCKmEaTYsGSAvRHJjgnCw8myyvXrmMkDqsIIUW1BvHKzUgBWNZRDZ
         qgHVIMxL7wBqqAlDkn/EUA7xC6HXrasr6QC6ZwLySh7hO06CW2KTI09N5yUA7npRDWfz
         G9Ph1iDyFP6w/+8xNxM8WEQZEtr+XbYIzDfRzry1sWocdIyZDBiRSe6CMGbQHMFrYGXu
         ro7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716398979; x=1717003779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEc+arxvFWhx8lCR8GzmhsnqiINgipEWkuKuwOGrkaU=;
        b=XrWDEeQqKE+m4/xupFGwS9WXGq9B9D4PzKsib5FvofzkPCQTQouIlVYCude3B7sedQ
         bnUlthexGr9LzT2dbupcMJ61SS/AsgsL2iFfKP8xtM8m1tau9cCe/HqFm5QdYmGk6OcT
         1oVSup3dY6TnBvprsrVLI5iLch4YNHYgRYmlcXT6vY9nIIKByHMkrbjf6IDtYe5CW++D
         Upr/9cMwBiXMMx0dB1dC2JHDli2TS5ww0xMCW3g2cRBCNR0T9WdUwu9cbHpCzJDEjnRe
         ZAZSFxPJnE09y5RgliCFpV0SwvX1twss+7ohckoFi/GXNgIL0zS8zziKPvE6u8WWFcpU
         /asw==
X-Forwarded-Encrypted: i=1; AJvYcCUxEN/15BIbZ8xk/nmBhdQxQqirt7kTk2DCGdzKS0paevpel4YkS20iI/x1ZUqEzUyypXonCkT6gd8/O/Vn1wTcs3AXxlFwiRVC6Mu8Ys9b2ivtvJ+zhxiV5wg6jxdK3dU3Xca8NKGxjU30DSDyLxCZ
X-Gm-Message-State: AOJu0YwuLBG0EKyM3XrfgqjjyHmNC0gtPvwo2O3MgexdIKQWKzCzEVdD
	JieMrQdcJfwrYiQR3Yn4GRELrCqGB0Rn9SdGrYmNVRIp90SwSe4T68BWzJdIFmabYk5QYURet6+
	Cpk//4WFmuUQKa3cIcsEUZDaTTH0=
X-Google-Smtp-Source: AGHT+IHxtCT+6421K38bBMQqfaWWBsR7+hW7v1lv9SZEngeBkWSn+LwQR+eOXTefCvP2BKHvOB8p+YdMWWR3/ROV+Os=
X-Received: by 2002:a17:90b:68b:b0:2b6:208c:2aee with SMTP id
 98e67ed59e1d1-2bd9f604d7cmr3898356a91.20.1716398979539; Wed, 22 May 2024
 10:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503130905.16823-1-stephen.smalley.work@gmail.com>
 <171497439414.9775.6998904788791406674@noble.neil.brown.name>
 <CAEjxPJ6DTNY3p9MmdV0K1A7No7joczGTeOe26Q4wr6yujk9zKA@mail.gmail.com> <CAEjxPJ6y=WmGqRkj+Qrj9x5+-u74=DEt0JCWmCpRu4EZufpmkg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6y=WmGqRkj+Qrj9x5+-u74=DEt0JCWmCpRu4EZufpmkg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 22 May 2024 13:29:28 -0400
Message-ID: <CAEjxPJ7Wh3jnH7fjYorT3DCw_iK48NzfG9t6c3to66L_WgVt0A@mail.gmail.com>
Subject: Re: [PATCH v3] nfsd: set security label during create operations
To: NeilBrown <neilb@suse.de>
Cc: selinux@vger.kernel.org, linux-nfs@vger.kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 1:29=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, May 15, 2024 at 10:52=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, May 6, 2024 at 1:46=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
> > >
> > > On Fri, 03 May 2024, Stephen Smalley wrote:
> > > > When security labeling is enabled, the client can pass a file secur=
ity
> > > > label as part of a create operation for the new file, similar to mo=
de
> > > > and other attributes. At present, the security label is received by=
 nfsd
> > > > and passed down to nfsd_create_setattr(), but nfsd_setattr() is nev=
er
> > > > called and therefore the label is never set on the new file. This b=
ug
> > > > may have been introduced on or around commit d6a97d3f589a ("NFSD:
> > > > add security label to struct nfsd_attrs"). Looking at nfsd_setattr(=
)
> > > > I am uncertain as to whether the same issue presents for
> > > > file ACLs and therefore requires a similar fix for those.
> > > >
> > > > An alternative approach would be to introduce a new LSM hook to set=
 the
> > > > "create SID" of the current task prior to the actual file creation,=
 which
> > > > would atomically label the new inode at creation time. This would b=
e better
> > > > for SELinux and a similar approach has been used previously
> > > > (see security_dentry_create_files_as) but perhaps not usable by oth=
er LSMs.
> > > >
> > > > Reproducer:
> > > > 1. Install a Linux distro with SELinux - Fedora is easiest
> > > > 2. git clone https://github.com/SELinuxProject/selinux-testsuite
> > > > 3. Install the requisite dependencies per selinux-testsuite/README.=
md
> > > > 4. Run something like the following script:
> > > > MOUNT=3D$HOME/selinux-testsuite
> > > > sudo systemctl start nfs-server
> > > > sudo exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
> > > > sudo mkdir -p /mnt/selinux-testsuite
> > > > sudo mount -t nfs -o vers=3D4.2 localhost:$MOUNT /mnt/selinux-tests=
uite
> > > > pushd /mnt/selinux-testsuite/
> > > > sudo make -C policy load
> > > > pushd tests/filesystem
> > > > sudo runcon -t test_filesystem_t ./create_file -f trans_test_file \
> > > >       -e test_filesystem_filetranscon_t -v
> > > > sudo rm -f trans_test_file
> > > > popd
> > > > sudo make -C policy unload
> > > > popd
> > > > sudo umount /mnt/selinux-testsuite
> > > > sudo exportfs -u localhost:$MOUNT
> > > > sudo rmdir /mnt/selinux-testsuite
> > > > sudo systemctl stop nfs-server
> > > >
> > > > Expected output:
> > > > <eliding noise from commands run prior to or after the test itself>
> > > > Process context:
> > > >       unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> > > > Created file: trans_test_file
> > > > File context: unconfined_u:object_r:test_filesystem_filetranscon_t:=
s0
> > > > File context is correct
> > > >
> > > > Actual output:
> > > > <eliding noise from commands run prior to or after the test itself>
> > > > Process context:
> > > >       unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> > > > Created file: trans_test_file
> > > > File context: system_u:object_r:test_file_t:s0
> > > > File context error, expected:
> > > >       test_filesystem_filetranscon_t
> > > > got:
> > > >       test_file_t
> > > >
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > ---
> > > > v3 removes the erroneous and unnecessary change to NFSv2 and update=
s the
> > > > description to note the possible origin of the bug. I did not add a
> > > > Fixes tag however as I have not yet tried confirming that.
> > >
> > > I think this bug has always been present - since label support was
> > > added.
> > > Commit d6a97d3f589a ("NFSD: add security label to struct nfsd_attrs")
> > > should have fixed it, but was missing the extra test that you provide=
.
> > >
> > > So
> > > Fixes: 0c71b7ed5de8 ("nfsd: introduce file_cache_mutex")
> > > might be appropriate - it fixes the patch, though not a bug introduce=
d
> > > by the patch.
> > >
> > > Thanks for this patch!
> > > Reviewed-by: NeilBrown <neilb@suse.de>
> >
> > FWIW, I finally got around to testing Linux v5.14 and it did pass
> > these NFS tests so this was a regression. I haven't been able to
> > bisect yet.
>
> Seems to have broken sometime between v5.19 and v6.0. Still bisecting.

git bisect ended with:
[d6a97d3f589a3a46a16183e03f3774daee251317] NFSD: add security label to
struct nfsd_attrs
as the breaking commit.

Bisecting was a little complicated by other unrelated bugs but I
narrowed it to just this particular one.

