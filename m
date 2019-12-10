Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A37118887
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Dec 2019 13:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfLJMd5 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 10 Dec 2019 07:33:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39585 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727374AbfLJMbV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4CxEQ5z2P35PU5qEnTEcH9MyNfCjukSbjzhDjqs04MQ=;
        b=HvKLzLgQ5HtpiU1y5VIDskCrdj19j961VmXcvVdbGEYy9bX9s46eaW8nJJ/bzGg1rXVIJH
        6LjjDT/Q/oYA+Ej/hkKAxirykPVbpaW5sEzFCE4xFKW2yas2s18ZXPpFPy3nXakS103x9C
        HXfctNafBSFp5ArZ9Pjuz7E/XNavNFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-dwRglwilOo-3WYmw05ymMQ-1; Tue, 10 Dec 2019 07:31:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8F5E107ACCD;
        Tue, 10 Dec 2019 12:31:16 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2396C60BF3;
        Tue, 10 Dec 2019 12:31:16 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 9516020AE5; Tue, 10 Dec 2019 07:31:15 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 02/27] nfs: stash server into struct nfs_mount_info
Date:   Tue, 10 Dec 2019 07:30:50 -0500
Message-Id: <20191210123115.1655-3-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: dwRglwilOo-3WYmw05ymMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h  |  3 ++-
 fs/nfs/nfs4super.c | 10 ++++------
 fs/nfs/super.c     | 19 ++++++++-----------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 24a65da58aa9..8f4900bd04f7 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -142,6 +142,7 @@ struct nfs_mount_info {
 =09int (*set_security)(struct super_block *, struct dentry *, struct nfs_m=
ount_info *);
 =09struct nfs_parsed_mount_data *parsed;
 =09struct nfs_clone_mount *cloned;
+=09struct nfs_server *server;
 =09struct nfs_fh *mntfh;
 };
=20
@@ -397,7 +398,7 @@ struct dentry *nfs_try_mount(int, const char *, struct =
nfs_mount_info *,
 =09=09=09struct nfs_subversion *);
 int nfs_set_sb_security(struct super_block *, struct dentry *, struct nfs_=
mount_info *);
 int nfs_clone_sb_security(struct super_block *, struct dentry *, struct nf=
s_mount_info *);
-struct dentry *nfs_fs_mount_common(struct nfs_server *, int, const char *,
+struct dentry *nfs_fs_mount_common(int, const char *,
 =09=09=09=09   struct nfs_mount_info *, struct nfs_subversion *);
 struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, =
void *);
 struct dentry * nfs_xdev_mount_common(struct file_system_type *, int,
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index beeaed872e6c..e7f2fd1925b1 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -109,13 +109,12 @@ nfs4_remote_mount(struct file_system_type *fs_type, i=
nt flags,
 =09=09  const char *dev_name, void *info)
 {
 =09struct nfs_mount_info *mount_info =3D info;
-=09struct nfs_server *server;
=20
 =09mount_info->set_security =3D nfs_set_sb_security;
=20
 =09/* Get a volume representation */
-=09server =3D nfs4_create_server(mount_info, &nfs_v4);
-=09return nfs_fs_mount_common(server, flags, dev_name, mount_info, &nfs_v4=
);
+=09mount_info->server =3D nfs4_create_server(mount_info, &nfs_v4);
+=09return nfs_fs_mount_common(flags, dev_name, mount_info, &nfs_v4);
 }
=20
 static struct vfsmount *nfs_do_root_mount(struct file_system_type *fs_type=
,
@@ -260,7 +259,6 @@ nfs4_remote_referral_mount(struct file_system_type *fs_=
type, int flags,
 =09=09.set_security =3D nfs_clone_sb_security,
 =09=09.cloned =3D raw_data,
 =09};
-=09struct nfs_server *server;
 =09struct dentry *mntroot =3D ERR_PTR(-ENOMEM);
=20
 =09dprintk("--> nfs4_referral_get_sb()\n");
@@ -270,8 +268,8 @@ nfs4_remote_referral_mount(struct file_system_type *fs_=
type, int flags,
 =09=09goto out;
=20
 =09/* create a new volume representation */
-=09server =3D nfs4_create_referral_server(mount_info.cloned, mount_info.mn=
tfh);
-=09mntroot =3D nfs_fs_mount_common(server, flags, dev_name, &mount_info, &=
nfs_v4);
+=09mount_info.server =3D nfs4_create_referral_server(mount_info.cloned, mo=
unt_info.mntfh);
+=09mntroot =3D nfs_fs_mount_common(flags, dev_name, &mount_info, &nfs_v4);
 out:
 =09nfs_free_fhandle(mount_info.mntfh);
 =09return mntroot;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index f074c3773f0e..379c7b26051d 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1896,14 +1896,12 @@ struct dentry *nfs_try_mount(int flags, const char =
*dev_name,
 =09=09=09     struct nfs_mount_info *mount_info,
 =09=09=09     struct nfs_subversion *nfs_mod)
 {
-=09struct nfs_server *server;
-
 =09if (mount_info->parsed->need_mount)
-=09=09server =3D nfs_try_mount_request(mount_info, nfs_mod);
+=09=09mount_info->server =3D nfs_try_mount_request(mount_info, nfs_mod);
 =09else
-=09=09server =3D nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
+=09=09mount_info->server =3D nfs_mod->rpc_ops->create_server(mount_info, n=
fs_mod);
=20
-=09return nfs_fs_mount_common(server, flags, dev_name, mount_info, nfs_mod=
);
+=09return nfs_fs_mount_common(flags, dev_name, mount_info, nfs_mod);
 }
 EXPORT_SYMBOL_GPL(nfs_try_mount);
=20
@@ -2649,20 +2647,21 @@ static void nfs_set_readahead(struct backing_dev_in=
fo *bdi,
 =09bdi->io_pages =3D iomax_pages;
 }
=20
-struct dentry *nfs_fs_mount_common(struct nfs_server *server,
-=09=09=09=09   int flags, const char *dev_name,
+struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 =09=09=09=09   struct nfs_mount_info *mount_info,
 =09=09=09=09   struct nfs_subversion *nfs_mod)
 {
 =09struct super_block *s;
 =09struct dentry *mntroot =3D ERR_PTR(-ENOMEM);
 =09int (*compare_super)(struct super_block *, void *) =3D nfs_compare_supe=
r;
+=09struct nfs_server *server =3D mount_info->server;
 =09struct nfs_sb_mountdata sb_mntdata =3D {
 =09=09.mntflags =3D flags,
 =09=09.server =3D server,
 =09};
 =09int error;
=20
+=09mount_info->server =3D NULL;
 =09if (IS_ERR(server))
 =09=09return ERR_CAST(server);
=20
@@ -2803,7 +2802,6 @@ nfs_xdev_mount(struct file_system_type *fs_type, int =
flags,
 =09=09.set_security =3D nfs_clone_sb_security,
 =09=09.cloned =3D data,
 =09};
-=09struct nfs_server *server;
 =09struct dentry *mntroot =3D ERR_PTR(-ENOMEM);
 =09struct nfs_subversion *nfs_mod =3D NFS_SB(data->sb)->nfs_client->cl_nfs=
_mod;
=20
@@ -2812,10 +2810,9 @@ nfs_xdev_mount(struct file_system_type *fs_type, int=
 flags,
 =09mount_info.mntfh =3D mount_info.cloned->fh;
=20
 =09/* create a new volume representation */
-=09server =3D nfs_mod->rpc_ops->clone_server(NFS_SB(data->sb), data->fh, d=
ata->fattr, data->authflavor);
+=09mount_info.server =3D nfs_mod->rpc_ops->clone_server(NFS_SB(data->sb), =
data->fh, data->fattr, data->authflavor);
=20
-=09mntroot =3D nfs_fs_mount_common(server, flags,
-=09=09=09=09dev_name, &mount_info, nfs_mod);
+=09mntroot =3D nfs_fs_mount_common(flags, dev_name, &mount_info, nfs_mod);
=20
 =09dprintk("<-- nfs_xdev_mount() =3D %ld\n",
 =09=09=09IS_ERR(mntroot) ? PTR_ERR(mntroot) : 0L);
--=20
2.17.2

