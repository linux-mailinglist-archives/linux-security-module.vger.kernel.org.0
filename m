Return-Path: <linux-security-module+bounces-309-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 889E9806210
	for <lists+linux-security-module@lfdr.de>; Tue,  5 Dec 2023 23:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB77281EEA
	for <lists+linux-security-module@lfdr.de>; Tue,  5 Dec 2023 22:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077F83FE37
	for <lists+linux-security-module@lfdr.de>; Tue,  5 Dec 2023 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mbql03Ab"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0881B6
	for <linux-security-module@vger.kernel.org>; Tue,  5 Dec 2023 13:25:29 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77d6f853ba0so18700185a.0
        for <linux-security-module@vger.kernel.org>; Tue, 05 Dec 2023 13:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701811529; x=1702416329; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CMVMFfhvbOdfB8cvyMD4FKpTO+rRmK8hhOgtlFXL7rk=;
        b=Mbql03Ab+1n0b6FoLfHBcRAz3M+47RE7/Ew9sZIAZezRHzNAxuzX1DdgKJPB8P/TGA
         OEmS2cM8tyiyTkWDY2NSXursEd96L6QHC0xjwJOfxRR61W/tGePkYhYL2YioqEuCDUUS
         kPVF7zjN32aAWft0yM7jVo5dlGe0lU91PpQZ4/Nm6h2vDgf171e+Lxy6clGl8+yrimyp
         Wkl/Qjz5rKTo0l5/X1LkGASLQGtmXXBPTbs57smIGFFWJSWDFDI1w5a5NtuwF3aro2Ip
         DBEi/6lb6nxWvHOXr7XqUkd11cSCrW0JQHiOd94xoiWssyboAMYnTeGp7oVFVe2i+p4n
         kISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701811529; x=1702416329;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMVMFfhvbOdfB8cvyMD4FKpTO+rRmK8hhOgtlFXL7rk=;
        b=iO1PKMm42TD8WAusZjXP2GaagKVSlQLZc3THFrSlKe8EWnsRamTkVtsRzKdtIVpbYU
         JCXnBDrWut1oIFIs0Y3nrEQQWNfA5cNVtjWhB8VGZhNm73fKqa2rpMoG76WBZ6bKkrAq
         eKnexmLak7/kVwEdXxYArtlyky9wWbP/N3k8rb230dY+DoVQKblv78hVfN6Bb8x2Yt+T
         0fYdOeilGXibgavbEahy4HZXpvSs08MmPYT5wzXiCpktA3Qi24APviv4+/SKox2SXoaa
         N7JdjFHQk+Qh2leMRAVfnTNLDJDtAIO/0Dv0uC5Vk8F1GXJa4srAgfHakjJyVblaPhRZ
         V4Ig==
X-Gm-Message-State: AOJu0YyrJoO3CHAJTNWtab+MawehZry7xf96l5lY5TYMclIp8+VI3BIz
	nCb+qhuyhs4UZDH7wvBj97g2
X-Google-Smtp-Source: AGHT+IH7OLGZe+bSiTCv7KItvdnzkZ/6BNIFysl6tMyjl2tNshYTK30o06KIqGAeXAlEmbt9QK/1EQ==
X-Received: by 2002:a05:620a:f0b:b0:77d:72cf:c47 with SMTP id v11-20020a05620a0f0b00b0077d72cf0c47mr2828909qkl.35.1701811528715;
        Tue, 05 Dec 2023 13:25:28 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id qx3-20020a05620a8b8300b0077da68b8801sm5405116qkn.65.2023.12.05.13.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 13:25:28 -0800 (PST)
Date: Tue, 05 Dec 2023 16:25:27 -0500
Message-ID: <c88dd2922f2689e2ede5bbf4a0e43a0a@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, linux-unionfs@vger.kernel.org, "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Subject: Re: [PATCH 4/16] capability: use vfsuid_t for vfs_caps rootids
References: <20231129-idmap-fscap-refactor-v1-4-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-4-da5a26058a5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

On Nov 29, 2023 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org> wrote:
> 
> The rootid is a kuid_t, but it contains an id which maped into a mount
> idmapping, so it is really a vfsuid. This is confusing and creates
> potential for misuse of the value, so change it to vfsuid_t.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  include/linux/capability.h | 3 ++-
>  kernel/auditsc.c           | 5 +++--
>  security/commoncap.c       | 2 +-
>  3 files changed, 6 insertions(+), 4 deletions(-)

It might be nice if AS_KUIDT() and friends were named in such a way
as to indicate that they require a vfsuid_t parameter.  At least the
call to __vfsuid_val() should flag a type mismatch if some other type
is used.  Regardless, that is more of a general VFS issue and not a
problem specific to this patchset.

With the same understanding about the capabilities code and Serge ...

Acked-by: Paul Moore <paul@paul-moore.com> (Audit,LSM)

> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index c24477e660fc..eb46d346bbbc 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -16,6 +16,7 @@
>  #include <uapi/linux/capability.h>
>  #include <linux/uidgid.h>
>  #include <linux/bits.h>
> +#include <linux/vfsid.h>
>  
>  #define _KERNEL_CAPABILITY_VERSION _LINUX_CAPABILITY_VERSION_3
>  
> @@ -26,7 +27,7 @@ typedef struct { u64 val; } kernel_cap_t;
>  /* same as vfs_ns_cap_data but in cpu endian and always filled completely */
>  struct vfs_caps {
>  	__u32 magic_etc;
> -	kuid_t rootid;
> +	vfsuid_t rootid;
>  	kernel_cap_t permitted;
>  	kernel_cap_t inheritable;
>  };
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 783d0bf69ca5..65691450b080 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -65,6 +65,7 @@
>  #include <uapi/linux/netfilter/nf_tables.h>
>  #include <uapi/linux/openat2.h> // struct open_how
>  #include <uapi/linux/fanotify.h>
> +#include <linux/mnt_idmapping.h>
>  
>  #include "audit.h"
>  
> @@ -2260,7 +2261,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
>  	name->fcap.permitted = caps.permitted;
>  	name->fcap.inheritable = caps.inheritable;
>  	name->fcap.fE = !!(caps.magic_etc & VFS_CAP_FLAGS_EFFECTIVE);
> -	name->fcap.rootid = caps.rootid;
> +	name->fcap.rootid = AS_KUIDT(caps.rootid);
>  	name->fcap_ver = (caps.magic_etc & VFS_CAP_REVISION_MASK) >>
>  				VFS_CAP_REVISION_SHIFT;
>  
> @@ -2816,7 +2817,7 @@ int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
>  	ax->fcap.permitted = vcaps.permitted;
>  	ax->fcap.inheritable = vcaps.inheritable;
>  	ax->fcap.fE = !!(vcaps.magic_etc & VFS_CAP_FLAGS_EFFECTIVE);
> -	ax->fcap.rootid = vcaps.rootid;
> +	ax->fcap.rootid = AS_KUIDT(vcaps.rootid);
>  	ax->fcap_ver = (vcaps.magic_etc & VFS_CAP_REVISION_MASK) >> VFS_CAP_REVISION_SHIFT;
>  
>  	ax->old_pcap.permitted   = old->cap_permitted;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index cf130d81b8b4..3d045d377e5e 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -710,7 +710,7 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
>  	cpu_caps->permitted.val &= CAP_VALID_MASK;
>  	cpu_caps->inheritable.val &= CAP_VALID_MASK;
>  
> -	cpu_caps->rootid = vfsuid_into_kuid(rootvfsuid);
> +	cpu_caps->rootid = rootvfsuid;
>  
>  	return 0;
>  }
> -- 
> 2.43.0

--
paul-moore.com

