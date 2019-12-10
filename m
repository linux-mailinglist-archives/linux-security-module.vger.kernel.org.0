Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1645E118851
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Dec 2019 13:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfLJMcn (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 10 Dec 2019 07:32:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36892 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727412AbfLJMbY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbdrkapHLLKH5mkxtqO26NmoIcSlRfGq27jM+DUC/Nw=;
        b=AVIY8xC4jqHUbq5PY7wnGN2nXeOaskBHyobYbXARVOg/Uz+t6478L7heMgpOJ31yGjab5z
        vl7RosP8GaV0dGaXu3E5CmNdC8TDK9XWmJFqOcAJI+f1o9zn0lsJmqwSohaXK030oA3k4M
        lpzyPsUbsndx8Pd2S4YZq+8U1lTQ3b8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-VZzVeAueN_qo1xjIUidlwA-1; Tue, 10 Dec 2019 07:31:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92CD22F60;
        Tue, 10 Dec 2019 12:31:16 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2390E5C241;
        Tue, 10 Dec 2019 12:31:16 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 9B9AA20B4C; Tue, 10 Dec 2019 07:31:15 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 03/27] nfs: lift setting mount_info from nfs4_remote{,_referral}_mount
Date:   Tue, 10 Dec 2019 07:30:51 -0500
Message-Id: <20191210123115.1655-4-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: VZzVeAueN_qo1xjIUidlwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Do that (fhandle allocation, setting struct server up) in
nfs4_referral_mount() and nfs4_try_mount() resp. and pass the
server and pointer to mount_info into nfs_do_root_mount() so that
nfs4_remote_referral_mount()/nfs_remote_mount() could be merged.

Since we are moving stuff from ->mount() instances to the points
prior to vfs_kern_mount() that would trigger those, we need to
make sure that do_nfs_root_mount() will do the corresponding
cleanup itself if it doesn't trigger those ->mount() instances.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs4super.c | 67 ++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index e7f2fd1925b1..ac3e8928643d 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -108,32 +108,37 @@ static struct dentry *
 nfs4_remote_mount(struct file_system_type *fs_type, int flags,
 =09=09  const char *dev_name, void *info)
 {
-=09struct nfs_mount_info *mount_info =3D info;
-
-=09mount_info->set_security =3D nfs_set_sb_security;
-
-=09/* Get a volume representation */
-=09mount_info->server =3D nfs4_create_server(mount_info, &nfs_v4);
-=09return nfs_fs_mount_common(flags, dev_name, mount_info, &nfs_v4);
+=09return nfs_fs_mount_common(flags, dev_name, info, &nfs_v4);
 }
=20
 static struct vfsmount *nfs_do_root_mount(struct file_system_type *fs_type=
,
-=09=09int flags, void *data, const char *hostname)
+=09=09=09=09=09  struct nfs_server *server, int flags,
+=09=09=09=09=09  struct nfs_mount_info *info,
+=09=09=09=09=09  const char *hostname)
 {
 =09struct vfsmount *root_mnt;
 =09char *root_devname;
 =09size_t len;
=20
+=09if (IS_ERR(server))
+=09=09return ERR_CAST(server);
+
 =09len =3D strlen(hostname) + 5;
 =09root_devname =3D kmalloc(len, GFP_KERNEL);
-=09if (root_devname =3D=3D NULL)
+=09if (root_devname =3D=3D NULL) {
+=09=09nfs_free_server(server);
 =09=09return ERR_PTR(-ENOMEM);
+=09}
 =09/* Does hostname needs to be enclosed in brackets? */
 =09if (strchr(hostname, ':'))
 =09=09snprintf(root_devname, len, "[%s]:/", hostname);
 =09else
 =09=09snprintf(root_devname, len, "%s:/", hostname);
-=09root_mnt =3D vfs_kern_mount(fs_type, flags, root_devname, data);
+=09info->server =3D server;
+=09root_mnt =3D vfs_kern_mount(fs_type, flags, root_devname, info);
+=09if (info->server)
+=09=09nfs_free_server(info->server);
+=09info->server =3D NULL;
 =09kfree(root_devname);
 =09return root_mnt;
 }
@@ -234,11 +239,15 @@ struct dentry *nfs4_try_mount(int flags, const char *=
dev_name,
 =09struct dentry *res;
 =09struct nfs_parsed_mount_data *data =3D mount_info->parsed;
=20
+=09mount_info->set_security =3D nfs_set_sb_security;
+
 =09dfprintk(MOUNT, "--> nfs4_try_mount()\n");
=20
 =09export_path =3D data->nfs_server.export_path;
 =09data->nfs_server.export_path =3D "/";
-=09root_mnt =3D nfs_do_root_mount(&nfs4_remote_fs_type, flags, mount_info,
+=09root_mnt =3D nfs_do_root_mount(&nfs4_remote_fs_type,
+=09=09=09nfs4_create_server(mount_info, &nfs_v4),
+=09=09=09flags, mount_info,
 =09=09=09data->nfs_server.hostname);
 =09data->nfs_server.export_path =3D export_path;
=20
@@ -254,25 +263,7 @@ static struct dentry *
 nfs4_remote_referral_mount(struct file_system_type *fs_type, int flags,
 =09=09=09   const char *dev_name, void *raw_data)
 {
-=09struct nfs_mount_info mount_info =3D {
-=09=09.fill_super =3D nfs_fill_super,
-=09=09.set_security =3D nfs_clone_sb_security,
-=09=09.cloned =3D raw_data,
-=09};
-=09struct dentry *mntroot =3D ERR_PTR(-ENOMEM);
-
-=09dprintk("--> nfs4_referral_get_sb()\n");
-
-=09mount_info.mntfh =3D nfs_alloc_fhandle();
-=09if (mount_info.cloned =3D=3D NULL || mount_info.mntfh =3D=3D NULL)
-=09=09goto out;
-
-=09/* create a new volume representation */
-=09mount_info.server =3D nfs4_create_referral_server(mount_info.cloned, mo=
unt_info.mntfh);
-=09mntroot =3D nfs_fs_mount_common(flags, dev_name, &mount_info, &nfs_v4);
-out:
-=09nfs_free_fhandle(mount_info.mntfh);
-=09return mntroot;
+=09return nfs_fs_mount_common(flags, dev_name, raw_data, &nfs_v4);
 }
=20
 /*
@@ -282,23 +273,35 @@ static struct dentry *nfs4_referral_mount(struct file=
_system_type *fs_type,
 =09=09int flags, const char *dev_name, void *raw_data)
 {
 =09struct nfs_clone_mount *data =3D raw_data;
+=09struct nfs_mount_info mount_info =3D {
+=09=09.fill_super =3D nfs_fill_super,
+=09=09.set_security =3D nfs_clone_sb_security,
+=09=09.cloned =3D data,
+=09};
 =09char *export_path;
 =09struct vfsmount *root_mnt;
 =09struct dentry *res;
=20
 =09dprintk("--> nfs4_referral_mount()\n");
=20
+=09mount_info.mntfh =3D nfs_alloc_fhandle();
+=09if (!mount_info.mntfh)
+=09=09return ERR_PTR(-ENOMEM);
+
 =09export_path =3D data->mnt_path;
 =09data->mnt_path =3D "/";
-
 =09root_mnt =3D nfs_do_root_mount(&nfs4_remote_referral_fs_type,
-=09=09=09flags, data, data->hostname);
+=09=09=09nfs4_create_referral_server(mount_info.cloned,
+=09=09=09=09=09=09    mount_info.mntfh),
+=09=09=09flags, &mount_info, data->hostname);
 =09data->mnt_path =3D export_path;
=20
 =09res =3D nfs_follow_remote_path(root_mnt, export_path);
 =09dprintk("<-- nfs4_referral_mount() =3D %d%s\n",
 =09=09PTR_ERR_OR_ZERO(res),
 =09=09IS_ERR(res) ? " [error]" : "");
+
+=09nfs_free_fhandle(mount_info.mntfh);
 =09return res;
 }
=20
--=20
2.17.2

