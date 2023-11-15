Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D237E783B
	for <lists+linux-security-module@lfdr.de>; Fri, 10 Nov 2023 04:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345847AbjKJDs4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 9 Nov 2023 22:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345800AbjKJDs4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Nov 2023 22:48:56 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7AE4687
        for <linux-security-module@vger.kernel.org>; Thu,  9 Nov 2023 19:48:54 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MXqje005487
        for <linux-security-module@vger.kernel.org>; Thu, 9 Nov 2023 19:48:53 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u8nqkjakm-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 09 Nov 2023 19:48:53 -0800
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 19:48:51 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 431BA3B41DBB1; Thu,  9 Nov 2023 19:48:38 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <paul@paul-moore.com>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v10 bpf-next 00/17] BPF token and BPF FS-based delegation
Date:   Thu, 9 Nov 2023 19:48:21 -0800
Message-ID: <20231110034838.1295764-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fyTvUsNNGz4x-1ZwCu5emTmG-zppDJjU
X-Proofpoint-GUID: fyTvUsNNGz4x-1ZwCu5emTmG-zppDJjU
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch set introduces an ability to delegate a subset of BPF subsystem
functionality from privileged system-wide daemon (e.g., systemd or any other
container manager) through special mount options for userns-bound BPF FS to
a *trusted* unprivileged application. Trust is the key here. This
functionality is not about allowing unconditional unprivileged BPF usage.
Establishing trust, though, is completely up to the discretion of respective
privileged application that would create and mount a BPF FS instance with
delegation enabled, as different production setups can and do achieve it
through a combination of different means (signing, LSM, code reviews, etc),
and it's undesirable and infeasible for kernel to enforce any particular way
of validating trustworthiness of particular process.

The main motivation for this work is a desire to enable containerized BPF
applications to be used together with user namespaces. This is currently
impossible, as CAP_BPF, required for BPF subsystem usage, cannot be namespaced
or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BPF
helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely read
arbitrary memory, and it's impossible to ensure that they only read memory of
processes belonging to any given namespace. This means that it's impossible to
have a mechanically verifiable namespace-aware CAP_BPF capability, and as such
another mechanism to allow safe usage of BPF functionality is necessary.BPF FS
delegation mount options and BPF token derived from such BPF FS instance is
such a mechanism. Kernel makes no assumption about what "trusted" constitutes
in any particular case, and it's up to specific privileged applications and
their surrounding infrastructure to decide that. What kernel provides is a set
of APIs to setup and mount special BPF FS instanecs and derive BPF tokens from
it. BPF FS and BPF token are both bound to its owning userns and in such a way
are constrained inside intended container. Users can then pass BPF token FD to
privileged bpf() syscall commands, like BPF map creation and BPF program
loading, to perform such operations without having init userns privileged.

This version incorporates feedback and suggestions ([3]) received on v3 of
this patch set, and instead of allowing to create BPF tokens directly assuming
capable(CAP_SYS_ADMIN), we instead enhance BPF FS to accept a few new
delegation mount options. If these options are used and BPF FS itself is
properly created, set up, and mounted inside the user namespaced container,
user application is able to derive a BPF token object from BPF FS instance,
and pass that token to bpf() syscall. As explained in patch #3, BPF token
itself doesn't grant access to BPF functionality, but instead allows kernel to
do namespaced capabilities checks (ns_capable() vs capable()) for CAP_BPF,
CAP_PERFMON, CAP_NET_ADMIN, and CAP_SYS_ADMIN, as applicable. So it forms one
half of a puzzle and allows container managers and sys admins to have safe and
flexible configuration options: determining which containers get delegation of
BPF functionality through BPF FS, and then which applications within such
containers are allowed to perform bpf() commands, based on namespaces
capabilities.

Previous attempt at addressing this very same problem ([0]) attempted to
utilize authoritative LSM approach, but was conclusively rejected by upstream
LSM maintainers. BPF token concept is not changing anything about LSM
approach, but can be combined with LSM hooks for very fine-grained security
policy. Some ideas about making BPF token more convenient to use with LSM (in
particular custom BPF LSM programs) was briefly described in recent LSF/MM/BPF
2023 presentation ([1]). E.g., an ability to specify user-provided data
(context), which in combination with BPF LSM would allow implementing a very
dynamic and fine-granular custom security policies on top of BPF token. In the
interest of minimizing API surface area and discussions this was relegated to
follow up patches, as it's not essential to the fundamental concept of
delegatable BPF token.

It should be noted that BPF token is conceptually quite similar to the idea of
/dev/bpf device file, proposed by Song a while ago ([2]). The biggest
difference is the idea of using virtual anon_inode file to hold BPF token and
allowing multiple independent instances of them, each (potentially) with its
own set of restrictions. And also, crucially, BPF token approach is not using
any special stateful task-scoped flags. Instead, bpf() syscall accepts
token_fd parameters explicitly for each relevant BPF command. This addresses
main concerns brought up during the /dev/bpf discussion, and fits better with
overall BPF subsystem design.

This patch set adds a basic minimum of functionality to make BPF token idea
useful and to discuss API and functionality. Currently only low-level libbpf
APIs support creating and passing BPF token around, allowing to test kernel
functionality, but for the most part is not sufficient for real-world
applications, which typically use high-level libbpf APIs based on `struct
bpf_object` type. This was done with the intent to limit the size of patch set
and concentrate on mostly kernel-side changes. All the necessary plumbing for
libbpf will be sent as a separate follow up patch set kernel support makes it
upstream.

Another part that should happen once kernel-side BPF token is established, is
a set of conventions between applications (e.g., systemd), tools (e.g.,
bpftool), and libraries (e.g., libbpf) on exposing delegatable BPF FS
instance(s) at well-defined locations to allow applications take advantage of
this in automatic fashion without explicit code changes on BPF application's
side. But I'd like to postpone this discussion to after BPF token concept
lands.

  [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.org/
  [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BPF_LSFMM2023.pdf
  [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving@fb.com/
  [3] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785e@brauner/

v9-v10:
  - slight adjustments in LSM parts (Paul);
  - setting delegate_xxx  options require capable(CAP_SYS_ADMIN) (Christian);
  - simplify BPF_TOKEN_CREATE UAPI by accepting BPF FS FD directly (Christian);
v8->v9:
  - fix issue in selftests due to sys/mount.h header (Jiri);
  - fix warning in doc comments in LSM hooks (kernel test robot);
v7->v8:
  - add bpf_token_allow_cmd and bpf_token_capable hooks (Paul);
  - inline bpf_token_alloc() into bpf_token_create() to prevent accidental
    divergence with security_bpf_token_create() hook (Paul);
v6->v7:
  - separate patches to refactor bpf_prog_alloc/bpf_map_alloc LSM hooks, as
    discussed with Paul, and now they also accept struct bpf_token;
  - added bpf_token_create/bpf_token_free to allow LSMs (SELinux,
    specifically) to set up security LSM blob (Paul);
  - last patch also wires bpf_security_struct setup by SELinux, similar to how
    it's done for BPF map/prog, though I'm not sure if that's enough, so worst
    case it's easy to drop this patch if more full fledged SELinux
    implementation will be done separately;
  - small fixes for issues caught by code reviews (Jiri, Hou);
  - fix for test_maps test that doesn't use LIBBPF_OPTS() macro (CI);
v5->v6:
  - fix possible use of uninitialized variable in selftests (CI);
  - don't use anon_inode, instead create one from BPF FS instance (Christian);
  - don't store bpf_token inside struct bpf_map, instead pass it explicitly to
    map_check_btf(). We do store bpf_token inside prog->aux, because it's used
    during verification and even can be checked during attach time for some
    program types;
  - LSM hooks are left intact pending the conclusion of discussion with Paul
    Moore; I'd prefer to do LSM-related changes as a follow up patch set
    anyways;
v4->v5:
  - add pre-patch unifying CAP_NET_ADMIN handling inside kernel/bpf/syscall.c
    (Paul Moore);
  - fix build warnings and errors in selftests and kernel, detected by CI and
    kernel test robot;
v3->v4:
  - add delegation mount options to BPF FS;
  - BPF token is derived from the instance of BPF FS and associates itself
    with BPF FS' owning userns;
  - BPF token doesn't grant BPF functionality directly, it just turns
    capable() checks into ns_capable() checks within BPF FS' owning user;
  - BPF token cannot be pinned;
v2->v3:
  - make BPF_TOKEN_CREATE pin created BPF token in BPF FS, and disallow
    BPF_OBJ_PIN for BPF token;
v1->v2:
  - fix build failures on Kconfig with CONFIG_BPF_SYSCALL unset;
  - drop BPF_F_TOKEN_UNKNOWN_* flags and simplify UAPI (Stanislav).

Andrii Nakryiko (17):
  bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
  bpf: add BPF token delegation mount options to BPF FS
  bpf: introduce BPF token object
  bpf: add BPF token support to BPF_MAP_CREATE command
  bpf: add BPF token support to BPF_BTF_LOAD command
  bpf: add BPF token support to BPF_PROG_LOAD command
  bpf: take into account BPF token when fetching helper protos
  bpf: consistently use BPF token throughout BPF verifier logic
  bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM hooks
  bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM hooks
  bpf,lsm: add BPF token LSM hooks
  libbpf: add bpf_token_create() API
  libbpf: add BPF token support to bpf_map_create() API
  libbpf: add BPF token support to bpf_btf_load() API
  libbpf: add BPF token support to bpf_prog_load() API
  selftests/bpf: add BPF token-enabled tests
  bpf,selinux: allocate bpf_security_struct per BPF token

 drivers/media/rc/bpf-lirc.c                   |   2 +-
 include/linux/bpf.h                           |  83 ++-
 include/linux/filter.h                        |   2 +-
 include/linux/lsm_hook_defs.h                 |  15 +-
 include/linux/security.h                      |  43 +-
 include/uapi/linux/bpf.h                      |  42 ++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/arraymap.c                         |   2 +-
 kernel/bpf/bpf_lsm.c                          |  15 +-
 kernel/bpf/cgroup.c                           |   6 +-
 kernel/bpf/core.c                             |   3 +-
 kernel/bpf/helpers.c                          |   6 +-
 kernel/bpf/inode.c                            | 101 ++-
 kernel/bpf/syscall.c                          | 215 ++++--
 kernel/bpf/token.c                            | 249 +++++++
 kernel/bpf/verifier.c                         |  13 +-
 kernel/trace/bpf_trace.c                      |   2 +-
 net/core/filter.c                             |  36 +-
 net/ipv4/bpf_tcp_ca.c                         |   2 +-
 net/netfilter/nf_bpf_link.c                   |   2 +-
 security/security.c                           | 101 ++-
 security/selinux/hooks.c                      |  47 +-
 tools/include/uapi/linux/bpf.h                |  42 ++
 tools/lib/bpf/bpf.c                           |  28 +-
 tools/lib/bpf/bpf.h                           |  35 +-
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
 .../testing/selftests/bpf/prog_tests/token.c  | 672 ++++++++++++++++++
 29 files changed, 1610 insertions(+), 167 deletions(-)
 create mode 100644 kernel/bpf/token.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c

-- 
2.34.1

