Return-Path: <linux-security-module+bounces-517-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C2980F686
	for <lists+linux-security-module@lfdr.de>; Tue, 12 Dec 2023 20:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94221C20BD5
	for <lists+linux-security-module@lfdr.de>; Tue, 12 Dec 2023 19:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85F381E3D;
	Tue, 12 Dec 2023 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5ytUkjB"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D4781E3B
	for <linux-security-module@vger.kernel.org>; Tue, 12 Dec 2023 19:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF2DC43391
	for <linux-security-module@vger.kernel.org>; Tue, 12 Dec 2023 19:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702408941;
	bh=GWSziTK7PkiFilfV05Scv9fS3VasGlENydizrC12iJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f5ytUkjBaFSM81xZ3oETxIxEgu7fIpCOKc3PADXV3INiEEzNpWnXaB7MYtpC/Gi3I
	 1wNbXtyKlblZFd1dBmP6o0EQcss3bFRxmpEnaGAKhbMDDUHJCImEfwzfignStiIObi
	 +8zJhhJDSHJvPCKVNQmBAEkEeWK0JsEzQkIZOElMpTxSGx6JblIQ5/3Fw5vf9Ko2ZH
	 2Sip2+jN+n0rK34lK8beTRQnUafNbbkA2P/QoRD+l1u6u4lcRzVSInH09Gj7eAfQd4
	 YYTq3MuPvcYZWUSok8Uv4hccJ5ZBX2BGurEo6Awz7DwZwGQlydgCKas/kWEGV3ysLN
	 BUAR4kZ1GXPOQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54f4b31494fso9312267a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 12 Dec 2023 11:22:21 -0800 (PST)
X-Gm-Message-State: AOJu0YypWUnaZw6YlrfuuEMpZ/OUj4jyiIlL94KNzGOekI6qbVIFomGT
	8+9McMu/Pm06SXHwbRiVEbhL0TuudALd/YY8haAjpg==
X-Google-Smtp-Source: AGHT+IGt7+EiPa2NUH35A5YujCkzrmLERWiAdyOrjpgY/ezwMiXHBzFZgc6YWQ1mlQyfRtwOs+FtPdkeuskg+LpIVB0=
X-Received: by 2002:a50:9357:0:b0:54c:553e:67f5 with SMTP id
 n23-20020a509357000000b0054c553e67f5mr7027221eda.8.1702408939747; Tue, 12 Dec
 2023 11:22:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208090622.4309-1-laoar.shao@gmail.com> <20231208090622.4309-6-laoar.shao@gmail.com>
In-Reply-To: <20231208090622.4309-6-laoar.shao@gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 12 Dec 2023 20:22:07 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7Eg=bG5Vr8eiXyLq+hto2KpnzhgRrw3eiJiqeJSs4w_w@mail.gmail.com>
Message-ID: <CACYkzJ7Eg=bG5Vr8eiXyLq+hto2KpnzhgRrw3eiJiqeJSs4w_w@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] selftests/bpf: Add selftests for set_mempolicy
 with a lsm prog
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, omosnace@redhat.com, mhocko@suse.com, ying.huang@intel.com, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 10:06=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> The result as follows,
>   #263/1   set_mempolicy/MPOL_BIND_without_lsm:OK
>   #263/2   set_mempolicy/MPOL_DEFAULT_without_lsm:OK
>   #263/3   set_mempolicy/MPOL_BIND_with_lsm:OK
>   #263/4   set_mempolicy/MPOL_DEFAULT_with_lsm:OK
>   #263     set_mempolicy:OK
>   Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

Please write a commit description on what the test actually does. I
even think of something simple that mentions a BPF LSM program that
denies all mbind with the mode MPOL_BIND and checks whether the
corresponding syscall is denied when the program is loaded.


>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/set_mempolicy.c       | 81 ++++++++++++++++=
++++++
>  .../selftests/bpf/progs/test_set_mempolicy.c       | 28 ++++++++
>  2 files changed, 109 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/set_mempolicy.=
c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_set_mempolicy.=
c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/set_mempolicy.c b/too=
ls/testing/selftests/bpf/prog_tests/set_mempolicy.c
> new file mode 100644
> index 0000000..736b5e3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
> +
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/mman.h>
> +#include <linux/mempolicy.h>
> +#include <test_progs.h>
> +#include "test_set_mempolicy.skel.h"
> +
> +#define SIZE 4096
> +
> +static void mempolicy_bind(bool success)
> +{
> +       unsigned long mask =3D 1;
> +       char *addr;
> +       int err;
> +
> +       addr =3D mmap(NULL, SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_A=
NONYMOUS, -1, 0);
> +       if (!ASSERT_OK_PTR(addr, "mmap"))
> +               return;
> +
> +       /* -lnuma is required by mbind(2), so use __NR_mbind to avoid the=
 dependency. */
> +       err =3D syscall(__NR_mbind, addr, SIZE, MPOL_BIND, &mask, sizeof(=
mask), 0);
> +       if (success)
> +               ASSERT_OK(err, "mbind_success");
> +       else
> +               ASSERT_ERR(err, "mbind_fail");
> +
> +       munmap(addr, SIZE);
> +}
> +
> +static void mempolicy_default(void)
> +{
> +       char *addr;
> +       int err;
> +
> +       addr =3D mmap(NULL, SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_A=
NONYMOUS, -1, 0);
> +       if (!ASSERT_OK_PTR(addr, "mmap"))
> +               return;
> +
> +       err =3D syscall(__NR_mbind, addr, SIZE, MPOL_DEFAULT, NULL, 0, 0)=
;
> +       ASSERT_OK(err, "mbind_success");
> +
> +       munmap(addr, SIZE);
> +}
> +
> +void test_set_mempolicy(void)
> +{
> +       struct test_set_mempolicy *skel;
> +       int err;
> +
> +       skel =3D test_set_mempolicy__open();
> +       if (!ASSERT_OK_PTR(skel, "open"))
> +               return;
> +
> +       skel->bss->target_pid =3D getpid();
> +
> +       err =3D test_set_mempolicy__load(skel);
> +       if (!ASSERT_OK(err, "load"))
> +               goto destroy;
> +
> +       if (test__start_subtest("MPOL_BIND_without_lsm"))
> +               mempolicy_bind(true);
> +       if (test__start_subtest("MPOL_DEFAULT_without_lsm"))
> +               mempolicy_default();
> +
> +       /* Attach LSM prog first */
> +       err =3D test_set_mempolicy__attach(skel);
> +       if (!ASSERT_OK(err, "attach"))
> +               goto destroy;
> +
> +       /* syscall to adjust memory policy */
> +       if (test__start_subtest("MPOL_BIND_with_lsm"))
> +               mempolicy_bind(false);
> +       if (test__start_subtest("MPOL_DEFAULT_with_lsm"))
> +               mempolicy_default();
> +
> +destroy:
> +       test_set_mempolicy__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_set_mempolicy.c b/too=
ls/testing/selftests/bpf/progs/test_set_mempolicy.c
> new file mode 100644
> index 0000000..b5356d5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_set_mempolicy.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +int target_pid;
> +
> +static int mem_policy_adjustment(u64 mode)
> +{
> +       struct task_struct *task =3D bpf_get_current_task_btf();
> +
> +       if (task->pid !=3D target_pid)
> +               return 0;
> +
> +       if (mode !=3D MPOL_BIND)
> +               return 0;
> +       return -1;
> +}
> +
> +SEC("lsm/set_mempolicy")
> +int BPF_PROG(setmempolicy, u64 mode, u16 mode_flags, nodemask_t *nmask, =
u32 flags)
> +{
> +       return mem_policy_adjustment(mode);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 1.8.3.1
>
>

