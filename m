Return-Path: <linux-security-module+bounces-8322-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85CBA42731
	for <lists+linux-security-module@lfdr.de>; Mon, 24 Feb 2025 17:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860371687EC
	for <lists+linux-security-module@lfdr.de>; Mon, 24 Feb 2025 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BE926158D;
	Mon, 24 Feb 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FS4DC/RE"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8C261577
	for <linux-security-module@vger.kernel.org>; Mon, 24 Feb 2025 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412815; cv=none; b=bW48UKKJ01WiLJfeHixI7CO2b9ecEx9pYfkbqGWnypL8dpllRFwej3WcdDe2uXZXCRZVKZLG4f5X+EVrMUSniB2YyCcCk2aHu5emrtvPBXgpxklcp52uIzawxmxR/rQYhP01/1TQT4GUCSb6SmKo+bczYSNEwaMYGEEv7E5FTX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412815; c=relaxed/simple;
	bh=AdyXgY16YNekp+2cH5s3+823NmA4/JzTMk5uuqG/0jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mAJ44Zn9h65Cmjf2H4X+rK0lmUFUHB5ubidBRlZYuVTR5OqmnvtCFyo9KS30qHl1Rq6Zgfzl0K0X3Vc4iYJF/cy4ZnpElMeB/jenVX27ys0CrrkgTBh+mtWzF0gPbHAZbmKg+atAqN80MTyiNdH90ON33tCC2F0MMnsuZV37auM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FS4DC/RE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740412811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpJsnx/DlFS+m2+wC+CtveEzavYNI09p8+P4b7TZQL4=;
	b=FS4DC/REFoxmAQWcIv2Mwqw0W6Voh0LA1t7Y4w/EMPVXjaplNATYnQw1MI9fEeYVd8384P
	o1n/jPWe0U6meIPQKS973SeRqXyobml7iYlZj9l7bjnCUG/eTjL9aeSxjDKyItSUeeNKAz
	7Iogesud1dUgRc9ThWxsDZA4g244nUk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-vwLWSTuPM_KY6DoLUnldeg-1; Mon, 24 Feb 2025 11:00:10 -0500
X-MC-Unique: vwLWSTuPM_KY6DoLUnldeg-1
X-Mimecast-MFC-AGG-ID: vwLWSTuPM_KY6DoLUnldeg_1740412809
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f2f438fb6so5133660f8f.1
        for <linux-security-module@vger.kernel.org>; Mon, 24 Feb 2025 08:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740412809; x=1741017609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpJsnx/DlFS+m2+wC+CtveEzavYNI09p8+P4b7TZQL4=;
        b=dOzfttfj/dVN1UGBEF8NamWLV3cYl8twpFqPFacXbqAwnBWhOy8+GkxG+9ISsNPDAI
         NLhn8LICd/bvhj7o5B7pdLftFg+7RLDJgGGoBnR2FZ3PwqERQWjugo0NVez8Gg5jmtmO
         5XDFodgEU1Gz+oabNfaG1WKf8KIWo89YTrXq0Ffu4Lk6t5Ph75XQ21YUAIAjnG4ue+Ge
         Kzc+xukvi5fVGPX0cJh2W6S6KJZCeZAwIg1fCNIIV+xnFS6nWYh72ySGDXI7nxVpQFL9
         MUvY1MxaRFuIYG48qnCmZu/zOgYv7B/6slsCLp8mhyMc/Fm04gxBsrkrFF5WVw8QTIm1
         NkHA==
X-Forwarded-Encrypted: i=1; AJvYcCWEADs72IqC9darpvwH0G8n7wQkAdGKTFbjiESPqqHrLUoVdTVwk+xOpijBql9c06UunNwcWknFlZqgulPET9zDvNmlOPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKKREc10JLK2RdLZ7n5rd2F4lRNumAoxJdhUH4tArMVzmjh7P
	NjBE1TiAnxmyNzdwQF6ayo32YH00XEeGkgQUj8V967FeUFB1hGV+A/aBQObzEB/vDmVxGonjWBr
	DfOiijTuJCPgdaDvfjBpJ1UJISFQaiGsIviy2XQ3MJXoiKjhQbJJHAxcczK1R0OwmWzEHV5Of
X-Gm-Gg: ASbGncsO6VOk7NlSk8pR6pvN2OAd5g+BFJrnG9/8WdZ+3a9xsmQza3ET7e+hJIHaOV0
	vv9vYAL3wVF8Yn8+K/RhK3d0NoHGSxAGkoL5v2wTKrimJKMFPCYbhp2xgtuJ4Z4u/NGTHqrnkAy
	SrOYE3sIIFBN5G/r4ie0UG04rCZzN6nhuWMYidYq2+r89HT6FNtQ48zvr6LM3X7khfeCoYhPp0R
	zzVkhN/jE0B7ko7mwj2JxoW7iSpLojc82VYR370xYsEKn+OBbHa5K+SPbsr8nkLmYVGP/1NCeNa
	wADbSMJ7Nt8eKUBdFSM3K0TxE1TICrfVSZY=
X-Received: by 2002:a05:6000:1fa1:b0:38f:4cdc:5d21 with SMTP id ffacd0b85a97d-38f6e97a9dcmr12224779f8f.24.1740412809195;
        Mon, 24 Feb 2025 08:00:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRB2XHSy5TyYjE+T5i1FHBWJzQQ+oKxvmCxdX7G981Poru458aCvgYJqnx5VUZ7SWREA2qKg==
X-Received: by 2002:a05:6000:1fa1:b0:38f:4cdc:5d21 with SMTP id ffacd0b85a97d-38f6e97a9dcmr12224740f8f.24.1740412808720;
        Mon, 24 Feb 2025 08:00:08 -0800 (PST)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbab9e9863sm1469799966b.64.2025.02.24.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:00:08 -0800 (PST)
Date: Mon, 24 Feb 2025 17:00:06 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <jvo6uj7ro5czlo5ukw3vtf5mpqgrbuksqq4j63s2i6gwrjpz4m@kghpcqyi7gwb>
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
 <20250221.ahB8jei2Chie@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250221.ahB8jei2Chie@digikod.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6IEk4u59mA3UP1y3H2wpo0Tcm0txIOvaJO2MxpTiJvo_1740412809
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2025-02-21 16:08:33, Micka�l Sala�n wrote:
> It looks security checks are missing.  With IOCTL commands, file
> permissions are checked at open time, but with these syscalls the path
> is only resolved but no specific access seems to be checked (except
> inode_owner_or_capable via vfs_fileattr_set).
> 
> On Tue, Feb 11, 2025 at 06:22:47PM +0100, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> > extended attributes/flags. The syscalls take parent directory fd and
> > path to the child together with struct fsxattr.
> > 
> > This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> > that file don't need to be open as we can reference it with a path
> > instead of fd. By having this we can manipulated inode extended
> > attributes not only on regular files but also on special ones. This
> > is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> > we can not call ioctl() directly on the filesystem inode using fd.
> > 
> > This patch adds two new syscalls which allows userspace to get/set
> > extended inode attributes on special files by using parent directory
> > and a path - *at() like syscall.
> > 
> > Also, as vfs_fileattr_set() is now will be called on special files
> > too, let's forbid any other attributes except projid and nextents
> > (symlink can have an extent).
> > 
> > CC: linux-api@vger.kernel.org
> > CC: linux-fsdevel@vger.kernel.org
> > CC: linux-xfs@vger.kernel.org
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> > v1:
> > https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@kernel.org/
> > 
> > Previous discussion:
> > https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/
> > 
> > XFS has project quotas which could be attached to a directory. All
> > new inodes in these directories inherit project ID set on parent
> > directory.
> > 
> > The project is created from userspace by opening and calling
> > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> > with empty project ID. Those inodes then are not shown in the quota
> > accounting but still exist in the directory. Moreover, in the case
> > when special files are created in the directory with already
> > existing project quota, these inode inherit extended attributes.
> > This than leaves them with these attributes without the possibility
> > to clear them out. This, in turn, prevents userspace from
> > re-creating quota project on these existing files.
> > ---
> > Changes in v3:
> > - Remove unnecessary "dfd is dir" check as it checked in user_path_at()
> > - Remove unnecessary "same filesystem" check
> > - Use CLASS() instead of directly calling fdget/fdput
> > - Link to v2: https://lore.kernel.org/r/20250122-xattrat-syscall-v2-1-5b360d4fbcb2@kernel.org
> > ---
> >  arch/alpha/kernel/syscalls/syscall.tbl      |  2 +
> >  arch/arm/tools/syscall.tbl                  |  2 +
> >  arch/arm64/tools/syscall_32.tbl             |  2 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       |  2 +
> >  arch/microblaze/kernel/syscalls/syscall.tbl |  2 +
> >  arch/mips/kernel/syscalls/syscall_n32.tbl   |  2 +
> >  arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 +
> >  arch/mips/kernel/syscalls/syscall_o32.tbl   |  2 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     |  2 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    |  2 +
> >  arch/s390/kernel/syscalls/syscall.tbl       |  2 +
> >  arch/sh/kernel/syscalls/syscall.tbl         |  2 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      |  2 +
> >  arch/x86/entry/syscalls/syscall_32.tbl      |  2 +
> >  arch/x86/entry/syscalls/syscall_64.tbl      |  2 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     |  2 +
> >  fs/inode.c                                  | 75 +++++++++++++++++++++++++++++
> >  fs/ioctl.c                                  | 16 +++++-
> >  include/linux/fileattr.h                    |  1 +
> >  include/linux/syscalls.h                    |  4 ++
> >  include/uapi/asm-generic/unistd.h           |  8 ++-
> >  21 files changed, 133 insertions(+), 3 deletions(-)
> > 
> 
> [...]
> 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 6b4c77268fc0ecace4ac78a9ca777fbffc277f4a..b2dddd9db4fabaf67a6cbf541a86978b290411ec 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -23,6 +23,9 @@
> >  #include <linux/rw_hint.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/syscalls.h>
> > +#include <linux/fileattr.h>
> > +#include <linux/namei.h>
> >  #include <trace/events/writeback.h>
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/timestamp.h>
> > @@ -2953,3 +2956,75 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
> >  	return mode & ~S_ISGID;
> >  }
> >  EXPORT_SYMBOL(mode_strip_sgid);
> > +
> > +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
> > +		struct fsxattr __user *, fsx, unsigned int, at_flags)
> > +{
> > +	CLASS(fd, dir)(dfd);
> > +	struct fileattr fa;
> > +	struct path filepath;
> > +	int error;
> > +	unsigned int lookup_flags = 0;
> > +
> > +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> > +		return -EINVAL;
> > +
> > +	if (at_flags & AT_SYMLINK_FOLLOW)
> > +		lookup_flags |= LOOKUP_FOLLOW;
> > +
> > +	if (at_flags & AT_EMPTY_PATH)
> > +		lookup_flags |= LOOKUP_EMPTY;
> > +
> > +	if (fd_empty(dir))
> > +		return -EBADF;
> > +
> > +	error = user_path_at(dfd, filename, lookup_flags, &filepath);
> > +	if (error)
> > +		return error;
> 
> security_inode_getattr() should probably be called here.
> 
> > +
> > +	error = vfs_fileattr_get(filepath.dentry, &fa);
> > +	if (!error)
> > +		error = copy_fsxattr_to_user(&fa, fsx);
> > +
> > +	path_put(&filepath);
> > +	return error;
> > +}
> > +
> > +SYSCALL_DEFINE4(setfsxattrat, int, dfd, const char __user *, filename,
> > +		struct fsxattr __user *, fsx, unsigned int, at_flags)
> > +{
> > +	CLASS(fd, dir)(dfd);
> > +	struct fileattr fa;
> > +	struct path filepath;
> > +	int error;
> > +	unsigned int lookup_flags = 0;
> > +
> > +	if ((at_flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
> > +		return -EINVAL;
> > +
> > +	if (at_flags & AT_SYMLINK_FOLLOW)
> > +		lookup_flags |= LOOKUP_FOLLOW;
> > +
> > +	if (at_flags & AT_EMPTY_PATH)
> > +		lookup_flags |= LOOKUP_EMPTY;
> > +
> > +	if (fd_empty(dir))
> > +		return -EBADF;
> > +
> > +	if (copy_fsxattr_from_user(&fa, fsx))
> > +		return -EFAULT;
> > +
> > +	error = user_path_at(dfd, filename, lookup_flags, &filepath);
> > +	if (error)
> > +		return error;
> > +
> > +	error = mnt_want_write(filepath.mnt);
> > +	if (!error) {
> 
> security_inode_setattr() should probably be called too.

Aren't those checks for something different - inode attributes
ATTR_*?
(sorry, the naming can't be more confusing)

Looking into security_inode_setattr() it seems to expect struct
iattr, which works with inode attributes (mode, time, uid/gid...).
These new syscalls work with filesystem inode extended flags/attributes
FS_XFLAG_* in fsxattr->fsx_xflags. Let me know if I missing
something here

-- 
- Andrey


