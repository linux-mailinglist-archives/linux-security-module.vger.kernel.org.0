Return-Path: <linux-security-module+bounces-6282-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F39A6B01
	for <lists+linux-security-module@lfdr.de>; Mon, 21 Oct 2024 15:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351631F22ABB
	for <lists+linux-security-module@lfdr.de>; Mon, 21 Oct 2024 13:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64C2192D69;
	Mon, 21 Oct 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tIvPlLuX"
X-Original-To: linux-security-module@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737B11F709B
	for <linux-security-module@vger.kernel.org>; Mon, 21 Oct 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518652; cv=none; b=U4E+oSubyEknNSUD/AwXDZLfJpgYwhCLWn201sZASiVllPk5l6BvhSz0ir4LbUlBdLE8cB93KGzs9pGuOi47b8DdqPs6bgh4t9gvSG9PlcjUS9ZXksx0Xfk0fxappXz4cQoc5EiMwvinGzCte4iN5ZrUP7ACp+LLBKDcT5B5E+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518652; c=relaxed/simple;
	bh=Mpxf8WD4BOyC9Mv69AMwaEVsCepV4a/KTq+Joni5Z+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpLo7ZiT6FDh2rMjg3ETR1XtXyR8AL/3YEydxBhElfkEOUoJ04Kpv16S9AEmbOWZaIPQINAfvnlATjjc/U47yruuRmPre6AJM5X4+J42heyXCLjbOPDEQqlH2BiRPHc+dWwW7OrUi5KyqhQonzIQjEUYPOV2MXotPPXqWnVnuMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tIvPlLuX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 885D1210B2FE;
	Mon, 21 Oct 2024 06:50:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 885D1210B2FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729518649;
	bh=KCgMY+TBKsc42jkzry4a4kY4BW52qXF1amap6EkrAx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tIvPlLuX0Hsp1fCrD4eRcMINc/MlG7fwdBrl9xqHdxDVayEG5Q7J/DRXjajs9qclo
	 Yv9Iw+t+I0ZfRA0YFMkhnsZd9hH3p9Bx6GD5TpUHjQrhZBu045zuLipx6LUScQY/y7
	 2B7dStNyGRxj4hsYPE9yvkVkpbvljNQPiFpGIZ9M=
Message-ID: <57019d41-75a2-4ad6-8ee1-29d20b1e4a85@linux.microsoft.com>
Date: Mon, 21 Oct 2024 09:50:48 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Landlock: fix grammar issues in docs
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: gnoack@google.com, linux-security-module@vger.kernel.org
References: <20241015172647.2007644-1-dburgener@linux.microsoft.com>
 <20241021.eephi5Taiqu4@digikod.net>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20241021.eephi5Taiqu4@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/2024 3:43 AM, Mickaël Salaün wrote:
> Thanks Daniel!  Your changes not only fix grammar issues but also
> improve the doc overall.  I only have one comment:
> 
> 
> On Tue, Oct 15, 2024 at 01:26:46PM -0400, Daniel Burgener wrote:
>> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
>> ---
>>   Documentation/security/landlock.rst      | 14 ++---
>>   Documentation/userspace-api/landlock.rst | 67 ++++++++++++------------
>>   2 files changed, 40 insertions(+), 41 deletions(-)
>>
>> diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
>> index 36f26501fd15..59ecdb1c0d4d 100644
>> --- a/Documentation/security/landlock.rst
>> +++ b/Documentation/security/landlock.rst
>> @@ -11,18 +11,18 @@ Landlock LSM: kernel documentation
>>   
>>   Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
>>   harden a whole system, this feature should be available to any process,
>> -including unprivileged ones.  Because such process may be compromised or
>> +including unprivileged ones.  Because such a process may be compromised or
>>   backdoored (i.e. untrusted), Landlock's features must be safe to use from the
>>   kernel and other processes point of view.  Landlock's interface must therefore
>>   expose a minimal attack surface.
>>   
>>   Landlock is designed to be usable by unprivileged processes while following the
>>   system security policy enforced by other access control mechanisms (e.g. DAC,
>> -LSM).  Indeed, a Landlock rule shall not interfere with other access-controls
>> -enforced on the system, only add more restrictions.
>> +LSM).  A Landlock rule shall not interfere with other access-controls enforced
>> +on the system, only add more restrictions.
>>   
>>   Any user can enforce Landlock rulesets on their processes.  They are merged and
>> -evaluated according to the inherited ones in a way that ensures that only more
>> +evaluated against inherited rulesets in a way that ensures that only more
>>   constraints can be added.
>>   
>>   User space documentation can be found here:
>> @@ -43,7 +43,7 @@ Guiding principles for safe access controls
>>     only impact the processes requesting them.
>>   * Resources (e.g. file descriptors) directly obtained from the kernel by a
>>     sandboxed process shall retain their scoped accesses (at the time of resource
>> -  acquisition) whatever process use them.
>> +  acquisition) whatever process uses them.
>>     Cf. `File descriptor access rights`_.
>>   
>>   Design choices
>> @@ -71,7 +71,7 @@ the same results, when they are executed under the same Landlock domain.
>>   Taking the ``LANDLOCK_ACCESS_FS_TRUNCATE`` right as an example, it may be
>>   allowed to open a file for writing without being allowed to
>>   :manpage:`ftruncate` the resulting file descriptor if the related file
>> -hierarchy doesn't grant such access right.  The following sequences of
>> +hierarchy doesn't grant that access right.  The following sequences of
>>   operations have the same semantic and should then have the same result:
>>   
>>   * ``truncate(path);``
>> @@ -81,7 +81,7 @@ Similarly to file access modes (e.g. ``O_RDWR``), Landlock access rights
>>   attached to file descriptors are retained even if they are passed between
>>   processes (e.g. through a Unix domain socket).  Such access rights will then be
>>   enforced even if the receiving process is not sandboxed by Landlock.  Indeed,
>> -this is required to keep a consistent access control over the whole system, and
>> +this is required to keep access controls consistent over the whole system, and
>>   this avoids unattended bypasses through file descriptor passing (i.e. confused
>>   deputy attack).
>>   
>> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
>> index bb7480a05e2c..17fa2148c7c4 100644
>> --- a/Documentation/userspace-api/landlock.rst
>> +++ b/Documentation/userspace-api/landlock.rst
>> @@ -10,11 +10,11 @@ Landlock: unprivileged access control
>>   :Author: Mickaël Salaün
>>   :Date: October 2024
>>   
>> -The goal of Landlock is to enable to restrict ambient rights (e.g. global
>> +The goal of Landlock is to enable restriction of ambient rights (e.g. global
>>   filesystem or network access) for a set of processes.  Because Landlock
>> -is a stackable LSM, it makes possible to create safe security sandboxes as new
>> -security layers in addition to the existing system-wide access-controls. This
>> -kind of sandbox is expected to help mitigate the security impact of bugs or
>> +is a stackable LSM, it makes it possible to create safe security sandboxes as
>> +new security layers in addition to the existing system-wide access-controls.
>> +This kind of sandbox is expected to help mitigate the security impact of bugs or
>>   unexpected/malicious behaviors in user space applications.  Landlock empowers
>>   any process, including unprivileged ones, to securely restrict themselves.
>>   
>> @@ -86,8 +86,8 @@ to be explicit about the denied-by-default access rights.
>>               LANDLOCK_SCOPE_SIGNAL,
>>       };
>>   
>> -Because we may not know on which kernel version an application will be
>> -executed, it is safer to follow a best-effort security approach.  Indeed, we
>> +Because we may not know which kernel version an application will be executed
>> +on, it is safer to follow a best-effort security approach.  Indeed, we
>>   should try to protect users as much as possible whatever the kernel they are
>>   using.
>>   
>> @@ -129,7 +129,7 @@ version, and only use the available subset of access rights:
>>                                    LANDLOCK_SCOPE_SIGNAL);
>>       }
>>   
>> -This enables to create an inclusive ruleset that will contain our rules.
>> +This enables the creation of an inclusive ruleset that will contain our rules.
>>   
>>   .. code-block:: c
>>   
>> @@ -219,42 +219,41 @@ If the ``landlock_restrict_self`` system call succeeds, the current thread is
>>   now restricted and this policy will be enforced on all its subsequently created
>>   children as well.  Once a thread is landlocked, there is no way to remove its
>>   security policy; only adding more restrictions is allowed.  These threads are
>> -now in a new Landlock domain, merge of their parent one (if any) with the new
>> -ruleset.
>> +now in a new Landlock domain, which is a merger of their parent one (if any)
>> +with the new ruleset.
>>   
>>   Full working code can be found in `samples/landlock/sandboxer.c`_.
>>   
>>   Good practices
>>   --------------
>>   
>> -It is recommended setting access rights to file hierarchy leaves as much as
>> +It is recommended to set access rights to file hierarchy leaves as much as
>>   possible.  For instance, it is better to be able to have ``~/doc/`` as a
>>   read-only hierarchy and ``~/tmp/`` as a read-write hierarchy, compared to
>>   ``~/`` as a read-only hierarchy and ``~/tmp/`` as a read-write hierarchy.
>>   Following this good practice leads to self-sufficient hierarchies that do not
>>   depend on their location (i.e. parent directories).  This is particularly
>>   relevant when we want to allow linking or renaming.  Indeed, having consistent
>> -access rights per directory enables to change the location of such directory
>> +access rights per directory enables changing the location of such directories
>>   without relying on the destination directory access rights (except those that
>>   are required for this operation, see ``LANDLOCK_ACCESS_FS_REFER``
>>   documentation).
>>   
>>   Having self-sufficient hierarchies also helps to tighten the required access
>>   rights to the minimal set of data.  This also helps avoid sinkhole directories,
>> -i.e.  directories where data can be linked to but not linked from.  However,
>> +i.e. directories where data can be linked to but not linked from.  However,
>>   this depends on data organization, which might not be controlled by developers.
>>   In this case, granting read-write access to ``~/tmp/``, instead of write-only
>> -access, would potentially allow to move ``~/tmp/`` to a non-readable directory
>> +access, would potentially allow moving ``~/tmp/`` to a non-readable directory
>>   and still keep the ability to list the content of ``~/tmp/``.
>>   
>>   Layers of file path access rights
>>   ---------------------------------
>>   
>>   Each time a thread enforces a ruleset on itself, it updates its Landlock domain
>> -with a new layer of policy.  Indeed, this complementary policy is stacked with
>> -the potentially other rulesets already restricting this thread.  A sandboxed
>> -thread can then safely add more constraints to itself with a new enforced
>> -ruleset.
>> +with a new layer of policy.  This complementary policy is stacked with any
>> +other rulesets potentially already restricting this thread.  A sandboxed thread
>> +can then safely add more constraints to itself with a new enforced ruleset.
>>   
>>   One policy layer grants access to a file path if at least one of its rules
>>   encountered on the path grants the access.  A sandboxed thread can only access
>> @@ -265,7 +264,7 @@ etc.).
>>   Bind mounts and OverlayFS
>>   -------------------------
>>   
>> -Landlock enables to restrict access to file hierarchies, which means that these
>> +Landlock enables restricting access to file hierarchies, which means that these
>>   access rights can be propagated with bind mounts (cf.
>>   Documentation/filesystems/sharedsubtree.rst) but not with
>>   Documentation/filesystems/overlayfs.rst.
>> @@ -278,21 +277,21 @@ access to multiple file hierarchies at the same time, whether these hierarchies
>>   are the result of bind mounts or not.
>>   
>>   An OverlayFS mount point consists of upper and lower layers.  These layers are
>> -combined in a merge directory, result of the mount point.  This merge hierarchy
>> -may include files from the upper and lower layers, but modifications performed
>> -on the merge hierarchy only reflects on the upper layer.  From a Landlock
>> -policy point of view, each OverlayFS layers and merge hierarchies are
>> -standalone and contains their own set of files and directories, which is
>> -different from bind mounts.  A policy restricting an OverlayFS layer will not
>> -restrict the resulted merged hierarchy, and vice versa.  Landlock users should
>> -then only think about file hierarchies they want to allow access to, regardless
>> -of the underlying filesystem.
>> +combined in a merge directory, and that merged directory becomes available at
>> +the mount point.  This merge hierarchy may include files from the upper and
>> +lower layers, but modifications performed on the merge hierarchy only reflect
>> +on the upper layer.  From a Landlock policy point of view, all OverlayFS layers
>> +and merge hierarchies are standalone and each contains their own set of files
>> +and directories, which is different from bind mounts.  A policy restricting an
>> +OverlayFS layer will not restrict the resulted merged hierarchy, and vice versa.
>> +Landlock users should then only think about file hierarchies they want to allow
>> +access to, regardless of the underlying filesystem.
>>   
>>   Inheritance
>>   -----------
>>   
>>   Every new thread resulting from a :manpage:`clone(2)` inherits Landlock domain
>> -restrictions from its parent.  This is similar to the seccomp inheritance (cf.
>> +restrictions from its parent.  This is similar to seccomp inheritance (cf.
>>   Documentation/userspace-api/seccomp_filter.rst) or any other LSM dealing with
>>   task's :manpage:`credentials(7)`.  For instance, one process's thread may apply
>>   Landlock rules to itself, but they will not be automatically applied to other
>> @@ -311,7 +310,7 @@ Ptrace restrictions
>>   A sandboxed process has less privileges than a non-sandboxed process and must
>>   then be subject to additional restrictions when manipulating another process.
>>   To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
>> -process, a sandboxed process should have a subset of the target process rules,
>> +process, a sandboxed process should have a superset of the target process rules,
> 
> With "a subset of the target process rules" I meant a subset of the
> restrictions, and in the kernel implementation it's really about less
> (stacks of) rules because a nested sandboxe inherit from it's parent
> rules.  But there are two ways to interpret it, which is confusing and
> not good for a doc.  What about this fix instead:
> 
> process, a sandboxed process should have a subset of the target process's restrictions,
> 
> 

Thanks for the clarification.  I still find the suggested change 
confusing though.  In general, Landlock has a deny-by-default, 
allow-by-exception policy, so talking about subsets of "restrictions" 
feels weird to me, unless I'm misunderstanding you.  I think that what 
this paragraph is trying to say is that process foo has a landlock 
sandbox that lets them access X, Y and Z, and process bar has a landlock 
sandbox that only lets them access X and Y, therefore foo can ptrace 
bar, because there is no new privilege for foo if it manipulates bar to 
be its delegate.  Is that accurate?  What about:

process, a sandboxed process should have a superset of the target 
process's access rights.

Talking about positive access rights seems more natural to me than 
talking about negative restrictions, since the access rights are what is 
granted by landlock rules.

-Daniel

>>   which means the tracee must be in a sub-domain of the tracer.
>>   
>>   IPC scoping
>> @@ -322,7 +321,7 @@ interactions between sandboxes. Each Landlock domain can be explicitly scoped
>>   for a set of actions by specifying it on a ruleset.  For example, if a
>>   sandboxed process should not be able to :manpage:`connect(2)` to a
>>   non-sandboxed process through abstract :manpage:`unix(7)` sockets, we can
>> -specify such restriction with ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``.
>> +specify such a restriction with ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``.
>>   Moreover, if a sandboxed process should not be able to send a signal to a
>>   non-sandboxed process, we can specify this restriction with
>>   ``LANDLOCK_SCOPE_SIGNAL``.
>> @@ -394,7 +393,7 @@ Backward and forward compatibility
>>   Landlock is designed to be compatible with past and future versions of the
>>   kernel.  This is achieved thanks to the system call attributes and the
>>   associated bitflags, particularly the ruleset's ``handled_access_fs``.  Making
>> -handled access right explicit enables the kernel and user space to have a clear
>> +handled access rights explicit enables the kernel and user space to have a clear
>>   contract with each other.  This is required to make sure sandboxing will not
>>   get stricter with a system update, which could break applications.
>>   
>> @@ -606,9 +605,9 @@ Build time configuration
>>   
>>   Landlock was first introduced in Linux 5.13 but it must be configured at build
>>   time with ``CONFIG_SECURITY_LANDLOCK=y``.  Landlock must also be enabled at boot
>> -time as the other security modules.  The list of security modules enabled by
>> +time like other security modules.  The list of security modules enabled by
>>   default is set with ``CONFIG_LSM``.  The kernel configuration should then
>> -contains ``CONFIG_LSM=landlock,[...]`` with ``[...]``  as the list of other
>> +contain ``CONFIG_LSM=landlock,[...]`` with ``[...]``  as the list of other
>>   potentially useful security modules for the running system (see the
>>   ``CONFIG_LSM`` help).
>>   
>> @@ -670,7 +669,7 @@ Questions and answers
>>   What about user space sandbox managers?
>>   ---------------------------------------
>>   
>> -Using user space process to enforce restrictions on kernel resources can lead
>> +Using user space processes to enforce restrictions on kernel resources can lead
>>   to race conditions or inconsistent evaluations (i.e. `Incorrect mirroring of
>>   the OS code and state
>>   <https://www.ndss-symposium.org/ndss2003/traps-and-pitfalls-practical-problems-system-call-interposition-based-security-tools/>`_).
>> -- 
>> 2.41.0
>>


