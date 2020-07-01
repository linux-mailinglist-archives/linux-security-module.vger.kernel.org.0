Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7CB21061D
	for <lists+linux-security-module@lfdr.de>; Wed,  1 Jul 2020 10:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgGAI1l (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 1 Jul 2020 04:27:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51161 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbgGAI1k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Jul 2020 04:27:40 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jqY5F-0001ea-FF; Wed, 01 Jul 2020 08:27:09 +0000
Date:   Wed, 1 Jul 2020 10:27:08 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200701082708.pgfskg7hrsnfi36k@wittgenstein>
References: <20200701064906.323185-1-areber@redhat.com>
 <20200701064906.323185-2-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200701064906.323185-2-areber@redhat.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 01, 2020 at 08:49:04AM +0200, Adrian Reber wrote:
> This patch introduces CAP_CHECKPOINT_RESTORE, a new capability facilitating
> checkpoint/restore for non-root users.
> 
> Over the last years, The CRIU (Checkpoint/Restore In Userspace) team has been
> asked numerous times if it is possible to checkpoint/restore a process as
> non-root. The answer usually was: 'almost'.
> 
> The main blocker to restore a process as non-root was to control the PID of the
> restored process. This feature available via the clone3 system call, or via
> /proc/sys/kernel/ns_last_pid is unfortunately guarded by CAP_SYS_ADMIN.
> 
> In the past two years, requests for non-root checkpoint/restore have increased
> due to the following use cases:
> * Checkpoint/Restore in an HPC environment in combination with a resource
>   manager distributing jobs where users are always running as non-root.
>   There is a desire to provide a way to checkpoint and restore long running
>   jobs.
> * Container migration as non-root
> * We have been in contact with JVM developers who are integrating
>   CRIU into a Java VM to decrease the startup time. These checkpoint/restore
>   applications are not meant to be running with CAP_SYS_ADMIN.
> 
> We have seen the following workarounds:
> * Use a setuid wrapper around CRIU:
>   See https://github.com/FredHutch/slurm-examples/blob/master/checkpointer/lib/checkpointer/checkpointer-suid.c
> * Use a setuid helper that writes to ns_last_pid.
>   Unfortunately, this helper delegation technique is impossible to use with
>   clone3, and is thus prone to races.
>   See https://github.com/twosigma/set_ns_last_pid
> * Cycle through PIDs with fork() until the desired PID is reached:
>   This has been demonstrated to work with cycling rates of 100,000 PIDs/s
>   See https://github.com/twosigma/set_ns_last_pid
> * Patch out the CAP_SYS_ADMIN check from the kernel
> * Run the desired application in a new user and PID namespace to provide
>   a local CAP_SYS_ADMIN for controlling PIDs. This technique has limited use in
>   typical container environments (e.g., Kubernetes) as /proc is
>   typically protected with read-only layers (e.g., /proc/sys) for hardening
>   purposes. Read-only layers prevent additional /proc mounts (due to proc's
>   SB_I_USERNS_VISIBLE property), making the use of new PID namespaces limited as
>   certain applications need access to /proc matching their PID namespace.
> 
> The introduced capability allows to:
> * Control PIDs when the current user is CAP_CHECKPOINT_RESTORE capable
>   for the corresponding PID namespace via ns_last_pid/clone3.
> * Open files in /proc/pid/map_files when the current user is
>   CAP_CHECKPOINT_RESTORE capable in the root namespace, useful for recovering
>   files that are unreachable via the file system such as deleted files, or memfd
>   files.
> 
> See corresponding selftest for an example with clone3().
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>
> Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> ---

I think that now looks reasonable. A few comments.

Before we proceed, please split the addition of
checkpoint_restore_ns_capable() out into a separate patch.
In fact, I think the cleanest way of doing this would be:
- 0/n capability: add CAP_CHECKPOINT_RESTORE
- 1/n pid: use checkpoint_restore_ns_capable() for set_tid
- 2/n pid_namespace: use checkpoint_restore_ns_capable() for ns_last_pid
- 3/n: proc: require checkpoint_restore_ns_capable() in init userns for map_files

(commit subjects up to you of course) and a nice commit message for each
time we relax a permissions on something so we have a clear separate
track record for each change in case we need to revert something. Then
the rest of the patches in this series. Testing patches probably last.

>  fs/proc/base.c                      | 8 ++++----
>  include/linux/capability.h          | 6 ++++++
>  include/uapi/linux/capability.h     | 9 ++++++++-
>  kernel/pid.c                        | 2 +-
>  kernel/pid_namespace.c              | 2 +-
>  security/selinux/include/classmap.h | 5 +++--
>  6 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index d86c0afc8a85..ad806069c778 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2189,16 +2189,16 @@ struct map_files_info {
>  };
>  
>  /*
> - * Only allow CAP_SYS_ADMIN to follow the links, due to concerns about how the
> - * symlinks may be used to bypass permissions on ancestor directories in the
> - * path to the file in question.
> + * Only allow CAP_SYS_ADMIN and CAP_CHECKPOINT_RESTORE to follow the links, due
> + * to concerns about how the symlinks may be used to bypass permissions on
> + * ancestor directories in the path to the file in question.
>   */
>  static const char *
>  proc_map_files_get_link(struct dentry *dentry,
>  			struct inode *inode,
>  		        struct delayed_call *done)
>  {
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTORE))
>  		return ERR_PTR(-EPERM);

I think it's clearer if you just use:
checkpoint_restore_ns_capable(&init_user_ns)

> +static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)

>  
>  	return proc_pid_get_link(dentry, inode, done);
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index b4345b38a6be..1e7fe311cabe 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -261,6 +261,12 @@ static inline bool bpf_capable(void)
>  	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
>  }
>  
> +static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
> +{
> +	return ns_capable(ns, CAP_CHECKPOINT_RESTORE) ||
> +		ns_capable(ns, CAP_SYS_ADMIN);
> +}
> +
>  /* audit system wants to get cap info from files as well */
>  extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
>  
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 48ff0757ae5e..395dd0df8d08 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -408,7 +408,14 @@ struct vfs_ns_cap_data {
>   */
>  #define CAP_BPF			39
>  
> -#define CAP_LAST_CAP         CAP_BPF
> +
> +/* Allow checkpoint/restore related operations */
> +/* Allow PID selection during clone3() */
> +/* Allow writing to ns_last_pid */
> +
> +#define CAP_CHECKPOINT_RESTORE	40
> +
> +#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
>  
>  #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
>  
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 5799ae54b89e..2d0a97b7ed7a 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -198,7 +198,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  			if (tid != 1 && !tmp->child_reaper)
>  				goto out_free;
>  			retval = -EPERM;
> -			if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
> +			if (!checkpoint_restore_ns_capable(tmp->user_ns))
>  				goto out_free;
>  			set_tid_size--;
>  		}
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 0e5ac162c3a8..ac135bd600eb 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -269,7 +269,7 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
>  	struct ctl_table tmp = *table;
>  	int ret, next;
>  
> -	if (write && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
> +	if (write && !checkpoint_restore_ns_capable(pid_ns->user_ns))
>  		return -EPERM;
>  
>  	/*
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 98e1513b608a..40cebde62856 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -27,9 +27,10 @@
>  	    "audit_control", "setfcap"
>  
>  #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
> -		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf"
> +		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
> +		"checkpoint_restore"
>  
> -#if CAP_LAST_CAP > CAP_BPF
> +#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
>  #error New capability defined, please update COMMON_CAP2_PERMS.
>  #endif
>  
> -- 
> 2.26.2
> 
