Return-Path: <linux-security-module+bounces-1793-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7BE86F006
	for <lists+linux-security-module@lfdr.de>; Sat,  2 Mar 2024 11:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F5A1F22607
	for <lists+linux-security-module@lfdr.de>; Sat,  2 Mar 2024 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AFC16FF4F;
	Sat,  2 Mar 2024 10:31:49 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D514275;
	Sat,  2 Mar 2024 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709375508; cv=none; b=fOZNE0Q23KT2ACUCJxzMKVrpwvMqzSJwgqHbdQ6ccfbDexKvy9I+Eh1yWKUEuDgox/xRT2PmzB8KJzFwfe13X6k9EIw4J8zyEOtMUSozWgj6xS+4kcAqy9ZmrtqOqViPOPrADY6iA+jTFpNElTESt5h//R+iyxZeo55aw40JXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709375508; c=relaxed/simple;
	bh=beDdbXEFaSG4DXuS5QVb0tO5/w8BENgdJ6p8YrVG+SU=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=OXm5w5KKiM5AkOxYaIBmHbtKaPvI3Qmpy+IXiZKoNIBIfKUbbQxtl42o0cfBugsP0mocWKyUmltre9BtH9/q5zwnEKHnHyWcyDBO+N9jw8iWoksGFHyUSmdtWbNzndxd9rJEwLscQHWLp247cfnKWzDa3lXK/XUsq3Yy0ZBj2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 9C3A337802F2;
	Sat,  2 Mar 2024 10:31:37 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <202403011451.C236A38@keescook>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240301213442.198443-1-adrian.ratiu@collabora.com> <202403011451.C236A38@keescook>
Date: Sat, 02 Mar 2024 10:31:37 +0000
Cc: linux-fsdevel@vger.kernel.org, kernel@collabora.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, "Guenter Roeck" <groeck@chromium.org>, "Doug Anderson" <dianders@chromium.org>, "Jann Horn" <jannh@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Christian Brauner" <brauner@kernel.org>, "Mike Frysinger" <vapier@chromium.org>
To: "Kees Cook" <keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158ea-65e30000-105-38e7da00@91796698>
Subject: =?utf-8?q?Re=3A?= [PATCH v2] =?utf-8?q?proc=3A?= allow restricting 
 /proc/pid/mem writes
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Saturday, March 02, 2024 01:55 EET, Kees Cook <keescook@chromium.org=
> wrote:

> On Fri, Mar 01, 2024 at 11:34:42PM +0200, Adrian Ratiu wrote:
> > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> > after which it got allowed in commit 198214a7ee50 ("proc: enable
> > writing to /proc/pid/mem"). Famous last words from that patch:
> > "no longer a security hazard". :)
> >=20
> > Afterwards exploits appeared started causing drama like [1]. The
>=20
> nit: I think "appeared" can be dropped here.
>=20
> > /proc/*/mem exploits can be rather sophisticated like [2] which
> > installed an arbitrary payload from noexec storage into a running
> > process then exec'd it, which itself could include an ELF loader
> > to run arbitrary code off noexec storage.
> >=20
> > As part of hardening against these types of attacks, distrbutions
> > can restrict /proc/*/mem to only allow writes when they makes sense=
,
> > like in case of debuggers which have ptrace permissions, as they
> > are able to access memory anyway via PTRACE=5FPOKEDATA and friends.
> >=20
> > Dropping the mode bits disables write access for non-root users.
> > Trying to `chmod` the paths back fails as the kernel rejects it.
> >=20
> > For users with CAP=5FDAC=5FOVERRIDE (usually just root) we have to
> > disable the mem=5Fwrite callback to avoid bypassing the mode bits.
> >=20
> > Writes can be used to bypass permissions on memory maps, even if a
> > memory region is mapped r-x (as is a program's executable pages),
> > the process can open its own /proc/self/mem file and write to the
> > pages directly.
> >=20
> > Even if seccomp filters block mmap/mprotect calls with W|X perms,
> > they often cannot block open calls as daemons want to read/write
> > their own runtime state and seccomp filters cannot check file paths=
.
> > Write calls also can't be blocked in general via seccomp.
> >=20
> > Since the mem file is part of the dynamic /proc/<pid>/ space, we
> > can't run chmod once at boot to restrict it (and trying to react
> > to every process and run chmod doesn't scale, and the kernel no
> > longer allows chmod on any of these paths).
> >=20
> > SELinux could be used with a rule to cover all /proc/*/mem files,
> > but even then having multiple ways to deny an attack is useful in
> > case on layer fails.
>=20
> Everything above here is good to keep in the commit log, but it's all
> the "background". Please also write here what has been done to addres=
s
> the background above it. e.g.:
>=20
> "Introduce a CONFIG and a =5F=5Fro=5Fafter=5Finit runtime toggle to m=
ake
> it so only processes that are already tracing the task to write to
> /proc/<pid>/mem." etc
>=20
> >=20
> > [1] https://lwn.net/Articles/476947/
> > [2] https://issues.chromium.org/issues/40089045
>=20
> These can be:
>=20
> Link: https://lwn.net/Articles/476947/ [1]
> Link: https://issues.chromium.org/issues/40089045 [2]
>=20
> > Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
> >=20
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Co-developed-by: Mike Frysinger <vapier@chromium.org>
> > Signed-off-by: Mike Frysinger <vapier@chromium.org>
> > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > ---
> > Changes in v2:
> >  * Added boot time parameter with default kconfig option
> >  * Moved check earlier in mem=5Fopen() instead of mem=5Fwrite()
> >  * Simplified implementation branching
> >  * Removed dependency on CONFIG=5FMEMCG
>=20
> Can you mention in the commit log what behaviors have been tested wit=
h
> this patch? For example, I assume gdb still works with
> restrict=5Fproc=5Fmem=5Fwrite=3Dy ?
>=20

Thanks, I will address all the above commit message feedback in v3.

Yes, gdb and gdbserver work with restrict=5Fproc=5Fmem=5Fwrite=3Dy. My =
testing is
focused on the correct functioning of GDB and gdbserver (lldb/server us=
e=20
ptrace POKEDATA so they work regardless of restrict=5Fproc=5Fmem=5Fwrit=
e).

This all started from my attempt to fix gdbserver by adding a ptrace fa=
llback
in case /proc/pid/mem writes are blocked without any exception, because
that breaks basic functionality like setting breakpoints.

GDB upstream NAK'ed my ptrace fallback approach because it's doesn't
work well with their /proc/pid/mem focused design required for non-stop=20
mode (the default all-stop mode is emulated on top of non-stop), as wel=
l
as ptrace peek/poke requiring a live task which can cause memory access
problems if the ptraced task dies.

Other solutions were considered by GDB upstream, including using the=20
process=5Fvm=5Fwritev & co, but they respect page permissions and GDB h=
as
to write RO pages to set breakpoints.

In the end GDB maintainers directed me to do a proper kernel fix with a=
n
exception for tasks already ptracing others, because from a security
perspective, they can already access tracee memory regardless of
/proc/pid/mem restrictions, so here we are. :)

> When this is enabled, what =5Fdoes=5F break that people might expect =
to
> work?

With the current iteration, all things I tested work as expected. It is=
 rather
hard to come up with things that break with restrict=5Fproc=5Fmem=5Fwri=
te=3Dy,
because other than debuggers and exploits I don't have other use-cases.

Obvious things like "echo >/proc/self/mem" get permission denied, but
that is expected with restrict=5Fproc=5Fmem=5Fwrite=3Dy, so I wouldn't =
classify
it as breakage.

In theory there might be some weird/legacy apps which might break, so
that is why I suggest we land the mechanism as default off, and later,
after it gets tested in various distributions, pull the trigger to make=
 it
default on.

>=20
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  4 ++
> >  fs/proc/base.c                                | 47 +++++++++++++++=
+++-
> >  security/Kconfig                              | 22 +++++++++
> >  3 files changed, 71 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docu=
mentation/admin-guide/kernel-parameters.txt
> > index 460b97a1d0da..0647e2f54248 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5618,6 +5618,10 @@
> >  	reset=5Fdevices	[KNL] Force drivers to reset the underlying devic=
e
> >  			during initialization.
> > =20
> > +	restrict=5Fproc=5Fmem=5Fwrite=3D [KNL]
>=20
> Please add here:
>=20
> 			Format: <bool>
>=20

Ack, will do in v3.

> > +			Enable or disable write access to /proc/*/mem files.
> > +			Default is SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE=5FDEFAULT=5F=
ON.
> > +
> >  	resume=3D		[SWSUSP]
> >  			Specify the partition device for software suspend
> >  			Format:
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 98a031ac2648..92f668191312 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -152,6 +152,30 @@ struct pid=5Fentry {
> >  		NULL, &proc=5Fpid=5Fattr=5Foperations,	\
> >  		{ .lsmid =3D LSMID })
> > =20
> > +#ifdef CONFIG=5FSECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE
>=20
> Please drop this CONFIG entirely -- it should be always available for
> all builds of the kernel. Only CONFIG=5FSECURITY=5FPROC=5FMEM=5FRESTR=
ICT=5FWRITE=5FDEFAULT=5FON
> needs to remain.
>=20

Ack, will do in v3.

> > +DEFINE=5FSTATIC=5FKEY=5FMAYBE=5FRO(CONFIG=5FSECURITY=5FPROC=5FMEM=5F=
RESTRICT=5FWRITE=5FDEFAULT=5FON,
> > +			   restrict=5Fproc=5Fmem=5Fwrite);
> > +static int =5F=5Finit early=5Frestrict=5Fproc=5Fmem=5Fwrite(char *=
buf)
> > +{
> > +	int ret;
> > +	bool bool=5Fresult;
> > +
> > +	ret =3D kstrtobool(buf, &bool=5Fresult);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (bool=5Fresult)
> > +		static=5Fbranch=5Fenable(&restrict=5Fproc=5Fmem=5Fwrite);
> > +	else
> > +		static=5Fbranch=5Fdisable(&restrict=5Fproc=5Fmem=5Fwrite);
> > +	return 0;
> > +}
> > +early=5Fparam("restrict=5Fproc=5Fmem=5Fwrite", early=5Frestrict=5F=
proc=5Fmem=5Fwrite);
> > +# define PROC=5FPID=5FMEM=5FMODE S=5FIRUSR
> > +#else
> > +# define PROC=5FPID=5FMEM=5FMODE (S=5FIRUSR|S=5FIWUSR)
> > +#endif
>=20
> PROC=5FPID=5FMEM=5FMODE will need to be a =5F=5Fro=5Fafter=5Finit var=
iable, set by
> early=5Frestrict=5Fproc=5Fmem=5Fwrite, otherwise the mode won't chang=
e based on
> the runtime setting. e.g.:
>=20
> #ifdef CONFIG=5FSECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE=5FDEFAULT=5F=
ON
> mode=5Ft proc=5Fpid=5Fmem=5Fmode =5F=5Fro=5Fafter=5Finit =3D S=5FIRUS=
R;
> #else
> mode=5Ft proc=5Fpid=5Fmem=5Fmode =5F=5Fro=5Fafter=5Finit =3D (S=5FIRU=
SR|S=5FIWUSR);
> #endif
>=20
> DEFINE=5FSTATIC=5FKEY=5FMAYBE=5FRO(CONFIG=5FSECURITY=5FPROC=5FMEM=5FR=
ESTRICT=5FWRITE=5FDEFAULT=5FON,
> 			   restrict=5Fproc=5Fmem=5Fwrite);
> ...
> 	if (bool=5Fresult) {
> 		static=5Fbranch=5Fenable(&restrict=5Fproc=5Fmem=5Fwrite);
> 		proc=5Fpid=5Fmem=5Fmode =3D S=5FIRUSR;
> 	} else {
> 		static=5Fbranch=5Fdisable(&restrict=5Fproc=5Fmem=5Fwrite);
> 		proc=5Fpid=5Fmem=5Fmode =3D (S=5FIRUSR|S=5FIWUSR);
> 	}
> ...
> 	REG("mem",        proc=5Fpid=5Fmem=5Fmode, proc=5Fmem=5Foperations),
>=20
>=20

Ack, will do in v3.

> > +
> >  /*
> >   * Count the number of hardlinks for the pid=5Fentry table, exclud=
ing the .
> >   * and .. links.
> > @@ -829,6 +853,25 @@ static int mem=5Fopen(struct inode *inode, str=
uct file *file)
> >  {
> >  	int ret =3D =5F=5Fmem=5Fopen(inode, file, PTRACE=5FMODE=5FATTACH)=
;
> > =20
> > +#ifdef CONFIG=5FSECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE
>=20
> Drop this ifdef (as mentioned above).
>=20
> > +	struct mm=5Fstruct *mm =3D file->private=5Fdata;
> > +	struct task=5Fstruct *task =3D get=5Fproc=5Ftask(inode);
> > +
> > +	if (mm && task) {
> > +		/* Only allow writes by processes already ptracing the target ta=
sk */
> > +		if (file->f=5Fmode & FMODE=5FWRITE &&
> > +		    static=5Fbranch=5Fmaybe(CONFIG=5FSECURITY=5FPROC=5FMEM=5FRES=
TRICT=5FWRITE=5FDEFAULT=5FON,
> > +					&restrict=5Fproc=5Fmem=5Fwrite)) {
>=20
> Do we need to also do an mm=5Faccess() on the task to verify that the=
 task
> we're about to check has its mm still matching file->private=5Fdata? =
The
> PID can change out from under us (but the mm cannot).
>=20

Likely yes, will look into this for v3.

> > +			rcu=5Fread=5Flock();
> > +			if (!ptracer=5Fcapable(current, mm->user=5Fns) ||
> > +			    current !=3D ptrace=5Fparent(task))
>=20
> If you're just allowing "already ptracing", why include the
> ptracer=5Fcapable() check?
>=20

It is a very good observation that the check is redundant. :)

It is a remnant from a previous iteration of this patch, from
when I was proposing solutions to GDB upstream. I left it there
because it doesn't do much harm to verify capability as well,
more of a precaution / test invariant than anything else.

I'll remove it in v3 since it might cause confusion.

> > +				ret =3D -EACCES;
> > +			rcu=5Fread=5Funlock();
> > +		}
> > +		put=5Ftask=5Fstruct(task);
> > +	}
> > +#endif
> > +
> >  	/* OK to pass negative loff=5Ft, we can catch out-of-range */
> >  	file->f=5Fmode |=3D FMODE=5FUNSIGNED=5FOFFSET;
> > =20
> > @@ -3281,7 +3324,7 @@ static const struct pid=5Fentry tgid=5Fbase=5F=
stuff[] =3D {
> >  #ifdef CONFIG=5FNUMA
> >  	REG("numa=5Fmaps",  S=5FIRUGO, proc=5Fpid=5Fnuma=5Fmaps=5Foperati=
ons),
> >  #endif
> > -	REG("mem",        S=5FIRUSR|S=5FIWUSR, proc=5Fmem=5Foperations),
> > +	REG("mem",        PROC=5FPID=5FMEM=5FMODE, proc=5Fmem=5Foperation=
s),
> >  	LNK("cwd",        proc=5Fcwd=5Flink),
> >  	LNK("root",       proc=5Froot=5Flink),
> >  	LNK("exe",        proc=5Fexe=5Flink),
> > @@ -3631,7 +3674,7 @@ static const struct pid=5Fentry tid=5Fbase=5F=
stuff[] =3D {
> >  #ifdef CONFIG=5FNUMA
> >  	REG("numa=5Fmaps", S=5FIRUGO, proc=5Fpid=5Fnuma=5Fmaps=5Foperatio=
ns),
> >  #endif
> > -	REG("mem",       S=5FIRUSR|S=5FIWUSR, proc=5Fmem=5Foperations),
> > +	REG("mem",       PROC=5FPID=5FMEM=5FMODE, proc=5Fmem=5Foperations=
),
> >  	LNK("cwd",       proc=5Fcwd=5Flink),
> >  	LNK("root",      proc=5Froot=5Flink),
> >  	LNK("exe",       proc=5Fexe=5Flink),
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 412e76f1575d..ffee9e847ed9 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -19,6 +19,28 @@ config SECURITY=5FDMESG=5FRESTRICT
> > =20
> >  	  If you are unsure how to answer this question, answer N.
> > =20
> > +config SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE
> > +	bool "Restrict /proc/*/mem write access"
> > +	default n
> > +	help
> > +	  This restricts writes to /proc/<pid>/mem, except when the curre=
nt
> > +	  process ptraces the /proc/<pid>/mem task, because a ptracer alr=
eady
> > +	  has write access to the tracee memory.
> > +
> > +	  Write access to this file allows bypassing memory map permissio=
ns,
> > +	  such as modifying read-only code.
> > +
> > +	  If you are unsure how to answer this question, answer N.
> > +
> > +config SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE=5FDEFAULT=5FON
> > +	bool "Default state of /proc/*/mem write restriction"
> > +	depends on SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE
> > +	default y
> > +	help
> > +	  /proc/*/mem write access is controlled by kernel boot param
> > +	  "restrict=5Fproc=5Fmem=5Fwrite" and this config chooses the def=
ault
> > +	  boot state.
>=20
> As mentioned, I'd say merge the help texts here, but drop
> SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE.
>=20

Ack, will do in v3.

> > +
> >  config SECURITY
> >  	bool "Enable different security models"
> >  	depends on SYSFS
> > --=20
> > 2.30.2
> >=20
>=20
> Thanks for this! I look forward to turning it on. :)
>

Thank you very much for all your feedback!
It is much appreciated.

I'll wait a few more days before sending v3 to let others
comment, then address everything.
=20
> -Kees
>=20
> --=20
> Kees Cook


