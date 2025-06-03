Return-Path: <linux-security-module+bounces-10302-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D05ACBD6C
	for <lists+linux-security-module@lfdr.de>; Tue,  3 Jun 2025 00:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1DC7A771D
	for <lists+linux-security-module@lfdr.de>; Mon,  2 Jun 2025 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A246253938;
	Mon,  2 Jun 2025 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HdFEIjP1"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111824DD14
	for <linux-security-module@vger.kernel.org>; Mon,  2 Jun 2025 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748904051; cv=none; b=GShOLlgPqnxNVxjUt4L6zit81CUK96xH6eIOQKB4ss/dfm5yqkKaMuH1sHyUWiXD6+UcElgQTXG0Jk9tr64sg8ypW1jRZox7W5RRrbBMBuQWIoQbJsbvrtxKJWP9ODVk/XirJX//zZIZrgta90UERl6CdEfLQp7QcPVJSefwMyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748904051; c=relaxed/simple;
	bh=/vvqRw9cz+5hMeJ/bcZKDuYvQogKzDJ587sBcYGc52I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2gFRBprQ0mkDdD5DbY5KOhRrLJGB/UmXJvSv9QDweErngmglE0r6TyeTFBqFQHHsff2kgTLFU9S0y/QXTojGSlCqCwSZe0KDYMAvriY/6Yv25WJ9SWnJigtPUEaxm5QRmCvRJFYmgyz4yjFC11hnSNozy02qnLY0JXpOx38WR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HdFEIjP1; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70e5599b795so47998787b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 02 Jun 2025 15:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1748904046; x=1749508846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T32s96RITG9z0l1YbpSqA97I6G74VAkYppjM6RayCCs=;
        b=HdFEIjP13wNPN7B9ZfiIH5e51rXzvwjakjfsoI4MDqbqhrpxEgNbsMb3VSCm6mDfpN
         AAuyCgd9sNc6GR4Yoqq0Ohd+quL0ZBbNr6oz8SZ1gKo7NKF3qQxOyinRZsQfAViuDFni
         hMZs64U3Du6nZkvgnNG8OovAAVbbQFmBu5CXsD1EcyLCisyc9pBAndh+6e56ew6ocI7J
         Ntxd2MtXBmdnN2vxQjEuMd0NuvWhKIpASk1Jszif02CgEZMxEVNNNaff1o4RBntSUCxY
         6VCH2iGWomfX8pMsQrPVri4akA/eD4M8FnKQK61DZsun3QpPo9tkbY+oToYB2n3CaMTa
         vSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748904047; x=1749508847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T32s96RITG9z0l1YbpSqA97I6G74VAkYppjM6RayCCs=;
        b=nVMj/ADHYCFmJzncsZ162ms4ojNeN+X6WqR8ZUjLtU/MJfpIc5/vqyGdTfMiCXDJhQ
         nbfGtUPKzQN4UdHijNDpndOLTjWO5zGCm7J3nkFFskA2VOoQ3Wl+tnuqJUlLqN54gOZP
         m3AeYtXUs1xZIBxWG14IIBOnnpPEN4W9Ang/JnD4mVT6YAu98gqW/zMzKYpXE4QgCMa1
         x8du0RlQPGiWLDmVZ0ejXn08/feMFy1N24imIsNr5ky8Vcec6tEuB6m/51aL+b4ACVzA
         +HR3LLk8p7lUuKQXlir9Wimy0S35qJfDNQpjvyPFt6Ct9vJ2o3/UdGlV52pkFFMEnUWV
         cLIg==
X-Forwarded-Encrypted: i=1; AJvYcCVreBLGBeeBoH8KphQvm/jGJ7hfYtlkN6nU1SBQ3yZpIs1TAUh60kRrHDgqG7LeMTqbi8aFbOZ0rzyAyHLG0KhdlNPGj24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBfOZxDTe+qQr9sB06FKYEzE5KRP/fGJSkZ6E8C47rahW9j0yu
	hfShkwZlQ83sJCz3P3bQm4zfZzKn6uNNI75cSAFymfuyx+7vMmV25r4Uw/rJzrxVriCy4G89jaA
	/MCjzQ8zeD2W5a9zRdzck3SOW48vledbCK0d8IbXa
X-Gm-Gg: ASbGnctCyUFCaiUjnaa/ZP18xbyvZeAhcg2oRpdjgUvF42kTJOay2sYeN1Rco5OO0no
	LGRADXgRS3toX6EGxz/tf0WehCtz9z4YPx/5S3iv7xFD3AafeLpCwMK5G4SYYyVv8I88olhYQZ1
	JOTFyNDUU4SANlJZGViYTYC46HakxwTGX8
X-Google-Smtp-Source: AGHT+IEoW15vP4TZMilz80sYx0Hku+Zl/sAggEOxsTe06cP7n08O7EyiHxpX3KBOESBFu/aogEn4PvBql4PlUpAmSMI=
X-Received: by 2002:a05:690c:6382:b0:70e:7503:1181 with SMTP id
 00721157ae682-70f97eaa4femr226665457b3.18.1748904046535; Mon, 02 Jun 2025
 15:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com> <20250528215037.2081066-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250528215037.2081066-2-bboscaccy@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Jun 2025 18:40:35 -0400
X-Gm-Features: AX0GCFtYhBGLoq5-Qs5c7_qoke3991xjj2U1oRE7b1POKvzoUfmQJ8v4VIG2L64
Message-ID: <CAHC9VhQT=ymqssa9ymXtvssHTdVH_64T8Mpb0Mh8oxRD0Guo_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: Add bpf_check_signature
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: jarkko@kernel.org, zeffron@riotgames.com, xiyou.wangcong@gmail.com, 
	kysrinivasan@gmail.com, code@tyhicks.com, 
	linux-security-module@vger.kernel.org, roberto.sassu@huawei.com, 
	James.Bottomley@hansenpartnership.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Ignat Korchagin <ignat@cloudflare.com>, Quentin Monnet <qmo@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Anton Protopopov <aspsk@isovalent.com>, Jordan Rome <linux@jordanrome.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Matteo Croce <teknoraver@meta.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 5:50=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> This introduces signature verification for eBPF programs inside of the
> bpf subsystem. Two signature validation schemes are included, one that
> only checks the instruction buffer, and another that checks over a
> hash chain constructed from the program and a list of maps. The
> alternative algorithm is designed to provide support to scenarios
> where having self-aborting light-skeletons or signature checking
> living outside the kernel-proper is insufficient or undesirable.
>
> An abstract hash method is introduced to allow calculating the hash of
> maps, only arrays are implemented at this time.
>
> A simple UAPI is introduced to provide passing signature information.
>
> The signature check is performed before the call to
> security_bpf_prog_load. This allows the LSM subsystem to be clued into
> the result of the signature check, whilst granting knowledge of the
> method and apparatus which was employed.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  include/linux/bpf.h            |   2 +
>  include/linux/verification.h   |   1 +
>  include/uapi/linux/bpf.h       |   4 ++
>  kernel/bpf/arraymap.c          |  11 ++-
>  kernel/bpf/syscall.c           | 123 ++++++++++++++++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h |   4 ++
>  6 files changed, 143 insertions(+), 2 deletions(-)

...

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 64c3393e8270..7dc35681d3f8 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2753,8 +2764,113 @@ static bool is_perfmon_prog_type(enum bpf_prog_ty=
pe prog_type)
>         }
>  }
>
> +static int bpf_check_signature(struct bpf_prog *prog, union bpf_attr *at=
tr, bpfptr_t uattr,
> +                              __u32 uattr_size)
> +{
> +       u64 hash[4];
> +       u64 buffer[8];
> +       int err;
> +       char *signature;
> +       int *used_maps;
> +       int n;
> +       int map_fd;
> +       struct bpf_map *map;
> +
> +       if (!attr->signature)
> +               return 0;
> +
> +       signature =3D kmalloc(attr->signature_size, GFP_KERNEL);
> +       if (!signature) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       if (copy_from_bpfptr(signature,
> +                            make_bpfptr(attr->signature, uattr.is_kernel=
),
> +                            attr->signature_size) !=3D 0) {
> +               err =3D -EINVAL;
> +               goto free_sig;
> +       }
> +
> +       if (!attr->signature_maps_size) {
> +               sha256((u8 *)prog->insnsi, prog->len * sizeof(struct bpf_=
insn), (u8 *)&hash);
> +               err =3D verify_pkcs7_signature(hash, sizeof(hash), signat=
ure, attr->signature_size,
> +                                    VERIFY_USE_SECONDARY_KEYRING,
> +                                    VERIFYING_EBPF_SIGNATURE,
> +                                    NULL, NULL);
> +       } else {
> +               used_maps =3D kmalloc_array(attr->signature_maps_size,
> +                                         sizeof(*used_maps), GFP_KERNEL)=
;
> +               if (!used_maps) {
> +                       err =3D -ENOMEM;
> +                       goto free_sig;
> +               }
> +               n =3D attr->signature_maps_size;
> +               n--;
> +
> +               err =3D copy_from_bpfptr_offset(&map_fd, make_bpfptr(attr=
->fd_array, uattr.is_kernel),
> +                                             used_maps[n] * sizeof(map_f=
d),
> +                                             sizeof(map_fd));
> +               if (err < 0)
> +                       goto free_maps;
> +
> +               /* calculate the terminal hash */
> +               CLASS(fd, f)(map_fd);
> +               map =3D __bpf_map_get(f);
> +               if (IS_ERR(map)) {
> +                       err =3D PTR_ERR(map);
> +                       goto free_maps;
> +               }
> +               if (__map_get_hash(map, (u8 *)hash)) {
> +                       err =3D -EINVAL;
> +                       goto free_maps;
> +               }
> +
> +               n--;
> +               /* calculate a link in the hash chain */
> +               while (n >=3D 0) {
> +                       memcpy(buffer, hash, sizeof(hash));
> +                       err =3D copy_from_bpfptr_offset(&map_fd,
> +                                                     make_bpfptr(attr->f=
d_array, uattr.is_kernel),
> +                                                     used_maps[n] * size=
of(map_fd),
> +                                                     sizeof(map_fd));
> +                       if (err < 0)
> +                               goto free_maps;
> +
> +                       CLASS(fd, f)(map_fd);
> +                       map =3D __bpf_map_get(f);
> +                       if (!map) {
> +                               err =3D -EINVAL;
> +                               goto free_maps;
> +                       }
> +                       if (__map_get_hash(map, (u8 *)buffer+4)) {
> +                               err =3D -EINVAL;
> +                               goto free_maps;
> +                       }
> +                       sha256((u8 *)buffer, sizeof(buffer), (u8 *)&hash)=
;

James' comment about using the hash from the PKCS7 data makes a lot of
sense.  I'm not a kernel crypto expert, but if looks like if you call
pkcs7_parse_message() you should be able to get the hash algorithm
from pkcs7_message->signed_infos->sig->hash_algo.

I imagine there might be user/admin concerns over which algorithms
would be considered acceptable for a signature verification, but I
suppose one could make the argument that if you don't trust that
algorithm it shouldn't be enabled in the kernel.

> +                       n--;
> +               }
> +               /* calculate the root hash and verify it's signature */
> +               sha256((u8 *)prog->insnsi, prog->len * sizeof(struct bpf_=
insn), (u8 *)&buffer);
> +               memcpy(buffer+4, hash, sizeof(hash));
> +               sha256((u8 *)buffer, sizeof(buffer), (u8 *)&hash);
> +               err =3D verify_pkcs7_signature(hash, sizeof(hash), signat=
ure, attr->signature_size,
> +                                    VERIFY_USE_SECONDARY_KEYRING,
> +                                    VERIFYING_EBPF_SIGNATURE,
> +                                    NULL, NULL);
> +free_maps:
> +               kfree(used_maps);
> +       }
> +
> +free_sig:
> +       kfree(signature);
> +out:
> +       prog->aux->signature_verified =3D !err;

Considering this code supports two signature schemes, signed loader
(with implied loader verification of maps) and signed loader + maps,
it seems like it might be a good idea to have two flags to indicate
what has been verified in bpf_check_signature(); a "prog_sig_verified"
(or similar) flag to indicate the program has been verified and a
"maps_sig_verified" (or similar) to indicate the maps have been
verified.

Beyond that, I wanted to talk a bit about the two different signature
schemes and why I think there is value in supporting both.  The
discussion was happening in patch 0/3, but it looks like KP wanted to
move the discussion away from the cover letter and into that patch, so
I'm doing that here ...

The loader (+ implicit loader verification of maps w/original program)
signature verification scheme has been requested by Alexei/KP, and
that's fine, the code is trivial and if the user/admin is satisfied
with that as a solution, great.  However, the loader + map signature
verification scheme has some advantages and helps satisfy some
requirements that are not satisfied by only verifying the loader and
relying on the loader to verify the original program stored in the
maps.  One obvious advantage is that the lskel loader is much simpler
in this case as it doesn't need to worry about verification of the
program maps as that has already been done in bpf_check_signature().
I'm sure there are probably some other obvious reasons, but beyond the
one mentioned above, the other advantages that I'm interested in are a
little less obvious, or at least I haven't seen them brought up yet.
As I mentioned in an earlier thread, it's important to have the LSM
hook that handles authorization of a BPF program load *after* the BPF
program's signature has been verified.  This is not simply because the
LSM implementation might want to enforce and access control on a BPF
program load due to the signature state (signature verified vs no
signature), but also because the LSM might want to measure system
state and/or provide a record of the operation.  If we only verify the
lskel loader, at the point in time that the security_bpf_prog_load()
hook is called, we haven't properly verified both the loader and the
original BPF program stored in the map, that doesn't happen until much
later when the lskel loader executes.  Yes, I understand that may
sound very pedantic and fussy, but there are users who care very much
about those details, and if they see an event in the logs that
indicates that the BPF program signature has been verified as "good",
they need that log event to be fully, 100% true, and not have an
asterix of "only the lskel loader has been verified, the original BPF
program will potentially be verified later without any additional
events being logged to indicate the verification".

Considering that Blaise has proposed something which satisfies both
the loader-only and loader+maps signature requirements, I don't
understand the objections.  KP described two technical objections in
his replies to patch 0/3:

1. "It does not align with most BPF use-cases out there as most
use-cases need a trusted loader."
2. "Locks us into a UAPI, whereas a signed LOADER allows us to
incrementally build signing for all use-cases without compromising the
security properties."

In response to objection #1, the approach Blaise has described here
fully supports signing only the lskel loader and leaving it to the
loader to verify the original BPF program maps.  The "trusted loader"
use cases are fully supported, as the loader+maps scheme does not
prevent the loader-only signature scheme.

In response to objection #2, honestly this seems like an extension to
objection #1.  The trusted loader-only signature scheme is fully
supported.  Yes, adding support for either signature schemes is an
extension to the BPF program loading UAPI, but both schemes are
optional and supporting both is very much in line with BPF's stated
philosophy of "flexibility and not locking the users into a rigid
in-kernel implementation and UAPI."

> +       return err;
> +}
> +

--=20
paul-moore.com

