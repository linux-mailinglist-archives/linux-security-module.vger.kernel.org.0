Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82F31118857
	for <lists+linux-security-module@lfdr.de>; Tue, 10 Dec 2019 13:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfLJMcs (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 10 Dec 2019 07:32:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfLJMbY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khcIL4+wv9RIQRFtGHMKM1uJK9yR6QWB6UAOQXbTNJ8=;
        b=XaIMSdzkF4agSZTNmoQ8mg6ame9NfFYG0ZDy8Cetygod74XKtDoNZhs73K117UFUdLPCjZ
        /uN3tlzbmr3Av82/zxurLKfRSqOv6d8JNDehmviq6h5sf6YNRYaigXAGwBbSTjOujUlPjr
        q5IsVtdwfRLDLHivar8lgzK8RGTeYNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-th6cntvtPVWStFSNe5DOMQ-1; Tue, 10 Dec 2019 07:31:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1BE92EED;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 663116FDDF;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id EAF9020C2F; Tue, 10 Dec 2019 07:31:15 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 19/27] NFS: Split nfs_parse_mount_options()
Date:   Tue, 10 Dec 2019 07:31:07 -0500
Message-Id: <20191210123115.1655-20-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: th6cntvtPVWStFSNe5DOMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Split nfs_parse_mount_options() to move the prologue, list-splitting and
epilogue into one function and the per-option processing into another.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/fs_context.c | 126 ++++++++++++++++++++++++--------------------
 fs/nfs/internal.h   |   3 ++
 2 files changed, 73 insertions(+), 56 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 52aa2b8522f0..a386825c3b0f 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -496,36 +496,18 @@ static int nfs_get_option_ul_bound(substring_t args[]=
, unsigned long *option,
 }
=20
 /*
- * Error-check and convert a string of mount options from user space into
- * a data structure.  The whole mount string is processed; bad options are
- * skipped as they are encountered.  If there were no errors, return 1;
- * otherwise return 0 (zero).
+ * Parse a single mount option in "key[=3Dval]" form.
  */
-int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
+static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p=
)
 {
-=09char *p, *string;
-=09int rc, sloppy =3D 0, invalid_option =3D 0;
-=09unsigned short protofamily =3D AF_UNSPEC;
-=09unsigned short mountfamily =3D AF_UNSPEC;
-
-=09if (!raw) {
-=09=09dfprintk(MOUNT, "NFS: mount options string was NULL.\n");
-=09=09return 1;
-=09}
-=09dfprintk(MOUNT, "NFS: nfs mount opts=3D'%s'\n", raw);
-
-=09rc =3D security_sb_eat_lsm_opts(raw, &ctx->lsm_opts);
-=09if (rc)
-=09=09goto out_security_failure;
+=09char *string;
+=09int rc;
=20
-=09while ((p =3D strsep(&raw, ",")) !=3D NULL) {
+=09{
 =09=09substring_t args[MAX_OPT_ARGS];
 =09=09unsigned long option;
 =09=09int token;
=20
-=09=09if (!*p)
-=09=09=09continue;
-
 =09=09dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", p);
=20
 =09=09token =3D match_token(p, nfs_mount_option_tokens, args);
@@ -734,7 +716,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_co=
ntext *ctx)
 =09=09=09if (!rc) {
 =09=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
 =09=09=09=09=09=09"security flavor\n");
-=09=09=09=09return 0;
+=09=09=09=09return -EINVAL;
 =09=09=09}
 =09=09=09break;
 =09=09case Opt_proto:
@@ -744,24 +726,24 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_=
context *ctx)
 =09=09=09token =3D match_token(string,
 =09=09=09=09=09    nfs_xprt_protocol_tokens, args);
=20
-=09=09=09protofamily =3D AF_INET;
+=09=09=09ctx->protofamily =3D AF_INET;
 =09=09=09switch (token) {
 =09=09=09case Opt_xprt_udp6:
-=09=09=09=09protofamily =3D AF_INET6;
+=09=09=09=09ctx->protofamily =3D AF_INET6;
 =09=09=09=09/* fall through */
 =09=09=09case Opt_xprt_udp:
 =09=09=09=09ctx->flags &=3D ~NFS_MOUNT_TCP;
 =09=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
 =09=09=09=09break;
 =09=09=09case Opt_xprt_tcp6:
-=09=09=09=09protofamily =3D AF_INET6;
+=09=09=09=09ctx->protofamily =3D AF_INET6;
 =09=09=09=09/* fall through */
 =09=09=09case Opt_xprt_tcp:
 =09=09=09=09ctx->flags |=3D NFS_MOUNT_TCP;
 =09=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
 =09=09=09=09break;
 =09=09=09case Opt_xprt_rdma6:
-=09=09=09=09protofamily =3D AF_INET6;
+=09=09=09=09ctx->protofamily =3D AF_INET6;
 =09=09=09=09/* fall through */
 =09=09=09case Opt_xprt_rdma:
 =09=09=09=09/* vector side protocols to TCP */
@@ -773,7 +755,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_co=
ntext *ctx)
 =09=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
 =09=09=09=09=09=09"transport protocol\n");
 =09=09=09=09kfree(string);
-=09=09=09=09return 0;
+=09=09=09=09return -EINVAL;
 =09=09=09}
 =09=09=09kfree(string);
 =09=09=09break;
@@ -785,16 +767,16 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_=
context *ctx)
 =09=09=09=09=09    nfs_xprt_protocol_tokens, args);
 =09=09=09kfree(string);
=20
-=09=09=09mountfamily =3D AF_INET;
+=09=09=09ctx->mountfamily =3D AF_INET;
 =09=09=09switch (token) {
 =09=09=09case Opt_xprt_udp6:
-=09=09=09=09mountfamily =3D AF_INET6;
+=09=09=09=09ctx->mountfamily =3D AF_INET6;
 =09=09=09=09/* fall through */
 =09=09=09case Opt_xprt_udp:
 =09=09=09=09ctx->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
 =09=09=09=09break;
 =09=09=09case Opt_xprt_tcp6:
-=09=09=09=09mountfamily =3D AF_INET6;
+=09=09=09=09ctx->mountfamily =3D AF_INET6;
 =09=09=09=09/* fall through */
 =09=09=09case Opt_xprt_tcp:
 =09=09=09=09ctx->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
@@ -803,7 +785,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_co=
ntext *ctx)
 =09=09=09default:
 =09=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
 =09=09=09=09=09=09"transport protocol\n");
-=09=09=09=09return 0;
+=09=09=09=09return -EINVAL;
 =09=09=09}
 =09=09=09break;
 =09=09case Opt_addr:
@@ -867,7 +849,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_co=
ntext *ctx)
 =09=09=09=09default:
 =09=09=09=09=09dfprintk(MOUNT, "NFS:   invalid "
 =09=09=09=09=09=09=09"lookupcache argument\n");
-=09=09=09=09=09return 0;
+=09=09=09=09=09return -EINVAL;
 =09=09=09}
 =09=09=09break;
 =09=09case Opt_fscache_uniq:
@@ -900,7 +882,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_co=
ntext *ctx)
 =09=09=09default:
 =09=09=09=09dfprintk(MOUNT, "NFS:=09invalid=09"
 =09=09=09=09=09=09"local_lock argument\n");
-=09=09=09=09return 0;
+=09=09=09=09return -EINVAL;
 =09=09=09}
 =09=09=09break;
=20
@@ -908,7 +890,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_co=
ntext *ctx)
 =09=09 * Special options
 =09=09 */
 =09=09case Opt_sloppy:
-=09=09=09sloppy =3D 1;
+=09=09=09ctx->sloppy =3D 1;
 =09=09=09dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
 =09=09=09break;
 =09=09case Opt_userspace:
@@ -918,12 +900,53 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_=
context *ctx)
 =09=09=09break;
=20
 =09=09default:
-=09=09=09invalid_option =3D 1;
 =09=09=09dfprintk(MOUNT, "NFS:   unrecognized mount option "
 =09=09=09=09=09"'%s'\n", p);
+=09=09=09return -EINVAL;
 =09=09}
 =09}
=20
+=09return 0;
+
+out_invalid_address:
+=09printk(KERN_INFO "NFS: bad IP address specified: %s\n", p);
+=09return -EINVAL;
+out_invalid_value:
+=09printk(KERN_INFO "NFS: bad mount option value specified: %s\n", p);
+=09return -EINVAL;
+out_nomem:
+=09printk(KERN_INFO "NFS: not enough memory to parse option\n");
+=09return -ENOMEM;
+}
+
+/*
+ * Error-check and convert a string of mount options from user space into
+ * a data structure.  The whole mount string is processed; bad options are
+ * skipped as they are encountered.  If there were no errors, return 1;
+ * otherwise return 0 (zero).
+ */
+int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
+{
+=09char *p;
+=09int rc, sloppy =3D 0, invalid_option =3D 0;
+
+=09if (!raw) {
+=09=09dfprintk(MOUNT, "NFS: mount options string was NULL.\n");
+=09=09return 1;
+=09}
+=09dfprintk(MOUNT, "NFS: nfs mount opts=3D'%s'\n", raw);
+
+=09rc =3D security_sb_eat_lsm_opts(raw, &ctx->lsm_opts);
+=09if (rc)
+=09=09goto out_security_failure;
+
+=09while ((p =3D strsep(&raw, ",")) !=3D NULL) {
+=09=09if (!*p)
+=09=09=09continue;
+=09=09if (nfs_fs_context_parse_option(ctx, p) < 0)
+=09=09=09invalid_option =3D true;
+=09}
+
 =09if (!sloppy && invalid_option)
 =09=09return 0;
=20
@@ -938,22 +961,26 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_=
context *ctx)
 =09 * verify that any proto=3D/mountproto=3D options match the address
 =09 * families in the addr=3D/mountaddr=3D options.
 =09 */
-=09if (protofamily !=3D AF_UNSPEC &&
-=09    protofamily !=3D ctx->nfs_server.address.ss_family)
+=09if (ctx->protofamily !=3D AF_UNSPEC &&
+=09    ctx->protofamily !=3D ctx->nfs_server.address.ss_family)
 =09=09goto out_proto_mismatch;
=20
-=09if (mountfamily !=3D AF_UNSPEC) {
+=09if (ctx->mountfamily !=3D AF_UNSPEC) {
 =09=09if (ctx->mount_server.addrlen) {
-=09=09=09if (mountfamily !=3D ctx->mount_server.address.ss_family)
+=09=09=09if (ctx->mountfamily !=3D ctx->mount_server.address.ss_family)
 =09=09=09=09goto out_mountproto_mismatch;
 =09=09} else {
-=09=09=09if (mountfamily !=3D ctx->nfs_server.address.ss_family)
+=09=09=09if (ctx->mountfamily !=3D ctx->nfs_server.address.ss_family)
 =09=09=09=09goto out_mountproto_mismatch;
 =09=09}
 =09}
=20
 =09return 1;
=20
+out_minorversion_mismatch:
+=09printk(KERN_INFO "NFS: mount option vers=3D%u does not support "
+=09=09=09 "minorversion=3D%u\n", ctx->version, ctx->minorversion);
+=09return 0;
 out_mountproto_mismatch:
 =09printk(KERN_INFO "NFS: mount server address does not match mountproto=
=3D "
 =09=09=09 "option\n");
@@ -961,23 +988,10 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_=
context *ctx)
 out_proto_mismatch:
 =09printk(KERN_INFO "NFS: server address does not match proto=3D option\n"=
);
 =09return 0;
-out_invalid_address:
-=09printk(KERN_INFO "NFS: bad IP address specified: %s\n", p);
-=09return 0;
-out_invalid_value:
-=09printk(KERN_INFO "NFS: bad mount option value specified: %s\n", p);
-=09return 0;
-out_minorversion_mismatch:
-=09printk(KERN_INFO "NFS: mount option vers=3D%u does not support "
-=09=09=09 "minorversion=3D%u\n", ctx->version, ctx->minorversion);
-=09return 0;
 out_migration_misuse:
 =09printk(KERN_INFO
 =09=09"NFS: 'migration' not supported for this NFS version\n");
-=09return 0;
-out_nomem:
-=09printk(KERN_INFO "NFS: not enough memory to parse option\n");
-=09return 0;
+=09return -EINVAL;
 out_security_failure:
 =09printk(KERN_INFO "NFS: security options invalid: %d\n", rc);
 =09return 0;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 7131fa150d1b..d0abc7b65cd2 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -96,7 +96,10 @@ struct nfs_fs_context {
 =09unsigned int=09=09version;
 =09unsigned int=09=09minorversion;
 =09char=09=09=09*fscache_uniq;
+=09unsigned short=09=09protofamily;
+=09unsigned short=09=09mountfamily;
 =09bool=09=09=09need_mount;
+=09bool=09=09=09sloppy;
=20
 =09struct {
 =09=09struct sockaddr_storage=09address;
--=20
2.17.2

