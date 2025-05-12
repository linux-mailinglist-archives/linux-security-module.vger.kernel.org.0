Return-Path: <linux-security-module+bounces-9846-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5C0AB3860
	for <lists+linux-security-module@lfdr.de>; Mon, 12 May 2025 15:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC017175F7D
	for <lists+linux-security-module@lfdr.de>; Mon, 12 May 2025 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5B2295501;
	Mon, 12 May 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SB89aJzJ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27D294A12
	for <linux-security-module@vger.kernel.org>; Mon, 12 May 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055968; cv=none; b=uAJPdQnj/N0iCxu4jsmgW7OiEMcGEJilgXO+JJv+xUumuoQ6igeTj/MiLxXlsGPb3GSlSo1pZaHE/xg6xT3wycAfQ6mizatZxlLJLeZ9Q5tpAZ1cwXLFe2sJnLgZgLdUCl6WbpisxfFrKqEEYvAfacoFaRoYJHpYS0bT8ErDyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055968; c=relaxed/simple;
	bh=DoJT2dz8txJo2HLysgqy6uqVMVeur99HqA28GNGz35o=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=GpL/lg9JA5ppnxHhN6e4z+n3Uq0n0JlaZPo1BLNdstv8xGTjsIJicuvo1eFfSe0g1mO7s/Ig6Sk7nt7syX7KPOEbTINYRhULZbjC8Gc2Ebow0w2qo9fmauObEiPyV9bMcBT6UMQS1/QSraHtdSb0e502Q5DvBw1Z4jT2suc7/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SB89aJzJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747055963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=znSs0IWOkqtw8MwO3eoXgDf53PvMGgHP2+ODqAezjoE=;
	b=SB89aJzJfMVb9HOItHzgicGgmObEe8IRIZTo7iBFKLuGt0TcA5EI7Y5I85OlRsyWCCchlh
	RveSiH11gE+HxRjtPrl1v+yTXhUdGTIEaAG2tYMa6yccAFDDw9Unvqg5tDdsfkc1oANQg6
	tbmPo0UtPZX+eRQ6ZG88K3xFgwVro6s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-g3G129XmOVSjuroAbQUqng-1; Mon, 12 May 2025 09:19:19 -0400
X-MC-Unique: g3G129XmOVSjuroAbQUqng-1
X-Mimecast-MFC-AGG-ID: g3G129XmOVSjuroAbQUqng_1747055959
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acbbb000796so349264566b.2
        for <linux-security-module@vger.kernel.org>; Mon, 12 May 2025 06:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055955; x=1747660755;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znSs0IWOkqtw8MwO3eoXgDf53PvMGgHP2+ODqAezjoE=;
        b=lUJ+FyDBTfBa2AD62pOclY0aNv2bnI79ubu/nWPlhjQ8umyIzW0ID02WkXNG0fBWdm
         XRWwHCLkHLjrIR1K7P/2WBTQNnHpPIuPV9XR5fU6QjSIbUwfOYNKmWJJVLlXAGSAQsty
         YunSMMUP+dng/wdvxFbt3FoJWGrOAqFResC4ezamBXTv0gjj4xuRdc+bXA/ATXomwK6j
         xkIWTxdze9u/PIM76562nVj/fZC2/kCoyzX2gJzzYe0bjiVb3h4/HEU7vHrSW+ss7IxA
         620uNNMtfyV+hQC4RGWqVLzSYjplOcGLLoQzGU3tivgxlxQNvNbOKVZ624bAocU1a5hZ
         uHng==
X-Forwarded-Encrypted: i=1; AJvYcCX3fLx27voeW8jfOtBu2vtt8mWt8bsig93uNQwvJLOP4KSxn1XvO6seMo5EsIRIREV6+iEnZIr8KIq5lUT0b8gP9AQAyhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN2A3qKIZ35jqLdvpYrgi6TCjxRauotDafHgbwbEZjcRZ8IEG1
	bRccy6+xd44QZzFOA/Lu3y+SJSTp2RY8EBYPC+2tMIVxPqTMaRG1s9BOJtc35+6+AoDgAZFJPuL
	4gZEsOF9dRuTo0xW1YHVVd11bVooFSyf86g4ZmxHF7AjutZVOcgqSIGs9qI0wCZIcPSITu0e4
X-Gm-Gg: ASbGncsTe+TzasD/jSlzlIXADUCLfQ7/62sLhq9B8g0dUrNbVHLcLGmzmlBMQpqj2Dl
	rXlfcOftUQbj4ok8aA7A3boKsHdG2ra00JVli0ig+YsGYa7k9OBsLaSnnMemLpsM8/nwMErHAvS
	iVRg89PPBHPa4hysrYzjPlQY3r6YJ6gCIdJkwK5wbPyWoXw28IHKKvOk06dywzOJLiDUDv86R4r
	K0O4FB4+tQJb0QWQlt7sGc+Wtj7fnexk1HisJv0drKWtIWPyxX7fW70DrZnruV0CDwAHhd4Oumm
	R080OkE9drFQ9ImbxPHzAeL36Uo=
X-Received: by 2002:a17:907:3e1f:b0:ad2:4fa0:88d1 with SMTP id a640c23a62f3a-ad24fa08b96mr397882466b.9.1747055954480;
        Mon, 12 May 2025 06:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2gaN4nId6A/kunm1rnCP/+7J7Yrf/475CQq5wTNUNFEpBtRjClSuGrdC8wxlG4kjN+bjbbw==
X-Received: by 2002:a17:907:3e1f:b0:ad2:4fa0:88d1 with SMTP id a640c23a62f3a-ad24fa08b96mr397878666b.9.1747055953940;
        Mon, 12 May 2025 06:19:13 -0700 (PDT)
Received: from [127.0.0.1] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bde09sm612328766b.125.2025.05.12.06.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:19:13 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v5 0/7] fs: introduce file_getattr and file_setattr
 syscalls
Date: Mon, 12 May 2025 15:18:53 +0200
Message-Id: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAD31IWgC/23NTQrCMBCG4auUrI0kkx9bV95DXCTNRIOllaSEl
 tK7m4ogosv3g3lmIQljwESO1UIi5pDC0JdQu4q0N9NfkQZXmgADxTiXdDLjGM1I05xa03VUG86
 FduCsaki5ekT0YXqJ50vpW0jjEOfXgwzb+rYAfqwMlFNlhWZOettaON0x9tjth3glG5bFBwDOf
 wFRAMMOjitfN/UfQH4AAX8ASRkVWANqbwVo+QWs6/oEtac3pDEBAAA=
X-Change-ID: 20250114-xattrat-syscall-6a1136d2db59
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
 selinux@vger.kernel.org, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 Andrey Albershteyn <aalbersh@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7943; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=DoJT2dz8txJo2HLysgqy6uqVMVeur99HqA28GNGz35o=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMhS/+ikUz/+zKeDcJU4Vu/2bX35T2jNhmd4FXg6HD
 +dm71lmfeB2RykLgxgXg6yYIss6aa2pSUVS+UcMauRh5rAygQxh4OIUgIk8E2D4p9yRo7vd7Fx2
 +08doV9xDvUxK48fv6Khpfy+e1bF/469nIwMx3ZVrBNbc1PypFML49PkHfx7zu9tPaBw836nz26
 zZV/5OQBQ90ss
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pzBqNBCp3a3sVJONVoBs70ttlt8J4bTEuWEGxlqesQ4_1747055959
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patchset introduced two new syscalls file_getattr() and
file_setattr(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
except they use *at() semantics. Therefore, there's no need to open the
file to get a fd.

These syscalls allow userspace to set filesystem inode attributes on
special files. One of the usage examples is XFS quota projects.

XFS has project quotas which could be attached to a directory. All
new inodes in these directories inherit project ID set on parent
directory.

The project is created from userspace by opening and calling
FS_IOC_FSSETXATTR on each inode. This is not possible for special
files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
with empty project ID. Those inodes then are not shown in the quota
accounting but still exist in the directory. This is not critical but in
the case when special files are created in the directory with already
existing project quota, these new inodes inherit extended attributes.
This creates a mix of special files with and without attributes.
Moreover, special files with attributes don't have a possibility to
become clear or change the attributes. This, in turn, prevents userspace
from re-creating quota project on these existing files.

NAME

	file_getattr/file_setattr - get/set filesystem inode attributes

SYNOPSIS

	#include <sys/syscall.h>    /* Definition of SYS_* constants */
	#include <unistd.h>

	long syscall(SYS_file_getattr, int dirfd, const char *pathname,
		struct fsxattr *fsx, size_t size, unsigned int at_flags);
	long syscall(SYS_file_setattr, int dirfd, const char *pathname,
		struct fsxattr *fsx, size_t size, unsigned int at_flags);

	Note: glibc doesn't provide for file_getattr()/file_setattr(),
	use syscall(2) instead.

DESCRIPTION

	The syscalls take fd and path. If path is absolute, fd is not
	used. If path is empty, fd can be AT_FDCWD or any valid fd which
	will be used to get/set attributes on.

	This is an alternative to FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR
	ioctl with a difference that file don't need to be open as we
	can reference it with a path instead of fd. By having this we
	can manipulated filesystem inode attributes not only on regular
	files but also on special ones. This is not possible with
	FS_IOC_FSSETXATTR ioctl as with special files we can not call
	ioctl() directly on the filesystem inode using file descriptor.

	at_flags can be set to AT_SYMLINK_NOFOLLOW or AT_EMPTY_PATH.

RETURN VALUE

	On success, 0 is returned.  On error, -1 is returned, and errno
	is set to indicate the error.

ERRORS

	EINVAL		Invalid at_flag specified (only
			AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH is
			supported).

	EINVAL		Size was smaller than any known version of
			struct fsxattr.

	EINVAL		Invalid combination of parameters provided in
			fsxattr for this type of file.

	E2BIG		Size of input argument **struct fsxattr** is too
			big.

	EBADF		Invalid file descriptor was provided.

	EPERM		No permission to change this file.

	EOPNOTSUPP	Filesystem does not support setting attributes
			on this type of inode

HISTORY

	Added in Linux 6.15.

EXAMPLE

Create directory and file "mkdir ./dir && touch ./dir/foo" and then
execute the following program:

	#include <fcntl.h>
	#include <errno.h>
	#include <string.h>
	#include <linux/fs.h>
	#include <stdio.h>
	#include <sys/syscall.h>
	#include <unistd.h>

	int
	main(int argc, char **argv) {
		int dfd;
		int error;
		struct fsxattr fsx;

		dfd = open("./dir", O_RDONLY);
		if (dfd == -1) {
			printf("can not open ./dir");
			return dfd;
		}

		error = syscall(467, dfd, "./foo", &fsx, 0);
		if (error) {
			printf("can not call 467: %s", strerror(errno));
			return error;
		}

		printf("dir/foo flags: %d\n", fsx.fsx_xflags);

		fsx.fsx_xflags |= FS_XFLAG_NODUMP;
		error = syscall(468, dfd, "./foo", &fsx, 0);
		if (error) {
			printf("can not call 468: %s", strerror(errno));
			return error;
		}

		printf("dir/foo flags: %d\n", fsx.fsx_xflags);

		return error;
	}

SEE ALSO

	ioctl(2), ioctl_iflags(2), ioctl_xfs_fsgetxattr(2)

---
Changes in v5:
- Remove setting of LOOKUP_EMPTY flags which does not have any effect
- Return -ENOSUPP from vfs_fileattr_set()
- Add fsxattr masking (by Amir)
- Fix UAF issue dentry
- Fix getname_maybe_null() issue with NULL path
- Implement file_getattr/file_setattr hooks
- Return LSM return code from file_setattr
- Rename from getfsxattrat/setfsxattrat to file_getattr/file_setattr
- Link to v4: https://lore.kernel.org/r/20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org

Changes in v4:
- Use getname_maybe_null() for correct handling of dfd + path semantic
- Remove restriction for special files on which flags are allowed
- Utilize copy_struct_from_user() for better future compatibility
- Add draft man page to cover letter
- Convert -ENOIOCTLCMD to -EOPNOSUPP as more appropriate for syscall
- Add missing __user to header declaration of syscalls
- Link to v3: https://lore.kernel.org/r/20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org

Changes in v3:
- Remove unnecessary "dfd is dir" check as it checked in user_path_at()
- Remove unnecessary "same filesystem" check
- Use CLASS() instead of directly calling fdget/fdput
- Link to v2: https://lore.kernel.org/r/20250122-xattrat-syscall-v2-1-5b360d4fbcb2@kernel.org

v1:
https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@kernel.org/

Previous discussion:
https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/

---
Amir Goldstein (1):
      fs: prepare for extending file_get/setattr()

Andrey Albershteyn (6):
      fs: split fileattr related helpers into separate file
      lsm: introduce new hooks for setting/getting inode fsxattr
      selinux: implement inode_file_[g|s]etattr hooks
      fs: split fileattr/fsxattr converters into helpers
      fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
      fs: introduce file_getattr and file_setattr syscalls

 arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
 arch/arm/tools/syscall.tbl                  |   2 +
 arch/arm64/tools/syscall_32.tbl             |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
 arch/s390/kernel/syscalls/syscall.tbl       |   2 +
 arch/sh/kernel/syscalls/syscall.tbl         |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
 fs/Makefile                                 |   3 +-
 fs/ecryptfs/inode.c                         |   8 +-
 fs/file_attr.c                              | 475 ++++++++++++++++++++++++++++
 fs/ioctl.c                                  | 309 ------------------
 fs/overlayfs/inode.c                        |   2 +-
 include/linux/fileattr.h                    |  26 ++
 include/linux/lsm_hook_defs.h               |   2 +
 include/linux/security.h                    |  16 +
 include/linux/syscalls.h                    |   6 +
 include/uapi/asm-generic/unistd.h           |   8 +-
 include/uapi/linux/fs.h                     |   3 +
 security/security.c                         |  30 ++
 security/selinux/hooks.c                    |  14 +
 29 files changed, 621 insertions(+), 313 deletions(-)
---
base-commit: 0d8d44db295ccad20052d6301ef49ff01fb8ae2d
change-id: 20250114-xattrat-syscall-6a1136d2db59

Best regards,
-- 
Andrey Albershteyn <aalbersh@kernel.org>


