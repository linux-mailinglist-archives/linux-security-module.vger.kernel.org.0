Return-Path: <linux-security-module+bounces-1036-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783BD832C60
	for <lists+linux-security-module@lfdr.de>; Fri, 19 Jan 2024 16:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E0281DD5
	for <lists+linux-security-module@lfdr.de>; Fri, 19 Jan 2024 15:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBD554746;
	Fri, 19 Jan 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8W0P6L6"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B351C4B;
	Fri, 19 Jan 2024 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705678280; cv=none; b=NCv8IiamrwnowlUxhR0FHj3bFO3ohptllYBdEENsubklUwiwdxtwUYJm1+lS0aXCHmG0oK3k3qkJB94rjKvURsnYB4a8k53/hNYFhv8CSfBNfJjkjKu0MaQyL3YCIt4qlEubRqP4PIEX4YwDc3D5BAObXaHq5LmEa2mqSsetj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705678280; c=relaxed/simple;
	bh=GHjwp/uocCWsVobLDZmafyb7pyg6uOUj7MEnEcbl35E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQcNc/t5P1vCeQaQ+w8OC2EUSpFLpS/RaIERSoDQFQoExZ9Sbk+SAqYh97QkygINOljcgRwuPzTqlqbRn0F8iHXM8Wjo2d3qZJWETtpoS5C5871hnXzGB5/+m8eb6CuNyt81I+ON+o8Y5pyRqcj090BgZfxcQhulnLEL2ZhaRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8W0P6L6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so726354a12.1;
        Fri, 19 Jan 2024 07:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705678278; x=1706283078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZsBeSeTySBj1BNxF3i9blNC2Wf+RZB9bqER12tGM9g=;
        b=e8W0P6L68sj5UTBbHrAKzR3hbmBtv5cVjWuhixD4ugeTtwlvp2HOMpWUVjqH581wqx
         W3qjaQvBty7AbSOwFQZrOq8a15cOvTaZ6AEtkiSfy5Saa8r52pI2qXqaUd+bcTDTgHc7
         H6hAFNLy+KBCHstjuFk323FQSGb52/jmua64ZPCPafPxVXQc5O+xw0m69D+CKAray5Jf
         lMFwYCeWr8sRpjQxFtfs8YlkPrtMTSjWHcGNopDn0rqeqQ3iefOia/boPSBGAYBf4j6D
         MLBaqWlCO1k1OOjFn7NQz1PEFrnrHUDHTPwAeiA0gPmqk+Fw2T8lzpYPzP2uGRhViuts
         Pptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705678278; x=1706283078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZsBeSeTySBj1BNxF3i9blNC2Wf+RZB9bqER12tGM9g=;
        b=S5aAK4DCbxPORnEBcVFfZwqzCXgKC559rBTrYtPq37YQMdgtL/NrAGl3P9w6VgS+k6
         aLBZ+meyUuBfX8rCoVp6I+GIqWFiM3VUcDa6FBTPnPz1mi4YFQxy9Vj7j7hM42kHLil0
         FeFajDE0UHsuOz+RGX2HuVHJO70ipwZnmEgQreSba/0QkA9GFHc/V5WXXgdCxP0+v58n
         gtQfRg7OgvGSm8W8zYTscmgZrfK5VbG6x+o3xPOvfTn5bPbYupE0jIC8/eGyx2i25/AK
         hlZWw/KQZnesk0g/0geHGPsNVk5V+M+MYF3wGVw+TszP+QM26cXL8OCOrt98i4Y1PmwN
         Qflw==
X-Gm-Message-State: AOJu0YwG/GI58Q3jJyAwerq1O5fmjwG3V1AyJSJYGfFt63zPd/azYKaD
	XN05UtJebvm2xBA7BFW5FERArsEPdDSXwFxNfWoTsEHjRNlaR2aEN4YVCwGplrLch1Oocqu4wp9
	p+t+7BRj0SHA/2Nota2JIc3XwoQE=
X-Google-Smtp-Source: AGHT+IG96d74A682TLxeQ1zioID7dMjfP01SgHa4knoQ71VhMM3Yjo2CG4ygePpxxCLRPuV8lRY8AW1a+9CSwSI5f0c=
X-Received: by 2002:a17:90a:a884:b0:28e:81a3:43d5 with SMTP id
 h4-20020a17090aa88400b0028e81a343d5mr49949pjq.27.1705678278143; Fri, 19 Jan
 2024 07:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119050000.3362312-1-andrii@kernel.org>
In-Reply-To: <20240119050000.3362312-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jan 2024 07:31:06 -0800
Message-ID: <CAEf4BzZx55q2hSSs96jO9BRi-GOuh0n3-fk-DC3oKgcWhut3kw@mail.gmail.com>
Subject: Re: [GIT PULL] BPF token for v6.8
To: Andrii Nakryiko <andrii@kernel.org>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 9:00=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Hi Linus,
>
> This is BPF token patches freshly rebased onto latest bpf/master with fee=
dback
> received on last revision addressed and changes applied to appropriate pa=
tches.
> Plus a few more selftests are added around LSM and BPF token interactions=
.
>
> This time I'm sending them as a dedicated PR. Please let me know if you a=
re OK
> pull them directly now, or whether I should target it for the next merge
> window. If the latter is decided, would it be OK to land these patches in=
to
> bpf-next tree and then include them in a usual bpf-next PR batch? Keeping
> these patches conflict-free for entire next dev cycle might be challengin=
g,
> given somewhat wide kernel and libbpf changes. Thanks!

And that already happened, unfortunately. There was an interplay
between libbpf refactoring in these patches and latest bpf/master
changes, which used parts of internal libbpf "infrastructure" code. We
must have some Makefile integration bug somewhere, as I did build
kernel and selftests after rebasing on latest bpf/master, but it
didn't catch the issue. Either way, my bad, I'll be doing `make clean`
before submitting future PRs, sorry about this.

Long story short, I fixed up build breakages in corresponding patches
in this series that do refactor relevant pieces. I force pushed
for-linus tag and bpf-token branch, and so hashes changed a bit and
now the following part of PR would look like this:

The following changes since commit 736b5545d39ca59d4332a60e56cc8a1a5e264a8e=
:

  Merge tag 'net-6.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-01-18
17:33:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-linu=
s

for you to fetch changes up to cf5e8dc4a8e902c29a493350e2f4b2ff0c8028fb:

  selftests/bpf: incorporate LSM policy to token-based tests
(2024-01-19 07:16:49 -0800)


Please let me know if I should just go for bpf-next and next dev
cycle, or should resend PR, or if you can pull from force-updated Git
branch as is. Sorry again for the churn!

>
> The following changes since commit 736b5545d39ca59d4332a60e56cc8a1a5e264a=
8e:
>
>   Merge tag 'net-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/netdev/net (2024-01-18 17:33:50 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-li=
nus
>
> for you to fetch changes up to df4ffe6e674b8421230276238a0107966b85e044:
>
>   selftests/bpf: incorporate LSM policy to token-based tests (2024-01-18 =
20:39:48 -0800)
>
> ----------------------------------------------------------------
> BPF token
>
> This PR is a combination of three BPF token-related patch sets ([0],
> [1], [2]) with fixes ([3]) to kernel-side token_fd passing APIs incorpora=
ted
> into relevant patches, bpf_token_capable() changes requested by
> Christian Brauner, and necessary libbpf and BPF selftests side adjustment=
s.
>
> This patch set introduces an ability to delegate a subset of BPF subsyste=
m
> functionality from privileged system-wide daemon (e.g., systemd or any ot=
her
> container manager) through special mount options for userns-bound BPF FS =
to
> a *trusted* unprivileged application. Trust is the key here. This
> functionality is not about allowing unconditional unprivileged BPF usage.
> Establishing trust, though, is completely up to the discretion of respect=
ive
> privileged application that would create and mount a BPF FS instance with
> delegation enabled, as different production setups can and do achieve it
> through a combination of different means (signing, LSM, code reviews, etc=
),
> and it's undesirable and infeasible for kernel to enforce any particular =
way
> of validating trustworthiness of particular process.
>
> The main motivation for this work is a desire to enable containerized BPF
> applications to be used together with user namespaces. This is currently
> impossible, as CAP_BPF, required for BPF subsystem usage, cannot be names=
paced
> or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BP=
F
> helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely=
 read
> arbitrary memory, and it's impossible to ensure that they only read memor=
y of
> processes belonging to any given namespace. This means that it's impossib=
le to
> have a mechanically verifiable namespace-aware CAP_BPF capability, and as=
 such
> another mechanism to allow safe usage of BPF functionality is necessary.
>
> BPF FS delegation mount options and BPF token derived from such BPF FS in=
stance
> is such a mechanism. Kernel makes no assumption about what "trusted"
> constitutes in any particular case, and it's up to specific privileged
> applications and their surrounding infrastructure to decide that. What ke=
rnel
> provides is a set of APIs to setup and mount special BPF FS instance and
> derive BPF tokens from it. BPF FS and BPF token are both bound to its own=
ing
> userns and in such a way are constrained inside intended container. Users=
 can
> then pass BPF token FD to privileged bpf() syscall commands, like BPF map
> creation and BPF program loading, to perform such operations without havi=
ng
> init userns privileges.
>
> This version incorporates feedback and suggestions ([4]) received on earl=
ier
> iterations of BPF token approach, and instead of allowing to create BPF t=
okens
> directly assuming capable(CAP_SYS_ADMIN), we instead enhance BPF FS to ac=
cept
> a few new delegation mount options. If these options are used and BPF FS =
itself
> is properly created, set up, and mounted inside the user namespaced conta=
iner,
> user application is able to derive a BPF token object from BPF FS instanc=
e, and
> pass that token to bpf() syscall. As explained in patch #3, BPF token its=
elf
> doesn't grant access to BPF functionality, but instead allows kernel to d=
o
> namespaced capabilities checks (ns_capable() vs capable()) for CAP_BPF,
> CAP_PERFMON, CAP_NET_ADMIN, and CAP_SYS_ADMIN, as applicable. So it forms=
 one
> half of a puzzle and allows container managers and sys admins to have saf=
e and
> flexible configuration options: determining which containers get delegati=
on of
> BPF functionality through BPF FS, and then which applications within such
> containers are allowed to perform bpf() commands, based on namespaces
> capabilities.
>
> Previous attempt at addressing this very same problem ([5]) attempted to
> utilize authoritative LSM approach, but was conclusively rejected by upst=
ream
> LSM maintainers. BPF token concept is not changing anything about LSM
> approach, but can be combined with LSM hooks for very fine-grained securi=
ty
> policy. Some ideas about making BPF token more convenient to use with LSM=
 (in
> particular custom BPF LSM programs) was briefly described in recent LSF/M=
M/BPF
> 2023 presentation ([6]). E.g., an ability to specify user-provided data
> (context), which in combination with BPF LSM would allow implementing a v=
ery
> dynamic and fine-granular custom security policies on top of BPF token. I=
n the
> interest of minimizing API surface area and discussions this was relegate=
d to
> follow up patches, as it's not essential to the fundamental concept of
> delegatable BPF token.
>
> It should be noted that BPF token is conceptually quite similar to the id=
ea of
> /dev/bpf device file, proposed by Song a while ago ([7]). The biggest
> difference is the idea of using virtual anon_inode file to hold BPF token=
 and
> allowing multiple independent instances of them, each (potentially) with =
its
> own set of restrictions. And also, crucially, BPF token approach is not u=
sing
> any special stateful task-scoped flags. Instead, bpf() syscall accepts
> token_fd parameters explicitly for each relevant BPF command. This addres=
ses
> main concerns brought up during the /dev/bpf discussion, and fits better =
with
> overall BPF subsystem design.
>
> Second part of this patch set adds full support for BPF token in libbpf's=
 BPF
> object high-level API. Good chunk of the changes rework libbpf feature
> detection internals, which are the most affected by BPF token presence.
>
> Besides internal refactorings, libbpf allows to pass location of BPF FS f=
rom
> which BPF token should be created by libbpf. This can be done explicitly =
though
> a new bpf_object_open_opts.bpf_token_path field. But we also add implicit=
 BPF
> token creation logic to BPF object load step, even without any explicit
> involvement of the user. If the environment is setup properly, BPF token =
will
> be created transparently and used implicitly. This allows for all existin=
g
> application to gain BPF token support by just linking with latest version=
 of
> libbpf library. No source code modifications are required.  All that unde=
r
> assumption that privileged container management agent properly set up def=
ault
> BPF FS instance at /sys/bpf/fs to allow BPF token creation.
>
> libbpf adds support to override default BPF FS location for BPF token cre=
ation
> through LIBBPF_BPF_TOKEN_PATH envvar knowledge. This allows admins or con=
tainer
> managers to mount BPF token-enabled BPF FS at non-standard location witho=
ut the
> need to coordinate with applications.  LIBBPF_BPF_TOKEN_PATH can also be =
used
> to disable BPF token implicit creation by setting it to an empty value.
>
>   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D80570=
7&state=3D*
>   [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D81026=
0&state=3D*
>   [2] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D80980=
0&state=3D*
>   [3] https://patchwork.kernel.org/project/netdevbpf/patch/20231219053150=
.336991-1-andrii@kernel.org/
>   [4] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785=
e@brauner/
>   [5] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.o=
rg/
>   [6] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BP=
F_LSFMM2023.pdf
>   [7] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving=
@fb.com/
>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> ----------------------------------------------------------------
> Andrii Nakryiko (30):
>       bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
>       bpf: add BPF token delegation mount options to BPF FS
>       bpf: introduce BPF token object
>       bpf: add BPF token support to BPF_MAP_CREATE command
>       bpf: add BPF token support to BPF_BTF_LOAD command
>       bpf: add BPF token support to BPF_PROG_LOAD command
>       bpf: take into account BPF token when fetching helper protos
>       bpf: consistently use BPF token throughout BPF verifier logic
>       bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM hooks
>       bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM hooks
>       bpf,lsm: add BPF token LSM hooks
>       libbpf: add bpf_token_create() API
>       libbpf: add BPF token support to bpf_map_create() API
>       libbpf: add BPF token support to bpf_btf_load() API
>       libbpf: add BPF token support to bpf_prog_load() API
>       selftests/bpf: add BPF token-enabled tests
>       bpf,selinux: allocate bpf_security_struct per BPF token
>       bpf: fail BPF_TOKEN_CREATE if no delegation option was set on BPF F=
S
>       bpf: support symbolic BPF FS delegation mount options
>       selftests/bpf: utilize string values for delegate_xxx mount options
>       libbpf: split feature detectors definitions from cached results
>       libbpf: further decouple feature checking logic from bpf_object
>       libbpf: move feature detection code into its own file
>       libbpf: wire up token_fd into feature probing logic
>       libbpf: wire up BPF token support at BPF object level
>       selftests/bpf: add BPF object loading tests with explicit token pas=
sing
>       selftests/bpf: add tests for BPF object load with implicit token
>       libbpf: support BPF token path setting through LIBBPF_BPF_TOKEN_PAT=
H envvar
>       selftests/bpf: add tests for LIBBPF_BPF_TOKEN_PATH envvar
>       selftests/bpf: incorporate LSM policy to token-based tests
>
>  drivers/media/rc/bpf-lirc.c                        |    2 +-
>  include/linux/bpf.h                                |   85 +-
>  include/linux/filter.h                             |    2 +-
>  include/linux/lsm_hook_defs.h                      |   15 +-
>  include/linux/security.h                           |   43 +-
>  include/uapi/linux/bpf.h                           |   54 +
>  kernel/bpf/Makefile                                |    2 +-
>  kernel/bpf/arraymap.c                              |    2 +-
>  kernel/bpf/bpf_lsm.c                               |   15 +-
>  kernel/bpf/cgroup.c                                |    6 +-
>  kernel/bpf/core.c                                  |    3 +-
>  kernel/bpf/helpers.c                               |    6 +-
>  kernel/bpf/inode.c                                 |  276 ++++-
>  kernel/bpf/syscall.c                               |  228 +++--
>  kernel/bpf/token.c                                 |  278 ++++++
>  kernel/bpf/verifier.c                              |   13 +-
>  kernel/trace/bpf_trace.c                           |    2 +-
>  net/core/filter.c                                  |   36 +-
>  net/ipv4/bpf_tcp_ca.c                              |    2 +-
>  net/netfilter/nf_bpf_link.c                        |    2 +-
>  security/security.c                                |  101 +-
>  security/selinux/hooks.c                           |   47 +-
>  tools/include/uapi/linux/bpf.h                     |   54 +
>  tools/lib/bpf/Build                                |    2 +-
>  tools/lib/bpf/bpf.c                                |   41 +-
>  tools/lib/bpf/bpf.h                                |   37 +-
>  tools/lib/bpf/btf.c                                |   10 +-
>  tools/lib/bpf/elf.c                                |    2 -
>  tools/lib/bpf/features.c                           |  503 ++++++++++
>  tools/lib/bpf/libbpf.c                             |  557 ++---------
>  tools/lib/bpf/libbpf.h                             |   21 +-
>  tools/lib/bpf/libbpf.map                           |    1 +
>  tools/lib/bpf/libbpf_internal.h                    |   36 +-
>  tools/lib/bpf/libbpf_probes.c                      |   11 +-
>  tools/lib/bpf/str_error.h                          |    3 +
>  .../selftests/bpf/prog_tests/libbpf_probes.c       |    4 +
>  .../testing/selftests/bpf/prog_tests/libbpf_str.c  |    6 +
>  tools/testing/selftests/bpf/prog_tests/token.c     | 1052 ++++++++++++++=
++++++
>  tools/testing/selftests/bpf/progs/priv_map.c       |   13 +
>  tools/testing/selftests/bpf/progs/priv_prog.c      |   13 +
>  tools/testing/selftests/bpf/progs/token_lsm.c      |   32 +
>  41 files changed, 2977 insertions(+), 641 deletions(-)
>  create mode 100644 kernel/bpf/token.c
>  create mode 100644 tools/lib/bpf/features.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
>  create mode 100644 tools/testing/selftests/bpf/progs/priv_map.c
>  create mode 100644 tools/testing/selftests/bpf/progs/priv_prog.c
>  create mode 100644 tools/testing/selftests/bpf/progs/token_lsm.c
>

