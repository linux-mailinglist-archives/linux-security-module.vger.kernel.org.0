Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860F513DA98
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Jan 2020 13:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgAPMuD (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 16 Jan 2020 07:50:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51819 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAPMuC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jan 2020 07:50:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so3651158wmd.1
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jan 2020 04:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tr/DtQbw80edm0kUYwLGkk2mPCZ6YPMOG5ytlVqwf38=;
        b=VtZUmkL+mW9tvhVrFIuogQamsu85xPQJsCw3qEI+HIEloMyZGmdZKfpGJlBJTB9SH8
         42bN5oRkXhgLPOyT0h9W/dWFSmLQwbHNLpG+0CFcu15JUeQPXPZ/T3XjqJIdKnIqRa5c
         QwcNenJQLPN+XShEpFT2oGlSpVkJWbmx19UuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tr/DtQbw80edm0kUYwLGkk2mPCZ6YPMOG5ytlVqwf38=;
        b=hdFdMXCBlpOthn5O7X56w3cfIGKrCoLobEVFjj7diwSKxP5zhsqShNJcVGzxJvcL+5
         9OwabrblXEj5YLasHkF4Yw04MAeaxboXfdmhex/tDUo2Y0hI0uvWY4IKlSya34k8sPnc
         Mbwgliav7wY21UZ2jl/zpfUUum+KTOpeb9RS7FlSrkRfa6ZA1JjoWkMQtatBEglk0gYT
         wPbzrFEBvzhdsXlc1R8MQvgrWjAU8/2SdQuTnNhfXqq3LYy6ocluqaDacMuCysERFv2/
         MpcYy12T8JRwbLYGjst1sXzN0biu4JqZIqN6xp9wM58KeTcqxERqOn4/bG2qu7sbmRaW
         Iehw==
X-Gm-Message-State: APjAAAXQaCONWSartK/LPAKBOOj92EaKCtLrkh/F/lC0Jh+/B3p2u4Hj
        w6dLqy4QV6z46K2tqRdhRwOWAw==
X-Google-Smtp-Source: APXvYqwmQ1fburvLVtHu6aw66s3XtC88auqcz/HJevROy/CPn12+A2Ac8OF0hanW7boS+0yOStrJGw==
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr5800797wma.139.1579178998421;
        Thu, 16 Jan 2020 04:49:58 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id a184sm4430870wmf.29.2020.01.16.04.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:49:57 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 16 Jan 2020 13:49:55 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v2 08/10] tools/libbpf: Add support for
 BPF_PROG_TYPE_LSM
Message-ID: <20200116124955.GD240584@google.com>
References: <20200115171333.28811-1-kpsingh@chromium.org>
 <20200115171333.28811-9-kpsingh@chromium.org>
 <CAEf4BzZodr3LKJuM7QwD38BiEH02Cc1UbtnGpVkCJ00Mf+V_Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZodr3LKJuM7QwD38BiEH02Cc1UbtnGpVkCJ00Mf+V_Qg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks for the review Andrii!

I will incorporate the fixes in the next revision.

On 15-Jan 13:19, Andrii Nakryiko wrote:
> On Wed, Jan 15, 2020 at 9:13 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > * Add functionality in libbpf to attach eBPF program to LSM hooks
> > * Lookup the index of the LSM hook in security_hook_heads and pass it in
> >   attr->lsm_hook_index
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  tools/lib/bpf/bpf.c      |   6 +-
> >  tools/lib/bpf/bpf.h      |   1 +
> >  tools/lib/bpf/libbpf.c   | 143 ++++++++++++++++++++++++++++++++++-----
> >  tools/lib/bpf/libbpf.h   |   4 ++
> >  tools/lib/bpf/libbpf.map |   3 +
> >  5 files changed, 138 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index 500afe478e94..b138d98ff862 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -235,7 +235,10 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
> >         memset(&attr, 0, sizeof(attr));
> >         attr.prog_type = load_attr->prog_type;
> >         attr.expected_attach_type = load_attr->expected_attach_type;
> > -       if (attr.prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
> > +
> > +       if (attr.prog_type == BPF_PROG_TYPE_LSM) {
> > +               attr.lsm_hook_index = load_attr->lsm_hook_index;
> > +       } else if (attr.prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
> >                 attr.attach_btf_id = load_attr->attach_btf_id;
> >         } else if (attr.prog_type == BPF_PROG_TYPE_TRACING) {
> >                 attr.attach_btf_id = load_attr->attach_btf_id;
> > @@ -244,6 +247,7 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
> >                 attr.prog_ifindex = load_attr->prog_ifindex;
> >                 attr.kern_version = load_attr->kern_version;
> >         }
> > +
> >         attr.insn_cnt = (__u32)load_attr->insns_cnt;
> >         attr.insns = ptr_to_u64(load_attr->insns);
> >         attr.license = ptr_to_u64(load_attr->license);
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index 56341d117e5b..54458a102939 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -86,6 +86,7 @@ struct bpf_load_program_attr {
> >                 __u32 prog_ifindex;
> >                 __u32 attach_btf_id;
> >         };
> > +       __u32 lsm_hook_index;
> 
> 
> this is changing memory layout of struct bpf_load_program_attr, which
> is part of public API, so breaking backward compatibility. But I think
> you intended to put it inside union along the attach_btf_id?
> 

Correct, I moved it to the union.

> also, we use idx for index pretty consistently (apart from ifindex),
> so maybe lsm_hook_idx?

Renamed all usages of index -> idx.

> 
> >         __u32 prog_btf_fd;
> >         __u32 func_info_rec_size;
> >         const void *func_info;
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 0c229f00a67e..60737559a9a6 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -229,6 +229,7 @@ struct bpf_program {
> >         enum bpf_attach_type expected_attach_type;
> >         __u32 attach_btf_id;
> >         __u32 attach_prog_fd;
> > +       __u32 lsm_hook_index
> >         void *func_info;
> >         __u32 func_info_rec_size;
> >         __u32 func_info_cnt;
> > @@ -4886,7 +4887,10 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
> >         load_attr.insns = insns;
> >         load_attr.insns_cnt = insns_cnt;
> >         load_attr.license = license;
> > -       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
> > +
> > +       if (prog->type == BPF_PROG_TYPE_LSM) {
> > +               load_attr.lsm_hook_index = prog->lsm_hook_index;
> > +       } else if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
> >                 load_attr.attach_btf_id = prog->attach_btf_id;
> >         } else if (prog->type == BPF_PROG_TYPE_TRACING) {
> >                 load_attr.attach_prog_fd = prog->attach_prog_fd;
> > @@ -4895,6 +4899,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
> >                 load_attr.kern_version = kern_version;
> >                 load_attr.prog_ifindex = prog->prog_ifindex;
> >         }
> > +
> >         /* if .BTF.ext was loaded, kernel supports associated BTF for prog */
> >         if (prog->obj->btf_ext)
> >                 btf_fd = bpf_object__btf_fd(prog->obj);
> > @@ -4967,9 +4972,11 @@ static int libbpf_find_attach_btf_id(const char *name,
> >                                      enum bpf_attach_type attach_type,
> >                                      __u32 attach_prog_fd);
> >
> > +static __s32 btf__find_lsm_hook_index(const char *name);
> > +
> >  int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
> >  {
> > -       int err = 0, fd, i, btf_id;
> > +       int err = 0, fd, i, btf_id, index;
> >
> >         if (prog->type == BPF_PROG_TYPE_TRACING) {
> >                 btf_id = libbpf_find_attach_btf_id(prog->section_name,
> > @@ -4980,6 +4987,13 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
> >                 prog->attach_btf_id = btf_id;
> >         }
> >
> > +       if (prog->type == BPF_PROG_TYPE_LSM) {
> > +               index = btf__find_lsm_hook_index(prog->section_name);
> > +               if (index < 0)
> > +                       return index;
> > +               prog->lsm_hook_index = index;
> > +       }
> > +
> >         if (prog->instances.nr < 0 || !prog->instances.fds) {
> >                 if (prog->preprocessor) {
> >                         pr_warn("Internal error: can't load program '%s'\n",
> > @@ -6207,6 +6221,7 @@ bool bpf_program__is_##NAME(const struct bpf_program *prog)       \
> >  }                                                              \
> >
> >  BPF_PROG_TYPE_FNS(socket_filter, BPF_PROG_TYPE_SOCKET_FILTER);
> > +BPF_PROG_TYPE_FNS(lsm, BPF_PROG_TYPE_LSM);
> >  BPF_PROG_TYPE_FNS(kprobe, BPF_PROG_TYPE_KPROBE);
> >  BPF_PROG_TYPE_FNS(sched_cls, BPF_PROG_TYPE_SCHED_CLS);
> >  BPF_PROG_TYPE_FNS(sched_act, BPF_PROG_TYPE_SCHED_ACT);
> > @@ -6272,6 +6287,8 @@ static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
> >                                       struct bpf_program *prog);
> >  static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
> >                                      struct bpf_program *prog);
> > +static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
> > +                                  struct bpf_program *prog);
> >
> >  struct bpf_sec_def {
> >         const char *sec;
> > @@ -6315,12 +6332,17 @@ static const struct bpf_sec_def section_defs[] = {
> >                 .expected_attach_type = BPF_TRACE_FEXIT,
> >                 .is_attach_btf = true,
> >                 .attach_fn = attach_trace),
> > +       SEC_DEF("lsm/", LSM,
> > +               .expected_attach_type = BPF_LSM_MAC,
> > +               .attach_fn = attach_lsm),
> >         BPF_PROG_SEC("xdp",                     BPF_PROG_TYPE_XDP),
> >         BPF_PROG_SEC("perf_event",              BPF_PROG_TYPE_PERF_EVENT),
> >         BPF_PROG_SEC("lwt_in",                  BPF_PROG_TYPE_LWT_IN),
> >         BPF_PROG_SEC("lwt_out",                 BPF_PROG_TYPE_LWT_OUT),
> >         BPF_PROG_SEC("lwt_xmit",                BPF_PROG_TYPE_LWT_XMIT),
> >         BPF_PROG_SEC("lwt_seg6local",           BPF_PROG_TYPE_LWT_SEG6LOCAL),
> > +       BPF_PROG_BTF("lsm/",                    BPF_PROG_TYPE_LSM,
> > +                                               BPF_LSM_MAC),
> 
> This is just a duplicate of SEC_DEF above, remove?

Oops. Removed.

> 
> >         BPF_APROG_SEC("cgroup_skb/ingress",     BPF_PROG_TYPE_CGROUP_SKB,
> >                                                 BPF_CGROUP_INET_INGRESS),
> >         BPF_APROG_SEC("cgroup_skb/egress",      BPF_PROG_TYPE_CGROUP_SKB,
> > @@ -6576,32 +6598,80 @@ static int bpf_object__collect_struct_ops_map_reloc(struct bpf_object *obj,
> >         return -EINVAL;
> >  }
> >
> > -#define BTF_PREFIX "btf_trace_"
> > +#define BTF_TRACE_PREFIX "btf_trace_"
> > +
> > +static inline int btf__find_by_prefix_kind(struct btf *btf, const char *name,
> > +                                          const char *prefix, __u32 kind)
> 
> this is internal helper, not really BTF API, let's call it
> find_btf_by_prefix_kind? Also const char *prefix more logically should
> go before name argument?

Done.

> 
> > +{
> > +       char btf_type_name[128];
> > +
> > +       snprintf(btf_type_name, sizeof(btf_type_name), "%s%s", prefix, name);
> 
> check overflow?

Done.

> 
> > +       return btf__find_by_name_kind(btf, btf_type_name, kind);
> > +}
> > +
> > +static __s32 btf__find_lsm_hook_index(const char *name)
> 
> this name is violating libbpf naming guidelines. Just
> `find_lsm_hook_idx` for now?

Cool. I think I finally hang of the naming convention now :). I mixed
up btf.c and libbpf.c here.

> 
> > +{
> > +       struct btf *btf = bpf_find_kernel_btf();
> 
> ok, it's probably time to do this right. Let's ensure we load kernel
> BTF just once, keep it inside bpf_object while we need it and then
> release it after successful load. We are at the point where all the
> new types of program is loading/releasing kernel BTF for every section
> and it starts to feel very wasteful.

Sure, will give it a shot in v3.

> 
> > +       const struct bpf_sec_def *sec_def;
> > +       const struct btf_type *hl_type;
> > +       struct btf_member *m;
> > +       __u16 vlen;
> > +       __s32 hl_id;
> > +       int j;
> 
> j without having i used anywhere?...

Fixed.

> 
> > +
> > +       sec_def = find_sec_def(name);
> > +       if (!sec_def)
> > +               return -ESRCH;
> > +
> > +       name += sec_def->len;
> > +
> > +       hl_id = btf__find_by_name_kind(btf, "security_hook_heads",
> > +                                      BTF_KIND_STRUCT);
> > +       if (hl_id < 0) {
> > +               pr_debug("security_hook_heads cannot be found in BTF\n");
> 
> "in vmlinux BTF" ?
> 
> and it should be pr_warn(), we don't really expect this, right?

Fixed both.

> 
> and it should be (hl_id <= 0) with current btf__find_by_name_kind(),
> and then return hl_id ? : -ESRCH, which further proves we need to
> change btf__find_by_name_kind() as I suggested below.
> 
> > +               return hl_id;
> > +       }
> > +
> > +       hl_type = btf__type_by_id(btf, hl_id);
> > +       if (!hl_type) {
> > +               pr_warn("Can't find type for security_hook_heads: %u\n", hl_id);
> > +               return -EINVAL;
> 
> -ESRCH?

Done.

> 
> > +       }
> > +
> > +       m = btf_members(hl_type);
> > +       vlen = btf_vlen(hl_type);
> > +
> > +       for (j = 0; j < vlen; j++) {
> 
> can add succinct `, m++` here instead

Done.

> 
> > +               if (!strcmp(btf__name_by_offset(btf, m->name_off), name))
> > +                       return j + 1;
> 
> I looked briefly through kernel-side patch introducing lsm_hook_index,
> but it didn't seem to explain why this index needs to be (unnaturally)
> 1-based. So asking here first as I'm looking through libbpf changes?

The lsm_hook_idx is one-based as it makes it easy to validate the
input. If we make it zero-based it's hard to check if the user
intended to attach to the LSM hook at index 0 or did not set it.

We are then up to the verifier to reject the loaded program which
may or may not match the signature of the hook at lsm_hook_idx = 0.

I will clarify this in the commit log as well.

> 
> > +               m++;
> > +       }
> > +
> > +       pr_warn("Cannot find offset for %s in security_hook_heads\n", name);
> 
> it's not offset, rather member index?

Correct, fixed.

> 
> > +       return -ENOENT;
> 
> not entirely clear about distinction between ENOENT and ESRCH? So far
> we typically used ESRCH, does ENOENT have more specific semantics?

Updated it to ESRCH, to be consistent with libbpf's convention.

> 
> > +}
> > +
> >  int libbpf_find_vmlinux_btf_id(const char *name,
> >                                enum bpf_attach_type attach_type)
> >  {
> >         struct btf *btf = bpf_find_kernel_btf();
> > -       char raw_tp_btf[128] = BTF_PREFIX;
> > -       char *dst = raw_tp_btf + sizeof(BTF_PREFIX) - 1;
> > -       const char *btf_name;
> >         int err = -EINVAL;
> > -       __u32 kind;
> >
> >         if (IS_ERR(btf)) {
> >                 pr_warn("vmlinux BTF is not found\n");
> >                 return -EINVAL;
> >         }
> >
> > -       if (attach_type == BPF_TRACE_RAW_TP) {
> > -               /* prepend "btf_trace_" prefix per kernel convention */
> > -               strncat(dst, name, sizeof(raw_tp_btf) - sizeof(BTF_PREFIX));
> > -               btf_name = raw_tp_btf;
> > -               kind = BTF_KIND_TYPEDEF;
> > -       } else {
> > -               btf_name = name;
> > -               kind = BTF_KIND_FUNC;
> > -       }
> > -       err = btf__find_by_name_kind(btf, btf_name, kind);
> > +       if (attach_type == BPF_TRACE_RAW_TP)
> > +               err = btf__find_by_prefix_kind(btf, name, BTF_TRACE_PREFIX,
> > +                                              BTF_KIND_TYPEDEF);
> > +       else
> > +               err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> > +
> > +       /* err = 0 means void / UNKNOWN which is treated as an error */
> > +       if (err == 0)
> > +               err = -EINVAL;
> 
> I think it's actually less error-prone to make btf__find_by_name_kind
> and btf__find_by_prefix_kind to return -ESRCH when type is not found,
> instead of a valid type_id 0. I just checked, and struct_ops code
> already is mishandling it, only checking for <0. Could you make this
> change and just do a natural <0 check everywhere?
> 
> 
> > +
> >         btf__free(btf);
> >         return err;
> >  }
> > @@ -6630,7 +6700,7 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
> >         }
> >         err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> >         btf__free(btf);
> > -       if (err <= 0) {
> > +       if (err < 0) {
> >                 pr_warn("%s is not found in prog's BTF\n", name);
> >                 goto out;
> >         }
> > @@ -7395,6 +7465,43 @@ static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
> >         return bpf_program__attach_trace(prog);
> >  }
> >
> > +struct bpf_link *bpf_program__attach_lsm(struct bpf_program *prog)
> > +{
> > +       char errmsg[STRERR_BUFSIZE];
> > +       struct bpf_link_fd *link;
> > +       int prog_fd, pfd;
> > +
> > +       prog_fd = bpf_program__fd(prog);
> > +       if (prog_fd < 0) {
> > +               pr_warn("program '%s': can't attach before loaded\n",
> > +                       bpf_program__title(prog, false));
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       link = calloc(1, sizeof(*link));
> > +       if (!link)
> > +               return ERR_PTR(-ENOMEM);
> > +       link->link.detach = &bpf_link__detach_fd;
> > +
> > +       pfd = bpf_prog_attach(prog_fd, 0, BPF_LSM_MAC,
> > +                             BPF_F_ALLOW_OVERRIDE);
> 
> do we want to always specify ALLOW_OVERRIDE? Or should it be an option?

I think this is a relic from the duplicate attachment code. With the
anonymous-fd + link which can be destroyed. The way the OVERRIDE
should work is:

-  Destroy the link (detach)
-  And attach.

We don't use the BPF_F_ALLOW_OVERRIDE in the attach logic in the LSM.
So I will get rid of that.

> 
> > +       if (pfd < 0) {
> > +               pfd = -errno;
> > +               pr_warn("program '%s': failed to attach: %s\n",
> > +                       bpf_program__title(prog, false),
> > +                       libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
> > +               return ERR_PTR(pfd);
> 
> leaking link here

Fixed.

> 
> > +       }
> > +       link->fd = pfd;
> > +       return (struct bpf_link *)link;
> > +}
> > +
> > +static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
> > +                                  struct bpf_program *prog)
> > +{
> > +       return bpf_program__attach_lsm(prog);
> > +}
> > +
> >  struct bpf_link *bpf_program__attach(struct bpf_program *prog)
> >  {
> >         const struct bpf_sec_def *sec_def;
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 01639f9a1062..a97e709a29e6 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -241,6 +241,8 @@ LIBBPF_API struct bpf_link *
> >  bpf_program__attach_trace(struct bpf_program *prog);
> >  struct bpf_map;
> >  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(struct bpf_map *map);
> > +LIBBPF_API struct bpf_link *
> > +bpf_program__attach_lsm(struct bpf_program *prog);
> 
> nit: put it after attach_trace, so that program attaches and map
> attaches are grouped together, not intermixed

Done.

> 
> >  struct bpf_insn;
> >
> >  /*
> > @@ -318,6 +320,7 @@ LIBBPF_API int bpf_program__set_xdp(struct bpf_program *prog);
> >  LIBBPF_API int bpf_program__set_perf_event(struct bpf_program *prog);
> >  LIBBPF_API int bpf_program__set_tracing(struct bpf_program *prog);
> >  LIBBPF_API int bpf_program__set_struct_ops(struct bpf_program *prog);
> > +LIBBPF_API int bpf_program__set_lsm(struct bpf_program *prog);
> >
> >  LIBBPF_API enum bpf_prog_type bpf_program__get_type(struct bpf_program *prog);
> >  LIBBPF_API void bpf_program__set_type(struct bpf_program *prog,
> > @@ -339,6 +342,7 @@ LIBBPF_API bool bpf_program__is_xdp(const struct bpf_program *prog);
> >  LIBBPF_API bool bpf_program__is_perf_event(const struct bpf_program *prog);
> >  LIBBPF_API bool bpf_program__is_tracing(const struct bpf_program *prog);
> >  LIBBPF_API bool bpf_program__is_struct_ops(const struct bpf_program *prog);
> > +LIBBPF_API bool bpf_program__is_lsm(const struct bpf_program *prog);
> >
> >  /*
> >   * No need for __attribute__((packed)), all members of 'bpf_map_def'
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index a19f04e6e3d9..3da0452ce679 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -227,4 +227,7 @@ LIBBPF_0.0.7 {
> >                 bpf_program__is_struct_ops;
> >                 bpf_program__set_struct_ops;
> >                 btf__align_of;
> > +               bpf_program__is_lsm;
> > +               bpf_program__set_lsm;
> > +               bpf_program__attach_lsm;
> 
> preserve alphabetical order, please

Sure.

> 
> >  } LIBBPF_0.0.6;
> 
> > --
> > 2.20.1
> >
