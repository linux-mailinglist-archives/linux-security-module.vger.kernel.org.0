Return-Path: <linux-security-module+bounces-1986-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B56876F90
	for <lists+linux-security-module@lfdr.de>; Sat,  9 Mar 2024 08:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19911F2193D
	for <lists+linux-security-module@lfdr.de>; Sat,  9 Mar 2024 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3D5374FF;
	Sat,  9 Mar 2024 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuYaBUOr"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A3208A8
	for <linux-security-module@vger.kernel.org>; Sat,  9 Mar 2024 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970813; cv=none; b=ptvCtQRF6tkxdi4C61SQj7l/H4+fV0NVYBTCfNm1VUHq1jzmc01vQp+L4vFGxV5kPkIaKpm2utxsa2WLaCbiOxcBlD9y0EjL9V8z8hyaaMBotocoXAWlAqjqV5I6Qtunbum/5a7R9YBwKa48EX8F8niLsu4/R0iQxMdwJRgIn6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970813; c=relaxed/simple;
	bh=wJmTGdVJAVesVzJ6a6JxcjdNRnDAjqA+pjYKlN8mId8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eLCjxkt5bWtj/H4nZX82StoU6FI069i7LYYK0b+6isdiRULgw/QYbxaMm+d+wkDnUxuJlRIg4gqM4kyex8dSbuv/gDnCyroPl6gE29xBgehTO1OGiRWHCtHcekTS57whuDiLNb47OLL5ubGIMh4dr7+uNgqay1S87LLYxGIDWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WuYaBUOr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609fe434210so29268297b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 08 Mar 2024 23:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709970810; x=1710575610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEp+ydMHSAWkFv/Vs8D4y4Cop1/7Ih7jN+mIT5vXzyk=;
        b=WuYaBUOr7PAEemRsk6lnO6e+YkDmS0pquLpT4og1kyGojH2Rg905CXLSBKDFThT3+K
         q4pqfGV56pNa9GqxJ/vHCudrq4f6oqL2KPHqphLzvH36YTAJvO0ipVzfwueqwGK8RPK6
         Vtxkr2CYMww6oExLOEzRNw6KZnI7HgzkFOGw2DYoIZN+QfeKNO9QxhWckAVsmEEGitM5
         7ZjNfEtJzWHhGZ8rclaw3UtAXvT4oCqvSZfyGBni/Gi5z87UXzLPDsPU0QscQfuoBLbj
         RHr6jV0mp0vVBsN+ado2/Ou8oQY4F6HVzA6GLRS7Oe6qvbkbFd9sfAC+JbE3x5ifGvCO
         gVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709970810; x=1710575610;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vEp+ydMHSAWkFv/Vs8D4y4Cop1/7Ih7jN+mIT5vXzyk=;
        b=At818B1yw3iOqRp4ZTYCaTSiQF/HOA1/cRKjPuJGo/SlP7QUqOrEjapFpVBjICF4Za
         79LKnYWZ0nMcZYlqSlg78QtLmGtKcvpTqjUlRakGQZ5PJ9wWTzl7xgm4ufrvw57TspNp
         KQH7WIQDHWi+9Pjl4kIG+l0lmh89CXivN+rMCzKryLLgWSiXAEi8vUxNAzTSu1BqQ81J
         OkQjyR6Ft9KNuaHKWCp7+Ttb1oPP2wH08C/6shPqy2RK6OnkplLvXJjxK6dP7Xc1iuAb
         MRGdBBEwIF+Cb0kivf6xeaI/iFlhtWGlfpMSwgQbM+d2R8OHKM51cqRqApJkIa35CZ45
         oUBQ==
X-Gm-Message-State: AOJu0YzbutnkJrKH1I9tQB2oPytFxavUdxAsWgudqom4giT1w1AeqHT8
	GuYARU6TNv3h4VCYdjg9feUtQUdiOcEiIll5Bn0zFU/mu3Co0qT6EJMX2/omKY5wyoc/fy+z8je
	SdRW6wTn+WigkpwHU+9KLAotBGBO4DcI+7MbDsM9oVeHUVSpKE0NcJct/e7V7ySWnErNE1tOW4W
	vd3z2sdn7wNnOAGl39fmvBAfTdqLculrrce0Ivd4vcT+BMbdn6R3zk
X-Google-Smtp-Source: AGHT+IE5cd51kXjWILQL+fkvPRrBN0CEn11tEraMbiaXfMc65ONft54Z67V/0ucCG1EwDaoCnawdb7tDN+c=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a5b:988:0:b0:dcc:9f24:692b with SMTP id
 c8-20020a5b0988000000b00dcc9f24692bmr56710ybq.13.1709970809870; Fri, 08 Mar
 2024 23:53:29 -0800 (PST)
Date: Sat,  9 Mar 2024 07:53:13 +0000
In-Reply-To: <20240309075320.160128-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309075320.160128-3-gnoack@google.com>
Subject: [PATCH v10 2/9] landlock: Add IOCTL access right for character and
 block devices
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Introduces the LANDLOCK_ACCESS_FS_IOCTL_DEV right
and increments the Landlock ABI version to 5.

This access right applies to device-custom IOCTL commands
when they are invoked on block or character device files.

Like the truncate right, this right is associated with a file
descriptor at the time of open(2), and gets respected even when the
file descriptor is used outside of the thread which it was originally
opened in.

Therefore, a newly enabled Landlock policy does not apply to file
descriptors which are already open.

If the LANDLOCK_ACCESS_FS_IOCTL_DEV right is handled, only a small
number of safe IOCTL commands will be permitted on newly opened device
files.  These include FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC, as well
as other IOCTL commands for regular files which are implemented in
fs/ioctl.c.

Noteworthy scenarios which require special attention:

TTY devices are often passed into a process from the parent process,
and so a newly enabled Landlock policy does not retroactively apply to
them automatically.  In the past, TTY devices have often supported
IOCTL commands like TIOCSTI and some TIOCLINUX subcommands, which were
letting callers control the TTY input buffer (and simulate
keypresses).  This should be restricted to CAP_SYS_ADMIN programs on
modern kernels though.

Known limitations:

The LANDLOCK_ACCESS_FS_IOCTL_DEV access right is a coarse-grained
control over IOCTL commands.

Landlock users may use path-based restrictions in combination with
their knowledge about the file system layout to control what IOCTLs
can be done.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 include/uapi/linux/landlock.h                | 35 +++++++++++++-----
 security/landlock/fs.c                       | 38 ++++++++++++++++++--
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  8 +++--
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   |  5 +--
 6 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 25c8d7677539..193733d833b1 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -128,7 +128,7 @@ struct landlock_net_port_attr {
  * files and directories.  Files or directories opened before the sandboxi=
ng
  * are not subject to these restrictions.
  *
- * A file can only receive these access rights:
+ * The following access rights apply only to files:
  *
  * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
  * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note t=
hat
@@ -138,12 +138,13 @@ struct landlock_net_port_attr {
  * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
  * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate=
(2)`,
  *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` w=
ith
- *   ``O_TRUNC``. Whether an opened file can be truncated with
- *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, in t=
he
- *   same way as read and write permissions are checked during
- *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
- *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available since =
the
- *   third version of the Landlock ABI.
+ *   ``O_TRUNC``.  This access right is available since the third version =
of the
+ *   Landlock ABI.
+ *
+ * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or=
 used
+ * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same wa=
y as
+ * read and write permissions are checked during :manpage:`open(2)` using
+ * %LANDLOCK_ACCESS_FS_READ_FILE and %LANDLOCK_ACCESS_FS_WRITE_FILE.
  *
  * A directory can receive access rights related to files or directories. =
 The
  * following access right is applied to the directory itself, and the
@@ -198,13 +199,30 @@ struct landlock_net_port_attr {
  *   If multiple requirements are not met, the ``EACCES`` error code takes
  *   precedence over ``EXDEV``.
  *
+ * The following access right applies both to files and directories:
+ *
+ * - %LANDLOCK_ACCESS_FS_IOCTL_DEV: Invoke :manpage:`ioctl(2)` commands on=
 an opened
+ *   character or block device.
+ *
+ *   This access right applies to all `ioctl(2)` commands implemented by d=
evice
+ *   drivers.  However, the following common IOCTL commands continue to be
+ *   invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL_DEV right:
+ *
+ *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO``, ``FIOASYNC``, ``FIOQSIZE``,
+ *   ``FIFREEZE``, ``FITHAW``, ``FS_IOC_FIEMAP``, ``FIGETBSZ``, ``FICLONE`=
`,
+ *   ``FICLONERANGE``, ``FIDEDUPERANGE``, ``FS_IOC_GETFLAGS``,
+ *   ``FS_IOC_SETFLAGS``, ``FS_IOC_FSGETXATTR``, ``FS_IOC_FSSETXATTR``
+ *
+ *   This access right is available since the fifth version of the Landloc=
k
+ *   ABI.
+ *
  * .. warning::
  *
  *   It is currently not possible to restrict some file-related actions
  *   accessible through these syscall families: :manpage:`chdir(2)`,
  *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
  *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
- *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
+ *   :manpage:`fcntl(2)`, :manpage:`access(2)`.
  *   Future Landlock evolutions will enable to restrict them.
  */
 /* clang-format off */
@@ -223,6 +241,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
+#define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
 /* clang-format on */
=20
 /**
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6f0bf1434a2c..bfa69ea94cf8 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -148,7 +148,8 @@ static struct landlock_object *get_inode_object(struct =
inode *const inode)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 /* clang-format on */
=20
 /*
@@ -1332,8 +1333,10 @@ static int hook_file_alloc_security(struct file *con=
st file)
 static int hook_file_open(struct file *const file)
 {
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
-	access_mask_t open_access_request, full_access_request, allowed_access;
-	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
+	access_mask_t open_access_request, full_access_request, allowed_access,
+		optional_access;
+	const struct inode *inode =3D file_inode(file);
+	const bool is_device =3D S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode)=
;
 	const struct landlock_ruleset *const dom =3D get_current_fs_domain();
=20
 	if (!dom)
@@ -1350,6 +1353,10 @@ static int hook_file_open(struct file *const file)
 	 * We look up more access than what we immediately need for open(), so
 	 * that we can later authorize operations on opened files.
 	 */
+	optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
+	if (is_device)
+		optional_access |=3D LANDLOCK_ACCESS_FS_IOCTL_DEV;
+
 	full_access_request =3D open_access_request | optional_access;
=20
 	if (is_access_to_paths_allowed(
@@ -1406,6 +1413,30 @@ static int hook_file_truncate(struct file *const fil=
e)
 	return -EACCES;
 }
=20
+static int hook_file_vfs_ioctl(struct file *file, unsigned int cmd,
+			       unsigned long arg)
+{
+	const struct inode *inode =3D file_inode(file);
+	const bool is_device =3D S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode)=
;
+	access_mask_t required_access, allowed_access;
+
+	if (!is_device)
+		return 0;
+
+	/*
+	 * It is the access rights at the time of opening the file which
+	 * determine whether IOCTL can be used on the opened file later.
+	 *
+	 * The access right is attached to the opened file in hook_file_open().
+	 */
+	required_access =3D LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	allowed_access =3D landlock_file(file)->allowed_access;
+	if ((allowed_access & required_access) =3D=3D required_access)
+		return 0;
+
+	return -EACCES;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init =3D {
 	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
=20
@@ -1428,6 +1459,7 @@ static struct security_hook_list landlock_hooks[] __r=
o_after_init =3D {
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
 	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
+	LSM_HOOK_INIT(file_vfs_ioctl, hook_file_vfs_ioctl),
 };
=20
 __init void landlock_add_fs_hooks(void)
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 93c9c6f91556..20fdb5ff3514 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -18,7 +18,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
=20
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 #define LANDLOCK_SHIFT_ACCESS_FS	0
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 6788e73b6681..9ae3dfa47443 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -149,7 +149,7 @@ static const struct file_operations ruleset_fops =3D {
 	.write =3D fop_dummy_write,
 };
=20
-#define LANDLOCK_ABI_VERSION 4
+#define LANDLOCK_ABI_VERSION 5
=20
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -321,7 +321,11 @@ static int add_rule_path_beneath(struct landlock_rules=
et *const ruleset,
 	if (!path_beneath_attr.allowed_access)
 		return -ENOMSG;
=20
-	/* Checks that allowed_access matches the @ruleset constraints. */
+	/*
+	 * Checks that allowed_access matches the @ruleset constraints and only
+	 * consists of publicly visible access rights (as opposed to synthetic
+	 * ones).
+	 */
 	mask =3D landlock_get_raw_fs_access_mask(ruleset, 0);
 	if ((path_beneath_attr.allowed_access | mask) !=3D mask)
 		return -EINVAL;
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/s=
elftests/landlock/base_test.c
index 646f778dfb1e..d292b419ccba 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -75,7 +75,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr =3D {
 		.handled_access_fs =3D LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(5, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
=20
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 2d6d9b43d958..0bcbbf594fd7 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -527,9 +527,10 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
=20
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
=20
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
--=20
2.44.0.278.ge034bb2e1d-goog


